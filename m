Return-Path: <linux-kernel+bounces-552934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D562CA58132
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 07:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C30AF7A6386
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B13416A959;
	Sun,  9 Mar 2025 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSEgaBBx"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9A233E7;
	Sun,  9 Mar 2025 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741502983; cv=none; b=G551JIyZEF+SzbqH1HvQMcP1IWw/Km5FdqF+kNcVNi0P/pSbrr+1X44ri+9ZQnyamliDO2aakxa5OeUcvsFR8gA2kAZKLrIKt+BZXlrVnLQIzrdSLo6toOkFkIIVrtUElkaRc6wk+mehiD+BBbYLjHCB4fImo4zkV18dUz1gfMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741502983; c=relaxed/simple;
	bh=cl65f/0t7FsLCASGiewdIE8SaLE0/OtzJdiDvPmWgAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7iw3GGVDWLE6Lc9qTABhZrJHb12HOXge5lObA+MAFN9qPDcQlX39yBBCCn9I6uzd203A8a5lTgj9c63WswwWQ4xNjasmruXcA/epWYe0sMJrdjhTcBNCBdLQzx6BtvJ7A/2q7KrbyMhzyyFUm9lU2lE3MqeREImX1JXhC2PrVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSEgaBBx; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb379so5283139a12.3;
        Sat, 08 Mar 2025 22:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741502980; x=1742107780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cl65f/0t7FsLCASGiewdIE8SaLE0/OtzJdiDvPmWgAE=;
        b=aSEgaBBxrObP7qG8nVD35uDHURkoECdRa0vAH27BGxK5Qa4HZQsf7Yoj1wu/i/1hek
         96ym1ag8GDETGMCFomqQhlbUOVxeXI6PvZi/3Wgho0CVD45ltT6lT8n6fJNfFtrzm9pH
         r5pPXlNLpd64zGkAF2sKK6ptMshzkWbi2Y3TG2dHnU8pd+9e0xZE+xIWCxq4rNZChGBb
         3qnKnJzyNDzZybDUOUSsp1vtyTKUVQkMtvHGfCmUBYoT0FPEf5HjQ9PSgf2jlX6NiGsr
         1MMbMBKYrasFZJKDhIGD5j/xLgTFZU7niETYFtA3YPqZDw5btFbVHyTvr6f6jE4J2pqI
         IVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741502980; x=1742107780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cl65f/0t7FsLCASGiewdIE8SaLE0/OtzJdiDvPmWgAE=;
        b=BlBGwMTDWsuFURmmMf1TdFVOHToPLu0yOD557drnwutK0jZeVd7GxUDZ8Jxv/3ueSv
         jDJTYVDBZuEKTtTzc/F5I5O6lsN5YyTaBPzdWLZDJFNlu7Qp0CSCywPngDcA1OKwoZxs
         RFLIx1PucVdaqOHSsUrsuvTOXnawCSTrVpNMzJ8CzidY5aAHu3/Z/An9L4BWRMkVu9yE
         jxWAbE8wrEVhQmk2MmrYlIffiTYhQkSm/tA4B1kxazOm8V5oMgTo1o6zkGMd+KJm2e8C
         twVKCT2EsoXka8Gzahr+OartGkiW5dQWA3H9hmXhL7FgTPWz/kB1zofZrBryXLzVxjdQ
         aUZg==
X-Forwarded-Encrypted: i=1; AJvYcCUnRsaH7LhREWDY1+FSSZUdZoleww7Dwv5J9svysskQIe72zmCE190kMwQCoAn3r1esAUWfXc2Sv8Lg@vger.kernel.org, AJvYcCWqGpstyh/n+SDntHnoFS+loVpRhCHJV4GLy/oHtw9pfO1Sw+1+Efzle56Px5D/jOEkd8HBa62xdy4m@vger.kernel.org, AJvYcCWvMXpB+BY+tFFI+cZC2DKjGAViyZyAJOyP7XukEc5KCdsu8QbgWbYr9jhsGHVLgUVLE1ylVT+3dWQWfT9o@vger.kernel.org
X-Gm-Message-State: AOJu0YwZHpRPM7FfW//AYLiHIYcnOQzlEzVeOELvC1IoT9mrFng1TWkv
	mnzInPD8yYumDgnJ8EfODBwkjgGTSlURX5v8+GwKPleoQZ0s5MPS
X-Gm-Gg: ASbGncu8nB9NDqXnkTLU2JuV+f+47kOaHZgtOkULk1+LfceN6xCZ3C8YyX6UNI0GqzL
	yB20cCPxXtS6OMMftTwbZOwllUOE5x4SSS5A0Hm+hvC5eGS/52eeiHt4zn0u3mCiasKNU06k/6k
	C8czlvjJI9BLc3GDbzszencxYxodwgZ/bPSKkychTpUjzYa3GxKd2rSYaxvfr2/rqm2bKb1K0RY
	gf4riwqQul1lzkduF626sI4EJ71VuQhMAD9Vs/C8nuJ6DKPsqPjmElNREURCq8Vp55TylBs9iez
	1yL79fAmO7yVKbBDPlUDlfl6n48k88gBsH2H+ud6OQ57fooDcrdLh89fKo7S+ZTOpw==
X-Google-Smtp-Source: AGHT+IFI/zjd7lG5rPco3cg8PnFl2h9bozpdBtlW5SATxdyS7wM6nxNoH3ZloBa8WWl8S2snqJH40g==
X-Received: by 2002:a05:6402:1e93:b0:5e4:c7be:f8bd with SMTP id 4fb4d7f45d1cf-5e5e24ddabcmr9224865a12.21.1741502980045;
        Sat, 08 Mar 2025 22:49:40 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7669fd0sm4835570a12.51.2025.03.08.22.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 22:49:38 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/14] clk: sunxi-ng: a523: add video mod clocks
Date: Sun, 09 Mar 2025 07:49:36 +0100
Message-ID: <4963134.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20250307002628.10684-8-andre.przywara@arm.com>
References:
 <20250307002628.10684-1-andre.przywara@arm.com>
 <20250307002628.10684-8-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 7. marec 2025 ob 01:26:21 Srednjeevropski standardni =C4=8Das je=
 Andre Przywara napisal(a):
> Add the clocks driving the various video subsystems of the SoC: the "DE"
> display engine, the "DI" deinterlacer, the "G2D" 2D graphics system, the
> Mali "GPU", the "VE" video engine, its associated IOMMU, as well as the
> clocks for the various video output drivers (HDMI, DP, LCDs).
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



