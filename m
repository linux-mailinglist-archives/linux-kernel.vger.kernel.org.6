Return-Path: <linux-kernel+bounces-534340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E667A465D6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A540519C6CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2150F21E0BE;
	Wed, 26 Feb 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YU7xe1AF"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703121E098
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584973; cv=none; b=UcuOr2lnRf/4qbU3dujd0OuFNDWkN5IrZvMBLxcQRPVNRLGRdSt+JJaAKBa/6mMvUUBIHkHQ+6+EqD+IYWlSlH7UmBPwjzFb1lKKcqKh38sAiKrPXt64/hAQARdyxt6MybOdHj+mt+USs654WHjjhBmorJs3XnIf34XjtuJGUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584973; c=relaxed/simple;
	bh=n9sfwMLjqZKr8H/DBdrE0eiQovz4JNiyMotXUT2Uvjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5DqoUkYLEF5+Dd5IBlvD46cmSsWBtRic5TBGiIVkHrVuLfmMcxRI7WM725dqaPX4F2tzxWBqzQIeU17Dzo7TNhsF7Za91Dx17foyJz5vqnnUFefSW+Zxp30Nv0v0XSK7FW3I8Byd5ku2qW+kiNL/gMRY3k4uVz7tbYdkPTXmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YU7xe1AF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4397dff185fso61300685e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740584969; x=1741189769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0p0n/HvVMpkGcsOceJadWdw3uKxq8oQ66r+vg7p98B4=;
        b=YU7xe1AF+mIIRE7HEzTv/xqfgG3daQ37STLk0+GSYkYg5cHt4hw5iGQ91J1s+f+/0B
         Bo/RzLGkB5EvQtsml+u54+dLeCStLnhdzvlC8aeQBBQMYdWwNuAXtdU2KItZRtD6IX8Q
         SFVz2bkymusgV+/ggXZxf+8p6Gi4kAnialYcFKMp1YQMnxhPra4gSugoceRexIJZDGGl
         8WX+ThWR32eP+CmdjRDEDDBVlhYPOSpOpmXsG+QwzFQuyInlz5q6+PFLG34iuw7jrGeb
         E4EE3avW1e1Z7wiKOz4cEKtg2CRAYVIjOr4kbgOHBKw3ph/SdOqZS2HMcnuYZ1aK/hZG
         tdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584969; x=1741189769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0p0n/HvVMpkGcsOceJadWdw3uKxq8oQ66r+vg7p98B4=;
        b=M9Mcsnk1cc2bokFULeYx6O/4hhCHHWH2z8bBhkLOt5DOVGAyAno2yefaqltzLnV0aw
         r5+4qq27Qcv5G+JXNtBxBHDI2uvtr8cktLQE6gC2D/edg32CT3+SHCRU1mkD/FFuhGlr
         xyF9+1rArQSZsMM/AcAfjeS7AE6irnLla5ua3dRz3RK56arUOhrKNzugvNnZP1yUL8Ng
         bkwd6BB1xTvm7Siz6bB3D5OM8i+KOdvirLTpugamob6lLQQIYMmBsI2YTscdB010oUev
         orbSrEZ3O8s26YwEIIjDsNFMS3zvk6ZLU0p1P04xYTyg9kZ3sOCHRnpqFg2z44brHyVM
         pMOg==
X-Forwarded-Encrypted: i=1; AJvYcCVHWvpbUxCC8B4RTFuS/wBQhgV22GJf+Rkv99kHjoD79blmWymZhGDussLEIS6DVzcmt/GMp0zL+rGmLFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxt1uNXRp35X4X6w9kLoHwBzwtim2peF7tVBgOCfNz1NIiS/TN
	fLpi/zogOyuiLECHox5F74kpXkluebWqjDV/OFnzXH9W84MgwfydjnA/6ZU6tv8=
X-Gm-Gg: ASbGncuQmG9l0nAgbCB0noUCb0SHjrE9AJRRK7vyrNIGkA4WejaEzbBL7Z4mLSsB3Nr
	PIQuOnGtp45wHXNR24V/JZ/DiPtwPR0I1u9NvDRk0pmbEnKJiCdB1IcQdtUDLUS/3HUcTs8JFCR
	mekYyZ2AcTXBQ+hLEjJVDWEgmlzlqQVIJu9Bk3fkqk2S33q1oUaWX+2u/ADOJ4XhcVMnqxScpB9
	236y5I7Ch570eq6AOpjidT0C2B+WZ3hG7ccgZNt9aN6i828TmvzlAyOXDEbzCD87wSyU6GFkAwi
	9u0RoOAO6VggVGD/skBZSL1JZEtR
X-Google-Smtp-Source: AGHT+IFrDL1uk86PVoF2mj9jbYVArsum6vONC+I6iG2Yc+eitETSemITRmSloxxMANxWuwoKDv84Ng==
X-Received: by 2002:a05:600c:4506:b0:439:6e12:fdb4 with SMTP id 5b1f17b1804b1-43ab8fe90camr40816605e9.14.1740584969299;
        Wed, 26 Feb 2025 07:49:29 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532d33sm25750165e9.15.2025.02.26.07.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:49:28 -0800 (PST)
