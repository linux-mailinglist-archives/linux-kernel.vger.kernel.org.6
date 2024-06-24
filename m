Return-Path: <linux-kernel+bounces-227934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E019915842
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE7B1C235F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3781645010;
	Mon, 24 Jun 2024 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="i9d/bZ5t"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811A3770C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262034; cv=none; b=JRiE5/wi1iQM0+sYp4KOn8MJCG2RyfvpfSesYHqfxorykiiLLE33eFMSSnDOx6UTNoEGqtod6rWymkcJH9BeIdgfcbemhNL3b7Z84OVM254AZmvuN1LusM2V49LrkN94UKGQ/cR867Um7trMtOsfKn8MALjnkQzTpzXltz/798k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262034; c=relaxed/simple;
	bh=tEHUYCkIIv4oi6rpppXJgZGALfgMl4SEQuChLwjNeho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7jQLJRPr5RsRweNGafhkTCrQTbR3SFD0lOwIWAuKYpXgmVGtprRKcdZTMELpfkT1v3PHh+JQZdbWluYm24Oe4d5ZPPiKtbgyqW5EmNUSGnnNp6e5cy25HEBGM+y44H/xXd/9gKeE7AVyDnM//okfu8AaHc+9BmdEBanmCy8V+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=i9d/bZ5t; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec52fbb50cso26322791fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719262031; x=1719866831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEHUYCkIIv4oi6rpppXJgZGALfgMl4SEQuChLwjNeho=;
        b=i9d/bZ5t/SR5m7oQpK6fTjQj4cvmArO8EM6U3TP0LY4cm9pcdvpnz+m4B0ZnJcaYSg
         j/NrmSKGMPSw8jcbgIpSsk3Jyn9NtZTQ4qe33Y6AELi0X6+vlPmHtXB7oWiSUyAt/XyK
         ipB/B6eFtDzKfS5amEXeNUkWZKQC6qJVMRk6NenL4WOD4vcsvdDU/N9yvUT8yEt4ksjd
         v5V3Y0qtnHNoe4dVvaWp3oFRt4rlzTVCHLopeDFVEbPkWVXwIk4esi+GmYsPTFGEMOn5
         AS2OClsFWDSd0xVA/nZZ9XMLxbJ0UQzZCWU4mqQZTJj+mawhg4jnj/BygOGVtPVt2dc1
         yjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719262031; x=1719866831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEHUYCkIIv4oi6rpppXJgZGALfgMl4SEQuChLwjNeho=;
        b=v1PsOTSQsSKnvrjgoL+VfOvdiX6mY9sItMw3zge/OUPcRotFvFk7cH0RmCAUkFh3Rz
         eajvjdhWlYBIHdLkh3T+h2IXckLKUY0aT1WmC7L4UINBhMlPoxZcQNPt01H6sOnEO1Bn
         wMMit1TjZwliU/+0bSD74KYITbNCiMWIs6caoI3P0AdDXBZdvdqwgeGqiSR+QacY+Wdd
         WWMX97Us1t7+RTjR5rowiQX1Yc+FRYtSANjWWXw5qEVqg6Z8jUqB53Cm/HC4T38Mm3qB
         KB41xhk6Hkk0427HB9Gpli1Ob7fBYKE1uQpG+iPBcB8zn8QGaII7faQm/3DvyVDrE2na
         p+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUE+i/9WpJvbyncWJBmg/Amu88bm3DXaj+3QSjGVJSNdxpLhSzBMsMNt53D9XCX4x7nHdby+WcRin3H5iI23YgraYRnbospVD1HVtA3
X-Gm-Message-State: AOJu0YwaYS6rHr+EMDB8qwaRJB2i+EqoaeVn50u9MuOFX4KM+DazcqJK
	B6z1U+Wxc5vYKlYXXIveziVs+54qwQrphYYIO//qDM16c7SQS4Hf+aai8sj6ApesD6HpXYHPPot
	94ngpJrkQAbJ0HII5FQMO9/534f8Nxr3WlZtwag==
X-Google-Smtp-Source: AGHT+IHL/+BVaSL1JwC3QdV7+dB7p9nj9FusdDMo3xQgiMwebDA1XqLs7ZH+yWvabVQljOToUMXD4dlenP+acuxj/IA=
X-Received: by 2002:a05:6512:39c8:b0:52c:e4cf:4f31 with SMTP id
 2adb3069b0e04-52ce4cf502dmr3593154e87.49.1719262030535; Mon, 24 Jun 2024
 13:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
In-Reply-To: <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 24 Jun 2024 22:46:59 +0200
Message-ID: <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:17=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 24 Jun 2024 at 22:45, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We unnecessarily fallthrough the case for QCA6390 when initializing the
> > device and hit the condition where - due to the lack of the enable-gpio
> > - we disable power management despite using the power sequencer. We don=
't
> > need to look for clocks on this model so it makes more sense to just
> > register the hci device and break the switch.
> >
> > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Fixes: 4029dba6b6f1 ("Bluetooth: qca: use the power sequencer for QCA63=
90")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Is this going to break the QCA6390 as present on M.2 / PCIe cards? Or
> the older DT which didn't have pwrseq entries?
>

Neither of these has clocks that need to be driven by linux. The only
user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't exist
before so no commitment was ever made.

Bart

