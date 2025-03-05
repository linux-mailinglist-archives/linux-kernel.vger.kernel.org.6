Return-Path: <linux-kernel+bounces-547520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF49A50A5D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4E83A542F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC0D25333B;
	Wed,  5 Mar 2025 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQCh0ecO"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067741DD9AC;
	Wed,  5 Mar 2025 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200855; cv=none; b=RAhHiPW78BpAw5hzwxG9S3GJcQLfESZxs6FvwhsG2PYcq7NJWXCey54z8OY1PMPDjRAely6MVIs/tWCShsoKrF+Yu09Yo3i1VbHtoM+nE3q/INMHai057DUVXNoXx0PVruYAk0TU3HoMnsxT8M894gTkPPe1lXnZwUvPyDu1bhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200855; c=relaxed/simple;
	bh=1IKgsVfO8AFngCF533cDPpX+Sfrno9eJbAhfD0kB+ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITBP5s8I0x1We7kQDAzWyWXYs/rbvrrlMtm2GDWq7Fq7rvO3FT1ScJaBo8sN4UYT1bFUPjcaQYvhzSlpJg+Y+9IFN26Vrp3c26N4iBtt/MBqG/w3uK/wSJ+mCkRJTa8vxmecRPZ277tX2rU5uMaX/33nYiZ9TF49TezjTvE0Nrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQCh0ecO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso77829395e9.1;
        Wed, 05 Mar 2025 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741200852; x=1741805652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTEPlivf57KNf0u9yF+nL78ShRAOQbbl1KlRhOM3FSk=;
        b=DQCh0ecO+UEqtuGE35iqY8xkOuQc/PtmHIjFDtoEg8ek3wvOY6BMoR980TfMAdApMy
         A5oiFZPseSH6ndIj7mLkKQQdamXbecxfQ5fXdlpItxAk2+XIPq6Sc9luTpRYrO24yR+L
         NNfLT//nwM55Z6TV/m5SGw30pc1s8RGQ95auDr6Wp1ukiLHUrX5hCrMjOrmuGf0K78zb
         YujecUV9Vaox2kwwtTyTMcfeG4nePJ6W8uw8Jjqi7ZNm79IBEoi+VQHI/ZTpG0chyb55
         e1Ya8OYxztxlVUk84oc32HK/0ZI2R12wSawiRelba2q7Mx0YAGwkocXtBO9jfdxTjxah
         IBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741200852; x=1741805652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTEPlivf57KNf0u9yF+nL78ShRAOQbbl1KlRhOM3FSk=;
        b=UwFpb/zGXlccAhjP7TkjKcDvIkLMKG6xhieLgEjEG34VNLAfz2Vo8Kvs65j9GWxeve
         zdX0gsC94YmfIlL8E9qaT1bTKA3oJ7/4TXZ/0prFaKyw3wFBcFE2ocfUETwwO6vEyO9a
         Zp8TihNbQCgLHOF704cEdSOvQdN9WbC6T0bzWTgF9xQynWXb7RanDrNa+C+qU24/+3q3
         9BEQiD5XYVAERxoi338T32J571He3MT552PitpmNXzm09Uos4ZDdsoQ3O2e6QyF1POMG
         e7tup2Nhow628VpzXbXURVHQ13xbRKVi44qEWQhr/aLP9Ds06H0nFPBNZQEC37tMpDNr
         jluQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGbNzLNG47Zjj5wVV47Oy6ZIWOErGCM5b4LUKnnhoJzMg8t7mCYLlEVbWm/QG0xy/AxpbMf9B3YTgvqHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQb2ZGtwOv+dNZgDkI8MPj0a+ZCpekubvk6QMOn4/Rz4WqH+en
	Me0CwbvyopIx4wRePA8NFERyAjBad/2mzYEH5oDG2llMre1sD1Ar
X-Gm-Gg: ASbGncsy36+q+79MKKK0W+eK8nI2Ml99O0TSquhw4FFwKTOxZ4L7Z1v+2EuDXFtDJGO
	Mv2WiG4b8NGq1wJ/kEcz90/es1RVilBfD0Z/cLtwp13tbDfIoDPrTHwbSDJ9mlb+rvuI3+20Z4u
	FfmBFgjDkjS/lWIqixKvuCzOaZf5DxGMfkz5FOE4Fix6tBfq8JuV7JW/iuq2G3ayoSUxBrnEKGq
	sQk4CuhzbrgQBWPyG2z7RsC7Mc8cNDrwJvjgVIZSjj5XS1eM5zKxa1Jg04VhYbFW9LlkqAnzbSo
	5lBkJ0uq6SPgcvPsNNPIwSG8IjZInqIS+pkBcIX/o2lNqn6d/funGegfTE76WzrJ2c1IkJ/K0vc
	oxdyjXYg16gC1it18T17m
X-Google-Smtp-Source: AGHT+IFq7ByBMzrdcbNey9rPMwFoH0XXCXvSqwidIYHLYAKpglo0B8dEBkmtmZjPTAu9SsK5oJOomg==
X-Received: by 2002:a05:6000:1f82:b0:390:f75e:f815 with SMTP id ffacd0b85a97d-3911f7543a6mr4658220f8f.23.1741200851871;
        Wed, 05 Mar 2025 10:54:11 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47965ddsm22312099f8f.18.2025.03.05.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:54:11 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 15/15] arm64: dts: allwinner: h616: add YuzukiHD Chameleon
 support
Date: Wed, 05 Mar 2025 19:54:10 +0100
Message-ID: <2227598.Icojqenx9y@jernej-laptop>
In-Reply-To: <20250304222309.29385-16-andre.przywara@arm.com>
References:
 <20250304222309.29385-1-andre.przywara@arm.com>
 <20250304222309.29385-16-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 4. marec 2025 ob 23:23:09 Srednjeevropski standardni =C4=8Das je=
 Andre Przywara napisal(a):
> The Chameleon board is an OpenHardware devboard made by YuzukiTsuru.
> The form factor resembles the Raspberry Pi Model A boards, though it
> differs significantly in its features:
>=20
>   - Allwinner H618 SoC (4 * Arm Cortex-A53 cores, 1MB L2 cache, 1.4 GHz)
>   - between 512MiB and 2GiB DDR3 DRAM
>   - up to 128 GiB eMMC flash
>   - AXP313a PMIC
>   - 100 Mbit/s Ethernet pins on a header
>   - XR829 WIFI+Bluetooth chip
>   - 4 * USB 2.0 USB-C ports
>   - microSD card slot
>   - 3.5mm A/V port
>=20
> Add the devicetree describing the board's peripherals and their
> connections.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



