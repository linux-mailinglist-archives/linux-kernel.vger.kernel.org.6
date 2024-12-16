Return-Path: <linux-kernel+bounces-447580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3999F347A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4B27A06D6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878D21465BB;
	Mon, 16 Dec 2024 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR/XA5tl"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D97D1428F1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362850; cv=none; b=c1mnhMBFuCu2VYZjv4n8JpA4Ma9fqPQxRg5r8GVNMarvfMDzMvL1mfghMaBY/7dJw8nlA8E1dxZROR6WmyjOIaWWezc0FGxP5QMwk2tfkp2QAH+XW9Ht/dbOcqJdE+RtBBgIF3N1LsFOrG8gvhx9Va31HjmHd9cJmWWtQeF8hwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362850; c=relaxed/simple;
	bh=MkFtTkycxCLN2hvMP/wELg8yyfVoUN67QxyV1hUYFl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqvXZGeJ61VYwPfp6iAAhRssi2LTC/Nl/WwaIcm1+iAb68uPQRePXY9YbdWIps71nrzltWB9TwZB+H8bU+3/ydBAR74iWUBwF5lV3XvlSuXPhU5XaFpPxQbphOPpDBWnIEyWOh2xBuepUMMnRGG74QZF3rShYhs7Q3An5mhPB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VR/XA5tl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728f1525565so5013929b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734362848; x=1734967648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txyBl6tr4XpayoZxmsZMBAK3JU44QnXvAJHt33m6DoI=;
        b=VR/XA5tlYSEqap3LAvFD4vg4KckVWt3nPg1ESsLAzHg9dcl9jKZJn7Fj9OTQDzSSKE
         wL+dQuTYzO6A97is6cg4BlRmZ3fZo9h/PP4GwFqQmXZnMobftJuzf8BXvEukqaRqqqM1
         WizIHmvd30UTXt+eGWt6OlmqWZ7dMb09WjwwaOoc6IZv+YWUBBUOW7ci/hGFx2zp5tJy
         r7rh+/olS6jyJDAWHmW6VwiX1clMNNwqz2L9/1Z9fsPFqVSJkKE6qDdlIALk+WNg0080
         ro9Hr1ASelJVbQPhTZYlGKti3TORc4Wo9dXvCGubq46xaYlwXyNzNWRz17Iib1CnDlYt
         1Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734362848; x=1734967648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txyBl6tr4XpayoZxmsZMBAK3JU44QnXvAJHt33m6DoI=;
        b=NtVIunLDmVBRR4AlYOdKmjbq6LgtQcWwL2py+50pFSaIcdO2WarUpoxK5J45udHzCT
         ttd2O+moV1DBHWgolVfSICgj9iE6PaFAzcwOqPSqAehodoY2ZjPe38bT0WICi8QnolCI
         vs82MfWAyU9jvRrwzhcf4bf83MGKlXvMCJsvZ6ffF/5ZH4oKCS1oRaCH+IxpfDrVgBMv
         TtU2vhgT9S/FKKOh5RrPL3jHzRSJ0bb7P5TzlIBoLAh8wYTbXcBrPoWciKgcRWifyinE
         hXAuxIEuBnYt/pvCgeR0kqwix5Fz+MOE6WbOoxJc3rUAjb7c1FR9E+8UfsM/ZGzmC8mS
         leWg==
X-Gm-Message-State: AOJu0YzNgIFq9F9CoNh6+V0T5zo5CpDQC8HODv+0y0vjrWyvRDOiF/zO
	Vt5rDAr+acXUxAoBD0bOOTYfCT+6H36RxIUio2ml6U0w5fWCW626TBkd0w==
X-Gm-Gg: ASbGnct/7oGlw1sHeQ6NM54Rm5pgCAjLeo83ADBOM3ngl5raH81FnvyeCU1SVwIqB7N
	GsxFsvoN4dzvBrZELWSeWWoBwhgWOrOIemkKfD8/MfinKnu/ihj5/+lzOeY5WeeOV9y6RQMdKiL
	UAQl/y6V5aCGu0Hn3JXl+zYyr7tGa/HTKvNvNjD33SKLzLjLYusvs1gSqqNEYV44w5LyBAS00fF
	ALRK7prN7J2qBJuLssfIsKZmX0hMej/q8w3NX/aous0ZpoZSHsVrdflfQ0qJlZ24QxuGA==
