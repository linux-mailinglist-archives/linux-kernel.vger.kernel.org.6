Return-Path: <linux-kernel+bounces-247125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1553B92CB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332E91C22B16
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F348D8172D;
	Wed, 10 Jul 2024 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjWUMoYx"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74851B86FF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720594874; cv=none; b=Q18gyq2bAlnBCHm9xyeYP0n4XQho1wk5DX0vqg2uF5zU3vrHFJR7d3rvawNNHyI9+u0SBylI00MUJWoBngeyZoajtGrrNbzjG/2cXPDov4Q9WRPpYTJojoDEQU90EY3+7jt1qrZ3vi4nOfUFfvE3XkdutVAGfy/Arz4e1SLgqLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720594874; c=relaxed/simple;
	bh=0g/tbN5BOdpCUSIAXDAOLNWIFD9iOc+XZRuFSDfjuIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXGyoyvoGvYWIL11jvcmlMvwx+buny+PPX49NwC9NfXD0/el04V2q9+O13bvWr9V+ob4YZt8gBJ15ZtcYyJ3zOuC84bPaPqIoiA8x8Sg2p/aWN3YpHhqgDgcCOYaF4eMo70OcaaNSWIr0XgK5r0tCR/fVFU0D3h8SfJ321AJgEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjWUMoYx; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5c66797e197so77806eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720594872; x=1721199672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0g/tbN5BOdpCUSIAXDAOLNWIFD9iOc+XZRuFSDfjuIw=;
        b=XjWUMoYxVPrx3K9j+HPB2b8Z7drUJDoUKM5QztmmswUJjMDnv4B3veFhVYm2ckTYfB
         KRx5qTwu+FP54r5AGwu4jS8gNpjBqVxEHd1xsU7bmZg7xv2BCcoXwlQx9uel2fqhahBn
         dC/LNy+dTeDk1yVouIDH4TqrP5dqa1ecNVZIaRv3WkgzrrtxFVWQHHqMsGpI5iA1YEn9
         ckCcD5a2oF2471+DRSDenyMnTWL6jln5HBqZQbmkvuI3DbNHbH6x/UXju1aTqD+LoAA2
         aB0yB5vzn0KYGT16fLcXK4c3An5sjQKVj26GCWG5WZy5aJ8XuNyLO/O6O4bPlHceVnje
         hq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720594872; x=1721199672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0g/tbN5BOdpCUSIAXDAOLNWIFD9iOc+XZRuFSDfjuIw=;
        b=QXJcIOi4phi/WeKKiXVaJthhxyTETjsuSc94mYI/x2GjIhhzw8qBugW9ypTgKu9FYV
         sxooZ6WoltedeYMcNRy3c5EV3HG1+cr9k97mr9vvP3H83xBpij28p/PSOKUr+PsZhZQr
         jo7AFDsiCYHfd37Bd9kaBJ+ufuXA4C2E14h7keD+K/JvfxoeBI6otcuRBrzNmuIR0U3M
         xCi/duU4nMy2cQNmpYdC4NWNV+6crMC+QjIj+48n67u120mqPqyFMgjE3G0UGp2bIR+T
         4SP1I6O3ATQHTnW/DuWrngmJzhNF7dYj2WItm7L37v4ChzAs9KydBXDs8DEFMfQ78ekR
         jv7g==
X-Forwarded-Encrypted: i=1; AJvYcCVkfcyq9LFEdE81rP7cmHg/30NJW7+H8acOUJas3SYRbyUVI7tKbHG+jfUJ8eqtwCRgC94H5dO0dP+J/MmzLjChfee6ShpW+HDpSMif
X-Gm-Message-State: AOJu0Yz7EYRI5JixjsS4gIS9slZA4wexwcANLr8SHJ42m+bWUxDXsHZ6
	1xHWbgOrqkfzuUwAb2Z5tIS3Z4HHoQyfX9X9+1EwTrRTCSOG+1/qld9RmcVhQQUQg9SYVT2egPG
	h7/QIpPy52pvVzOZzidFmgaEaeK7qBPQiaoCL5Jyj
X-Google-Smtp-Source: AGHT+IFx2BRvjtFXqoSg1+PvMMQRdSDlmRVGe6OqPGstIMZOnCPopgGEXsf8wsKHq0X3hpEtGSjUw3Isc0L2F8oBYBc=
X-Received: by 2002:a05:6820:2c05:b0:5c7:b587:40a7 with SMTP id
 006d021491bc7-5c7b58743aemr806363eaf.1.1720594871696; Wed, 10 Jul 2024
 00:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com>
 <CADnq5_PDxJ8O1JUQ9RBYRFB9G1WZJos05ZAM4jUKuPBwPxjNkA@mail.gmail.com>
 <CABXGCsNN9LwHc2x2AAEH=5UNwpvkWkBqRYz3OP8MZ6Woy+HDXA@mail.gmail.com>
 <b6c440ca-e63e-429b-af41-5f27d4b8b2a2@leemhuis.info> <CABXGCsNoFfMn7LaqqFgEPg-ECyUPN=f=SXVrFi=GZk6c69-Gqw@mail.gmail.com>
 <CADnq5_PDSkr4hOHJmb1J30UC0a7sXsm5-TPkEmjzffMK_A+7ug@mail.gmail.com>
 <ea465a40-f673-42b1-8b1c-a2efb20cd562@amd.com> <CABXGCsPyrUEqDq2gbr4VLw5ncd9cKoCZ9nOr2SRfg8Lh=9H5Kg@mail.gmail.com>
 <2915a8c4-ebac-4dae-8f09-32a5b4d9aeda@amd.com>
