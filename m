Return-Path: <linux-kernel+bounces-340800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9269D987808
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E671C23570
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25D4157A41;
	Thu, 26 Sep 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GN/TBH4g"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7BC1C28E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370021; cv=none; b=EyUi1hbt1TOovjZWiKMVAnO1CbeljdaIfZmEVy+4fGz+hDcSgdgSOTlYw1257fXOJAIUruzcVYOAptG0WcVYFv2zdxUOgMuyVWnc0iNwtRbGC6wG5ll6wz2BAHhFcQS4hN4nwpQHWe6SIIAMT4myXVB8rNmmTE1/D58WnVp6Cog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370021; c=relaxed/simple;
	bh=oYtKQy2mnfH6RR8gc/exy5qEImd9nCXyRPhlO+Cah6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFk6hi0pVe54khhsp8EBR0Aniz14v5MFlvecTIt4dFTXsbMYswvg+oKS+jfhGTeMFdoHdjn0BGzzjfYHHb881zBKgBXn0e4h5Q4DLgORGvbTZnL6fJzGU/fknMTYEElOVpUkht/2aqWYzXJ4KZYWWij6WnPXEd0oiNSqL0a0W4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GN/TBH4g; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d446adf6eso168492066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727370017; x=1727974817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8hoqDI+tC5eLbqfHqUDQ9CgvU+UFuqg7aCqYwQjuRVY=;
        b=GN/TBH4gu9w4dE3+z/3CfLoBWfptuQr7L28XTv8Rarsn4g5pEAeYJRBkImk7l3fiR7
         KwpIcXMNXbHpdRNQrukF5lkq/ZJr/CQ4g5h0EGBEZfQa/QZUtwQqsCqttMqib1MFE89g
         rcsSk+BsMrkaePTxeM01aBA0BiGZfRI8XmhBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727370017; x=1727974817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hoqDI+tC5eLbqfHqUDQ9CgvU+UFuqg7aCqYwQjuRVY=;
        b=f1QbgO6rqg1p+i5LzhZ8Bp2Ujw8nK8cSzyK3FXlGkyPrB81rT5RyLz532k6WAxCFM6
         Ga+1lYbmAkeLAcrkwzadoxRiJHhPIzrrdOi3KPhedTlsA2ZQzzjf5UX3RKv/hbbLjKte
         qLTgPILT9n8PIkGQd0iiJkd6cDGxmWPQ6Un9wgk0q2hFLl/YONOn4BE1nI+56Gf5pjez
         Qb2z9YKRhuxMSiOAdGJmMI8JG60Phi8L+o8hbPpuyVWH4iEi7TA0j+6DsqtS3X9BEylY
         zptjf+xoj/PD8gKV0HMD/A3Tq9i6WyWBdaeS+gfjh35CSlebhw3SQ8yaba5vPG7+JpVs
         l9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWA6nKZsaUH2IzAAu9tlwqC7A/2lBctrDifrIM/EPbLJA105GK9TNytYVR0Vnp7B9NwdE2ygH4L+iAPcfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZgGWPPon9tGzmAtiVbyAa8VElA9nioRknBQ0xzmdYIbH0Dhdg
	boJr6JK7U1YW/0DiXzd4uR3ghSqF9lMGUx6o4bwb2jGd766cz1nEuhpCmQp+cezxVSNdJTBaxSp
	xEgX5sw==
X-Google-Smtp-Source: AGHT+IE0nfjAgJ8g4Ln2byytSob1O0YpCmhVJdifXfIFp1Ds2GGc/SJ8XPNzlJi4HqA6KIyhoDcdDw==
X-Received: by 2002:a17:907:7f1f:b0:a8d:3e29:a82d with SMTP id a640c23a62f3a-a93c492ab45mr12153166b.37.1727370017051;
        Thu, 26 Sep 2024 10:00:17 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bb40sm17423766b.181.2024.09.26.10.00.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 10:00:16 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so10307705e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:00:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX21LeLHbXHOaHkZXzVjolPEiZ/nbaAo/Atd/YDh7VxwvVNckg0Iu0p+iK5bwrKn/o33U5nZL5T/I2zSe0=@vger.kernel.org
X-Received: by 2002:a17:907:7e8e:b0:a86:9d3d:edef with SMTP id
 a640c23a62f3a-a93c48e8c12mr13943566b.12.1727369690656; Thu, 26 Sep 2024
 09:54:50 -0700 (PDT)
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
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com> <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com>
In-Reply-To: <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Sep 2024 09:54:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
Message-ID: <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
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

On Thu, 26 Sept 2024 at 09:40, Jonas Oberhauser
<jonas.oberhauser@huaweicloud.com> wrote:
>
> Boqun seems to be unhappy with a barrier though, because it would
> theoretically also forbid unrelated optimizations.

Well, doing a "barrier()" is kind of a big hammer thing, but honestly,
I don't think we've ever seen any real situation where it makes a
noticeable difference. Yes, it can pessimize compiler output more than
strictly necessary, but the kind of code generation issues it causes
tends to be the non-problematic kind (and particularly the kind that
even a trivial OoO core will deal with well).

We do have some more directed compiler barriers available, and this
code might be able to use OPTIMIZER_HIDE_VAR() for example. It's kind
of a "single variable value barrier".

Honestly, we don't use it much. It just tends to be _too_specific. But
it is there if somebody wants to use it.

> But I have not seen any evidence that there are any unrelated
> optimizations going on in the first place that would be forbidden by this.

Compared to something like "smp_mb()", which is not just a compiler
barrier but also generates typically very expensive instructions that
completely mess with an OoO core, a regular compiler barrier is a
complete non-issue. When you have those two close to each other, you'd
have to make up some very odd situation where the plain "barrier()" is
even noticeable.

               Linus

