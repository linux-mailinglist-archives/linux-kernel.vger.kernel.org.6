Return-Path: <linux-kernel+bounces-359239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F5E998973
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58552B2845A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636761E9074;
	Thu, 10 Oct 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyRGeP04"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A41CBEAF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569543; cv=none; b=Z5rd14f+qJy8r9xHZ7I4yS0mui1BEkMCgNc2jjs06wGPxjSCX7HdXV5DvFz0ef4cSCKyrmtrHBzj6NE5mamWu7jhlyu6VlaLzAV2ALQiSKG7Jd8xAV3AZ6w85DR0ku5vcbBvJErDStP4qoNSn6HEQemnvw2xFDY6nosvXpBqUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569543; c=relaxed/simple;
	bh=mp+ydBXKAptuG5CEuQsM73JzDZCwFzRceNVYbv5rs8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SR5MiawnaB6g50t4JOhpA2S87ws44eEYm/a845A9iuiQQ6aS+2j7l1W3Ud+dPgZQLM/XmSAmp7D+IlyYMK32x2yDttwPsEtcwgBje4H/62scIrS8EeBrRWmcUuSS4AMLliUwfv8/qhV2GLEfT1Z/d0zVrIBOmcWpApmS08HWq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyRGeP04; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728569539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIdquXq2ihRf2+MDucnrUHZtZ6OWlhrGt3bxTZ17BpQ=;
	b=GyRGeP04FnUbFXvDjkmF60AQ/Z0kfKWNnf7mSLQLoNWkkDFdZ8HFPNOFsV+yonHtk6H+yo
	zTaEAo0cAnicly2uOwKznVzeTme6Mdv6MAD5dvJHfW86vBXz83DqgYpQZoKbwY3p3C6UdX
	qfeKCwmUlZ6pntSsSt8IyN3lpvRavzg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-KPZRcgGzNIajbq_Vr6tukA-1; Thu, 10 Oct 2024 10:12:17 -0400
X-MC-Unique: KPZRcgGzNIajbq_Vr6tukA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a994fb94446so114495566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728569536; x=1729174336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIdquXq2ihRf2+MDucnrUHZtZ6OWlhrGt3bxTZ17BpQ=;
        b=pjwg0P3iYE5tAl4LGS5hZIR3l0vvh3MsNNPKQNVWtitD2qVjKGyDBL6PiHNhUFfRyg
         5pEPfnxiljLQa+aGhk3tjDP25rs1fmOf0iSgZpas1augGV7T3YTeMEMnWIVSx0NLOprS
         Cf+Jm19I1nY+Voj0e05DWIfK5WtNXcwZq+yWkcqN6P5JuKRy9BoWuL6DP+WTNOv4N1x4
         OjQGvcmDFHGsWDCW3nwYl7rQwZBDTF/zyJwwa7oR8k5LigWWVYh7Zw5OLwFsdDb0A9C2
         FKrIAYQ5QV3pK+KsRfTTxgR7rWAqPYmGfl6TAGUz5CTvSFjU+6GN8CI7/UbL6oHz3FLf
         BCAg==
X-Gm-Message-State: AOJu0Yy5qRTcu1F1Zhkt+dua5K3K12tw7gJGgAqgRJu3xTF8Ja06HnuA
	lVIuKtgP5xsVNvJRBO2fJcDDxUJ9U2LrSKWD3Z1vptOsGfYC16qAW+a1vBgZnawby82L3P08eX0
	ig7MpH/hdM/zsuW3gX6qGhJGOpy6D8i7p1MwXJ4F8pZYzxlzFVx4mcBsnipZ1n+99dOOcp8gc
X-Received: by 2002:a17:906:dc8e:b0:a8d:43c5:9a16 with SMTP id a640c23a62f3a-a99a0ebd1eemr305911666b.6.1728569536157;
        Thu, 10 Oct 2024 07:12:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl3WXbrZXA1tbQocubevDe93M5AX5HyzV2+h4YLu7+y+aA6/10DMrsbrVFivlIBDFTXowJAA==
X-Received: by 2002:a17:906:dc8e:b0:a8d:43c5:9a16 with SMTP id a640c23a62f3a-a99a0ebd1eemr305908366b.6.1728569535630;
        Thu, 10 Oct 2024 07:12:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f26678sm93284066b.70.2024.10.10.07.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 07:12:15 -0700 (PDT)
Message-ID: <331d3a2e-d66a-4118-a6b8-cb0cfbb9b3cf@redhat.com>
Date: Thu, 10 Oct 2024 16:12:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in PMC code in 6.12-rc1
To: =?UTF-8?Q?Marek_Ma=C5=9Blanka?= <mmaslanka@google.com>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
 Luca Coelho <luca@coelho.fi>
References: <40555604c3f4be43bf72e72d5409eaece4be9320.camel@coelho.fi>
 <CAGcaFA1zqcqRNNydCZwn1pXUrjgSwvpLcVrf-ecFub2CABLiUw@mail.gmail.com>
 <CAGcaFA3tZTcppfPMzrpA0W5jS1byYaDwbADMfvKOQfjw8YvMqQ@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAGcaFA3tZTcppfPMzrpA0W5jS1byYaDwbADMfvKOQfjw8YvMqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Marek,

On 10-Oct-24 4:09 PM, Marek Maślanka wrote:
> Hi Franz,

Franz? I guess you are trying to address me (Hans) ?

