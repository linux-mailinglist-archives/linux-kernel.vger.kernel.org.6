Return-Path: <linux-kernel+bounces-336486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B44983B66
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E17B22479
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F5313FFC;
	Tue, 24 Sep 2024 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIywVZEa"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7793E1A270
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727146597; cv=none; b=jEec1SVotep3XfYNiXSr4U3XIpDNKYGgd+fMwFcq61LQJCGm+PB6K6xCYbmaOlv2/OgHBNslOiNIZgkZRTehrEF3m5a3/6y2vEDGvF7TIz0o1BD4kxCxgf+VcTis1QQAZh457rjwAaJzgKgMKYoxbQ5RmYBY7JqSe03UA0hRUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727146597; c=relaxed/simple;
	bh=Q9jP7Q1ZhPeTNCMNZPnll2Sf0iv1WFG1IhgqRB5dmZw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Rsmeic2aLj/mpDtSPgaGerYCZDbaYnOg8XE/tDEB9G8XoBOIW8UkrUBsNVEDj76iNiiHYWGi5niZMOnYFBof5a6E8m/sP0j9kDqo7cxcLVbxjIBY6+JOYa5qzkJUMOehkh0v4FfhH5VEn4fhGL0Wp1sMnYFP9ajWZj0dhI5HrUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIywVZEa; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d8b679d7f2so4012468a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727146596; x=1727751396; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=On9oGsvIZfjem73sGq+MqJdM2U+WXxLGXRq4IkAZ4Lo=;
        b=VIywVZEan53cLVg5z41eT4LXB3Yf7LpQ77B+a0fHRX7R1ublvTFe78YO++sQYoBc6+
         KTun13x3bbDg3uBBBsIsi1zmGkvP/iQ8AAkx5WiHWLr5xtghhyJa8rAekTdLuFgSQsxa
         rRZavKAytKiF0MaZLXjZbQEvSF5+SS/KtC6kMvLHAD/2HhwGidaPQL6f+Km/FRkPlhUW
         kS7eoOcYUA7dT0s5a15J7FTftGCi1X6WVBM3CZCvZ2ht2CWG0dfR+1b+YLGbEhYGD0DZ
         Fuyt8lz4RrHkffh9OAkx6KbofsvyhHHicgkbhqmCgQCeDn+V/U+NPz7qC1FIMfodCTTo
         er2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727146596; x=1727751396;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=On9oGsvIZfjem73sGq+MqJdM2U+WXxLGXRq4IkAZ4Lo=;
        b=WPsif1PFe/RxdCx4u9X+DPpfjs1jYkui596jyur7656FecFdRlaaO4z/Up5wE81luZ
         CuI1y8s2YCcWYrRycXBt+3cfhHIs+e4MX49ZB/Zz+hsMafpsk/TBnHLsUXRCwo9iAUbL
         ZiD/G2DJ7zJ/yYz9uREnT/Al20kFew69cMpkZKNGWwh7mhaASro9hWsfBOp2AI1/BnE7
         WvZRXoO58G/jxlQF+poIeMu7J+yMKy/F5ed2AuFTAaDwby7wUUhL3zewgGAYD6Iv2wVy
         damKWqjbXDFwobWhk6R6xH9CMNEWnia6NHsspxhFJ/7HzI5gMqUTV3lVHETh7JQCxHEh
         R8Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWB3wnKBUSmjyPbUq/v1Q0S7JLFnBSy8VSVWIwYj6li5DL5Y5iduMdlWz2hp8Kntbjigr6ini7kEcw7+iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTUgxysq6RDNS66WbMr3KZFdM4hZvahe6UV4pXiwiG65pGWFX
	/2czWcd8bkkhPodcWvXLJ+vzj/Ni1t+91WgQbWZo4uWAWDMLrhk3
X-Google-Smtp-Source: AGHT+IGCM/yRJ3B8EHDlCv/yrPfabD25tlj3A/kHgW0/fWrGcWy5BoiszT2hpqv3WpjdbmjtaZnRow==
X-Received: by 2002:a17:90a:fa8f:b0:2d8:53f8:77c0 with SMTP id 98e67ed59e1d1-2dd80c05452mr18655444a91.7.1727146595600;
        Mon, 23 Sep 2024 19:56:35 -0700 (PDT)
