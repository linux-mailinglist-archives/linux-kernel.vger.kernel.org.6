Return-Path: <linux-kernel+bounces-266026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD8C93F96F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E89F282876
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B525D1581F2;
	Mon, 29 Jul 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzI6zpg6"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283BC148848
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266962; cv=none; b=rE4Oi2UwDDaqA/fcjeEOvCL2h+7+k3eW0utRSGE7qa4/N0/2G7HSSl2Hbx6uiBFJJxXLhPhsWTY+ehD4/avGLKgEW7efdVCs4j4gBgr6p9ZYOvYi7vVgBmxbE/EcYZO2loLps+JprrNOtteLUNFKZ8JNPEJWA2hQxvFJ6nOBUYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266962; c=relaxed/simple;
	bh=9KPfT/3SeTRToTKp3uqpQQfagG/NnSdnoqIcXXg76Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUW2F0Pul7GFDhxY9Q61PgK8wnppkfeDxLz8ImJSPSGqG6QJnEJDrCyicIkBbltO5tNr2OxuUhg1Iz6sX1QWOAIU2thOsBTg8osDw3eX91kZiAnqJAnBp9hwnSbaop9WKfFXLctOefYTcjB16DjxxJYIHw1BUXV5TkS5z1ATOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzI6zpg6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd66cddd4dso28716275ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722266960; x=1722871760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEwyU+QCb9uJYPv1krwkDsqk+Tob9fjZC4SjXysgvB8=;
        b=lzI6zpg6NIv3l9Ig3qDzge9+1NNEsVYh5IkwnCi6DZPQf0s2UO3aiFSe7G40C7S7gs
         XcTCiBd27O4HEEjFD+sxyn7cRDKhZ8TRNsChP6LcBGyAX2+AAqA5Mfee2HXSzCAU8Nkn
         OxdgL1EJ4IdEsiFpvw8zWZ/H8ynSevXArdH8tepDAeMJ1BqTV0xHQM6/OGbZbRyBpYCr
         IP0WDanR2aWonMhzqN5avAgcLp9H0elmncSB8+l01YdOrFYd+C3Rq34jxotW9nWNJptg
         zjmMbBRrEHu9pGBXsXxH8TuNQsAwHB8o/vBzXXta0J/wnNSU50Qm7aLZ/PNUT3Gzgzlg
         OMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722266960; x=1722871760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEwyU+QCb9uJYPv1krwkDsqk+Tob9fjZC4SjXysgvB8=;
        b=Qax5dxmFgnlPVYUiLwVnziCD5EaFFXO0E4JhWPN98gZF26937dpkIJmpiCY6TTIYAH
         Sa521ut3/9mFzR1zMNXi314COMkkmHqdSqKIFaQuvzSVaJzYA1HXzKWmptUJwXBzesP+
         G2xgszwSkMdkaTiQS5JKl6IpYbO3kPcbWP2bStMgSHgjYxEZ5dNrIHFeLj5jDJv9mGSj
         wxhvgqzcbF26V2b8XW7UD8UGH9nKE/qSihjUaGDDuAnJc3A5D9n1iGtvNvis+m2Ukiep
         FoE3Wm5j6fliky6eMKGt9735tsTGg4HlSajJbL3Nb1wDaGIyTm2VkYJAVTtybXsFiNUu
         Kt5Q==
X-Gm-Message-State: AOJu0YyMC8FZKkLtzm7NEZlb2FgqRRkEnKGB28qAWO0fPpcX7XKfZQY0
	hSq3vZPK98Xae6xISZaxjubaobAP/gEh7CWQ1APmbO5XKjAK1IJx7sj9ww==
X-Google-Smtp-Source: AGHT+IE/EoXnZsuVV+eJeuuQ8jBq1n68G6nnoSXr49GzAYiymXDtlUUtVvKhUr//ZHb9f1DrtTnxYg==
X-Received: by 2002:a17:903:41c8:b0:1fa:fc69:7a81 with SMTP id d9443c01a7336-1ff0483157amr100623515ad.29.1722266960260;
        Mon, 29 Jul 2024 08:29:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7cf6843sm84835905ad.89.2024.07.29.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:29:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 29 Jul 2024 08:29:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>

