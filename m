Return-Path: <linux-kernel+bounces-342183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B97988B47
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC5F1F2122F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854461C2326;
	Fri, 27 Sep 2024 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zh4Ypjn1"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86F1381B1
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469013; cv=none; b=RhQ6D/IRvpwcRS7XxSGGx0Q4aTRIV/NLt9sxoriRs23QBi2LWV/IIz/wqohfbYTnZwP/8yfzyOfp87czeeK/gCOozoYDE1Zo6KZAo44IQUeK/rpwZ25Pd047OF37W2OLVonqOMJu1JTwYzx1ers6ddVhaoYZ9fbclZgKbud/918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469013; c=relaxed/simple;
	bh=DktPPQWVliv9sw4BrPAGhW6J9QwXUF8Rr4uJcTFsAy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ktg4QqhJcXlYFqniuOFPR1L3Ym/nngQoTn29q7KWYK+gf5GW1R4KSmrHjKahivtutiainOam4H/kLo+W5jTDQ/BgTCGcl2LZLYViu3kmt1K3qdDt+5JiH57mr4UBlGdWJsCwWd3xslPCFkUlbaNqUmNyQiE9tIt4gY9aMFAXDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zh4Ypjn1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c26a52cf82so1305408a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727469010; x=1728073810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y7HnKDJ0lmmcY7Bm5NjvF8jzj2uLye3yGTiI+8Ax554=;
        b=Zh4Ypjn1eZkBH7aCi2Cj58EGa+2qpKX9IjIivyJTLEW0GgvUQR+7rqN23tipfV2ykN
         c0UghzQaFL8PewlTRxwuXjNsOd1aGMAwi+cdoulfnCTgSW8gq0NGUxnUaUTT4hr0QX3q
         FzTLzIwyaPUr1S0yJvJN+qG2Jdq5oFHwm0uIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469010; x=1728073810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7HnKDJ0lmmcY7Bm5NjvF8jzj2uLye3yGTiI+8Ax554=;
        b=qj4GAssVzMJLA7yPE+Nqsb4SmzsNUbVbAN7UYJKlaeep0enHiGMRL3Y7AbHNYV9nfr
         OX7nlZ2np5gH2AY/V/OUH6TiP2CYki9Mz6APu6M21nUNShnt4Dg9+Vbbcf32vvfD1pJ5
         Ngp7y/LmH/T2hKDFpbawOrAdxW7cZJ91gBy1tq/XmcX2ntMFMWzL2LbnCZm3drEtfPC6
         41eDD0+tsoKiB45PPPjvJJYowR0yA03CnvwtYyM87JVBxUNZ/9k9I74AeAfPR7O8Z61w
         sDxrfMFkK2L6UQrr1k3lO3Tlik6l6DMhR+/mm0wtvU+wjPwmbkB4lvCzKjjPS44OW3La
         2CFA==
X-Forwarded-Encrypted: i=1; AJvYcCVnwysgzL5ZqGKcLuJFS69orTAchn+ZVXwh5+fv5IbiNzjrc2dFMgoCRqaEVY4eEHtVjItkwDe99wBkp9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+w8SUoIcye/POlw1+Sm/ZbYcwNXf0E9vORCYdSZWfq8SIPpYr
	lKn1cTMSeWLMjouc4z+l0maYDZRmBKlJc/f3utrlWt9d+BtAffzudkOsS4PEeacsJce27OV4kls
	44YLhMg==
X-Google-Smtp-Source: AGHT+IF9xpd61F23FLTT+ZNbE4y9ug2XtBRwNIHYmLZ+5F+DK3LMzW30ZROqJ8XaS8Iv3to7suC/Tg==
X-Received: by 2002:a05:6402:3547:b0:5be:cdda:1c6b with SMTP id 4fb4d7f45d1cf-5c882603a00mr4391330a12.31.1727469010006;
        Fri, 27 Sep 2024 13:30:10 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248af26sm1541124a12.63.2024.09.27.13.30.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 13:30:09 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c26a52cf82so1305399a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 13:30:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8MSrluk7+yv3+lGoigr13Ygt9mLkXpEXyDnevayMkuoJiWfTC49E8FDHU/8/7069lxMtptBuqmC0B3uo=@vger.kernel.org
X-Received: by 2002:a05:6512:3095:b0:536:a5ee:bb75 with SMTP id
 2adb3069b0e04-5389fc3f106mr5002054e87.21.1727468663689; Fri, 27 Sep 2024
 13:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com> <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com> <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com> <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com> <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
 <ZvX12_1mK8983cXm@boqun-archlinux> <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
 <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com> <CAHk-=wgQyXOt_HjDZHNqWMmyvv74xLAcMw88grfp4HkKoS2vLw@mail.gmail.com>
 <7e1c8a5e-c110-414c-8fb2-022eacc2bd4a@efficios.com> <CAHk-=wgBgh5U+dyNaN=+XCdcm2OmgSRbcH4Vbtk8i5ZDGwStSA@mail.gmail.com>
 <34ec590c-b109-44a0-8bfe-8aafc6e7ad64@efficios.com> <CAHk-=wi_hz8Whs2ogRUQEfMBk=OkZ3usmvJkzb5YyEKwqEJBmQ@mail.gmail.com>
 <1b04e35c-8994-48d9-907a-966bb4dfabaf@huaweicloud.com> <CAHk-=wgi9vqh6qUpPKSydfdqd3210MnekZ1VxB6aAmfqz2bFpw@mail.gmail.com>
In-Reply-To: <CAHk-=wgi9vqh6qUpPKSydfdqd3210MnekZ1VxB6aAmfqz2bFpw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 13:24:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whteT=CDW09TMk4wwwYs+qvcAKQUfw8+1D-e8H4XhFs3A@mail.gmail.com>
Message-ID: <CAHk-=whteT=CDW09TMk4wwwYs+qvcAKQUfw8+1D-e8H4XhFs3A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard pointers
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 12:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Dammit, people, read the code I posted.

Actually, no, apologies. You were right, and I was wrong.

It does need both of the sources of the comparison to be hidden,
because while even hiding just one side makes the comparison result
"meaningless" as far as the compiler is concerned, the compiler will
still have generated a pseudo for the hidden value, and might decide
that it can re-use that pseudo for the non-hidden pointer if the two
then match.

So yeah, the example function I posted should be safe, but my "you can
probably make do with hiding just one side" was actually a bogus and
invalid optimization. You do need to hide both sides. Not just for
clarity, but for correctness.

             Linus

