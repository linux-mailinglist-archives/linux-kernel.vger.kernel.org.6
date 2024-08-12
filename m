Return-Path: <linux-kernel+bounces-283390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2284694F1E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C127C1F238B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D11184538;
	Mon, 12 Aug 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk3kh/43"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25E183CD4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477194; cv=none; b=gaw7SHrsVGw1W+910C6+oJY+fn1/L8tcA3+5RLugf6aJF//tVwqTSShS3eiKWOTcuE2+NSnlb0GRWm72rF80SODI5xeIG9xHt/aeyVQWrhbfoOsKKi1BC1s7/ZvQXS20UW7tZVTF8aSjTBzvQDHerj6IBS4u62HKjdCbXBX9O3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477194; c=relaxed/simple;
	bh=wCUBjTJClPhsjWnvucY79lRFrXsgfdnGkEeOx+5IqUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ua69vAcYxgbweIYqvYuVGkOYgTCV7ky1qXFssOILfp0NVJANmD06bFbXnK9CattZvvZa2O2myxJWTuXMpTtYEDJD2hqVcBtzZZKreLfEe6DpXxhj8huAv6+MVL6LfFcIrtccer3pUGIOeQ2LonnMlma2aQ5sNPrHCYe7UeQVbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fk3kh/43; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-200aa78d35aso17618645ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477191; x=1724081991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzxlktYMQary2FQy6FkjVq8APY99pGCjjWx7emAdMDM=;
        b=Fk3kh/432P7MCkFdUnhFk2yP5JgFbuP0EFyJga7i0nb7nOhlFWlC787vsO2vMdQSIN
         KQThGGbvRid0KqXKN4OFRsfqBLClNxSC9KKpytErl8/k/snpA22liJSP1htMsBGeQjM5
         vJqRAAFn6epB7MLQOk3qfSHeby1mnPdS0uBgxzWf1HqTEQk33YdFjW4BGr1WnL3Jh5u0
         A7bg+hdtP4oObOFnWQBbXinfjVBAKo+1ZrjRURUtiM10n3a/S8mjiFqD/vC7gGNVnzJ4
         8+WGlhMzz1Tv3bNnb46VfoKAvzouGgXrI+FzR2lhPuVFI/hFIsiDHdXxYr3BlZAbk+jr
         pVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477191; x=1724081991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzxlktYMQary2FQy6FkjVq8APY99pGCjjWx7emAdMDM=;
        b=RFwIgqDabti0iCM7oR+Db/twS8HkfXS3aolzqqqAjxRDUIg7YcdRe+Xe5uszjgKoti
         qiOSjdM4CLEOg0xCnZTWi8mtBI1j6k7/6J2ZHZZoCI6W2OvtP9oPTHH/DSxYt+paMDat
         RIcFjRxFW69jx/RfqxPwVkJC+/A8p9Y/yjPPcgHmd19kkX5oXQRa5WlF62us89xh196R
         8OqBrcgutnm/WWIirtQRQpk4WbwPKoxKTE0BdI3uMLhxbytRlscv+CjL8KD3eoVvpK4K
         I2ugLVG4jp7J0Yvdo/idCb4WAwg8DzBArbQ+KoSCvQ6M5P++ojvOkS5LPAP/QyNLohgB
         3abw==
X-Gm-Message-State: AOJu0Yy8WUR6Pg2+7AtYMAVMSTsbSaxPF3jBmFpVOzAbEpMEwxeAmVhx
	mWfxmDf+FEl7ckd3Y3lqXsHKeJ7hBl/kXwKLHR5QOPbOweC2qf6Ts8CwWw==
X-Google-Smtp-Source: AGHT+IHjYCt5/Q2Le8clidztmshfEx9Glt9vfdVPSiXDIvNaebRmvM6wjOJbdKOzmZkjCKKRTl/Bog==
X-Received: by 2002:a17:903:249:b0:1fd:7664:d870 with SMTP id d9443c01a7336-201ca1b115bmr7840615ad.51.1723477190850;
        Mon, 12 Aug 2024 08:39:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bba01c8dsm39398505ad.231.2024.08.12.08.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:39:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 12 Aug 2024 08:39:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.11-rc3
Message-ID: <669cefa8-b60b-4ade-9bfa-20f4b89fcc72@roeck-us.net>
References: <CAHk-=wj7_w1E0kMiUeskhBRrcCz3bejjegteGmM6-TES8bQURg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7_w1E0kMiUeskhBRrcCz3bejjegteGmM6-TES8bQURg@mail.gmail.com>

On Sun, Aug 11, 2024 at 02:35:08PM -0700, Linus Torvalds wrote:
> Nothing particularly strange or interesting going on, things look normal.
> 
> Half the changes are to drivers (all the usual suspects: sound, gpu,
> and networking are big, but we have usb and other misc driver fixes
> there too).
> 
> The rest is the usual random mix, with filesystem fixes (bcachefs,
> btrfs, smb), architecture fixes (arm64, loongarch, x86),
> documentation, and networking. And some core kernel and tooling
> fixlets too.
> 
> Please do keep testing,
> 

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 539 pass: 517 fail: 22
Failed tests:
	microblaze:petalogix-s3adsp1800:initrd
	microblaze:petalogix-s3adsp1800:rootfs
	microblaze:petalogix-ml605:initrd
	microblaze:petalogix-ml605:rootfs
	microblazeel:petalogix-s3adsp1800:initrd
	microblazeel:petalogix-s3adsp1800:rootfs
	microblazeel:petalogix-ml605:initrd
	microblazeel:petalogix-ml605:rootfs
	ppc:mpc8544ds:mpc85xx_defconfig:net=e1000:initrd
	ppc:mpc8544ds:mpc85xx_defconfig:scsi[53C895A]:net=ne2k_pci:btrfs
	ppc:mpc8544ds:mpc85xx_defconfig:sata-sii3112:net=rtl8139:ext2
	ppc:mpc8544ds:mpc85xx_defconfig:sdhci-mmc:net=usb-ohci:ext2
	ppc:mpc8544ds:mpc85xx_smp_defconfig:net=e1000:initrd
	ppc:mpc8544ds:mpc85xx_smp_defconfig:scsi[DC395]:net=i82550:ext2
	ppc:mpc8544ds:mpc85xx_smp_defconfig:scsi[53C895A]:net=usb-ohci:btrfs
	ppc:mpc8544ds:mpc85xx_smp_defconfig:sata-sii3112:net=ne2k_pci:ext2
	ppc:ppce500:corenet32_smp_defconfig:e500:net=rtl8139:initrd
	ppc:ppce500:corenet32_smp_defconfig:e500:net=virtio-net:nvme:btrfs
	ppc:ppce500:corenet32_smp_defconfig:e500:net=eTSEC:sdhci-mmc:ext2
	ppc:ppce500:corenet32_smp_defconfig:e500:net=e1000:mmc:cramfs
	ppc:ppce500:corenet32_smp_defconfig:e500:net=tulip:scsi[53C895A]:ext2
	ppc:ppce500:corenet32_smp_defconfig:e500:net=i82562:sata-sii3112:ext2
Unit test results:
	pass: 345115 fail: 1193

On the plus side, the following patches in my 'fixes' branch address almost
all problems seen in my tests.

apparmor: fix policy_unpack_test on big endian systems
powerpc/mm: Fix size of allocated PGDIR
Revert "MIPS: csrc-r4k: Apply verification clocksource flags"
microblaze: don't treat zero reserved memory regions as error

For details please see branch 'fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git

Guenter