> I need to redesign this patch. The pmcdev->lock in the
> pmc_core_acpi_pm_timer_suspend_resume might already be held by the
> pmc_core_mphy_pg_show or pmc_core_pll_show if the userspace gets
> frozen when these functions are being executed, this will cause a hang.
> 
> Can you instruct me how to revert this patch? Or you can just do it?

Please submit a revert based on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

with a commit message explaining why this needs to be reverted for now
and then I will merge the revert into the fixes branch and include
it in the next fixes pull-request to Torvalds.

Regards,

Hans




> On Mon, Oct 7, 2024 at 12:57 PM Marek Maślanka <mmaslanka@google.com <mailto:mmaslanka@google.com>> wrote:
> 
>     Hi Luca,
> 
>     Thanks for the report.
> 
>     Seems that the tick_freeze function in the kernel/time/tick-common.c
>     is helding the spinlock so the pmc_core_acpi_pm_timer_suspend_resume
>     shouldn't try to take the mutex lock. I'll look for the solution.
> 
>     Marek
> 
> 
>     On Mon, Oct 7, 2024 at 11:17 AM Luca Coelho <luca@coelho.fi <mailto:luca@coelho.fi>> wrote:
>     >
>     > Hi Marek et al,
>     >
>     > We have been facing some errors when running some of our Display CI
>     > tests that seem to have been introduced by the following commit:
>     >
>     > e86c8186d03a ("platform/x86:intel/pmc: Enable the ACPI PM Timer to be turned off when suspended")
>     >
>     > The errors we are getting look like this:
>     >
>     > <4> [222.857770] =============================
>     > <4> [222.857771] [ BUG: Invalid wait context ]
>     > <4> [222.857772] 6.12.0-rc1-xe #1 Not tainted
>     > <4> [222.857773] -----------------------------
>     > <4> [222.857774] swapper/4/0 is trying to lock:
>     > <4> [222.857775] ffff8881174c88c8 (&pmcdev->lock){+.+.}-{3:3}, at: pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0 [intel_pmc_core]
>     > <4> [222.857782] other info that might help us debug this:
>     > <4> [222.857783] context-{4:4}
>     > <4> [222.857784] 1 lock held by swapper/4/0:
>     > <4> [222.857785]  #0: ffffffff83452258 (tick_freeze_lock){....}-{2:2}, at: tick_freeze+0x16/0x110
>     > <4> [222.857791] stack backtrace:
>     > <4> [222.857793] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 6.12.0-rc1-xe #1
>     > <4> [222.857794] Hardware name: Intel Corporation Alder Lake Client Platform/AlderLake-P DDR5 RVP, BIOS RPLPFWI1.R00.4035.A00.2301200723 01/20/2023
>     > <4> [222.857796] Call Trace:
>     > <4> [222.857797]  <TASK>
>     > <4> [222.857798]  dump_stack_lvl+0x80/0xc0
>     > <4> [222.857802]  dump_stack+0x10/0x20
>     > <4> [222.857805]  __lock_acquire+0x943/0x2800
>     > <4> [222.857808]  ? stack_trace_save+0x4b/0x70
>     > <4> [222.857812]  lock_acquire+0xc5/0x2f0
>     > <4> [222.857814]  ? pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0 [intel_pmc_core]
>     > <4> [222.857817]  __mutex_lock+0xbe/0xc70
>     > <4> [222.857819]  ? pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0 [intel_pmc_core]
>     > <4> [222.857822]  ? pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0 [intel_pmc_core]
>     > <4> [222.857825]  mutex_lock_nested+0x1b/0x30
>     > <4> [222.857827]  ? mutex_lock_nested+0x1b/0x30
>     > <4> [222.857828]  pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0 [intel_pmc_core]
>     > <4> [222.857831]  acpi_pm_suspend+0x23/0x40
>     > <4> [222.857834]  clocksource_suspend+0x2b/0x50
>     > <4> [222.857836]  timekeeping_suspend+0x22a/0x360
>     > <4> [222.857839]  tick_freeze+0x89/0x110
>     > <4> [222.857840]  enter_s2idle_proper+0x34/0x1d0
>     > <4> [222.857843]  cpuidle_enter_s2idle+0xaa/0x120
>     > <4> [222.857845]  ? tsc_verify_tsc_adjust+0x42/0x100
>     > <4> [222.857849]  do_idle+0x221/0x250
>     > <4> [222.857852]  cpu_startup_entry+0x29/0x30
>     > <4> [222.857854]  start_secondary+0x12e/0x160
>     > <4> [222.857856]  common_startup_64+0x13e/0x141
>     > <4> [222.857859]  </TASK>
>     >
>     > And the full logs can be found, for example, here:
>     >
>     > https://intel-gfx-ci.01.org/tree/intel-xe/xe-2016-92d12099cc768f36cf676ee1b014442a5c5ba965/shard-adlp-3/igt@kms_flip@flip-vs-suspend-interruptible.html <https://intel-gfx-ci.01.org/tree/intel-xe/xe-2016-92d12099cc768f36cf676ee1b014442a5c5ba965/shard-adlp-3/igt@kms_flip@flip-vs-suspend-interruptible.html>
>     >
>     >
>     > Reverting this commit seems to prevent the problem.  Do you have any
>     > idea what could be causing this and, more importantly, how to fix it?
>     > :)
>     >
>     > Thanks!
>     >
>     > --
>     > Cheers,
>     > Luca.
> 


