Return-Path: <linux-kernel+bounces-211128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7481904D81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B662883A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9758116DEA1;
	Wed, 12 Jun 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOpl2w/R"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD2345948
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179394; cv=none; b=NvmWUx1DeywNMzaKulKCQPedE0eYOzllzyR59SFA3OxEWDCotDTME5OypYRVLqaVs0Ihy49Ym2IhmShsPTxmeIW/cJ1ff7t+RPJsZnIHQYPUIlggH1d9dYM9ZFqe6RIl9MvJmJdOJBjFP6Q/weGIhs0AH+ogW4Czq9cERl+aSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179394; c=relaxed/simple;
	bh=w4GPNplcnOrxjX9LxJ2UyHSylkkAakamu/YIwBqrUQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMb+z9M3IsZFVVCPQuofJqHUcHjJvnUzhpq02r2zmMNl4won4ChooyuUlJlsCLofu9u3sSrljho+1Qd00jkz2qpeyEB0odv51kr4ZdlZ4xRaI5LyE4PNyqvxmjfSFlDZj5YgWouHDHRKt5lVeRRnqKJoCo9DwcmB1HBj+ujnOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IOpl2w/R; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a5bcfb2d3so4678401a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718179391; x=1718784191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEEQoekQRon+t3gUDKwXNDGB0vL1Zgsl9jkaeNoSvtw=;
        b=IOpl2w/RoVlMxlbW8zBKCki3huobe99tALVgbjtCQ4NZ79zHDscf2gCBwWf029dAo+
         NvPDM+oqH3L8u3VKm4VBL1sntqkaPQCw19gmgTxrMHpC/V8qcql5YWRCy9H2zI71KgL6
         Po8hM5Tr6hVBg6us22tjEYHNVX+ttx2D7f5NLoRLBxRyBQWaVNBvB1WlhagtDMUOGj8K
         lecO4evdp75LIX5hAROm/ppUF66Gax+p5hThA1glv0bc6+a78jQFfOMzGCoyaSajIllk
         Me1DpeH22QIJUXbxqs+ACtbWLMYwPdNUO/b77aNcFWJLP/2cZlldCzd+mKPYUzuR8SE3
         3P7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179391; x=1718784191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEEQoekQRon+t3gUDKwXNDGB0vL1Zgsl9jkaeNoSvtw=;
        b=SGuT3RG/aOwCOiR9QBgpewZaKla/zj2VHE0TCPRUfTczGsZvoJWgEZBD/Yi8aNAJEX
         h80jcWM403+8DOsU7OTgraMqrcblZebrv86UDIf2GnIBoJdw3C/5uqJnzr4lyAbZxexs
         z6T9ncoy8/pQHJuoLcSu8ZCIipwn2ZsSr5V7V54h+vkilwJ4KEYuSHXxrd/ZAVkFpQgw
         3iSa4MtJyzBHPEldvtqf4yu+ic2g7Ondb48EwhFVJS6Z7xcO2aCulmmampshr/hJFsj9
         NdpMVkOw2YezASxc0vrnWRJILh+87lskcSQuZHHG7V1OeJvh30VGoTy8JOwtPLqa2pqT
         AH2g==
X-Forwarded-Encrypted: i=1; AJvYcCUS1mg9AXb+jNNtrDZSCIBsZ4VRwd7cC6q1ydM1Yh4QA0QLoeS5QDt+v3GsD55tSyHQElGJJl+pmvt09gkxZuJTc1I+n+E7uxUspfNZ
X-Gm-Message-State: AOJu0Yyd5/6NNeGySnDewIJBAdBDRecLH6EoDkfp5Il5Z4f9+wkTQIJ5
	qDYWj1sivAvxaoVJm6u6q+Mb0xqDkmu+fYncdRsubba0148+FMShIYhATo+Fh3YoDgH0Ld+MQav
	F7dOUwjzoP+hC8Df0fIdgkGtdx7OIf2OWLuc3vg==
X-Google-Smtp-Source: AGHT+IG3DkdnwCX7yWoeLqpWN1gPYZHoua+wApHjAc3xsU9wEXw7nl/lYk3pClx+tXAPMxhOztwxQVIAAQzvweUAOg8=
X-Received: by 2002:a50:9e2e:0:b0:57c:ad96:14c8 with SMTP id
 4fb4d7f45d1cf-57cad961876mr323057a12.23.1718179390979; Wed, 12 Jun 2024
 01:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-samsung-usb-phy-fixes-v1-0-4ccba5afa7cc@linaro.org> <20240507-samsung-usb-phy-fixes-v1-1-4ccba5afa7cc@linaro.org>
In-Reply-To: <20240507-samsung-usb-phy-fixes-v1-1-4ccba5afa7cc@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 12 Jun 2024 09:02:57 +0100
Message-ID: <CADrjBPocKu4iSLBu12RdLVo7O3FujF-346aYBOWCn3JutyjX9Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] phy: exynos5-usbdrd: uniform order of register bit macros
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Tue, 7 May 2024 at 15:14, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> Most of the macros are ordered high -> low, but there are some
> outliers.
>
> Order them all uniformly from high to low. This will allow adding
> additional register (field) definitions in a consistent way.
>
> While at it, also remove some extra empty lines to group register bit
> field definitions together with the relevant register. This makes the
> registers easier to distinguish visually.
>
> No functional change.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by:  Peter Griffin <peter.griffin@linaro.org>

regards,

Peter

[..]

