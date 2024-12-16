Return-Path: <linux-kernel+bounces-448093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9139F3AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53527167CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE801D88D7;
	Mon, 16 Dec 2024 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="afZKyLTf"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A706A1D63ED
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381480; cv=none; b=cCCHWI/tIZxrYepc3Ev3TAi5+b83nKoSsENgSFrK1hWQUodVeyKiKBjQAmea2e00z3WugI3Dx4HnIO4EY+dyHY3XOpUwvzYfrjUhpnX8yy1NZqbifzg2nbgvIBk7MUEmLgpx2vLjG+xg9vnwGtyaTyCiCo5FW9D/w08p8ns5W9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381480; c=relaxed/simple;
	bh=NE1hPoXTfXueSL8XZoeJtAxIwg82btucyX54UoYPV6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wyzuh0xhx1kwAcpkIvb1OAeSJuiKYaQua3V7WDOsKZiNtk8uTZdboww/wRkCC2blYEor4wofOdEb6bVOsjFP6cJduhIrN5NPDTtfdiWBS4dsUKSM2xqJoTbSCavRE8L+7kYub4y0bjh4OSFPSERGjFobKxmFlFWAoPvxAk+rAWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=afZKyLTf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso28296785e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381477; x=1734986277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1a3TocO4QhOHi1hz8sskrSgMQ+R9urFgqr1JgbH+cmc=;
        b=afZKyLTf41m9Jcp7cEpU2bu7qhLVL+mxYDu+XbDM/I015qns5+3RcI1hxQOn/6CPCq
         2XkcF0CoAdjaKq2s9hh5azr6SpJ6788CYlxxpXjVcflOT3HM4CY/0Lsu8zxKfLKgvPwe
         mgWQTMx7Iy8bJ6sIpvRRiF3OM/53FvG6mM8lTnfo5jUKvnG+MDaJRhJ0b2GQGenNiXry
         ngoIqHcKiwUk4toBAl2VhxkZ2kZ4u6bfiRWSCOX5EogQehv/1dj5ZZuHRGK7ROa8c0by
         OgsLgBY6ZCys7ImqUKpp90iNY97lZ3h2BXBbxTBg+x6F6AomIdE54L9nPwlaLhkYnXWz
         hbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381477; x=1734986277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1a3TocO4QhOHi1hz8sskrSgMQ+R9urFgqr1JgbH+cmc=;
        b=AJlPPuGIxptEPNDWMtork3uDVHSz5bJCLvxVIuo2umOJbiH8n0hqMACgcm+ST4qms8
         MI1AKAVl/5ubY9Y0HGJfOQOEdBtxHu1agvnPqEul9px2DS2YS7XiT5Q4Wg77BiSSuoje
         TJyj6uRwLuGdEqS8uwcAb1pEhR6Oop7rIkQjGOD42B07mojRJ3yRfRCrd97+8ejcOsgK
         9ExTHZjkpI0LkE4WuY1aUE5oQYJEEhrV5xU6qZFlpD4eK/z3VXybv+acokB7fZmOnewU
         1CaAYpdW98fBYDT3S7fuopo7CdHJOY5oogoqteXZSrKA+JyUHETfnxqyiObMPbR39N/U
         icRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjMeQ5KHzgkP+vTubk5wrlcdHsS+Uu1iMlj2k1bRQZBUvmTNAMkoDnMCq1nyju/d1LS5Pku2qUlsLW69s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIff4C2Dk7jW2E/NvMM7QSf0fGX6heg9jA3yC+To+V3LcEPs/
	d9sQLC/3A5As7QApbHwOlYwctPRPHuW3fne7SWO2bBcOhmFP5j9uFEOl/ni/N+M=
X-Gm-Gg: ASbGncu1ARu1M65Tlf+gb5mfQ5/zGaNyRvJE8h/n5sf2RCRrYiWtmSoyDVjwRtlyeCV
	0NF928UTfl/tjqhr/YemZsfPfUI90yPGbjwIE3WH1WtZwkI7w38gO0DTBCX1Ejj5JGjLKtUeZmi
	J3u5xAJ/3JluBQHKnqNE6B+2NbBbYF/7psAzKkBh0/Opp5GgLA6GN9HhBx9sV28IY2ttPZg9so3
	LhJp3kRpcyGDbg4hzcj7sH3YsgKwhtjh9NFTJgivjWx22bM2mHnmHGaC+eX/tEhV6qqTjPKq1oW
	TT1wn+AXeXrlnx9E0Vy0a4myXkAFlYMQSQ==
X-Google-Smtp-Source: AGHT+IEj9m5GIAzgaSe3uUW27R9P1c5HFte/OIInIFLiV1U287XN2b9dm1z75fJaFkFxOA7MZKYrNQ==
X-Received: by 2002:a05:600c:6b12:b0:436:185f:dfae with SMTP id 5b1f17b1804b1-43648138c6bmr6465555e9.6.1734381477029;
        Mon, 16 Dec 2024 12:37:57 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:55 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 16 Dec 2024 21:36:26 +0100
Subject: [PATCH 6/8] iio: dac: ad3552r-hs: exit for error on wrong chip id
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-6-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Exit for error on wrong chip id, otherwise driver continues
with wrong assumptions.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 8974df625670..e613eee7fc11 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -326,8 +326,9 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 
 	id |= val << 8;
 	if (id != st->model_data->chip_id)
-		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
-			 AD3552R_ID, id);
+		return dev_err_probe(st->dev, -ENODEV,
+				     "chip id error, expected 0x%x, got 0x%x\n",
+				     st->model_data->chip_id, id);
 
 	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
 	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,

-- 
2.47.0


