Return-Path: <linux-kernel+bounces-244711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2192A83C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4748C1C21141
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B578B1487C5;
	Mon,  8 Jul 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y50tGogI"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DC764A98
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720460014; cv=none; b=apOnz3atv6aMVPna+9DuTJ+2L6cmxJ/bXB7+BgAhIUpRT7LcwL+FVSrJZVdXjAb5VM0Z81CNRtH9RKT7WA1HtC2nYXBbhTFOQ6c56a68jCrXPbMMemKTWKfuQnANQz/1792KjrPzWJFI/z/taUwzJ5VdSTtO2ijVtmBZOLwxyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720460014; c=relaxed/simple;
	bh=xMgVMxuVJ+4mDxDIZpv60LWECy5vBRGinidcROVywxQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wbpb5IEq9C2MMnSk1OZgtx4z3URO57C6LJ3HZZs9rt8w9SVwE+4y70ct6fkNz/Oeg1WCqzoxFBRwysmNrHElmsZzBxmO4mQLFIzoLTO67+/4AWX3ELIDtTlkx9G46wg3mQ2xjeyVdjSeEXsni9WTQpwDyGI0ZM9OvJ2PtoxBNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y50tGogI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee8911b451so52344151fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 10:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720460010; x=1721064810; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xMgVMxuVJ+4mDxDIZpv60LWECy5vBRGinidcROVywxQ=;
        b=Y50tGogIngiclh4Gts5xkP4pOWNro5ruF/OZolpDwLqRsNTA+OxfK0DtSOyKzzALe8
         OVKL3i4CpYcP4Nw6lYb0nfdhnKnrGCIR7T8t70gVVsI44HIpmtlofEaQJ7VZiPolsOn+
         f8oKytFIs7qqBmvnvOz/7XiPTT0kCMfvXKSK4hHsihxFH1QroOx7ByPSJhBvRrlN2OBQ
         HHCbi6iN1EA4jTBdC2owSX7quGRalPXVfsO/p2EtzGdUQI7zpwJqeoZ5B/RBk+ZejVeu
         Dxa9zCLntjXk/8y5NQCFO0oA/zKUgHm7SWYSeGGBjF7oYWtrqhG+0eFfPVs6+QoyFjqd
         Q5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720460010; x=1721064810;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMgVMxuVJ+4mDxDIZpv60LWECy5vBRGinidcROVywxQ=;
        b=WVwsD00Fzu/zFFRq57T4w4QqYtku8UoLBcgNg7H17/7OjYZW5OCRxsSspOQjutgMXE
         AyF2Vd3QudpeWJWrcVgygVdh8cuIlBqSBrB2SD/wJamct1ACeniZShXAfMiIr+FRQZFR
         flI/UzYwAZVZ7HRWqS3D9dueXMjCZA6dgMGlf6WDvcqeSrDxLCspO/fVfQ/1ENHROx5y
         fi6DE/gW0mwGRuHRoSvtaspwGyF4zCFTRvJJqJpCL6kDn0RcsxsdBxtXkqrQiyr+l4kX
         zlQzc/K/9qfGB9wEnmxwmJxrIEHXPAIut2lc9IVTmZWUj5a3DO3GJZ7KBesMQGnM6Ckz
         AV3w==
X-Forwarded-Encrypted: i=1; AJvYcCWSa8Nj9b2SAR0Q0exY1XNo18kS5s6Z4OqEowFFQQVykROOw9vPjQbDMH4Ufmv0laDMRlrLx73JcMFow63x6pLucxqpT4eMa4pLz2Wr
X-Gm-Message-State: AOJu0YxMpYLA/PpyupbU2RD93zPA9Hk/B0PQvaUsinGU4Pd8PLuJ6t1f
	zLWtjnZgQpacYpCRbF8n1xfFG7SHVLPNLY/cELaOFqi3lRHHNZxIsuoTC2kB8FQ=
X-Google-Smtp-Source: AGHT+IHqm74O9XrXu8Sp/c9nwIkpH2JvcIAs+C9RT3fJBrhdSnfh3Hhhnky9bRB/8pAITn8lkJu/iQ==
X-Received: by 2002:a2e:9a92:0:b0:2ed:136b:755b with SMTP id 38308e7fff4ca-2eeb318b5e9mr2863341fa.53.1720460010540;
        Mon, 08 Jul 2024 10:33:30 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741553sm5885805e9.40.2024.07.08.10.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 10:33:30 -0700 (PDT)
Message-ID: <77711848a7e7242a7445a4bccf5c93675239b838.camel@linaro.org>
Subject: Re: [PATCH] phy: exynos5-usbdrd: fix error code in probe()
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,  Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, Sam
 Protsenko <semen.protsenko@linaro.org>, Rob Herring <robh@kernel.org>,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
Date: Mon, 08 Jul 2024 18:33:29 +0100
In-Reply-To: <a956a3e2-c6ce-4f07-ad80-ec8a96e00d16@stanley.mountain>
References: <a956a3e2-c6ce-4f07-ad80-ec8a96e00d16@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 12:04 -0500, Dan Carpenter wrote:
> Return negative -ENOMEM instead of positive ENOMEM.
>=20
> Fixes: 497ddafe915e ("phy: exynos5-usbdrd: convert Vbus supplies to regul=
ator_bulk")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