X-Google-Smtp-Source: AGHT+IGT6EcHMKQh23sPpi7UK4xTExOckkhjoKvOJQaf3CpmpPE2d4t3WUTVjWtTjCuWaLPUFaMhEQ==
X-Received: by 2002:a05:6a20:d48f:b0:1db:ff76:99d7 with SMTP id adf61e73a8af0-1e1dfde8ff6mr21945776637.35.1734362848387;
        Mon, 16 Dec 2024 07:27:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b79066sm5038971b3a.129.2024.12.16.07.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 07:27:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 16 Dec 2024 07:27:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.13-rc3
Message-ID: <ce5282c1-d86f-422e-8ea0-916ce65076b5@roeck-us.net>
References: <CAHk-=wh7Wjqo_e1bLeEijGkDaw7XcD3+F5kLZYkJfah8wS=evg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh7Wjqo_e1bLeEijGkDaw7XcD3+F5kLZYkJfah8wS=evg@mail.gmail.com>

On Sun, Dec 15, 2024 at 04:10:24PM -0800, Linus Torvalds wrote:
> Earlier this week it felt to me like things might have already started
> to quiet down in prep for the holidays, but doing the statistics on
> rc3 that doesn't actually seem to be the case - this looks very
> regular both in number of commits and in diff size. In fact, the diff
> is  a bit on the larger side, but that is admittedly almost entirely
> due to the revert of a unicode change that then makes the diff large
> due to a generated data file.
> 
> So everything looks normal so far. xfs may stand out in the shortlog
> below, but the bulk of the diff (ignoring that generated unicode
> table) is still mostly random driver updates.
> 

Test results form my testbed:

Build results:
	total: 161 pass: 159 fail: 2
Failed builds:
	i386:allyesconfig
	x86_64:allyesconfig
Qemu test results:
	total: 544 pass: 529 fail: 15
Failed tests:
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:mem128:net=default:imx25-pdk:initrd
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:sd:mem128:net=default:imx25-pdk:ext2
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:usb0:mem128:net=default:imx25-pdk:ext2
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:usb1:mem128:net=default:imx25-pdk:ext2
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:mem256:net=nic:net=nic:imx6ul-14x14-evk:initrd
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:sd:mem256:net=nic:net=nic:imx6ul-14x14-evk:ext2
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb0:mem256:net=nic:net=nic:imx6ul-14x14-evk:ext2
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb1:mem256:net=nic:net=nic:imx6ul-14x14-evk:ext2
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:smp2:mem256:net=nic:imx7d-sdb:initrd
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:smp2:usb1:mem256:net=nic:imx7d-sdb:ext2
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:smp2:sd:mem256:net=nic:imx7d-sdb:ext2
	arm:sabrelite:imx_v6_v7_defconfig:nodrm:mem256:net=default:imx6dl-sabrelite:initrd
	arm:sabrelite:imx_v6_v7_defconfig:nodrm:mmc,b300:mem256:net=default:imx6dl-sabrelite:ext2
	arm:sabrelite:imx_v6_v7_defconfig:nodrm:usb0:mem256:net=default:imx6dl-sabrelite:ext2
	arm:sabrelite:imx_v6_v7_defconfig:nodrm:usb1:mem256:net=default:imx6dl-sabrelite:ext2
Unit test results:
	pass: 464828 fail: 0

Without going into detail, the above problems plus all new warning
backtraces observed since v6.12 are fixed with the following patches,
available in my fixes branch at
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git

0e8df6ef3b85 staging: gpib: fix pcmcia dependencies
5dcac0200cb5 staging: gpib: fix Makefiles
df631b2fc6f5 staging: gpib: make global 'usec_diff' functions static
b20a38276741 ARM: imx: Re-introduce the PINCTRL selection
45d54fabe85a locking/lockdep: Enforce PROVE_RAW_LOCK_NESTING only if ARCH_SUPPORTS_RT

Guenter

