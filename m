Return-Path: <linux-kernel+bounces-512374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E682AA33869
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD3B3A8FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612F4207DFD;
	Thu, 13 Feb 2025 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nv2vRVlT"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E515207DFB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429991; cv=none; b=ZcM8CQz6S5RCo8YMMyKk6svtO6QVKCUySpZuIa3bO4vckWo3vXCaxuQZB69u/vXk9qc09WdBXJjLMLT0cGEwK8gcgX9e/9dTdPklQvxrxbWPTANwLbOtSIlnM5kjArcxsnODQK6KA3SvYboZ8Hqw2TKckEDPPFPNeB7HKGZO3RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429991; c=relaxed/simple;
	bh=L+lWu/Bg4y/1hXkYeBGzl87ktHtA28/BQP0FvLsbWBU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cpFpqDYu/MJ00IZ359nGorktMG3Ujt5Zlw/Kr+ko7UUGx1LK+ZapN6plV6nytO6SJ3lGTCuRQBN1jBHzaPKWNfMX57q9VhZzUv9ZeEbJAcU3Qy5nq/yqzsEas8bglMuSRnb7BDnk9sGJe0VSXzi7eo0ngIeEfHoyRDj1PsVuDQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nv2vRVlT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso2767485e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739429988; x=1740034788; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L+lWu/Bg4y/1hXkYeBGzl87ktHtA28/BQP0FvLsbWBU=;
        b=nv2vRVlT60qu5gy4OzVc1C794oBvXfrksMC4mdRnFyRbGtw1Y/C1iKLUE4sqvb2g65
         pOHovNAlBEvS/lAihl9nqVtnCi2BeyffT7eIRTD/nscnvxtQ7Tl7iSxPT/TIk9jjZrgB
         p3rtuXtER2DjlhjhfZ3jJLFrAv0gKE83eREpfHP9UluMuPhwaVAzOajoMiUelMk/6MjD
         ytmnIH6qAQgdmU6ej2LAzrukmEBWK0m6Q3x31Up3yfLMAPf93rl+9+ZbCSMYmVPe0Pev
         iH8L/X1Uzsv4ox6XQGAgwYU/RXmD7frtOk0J50JFYNKRsCtwoBGAZDWOZzKnWRdV+iDx
         RrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739429988; x=1740034788;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+lWu/Bg4y/1hXkYeBGzl87ktHtA28/BQP0FvLsbWBU=;
        b=XFEut/tZYpiE0Y39RyH2hrNh0r/7B3xx+b8C1pB5pmvNeNWN1z58IPgEvHZUL+mTbf
         N/UtG/+s9ZTJsc487lZFaJsPA2ZgYgY/NiyxMJ0ByIbHjp3rZVcNFNOO9zISt/Ykfylr
         2iiEvmXdtd1WGd5N30hj83lZJWIyfhCFS6QWX+FMNH3fdmS+efwR4hi+9D40yQJnV0F0
         RtHjfmDGtZQkRs8tFQ3KGXSEnOouyOb9MzIoyzQ6y8VqnTJKZTPzSo2V0Zm2w+yMm7sP
         KLzUFt0Jhgjq51hJbHzoYuZyfBN6NEa5twzCzGWoVJn+G51XyL4Lin6NRBfStRPPdMU8
         L2tA==
X-Forwarded-Encrypted: i=1; AJvYcCWU8QxBsIAwZOqsFdPrYGt/H3PdlTTYdOE8gstWe/oYGn6tXeoE4LZwQP/w2wJX6xyi/OVqx1bSb++l37c=@vger.kernel.org
X-Gm-Message-State: AOJu0YymRgxqSzjPHJ/gA6TJJug0FuQOdXYhHSTOsS7xWWoqZgmtLnky
	8dwxIanQ/KvhIbBCIbN4KLBuGlEvMu77nb/xzGzXsmfuPPGOC5++WA9Q1DkcVcI=
X-Gm-Gg: ASbGnctx0T4hziqBjAupvppYAQurANLAyfx9H/TjkdP4U/xou1fFUYM7qM9c4yb05sr
	lbNGeoRU+F59SzDmV4oWAKFgax84nzQazQBZH3OTgNlBpaLbIxsNUMJ1YGGldCh+tu5o4/89BiN
	O9WV5O97peDM4XTjwzpQbwB6vNVeHAQ90OxkF+1BqgVTg6D3gQkXFpt6DBYMyIywDpAoy6z9M8H
	GvVkZhNOkhktKCjuSX5nPiKDpDVDS2hweNw3rUeCfra4VtEm0xCU0Yu1qvAYuh9gJW5L+3omPxr
	JHecsKzlNrlnDGpp6KA=
X-Google-Smtp-Source: AGHT+IEcIbIDDwYQdOV615CUjCJxgeMnQC+DGesANA1ClWsaF9ced93N0m+sAVSXmRf6DZmkMUCY+w==
X-Received: by 2002:a05:600c:214:b0:438:a313:cda9 with SMTP id 5b1f17b1804b1-43960c068d9mr13823075e9.10.1739429988348;
        Wed, 12 Feb 2025 22:59:48 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f85c2sm995229f8f.91.2025.02.12.22.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 22:59:47 -0800 (PST)
Message-ID: <f5f6194db4d3ab2e61ef8800531475af1b5680d9.camel@linaro.org>
Subject: Re: [PATCH v4 0/7] USB31DRD phy updates for Google Tensor gs101
 (orientation & DWC3 rpm)
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Marek Szyprowski
 <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>,
 kernel-team@android.com,  linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-samsung-soc@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 13 Feb 2025 06:59:46 +0000
In-Reply-To: <75e01bf815e5f7692d4b7aa261054851a943fece.camel@linaro.org>
References: 
	<20241206-gs101-phy-lanes-orientation-phy-v4-0-f5961268b149@linaro.org>
	 <75e01bf815e5f7692d4b7aa261054851a943fece.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Vinod,

On Mon, 2025-01-06 at 14:26 +0000, Andr=C3=A9 Draszik wrote:
> Hi Vinod,
>=20
> On Fri, 2024-12-06 at 16:31 +0000, Andr=C3=A9 Draszik wrote:
> > Hi,
> >=20
> > This series enables USB3 Type-C lane orientation detection and
> > configuration on platforms that support this (Google gs101), and it
> > also allows the DWC3 core to enter runtime suspend even when UDC is
> > active.
>=20
> Friendly ping on this series :-) Do you require anything else?

Ping again :-)

Cheers,
Andre'


