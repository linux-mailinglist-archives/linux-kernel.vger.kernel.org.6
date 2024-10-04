Return-Path: <linux-kernel+bounces-350270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89262990290
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BCD281765
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0164015AAB1;
	Fri,  4 Oct 2024 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFx1/JX9"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C16A148316
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042921; cv=none; b=TG/V21SON41gg/yVXzKZwfD3vFMpHrSloGskYVMFN8H9YcTjBtquzGU/DqRVnsD2W6ttcOmo/0sLGXqeU1+j/a/O9LQcJWrpZ2kvVdg/bYSQgO56KwatZRPfttjw4n8ChIJ6Vl2ZQXLO4X1Vxha1xJCZ+vcoAd3cuW1fZ5hdqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042921; c=relaxed/simple;
	bh=lW4WYgkssxVBDl6uNjKBsszdRCDAxXm8ViV/nvdlr1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAlSGK2wo51b9Ldd9fh2+dYyjZoo1ExMgz2Joa0PRKWZOBAkvpML11i1xxw4ZErKaTIb8BbXc830jqswgmFjIM0lSUvp4+YTXj3RVdljTbCaHRyFDEJtcFWxOtXbiMry+rG5AJrqiastllsjn9sIb7/PrXyOYRfSDuNWsBEmGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fFx1/JX9; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e25d15846baso1864224276.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728042918; x=1728647718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTaeamx6DcDUAZ9BpfuVVEl85CSz9b541yZH8Gp9Gkk=;
        b=fFx1/JX9eoe+64XPdM6zVjGuUXYuOUV0QwDSk9hGDXcYo15L2V3G1Gj0yH1f/pwVXW
         ranYZL9P5RMNObO3Jcm54/q+DJc8dc9kE6RsCb6ScBabFOEnLJzmkxv3q5DrWCsVaukE
         Jom/E1KjCqZJnq25xvi0Y0egkvCh9kSnKJsmOqNP3ETBi1YEy6UYq4/BrB47Xx0i6BnO
         K3XugRyEEjFYfSkvxiowsmEB+XiGuvK/vCxn6zXiFrx8yv5fq6vhcR16HVaPgg6MfnY9
         DvRCQ3Ut/nFZ7Rn6eV40UcZgtu23pMsqMYZCeYgaqavEKup2oYntn/OXCTX4e2bHllz+
         WwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728042918; x=1728647718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTaeamx6DcDUAZ9BpfuVVEl85CSz9b541yZH8Gp9Gkk=;
        b=J9O8hIfAWsWhorGh5R/pM4Gin43rxwBr06zjxIKzVf0XQHmtHqhsXy3vWYC3aM4Q9e
         l571Wd+uQWPpFx0m7Id4lRgU6XrE5rVCe2t1+zkdprnzh0ZOiUoK2dCLnmRdfneRGFoA
         whcQI+af5QiaG3WBOYXSIncYt0D3SmDFSU30qDQXzO+AKvTifJaJbbkDTn/4mQQwqJu6
         REnvSO1u6Zt/eAv+fi0Bp1Ec1shAVBR/E9iNAVu/VBMkCxAYjvBisq9O3/tEpHnfAshb
         kGYdkqIp8Xo8x6env4HkP0IeFZSFKG5aG25ctGO9Wv8WVLZ1hEWJ8YEGxSzGOllnkZwB
         rMVg==
X-Forwarded-Encrypted: i=1; AJvYcCW0gH5uVx9JcQiLmvKOrZrtI9DdmNvWme5fFluZZVs+dKy8BC5Clsq1SzFMSt45aBQ87yTv6Aj79hQTiUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5/ah7PmlYikXrvOqkkRsX9xFvRnnwFl8nE1UK4BaCBuNpmCJ
	xXPlRfShVPk2NxYV79CptqSSbqL1fDg5KOWmOqcuW9aAvHwX3gjDOoHX9ErdG32Bp8Z2p5CX1I4
	1f2g/Lt8pFAcmzkTUXtEanHl+ve695mIBZCUB+w==
X-Google-Smtp-Source: AGHT+IFOHbZCszBR3ogOu1f/JhER/gzMihu7gc5SjpNsnu2X6RNavWmU6/W2zmAtwXas+DdPqNCvqMeG+iyhpAHKMzo=
X-Received: by 2002:a05:6902:11ce:b0:e26:bea:9580 with SMTP id
 3f1490d57ef6-e28939513f8mr1470314276.53.1728042918520; Fri, 04 Oct 2024
 04:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913102836.6144-1-victorshihgli@gmail.com>
 <dfde5172-c1b7-4c22-94ab-87a1d5d5ee9d@intel.com> <CAK00qKAOd9_bSGs8sxaZjOjkpw3ge-jzXdmkZMcFmm=eg70KVQ@mail.gmail.com>
