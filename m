Return-Path: <linux-kernel+bounces-195064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C5F8D4710
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46A51F22F48
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D4214F117;
	Thu, 30 May 2024 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wNRq5zl4"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299DA7406F
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057758; cv=none; b=c7LGMsrKBzZos5MZIujyXFrxVqhwmxKRN4MFNFxRjfr15PdmH0TGaGCEMHQwxWs32EjdCe5QRdTUjsF2vPDVwgSvjiQwXQDmPRcoHjTtfLlTf7o4Ec2EdWwBLrqVgQ98cnS2hbQJxIx3w6pTb/2kKTo/CAXF2RhMvGczFtdngzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057758; c=relaxed/simple;
	bh=1dC68OM5OhNNycQprP16os0Vg8/XXI2lafMKxC6p1Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9A4qgwpEcGdMLWLgSLtK/rT5jZ7wgvj+RFOtzP6kFcMEm8kFyOG4KbKu5QChXKWS++92vzFE4T5Wpsn5Og8pjV5useuEYzwK/OWDiYUyLChE6SewBPIGT2PUn4aXuIXSTamYkfGCDCymmgWXkvM0ZfbWohBEVyZHdCU+OpfQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wNRq5zl4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b7ca4ad02so602158e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717057754; x=1717662554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jq3ITJfY20FavL9VkNKUphQHsxj2xf5tU3FnyAFuhp4=;
        b=wNRq5zl45XI5MaJAYnUiOrvVnckMSDy5WpfN1+TiJqRV9bX9yDOnxh/6SNC/30Knca
         wkMfwfycz3LcISeQv4ivA95TRZtyV5C0IhNXgPrO4iCVZHmNAsMasrCMnMkuIlJ1NqSn
         bEozbgCXuSelnFb0RZ9vZisvyt2X9kIjnxMtmY6fGXFrR3HlBgKG8imUPICIb86cFh6B
         5bMuV7x/g8of4QicJKqcLp3yfhSg8CFxlbTzvo1KXdpfpJSLbjTsfwJAFRai7m+sD4zH
         mFLx36j/DNZcBvyakQZ+MemZfs4ImkyW1pVX1yATe+czxdBckAa7J6hG1flXJUwtY2Wj
         OF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717057754; x=1717662554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq3ITJfY20FavL9VkNKUphQHsxj2xf5tU3FnyAFuhp4=;
        b=v+FLc+3PESH3uwS7WcN2KiU2QP/jJzBTVGwDXyugw8ocybEJ1EhF4iK9SRMuMBBM/2
         e0wasg+J3IKHDVdzJOWanNGsEXtD7fEaVjlmHHmaw+YlJMxtwYfhjb+9JdatyiireCwP
         f9qXh0MASz9mYHG3XKvglccD+FP/zUGruLO40uSSBTamhHkLtgGTO8dvTlh3Io6Xm8h7
         irmArSAPFnUMknqvvpgx6k9YcsA/JkFBUV+xgUkWryk6REhbhs1f/az/i2V2jj9pRzJJ
         IqDtgBsw4pLFVzVmM3V/EaD8rOyq/D80KXlKU3FZM7Mi6Ftj7n7ZmrxpM3vn7eMVW+IJ
         UOKA==
X-Forwarded-Encrypted: i=1; AJvYcCUp2HF6FekMFBT3TiheyLGtRXLHi/OaNCtHxnWv7x//tba77vuYo5T+QZfSk/sTAxsI0xlxZKvSWI8Vp8ZYF5kdzw0Mi+EE+itcrmIB
X-Gm-Message-State: AOJu0YzCKgq1i72KfS7EiGsOeqOGl7b13El7MLBciuvGXmogmIxwMG5R
	Qi4AxD3y7hWpfd3l2PqzOzbMgFQOlh+kiXYxICSK1xzb600zSpJrCeAadcYEmjk=
X-Google-Smtp-Source: AGHT+IERPqwzqHvnyunM46xzNM43pMoF4XoGOgBgJEWi/VN1D9l7sjV1ewNrLmSLuk4GSE0T8kvXjQ==
X-Received: by 2002:ac2:5328:0:b0:51e:bc4f:ed2a with SMTP id 2adb3069b0e04-52b7d43a6c5mr798868e87.37.1717057754190;
        Thu, 30 May 2024 01:29:14 -0700 (PDT)
Received: from nuoska (drt4d6yywjht56pm8q3st-3.rev.dnainternet.fi. [2001:14ba:7430:3d00:1239:a19d:315c:6ddf])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296e88788fsm1472254e87.61.2024.05.30.01.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:29:13 -0700 (PDT)
Date: Thu, 30 May 2024 11:29:11 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Manuel Traut <manut@mecka.net>
Cc: Sumit Garg <sumit.garg@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Message-ID: <Zlg411JGQJf2zRPe@nuoska>
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org>
 <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
 <CAHUa44G0bcK55RxNrN5sXiicBZ-BJtA46KpedfBdUSKsN8eUOA@mail.gmail.com>
 <ZlWkSCCjJ2fbE2ML@nuoska>
 <CAFA6WYOT52fdqgGvDYE91DQ_4MUbAv_1Gnn2fTyMNhrj_Agu=w@mail.gmail.com>
 <ZlbUwI0G3HGvioNm@nuoska>
 <Zlb3fuqvQIO9ghQX@manut.de>
 <Zlc7B6khuhGZ6QOZ@nuoska>
 <ZlgsLibqO59kNQUE@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZlgsLibqO59kNQUE@mecka.net>

