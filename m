Return-Path: <linux-kernel+bounces-205438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33BE8FFBD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C6D1F21847
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E268514F133;
	Fri,  7 Jun 2024 06:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAERxGI8"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04F1BC2F;
	Fri,  7 Jun 2024 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717740398; cv=none; b=PTakbqCD8bdce/irKTHM+VI4enkxnO8jq/C0LnrrJDUUI25yt52qxql3r0kSYqzgyYe5AJGfOJk4i3RJLS2vj3Zx7SXlwgBFtHDrdpB1fGaQBDXlSke8LSBOyJP+HUxNinV3EgTUdsT8WgqjRVxjvD5clz5gZJEmFUuIV/gEa5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717740398; c=relaxed/simple;
	bh=jNZkxBEs7U5TdwARCjZjVhwqyxR/ZXTvzrddGfOudKA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SU7O4GIn/WIuYula//qPWkGeSCXgR+0x9Fv6HwmeS2YxxZCZu35jsKcYxA2LZK9geiSmUGcMd3s0ylI87TE2yfgbv99yvxiRegTXUtF0PJv9NEJrlH525hm6xR4P2WcWbYyEPMPmge4Kh0yBHwN0eb+x/Wga5/KwwgGiqkD9bBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAERxGI8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35dd0c06577so1779188f8f.2;
        Thu, 06 Jun 2024 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717740395; x=1718345195; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNZkxBEs7U5TdwARCjZjVhwqyxR/ZXTvzrddGfOudKA=;
        b=dAERxGI8++50YtItabwAiNuQR1Zp+tgjBNEQzMQorMHD7XbtGd53jp6qdHqzwxKxwT
         j8SnSwJZB1EMdx4ipHxpRZm8L6CHGDlC7B8YL77evXL2OwMqk5obeMpjG3Qjf8OlPU0M
         KQ8iTcwZYovbtpoyXfMzI9XPxFEnEeOSDMFRIUrPGj1z5tE9Ba8URgDOFMO9G3UD9o4r
         aoJhp+mK0+vuylKY5fHPhy+MaznJqSyNjpIR8bo+lwEnQrpCG5ds0GEHqkz31Ll6IHmW
         YXPXFr0oleBHNn18a46NHkHOl9lFjOBtd2yDteawikbiVS2XyXdHyEeR9YE2lV55fUtg
         OTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717740395; x=1718345195;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNZkxBEs7U5TdwARCjZjVhwqyxR/ZXTvzrddGfOudKA=;
        b=tq7OrEpoD2uHq3yaq7dUAC4oAaQe/po5kdgjlTtkKhAW7KpG8sWbmw8qNCLgCbi5Sd
         yMAtJ1aUd2mAcV3sOORqQ6dfrD/VoldiIQvmJs/DKBhBzoUa0dd99uCjh3ERA3JIPVaO
         YL6+epJYxToRtXv0586vczpxmXCfY3dani+6kXiu7EYBDoWTazclOV2aM1md6S7EQaaz
         3in/0cCmnTM5wR+zX4325IqBCrf4d66qqC5vAhSOKxaVEQnXC8p573EHoiAResqTJ1FL
         hhShTAy/89CLkIBNQMfuTswvwjwJc71sUD/Er47V4MSjPV9KY6tnkru47w1GLf8FC1KV
         3F/g==
X-Forwarded-Encrypted: i=1; AJvYcCXqnbysRUbLypYMZow3+iLFgEc9kjCv3EHtzDw4Z0xiNdpHSWQOJoz/n5lQXisB4H0SGpac4/FV6vfbZ2yDwGOa4jR/tv+zj3gF+YtvP7+AK516ZyyNHYy88+2YZFMtMna73aSyzJ8Anw==
X-Gm-Message-State: AOJu0YyPqQ4dpbwEoNgQswDDy4JLsV2eGg2/kWrBucNtSyUV+IktiJi2
	p6s1Fe5Qszx32W2QZU9pgMAHGT7x8EOlj40EeFzE6LUEe/QLDEWl
X-Google-Smtp-Source: AGHT+IEgwZKufWc5FwUuSbx7D4i1LN7jDSiJEogiwEw6n1p0cNIWxHRj+ziKiW0p1rfT+aXoS165cg==
X-Received: by 2002:a5d:45c9:0:b0:34f:f540:bdbc with SMTP id ffacd0b85a97d-35efed64bdamr1061157f8f.38.1717740394602;
        Thu, 06 Jun 2024 23:06:34 -0700 (PDT)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d69867sm3230511f8f.57.2024.06.06.23.06.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2024 23:06:34 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH 00/12] arm64: meson: bunch of DT fixes, take 4 (final one
 ??)
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
Date: Fri, 7 Jun 2024 10:06:20 +0400
Cc: Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 AML <linux-amlogic@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <34243887-1D78-4D1E-BBB9-607297813CC7@gmail.com>
References: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: Apple Mail (2.3774.600.62)

> On 6 Jun 2024, at 12:48=E2=80=AFPM, Neil Armstrong =
<neil.armstrong@linaro.org> wrote:
>=20
> Along with the following:
> - =
https://lore.kernel.org/all/20240422-t7-reset-v2-1-cb82271d3296@amlogic.co=
m/
> - =
https://lore.kernel.org/all/20240513224552.800153-1-jan.dakinevich@saluted=
evices.com/
> - =
https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes=
-power-domains-spifc-v1-1-380f29ba4a16@linaro.org/
> - =
https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-conve=
rt-spdif-receiver-v1-1-262465adbac2@linaro.org/
> - =
https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes=
-power-domains-mmc-v1-1-4acbb8cc2626@linaro.org/
> - =
https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes=
-power-domains-nvmem-v1-1-ef6f10c86a63@linaro.org/
> - =
https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes=
-power-domains-phy-v1-1-c819b0ecd8c8@linaro.org/
> - =
https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes=
-power-domains-rng-v1-1-0a55a7ba55e4@linaro.org/
> - =
https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes=
-audio-widgets-v1-1-65bd7cc2e09b@linaro.org/
> - =
https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes=
-power-domains-sardac-v1-1-40a8de6baa59@linaro.org/
> - =
https://lore.kernel.org/all/20240606-topic-amlogic-upstream-bindings-conve=
rt-g12a-tohdmitx-v2-1-70d44fa30790@linaro.org/
>=20
> this bunch of changes fixes 99% of the remaining dts check errors.
>=20
> The two remaining bindings conversions for arm64/amlogic are:
> - ti,tas5707
> - everest,es7241
>=20
> I'm too lazy to do them right now, so if someone is interested
> in doing the conversion, please do it!
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

For the series, tested with multiple =E2=80=98meson=E2=80=99 boards =
(GXBB/GXL/GXM/G12B):

Tested-by: Christian Hewitt <christianshewitt@gmail.com>=

