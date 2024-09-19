Return-Path: <linux-kernel+bounces-333657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6A397CBF3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DEA1F231EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD60D1A01B6;
	Thu, 19 Sep 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGQ8FBLI"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7619412E78
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726761689; cv=none; b=M8aM0JJHgsZ4D7wqDvKxll465qJKMaSWKiM5Jk4ltzZAhBmBGhJWtcXuoqDP7sI94vjR8QJgPvnnb9Y1H99ZNYkBWFEEMdByQPICRq1vHA/9ZZSk59D/hHUBPtxWMW3VvqJIDgS6QenjRtRYGD8JVqett4Pf1xh4r0LqZV1pbYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726761689; c=relaxed/simple;
	bh=cRoiycHkeFW96JaYkecYLFKCi/mQupwzk1l6jsFBq/Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=PwzsHXGv/YWoD6kBCFB7Ru3KDipwKhezYlcEeU9C6ksvtviqQ6Us9SKR4xDI0VeMvDEvmKVD8GTyr4kzGlQD5mIGUyDyutQZ/CcNZqkjJxz3xuXc2eDx4Q5LVOVPO9cBIgVUpvj8wEOgFlvuyXKrQmhHnMXKJs/Y1xHTfjmfEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGQ8FBLI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d89dbb60bdso825759a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726761687; x=1727366487; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qFsRcTH4dqvFwHspAU/RYsmB8cUfGUGMr6LZVGKB7g4=;
        b=eGQ8FBLIJYDKEc54xanCBnWc9Pkb39Cf/nY/ekd8m7q5bp1Vz8fDIbMjBGkRU1jG7l
         30HIyBMQphMJszvoWUPKSfMv7a08LYrBj+FXJ3oD9LlOQu3eZ/rLLFEwtIxeoaqsHCi6
         O9mtFHovd3+o53JLkwQmnVW1NPpVCBVlMMQEfv+d0Vbzf+ijvx4g48br4tTvKFTb31Rm
         90uxUmNnQJMBG1Wdbyp4Wv7DAE6b8gA5sllzyIPnwY8C4OhGZxOqc/40Muai23GK6EDU
         IA9y5S/OIAeesphrbEhHwTK93tASAjhr38U1Kek1WMbNDIeVlqNJHRNI4B5v6EHJ4zH+
         hVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726761687; x=1727366487;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFsRcTH4dqvFwHspAU/RYsmB8cUfGUGMr6LZVGKB7g4=;
        b=LJuExS0JXT6Gz0f/BC8nihR8xRs1cllfoowAbGodwciO3gWKB873hGp+PlYN/7J3nU
         76jNcqw3PXPONtzq/82safhKy54XKv5Nv6gk2GWcfwlbgHSAdVynkuqVxFtXNu6ChbtU
         lB6JPNpdJS3mSZDDkO7wJAT2qIcboKfWqfUhGqDj9IRjDUkn6AMspxPv8mZhBTyoc0bs
         bWwraplQOZKMDDgFz6uF8eME82B4vcBh3SkWREZS8xBJg1Dw7qwx2LWLwMRkrdFFFpLi
         17S3nASPW5ryuAiUrS+QMcS5BH4k/atbPBYpF26VJp3WYrwKx+VHk7wvvBLbV4vTfsqn
         FDlw==
X-Forwarded-Encrypted: i=1; AJvYcCWd3rrRFeX9lSXetHs4qfa6zWI4lNMwS50qvdJas89CYWeU1MmnmrNrUIGdQYLWjWeeCLseZ6Pj4a1zq94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6avQe1IKprQFcCoABuo+wIa7hzC/fALkyTXfSubF9jr1RVuy
	rLd+ABHgh3VlDFrqYEFawS51wgm5CjyFow5VsR6H/WcfeJfmeQcW
