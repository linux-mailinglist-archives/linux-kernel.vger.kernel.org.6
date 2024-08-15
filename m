Return-Path: <linux-kernel+bounces-287830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6EC952CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4D11C22CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3299C1BB6A3;
	Thu, 15 Aug 2024 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEvMBtTA"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68DC189B9B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718814; cv=none; b=Ui/TSwuRun0pYmXIulro4eTyTvmbZ4u3oYCKSeLZJw9cMWEEYNJrRQJE2N4CWTcueX2r6CJOeN+pFvggLlYRvv3xHWNlA9aAdFUn4K9cya5IxPdcryVSBxj23ojFLdcQ0nBF9101kXgdU11fUe7XQpbhgg6+tNZV8mXxx7QjHIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718814; c=relaxed/simple;
	bh=aNnphcw6ovD9CeIcwCw8owAs63PXvt0AN73nKw8befo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TaYTGPu8sLpYGS3ICD4ghdrM3KXlb+TYXsNK/qG/8H5bgNVXRc4rq4LNDCBK/pHvA1AiBaG15Ieu8e27TzXtQNxRzmYqaV/VapmaNVkbFlxrMCRJcxtZi6oBx5aQgTCJMvm9fuZS1bf/zJ5+bVzO1MZNPbeDWKsE2xEOfMdAgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FEvMBtTA; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1157e88bc9so820578276.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723718812; x=1724323612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNnphcw6ovD9CeIcwCw8owAs63PXvt0AN73nKw8befo=;
        b=FEvMBtTAj2WR00DOQPl/fee+0EdzvdAlbZbg1/Q+qsnn9Xpte2GnA3Z8SXuJN1kh5e
         bd239GTGerwNVk+todb+42JM5YuXgBvnHTBO54aZIzuQLDWtSIvlJwFv3LnV3DGF1lj/
         YE0932OnjHaBGqSymR4EywhuZjiIiQyQaxJnYURzaWyJllJ4W5IEp7+E5NiO+OiyFl2i
         zBj5ReB+HP/VO+d0qQs4qPWWlulSiq7FsheyQNPEOTEMHRIXrLZnQ6J3AXhSZGdWIgx5
         pBNw0Xqe7Byg3bAzElPRzAnHkf4ygkiWxEmlhoebF8cb3ytY55HzWijbc6oaoGLIx/l7
         onFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723718812; x=1724323612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNnphcw6ovD9CeIcwCw8owAs63PXvt0AN73nKw8befo=;
        b=vzHDL1XFiX6re5O2HxjWsoEGJFYWSaWmm51QM4CkASv88cHdJ6U1K8dtSlkuGUSzzG
         LmVTLy6QllzinkfsYiOdqFnQdedIGmgXlV/+TcxA6xGYBGM3eUBDMTu7EcVAprD0Qif4
         Zl+zTACHgWuwxuLNzt22fJ2zv2M/PKvBI24fGNPt7RQEVPe7+M/TDkS91HWzT1BfRnDn
         HxHgznvHpMcMVkDnJhKtKQwbYS1jPkEJmKSpUZnJS85/TdgvL8Ty3cRqhaL3LL17akja
         7c6G4krvSZEjLfxBofFXRlbAEK1kQTtxlZpum6TMXztEdoS954PHYh/KX+6yH9SUseje
         R5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVJXzsgCoGiN/r4OzNG3bKFTo0lgItZCLqKPIsQaP59Egu0Lv5R/CN5DlKJax2RvFzNcchKv4sbh77pPKobnQvh6E8YLWIn7fAdUdOA
X-Gm-Message-State: AOJu0YzpsnuxRDSnYI/lZjoGNu3uM0AMr3ZaL9+n+v4J20myyVbbhY2W
	HwupMim/M8n6rQXEhWrncIx6g+kKbWsnHgBcH3HPOtGMv5A+CqI0s1qpNHbLMTWZXplUR8UG7wz
	a/C6IDW2RSMxCJJNdCPg7/iOTs9Grt7YHZdUlvg==
X-Google-Smtp-Source: AGHT+IHR5za73VDRCro7qpXpLbNTcfYm0rbfqguQzgbn4WLGm+KGmWjJsguvyGGakAyVo03nrwztDauA9VWHNATK0nQ=
X-Received: by 2002:a05:6902:2291:b0:e08:7bf9:4d65 with SMTP id
 3f1490d57ef6-e1155aae058mr6488901276.24.1723718811912; Thu, 15 Aug 2024
 03:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703110741.2668800-1-quic_sibis@quicinc.com>
 <ZoZ6Pk7NSUNDB74i@bogus> <064274c4-3783-c59e-e293-dd53a8595d8e@quicinc.com>
 <Zofvc31pPU23mjnp@bogus> <CAPDyKFrESupeNS4BO8TPHPGpXFLsNqLPrUEw3xzr8oh8FsLHeA@mail.gmail.com>
 <Zryxrdodn2Y2xsej@bogus>
In-Reply-To: <Zryxrdodn2Y2xsej@bogus>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Aug 2024 12:46:15 +0200
Message-ID: <CAPDyKFqmV7yvMdLjGhDHJN4CFiUun3FXprEk7uGFV_qmn9vA8Q@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: Fix debugfs node creation failure
To: Sudeep Holla <sudeep.holla@arm.com>, Sibi Sankar <quic_sibis@quicinc.com>
Cc: cristian.marussi@arm.com, linux-kernel@vger.kernel.org, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, johan@kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Aug 2024 at 15:31, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Aug 14, 2024 at 02:38:24PM +0200, Ulf Hansson wrote:
> >
> > Sudeep, while I understand your point and I agree with it, it's really
> > a simple fix that $subject patch is proposing. As the unique name
> > isn't mandated by the SCMI spec, it looks to me that we should make a
> > fix for it on the Linux side.
> >
>
> Yes, I did come to the conclusion that this is inevitable but hadn't
> thought much on the exact solution. This email and you merging the origin=
al
> patch made me think a bit quickly now =F0=9F=98=89

Alright, great!

>
> > I have therefore decided to queue up $subject patch for fixes. Please
> > let me know if you have any other proposals/objections moving forward.
>
> The original patch may not work well with the use case Peng presented.
> As the name and id may also match in their case, I was wondering if we
> need to add some prefix like perf- or something to avoid the potential
> clash across power and perf genpds ? I may be missing something still as
> it is hard to visualise all possible case that can happen with variety
> of platform and their firmware.
>
> In short, happy to have some fix for the issue in some form whichever
> works for wider set of platforms.

Okay, so I have dropped the $subject patch from my fixes branch for
now, to allow us and Sibi to come up with an improved approach.

That said, it looks to me that the proper fix needs to involve
pm_genpd_init() in some way, as this problem with unique device naming
isn't really limited to SCMI. Normally we use an "ida" to get a unique
index that we tag on to the device's name, but maybe there is a better
strategy here!?

Kind regards
Uffe