In-Reply-To: <2915a8c4-ebac-4dae-8f09-32a5b4d9aeda@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 10 Jul 2024 12:01:00 +0500
Message-ID: <CABXGCsPuRViSd_WeOciLKcQ4hjYxJ7e3i7LomwsUMzd0a+zvBw@mail.gmail.com>
Subject: Re: 6.10/bisected/regression - commits bc87d666c05 and 6d4279cb99ac
 cause appearing green flashing bar on top of screen on Radeon 6900XT and 120Hz
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 7:48=E2=80=AFPM Rodrigo Siqueira Jordao
<Rodrigo.Siqueira@amd.com> wrote:
> Hi,
>
> I also tried it with 6900XT. I got the same results on my side.

This is weird.

> Anyway, I could not reproduce the issue with the below components. I may
> be missing something that will trigger this bug; in this sense, could
> you describe the following:
> - The display resolution and refresh rate.

3840x2160 and 120Hz
At 60Hz issue not reproduced.

> - Are you able to reproduce this issue with DP and HDMI?

My TV, an OLED LG C3, has only an HDMI 2.1 port.

> - Could you provide the firmware information: sudo cat
> /sys/kernel/debug/dri/0/amdgpu_firmware_info

> sudo cat /sys/kernel/debug/dri/0/amdgpu_firmware_info
[sudo] password for mikhail:
VCE feature version: 0, firmware version: 0x00000000
UVD feature version: 0, firmware version: 0x00000000
MC feature version: 0, firmware version: 0x00000000
ME feature version: 38, firmware version: 0x0000000e
PFP feature version: 38, firmware version: 0x0000000e
CE feature version: 38, firmware version: 0x00000003
RLC feature version: 1, firmware version: 0x0000001f
RLC SRLC feature version: 1, firmware version: 0x00000001
RLC SRLG feature version: 1, firmware version: 0x00000001
RLC SRLS feature version: 1, firmware version: 0x00000001
RLCP feature version: 0, firmware version: 0x00000000
RLCV feature version: 0, firmware version: 0x00000000
MEC feature version: 38, firmware version: 0x00000015
MEC2 feature version: 38, firmware version: 0x00000015
IMU feature version: 0, firmware version: 0x00000000
SOS feature version: 0, firmware version: 0x00000000
ASD feature version: 553648344, firmware version: 0x210000d8
TA XGMI feature version: 0x00000000, firmware version: 0x00000000
TA RAS feature version: 0x00000000, firmware version: 0x00000000
TA HDCP feature version: 0x00000000, firmware version: 0x1700003f
TA DTM feature version: 0x00000000, firmware version: 0x12000016
TA RAP feature version: 0x00000000, firmware version: 0x00000000
TA SECUREDISPLAY feature version: 0x00000000, firmware version: 0x00000000
SMC feature version: 0, program: 0, firmware version: 0x00544fdf (84.79.223=
)
SDMA0 feature version: 52, firmware version: 0x00000009
VCN feature version: 0, firmware version: 0x0311f002
DMCU feature version: 0, firmware version: 0x00000000
DMCUB feature version: 0, firmware version: 0x05000f00
TOC feature version: 0, firmware version: 0x00000007
MES_KIQ feature version: 0, firmware version: 0x00000000
MES feature version: 0, firmware version: 0x00000000
VPE feature version: 0, firmware version: 0x00000000
VBIOS version: 102-RAPHAEL-008

> Also, could you conduct the below tests and report the results:
>
> - Test 1: Just revert the fallback patch (drm/amd/display: Add fallback
> configuration for set DRR in DCN10) and see if it solves the issue.

It's not enough.
I checked revert commit bc87d666c05 on top of 34afb82a3c67.

> - Test 2: Try the latest amd-staging-drm-next
> (https://gitlab.freedesktop.org/agd5f/linux) and see if the issue is gone=
.

I checked commit 7cef45b1347a in the amd-staging-drm-next branch. Same here=
.

> - Test 3: In the kernel that you see the issue, could you install the
> latest firmware and see if it fix the issue? Check:
> https://gitlab.freedesktop.org/drm/firmware P.S.: Don't forget to update
> the initramfs or something similar in your system.

Is this any sense? Fedora Rawhide always ships with the latest kernel
and firmware.

--=20
Best Regards,
Mike Gavrilov.

