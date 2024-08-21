Return-Path: <linux-kernel+bounces-295182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8D9959845
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DA71C21967
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616CF1E093D;
	Wed, 21 Aug 2024 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzmlSjTz"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD11E093B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230634; cv=none; b=JX9RiZbP1n6TotOI1Asv1b2gQVnJZqQozjwUPYPmwDAziT++xY9U0M5CfOvP3vxWDTsKyt4SKSBIuBeHPGLXwvksNq9y0sN3KedySMnps/fhGnkEbBNbh1kueM7jzsgRaIw45tNVNuccQE9b5gQ6lbCduR4Jvc52J2v61SXUqvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230634; c=relaxed/simple;
	bh=XiTaGykEXlOK7qo6DqiaH9pBLD9MfNMnNE4nZEAE5fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9VwhEuhGilLr4KB1VOJhTNHjXTYzCoVW+Yx6aQjKx8puG0RNOTI+ns4jMY20untmFnmVsCep8/5xskcF22AwGYPOyFzvd+qGaSXY5z5zPrvI83vJC55MIUQMBxSyE9/rmwWXLyhT/oCuT2FmV9OVoNV/HoWTplOUXFgpHuPfWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UzmlSjTz; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e115eb44752so6855897276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724230632; x=1724835432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0V60v0KwinrqIcf0dcsmelQeeG3cYskrSTMxoS0mUlI=;
        b=UzmlSjTzRoI+ZXUyFOCczgXrn3EEMLaShDofpdmgO2fTP9pQLLrEoyqImXh02WhnvL
         wUB1XG0dkmTZw2XqLFDdKDBhJTfK6E7DNtyjKzBrJRqqZc4U8G2NqY20W3ChHYVShzNo
         EqVDD5F3PM+zMsQ4pnTPfUcQniY09NjnHrOOtIfpri+FoMgrc86BcEyVGgw1K61M+EUJ
         RGFCWkneMtBLYgyug3nrKVAs5X8KDO0AySJ0tvljkDKVPzjQTfArCf5UcC0yOqSrEGQK
         YbrsIWZcire6Tp4L12rRT4au+Owmi/jQ0DekcnhbnHrS0Hs42jI6nyyn14WjLuRzyTwU
         1irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724230632; x=1724835432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V60v0KwinrqIcf0dcsmelQeeG3cYskrSTMxoS0mUlI=;
        b=VjtMp96NXBjBtEYKy4QVo+ExlwRYxyombjj8b+NeTJjbvCoM11PyDjZwBCYUhO1GPm
         3zaQX9FwMBMfSqULokH7DaGSibbZJBIZU5jR4kS2aWo4gAEMJ3n0wc1mP2b1mqejjbD/
         KQAhxVwNoMfuldQLvYFaXGfLBzlkNA4ekbZs2JB/Zrjl+8uibuy/N6qNK8WPzYnSUxiX
         eHPMSHlovnL2E+CccS1+cf6NV/yiWSkm3kYKuO5pY6OwzbzoR1aw9A+FnxEIxwGbQjsP
         cW2SlvsUInYhjMov63sYZ9UG2kAEO4LZTzaPVANaKrhV8YPaqjljbCk6xo/kunMzfhxg
         9rFg==
X-Forwarded-Encrypted: i=1; AJvYcCUEEh4p0BYucKU5OElOyfVaqGW9jxGPhewYrlDnTtZco0IUC6ANCH644M4WsyEjdgUupOHXJ5mdTNNOyDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVCw9q8zcd9th+WDzEPHDM7NuPBzy92DQY125fSUQDKHRFleO
	K7Z+Cvf2Z0MJ0zJ2pHmXjGKi95mObHOCMSLE7GaYNHK82aPCtLdsaVrJ/wSTyFGalS0hk1zBIFl
	7dyIOLuNfS7pVjjXZKJu5+UlBg3ejYPjy/aai4A==
X-Google-Smtp-Source: AGHT+IFe0QsIxtrjTu7cTIqZJ9lIeMtuZRcq9T15jB59XMlSfHcZtdLW6S/QNRL9WZwdcPfaFab4taXyswDraMCQ1Ac=
X-Received: by 2002:a05:6902:1ac6:b0:e16:6feb:e615 with SMTP id
 3f1490d57ef6-e166febe73cmr418747276.48.1724230631986; Wed, 21 Aug 2024
 01:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
 <20240723144610.564273-3-ulf.hansson@linaro.org> <0af670ae-8c8f-4e78-b1e0-e9ccb4fba2c9@gmail.com>
In-Reply-To: <0af670ae-8c8f-4e78-b1e0-e9ccb4fba2c9@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Aug 2024 10:56:35 +0200
Message-ID: <CAPDyKFr5xjE867rHRZxtKPr0iKh9B6_Ckyu=B4Jzn-ExDpQjVQ@mail.gmail.com>
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

On Tue, 20 Aug 2024 at 22:48, Stanimir Varbanov
<stanimir.k.varbanov@gmail.com> wrote:
>
> Hi Ulf,
>
> Thank you for the patch!
>
> On 23.07.24 =D0=B3. 17:46 =D1=87., Ulf Hansson wrote:
> > Rather than hooking up the PM domains through devm_pm_opp_attach_genpd(=
)
> > and manage the device-link, let's avoid the boilerplate-code by convert=
ing
> > into dev_pm_domain_attach|detach_list.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >   drivers/media/platform/qcom/venus/core.c      |  8 ++---
> >   drivers/media/platform/qcom/venus/core.h      |  6 +---
> >   .../media/platform/qcom/venus/pm_helpers.c    | 31 ++++++------------=
-
> >   3 files changed, 14 insertions(+), 31 deletions(-)
> >
>
> Acked-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>

Thanks!

>
> I'll pick it through linux-media.

Please don't.

I should have stated that this depends on another series [1] - and
they need either to go together or we need to defer $subject patch
until the next release cycle.

Kind regards
Uffe

