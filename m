Return-Path: <linux-kernel+bounces-305281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A04962C51
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49E5BB2309E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854091A2C37;
	Wed, 28 Aug 2024 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0nhP0E2"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB61A2844
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858840; cv=none; b=oJmeTEswIzqFcK04mIJ2OdRKu8XF4a7wDF2L9f9Uq6XDRPLvVhgD58A12alZzVQ8Reyr062FdmWTdlUQLiosFIz3gXzYv8OaMoZlvIcxQ56Z//pgpzDXlcjtLLvKyHhMtQuvFHAEev6Hba5PJ/FFL234zzx0qYsgbXYWNG/D/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858840; c=relaxed/simple;
	bh=9HzJPcyEnxnH+Ag1W1YfqcDxRxVZwQq5Cf1O/A3FzM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xqgr1iBVwZKipMrB+7AFH+LHiZVy771wQQiWWZF1WTRea5w4XMwn1a9srcB4LDaZ5TEtDnnSNLLmnhKlWSPanfoK9vYpl9uXHFaYJiN3h/ZdHKVb8HxfmEXa/zxEQ1w3Qqt+4xW1s+LXL143+DVHdCUXKufmyl0WMoILES97PDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H0nhP0E2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86abbd68ffso146535866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724858837; x=1725463637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MOBY3lvV3tV18oDrPAdQ4WWc7mqga2KPzBBZTBJ42n4=;
        b=H0nhP0E2FpU0nf2paOWcaEJHRBZ/LKmi9cZ9iLzJj7wlN7wetRnM4ZCnCDSe+yHL/3
         5nrIeLW4XVoas2kGw8GjUmf7OxcxgCYmCfXiCgU4ffEEbQ9bEf5b6Cz1d8Znb6In/c1g
         WfV92Xm+odaDWJRU53KXMtJ6tojJFS/1eYj7Yl4o0FWC3D+cNuZfQ0w3eWU0L9YIbmrd
         8y3ZDTs7fPDqqZRvZjsSVbHiLYsgdpyjk2vbHteeCpZOB8r1kiXbsPzLN2q0eOfvkpIr
         6XNaFl4th4h9qfJwiEqjhB5X2ULh6ENDFdVUzsUYuRnRcmqPv2OiJJZ6ZY6Dko0w6J7q
         HQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858837; x=1725463637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOBY3lvV3tV18oDrPAdQ4WWc7mqga2KPzBBZTBJ42n4=;
        b=rGaXza+CNjnymGYZ3tIHlXxKxRCTPCTPUHPscsheLCt0V7wnhnqPHFP+tzBe178NbA
         z2JS7CRW/GGGLHbtXi9mUMG1BLqa8bjn92WEStL2BgDGYdYjYv9xhlaB6VfVgQfCXKyw
         Ut90R2MlpMal1Pd6QQDUhRa+nHSeVC0S3By6+Ae+EswlnpJNwKu0w9D8LFENnWjhDVuj
         Cp3bfcl7rXg8sar0CnrD6a0fmsJDriVd/AS0+QqcLydvevJDhC00Igndpr3DJDHN2BvF
         nUshQ79ibzDwNLPHrrKvs42OfqEtcOUY3/KN0jnHiJ0ufXekqSMeLyZ/jBGhHH2koP5Z
         ubvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOLar7HmNp9YQFzulQi76Nl8E2FSFu5h5zI+zQz5DT7d3Zogzj4b+d2PhiHfnJG5SzSJYii36jF8z13TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTDMsbrlgV62lm+4qfWzfdRwIJqplGmU3A/IJHHwmrM4h9NfM
	1o1u6xBhkbrEbp9jbk7iiaIf4uEEMvPnwewgs4lDS5MwEatq/sfCtR1dXe8snFYplZCe/CkoDD8
	A3O+NIVWYTK+8kqL+GkopnePexajUaiw/T+YgIw==
X-Google-Smtp-Source: AGHT+IFixyOXCmBZEvpwN9wCdDNwQQHCRpTc9E75dou5XrmHQlyvUPK8JdSl5J69mGi3TqnnQJpuzic3MShgOP6KZGo=
X-Received: by 2002:a17:907:7f21:b0:a86:9f1b:f5c3 with SMTP id
 a640c23a62f3a-a870ab077b3mr311389666b.28.1724858837278; Wed, 28 Aug 2024
 08:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
 <20240723144610.564273-2-ulf.hansson@linaro.org> <4455ntyh3v5kk6p2hlprcdc3twy5lgwcihl6fg7akxxlxixr6f@vrpesypllh3o>
In-Reply-To: <4455ntyh3v5kk6p2hlprcdc3twy5lgwcihl6fg7akxxlxixr6f@vrpesypllh3o>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Aug 2024 17:26:40 +0200
Message-ID: <CAPDyKFosYtG=6KtDFeNq-XJ9DO0fbFK-bcpR7G8cVH2Zn2az3A@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/tegra: gr3d: Convert into dev_pm_domain_attach|detach_list()
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Aug 2024 at 17:06, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Tue, Jul 23, 2024 at 04:46:07PM GMT, Ulf Hansson wrote:
> > Rather than hooking up the PM domains through devm_pm_opp_attach_genpd()
> > and manage the device-link, let's avoid the boilerplate-code by converting
> > into dev_pm_domain_attach|detach_list.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/gpu/drm/tegra/gr3d.c | 46 ++++++++++--------------------------
> >  1 file changed, 13 insertions(+), 33 deletions(-)
>
> Applied to drm-misc-next, thanks.

Please drop this from your tree. I already have a patch [1] that you
have acked, which is a newer version of $subject patch.

Sorry if this was unclear.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/CAPDyKFqZ9XXi5_-essaGbdWBDLX8uR5nO9vDJCExBGV+10KqZA@mail.gmail.com/

