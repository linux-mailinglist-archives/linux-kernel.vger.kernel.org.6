Return-Path: <linux-kernel+bounces-552940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7234DA58143
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 07:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C6D3AEE22
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6660B17A2FA;
	Sun,  9 Mar 2025 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="me7J/PuS"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A036BE65;
	Sun,  9 Mar 2025 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741503472; cv=none; b=P5kb8fvP4hD+umvCzozDEeG4UAJVr6vWUcmu/TkfMT3nF3VuBLwdsLgaYw7FjcbBhoOVepz8YqEQe2iWA4vel80JrILPHmGIV+EP/FaxwvSan8EDqISAv2NqZHcUDWQsQNp+P9/XhbjNUbuhWwGKw+3lIZQVvLz7sa7ZsHDyNAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741503472; c=relaxed/simple;
	bh=rz99WKtoBL/5O0++DpAUVdioGN7NnvwM+hKPSLxc750=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgr01nnuyybD6vTWklH8yaC3zwR8kX6dvmKx+vBnmOj6BkPUhgNoLonQH4vMHY/n6K1A86P+pQQVuRmiR6yG9pB0TTmQVQM8NIQoCnvHz5+yDowiJnwcUqMXG+sXJQOToJ/NKi9a4KMEOF/2Jr46uVKSOUvJNpBVv73AGMfA+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=me7J/PuS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so2158613a12.1;
        Sat, 08 Mar 2025 22:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741503470; x=1742108270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rz99WKtoBL/5O0++DpAUVdioGN7NnvwM+hKPSLxc750=;
        b=me7J/PuS+TiCgbOR5LI1kh97UuMncWS6c85KX/Yp7xHpB4rPhrlt7tpRCXb6kqs4uf
         ZFQ+XK9A1rEzPpPgkBVPSxCUVjnGOjnU8bZ6jGWjhb5gDwatHRCsAJ308Cg4qL//tuW2
         cgP7rZKjhK278YdV4eK/9Ps1HOLhA7bjfq58HdOARlMHgDhny6aBa8dTYXryDMen8Vq6
         zTM6lcHeZuzkvp4vlO4UcmjXM86pABfTBq/+qA/aAGIhPThneZquDhrRYGaYjW9ob2B4
         BrMlVEVrokJgsy2PAcRlNJIlJT3ziGWs9mQDYGW9kxHlQ2EL5HTVs1yTlo43E9LNl7uA
         aeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741503470; x=1742108270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rz99WKtoBL/5O0++DpAUVdioGN7NnvwM+hKPSLxc750=;
        b=s9AA3vFSk/+noIuNZucGURLaJvaO2wWGZvK4uKsh9/0hgOgcxcX5+FABZIIV/Ojd/u
         BQKKuVNKjha0Q47hXG9JJ7iTHz+6zKbwZhkDkMOg/PiY8BgMZcAJfUcXYa8puzc/gEY0
         eOMI5sFzPmRPeGGC+By6mMCY1jnZHWLJYFOl/Rn7MqNh8RrplVQR1I+YgAClxsEmVfKg
         1/LpZ4tKG0a2YVr+QK/yxB/f2EexD1i4DBC1183fhYQHMqHM0/dFSzJTLh3+FSY+caKu
         Szzc3DCgfkWYkqrgZOvHbFfzFlimyRK1m/OSPzC6AcisJTtWd73h+aBrfpLMF1n4rw4e
         2zCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGDQOnjCqXSZhSZ1LKU9AA6miLETYtkkE2bvSo7rCaETkRfqEhAJ2JxlGEvCfIbhy6i0clGepCW9zL@vger.kernel.org, AJvYcCWDKnzizHuGMmWo//vZ8j8IyVXPWKIO2W6wNLiVbOnd5iGzHj3b+m250XcQRMkaHy3InxN3YInVpGYbOIGI@vger.kernel.org, AJvYcCX/isk2nCsNfT21LkbEN5fK0NnVMPiN7Bi8xdVnJ20n6P+U9ws2KmlYyIi+ZXEj2hBnvWxbWuqBeLwX@vger.kernel.org
X-Gm-Message-State: AOJu0YxensQDndrMNpiD7jy70hgbZr0HLXi/C+S7C1GkcWoy7Ld+SmJw
	hlrr4T5jmOUdP2KRU2n0HaojsuxT4KS/ARVnmWp5Go/tsiIbC/kK
X-Gm-Gg: ASbGncsNy/MQms0ydroL17rC5QCaYsiI6ty0fJvUQNlGqyQP1gHA4rSnNPPUDI8AH1F
	AtdDgOugDH7PROaGnIaI43CzHoHf10oTttnzmoTm+QGsHbh9S607R9ZMSNcCDQMmmU05M6Q6RLZ
	lWvW5pg41g6U6YkcYZpv/8LfZrFVR3CYrqUAkwF8dJw16tcuBi3NCpG07PGkQ+9uRQhFh5QQFLX
	qbkqkkM7vWTGI8IBEwg7Pq/zXEn4xNf07KjT1VUTp5pYqPQp8t5vSSy5o82AApzY3NxD0rc2F+z
	j7tolDmtglmHJTsruMWplx63dubCoVETRmbhZHpVB3tM6ROYeixv2pN5uU8HgzA34w==
X-Google-Smtp-Source: AGHT+IG6jGggHPNd0SVG+UZn0rvjVy5AUuO8FA/RbV267G+XhAkHX+wbIy3z+igqgRZsFBMzaObGag==
X-Received: by 2002:a17:906:4fc7:b0:abf:6c2d:f469 with SMTP id a640c23a62f3a-ac252a883d3mr1107863966b.20.1741503469598;
        Sat, 08 Mar 2025 22:57:49 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23973a0aasm543242466b.89.2025.03.08.22.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 22:57:49 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/14] clk: sunxi-ng: a523: add bus clock gates
Date: Sun, 09 Mar 2025 07:57:47 +0100
Message-ID: <10620511.nUPlyArG6x@jernej-laptop>
In-Reply-To: <20250307002628.10684-13-andre.przywara@arm.com>
References:
 <20250307002628.10684-1-andre.przywara@arm.com>
 <20250307002628.10684-13-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 7. marec 2025 ob 01:26:26 Srednjeevropski standardni =C4=8Das je=
 Andre Przywara napisal(a):
> Add the various bus clock gates that control access to the devices'
> register interface.
> These clocks are each just one bit, typically the lower bits in some "BGR"
> (Bus Gate / Reset) registers, for each device group: one for all UARTs,
> one for all SPI interfaces, and so on.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



