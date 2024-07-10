Return-Path: <linux-kernel+bounces-247127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E6392CB93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130FC1C22657
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C93580623;
	Wed, 10 Jul 2024 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl2opXLe"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F3C7404F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595023; cv=none; b=bp/u6HtgX5Nblc0t2mDUYeRp4L2Xc8h6qkZPGdTwibHrn1SJSkXvgoTgN67npMXm7ENJAsM3VBc7yhwY9FBs7Q7GrcmGfylsTsNBnAJXiRyNSrCCR3J3mP3m4qJyoMkDYOqSC1Bvc1zXUn2zZqvBY4/mA2oU33/CMHIvanFsyp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595023; c=relaxed/simple;
	bh=p3BXcqkjeuhZC3iXU7hUkrYXvkUrW95a4kWlrA8Wcs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plH/vTvZBEQ5hzx6yZKUh/lefujy8XwaJ27zP61nudkajdGPsHyQptdvmpSQ4acvkxiYxZJXLFo8hpCwIIa2Rjk4Wy/JeYOLB7ScOmTO32psC+T6zLQZubDTYfNRmpSaUs/kn6NmH0+VVUCgNe0RPT6RQz84qENd/7HM5AKjA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl2opXLe; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44932306263so656951cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720595021; x=1721199821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3BXcqkjeuhZC3iXU7hUkrYXvkUrW95a4kWlrA8Wcs0=;
        b=jl2opXLedZvUPsyJwLNPE4W8tp72hs2HbplEcRQ0y9zYywSFyp4x1nFCzAoe6BOiJK
         YeLoLHjUZwHhhaHi6dHDk+dHIn/eC5KI/J/ID0f24xwJkE6SjbXCqjJxBTjvOQSTQlw6
         1Dx6dZm3imvwgKwtttwhylTjluX3Pr25bCKuj52TQLgcbTOBCLruLpGwh5aXyS/LF8II
         ITg3tDrav7d00rll5yS+advHx/8O2ltLb34jW3MmwshGiXmn9/SZGIhi9pxsML8/BHeA
         XvqsvirMP0ArmfOtiwPvev56izpCHCfPe+s7Aal6ATK5zhjDLSf7VsH5nvWcX65sZVle
         KqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720595021; x=1721199821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3BXcqkjeuhZC3iXU7hUkrYXvkUrW95a4kWlrA8Wcs0=;
        b=UN6bkdXMDQGrNbkY1KpcP46Ig3KHt6SjYBuxYonI1ynv+eo5PMVXDSwoOT8W2h4GIr
         t4Fqrlcr3XTWefZ1zA/JVd+ITBH2CQLfyt9pThqMKMGXnyd6bW0ItkBjmlI/ZYpnExOs
         13WTMh7xjmx6EWunthx0yVSLlrkA+8ns/o5Hsx1/9K/0L236ACh2VOd5DhO4NbI7PIAz
         m1jkXWxrZXIuSLJRheySVEiR6cYyxJDV9IDiwOI3jEN0eG4gMaZlOYSVLV5LVygUqq4A
         /NWYpojBrg42JHnyj8DrPfUFA8hKWHtLB6wALYpaaiL3nZsPHRSt+sdCBpmA6styH0DK
         tvVA==
X-Forwarded-Encrypted: i=1; AJvYcCXnW9dZX1v9A/1Spq9q/QysknWNeMAKtARIIvRpapvoLq0gNSDGECDL+AX/f5dETJ4Yku1YwLNJB6d0qFNQLgafr9oyu39406aRMPRk
X-Gm-Message-State: AOJu0YyaZX/1HLtukSKClsfVlOvsOtMjjnuTS3tmbOmfESZtUcJKf6BM
	+vsc0/2cXSborNMBKW6746/CMSAUUGMZ7wxQywl7kmO0INOeEBQ6DihDvkg8HTGpjkb6RPuZjGx
	VAWesSlJP2spXQ/jU92TqZwHzE/Q=
X-Google-Smtp-Source: AGHT+IGoTFtKJW2jS7acG2Oi3QXPtRAexd48mCUJWxKk2iudODVVH1vr9AaGCM32ITeGQ3dDowuFjyKpv2ALtupjw7I=
X-Received: by 2002:a05:6214:514d:b0:6b2:b13d:5b75 with SMTP id
 6a1803df08f44-6b61bc801a7mr50698376d6.1.1720595021031; Wed, 10 Jul 2024
 00:03:41 -0700 (PDT)
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
 <2915a8c4-ebac-4dae-8f09-32a5b4d9aeda@amd.com> <CABXGCsPuRViSd_WeOciLKcQ4hjYxJ7e3i7LomwsUMzd0a+zvBw@mail.gmail.com>
In-Reply-To: <CABXGCsPuRViSd_WeOciLKcQ4hjYxJ7e3i7LomwsUMzd0a+zvBw@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 10 Jul 2024 12:03:30 +0500
Message-ID: <CABXGCsOsfP2SToiDhRAS51nPJ+Qr2v7B3Kjr+yVeP4G7zFZpMA@mail.gmail.com>
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

