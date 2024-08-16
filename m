Return-Path: <linux-kernel+bounces-289946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 851E0954D95
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0287C2830B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F5F1BD034;
	Fri, 16 Aug 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OacbWvJz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF021E4AF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821759; cv=none; b=fdxu97RmHLRky36zECSkH2oAnN1O7bAJe1GN6mmbqcQUZgoc3KKT4oQidysRCp8Caj0Nv97PzBlxoyMyhPYqZC9kHxngQzcOYG8SL8HGx7sMWOxZwYRGFAdy+AnsHxsb4sIuQ8juQ617zT5pYaXuFV6IAWSAYTdopwdLtUOzTFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821759; c=relaxed/simple;
	bh=fbq/7JiAozUzeZ3pX4FwdCsugTKm73bR5Wv9T0awF2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ItDoH/hnMy5GeIoxXgR4YXPzrxqysfdasTzohc0AkXp3Y4ENAwUb1wcmJcSXaW08jT2U6al4iCDVlQWExYHkEPxKHAAcFL8bM7B/JneHX/b4CuMTjKaRG4U0Iny/g/enJ4ut1U42Jb25cqo0VPLQqWFUmJQlbudc9F8BPxj0chk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OacbWvJz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723821757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fywk1mPCapIS6sNBtFYya3OlguvcKcSCvBC2UtIhiFc=;
	b=OacbWvJz6NLRfLhbIkaJDVzPPGIRRsztJmXBqBf8bRAnFI3JfyljxvFgJno6CH0g+o1NJ8
	QXFNqrunbOLteXgeQK1VCx8ZsUcOI82ZIX9MhCFm8B6su0xWKb8dahrGdzl8Y8CJjolPBg
	dUh4m2vrzAYrbkcCC/6jG+QWGIrDdd4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-1S9c3rk8OKOUpjBd652bFA-1; Fri, 16 Aug 2024 11:22:35 -0400
X-MC-Unique: 1S9c3rk8OKOUpjBd652bFA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-371730a4870so1061290f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723821754; x=1724426554;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fywk1mPCapIS6sNBtFYya3OlguvcKcSCvBC2UtIhiFc=;
        b=RZovadT0NLqTRKGRvhATfFFCJZwnfBspvqy5TaCZG0KdbeURfXIB8XX7aBoHVIe9DL
         im/RnzGwVzeBi2418FxhAyluaBVvF/VYra6VkNF93RNwdP4ojZ/hwhikGHN0vgYLq5D4
         NMaQELn2A2sUjW6r+LLpmOFNtPAZ32aahocIo/lZFmehTzxIkE1ryn7St4SeVxt6y0ik
         fOeIw40c1LJd1sJRVv0JJPW/u5oSUi2BahLky1h/ppLjm4QtF5SdaTbMQfgrnLkmYCZI
         kRDAQIVT8tx9ofjTULnDShp6/y9x1V9965RZ1sGXU4jcqZir57hFQZ5Bimpai3Lk6Chi
         6tEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmycbyxvnvoNowQ2vlm2G4IxeDFz5H/cRlQd3rKE32Ae28UcijDRc0BXe6xTLmUYkxwIQKOuDhMvKuBfblPq5dSQL0ymZhVT3r0zUu
X-Gm-Message-State: AOJu0YxIoWzgXb+xVkpTVwptTxLKRz4Jqng9E3dDS7KwZb6obyjBeijM
	aPJNqQYzDB+7wg4FfPC/pf5C3dKyn88syopR0ZzkBnMxwHFwwPZMw4K4RVe4ozGyPnkXbDximaH
	HoegQ/Fn5KQvwwH98p5TmLR9jPp9urTIWIJsGB+88N8wTI7TuojQNgUaN16+cog==
X-Received: by 2002:adf:f892:0:b0:368:664a:d4f9 with SMTP id ffacd0b85a97d-3719443f896mr2643545f8f.28.1723821754504;
        Fri, 16 Aug 2024 08:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5kIM2+bjxNCJh3H3BmSPEy2IBktEjWKK+OizwV/Na9qWTXrgdlz8OYeeW9KV96xipPusqAg==
X-Received: by 2002:adf:f892:0:b0:368:664a:d4f9 with SMTP id ffacd0b85a97d-3719443f896mr2643502f8f.28.1723821753676;
        Fri, 16 Aug 2024 08:22:33 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189863109sm3844878f8f.65.2024.08.16.08.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:22:33 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 00/24] Complete EEVDF
In-Reply-To: <20240727102732.960974693@infradead.org>
References: <20240727102732.960974693@infradead.org>
Date: Fri, 16 Aug 2024 17:22:32 +0200
Message-ID: <xhsmh8qwwcx1j.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 27/07/24 12:27, Peter Zijlstra wrote:
> Hi all,
>
> So after much delay this is hopefully the final version of the EEVDF patches.
> They've been sitting in my git tree for ever it seems, and people have been
> testing it and sending fixes.
>
> I've spend the last two days testing and fixing cfs-bandwidth, and as far
> as I know that was the very last issue holding it back.
>
> These patches apply on top of queue.git sched/dl-server, which I plan on merging
> in tip/sched/core once -rc1 drops.
>
> I'm hoping to then merge all this (+- the DVFS clock patch) right before -rc2.
>
>
> Aside from a ton of bug fixes -- thanks all! -- new in this version is:
>
>  - split up the huge delay-dequeue patch
>  - tested/fixed cfs-bandwidth
>  - PLACE_REL_DEADLINE -- preserve the relative deadline when migrating
>  - SCHED_BATCH is equivalent to RESPECT_SLICE
>  - propagate min_slice up cgroups
>  - CLOCK_THREAD_DVFS_ID

So what I've been testing at your queue/sched/core, HEAD at:
  4cc290c20a98 ("sched/eevdf: Dequeue in switched_from_fair()")
survives my (simplistic) CFS bandwidth testing, so FWIW:
  Tested-by: Valentin Schneider <vschneid@redhat.com>

And for patches 01-20:
  Reviewed-by: Valentin Schneider <vschneid@redhat.com>

with one caveat that I agree with Vincent on maybe doing something about
the load PELT signal of delayed dequeued entities.


