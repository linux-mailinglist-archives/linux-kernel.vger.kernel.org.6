Return-Path: <linux-kernel+bounces-272659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB063945F86
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7550E283B84
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CB521019A;
	Fri,  2 Aug 2024 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mvw84luo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3513C914
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609557; cv=none; b=btB1f7DVl8eAPe/lhXwT/9KMU3kqEOA/4mw3uNMU6FBlSXAFbwpMNplVe6QBGcp2WDaVtAJZsBcUmxGU6vLuSm5mAzzBK5QtYZ53SC9nvYr8sIHUBG1ICJAyk/PMxf0lcw0EZke9LQtazLD50WxjVnYW6Ca0UxBlcGJJ/9Q3J5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609557; c=relaxed/simple;
	bh=BgjXDpNQ9xoLWjfZ0gMQyNMbBWvmj4/J3jkZZbl0ZwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KMrKHCPqdHem4twpSl1bnyzdhDp0YC+ooBFdLMUWMYqd9Dh8L+oyUmUNKXhAyYBltiAHOZ4hcp6Wg/iM6dTCS2FiZUbp7xfYH3xCMY1jnBy4mV9LDY5afySTZUfK8gciK9eBRCKJx2musO5wZAOdqGlZj4K8q5yNslLE63Dh+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mvw84luo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722609554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BgjXDpNQ9xoLWjfZ0gMQyNMbBWvmj4/J3jkZZbl0ZwY=;
	b=Mvw84luo5ljsWG/Xe07jIzHlZs0bS5+bY4aMGFSZQYvYoEolvsSjJT37lANTRkrzygj0wm
	rfhD33IAiQpDA5NUcW0baOTWDgNiqsiu4cuWGQSsrqSmh+19QFy6O92WKoVT98ZN0SKIvY
	LZmCOm4xbFKO1/7NsooRrLdiFbN1ML8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-6og1ZTa7PIm5GnDypWYD0w-1; Fri, 02 Aug 2024 10:39:13 -0400
X-MC-Unique: 6og1ZTa7PIm5GnDypWYD0w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7535875ab7so417382266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 07:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722609552; x=1723214352;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgjXDpNQ9xoLWjfZ0gMQyNMbBWvmj4/J3jkZZbl0ZwY=;
        b=g/6JEnQEZC5PKCs4Twvc4ee/CQbdirVCv61OYFcwyU+oQm1tcmY3sbziLw328qzzCj
         ULvgpclLFvx6rTAaDUVWbH3qIIlyMHpljLXVFOBY5XpMJ4TiwEeWmdnnmA/9EGoZAfru
         2gUVFNlsGUi2PSYxoWgf0F0ed/GKomPm7gQdRTik48m+1n+P3i8nqfGOfXx8oKoIN5T6
         Q7xaEnm2Kxg5g1DrlZw7ULzl7FBg1QSD5hJ95fsndfgwGMvzgYJ2EqMbBoOuuQNXCwew
         xO0bihkWgva/YZYYJc++f+loo+cQFxu2e9mX9qmBGaI0bIL/ED+4aU5b1cwzqxezrqvc
         rWkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcN2zs1/NMfq3n1dgLPL7qUdhW8M8Q5Eq3Cm1gYzw8GRYeeNTvJ8qiBWgBiSOIIGZw/efxblQShMSEqrKwAv5bMhWP28UaS7zB44PM
X-Gm-Message-State: AOJu0YyXWXTAl+oAOCyItwjX/rJs82NeGrzc0UBXMkpROSrxREeS3szm
	LdP3kel84XveYgDu2nI4TOkTmvogIc4oZAsrvhbCTVDHcT2hnc4a1d788tsbkPjaKDwpvlYSAbC
	3+O/rY1ZDRYJ/eLFBuPPnjmiws7h5RUQVNyfPJMUB8I60A7TagmNhkal8p7gMiw==
X-Received: by 2002:a17:907:7f26:b0:a72:7ede:4d12 with SMTP id a640c23a62f3a-a7dc5f65686mr299570566b.5.1722609551874;
        Fri, 02 Aug 2024 07:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNVh38zPjBGczkw54vR62s1aLT7TE/psYrwqGhNsf8K2M/DrPedKtBvGejolbKNuvj6hRnCQ==
X-Received: by 2002:a17:907:7f26:b0:a72:7ede:4d12 with SMTP id a640c23a62f3a-a7dc5f65686mr299567666b.5.1722609551403;
        Fri, 02 Aug 2024 07:39:11 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d426e6sm105989366b.122.2024.08.02.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 07:39:10 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
In-Reply-To: <20240727105030.226163742@infradead.org>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
Date: Fri, 02 Aug 2024 16:39:08 +0200
Message-ID: <xhsmhjzgzt2er.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On 27/07/24 12:27, Peter Zijlstra wrote:
> Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
> noting that lag is fundamentally a temporal measure. It should not be
> carried around indefinitely.
>
> OTOH it should also not be instantly discarded, doing so will allow a
> task to game the system by purposefully (micro) sleeping at the end of
> its time quantum.
>
> Since lag is intimately tied to the virtual time base, a wall-time
> based decay is also insufficient, notably competition is required for
> any of this to make sense.
>
> Instead, delay the dequeue and keep the 'tasks' on the runqueue,
> competing until they are eligible.
>
> Strictly speaking, we only care about keeping them until the 0-lag
> point, but that is a difficult proposition, instead carry them around
> until they get picked again, and dequeue them at that point.
>

Question from a lazy student who just caught up to the current state of
EEVDF...

IIUC this makes it so time spent sleeping increases an entity's lag, rather
than it being frozen & restored via the place_entity() magic.

So entities with negative lag get closer to their 0-lag point, after which
they can get picked & dequeued if still not runnable.

However, don't entities with positive lag get *further* away from their
0-lag point?


