Return-Path: <linux-kernel+bounces-248994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966192E4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55514280BED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656F915821D;
	Thu, 11 Jul 2024 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQVm8x0+"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89A14D44F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693920; cv=none; b=Gk1yTLnwSJVXC+2IhrMZizLgg2Bgh8dypObf9nUxLcJciIxwOocD/DxY8tzu7O4k/92Uxo0NjXorX6TxUnFv8WwO2qnbo23Rl479/ZCgt7VCg1USBpX/V0eDxVFjIsyEzaspZmo2gsMj0C37UCqhGJ5YeIjuOB4ktnYuPTUQaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693920; c=relaxed/simple;
	bh=sLYnoBKzs5dKdL37heI92uqtdcf3VywRSOkfVafIoUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXOA4EMcgkYxcare6xievtkI8jz+Vu9racLW1y4J3pssQWe3dqwjxntQOGqEHcDnClfQ3huecvGIP5BzBV3x4cvSZKxlvm5+2rGQtp7l+VPSVPjCHAvvUFwnqMUePN+VJeq1BtnmHC5xUx5IUJ6DYlh36A/FrqnFEapez3cOrHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MQVm8x0+; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e057bdc936fso627588276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720693918; x=1721298718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sLYnoBKzs5dKdL37heI92uqtdcf3VywRSOkfVafIoUg=;
        b=MQVm8x0+TMKwmt++HVPt45k2fo3FtB9lJ9egjEUJisOEsZx5ry7ThEGfqyX9mJ79dr
         B2MyoD73ntBCkxSlQ+VgliSGBRjyWPFiF7ZA+gLjBy5GJaARDoiCDWjoL8ICDaSZlogM
         nrl6KI3zkJ0tUCBbxIrKam1OOHL2CU7MmSSrozeJ+Syfmv6+4Gm+FQWJzMTtoWWuzl3z
         FxpVHuMq5cPdTp9FzkdUqxdr35kQKBQGoX5vGkuvEZPOq4TrRtwMgkiGdTuqdO5DtBWT
         5FA7m36mL4M/UqrWMxu9wry2+/O4eIRLmd3JY8hEaa6aeYTHxSZppdJ/qUl+/NlmHiR5
         N70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720693918; x=1721298718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLYnoBKzs5dKdL37heI92uqtdcf3VywRSOkfVafIoUg=;
        b=rppbWAVFZ4XwHtX1lJcbpF1ddhiao5jKBJOJEosqtnNwenGqo4hdL5c4Hm+91RpTP6
         +R1UaHtWumzvFrSk/vck9TeNZWNhU1QSzwXf+n1zyuTpGtTmEse7zuFrTytr4NdRD2mS
         LkN3LBrvycmmOQKZK6kNBmOzxvp+5NCqEaHJ9vOfPW2Ae/TEoEFn+oqzQMGuyywurXRp
         XHV61NyGrZL9ntoBRq6Aa2N7qc8GDG0HzXHqALt+CLAkTUiudBkA+wGOTYcNq8WZHd0B
         J84AiaPK2HjNnTmvDA/cj5jTsaA0G1WD0sttF8qmE2/XnczNnjNWmJ5yCyfzAjALBDho
         fY9A==
X-Forwarded-Encrypted: i=1; AJvYcCUYEnxFQcOxiagQumZF+qfIGcWlv8Nn1KVYVUXhonJXUuKvzxcJPwQnapoa2lBho80Rl6t1aKQquFpwFusAKyl2CROyzdS3oQDhO9ei
X-Gm-Message-State: AOJu0YyTdK1Ef3TKGdNUDqIjqlaR5DtJBYj8HipofgX4JWARuHbeCfZb
	yohwKYdsZVMLQIblA46wYN4ORK8jP94jaBwR+xQvSNBwN0Wx93YkPUz97fYUFCopxV1V534pySb
	ZMTjDdMaYVnTKDSM8IU/ktM93j6be9EChB/r5vQ==
X-Google-Smtp-Source: AGHT+IEquy5Mfj+z2Qe+lRxpTPwm+FEGo5nmwpVJMvyZKcggTgoJuc5Z1qMdFrX2t9QzHPAMZntBHC16c2/koorP8a8=
X-Received: by 2002:a25:6801:0:b0:e05:6d47:57a4 with SMTP id
 3f1490d57ef6-e056d475973mr3751249276.10.1720693918146; Thu, 11 Jul 2024
 03:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618155013.323322-1-ulf.hansson@linaro.org>
 <20240625105425.pkociumt4biv4j36@vireshk-i7> <CAPDyKFpLfBjozpcOzKp4jngkYenqSdpmejvCK37XvE1-WbBY2g@mail.gmail.com>
 <20240701114748.hodf6pngk7opx373@vireshk-i7> <20240702051526.hyqhvmxnywofsjp2@vireshk-i7>
 <CAPDyKFoA9O5a6xZ+948QOzYqsRjk_0jJaSxeYRwx=76YsLHzXQ@mail.gmail.com> <20240711031356.rl2j6fqxrykmqfoy@vireshk-i7>
In-Reply-To: <20240711031356.rl2j6fqxrykmqfoy@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 12:31:22 +0200
Message-ID: <CAPDyKFocjOt+JyzcAqOfCnmTxBMZmPjMerSh6RZ-hSMajRhzEA@mail.gmail.com>
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM domains
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 05:13, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 10-07-24, 15:51, Ulf Hansson wrote:
> > I think this should work, but in this case we seem to need a similar
> > thing for dev_pm_opp_set_rate().
>
> We don't go to that path for genpd's I recall. Do we ? For genpd's,
> since there is no freq, we always call _set_opp().

You are right! Although, maybe it's still preferred to do it in
_set_opp() as it looks like the code would be more consistent? No?

Kind regards
Uffe

