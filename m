Return-Path: <linux-kernel+bounces-288606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5CF953C54
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFB11F23312
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3ED14D6F7;
	Thu, 15 Aug 2024 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qc7iVEDM"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2D713C677
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756040; cv=none; b=rDsqUT5cawqKRA19qdK1slbvnwmwdwYwC3FdYMKpQ+fdbjafyaT6xvoDZB9UydSWCCRV6SFnV3HJMr8wtKjeUq2X1ofW3nrNiB/YoDPRhNVSdvA3q9UOZUKt2HsbtSBe1DGWGijae5kgM+HmFA9FZ3HuyG0DMWbMwFs452os+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756040; c=relaxed/simple;
	bh=BF3urCbPeBeol0sYlYbUZi+Jf8OHyrb/Wi3RqCTay40=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sO3UMmb+1oWXUd9NnNF8QKz9HlVeGDEFL46B3RBxsnPCaf+14U32Xyy/+gXwwn22O/nqxKIXLu0eTiM5gHK4YjhAmM7uRj8yyEEoCO2kkhkSgqNVppt8B4/TdZuGeYIQcl1b/7x/gexlz9ksWZDFHf/KY/HA7yVjwd5OS32ykuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qc7iVEDM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd66cddd4dso13594755ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723756037; x=1724360837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GU3FEI8r9WUvRV8pU1u7iapspQEbMTOJxe92B2n9rDo=;
        b=Qc7iVEDMuL/pk2tjdjsi5aiU/buZyhayyKXPIpuNEnfjgGfHJb6ZEsnO4NVyK4pWwv
         necThe+WKKneQhrfflIchl9HkKGURfE3JXzX0TZRDLuyT9eIJ97xKVgTv+1mf1QGUTef
         sXCrHbztSATnRWNcREHjIMlU4yEm55DIGtLCdIVTTg7ie9cZgQu+Nr5PIGfMKEMIcJCL
         eJJsz2mUepESoLlIpf6R3foe2KH7W5/ajN/0/wvuZczEkAFoQRKLUccMrnQnXm1nIhVq
         b7xiO2HVs/sfn8IYUl6yhKkfho7jHjjxF1WUBvzEbWwc91QSiTkk20ELJFpB9xTe1Wol
         jI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723756037; x=1724360837;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GU3FEI8r9WUvRV8pU1u7iapspQEbMTOJxe92B2n9rDo=;
        b=aeJU8jMZS3/naKjgo9WEBF07jCbuWJyQLN6kndBqaW4EGfSpjfV/vt7dX1dv7Lm5Db
         1nbrbCU3d1saAySyc1aA430MO/CiRHSVej7gT7/pLvefd3nbpiOloPswM+yD2MdtMj9R
         W3RZFiH3TsPedSh5vavCiwm2gR2dVDpeqXqXFXEsSKpDbA7E9TIwq/38vo3fshb5KyfC
         cK6qrfgLbp/H65BoNvcfNr0jfjTyydqgXyb485LrXMHTamlcLotg3qvX5hGyHLYm7nIz
         TdUFj/G0S5E2ZtGoDD8PW6Dh/mBbeV4joWXCn+CtbTjEajFgrzSMkvOCRAONvJP5juST
         R5ew==
X-Forwarded-Encrypted: i=1; AJvYcCXbgOmKQ1BvJTFwAdNhJ1ptDwNeqN0LqjqN0wjHnEzxGASLRMa0slD2+57gQNqWJIQOhC6blIlsTdQQu41C1n9x+WtuAHHPMwbl5dSH
X-Gm-Message-State: AOJu0YyGB9i692zS24yHpN8YDspo8XE+VKtbJwAvKR01FJXuT+Z8AJ++
	vgLtICVkWMoU9KFx2+QjiM8a4J+A19Ad/3RG5XCYCwqmMwjRH8kHwrrgbVlb9Rw=
