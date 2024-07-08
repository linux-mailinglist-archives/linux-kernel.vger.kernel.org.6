Return-Path: <linux-kernel+bounces-244592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C296192A696
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D31E289054
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EA9146013;
	Mon,  8 Jul 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UTvoRLhm"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A41459F5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454323; cv=none; b=s3TLNAEJREPVY/ahp7eDnB8Ppuw9jUmxydc82phH8yRjrTpGq9CO8RfUf6gRjeB6mbg5CcSk8SQvvLqQuwYTIvcu2Y5siqkVNCp8oGfWywBFSZ00rw2S+Zq9cUk/3p/W+qTiB2a81dT7Rj94Wie6U8pROpRJQxIJivF3upgzoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454323; c=relaxed/simple;
	bh=N4zTgmOCGIZpptJHZvQ8M7KBia+dpv2NLYqoRSx/XWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObDoMjeAowZJwocJ5WdoezLwUnQc6mu3WUlRM4M6tbCmSpnq0ec9q4ueRSo3VgFCnYuVdYjAOdVH00pOlg00A24e+j+H5CFmz3SbP/FBvk8LWqfeEDTakzI8UzONdxVumxCPFKftoqEdfcgddrD/haTyNKe8oNj3qwCwpJ9tzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UTvoRLhm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c7fa0c9a8cso2285055a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720454321; x=1721059121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4zTgmOCGIZpptJHZvQ8M7KBia+dpv2NLYqoRSx/XWI=;
        b=UTvoRLhmeabXH4PhdOqlXYm1QQ27y2e78+hVbczYQDdEkMid+140yz+Ped/V1D+Og4
         XZWhXDgGSC5AN4rMvKdS3ip73dIcRQ4t7IVrE+o4rFLhFyOL13DBXdPPN4UNpSDEQ+RN
         fNqKVTDneKY9SzA1isjR2jwVia6z3xtvMZLKG2U6RPsLlGS9y72LuRzzXtXX+YoC/UFD
         3+ROQAuQPk7eVfbx28ujhoeD1JB6D+kivLrCY92rk2oVL757AD5cpH7jqzBevOqwPADk
         HBdWndAVudRrw3cWY5jKRZ09BKKuaYGV/Cht2dQLGW3FnbdPynj/JFpe2OoThUhBfrQV
         uEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720454321; x=1721059121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4zTgmOCGIZpptJHZvQ8M7KBia+dpv2NLYqoRSx/XWI=;
        b=NVpdKWdwJE7lJGzkfa7xmoQWyoq41fMlKRdCCZf71euACikfkebZiy1cXNq/nfF3fZ
         z58M0/NoUgLNG7o18rQWbeGmfspOscj2W3KyPPPbBqjYJF/nLBkBs/79pvpIFTppU1at
         VtCWwuqCdFt9XWwHZnAy9mBmCqOiNVwJMknJGGmeJkARsKzmVSRrjikGXe/IQFuOFVF1
         r+JpTAvtGmPdezayrHSEedmX+MC0ZAoBgu9ThhSoHg8m7squ+mNSgnT3SulZ27g81drC
         5w/YdCQU94/7USiqu/ey8LZTcpS0ghzRc9wjGJ9fAOKjNx2FWvnq1poSpcq/bnO8O6T2
         4KXw==
X-Forwarded-Encrypted: i=1; AJvYcCWbOHc0xIIKk464Vm1B+SyfxDpo21JM9Xr1rkUNbUwFotLnzoQ3dbaDrzC8L4hwKhQi0XLBXuTK5arhd/ZK4dZ1m4QD4G/3IMkNXHrl
X-Gm-Message-State: AOJu0Yxwo4SxEQm/EFV40UsMEIKC25TsYiMH7srLZIEdnPGHlMhwiMey
	O4BAa9xpIuDTNx+OBI4DkZ/8zfFiwpvcMXcDDUB1WSoENI0RJsTU6jjxT6UtPw8IdbUc4rxyzW/
	gE+9M4RnQ175txQzHQa+tPbg3Be7mmXrOlZZEGg==
X-Google-Smtp-Source: AGHT+IF3ZkVbj5QqPIPvybC5WDYIk62uSwnD5iCVAm2deAYTr18HzSAoct0EbVr0+z5tR7mNkI6qcJ9NrnOClyo7ftU=
X-Received: by 2002:a17:90b:2342:b0:2c9:a220:bab1 with SMTP id
 98e67ed59e1d1-2ca35c30b46mr117527a91.20.1720454321046; Mon, 08 Jul 2024
 08:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707183829.41519-1-spasswolf@web.de> <Zoriz1XDMiGX_Gr5@wunner.de>
 <20240708003730.GA586698@rocinante> <CACMJSevHmnuDk8hpK8W+R7icySmNF8nT1T9+dJDE_KMd4CbGNg@mail.gmail.com>
 <20240708083317.GA3715331@rocinante> <6e57dbc0-f47a-464e-af6b-abd45c450dc6@kernel.org>
 <CACMJSetAKtPp_Gua2S7m_+aC-f9HSUyfF1YoHUPdtcibLtQxpA@mail.gmail.com>
 <20240708154401.GD5745@thinkpad> <664619a9-c80f-4f81-b302-b9c5258b5e0e@kernel.org>
 <CAMRc=Mf2pE5JVHzcntO5b+5so_=ekuHGzrY=xJpKatURJFpGZA@mail.gmail.com> <8838b5c3-0c51-42f6-9842-186139822be7@kernel.org>
In-Reply-To: <8838b5c3-0c51-42f6-9842-186139822be7@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 8 Jul 2024 17:58:28 +0200
Message-ID: <CAMRc=MdHSsctXYor2ycWqRJHCUciweRTie_TjW9h0yfN7wZhOA@mail.gmail.com>
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
To: Mario Limonciello <superm1@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lukas Wunner <lukas@wunner.de>, Bert Karwatzki <spasswolf@web.de>, caleb.connolly@linaro.org, 
	bhelgaas@google.com, amit.pundir@linaro.org, neil.armstrong@linaro.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Praveenkumar Patil <PraveenKumar.Patil@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 5:53=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 7/8/2024 10:49, Bartosz Golaszewski wrote:
>
> >
> > If you have CONFIG_OF enabled then of_platform_populate() will go the
> > normal path and actually try to populate sub-nodes of the host bridge
> > node. If there are no OF nodes (not a device-tree system) then it will
> > fail.
> >
> > Bart
>
> So how about keep both patches then?

No, it doesn't make sense. If CONFIG_OF is enabled then -ENODEV is a
valid error. I was wrong to apply the previous patch as it would lead
to hiding actual errors on OF-enabled systems.

Bart

