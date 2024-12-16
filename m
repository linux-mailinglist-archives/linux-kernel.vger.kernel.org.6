Return-Path: <linux-kernel+bounces-447679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6F79F35ED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0B2163168
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF87176ADE;
	Mon, 16 Dec 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vjLWMXwH"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31F1714B7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366361; cv=none; b=sEiLdgSe5xgcmE29ONhXnnAKoi+1UTCI1t6rXK9IKHSI8iJTiN5nZVSLgybDZ1nzTYh66A/Wj17FK5jkHAkCx74XiHe500DJNc6IFkcxvNU+KsZk8z81TqfDVhIMbQUM2xBQMD4PbpCuKycJZL+IBt3ZkkAQi/SRWv06qegTsvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366361; c=relaxed/simple;
	bh=xWFsKNAzWIYsEzv8m19Krk9bD4aUjQyWMIRz8F756aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ab3rrKWHMCy7OxOAlT03bJNVHbEIEtN0dTShja2lpNrIknKjJHNDvO6Or5qmitumwlMHbogdCefA1r9xx90TGgn38aSG2R2V3VMP6Zny4hHMZ9bWWVmuiAtGurMkxIcSF5U8L7w5wO4IQjQFs/Mpvow8fWA238nyC1cVdu1Kspw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vjLWMXwH; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-29645a83b1bso2171341fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734366359; x=1734971159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bl+mV4pA+wZGpPLHN1VIPTBmdHvvhMJxM/LXXNqpGDA=;
        b=vjLWMXwHS94beVrijitd3ywn2Ojv0hTB9aGde40c1V1xjh+5hsuN1Vs7j+W1A6pens
         4qzJy7RkfIrruNaXT7Wf4lihrvzH/1E6HS1nWdJ0zeGBdC/A2Kl6UQ0kyNCG+K/vbDKs
         MqjvhH4z3pVl2N1BIAg0TgUMzqoo/liWEwvXItXHdT42tx4TAhupNsECiR1c+dDRJgrY
         ZBRZixzGldTqNOUfAKXaC7BOceC40+Gb5YfANsOrfzGxOpCL1Y3Z+BFwOl1CCoyh2OF0
         4sR9R55In64s6QwUWSHAJQlQQpvBVX9MeFFzEf3qx7+bfyogy6xQNd+FiO72KyhLOurj
         o85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734366359; x=1734971159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bl+mV4pA+wZGpPLHN1VIPTBmdHvvhMJxM/LXXNqpGDA=;
        b=uAFzM1bnYETSW/LXKnWrCbi04Wp+hPsIAxicapTuTnzVfIP6k11kYHV78e5LNsL9MA
         67sv9IMlsqnGTHZzhQqZ8eh9BG7pntZgX6IArjmvJW/W47Pdz5GkGXVz3SUSLTfq695J
         X/4GLS3+3tzXVZggsCTzk0ECHZiiFt15xtv6Jj4mO94pR+TC+KsuIIt6YcXlPb16jf1j
         7so1mYVGua4mzQiB7lGvRoFyfyqJ6HQ5ciLaAg85wPFtjbmAY6hIhfjvTwvSVGOPhSwd
         CsscIXy7i0mu1D5NQGXTQHDfT8JrjG0dAEMiSmkxUkNdI+dpm6zKvO9Y4QBBjpaRL30n
         TqZg==
X-Forwarded-Encrypted: i=1; AJvYcCWplhO064JcZEEGjA4UxE7acFf3HJunbP/XsbBOmUx2X8GlQhaemVH3khTulrplMVDZWGFfs9dFmfZerEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpObCavtiEyKIDqVOHIPnKmVIZlrpYev5nxRqXUoR7hEd6hmcB
	V0YYn6xk/P+vX0LhUKMpH+473rMM9FUzvWjYRT7V62mEJxFj28JuWZ/7CwqioW45Gt4+oexZr4D
	OUd9QRrt4MqT0OrC4O7psApje2ly7t8csPsLg95dwYRHbWOBX4Sw=
X-Gm-Gg: ASbGncv2jzKlu/kEbJ1Eh1JOAvvnGwXIT2+3DJstIQCcbFN6tWvEEGjHDngM53Q61yI
	yPwYfmldogYeLM4zwDG+7UCsk6aP3Xz1DgiLnAg==
X-Google-Smtp-Source: AGHT+IE1DCbPeOMJqQsPfYe1vaaHgBfCx8L5YVUmqKuT1Yn6YV8gl4AcCEnw686dWnL1WF9qvQmW7hZEU+/deVH8Xg8=
X-Received: by 2002:a05:6870:1593:b0:29f:9554:9b94 with SMTP id
 586e51a60fabf-2a788daa113mr145552fac.18.1734366358996; Mon, 16 Dec 2024
 08:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1me8iaK7cwgjL92@hovoldconsulting.com> <20241211145315.vaf7gbapieywcvau@thinkpad>
 <Z1mp3_ArzL-GLr3D@hovoldconsulting.com> <20241216074021.kwoid2747o7piquv@thinkpad>
 <Z2ApCU3DAxKS7Y9k@hovoldconsulting.com> <20241216141303.2zr5klbgua55agkx@thinkpad>