X-Google-Smtp-Source: AGHT+IGSQoGV/dFPSfyt6DFt+8Gjr3FqkXJ6TCEHVhdpHE/Gfg42Mlj3KP9xkMxWihDLlukD954wuQ==
X-Received: by 2002:a17:90b:1e0a:b0:2da:8730:5683 with SMTP id 98e67ed59e1d1-2dba006a195mr28204989a91.39.1726761686528;
        Thu, 19 Sep 2024 09:01:26 -0700 (PDT)
Received: from dw-tp ([171.76.85.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6eee0965sm2069560a91.42.2024.09.19.09.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 09:01:25 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, Narayana Murty N <nnmlinux@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
Subject: Re: [PATCH] powerpc/pseries/eeh: move pseries_eeh_err_inject() outside CONFIG_DEBUG_FS block
In-Reply-To: <87bk0jbsdb.fsf@vajain21.in.ibm.com>
Date: Thu, 19 Sep 2024 21:11:27 +0530
Message-ID: <875xqrzm54.fsf@gmail.com>
References: <20240917132445.3868016-1-nnmlinux@linux.ibm.com> <871q1hbsh7.fsf@gmail.com> <87bk0jbsdb.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> Hi Ritesh,
>
> Thanks for looking into this patch. My responses your review inline
> below:
>
> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
>
>> Narayana Murty N <nnmlinux@linux.ibm.com> writes:
>>
>>> Makes pseries_eeh_err_inject() available even when debugfs
>>> is disabled (CONFIG_DEBUG_FS=n). It moves eeh_debugfs_break_device()
>>> and eeh_pe_inject_mmio_error() out of the CONFIG_DEBUG_FS block
>>> and renames it as eeh_break_device().
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202409170509.VWC6jadC-lkp@intel.com/
>>> Fixes: b0e2b828dfca ("powerpc/pseries/eeh: Fix pseries_eeh_err_inject")
>>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>>> ---
>>>  arch/powerpc/kernel/eeh.c | 198 +++++++++++++++++++-------------------
>>>  1 file changed, 99 insertions(+), 99 deletions(-)
>>
>> Ok, so in your original patch you implemented eeh_inject ops for pseries
>> using mmio based eeh error injection (eeh_pe_inject_mmio_error()), which
>> uses the functions defined under debugfs -> eeh_debugfs_break_device(). 
>>
>> This was failing when CONFIG_DEBUGFS is not defined, thus referring to
>> undefined function definition. 
>>
>> Minor nit below.
>>
>>>
>>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>> index 49ab11a287a3..0fe25e907ea6 100644
>>> --- a/arch/powerpc/kernel/eeh.c
>>> +++ b/arch/powerpc/kernel/eeh.c
>>> @@ -1574,6 +1574,104 @@ static int proc_eeh_show(struct seq_file *m, void *v)
>>>  }
>>>  #endif /* CONFIG_PROC_FS */
>>>  
>>> +static int eeh_break_device(struct pci_dev *pdev)
>>> +{
>>> +	struct resource *bar = NULL;
>>> +	void __iomem *mapped;
>>> +	u16 old, bit;
>>> +	int i, pos;
>>> +
>>> +	/* Do we have an MMIO BAR to disable? */
>>> +	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
>>> +		struct resource *r = &pdev->resource[i];
>>> +
>>> +		if (!r->flags || !r->start)
>>> +			continue;
>>> +		if (r->flags & IORESOURCE_IO)
>>> +			continue;
>>> +		if (r->flags & IORESOURCE_UNSET)
>>> +			continue;
>>> +
>>> +		bar = r;
>>> +		break;
>>> +	}
>>> +
>>> +	if (!bar) {
>>> +		pci_err(pdev, "Unable to find Memory BAR to cause EEH with\n");
>>> +		return -ENXIO;
>>> +	}
>>> +
>>> +	pci_err(pdev, "Going to break: %pR\n", bar);
>>> +
>>> +	if (pdev->is_virtfn) {
>>> +#ifndef CONFIG_PCI_IOV
>>> +		return -ENXIO;
>>> +#else
>>> +		/*
>>> +		 * VFs don't have a per-function COMMAND register, so the best
>>> +		 * we can do is clear the Memory Space Enable bit in the PF's
>>> +		 * SRIOV control reg.
>>> +		 *
>>> +		 * Unfortunately, this requires that we have a PF (i.e doesn't
>>> +		 * work for a passed-through VF) and it has the potential side
>>> +		 * effect of also causing an EEH on every other VF under the
>>> +		 * PF. Oh well.
>>> +		 */
>>> +		pdev = pdev->physfn;
>>> +		if (!pdev)
>>> +			return -ENXIO; /* passed through VFs have no PF */
>>> +
>>> +		pos  = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
>>> +		pos += PCI_SRIOV_CTRL;
>>> +		bit  = PCI_SRIOV_CTRL_MSE;
>>> +#endif /* !CONFIG_PCI_IOV */
>>> +	} else {
>>> +		bit = PCI_COMMAND_MEMORY;
>>> +		pos = PCI_COMMAND;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Process here is:
>>> +	 *
>>> +	 * 1. Disable Memory space.
>>> +	 *
>>> +	 * 2. Perform an MMIO to the device. This should result in an error
>>> +	 *    (CA  / UR) being raised by the device which results in an EEH
>>> +	 *    PE freeze. Using the in_8() accessor skips the eeh detection hook
>>> +	 *    so the freeze hook so the EEH Detection machinery won't be
>>> +	 *    triggered here. This is to match the usual behaviour of EEH
>>> +	 *    where the HW will asynchronously freeze a PE and it's up to
>>> +	 *    the kernel to notice and deal with it.
>>> +	 *
>>> +	 * 3. Turn Memory space back on. This is more important for VFs
>>> +	 *    since recovery will probably fail if we don't. For normal
>>> +	 *    the COMMAND register is reset as a part of re-initialising
>>> +	 *    the device.
>>> +	 *
>>> +	 * Breaking stuff is the point so who cares if it's racy ;)
>>> +	 */
>>> +	pci_read_config_word(pdev, pos, &old);
>>> +
>>> +	mapped = ioremap(bar->start, PAGE_SIZE);
>>> +	if (!mapped) {
>>> +		pci_err(pdev, "Unable to map MMIO BAR %pR\n", bar);
>>> +		return -ENXIO;
>>> +	}
>>> +
>>> +	pci_write_config_word(pdev, pos, old & ~bit);
>>> +	in_8(mapped);
>>> +	pci_write_config_word(pdev, pos, old);
>>> +
>>> +	iounmap(mapped);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
>>> +{
>>> +	return eeh_break_device(pdev);
>>> +}
>>> +
>>
>> Why have an extra eeh_pe_inject_mmio_error() function which only calls
>> eeh_break_device()?
>>
>> Maybe we can rename eeh_break_device() to eeh_mmio_break_device() and use
>> this function itself at both call sites?
>
> Fair suggestion,
>
> However we want to keep the method debugfs interface uses
> to inject EEH (thats ppc platform agonistic), decoupled from what pseries
> uses. Right now to support as initial work VFIO EEH injection on
> pseries, we are piggy backing on eeh_debugfs_break_device().

Right. 

>
> This will change in future as we add more capabilities to pseries EEH
> injection and this will change working of eeh_pe_inject_mmio_error()
> without impacting the semantics of existing eeh_break_device().

Thanks Vaibhav for the context. 

The debugfs interface "eeh_break_device()" is defined here in
"arch/powerpc/kernel/eeh.c". Those "future pseries changes" could remain
in arch/powerpc/platforms/pseries/eeh_pseries.c using the generic
functions defined from <>/kernel/eeh.c, right. And today
eeh_pe_inject_mmio_error() has nothing pseries specific anyway.

But I get it that this is a minor compile fix for the patch that has
already landed in 6.12 now. As I said earlier too, this was just a minor
nit.

Maybe we could get rid of this redundant function later when we add
pseries specific capabilities (if we still find this extra function has
no use).

So - 

Please feel free to add - 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