X-Google-Smtp-Source: AGHT+IE7DC0PuZyrMxZiu7Je33kd+MzL7ueLlGL4l0yPHkA9u6HXMbV9O7yPJEcgT1AyBP5zqIVCbA==
X-Received: by 2002:a17:903:2342:b0:1fc:6c23:8a3b with SMTP id d9443c01a7336-20203e8d400mr10089755ad.17.1723756036599;
        Thu, 15 Aug 2024 14:07:16 -0700 (PDT)
Received: from [127.0.0.1] ([182.232.48.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f039fa16sm14112125ad.257.2024.08.15.14.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 14:07:16 -0700 (PDT)
Date: Fri, 16 Aug 2024 04:07:10 +0700
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: srinivas.kandagatla@linaro.org, broonie@kernel.org
CC: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, amit.pundir@linaro.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_ASoC=3A_codecs=3A_lpass-va-macro=3A?=
 =?US-ASCII?Q?_set_the_default_codec_version_for_sm8250?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240815164903.18400-1-srinivas.kandagatla@linaro.org>
References: <20240815164903.18400-1-srinivas.kandagatla@linaro.org>
Message-ID: <F07BF288-66F4-497A-A581-5FE4B7B432BD@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 15, 2024 11:49:03 PM GMT+07:00, srinivas=2Ekandagatla@linaro=2Eor=
g wrote:
>From: Srinivas Kandagatla <srinivas=2Ekandagatla@linaro=2Eorg>
>
>sm8250 and sc7280 have lpass codec version 1=2E0, as these are very old
>platforms, they do not have a reliable way to get the codec version
>from core_id registers=2E
>
>Add the version info into of_data, so that it does not need to use
>core_id registers to get version number=2E
>
>Fixes: 378918d59181 ("ASoC: codecs: lpass-macro: add helpers to get codec=
 version")
>Fixes: dbacef05898d ("ASoC: codec: lpass-rx-macro: prepare driver to acco=
mdate new codec versions")
>Fixes: 727de4fbc546 ("ASoC: codecs: lpass-wsa-macro: Correct support for =
newer v2=2E5 version")

Which commit introduced the issue? I think having just the first tag is en=
ough=2E

LGTM otherwise=2E

>Signed-off-by: Srinivas Kandagatla <srinivas=2Ekandagatla@linaro=2Eorg>
>---
> sound/soc/codecs/lpass-va-macro=2Ec | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/sound/soc/codecs/lpass-va-macro=2Ec b/sound/soc/codecs/lpass=
-va-macro=2Ec
>index 8454193ed22a=2E=2Ee95d1f29ef18 100644
>--- a/sound/soc/codecs/lpass-va-macro=2Ec
>+++ b/sound/soc/codecs/lpass-va-macro=2Ec
>@@ -228,11 +228,13 @@ struct va_macro {
> struct va_macro_data {
> 	bool has_swr_master;
> 	bool has_npl_clk;
>+	int version;
> };
>=20
> static const struct va_macro_data sm8250_va_data =3D {
> 	=2Ehas_swr_master =3D false,
> 	=2Ehas_npl_clk =3D false,
>+	=2Eversion =3D LPASS_CODEC_VERSION_1_0,
> };
>=20
> static const struct va_macro_data sm8450_va_data =3D {
>@@ -1587,7 +1589,14 @@ static int va_macro_probe(struct platform_device *=
pdev)
> 			goto err_npl;
> 	}
>=20
>-	va_macro_set_lpass_codec_version(va);
>+	/**
>+	 * old version of codecs do not have a reliable way to determine the
>+	 * version from registers, get them from soc specific data
>+	 */
>+	if (data->version)
>+		lpass_macro_set_codec_version(data->version);
>+	else /* read version from register */
>+		va_macro_set_lpass_codec_version(va);
>=20
> 	if (va->has_swr_master) {
> 		/* Set default CLK div to 1 */


--=20
With best wishes
Dmitry