On Sun, Jul 28, 2024 at 02:40:01PM -0700, Linus Torvalds wrote:
> The merge window felt pretty normal, and the stats all look pretty
> normal too. I was expecting things to be quieter because of summer
> vacations, but that (still) doesn't actually seem to have been the
> case.
> 
> There's 12k+ regular commits (and another 850 merge commits), so as
> always the summary of this all is just my merge log. The diffstats are
> also (once again) dominated by some big hardware descriptions (another
> AMD GPU register dump accounts for ~45% of the lines in the diff, and
> some more perf event JSON descriptor files account for another 5%).
> 
> But if you ignore those HW dumps, the diff too looks perfectly
> regular: drivers account for a bit over half (even when not counting
> the AMD register description noise). The rest is roughly one third
> architecture updates (lots of it is dts files, so I guess I could have
> lumped that in with "more hw descriptor tables"), one third tooling
> and documentation, and one third "core kernel" (filesystems,
> networking, VM and kernel). Very roughly.
> 
> If you want more details, you should get the git tree, and then narrow
> things down based on interests.
> 

Build results:
	total: 158 pass: 139 fail: 19
Failed builds:
	alpha:allmodconfig
	alpha:tinyconfig
	arcv2:tinyconfig
	arm:tinyconfig
	csky:tinyconfig
	hexagon:tinyconfig
	loongarch:tinyconfig
	m68k:tinyconfig
	microblaze:tinyconfig
	mips:tinyconfig
	nios2:tinyconfig
	openrisc:tinyconfig
	parisc:tinyconfig
	powerpc:tinyconfig
	riscv32:tinyconfig
	riscv64:tinyconfig
	sparc32:tinyconfig
	sparc64:tinyconfig
	xtensa:tinyconfig
Qemu test results:
	total: 533 pass: 493 fail: 40
Failed tests:
	arm:versatilepb:versatile_defconfig:aeabi:pci:scsi:mem128:net=default:versatile-pb:ext2
	arm:versatilepb:versatile_defconfig:aeabi:pci:flash64:mem128:net=default:versatile-pb:ext2
	arm:versatilepb:versatile_defconfig:aeabi:pci:mem128:net=default:versatile-pb:initrd
	arm:versatileab:versatile_defconfig:mem128:net=default:versatile-ab:initrd
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
	riscv32:virt:rv32_defconfig:nofs:noscsi:net=e1000:initrd
	riscv32:virt:rv32,zbb=no:rv32_defconfig:nofs:noscsi:net=e1000e:virtio-blk:ext2
	riscv32:virt:rv32_defconfig:nofs:noscsi:net=i82801:virtio:ext2
	riscv32:virt:rv32,zbb=no:rv32_defconfig:nofs:noscsi:net=i82550:virtio-pci:ext2
	riscv32:virt:rv32_defconfig:nofs:noscsi:tpm-tis-device:net=e1000-82544gc:sdhci-mmc:ext2
	riscv32:virt:rv32,zbb=no:rv32_defconfig:nofs:noscsi:net=usb-ohci:nvme:ext2
	riscv32:virt:rv32_defconfig:nofs:noscsi:net=virtio-net-device:usb-ohci:ext2
	riscv32:virt:rv32,zbb=no:rv32_defconfig:nofs:noscsi:net=pcnet:usb-ehci:ext2
	riscv32:virt:rv32_defconfig:nofs:noscsi:net=virtio-net-pci:usb-xhci:ext2
	riscv32:virt:rv32,zbb=no:rv32_defconfig:nofs:noscsi:net=i82557a:usb-uas-ehci:ext2
	riscv32:virt:rv32_defconfig:nofs:noscsi:net=i82558a:usb-uas-xhci:ext2
	riscv32:virt:rv32_defconfig:nofs:noscsi:net=i82557b:scsi[virtio]:ext2
	riscv32:virt:rv32,zbb=no:rv32_defconfig:nofs:noscsi:net=i82557c:scsi[virtio-pci]:ext2
	i386:q35:pentium3:defconfig:pae:nosmp:net=ne2k_pci:initrd
Unit test results:
	pass: 316946 fail: 0

In summary, quite impressive in a negative sense. At least some of the
problems (such as the tinyconfig build failures, and some of the test
failures) have already been reported. I simply don't have the time for a
detailed analysis. Logs are available at https://kerneltests.org/builders,
in the "master" column, for those with time to track things down.

Guenter

