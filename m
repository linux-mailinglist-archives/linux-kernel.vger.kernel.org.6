Return-Path: <linux-kernel+bounces-446931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6936D9F2B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB02918822A7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A57E1F4E4F;
	Mon, 16 Dec 2024 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nYRT1oH+"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4D01B6CF0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734334837; cv=none; b=su78KJjMvoxV9mWsi+TKDM/tdEW5iSj1pY+5Im6EsF8/JEOX9MCSuifE8IJpbCRTHVChz/hXKX2+D71V5VSOZZ82p9ZltXNTsumfCflzze7AF5xS7/X4/tQc+O0t90lKU6WMmOYPzFT/A+f5LUCB0iP6Q907QoXoaJD0/bIS+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734334837; c=relaxed/simple;
	bh=sSaYK2tg4AyOEiujF9xShUjCJHhLBfgOPM3fu4GnXkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTRgwgBT6ZQdStGvmdcLUvOJEd37TuhcG1UdlMkcxyg/aW6Hv5gQigaOaADWL2WAMpEUZUDYESb6OMNXgOHNdQkRNgb0G6eF8xQBU0hr3yHDKuDJGCjfkBSpet9Lu6fa0ndD7axiz6rlgYv6x0623arPHENzmoSMMmBs2krxKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nYRT1oH+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-728f337a921so3862650b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734334835; x=1734939635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8mDgxM0yEOok2sKIVcUGDtQKV48thFUw050xg1Tx7VU=;
        b=nYRT1oH+Lmol8aJbdMdmr2CER42eB2AvUfdSGxVXWsbp52P/pKHIAeiQkPYDvrp+aM
         UDxXjAtxekUKdnH6O3t3VT6LKquKA7OfNgkzA+nZ3CRPTa0xpM+3sYcBybn98MR3hwCu
         6j5B8ctnSor9yeUVNPPqf7JYNmc52Gro4BRnfaoj/frS/cAZJ7vVFXXAVSW/vw6l3bwI
         A/6I0FxDvyTfHVwyMEcXWai0+U9KLTS0aVlv1B1EMOT5xqjLGwMFxPeNB6epkT4rIxcQ
         bMlsll0irf/0k1PKxc6v6ht6Z0NhLDSLCSBzyJosSGdqDdooWvPkE1DllQdxi/Xzktsr
         Rvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734334835; x=1734939635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8mDgxM0yEOok2sKIVcUGDtQKV48thFUw050xg1Tx7VU=;
        b=wcNKliDi5d5EDKtgjVNlpfuxoKJjbY3dnKGzw5zBawQz0WfaZS4Dvnapyu//72+GXa
         P1Qs1oWDz3uZzCRxISsgWI9XFbkp0Ilw0ijHYeJ4A5X/sDjT98dmJ2w5vNCMJ1iTaY8v
         G0/HR1qN8fNMECbBRe/l6+zYtEAL5xEMk4fC0To5SLTPuS+eAL5U+NAFYo5+sfsUdz7H
         yf1L8g/9Bgn1Ik5wGh4OGN65FjuB3bvxc+iA4B3jj9DOatxEyAvldYdw8QUPkyNIHLYg
         VZ2h/BfC7ODSrdZ6g9e8q3FOVCbJ5wDgNFCMpuPD2DVrfMXrW1WS4+uZPOaEEhEq3N6K
         Mqig==
X-Forwarded-Encrypted: i=1; AJvYcCW8sHEEZIujvrM0EiX3vePO7S5sRioWFbK2qjSffGF3Q1G745JIes2rUcywMUXVz2KIG7YgsO0vTcxi+mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdzJKFIsKuxi6rJooxNg0Fu7xVLL/h1P3hYiAnplKsHXUcmblE
	a6zZOBuvGA+/TatNv7WSQsEOfhd5dEkx1iT+OZniQy1wYDndAvelD0+EU/+4SQ==