On Thu, May 30, 2024 at 09:35:10AM +0200, Manuel Traut wrote:
> Hi Mikko,
> 
> On Wed, May 29, 2024 at 05:26:15PM +0300, Mikko Rapeli wrote:
> > Hi,
> > 
> > On Wed, May 29, 2024 at 11:38:06AM +0200, Manuel Traut wrote:
> > > Hi Mikko,
> > > 
> > > On 10:09 Wed 29 May     , Mikko Rapeli wrote:
> > > > On Wed, May 29, 2024 at 10:56:04AM +0530, Sumit Garg wrote:
> > > > > On Tue, 28 May 2024 at 15:00, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
> > > > > > On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> > > > > > > On Mon, May 27, 2024 at 3:00 PM Jerome Forissier
> > > > > > > <jerome.forissier@linaro.org> wrote:
> > > > > > > > On 5/27/24 14:13, Jens Wiklander wrote:
> > > > > > Outside of these patches, I think the optee RPC setup with fTPM TA is one area which
> > > > > > currently requires tee-supplicant to be started. Detecting the existence of TPM before
> > > > > > kernel drivers are loaded is possible via the exported EFI logs from firmware to kernel
> > > > > > or ACPI TPM2 table entry, and detecting optee and thus starting tee-supplicant in userspace too.
> > > > > 
> > > > > One thing I am trying to find an answer about is why do we need to
> > > > > defer tee-supplicant launch if it's bundled into initrd? Once you
> > > > > detect OP-TEE then tee-supplicant should be launched unconditionally.
> > > > > As per your example below, the motivation here seems to be the TPM2
> > > > > device dependent on RPMB backend but what if other future systemd
> > > > > services come up and depend on other services offered by
> > > > > tee-supplicant?
> > > > 
> > > > There is an annoying depedency between firmware side optee and TAs, and kernel optee driver,
> > > > tee-supplicant in userspace and kernel TA drivers like fTPM.
> > > > 
> > > > Kernel fTPM driver and fTPM TA require tee-supplicant in userspace for RPMB, RPC etc.
> > > > 
> > > > This patch series is adding kernel side support for RPMB handling so that the dependency to
> > > > tee-supplicant in userspace can be removed. For fTPM use case, there is still the optee RPC
> > > > buffer setup which currently requires tee-supplicant in userspace or fTPM TA will panic.
> > > > 
> > > > So yes, currently, tee-supplicant must be started. But it would be great if kernel drivers
> > > > and firmware optee trusted applications would not depend on tee-supplicant running in userspace.
> > > > The startup sequence is really tricky to get right. My fTPM use case is using the TPM device
> > > > to encrypt rootfs and thus all SW components including tee-supplicant need to run early in
> > > > initramfs. Currently also switch from initramfs to main rootfs requires unloading
> > > > fTPM kernel driver and stopping tee-supplicant in initrd, and then starting tee-supplicant
> > > > and loading fTPM kernel driver from main rootfs. udev and automatic module loading for
> > > > fTPM can not be used due to the tee-supplicant userspace dependency.
> > > 
> > > I decided to build fTPM as buildin-TA into OP-TEE. RPMB routing is already
> > > implemented in u-boot so it can already write PCR registers.
> > 
> > Is build in TA same as early TA? I presume so.
> 
> Indeed.. sorry for using the wrong term.

Ok, no problem. Then we have the same fTPM TA setup. I'm using optee 4.1
with RPMB kernel support changes from Jens cherry-picked on top.

> > > With this series and the required changes in OP-TEE and a compiled in fTPM
> > > kernel driver and systemd v256 it is possible to use the fTPM in the initrd
> > > without tee-supplicant.
> > > 
> > > Maybe this information is helpful to you, regards
> > 
> > This is very interesting and I'm trying to get to the same state, though with
> > fTPM kernel driver as module. With v6 of this patch set and matching optee changes
> > I was not able to make this work as fTPM TA was crashing when loading ftpm kernel driver
> > due to failing RPC allocation, which tee-supplicant was setting up in the whole chain.
> > I'll try to get v7 patches working and test this again on my yocto based setup and kernel 6.6.y.
> 
> I'll try today also with v7 and 6.10-rc1 on an i.MX8MM. It should also
> work with fTPM as kernel module if you use systemd in the initrd
> with the new tpm.target in systemd v256.

Thanks for the details. I'm testing on qemu, rockpi4b (Rockchip rk3399 SoC) and synquacer
(Socionext Developer Box, SC2A11:Cortex-A53 MPCore 24cores). Kernel and rootfs
are from our yocto master branch based Trusted Reference Stack distro
( https://gitlab.com/Linaro/trusted-reference-stack/trs )
with kernel 6.6.29 (porting the RPMB v7 patches currently), systemd 255.4 (tpm2.target
backported), tee-supplicant 4.1 etc. I'm switching the initramfs from shell scripts
to systemd currently, but running into various issues.

UEFI firmware is our Trusted Substrate ( https://gitlab.com/Linaro/trustedsubstrate/meta-ts/ )
ARM System Ready IR compatible with secure boot and TPM support, u-boot
2024.04 (except rockpi4b still on 2023.01), optee 4.1, fTPM etc from meta-arm
yocto layer.

Booting without tee-supplicant has so far only resulted in the fTPM TA panic'ing
because RPC setup is failing. Also the fTPM TA enumation needs to be changed
from current yocto defaults to always discoverable if there is no tee-supplicant:
https://git.yoctoproject.org/meta-arm/tree/meta-arm/recipes-security/optee-ftpm/optee-ftpm/0001-add-enum-to-ta-flags.patch

I hope to get v7 of these patches into testing today.

Cheers,

-Mikko

