Return-Path: <linux-kernel+bounces-552937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE784A5813B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 07:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A57188FDE1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669C41714C6;
	Sun,  9 Mar 2025 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6+vtyDa"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9AA1EA6F;
	Sun,  9 Mar 2025 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741503190; cv=none; b=P6dZ9zL9cc0a4GOK0vDiibmFeEVVHsXLbxb+ZCdHoIobLa2DyIC/k+POeRCJMe2BxmIWRwfS2qOdDbRxnKOmNGioVKRVjNQQx/vDf2VqtAXohpRLBflKH2KXZVvt08If+X/ybFiPPrL0CvcpsEtWGi484vcpfXlNONN6ZrWAQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741503190; c=relaxed/simple;
	bh=8FLOytRST1b7cBgnwTPUTHSCubeWY65ELvAASAoo8K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vp3N3qSdveK2X968X8iulvWmUbo42PRulWj3lKmpmso3wL+6s/CATxNuXitQus8MRWC33+rVgnRtPsvj6W4bcR5/B8ptOVE8bKIaQN1l2GRwmh+UZN7w2nbOv2jUxsCq7uqVyMgB55O86e+RRpguk9nhjWk7Ip0qBSveCu4mQHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6+vtyDa; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e64700a38cso883028a12.1;
        Sat, 08 Mar 2025 22:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741503187; x=1742107987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FLOytRST1b7cBgnwTPUTHSCubeWY65ELvAASAoo8K8=;
        b=N6+vtyDadsK1mYiJ4rdCnGzzwqtn0mtuR9awLNHs0r7jKivtbgkOTBGknS707iXDpT
         5nksaiwuw/36jkQFE+8B1rwWC07/RjjnGmI1hhC3R8Qs58GiUH62B8hMHFVHiPG2Nrdk
         7SBjoyDEtx3rvti9oZjkfToo8PeA4JBPD6yqkkw/nzZ4Wg7PikPA4auVSEvLmAdXAFay
         AjkAKsTISPO6cAwGHG/+QbKqKB8sKWL3ybW8XBvYgSRAAW8xoM11Nfdj1qYh0kb5wqus
         QS8XHimDryzl7XSbcoNbFcP6MeDgpEK/amGMyGwlJ4wy5SOYhrhgD8N+3KtCEpSSPdgC
         OGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741503187; x=1742107987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FLOytRST1b7cBgnwTPUTHSCubeWY65ELvAASAoo8K8=;
        b=xUvimwQqiMKw25vSFq5/vgivkLkN7Jmqxrt5jw8T8k21EoPJG3y3NgE7NftC9k/NEe
         22tQJS3AA1J4pcWtM3343NgHCO5iBUerKWZM+QoaNYs/JaJMyXXv5YfxGFJF4CPKb6fw
         FYtue9Jg4t5RWVyxgYrwMIsj0oEuKtbe92ByFx7c6IIM7B6xAbYlluwqDdjogyQsSnez
         1tfODh3JzjAYvb0eCF0M2KVh+Qu3HBbF/xvgAufc5bABlCjMyRRqIB+ocS4Plru2zy29
         v3q8sOmPfE/3IoQhWSzAgYAi4vlh6PO3mt6c4P285KZxsUmDqs+4BJxMC86h2i2qOJ4R
         rGVA==
X-Forwarded-Encrypted: i=1; AJvYcCVcYi/IrZknHwE5bRjvLz5f80ZB6XXfrthfEoETNzmWrKjAQDaLjlJQaNpsEkuvDuiIOY90PP9qCiJnGMcz@vger.kernel.org, AJvYcCVrrvNXVN1lHiALQvczaJMYkwDBfwC0zONGzjgyKZp7HCcF1murJzZ7r0l3vLVMUA3qkB2OLQPSlYNj@vger.kernel.org, AJvYcCWMewI2uQSfH5hfogGTIP33ps65XAllEOu0T85p8WLfi5TLsq4dzNU4YdYVe4mHsn0bw8uxR0fDXMUL@vger.kernel.org
X-Gm-Message-State: AOJu0YxAwHlYcltK/dJZoRjBlgNLRd+0lux+newf47yQvgBhc+DLj2oo
	8w5VIiwOQlsGdjtQh2EYeo1jniz1lQTHOulaaxj6fVBFCjbQHtHZ
X-Gm-Gg: ASbGnctVQxElCTHN6q8qSPqr79OUL9GO7ODdUFivlR1lZfmk9rF1HEkXcWM5+GPYcjp
	3yL1lqrKYTB7QLZihPVMGHh2zAd2GnFLn/VS+jko2tju+x5kCIRGkqTD1s3m1nYNF4Zc607ZWUq
	Vw1W452oNGb05xNP8K6qQ1TcQKonn2Hr8MN34IPH71fcroylVhFBmPHbnhNyNWj35KhvNQui/WQ
	T0/PkhSDHX3h6hoiMiubLlsulflKTau49F7HHXywZAmYOzToW4FqXU9HXuZOIKkMERrohqNmH0n
	QnItOBpd7Ih1QICNlY7Tzc6SElOjS0x3Cy8M7AkE5Z8fL+7lpDXDWrWg+SzM0EcguA==
X-Google-Smtp-Source: AGHT+IEozQjXyjRcOAbnbhkCB/GeONnnBAob1GnncFL/WgIvYzJGUOAd/PvSRjZxlM/Y0ifrf89/uw==
X-Received: by 2002:a05:6402:5387:b0:5e0:9254:c10e with SMTP id 4fb4d7f45d1cf-5e5e22dbbf6mr10635788a12.11.1741503187497;
        Sat, 08 Mar 2025 22:53:07 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a7176sm4845027a12.35.2025.03.08.22.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 22:53:06 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/14] clk: sunxi-ng: a523: add interface mod clocks
Date: Sun, 09 Mar 2025 07:53:05 +0100
Message-ID: <2978516.e9J7NaK4W3@jernej-laptop>
In-Reply-To: <20250307002628.10684-10-andre.przywara@arm.com>
References:
 <20250307002628.10684-1-andre.przywara@arm.com>
 <20250307002628.10684-10-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 7. marec 2025 ob 01:26:23 Srednjeevropski standardni =C4=8Das je=
 Andre Przywara napisal(a):
> Add the clocks driving what the user manual summarises under "interface"
> devices: raw NAND flash, MMC, SPI, EMAC, "IR" infrared, and the "GPADC"
> general purpose analogue/digital converter.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