In-Reply-To: <CAK00qKAOd9_bSGs8sxaZjOjkpw3ge-jzXdmkZMcFmm=eg70KVQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 4 Oct 2024 13:54:42 +0200
Message-ID: <CAPDyKFqrSS=AhcQxVET9V_SN008Cu=n5PuBF70_yBt2CDjMK-w@mail.gmail.com>
Subject: Re: [PATCH V22 00/22] Add support UHS-II for GL9755 and GL9767
To: Victor Shih <victorshihgli@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Sept 2024 at 12:47, Victor Shih <victorshihgli@gmail.com> wrote:
>
> Hi, Ulf
>
> Sorry for bothering you.
> In this series of patches I have reached the final comments of the sdhci =
parts.
> Please help review this series of patches.
> I hope to get your feedback to confirm whether there are any needs to
> be modified.
> If you already have a closer look at a paragraph in the series, could
> you let me know your opinions first.
> I look forward to your reply.

Hi Victor,

Just wanted to let you know that I have re-started the review. I am
looking at patch7 right now. Hopefully I should be able to complete
the review later today or on Monday.

Kind regards
Uffe


>
> Thanks, Victor Shih
>
> On Wed, Sep 18, 2024 at 12:47=E2=80=AFPM Adrian Hunter <adrian.hunter@int=
el.com> wrote:
> >
> > On 13/09/24 13:28, Victor Shih wrote:
> > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > >
> > > Summary
> > > =3D=3D=3D=3D=3D=3D=3D
> > > These patches[1] support UHS-II and fix GL9755 and GL9767
> > > UHS-II compatibility.
> > >
> > > About UHS-II, roughly deal with the following three parts:
> > > 1) A UHS-II detection and initialization:
> > > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> > >   Sequence[2]).
> > > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequen=
ce
> > >   [2]).
> > > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is inclu=
de
> > >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> > >   Setting Register Setup Sequence.
> > >
> > > 2) Send Legacy SD command through SD-TRAN
> > > - Encapsulated SD packets are defined in SD-TRAN in order to ensure L=
egacy
> > >   SD compatibility and preserve Legacy SD infrastructures (Section 7.=
1.1
> > >   Packet Types and Format Overview[3]).
> > > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UH=
S-II
> > >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2=
]).
> > >
> > > 3) UHS-II Interrupt
> > > - Except for UHS-II error interrupts, most interrupts share the origi=
nal
> > >   interrupt registers.
> > >
> > > Patch structure
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > patch#1-#7:  for core
> > > patch#8-#20: for sdhci
> > > patch#21:    for GL9755
> > > patch#22:    for GL9767
> > >
> > > Tests
> > > =3D=3D=3D=3D=3D
> > > Ran 'dd' command to evaluate the performance 3 times:
> > > (SanDisk UHS-II card on GL9755 controller)
> > >                              Read    Write
> > > UHS-II disabled (UHS-I): 85.5MB/s 56.3MB/s
> > > UHS-II enabled         :  182MB/s 75.5MB/s
> > >                              Read    Write
> > > UHS-II disabled (UHS-I): 86.7MB/s 52.1MB/s
> > > UHS-II enabled         :  179MB/s 77.6MB/s
> > >                              Read    Write
> > > UHS-II disabled (UHS-I): 85.8MB/s 49.1MB/s
> > > UHS-II enabled         :  181MB/s 89.8MB/s
> > > (SanDisk UHS-II card on GL9767 controller)
> > >                              Read    Write
> > > UHS-II disabled (UHS-I): 81.9MB/s 49.0MB/s
> > > UHS-II enabled         :  186MB/s 87.9MB/s
> > >                              Read    Write
> > > UHS-II disabled (UHS-I): 80.8MB/s 53.5MB/s
> > > UHS-II enabled         :  192MB/s 87.3MB/s
> > >                              Read    Write
> > > UHS-II disabled (UHS-I): 81.0MB/s 53.9MB/s
> > > UHS-II enabled         :  199MB/s 73.6MB/s
> > >
> > > Test command
> > > =3D=3D=3D=3D=3D
> > > Read: dd if=3D/dev/mmcxxx of=3D/dev/null bs=3D4096k count=3D2000 ifla=
g=3Ddirect
> > > Write:dd if=3D/dev/zero of=3D/dev/mmcxxx bs=3D4096k count=3D2000 ofla=
g=3Ddirect
> > >
> > > Changes in v22 (September. 13, 2024)
> > > * Rebase on latest mmc/next.
> > > * Adjust patch order to avoid defined but nt used warnings:
> > >   v21 patch#18 to v22 patch#14.
> > >   v21 patch#14 to v22 patch#15.
> > >   v21 patch#15 to v22 patch#16.
> > >   v21 patch#16 to v22 patch#18.
> > > * Patch#14: Remove unnecessary code to avoid defined but not used war=
nings.
> > > * Patch#15: Add necessary code to avoid defined but not used warnings=
.
> > > * Patch#16: Remove unnecessary code to avoid defined but not used war=
nings.
> > >             Modify commit message.
> > > * Patch#17: Remove unnecessary code to avoid defined but not used war=
nings.
> > > * Patch#18: Add necessary code to avoid defined but not used warnings=
.
> >
> > For SDHCI:
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >
> >