Received: from dw-tp ([171.76.82.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e058f6ed30sm348649a91.25.2024.09.23.19.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 19:56:34 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org, mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, vaibhav@linux.ibm.com, ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
Subject: Re: [PATCH v3] powerpc/pseries/eeh: Fix pseries_eeh_err_inject
In-Reply-To: <c474f56f-af74-479d-9db6-fbbfdb287604@roeck-us.net>
Date: Tue, 24 Sep 2024 08:23:18 +0530
Message-ID: <87a5fxbw4h.fsf@gmail.com>
References: <20240909140220.529333-1-nnmlinux@linux.ibm.com> <c474f56f-af74-479d-9db6-fbbfdb287604@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Guenter Roeck <linux@roeck-us.net> writes:

> Hi,
>
> On Mon, Sep 09, 2024 at 09:02:20AM -0500, Narayana Murty N wrote:
>> VFIO_EEH_PE_INJECT_ERR ioctl is currently failing on pseries
>> due to missing implementation of err_inject eeh_ops for pseries.
>> This patch implements pseries_eeh_err_inject in eeh_ops/pseries
>> eeh_ops. Implements support for injecting MMIO load/store error
>> for testing from user space.
>> 
>> The check on PCI error type (bus type) code is moved to platform
>> code, since the eeh_pe_inject_err can be allowed to more error
>> types depending on platform requirement. Removal of the check for
>> 'type' in eeh_pe_inject_err() doesn't impact PowerNV as
>> pnv_eeh_err_inject() already has an equivalent check in place.
>> 
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> 
>> ---
>>  arch/powerpc/include/asm/eeh.h               |  2 +-
>>  arch/powerpc/kernel/eeh.c                    |  9 +++--
>>  arch/powerpc/platforms/pseries/eeh_pseries.c | 39 +++++++++++++++++++-
>>  3 files changed, 44 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>> index 91a9fd53254f..317b12fc1fe4 100644
>> --- a/arch/powerpc/include/asm/eeh.h
>> +++ b/arch/powerpc/include/asm/eeh.h
>> @@ -308,7 +308,7 @@ int eeh_pe_reset(struct eeh_pe *pe, int option, bool include_passed);
>>  int eeh_pe_configure(struct eeh_pe *pe);
>>  int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>>  		      unsigned long addr, unsigned long mask);
>> -
>> +int eeh_pe_inject_mmio_error(struct pci_dev *pdev);
>>  /**
>>   * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
>>   *
>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>> index d03f17987fca..49ab11a287a3 100644
>> --- a/arch/powerpc/kernel/eeh.c
>> +++ b/arch/powerpc/kernel/eeh.c
>> @@ -1537,10 +1537,6 @@ int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>>  	if (!eeh_ops || !eeh_ops->err_inject)
>>  		return -ENOENT;
>>  
>> -	/* Check on PCI error type */
>> -	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
>> -		return -EINVAL;
>> -
>>  	/* Check on PCI error function */
>>  	if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
>>  		return -EINVAL;
>> @@ -1851,6 +1847,11 @@ static const struct file_operations eeh_dev_break_fops = {
>>  	.read   = eeh_debugfs_dev_usage,
>>  };
>>  
>> +int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
>> +{
>> +	return eeh_debugfs_break_device(pdev);
>> +}
>> +
>
> The new function, as the context suggests, is only compiled if CONFIG_DEBUG_FS=y.
> However, it is called unconditionally. With CONFIG_DEBUG_FS=n, this results in
>
> powerpc64-linux-ld: arch/powerpc/platforms/pseries/eeh_pseries.o: in function `pseries_eeh_err_inject':
> /opt/buildbot/slave/qemu-ppc64/build/arch/powerpc/platforms/pseries/eeh_pseries.c:814:(.text+0x554): undefined reference to `eeh_pe_inject_mmio_error'
> make[3]: *** [/opt/buildbot/slave/qemu-ppc64/build/scripts/Makefile.vmlinux:34: vmlinux] Error 1
> make[2]: *** [/opt/buildbot/slave/qemu-ppc64/build/Makefile:1157: vmlinux] Error 2
>
> I'll enable CONFIG_DEBUG_FS in my tests and won't report this further,
> but you might want to consider fixing the problem at some point.
>

Yes, this is fixed and picked up in powerpc tree.

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=merge&id=3af2e2f68cc6baf0a11f662d30b0bf981f77bfea

-ritesh

