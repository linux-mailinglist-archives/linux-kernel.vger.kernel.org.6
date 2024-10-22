Return-Path: <linux-kernel+bounces-376611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BAF9AB3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0641C21F72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C2E1BBBC0;
	Tue, 22 Oct 2024 16:24:21 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF221A4F1B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614261; cv=none; b=rIwJBU/0oWycI4+1cPkw8PeCDxlUekXMa0WpPl/P4wrTG45YDKsjSUJVkgHNkQ+uaXMykjVHbrz8DyfdMOVF9IqcG3nQYLUygYXdmiBDxjitUI+mNodcYySkJnq4+DwKPCGKAT22RESOvKHf/yh2qcXch6nC9nC/apVpzhvjU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614261; c=relaxed/simple;
	bh=TaaTMM3UxQWbFXrjZD8NbUwl2Jn1hwjRyh9yQQ+Ff4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E/4sySa6NNPJSqdCOlnOD9jNJv2tkpSwh8zVRt0cPynoaY2NPJZVJLgJHgAJBJCJyqiVyBY8BcNLqIeKddt88ZEWd8QdFCbmqQsLwtfgMIM054bhKdAeA8K7mFNWfgMoZLw7m8PmBfpH2wnyEXYgRiikaG5z+KPMjK+K36cxJrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c803787abso45603265ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614258; x=1730219058;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaaTMM3UxQWbFXrjZD8NbUwl2Jn1hwjRyh9yQQ+Ff4A=;
        b=nhr7zqh2ZFrK3QEvFws4U4SziIa45pmeEC8TxNvJ4zGNSj1phGvLMtRWS7DS0uzQCY
         yXpJX6gajxo1H3VmatFwUiafaoDk9zYUO6kzYyxatj5glZQEsQEnA4Pq0vqPoiT2LGys
         a9SDH1yddfEceK5tvXx72d+dmL1fFL3/LikSV1y0X9DUpMUtT3f1dAlsdU00NE2U9bcx
         uTySpe935Bf763rpWGGLBh8R1Z8w6nsY1mfLw/i5yi2qpnfNgtQJiq/sJssdtB6DX7Co
         4JoirlYiEnphL36ZWYK2CQnE1iDxdYQihMb/Lvm66cWO7GPPHsQ7+Gp4YHiqdKCajEho
         8UtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXS3XEwhydtxzsdYUyqeYiRkUeaFNvLGme42v5fBBnP87QTl81IABJBHy4wRjy1iRjmHlahfc+RHMrksY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwId80uUtvRmTz194Q2668A4y3jsU5k8gKDe2RS6mcRbB95Unce
	QLIAJboxB8eek79KT9kPvxYKyMChZOcKBlB5k03KUxAyFZOrN9KoMT7X4HWRsB0=
X-Google-Smtp-Source: AGHT+IFaD/j1Rlq40Aw5sjAcS1z8YIlzMkor00MFlOjtln9GzriHDQFJiXnHbn4jt+cYqpNSUiqZDQ==
X-Received: by 2002:a17:902:dacb:b0:20c:7196:a1e9 with SMTP id d9443c01a7336-20e96feb050mr65803955ad.13.1729614257846;
        Tue, 22 Oct 2024 09:24:17 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm44498595ad.186.2024.10.22.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:24:17 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: tony@atomide.com, u-kumar1@ti.com, gregory.clement@bootlin.com,
 thomas.petazzoni@bootlin.com, theo.lebrun@bootlin.com,
 richard.genoud@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Richard
 <thomas.richard@bootlin.com>
Subject: Re: [PATCH v2] pmdomain: ti-sci: set the GENPD_FLAG_ACTIVE_WAKEUP
 flag for all PM domains
In-Reply-To: <20241022-8250-omap-no-console-suspend-v2-1-cc3d102b8a1e@bootlin.com>
References: <20241022-8250-omap-no-console-suspend-v2-1-cc3d102b8a1e@bootlin.com>
Date: Tue, 22 Oct 2024 09:24:16 -0700
Message-ID: <7hbjzct8b3.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Richard <thomas.richard@bootlin.com> writes:

> With this flag, if a device is marked on the wakeup path, the correspondi=
ng
> PM domain is kept powered on.
>
> This commit fixes the no_console_suspend support for some TI platforms
> (tested on J7200). In case of no_console_suspend the serial core marks the
> device on the wakeup path, but without this patch the power domain is
> powered off anyway.
>
> Suggested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

