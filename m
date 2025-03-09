Return-Path: <linux-kernel+bounces-552943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC443A5814B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 08:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2755E189040B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 07:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA70117A30D;
	Sun,  9 Mar 2025 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISO4OBtC"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9070C20330;
	Sun,  9 Mar 2025 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741503824; cv=none; b=lICDUFTaehn6iPtTvRGv8WoOA/BdB1/7zA04TEDKUAwNvryOQeUPR9E6oPkzgcOp7yZt8/LQ2YBmhNwQD8WoM4RV80q/jwxa7qmNmhRaJFGWFHIXZHVMAwS2q/f9nMQIN3jqzSlN8L4usegcR6DoPpT4o3jv0W1+fSVxtHntNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741503824; c=relaxed/simple;
	bh=4/qs3Uwkfo+ukkyY7y6RUTEw3elPT4tc7TjK0JH5xRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NiNoBz2nlX0cb44d3OIIELUfRvjg8OL45Plb/VPhSSgQdqDpTwQP7suhBUmVYtyMbfd2QT9ssfEwRgOO0lIdl08nSieGWassaoOjWCDIFYxSqLEW0DuRN9BbKgS1FNDIuLPq3uydnyLgAE5wTfl1ujXY6XwwmMckqPjAee7+XLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISO4OBtC; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so3902991a12.1;
        Sat, 08 Mar 2025 23:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741503821; x=1742108621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/qs3Uwkfo+ukkyY7y6RUTEw3elPT4tc7TjK0JH5xRw=;
        b=ISO4OBtCEegOvn2NKxrdPNSJwP/rrSXZ4b71E5hvrlIHVM0XoOehSkb9W8F1oKFHmP
         QoCIvqjrbeCoSN0E9KcH+oMWuv4cibMHrE3TF+pEwOZ6kVMAPYi58P+yiuwi3xMdhEft
         Qr9yTsgKiMnE7rO8Wcn4z4PaM2Am4xdwoYEXP7YoeH7ydYyMRl8LcyTcyFcJBgYRywoY
         b1Y7/UGccw+2ghtqKDGrcHqmIhKB4a6uaqiNHWEVV7Clfl0iEoILvE1K06yyxHm7teCy
         mIYnmkiiTHmSg09y3p3gaLmNlOj2tkpdAfx0wZyQRHdnMr3/tEZKKB7D2RmKuUhsZXkg
         Hldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741503821; x=1742108621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/qs3Uwkfo+ukkyY7y6RUTEw3elPT4tc7TjK0JH5xRw=;
        b=p+1EFfiq2Osp+LrLZlFJr/4wFudrZinYuXT/8BXmLvAFuTySQTJITWwzW+8mhLN9p1
         kXTb2mRhc2htMSCcg4Nr054TOZZ4pQkpJLKLG0Z0xeihYjBQer79/0plTpQUvykqwjYJ
         dce9huc9GTNKegRHZEVWjHC/WXA4cH9VWCAXO8fCCtm3TggVGaYSPfo+98AKwPprGdqk
         4bNOR4/jvSC7l0EFiq1eqXVG0RpfdKqMIf7Q9Hg+gW3M/umiwhRMtdTEvgUN34P9jXxH
         bkOo9XHwlAWVTuTk6OonQFZTinyIA0CcqalZ0IhbC5QJECqMLykUge6FrlHfvmyxQvzx
         sKyw==
X-Forwarded-Encrypted: i=1; AJvYcCUvUJHq37BmwH7wPtd8mZoWo1g9Ds2WGd4+hI3lbeRjlwyOijuqfl/qsid5TgsdWfIK7gopRWMQkfYU@vger.kernel.org, AJvYcCV/u5/Q56vb/IROaFTprTKlypS5MbtrfiPvPtCZkIMt0vhrFnxaGXvHZRg7p4ropcTeLv0u3skhBjKW@vger.kernel.org, AJvYcCVP8S77izAU41JqN98y0eCQibcMEmSZC6lE++u3D7qvW392JjAQnyPmi1rnayB/0WyQv9cM4uSOxq7QMruQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyQC0fvZ+Dbm55xShfU7/lxlhScTJNEXwG/LVoO669oFtJ0RYp9
	9hPX0AcK0EC/hrcfc5yK0ir07uCZkPWGD+WocBT9DB/G4/5vvT3c
X-Gm-Gg: ASbGncur+36klFXxPgi9rNyMqJosWefJOxr1YVRt1YLlXMNZ5O3G/DeLXJEVlXEdN3o
	VpN3WwA/Cq/IFH8Zq3EZeBYtMoKj9tcXCYEFUH27ocug0dMdxc8qxxEcS8sV1WP5WcGjc/10uzQ
	sQTYwWPrvHnIb6KBKOX0v9umjAH9TiOOMZgd4BZEsETZka7zNSKweisANxMNq6TnYgzPIyZ4GPU
	Y2t7RDNwLusQV0byVDQu0MOG3vl0au/CsefK/+Jzu+rpZctqHhE3V8yWF/GTKM8JWlVRGCkMjZK
	apF81jLn31DltwA+flMkNzdVSVzQEE8/TtOzUlS6GCw4fDTOkUcYqDT13BFox/UVwPrOVKRM211
	C
X-Google-Smtp-Source: AGHT+IGMCqfgtOksXCU2D5pV4LcZbxKnKSmq361rjbRlUZqwxHJQeerhBdOB3YccYo/fjODMlK3Onw==
X-Received: by 2002:a17:907:26c9:b0:ac2:166f:42fc with SMTP id a640c23a62f3a-ac2530200bdmr963517966b.52.1741503820537;
        Sat, 08 Mar 2025 23:03:40 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac298412a9asm21402166b.156.2025.03.08.23.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 23:03:40 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v4 14/14] clk: sunxi-ng: add support for the A523/T527 PRCM CCU
Date: Sun, 09 Mar 2025 08:03:38 +0100
Message-ID: <7776158.EvYhyI6sBW@jernej-laptop>
In-Reply-To: <20250307002628.10684-15-andre.przywara@arm.com>
References:
 <20250307002628.10684-1-andre.przywara@arm.com>
 <20250307002628.10684-15-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 7. marec 2025 ob 01:26:28 Srednjeevropski standardni =C4=8Das je=
 Andre Przywara napisal(a):
> The A523/T527 SoCs have clock/reset controls in the PRCM part, like many
> previous SoCs. For a change, the whole PRCM is documented in the A523
> manual, including the system bus tree, so we can describe all those
> clocks correctly based on that. There layout seems to be derived from
> the H6 and H616 PRCM CCUs, though there are more clocks, and many clocks
> have subtly changed.
>=20
> Describe all the mod and gate clocks, including the three bus clocks
> (R_AHB, R_APB0, and R_APB1).
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



