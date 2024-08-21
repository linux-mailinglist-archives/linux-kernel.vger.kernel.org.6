Return-Path: <linux-kernel+bounces-295186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2049959850
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202491C21D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76561B81B1;
	Wed, 21 Aug 2024 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDBI58+B"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630BC1E12F9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230780; cv=none; b=N5E8HBRf2Bia227i1EwVT2l6WZbtdrP4CLDctnl5pqnIgzyDCv/YQoNLXyRqWF74UPLPk7GbryZ46VQU6vwp/NyA4kFJcMQnNMO8tbhXI4ORVt970YiRCZuoOowAmwIinNydog3MvFWrb75tE4PcVtGmjjMfyynKFjoO6C1BM34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230780; c=relaxed/simple;
	bh=s9ykuWWKcIzYSLhEcZ+7Y4Hgz3fhKuaaWdhkvIE3Vr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2dh4VUA32ZOKaheLBvkksfL7mbglOWL4UjoOlHbnJyHX8z5SkMzSBibqBuFaDIj5pLcNrVXuHUy830nUDXnytb2CmE6F8RWWAvLfumdqhk2fi9ZjZq6Th0yUgh/T9qRlAvljwc16TVjSmdG5HnzEnJ7fvDAztKLedP8rEq6Pqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fDBI58+B; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e04196b7603so6994253276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724230777; x=1724835577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZLdwMEs9e97Ffbpr5sQWKeFKLgx/5QLihyfu1wCHdE=;
        b=fDBI58+BHQuhvC7WpH8a6BCGrEs/cHEl1EU6xLeOda9YpanIuZi5MrcIysmii4liNF
         hfV9YMwgU+4snAdT0nCHnwGm5X+am1i0p0jI0uHdZwwPf9XtvRxeqHN0MC0++wllnsQd
         drnfhVUX8cNiLvo4e7GeaNy6XSyM0nF5Fvuylajrd+BR3EUg3HBFTrDzEKOeBzcLac7D
         dvUTHkk+fX8rSPyzmOD+TOGKLm+AfLPzFRqHYfRElTEeFFHoFTFlUdmw5EOjZJ0OnYqB
         YJz185qyp0cgo95SvlLuvIDLM5Oi+1QhJ6s4CLm/QZA83K+QO5tVmz9mJ7BDLUiweWe8
         v8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724230777; x=1724835577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZLdwMEs9e97Ffbpr5sQWKeFKLgx/5QLihyfu1wCHdE=;
        b=Kip3RolzN4O28JYtZA+Pbzpy0b+bMuTpD6MN/EhvALWMELoNACfIUt58Yo2IqFg0Lu
         YwG6yrK0k7n6pGBoV7rbVF4vsc2FIs7yr2gkuNV8KMkg7FsIaxvgnpAYHZteO+C9/5nS
         M3zBm47wI9Zs8InZYg4EYbRyxR6KGFX5eEa4iBGJqxMavbZdRXmu8vYtRS9Mx1BkbLpw
         FfpBsiRXSd85UCz9yTAed4XLQIHiXNzD9cMOQH1KFETQscTK1QsUwEUSd+PiBWsgImnm
         HpMJ7BEiaK1qlCFL03Va0Z1U6IKmHmfCvT3Um+MKIyAp+0VGQAtLOOnOvqti4q1cG0Wc
         fU6A==
X-Forwarded-Encrypted: i=1; AJvYcCWRjjQfdkE9k1oQTjTV9I+U2BUrto1g5Ozb7qH83Ak6B1pSfIQSmzd+w9FL8sLoUJUSevQti/mZJzRNDpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqObxa9PZ7tjRUQCLhZLg3KpDP5A4i//6MhuWAP2MNC10RydBN
	9lfMTGLJfVwjrqeuZiaIRediW7Nu4cN8DwOYaxFkAr+ayPqy69Pui2Vqdmovyr4HJ9o8np0zGtS
	R94uxHY8dnFJpMZRdOZWLtbq1OGnaYOQWTr9O+w==
X-Google-Smtp-Source: AGHT+IHCal/De+SEUKvHz6W9y7R33FpC1amVSgjxjWHDOYJi7w75J2qZuI5FPiGbNGA5CdRLRwf6TZKiBh3F5efpwPY=
X-Received: by 2002:a05:6902:e0f:b0:e11:7f99:f76a with SMTP id
 3f1490d57ef6-e16655627f8mr1731952276.50.1724230777443; Wed, 21 Aug 2024
 01:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
 <20240723144610.564273-3-ulf.hansson@linaro.org> <0af670ae-8c8f-4e78-b1e0-e9ccb4fba2c9@gmail.com>
 <CAPDyKFr5xjE867rHRZxtKPr0iKh9B6_Ckyu=B4Jzn-ExDpQjVQ@mail.gmail.com>
In-Reply-To: <CAPDyKFr5xjE867rHRZxtKPr0iKh9B6_Ckyu=B4Jzn-ExDpQjVQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Aug 2024 10:58:59 +0200
Message-ID: <CAPDyKFrhFHn0Z4PV1hG7ZtthzqFzdekO0vd39KXAPiD_0jR4zw@mail.gmail.com>
Subject: Re: [PATCH 2/4] media: venus: Use dev_pm_domain_attach|detach_list()
 for OPP PM domain
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Aug 2024 at 10:56, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 20 Aug 2024 at 22:48, Stanimir Varbanov
> <stanimir.k.varbanov@gmail.com> wrote:
> >
> > Hi Ulf,
> >
> > Thank you for the patch!
> >
> > On 23.07.24 =D0=B3. 17:46 =D1=87., Ulf Hansson wrote:
> > > Rather than hooking up the PM domains through devm_pm_opp_attach_genp=
d()
> > > and manage the device-link, let's avoid the boilerplate-code by conve=
rting
> > > into dev_pm_domain_attach|detach_list.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >   drivers/media/platform/qcom/venus/core.c      |  8 ++---
> > >   drivers/media/platform/qcom/venus/core.h      |  6 +---
> > >   .../media/platform/qcom/venus/pm_helpers.c    | 31 ++++++----------=
---
> > >   3 files changed, 14 insertions(+), 31 deletions(-)
> > >
> >
> > Acked-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
>
> Thanks!
>
> >
> > I'll pick it through linux-media.
>
> Please don't.
>
> I should have stated that this depends on another series [1] - and
> they need either to go together or we need to defer $subject patch
> until the next release cycle.
>
> Kind regards
> Uffe

Forgot the link, here it is:
[1]
https://lore.kernel.org/all/20240718234319.356451-1-ulf.hansson@linaro.org/

