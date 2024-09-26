Return-Path: <linux-kernel+bounces-340750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5143987761
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0991C2197B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ABB1586F6;
	Thu, 26 Sep 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XuGZCNKy"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AF0154BF8
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367203; cv=none; b=pbDr50sTic+ZZB6S10VcIg9wCzogSxScoI2+urL07/8CKXtMTWH9G5BzywUfExpUB2yCnEXPNcxilubWiHfVaoApGN0dPPmZ5NuFL68ceAfBikc/gQ0uReGDBxUJSV/NQbnYjDyTy+ragiiNemTeE+ebmYo0g5BRSxzACaxSzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367203; c=relaxed/simple;
	bh=b/AkQ6KC/9/lXddy+98mjZVGNz2jCIw0oGNZw2EAKto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1MfxIU4kRIcA52Gki+N3F2kB3bfvXUawR9F7b31S3ZwCdDuiSq9emxFriSl5DEj4vt5EmeO0/bWslqofSbqbXslWrX9KTx/IDnN8MpFQLITCKVJE4xZOwwUv4K7IR3IUqrEtSbtKWrEUiHYKcDUxBG9s2JsO2GIgwOXxsqNTTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XuGZCNKy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5365a9574b6so2018688e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727367199; x=1727971999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QXnBUq/9ghYv0bNYvo4uDCfOpMdq8coMpre7nUUI9wE=;
        b=XuGZCNKyThI6pV+XtGz/YSJWu/BbCfILCXOy/06ICqmP5E9NkI0MrLvOE338o1NPGm
         Y5asItQWnqG5HBzIr22HrluLeJLREAR8pszbeyRWGw8grp5pV+Ey+RBtKe9rAzushAsb
         xUZJ+3+NExCx41Y3V02LOJMZnuzONYQtqd5rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727367199; x=1727971999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXnBUq/9ghYv0bNYvo4uDCfOpMdq8coMpre7nUUI9wE=;
        b=fRhmBvslIPzbTXmq8GGD0T/6b0pvjF1SItrKM02h89bTatdtAsngbje7eCVajxjPQo
         1mcAAKPN7ZThd/kOKYVxLiWpQenl0ZtxTFfk7qrUBBlZeXuoVoOBMOwyb1sySPy+ywry
         SZvwvhcjQHcczRDYcZSW6vWiP9hTQHkM/Bhapdw9Yj6aHS/y1Apl4GEKSpo+RQ9Q4un6
         ltIsSmc51xhjB38zUbbfOZnYIBDP8VxiIvBpGvStkfgMpRVOT0n5iiv5dYnWIEPgwGpM
         d3dgbc9ZxhUZQmPd++1TNkb6zs1pNdYbR7xuxDhZFq72ww1KEltwla9vvnflkN4ph8ws
         8Z/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgTslLfLBmQtVSgWc/gEfvDGIbgqQfHLHA2L1bv05YGczMKsXXsnILeAaVx5WDQKKSsFB5hB2JUEGsuVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyb+/wKtCvuWllu6oPQPa1MCLCudNgpoYbr53jqyGVIF2c6FlF
	Nc9+cGWx6xnb+I/fw4vw6TJYUcDXlttt/0YDRJgZZ/5t7DtetdtiRp6iMOXIiXzYzHr5+XCXQbT
	TDE99xw==
X-Google-Smtp-Source: AGHT+IH3FgGeQASmj22evWTI6ojXb5hgioegciqCnxrjZz5CKQA3pl+t5HkcYWGksdrq64Nw87jmYA==
X-Received: by 2002:a05:6512:158d:b0:533:4497:9f29 with SMTP id 2adb3069b0e04-5389fc4b107mr142527e87.31.1727367199466;
        Thu, 26 Sep 2024 09:13:19 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a04323a4sm799e87.144.2024.09.26.09.13.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 09:13:17 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365aa568ceso1431631e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:13:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrWi7tpBYOMqS52hwY7hV7v6Q6dGY2zpcwCeCZY6V1HwyZfqueXPW8GCTQl4d/3+b6+axJebWIqCcc9cE=@vger.kernel.org
X-Received: by 2002:a05:6512:1113:b0:536:53e3:feae with SMTP id
 2adb3069b0e04-5389fc34426mr138492e87.11.1727367195995; Thu, 26 Sep 2024
 09:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917143402.930114-1-boqun.feng@gmail.com> <20240917143402.930114-2-boqun.feng@gmail.com>
 <55975a55-302f-4c45-bfcc-192a8a1242e9@huaweicloud.com> <ZvPfmAp_2mDkI3ss@boqun-archlinux>
 <f5aeeeda-c725-422a-9481-4795bd3ade0f@huaweicloud.com> <ZvPp4taB9uu__oSQ@boqun-archlinux>
 <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com> <ZvP_H_R43bXpmkMS@boqun-archlinux>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com> <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com> <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
In-Reply-To: <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Sep 2024 09:12:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
Message-ID: <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard pointers
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 08:54, Jonas Oberhauser
<jonas.oberhauser@huaweicloud.com> wrote:
>
> No, the issue introduced by the compiler optimization (or by your
> original patch) is that the CPU can speculatively load from the first
> pointer as soon as it has completed the load of that pointer:

You mean the compiler can do it. The inline asm has no impact on what
the CPU does. The conditional isn't a barrier for the actual hardware.
But once the compiler doesn't try to do it, the data dependency on the
address does end up being an ordering constraint on the hardware too
(I'm happy to say that I haven't heard from the crazies that want
value prediction in a long time).

Just use a barrier.  Or make sure to use the proper ordered memory
accesses when possible. Don't use an inline asm for the compare - we
don't even have anything insane like that as a portable helper, and we
shouldn't have it.

                   Linus