In-Reply-To: <20241216141303.2zr5klbgua55agkx@thinkpad>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Mon, 16 Dec 2024 17:25:23 +0100
Message-ID: <CAMZdPi_0oiTFmgkq0hAhamVq-Noqa+jGDLZ_6yVaqHvcO+N=nA@mail.gmail.com>
Subject: Re: mhi resume failure on reboot with 6.13-rc2
To: Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 15:13, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Dec 16, 2024 at 02:20:09PM +0100, Johan Hovold wrote:
> > On Mon, Dec 16, 2024 at 01:10:21PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Dec 11, 2024 at 04:03:59PM +0100, Johan Hovold wrote:
> > > > On Wed, Dec 11, 2024 at 08:23:15PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Wed, Dec 11, 2024 at 03:17:22PM +0100, Johan Hovold wrote:
> > > >
> > > > > > I just hit the following modem related error on reboot of the x1e80100
> > > > > > CRD for the second time with 6.13-rc2:
> > > > > >
> > > > > >       [  138.348724] shutdown[1]: Rebooting.
> > > > > >         [  138.545683] arm-smmu 3da0000.iommu: disabling translation
> > > > > >         [  138.582505] mhi mhi0: Resuming from non M3 state (SYS ERROR)
> > > > > >         [  138.588516] mhi-pci-generic 0005:01:00.0: failed to resume device: -22
> > > > > >         [  138.595375] mhi-pci-generic 0005:01:00.0: device recovery started
> > > > > >         [  138.603841] wwan wwan0: port wwan0qcdm0 disconnected
> > > > > >         [  138.609508] wwan wwan0: port wwan0mbim0 disconnected
> > > > > >         [  138.615137] wwan wwan0: port wwan0qmi0 disconnected
> > > > > >         [  138.702604] mhi mhi0: Requested to power ON
> > > > > >         [  139.027494] mhi mhi0: Power on setup success
> > > > > >         [  139.027640] mhi mhi0: Wait for device to enter SBL or Mission mode
> > > > > >
> > > > > > and then the machine hangs.
> >
> > > Could be. But the issue seems to be stemming from the modem crash while exiting
> > > M3. You can try removing the modem autosuspend by skipping the if condition
> > > block:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/mhi/host/pci_generic.c?h=v6.13-rc1#n1184
> > >
> > > If you no longer see the crash, then the issue might be with modem not coping
> > > up with autosuspend. If you still see the crash, then something else going wrong
> > > during reboot/power off.
> >
> > I've only hit this issue three times and only since 6.13-rc2. So not
> > sure how useful that sort of experiment would be.
> >
>
> I do not have access to the device. So if you cannot spend time on debugging the
> reason for crash, then I'll have to rely on Qcom to do it (which I've asked
> anyway).
>
> > > > Is there anything you can do on the mhi side to prevent it from blocking
> > > > reboot/power off?
> > >
> > > It should not block the reboot/power off forever. There is a timeout waiting for
> > > SBL/Mission mode and the max time is 24s (depending on the modem). Can you share
> > > the modem VID:PID?
> >
> > I just hit the issue again and can confirm that it does block
> > reboot/shutdown forever (I've been waiting for 20 minutes now).
> >
>
> Ah, that's bad.
>
> > Judging from a quick look at the code, "Wait for device to enter SBL or
> > Mission mode" is printed by mhi_fw_load_handler(), which in turn is only
> > called from the mhi_pm_st_worker() state machine.
> >
> > I can't seem to find anything that makes sure that the next state is
> > ever reached, so regardless of the cause of the modem fw crash
>
> This code will make sure:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/mhi/host/pm.c?h=v6.13-rc1#n1264
>
> But then it doesn't print the error and returns -ETIMEDOUT to the caller after
> powering down MHI. The caller (mhi_pci_recovery_work), in the case of failure,
> unprepares MHI and starts function level recovery.
>
> > (if
> > that's what it is) the hung reboot appears to be a bug in mhi.
> >
>
> I'm not sure where exactly it got stuck. I've asked Qcom folks to reproduce this
> issue. We will investigate and hopefully get back with a fix asap.
>
> > This is with the SDX65 modem in the x1e80100 CRD:
> >
> >       17cb:0308

I have another MHI modem model, but will try to reproduce during the
week, any idea on the bug rate?

Regards,
Loic