Date: Wed, 26 Feb 2025 16:49:26 +0100
From: Petr Mladek <pmladek@suse.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: hamzamahfooz@linux.microsoft.com, akpm@linux-foundation.org,
	bhe@redhat.com, decui@microsoft.com, gregkh@linuxfoundation.org,
	haiyangz@microsoft.com, jani.nikula@intel.com, jfalempe@redhat.com,
	joel.granados@kernel.org, john.ogness@linutronix.de,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	wei.liu@kernel.org
Subject: Re: [PATCH RFC] panic: call panic handlers before
 panic_other_cpus_shutdown()
Message-ID: <Z784BiUZohADyoOW@pathway.suse.cz>
References: <Z7juu2YMiVfYm7ZM@hm-sls2>
 <20250222054405.298294-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222054405.298294-1-ryotkkr98@gmail.com>

On Sat 2025-02-22 14:44:05, Ryo Takakura wrote:
> On Fri, 21 Feb 2025 16:23:07 -0500, Hamza Mahfooz wrote:
> >On Fri, Feb 21, 2025 at 11:23:28AM +0900, Ryo Takakura wrote:
> >> On Thu, 20 Feb 2025 17:53:00 -0500, Hamza Mahfooz wrote:
> >> >Since, the panic handlers may require certain cpus to be online to panic
> >> >gracefully, we should call them before turning off SMP. Without this
> >> >re-ordering, on Hyper-V hv_panic_vmbus_unload() times out, because the
> >> >vmbus channel is bound to VMBUS_CONNECT_CPU and unless the crashing cpu
> >> >is the same as VMBUS_CONNECT_CPU, VMBUS_CONNECT_CPU will be offlined by
> >> >crash_smp_send_stop() before the vmbus channel can be deconstructed.
> >> >
> >> So maybe panic_other_cpus_shutdown() should be palced after 
> >> atomic_notifier_call_chain() along with printk_legacy_allow_panic_sync()
> >> like below?
> >> 
> >> ----- BEGIN -----
> >> diff --git a/kernel/panic.c b/kernel/panic.c
> >> index d8635d5cecb2..7ac40e85ee27 100644
> >> --- a/kernel/panic.c
> >> +++ b/kernel/panic.c
> >> @@ -372,16 +372,16 @@ void panic(const char *fmt, ...)
> >>         if (!_crash_kexec_post_notifiers)
> >>                 __crash_kexec(NULL);
> >> 
> >> -       panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
> >> -
> >> -       printk_legacy_allow_panic_sync();
> >> -
> >>         /*
> >>          * Run any panic handlers, including those that might need to
> >>          * add information to the kmsg dump output.
> >>          */
> >>         atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> >> 
> >> +       panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
> >> +
> >> +       printk_legacy_allow_panic_sync();
> >> 
> >>         panic_print_sys_info(false);
> >> 
> >>         kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> >> ----- END -----
> >
> >Ya, that looks fine to me, that's actually how I had it initally, but I
> >wasn't sure if it had to go before the panic handlers. So, I erred on
> >the side of caution.

The ordering (stopping CPUs before allowing printk_legacy loop)
is important from the printk POV. So, keep it, please.


> I see, sorry that I was only speaking in relation to stored backtraces.
> It seems that printk_legacy_allow_panic_sync() is placed before 
> atomic_notifier_call_chain() so that it can handle flushing before calling
> any panic handlers as described [0].

> [0] https://lore.kernel.org/lkml/ZeHSgZs9I3Ihvpye@alley/

> I'm not really familar with the problems associated with panic handlers
> so I hope maybe John and Petr can help on this matter...

Honestly, I do not have much experience with failures of the panic
notifiers. But I saw a patchset which tried to add filtering of
some problematic ones, see
https://lore.kernel.org/lkml/20220108153451.195121-1-gpiccoli@igalia.com/

I did not like the way of ad-hoc filtering. The right solution was to
fix the problematic notifiers.

Anyway, it went out that the situation was not that easy. The notifiers
do various things. Some of them just printing extra information. Others
stopped or suspended some devices or services. Some should be called
before and some after crash_dump.

The outcome was a monster-patchset which tried to fix some problematic
notifiers and split them into more notifier chains, see
https://lore.kernel.org/all/20220427224924.592546-1-gpiccoli@igalia.com/

Some of the fixes were accepted but the split has never been done.


My opinion:

1. The best solution would be to make the problematic notifier working
   with stopped CPUs. The discussion around [v2] suggests that the author
   made it working at least for x86_64, see
   https://lore.kernel.org/r/20250221213055.133849-1-hamzamahfooz@linux.microsoft.com


2. Another good solution might be to do the split of the notifier
   chain, for an example, see
   https://lore.kernel.org/lkml/Yn0TnsWVxCcdB2yO@alley/

   The problematic notifier can be then added into a chain which
   is called before stopping CPUs.


3. In the worst case, you could change the ordering as proposed above.
   I am just afraid that it might bring in new problems. There might
   be notifiers which were not tested with more running CPUs...


In general, the system is in an unpredictable state when panic() is
called. Notifiers should not expect that non-panic CPUs will be
able to handle any requests.

Also it looks like a good idea to stop non-panic CPUs as soon as possible.
Otherwise, they might create more harm than good.

Best Regards,
Petr