X-Gm-Gg: ASbGnctt55Rl0BBbUymCT628HLPETLmftFddbSqZb/BBeXj/fxJjk5sdBZJwBsRv5y4
	tvM22ZPfU6wmZviKRH69KiP2Mnknh06i/HeE3yNHhUwCviu5siHEwGSiKh4+mJi8yfDo+fB3hdA
	RojhPSsCaOtGavL4qRk6z1gRXQuwSIRaNGV8it0OeqsOZysTjl2dAuE6YXuXvvCNQA5WhHjDrmt
	m64YNe7BXr2mWb2IndX6D812i5xey/y4dUMHwnicOHBrnh91SfgatAlAfqB3n0Ts1c=
X-Google-Smtp-Source: AGHT+IGGVu4KJwdCoYzSffGoaGBpFi0gWJGthQi9td/n7fVzDFpB7iakWS1EO51d1T+rE8NLKPwRjQ==
X-Received: by 2002:a05:6a00:1815:b0:724:d503:87a1 with SMTP id d2e1a72fcca58-7290c144b3amr13962615b3a.7.1734334834646;
        Sun, 15 Dec 2024 23:40:34 -0800 (PST)
Received: from thinkpad ([120.60.56.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad6536sm4132897b3a.76.2024.12.15.23.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:40:34 -0800 (PST)
Date: Mon, 16 Dec 2024 13:10:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: mhi resume failure on reboot with 6.13-rc2
Message-ID: <20241216074021.kwoid2747o7piquv@thinkpad>
References: <Z1me8iaK7cwgjL92@hovoldconsulting.com>
 <20241211145315.vaf7gbapieywcvau@thinkpad>
 <Z1mp3_ArzL-GLr3D@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1mp3_ArzL-GLr3D@hovoldconsulting.com>

On Wed, Dec 11, 2024 at 04:03:59PM +0100, Johan Hovold wrote:
> On Wed, Dec 11, 2024 at 08:23:15PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Dec 11, 2024 at 03:17:22PM +0100, Johan Hovold wrote:
> 
> > > I just hit the following modem related error on reboot of the x1e80100
> > > CRD for the second time with 6.13-rc2:
> > > 
> > > 	[  138.348724] shutdown[1]: Rebooting.
> > >         [  138.545683] arm-smmu 3da0000.iommu: disabling translation
> > >         [  138.582505] mhi mhi0: Resuming from non M3 state (SYS ERROR)
> > >         [  138.588516] mhi-pci-generic 0005:01:00.0: failed to resume device: -22
> > >         [  138.595375] mhi-pci-generic 0005:01:00.0: device recovery started
> > >         [  138.603841] wwan wwan0: port wwan0qcdm0 disconnected
> > >         [  138.609508] wwan wwan0: port wwan0mbim0 disconnected
> > >         [  138.615137] wwan wwan0: port wwan0qmi0 disconnected
> > >         [  138.702604] mhi mhi0: Requested to power ON
> > >         [  139.027494] mhi mhi0: Power on setup success
> > >         [  139.027640] mhi mhi0: Wait for device to enter SBL or Mission mode
> > > 
> > > and then the machine hangs.
> > > 
> > > Do you know if there are any changes since 6.12 that could cause this?
> > 
> > Only 3 changes went in for 6.13-rc1 and they shouldn't cause any issues. One
> > caused the regression with pcim_iomap_region(), but you submitted a fix for
> > that and other two were trivial.
> 
> Ok, thanks.
> 
> > From the log, 'mhi mhi0: Resuming from non M3 state (SYS ERROR)' indicates that
> > the firmware got crashed while resuming. So maybe you should check with ath12k
> > folks.
> 
> This is the modem so I don't think the ath12k wifi folks are to blame
> here.
> 

Ah, even after these years I always confuse between WLAN and WWAN :)

> It may be an older, existing issue that started triggering due to
> changes in timing or something.
>

Could be. But the issue seems to be stemming from the modem crash while exiting
M3. You can try removing the modem autosuspend by skipping the if condition
block:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/mhi/host/pci_generic.c?h=v6.13-rc1#n1184

If you no longer see the crash, then the issue might be with modem not coping
up with autosuspend. If you still see the crash, then something else going wrong
during reboot/power off.

> Is there anything you can do on the mhi side to prevent it from blocking
> reboot/power off?
> 

It should not block the reboot/power off forever. There is a timeout waiting for
SBL/Mission mode and the max time is 24s (depending on the modem). Can you share
the modem VID:PID?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

