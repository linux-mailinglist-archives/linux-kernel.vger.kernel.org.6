Return-Path: <linux-kernel+bounces-537321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC6DA48A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BC816BC80
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9983A271272;
	Thu, 27 Feb 2025 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZTBV38+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632E71AB6D8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691760; cv=none; b=qaLncyYbfFuQdfOAuFPvKBSEbW8l8D8JO3VzZpi06ahlUi0O71/AS/8oYGv1GSRu9w/tUp5M15eHf2dRkjsvjYtDBapXhXXWqdkYTO8QR6Iw500lvRuDt4rGOySThM0eEGumegSmQ+/nrr/XCmtdWZE/Oe0iz6uJ4m6R/RiiAqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691760; c=relaxed/simple;
	bh=dxF4FN9xium4jLZfA/GNo17rLpehVIrI4gWP7/XCLpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D3WpFjjkGZiLsmE8QcztVFGpRLdGQ9bMe3UcIP85F3BsjR5ygwRI0eem/1VnyywtyQm+upOdK70WQjfPBDXY99Eh3RmTN6cN9c9C72e7lrosmCEerqb3P0a70zOsTFLaILSqNjD90V9TzfOpx0wUD7FViHsqxihAPSX042olWdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZTBV38+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740691757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eufceZLJr1I8fdiTEdgsBxpgVgc25hDn/n/ukbEKvAk=;
	b=OZTBV38+5cVY5/pGNO2gKz4TkVJhaOVWXX5Jx5Ti6CLE/R4Uv2fOjCw4kjNZ4tn0g3v1le
	+rBDevZg3U/mth+EdzvoCLa3WWt0TgEo+nahsqoHyCAnvxQm/Xvxr2aoXongu7TuWi8bFL
	drOuJx8LuFPYpsrOiqk/o1t9VHajWYg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-LK9kCNq_M8mqiUnzJv2_PQ-1; Thu, 27 Feb 2025 16:29:15 -0500
X-MC-Unique: LK9kCNq_M8mqiUnzJv2_PQ-1
X-Mimecast-MFC-AGG-ID: LK9kCNq_M8mqiUnzJv2_PQ_1740691755
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4393e89e910so8158065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740691754; x=1741296554;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eufceZLJr1I8fdiTEdgsBxpgVgc25hDn/n/ukbEKvAk=;
        b=lpOefq1b6sO/4lJLUrWxzHi5y5UvpTyvWxkE5IToWUlUjO63BBiK8KLihMWq8I04Hw
         hEz2VCFKaFDOvpFLhWxp346ODhAnkM7mKQ44LTVPdOMzfQSvZIYeCE2fTlqeK7lNxW8X
         nuB38Wc/aXf+40QU4DlSfuGt0RCEZMhsWhqJrKmmTuVCGtrbRpM/NoLPgzaPcs2VOqJ7
         vcBYRw4+oFwYyNmU4JNI9e4HKnZ4geFp7oWHtdowRFy16yFkWt1L2vzLABYq7fgwdy84
         klDnNkizSyyUhUAVqS5oJ70iYvLDFO+87qjTmzeyHA7x8pPM+Sos4xN9S74TSzRUZUUo
         Ckcw==
X-Forwarded-Encrypted: i=1; AJvYcCVVjNDD0Wr1UYs1X1o8w8Dw+Zky2fkyqczgekR3iCjlyvZ+ukR9oeOXa3qgE7pGvZ+dLonafGLOQ4PvcWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqt1Ty7h4agKAcbowK+c8WfjdNLHiH6UQyUcgtPi6WCoKYMtl
	AV32vCqcDZ8bjBze6OqmiXkdNF6NGk8CB4/dZJwoWIvCQtAi1Kk/f6BqYHV3fsQS5PsMh0wynyg
	hmvDu+ABLrkqJk6k4edA0wQERXm+nzDFVsEuUT6AWr1Fyxew4XZ1Fgw5FG7QeaQ==
X-Gm-Gg: ASbGncskKn9ki8uj2rn+cJ4c4zGDBl2YfnwuxabQ/FGQdElAYpQ+NomuYV0n6Za3MIO
	vXBIO3pcMvyE/g5zMvr0GNAkkR6P4nbs8Hu4e6fI1cGWXaHLssTCV3+6pBIL+PBojtmbviR5tbD
	E3DL6Y0kzZ4b+UtYYxKQmq/S3aC56HM6BXfpGpwza+cF1WAAaU27HH+Ru8+44bqug70u9TVnJEg
	eyiEzzKNQqe6lcGjkFhqeeg/Pp4nDpjFHERlZZHG8GezBrhu+jS/bhdbyy1czTPsnbfb8FZPkO3
	11cRqaQSozpgLAdawkDYdnuns1F8Y9M7EhK0O4R9SKevFxKzTCSOLeJzQxOIOVegSGQrhjP//bu
	T
