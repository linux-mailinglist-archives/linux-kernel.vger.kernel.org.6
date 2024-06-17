Return-Path: <linux-kernel+bounces-217015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D84B90A9AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A771F25D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BE0194087;
	Mon, 17 Jun 2024 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="laYIaRMo"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB9193062
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616910; cv=none; b=Iv4JXcdrrbqJ1ccaROPCV49BAs0YmItKEbmJ5chwH3eRZMGmXTVCsNmm0m8Zr/uiNm1eiykIBBHNR/NWhenDd/KiKEYkImIUaTrUs2DfnZXHfg3YuslOFkejI5MQNDnvPgiGSDAzrQgynmU1XOG0gIMIhH6yX5X3HXozf1B+cPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616910; c=relaxed/simple;
	bh=WwPANurgbHg/bZQ8Fx5BluELw0V5Ey9S41+qZoHECKw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NkxZnp5G+6hnHtw2iIYCRhu7I7cEd4Hi/H9TAg2as0V087lfFFRmOzIml5cAHZWqktMYiP8/z4DWPrTD9/gGLJmfwZolVZAhKC+A6P1eBDHaF9Yo6AOVll0pgvIXKh/ZIfkbyAQs32GRXB+ok3cISj5n3DKgyyp+ckNwk6+k0Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=laYIaRMo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42108856c33so31733195e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718616907; x=1719221707; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WwPANurgbHg/bZQ8Fx5BluELw0V5Ey9S41+qZoHECKw=;
        b=laYIaRMo9eTZTr+eQnuWlaemUDPoPbUpImpZArYPjWBxDaWTixAr0mMUYzL14h/OYz
         fBxKQCup2TjqFj0DoJ9Eip4hO6ZOkRm+XVZn2RVC2iCBOQcltJNIlAHsUd5Hynwv5iCn
         XNpbxoRLyhM01QgZzWCGwg5vgQl/Whs3ee+xYQkEFJ4zLrAndRJZZ8nkq8t2z+/WbLsS
         4ZVCPyg8a99/Oi+Ax5JkzT8Zn9UWKn7ENmpPv9XOU7ioqz6krAxXIrPFiv5spfuCDOOp
         ZiNCkvYaZhOxRWqJ+jWo5RKcJyDIYQVOLdbljibQGSx0OlMiZ2a2YJ/4kdKPm0fWjERc
         PRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616907; x=1719221707;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwPANurgbHg/bZQ8Fx5BluELw0V5Ey9S41+qZoHECKw=;
        b=ZS6P/MzuuaFKMYO3XWl22cwIEB0cjWx8J3BHL4REZAPJqHki50T85WLwzV+qgM+tAT
         5S1CjKJCVSA0HhdD1jxH4wMVC83bR4EqUG1aJ7orfg6bPfs+eMHeDVLAIu2/YD0vdGZR
         XiDSjYtuRv4LvaRfNcbd+75UBaSjcSf2VzPqHlZzIj1Mev9nX3l/bPvjWT6F3c3Nq11r
         tt+gyNd5VKN4u+510Fu6gKRhBziByMZH39H3ZIoixRkhSyPDw/moZMHwBXm0JFdjIa8Y
         nKIVzowA994lZJp1txF0Sej9/kr3OyuTDj0YdTcaqXDFiReZXa6uBhEAeDCJSqaAXTUf
         +H0A==
X-Forwarded-Encrypted: i=1; AJvYcCW6RSZsCfNmy/jYUbc0TWTmf3UmP6pWuotX76lROoXQz3EojZvJdo3WM7P+OdIc76IQ1ywyYsFmyj8yTBBV3+VjCcAMY3u7vA16lSlh
X-Gm-Message-State: AOJu0YxUEGAGvPGgQfQZQagp0xwdmls95h4fjPRo9dsGfF0usY9ii5Jg
	rIsGk++nC7jDi/XTElTfaMYp5G5oSszyiZ1W6T0F3WW7KYvjSRxFAEvzRsGCDsk=
X-Google-Smtp-Source: AGHT+IHGBx6pwB4k41f89sBwcN8cCQm1ojJM5khJQyC79+T1Ome1GJwJ/0v9xv2Ru99cLLhiuDCO8A==
X-Received: by 2002:a05:600c:46cd:b0:422:291:6b3e with SMTP id 5b1f17b1804b1-422b6dc8178mr119672225e9.1.1718616906922;
        Mon, 17 Jun 2024 02:35:06 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef970sm188935625e9.10.2024.06.17.02.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:35:06 -0700 (PDT)
Message-ID: <c8c2dce5680f3ac859bbedfd13edd99a2d6d1067.camel@linaro.org>
Subject: Re: [PATCH 2/2] soc: samsung: exynos-pmu: update to use
 of_syscon_register_regmap()
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, lee@kernel.org, arnd@arndb.de,
  krzk@kernel.org, alim.akhtar@samsung.com
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
  linux-kernel@vger.kernel.org, tudor.ambarus@linaro.org,
 saravanak@google.com,  willmcvicker@google.com, semen.protsenko@linaro.org,
 kernel-team@android.com
Date: Mon, 17 Jun 2024 10:35:05 +0100
In-Reply-To: <20240614140421.3172674-3-peter.griffin@linaro.org>
References: <20240614140421.3172674-1-peter.griffin@linaro.org>
	 <20240614140421.3172674-3-peter.griffin@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-14 at 15:04 +0100, Peter Griffin wrote:
> For SoCs like gs101 that need a special regmap, register this with
> of_syscon_register_regmap api, so it can be returned by
> syscon_regmap_lookup_by_phandle() and friends.
>=20
> For SoCs that don't require a custom regmap, revert back to syscon
> creating the mmio regmap rather than duplicating the logic here.
>=20
> exynos_get_pmu_regmap_by_phandle() api is also updated to retrieve
> the regmap via syscon. The exynos_get_pmu_regmap_by_phandle() api
> is kept around until fw_devlink support for syscon property is added
> for the pinctrl-samsung driver that also runs at postcore_initcall
> level.
>=20
> All other exynos client drivers can revert back to
> syscon_regmap_lookup_by_phandle().
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

With this series, the exynos5 usb phy driver works on gs101 without
having to patch it to use exynos_get_pmu_regmap_by_phandle() instead
of the standard syscon_regmap_lookup_by_phandle():

Tested-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


