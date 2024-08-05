Return-Path: <linux-kernel+bounces-274284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D9E94760E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3F41F21458
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7744F149E00;
	Mon,  5 Aug 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XF73iVkY"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86131E868
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843047; cv=none; b=epjKIzsA/NdVGd/QgdedMfEnkRj+a/0cwy+Vv0NuoFUzlOHtdTq3dEr8Eu3lyMF0STsemdM5H5UCDuKsGhtsko5m9nCO4ilffv2wILWhhPnDslsQaj2Hip2FUtO0cxw7BTwaNS8V0zxMyFxndElHlpn2AWBmappm2jDCI5XXMt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843047; c=relaxed/simple;
	bh=L+M74vZQeXrFJ7Zs9DX32hy+TeQGQ8+ygEOks2os48Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tixVFmvc6x8sKMyubQthbCLiDPlRS+rhEgrFQ3eoGrgi7YQxQrrma8f4EqqDw2y1XiLEX/c2L1uFm2hENBZrMje4a40fT/QbM5UOHzwg+xMsoTPqDmuSxH++qmoInrtV8nk6oaS1zUwYXcYkXS84fyMQbW5tCqIqFqPSyB1clkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XF73iVkY; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f1870c355cso1156161fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722843044; x=1723447844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+M74vZQeXrFJ7Zs9DX32hy+TeQGQ8+ygEOks2os48Y=;
        b=XF73iVkYJ4aSevtwzG0icpxYqTrEHr/7hMEdm83hx9XiYNGssfTeI5S56YwrnT0ok+
         PVbmczyH9pME0SJSZ7OZK5/000zafPMwwNLxQ82oasVOotgvnwEg06s6VRdXH1JErnCZ
         YMK5SCo1mO/btqxfwV3iK8c2Y7zBli/N17ri+CYWvbTAJYN1yV0DB03Vdf5g+KoGScmX
         cLRzqw3mRRsKbDJ0E0Ky5xcJtv8Ws4TdX5g2oWKts47pLVadVF+fcrT5K4/U2JSM3usq
         4i4C1zawRFeUU2jxsbNDkdLBkrwNR6/KWI63pMtn+sFCamDsvW0V2qTtIxQ0wDQ9gAoV
         sPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722843044; x=1723447844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+M74vZQeXrFJ7Zs9DX32hy+TeQGQ8+ygEOks2os48Y=;
        b=Dl+oxlyJ+FsT1wsop519cR6jUAj6GqVYkSepljgfcNSxBhnsXWy/x0dXmJy/3pyVjH
         A4nygsEpyGCVLWz844z8S6vCc+zK40oka0VO8lIzxsJfvv5YCOI2nuTxozxpTHuTjkHH
         9EUUzU43myGLYajgKHR4K4LH1VcLnsnYJeeVCINzzPeydo/YMjEvgJ2RV5/nIQV5rY7J
         L7fBZDYEtL/J8UBIs3JdXm5QaSeY8Y3uWYQ4jH65RnvLo6j2tciMhF5L14QZzyrab529
         ApeOoS/Xmb7Pjj2z4Ug+tFY05Z83qouQELW++qxuQEaaT0O/ajItdACfprUcuHvOMN5s
         dKBA==
X-Forwarded-Encrypted: i=1; AJvYcCUo8nwRu0ttOGioC0gHC0tWaCty69776km/qkIMi1PS1tl595995Y+qUXwo3Tlra2+ujprVGYbG/lt05CLCBDisiQDR7OtObUXeoKqn
X-Gm-Message-State: AOJu0YxqtmDCNAdI+bTJY9j+s/qFF1ELibnPo6J4Cqsz8qsgNR0w8WkH
	jIUz/1euuDQPOqZljimg/pVoQn4ZoR3uhhpqiYlEOa8PFX3FrGfQJiXJ+AuGiJh9ikLS1vgsl7z
	6mCho6xseO57ZLuDl8VO1axsybe8OTyry7g1H6Tv5nKXfpDNo
X-Google-Smtp-Source: AGHT+IEjQ7ricigROxn0lScb+/voP0agJ/MZ7YuI0SHXP9zdAk1F7JKQWvMDbrukfXWtMUvvy1y/l3/yOr5Dw8g1POA=
X-Received: by 2002:a05:6512:e9c:b0:52c:db22:efbf with SMTP id
 2adb3069b0e04-530bb36f150mr7789093e87.16.1722843043651; Mon, 05 Aug 2024
 00:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-topic-x1e_pdc_tlmm-v1-1-e278b249d793@linaro.org>
In-Reply-To: <20240711-topic-x1e_pdc_tlmm-v1-1-e278b249d793@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 09:30:32 +0200
Message-ID: <CACRpkdbNEAjX+HBGMSfzoD3ykwfpMHbXoOfERcEjPbOC5-TbzQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: x1e80100: Update PDC hwirq map
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 11:38=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linar=
o.org> wrote:

> The current map seems to be out of sync (and includes a duplicate entry
> for GPIO193..).
>
> Replace it with the map present in shipping devices' ACPI tables.
>
> This new one seems more complete, as it e.g. contains GPIO145 (PCIE6a
> WAKE#)
>
> Fixes: 05e4941d97ef ("pinctrl: qcom: Add X1E80100 pinctrl driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Patch applied for fixes. Sorry for delays!

Yours,
Linus Walleij