X-Received: by 2002:a05:6000:2112:b0:38f:6149:9235 with SMTP id ffacd0b85a97d-390ec7cba70mr618423f8f.16.1740691754590;
        Thu, 27 Feb 2025 13:29:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZAYOLvJ8C0YI1cxRbLvJGbMPaIg3Ni2v7psye+SaqGd/PraO+3wDx4Bo3vNp91pLbsuqmMQ==
X-Received: by 2002:a05:6000:2112:b0:38f:6149:9235 with SMTP id ffacd0b85a97d-390ec7cba70mr618394f8f.16.1740691754190;
        Thu, 27 Feb 2025 13:29:14 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d6dbsm3149393f8f.82.2025.02.27.13.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:29:13 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, sstabellini@kernel.org,
 tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, kees@kernel.org, aliceryhl@google.com, ojeda@kernel.org,
 samitolvanen@google.com, masahiroy@kernel.org, rppt@kernel.org,
 xur@google.com, paulmck@kernel.org, arnd@arndb.de, puranjay@kernel.org,
 broonie@kernel.org, mbenes@suse.cz, sudeep.holla@arm.com,
 guohanjun@huawei.com, prarit@redhat.com, liuwei09@cestc.cn,
 Jonathan.Cameron@huawei.com, dwmw@amazon.co.uk,
 kristina.martsenko@arm.com, liaochang1@huawei.com, ptosi@google.com,
 thiago.bauermann@linaro.org, kevin.brodsky@arm.com, Dave.Martin@arm.com,
 joey.gouly@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH -next v6 8/8] arm64: entry: Switch to generic IRQ entry
In-Reply-To: <Z8CwbmCXguCEfJvx@J2N7QTR9R3>
References: <20250213130007.1418890-1-ruanjinjie@huawei.com>
 <20250213130007.1418890-9-ruanjinjie@huawei.com>
 <xhsmh4j0fl0p3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z8CwbmCXguCEfJvx@J2N7QTR9R3>
Date: Thu, 27 Feb 2025 22:29:12 +0100
Message-ID: <xhsmh1pvjkrfb.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 27/02/25 18:35, Mark Rutland wrote:
> On Thu, Feb 27, 2025 at 07:08:56PM +0100, Valentin Schneider wrote:
>> On 13/02/25 21:00, Jinjie Ruan wrote:
>> > Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
>> > to use the generic entry infrastructure from kernel/entry/*.
>> > The generic entry makes maintainers' work easier and codes
>> > more elegant.
>> >
>> > Switch arm64 to generic IRQ entry first, which removed duplicate 100+
>> > LOC and make Lazy preemption on arm64 available by adding a
>> > _TIF_NEED_RESCHED_LAZY bit and enabling ARCH_HAS_PREEMPT_LAZY.
>>
>> Just a drive-by comment as I'm interested in lazy preemption for arm64;
>> this series doesn't actually enable lazy preemption, is that for a
>> follow-up with the rest of the generic entry stuff?
>>
>> From a quick glance, it looks like everything is in place for enabling it.
>
> Sorry, there's been some fractured discussion on this on the
> linux-rt-users list:
>
>   https://lore.kernel.org/linux-rt-users/20241216190451.1c61977c@mordecai.tesarici.cz/
>
> The TL;DR is that lazy preemption doesn't actually depend on generic
> entry, and we should be able to enable it on arm64 independently of this
> series. I'd posted a quick hack which Mike Galbraith cleaned up:
>
>   https://lore.kernel.org/linux-rt-users/a198a7dd9076f97b89d8882bb249b3bf303564ef.camel@gmx.de/
>
> ... but that was never posted as a new thread to LAKML.
>

Thanks for the breadcrumbs!

> Would you be happy to take charge and take that patch, test it, and post
> it here (or spin your own working version)? I was happy with the way it
> looks but hadn't had the time for testing and so on.
>

Sure, looks straightforward enough, I'll pick this up.

> I expect that we'll merge the generic entry code too, but having them
> separate is a bit easier for bisection and backporting where people want
> lazy preemption in downstream trees.
>
> Mark.


