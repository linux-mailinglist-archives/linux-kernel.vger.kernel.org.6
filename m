Return-Path: <linux-kernel+bounces-356881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3C099681C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8881F2346F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEFF191484;
	Wed,  9 Oct 2024 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nh0dJ8bq"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4C190499
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472313; cv=none; b=pKxmGbtzp5MuwbkqFxOHcfh6a44BrmuaGMieFlmaFsdObG+dUH2zzFVQQCj7BYm+++v4YaRrxF125sDk0b0siKMVh3C5dbYyzpjHp4PyS7oXs2PZHwfGBoyRg0bOQTylCJX2+qoeEr1fuyi9LipHK9aNJiVeCLpVAbmqE092AzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472313; c=relaxed/simple;
	bh=zkyoiyol/ZE9sPqTK4uVntBSTJv2678Uo5yX8kEiBq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpovJGfH5Qa3wJ8QOjs8yvwkk4WbZgqWHOU1RtrU9pETe+nxGCM8DXBcE0Bwke84PBL1THPbCYFhGdPXrc3P3YlkN2Gx0P8dT74camCgnaRE0voEUhNl5t9UTdnDt0cBM47eoTux2votD21fAfd6P1eXksgPJRPvesPkISLtmnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nh0dJ8bq; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e28fa28de37so1015048276.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 04:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728472311; x=1729077111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zkyoiyol/ZE9sPqTK4uVntBSTJv2678Uo5yX8kEiBq0=;
        b=nh0dJ8bqC4EQMc/3Qbf1FwWdncm+cWLSK/BrI+6m8mQ7c8E3uVL4/oMLZux7myniSc
         rfhcSG01gVQ6i8pQtdVEoG1fC+ZA93PRdTqAVcLCO2M/nehbFiZmCH8iq4fO4oiFf9/s
         t2/yLqG4Xuhr7/c1P4O+ptZJLIxDD14tNNs+hAj0abwm1lPVgtSiHCkVAazW06fqqPPq
         urZ9W7D0Fmd3Eh1nebfXq/00RvsrkEZRKENQMifKqjYKFm2epCgtsKqWNlxyRNlA96j1
         zdZHgFLLDAORR74rMsqJhz9iu3r4ORR6QZ9E8LuO4i/90DmoVJxdcKmg0uDUzFfGqESs
         n7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728472311; x=1729077111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkyoiyol/ZE9sPqTK4uVntBSTJv2678Uo5yX8kEiBq0=;
        b=VlvuqcE7hFXZD8w8d2ROtC/F3gF3q/wxD2xe5nByUYt+l3ZH4UzV7RhrDm0ge2Y0wD
         g9R/If5TJ8a2LFlV73iJIM+W3wLHecxQF7/BSdoMf7kE+Lz3mDk4Afgpzvnwq6tttXzn
         XQ1khht+L0pVW+tmwcWQxkI0BZlqQ/2WxFv7CbGmDM2oFtH9cgim/gQNfcnjDAfiMQxB
         wJugrA8P4Tgy20PwKDo38nV1m6JMvoNpw/vHvDfRwADNEshoTrjDg6t0iJji4Ph1oSc9
         ALJOW+hqdV6FvdFt/gZ6Az/Sai9eqrDxTuOpfjwTbhAaHCfVjK5pqb2LfoQdmA+nUC+9
         7T4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwgEs7FXw54KmtAVX/Src+315rrZ3Hs9Jj9ryMNJ7XOLeqiuRyfvq2p1Zze7iBC0cSY+navkWmhEuW8qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN8jeD0A9HO0zTkhsCvknE8q3HsxMrjktqr7l3Emvld3Lob0bE
	5xGaD0fQkDCwGeILBD8o1Go+Zlq8OSlGLT/RNyNWVHfp3B69C0lxIu9BParZs2xEBrMyNRjtej5
	krkPboAqpmQu4o0zfIG6lSNNGgA98qo0pF5B/lg==
X-Google-Smtp-Source: AGHT+IHuD7E8KK89qc/ZYJOshuMtFnxvbP22ktfO63zcv6l6glVmf7j+aAYtHbiv8eOva1PMvU0Zz5C/WEcPv6VWwRo=
X-Received: by 2002:a05:6902:909:b0:e11:7474:f296 with SMTP id
 3f1490d57ef6-e28fe44cae7mr1770214276.19.1728472311248; Wed, 09 Oct 2024
 04:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <20241007060642.1978049-4-quic_sibis@quicinc.com> <nlmz5adfxtnhgutblddlf2nlasmd5q3jpcsziaegmfvzsbkk7d@cb6e5qslk7vl>
In-Reply-To: <nlmz5adfxtnhgutblddlf2nlasmd5q3jpcsziaegmfvzsbkk7d@cb6e5qslk7vl>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 13:11:14 +0200
Message-ID: <CAPDyKFrG1ZEOOhk1Cb=RqZ-8eeuMEFe0ACz2DGC3=qejjj7Mkw@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] pmdomain: core: Fix debugfs node creation failure
To: Sibi Sankar <quic_sibis@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, jassisinghbrar@gmail.com, 
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	johan@kernel.org, konradybcio@kernel.org, linux-pm@vger.kernel.org, 
	tstrudel@google.com, rafael@kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 19:33, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, Oct 07, 2024 at 11:36:41AM GMT, Sibi Sankar wrote:
> > The domain attributes returned by the perf protocol can end up
> > reporting identical names across domains, resulting in debugfs
> > node creation failure. Fix this failure by ensuring that pm domains
> > get a unique name using ida in pm_genpd_init.

Thanks for working on this!

>
> Can we make this opt-in or opt-out? Seeing numeric suffixes next to
> well-known power domain names (e.g. those comin from RPMh or the CPU
> domains) is a bit strange. Or maybe you can limit the IDA suffix just to
> the SCMI / perf domains?

I was also thinking something along the lines of this.

Another thing on top of what Dmitry suggests, could be to iterate
through the &gpd_list and compare the existing genpd->names with the
one that we are adding in pm_genpd_init(). In this way, we don't need
to add the IDA to more than those that really need it.

What do you think?

[...]

Kind regards
Uffe