On Wed, Jul 10, 2024 at 12:01=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Tue, Jul 9, 2024 at 7:48=E2=80=AFPM Rodrigo Siqueira Jordao
> <Rodrigo.Siqueira@amd.com> wrote:
> > Hi,
> >
> > I also tried it with 6900XT. I got the same results on my side.
>
> This is weird.
>
> > Anyway, I could not reproduce the issue with the below components. I ma=
y
> > be missing something that will trigger this bug; in this sense, could
> > you describe the following:
> > - The display resolution and refresh rate.
>
> 3840x2160 and 120Hz
> At 60Hz issue not reproduced.
>
> > - Are you able to reproduce this issue with DP and HDMI?
>
> My TV, an OLED LG C3, has only an HDMI 2.1 port.
>
> > - Could you provide the firmware information: sudo cat
> > /sys/kernel/debug/dri/0/amdgpu_firmware_info
>
> > sudo cat /sys/kernel/debug/dri/0/amdgpu_firmware_info
> [sudo] password for mikhail:
> VCE feature version: 0, firmware version: 0x00000000
> UVD feature version: 0, firmware version: 0x00000000
> MC feature version: 0, firmware version: 0x00000000
> ME feature version: 38, firmware version: 0x0000000e
> PFP feature version: 38, firmware version: 0x0000000e
> CE feature version: 38, firmware version: 0x00000003
> RLC feature version: 1, firmware version: 0x0000001f
> RLC SRLC feature version: 1, firmware version: 0x00000001
> RLC SRLG feature version: 1, firmware version: 0x00000001
> RLC SRLS feature version: 1, firmware version: 0x00000001
> RLCP feature version: 0, firmware version: 0x00000000
> RLCV feature version: 0, firmware version: 0x00000000
> MEC feature version: 38, firmware version: 0x00000015
> MEC2 feature version: 38, firmware version: 0x00000015
> IMU feature version: 0, firmware version: 0x00000000
> SOS feature version: 0, firmware version: 0x00000000
> ASD feature version: 553648344, firmware version: 0x210000d8
> TA XGMI feature version: 0x00000000, firmware version: 0x00000000
> TA RAS feature version: 0x00000000, firmware version: 0x00000000
> TA HDCP feature version: 0x00000000, firmware version: 0x1700003f
> TA DTM feature version: 0x00000000, firmware version: 0x12000016
> TA RAP feature version: 0x00000000, firmware version: 0x00000000
> TA SECUREDISPLAY feature version: 0x00000000, firmware version: 0x0000000=
0
> SMC feature version: 0, program: 0, firmware version: 0x00544fdf (84.79.2=
23)
> SDMA0 feature version: 52, firmware version: 0x00000009
> VCN feature version: 0, firmware version: 0x0311f002
> DMCU feature version: 0, firmware version: 0x00000000
> DMCUB feature version: 0, firmware version: 0x05000f00
> TOC feature version: 0, firmware version: 0x00000007
> MES_KIQ feature version: 0, firmware version: 0x00000000
> MES feature version: 0, firmware version: 0x00000000
> VPE feature version: 0, firmware version: 0x00000000
> VBIOS version: 102-RAPHAEL-008
>

I forgot to add output for discrete GPU:

> sudo cat /sys/kernel/debug/dri/1/amdgpu_firmware_info
[sudo] password for mikhail:
VCE feature version: 0, firmware version: 0x00000000
UVD feature version: 0, firmware version: 0x00000000
MC feature version: 0, firmware version: 0x00000000
ME feature version: 44, firmware version: 0x00000040
PFP feature version: 44, firmware version: 0x00000062
CE feature version: 44, firmware version: 0x00000025
RLC feature version: 1, firmware version: 0x00000060
RLC SRLC feature version: 0, firmware version: 0x00000000
RLC SRLG feature version: 0, firmware version: 0x00000000
RLC SRLS feature version: 0, firmware version: 0x00000000
RLCP feature version: 0, firmware version: 0x00000000
RLCV feature version: 0, firmware version: 0x00000000
MEC feature version: 44, firmware version: 0x00000076
MEC2 feature version: 44, firmware version: 0x00000076
IMU feature version: 0, firmware version: 0x00000000
SOS feature version: 0, firmware version: 0x00210e64
ASD feature version: 553648345, firmware version: 0x210000d9
TA XGMI feature version: 0x00000000, firmware version: 0x2000000f
TA RAS feature version: 0x00000000, firmware version: 0x1b00013e
TA HDCP feature version: 0x00000000, firmware version: 0x1700003f
TA DTM feature version: 0x00000000, firmware version: 0x12000016
TA RAP feature version: 0x00000000, firmware version: 0x07000016
TA SECUREDISPLAY feature version: 0x00000000, firmware version: 0x00000000
SMC feature version: 0, program: 0, firmware version: 0x003a5a00 (58.90.0)
SDMA0 feature version: 52, firmware version: 0x00000053
SDMA1 feature version: 52, firmware version: 0x00000053
SDMA2 feature version: 52, firmware version: 0x00000053
SDMA3 feature version: 52, firmware version: 0x00000053
VCN feature version: 0, firmware version: 0x0311f002
DMCU feature version: 0, firmware version: 0x00000000
DMCUB feature version: 0, firmware version: 0x02020020
TOC feature version: 0, firmware version: 0x00000000
MES_KIQ feature version: 0, firmware version: 0x00000000
MES feature version: 0, firmware version: 0x00000000
VPE feature version: 0, firmware version: 0x00000000
VBIOS version: 113-D4120100-100


--=20
Best Regards,
Mike Gavrilov.

