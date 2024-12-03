Return-Path: <linux-kernel+bounces-429312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6819A9E1A51
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114E61668D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9354F1E25E5;
	Tue,  3 Dec 2024 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvN4th6Q"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA871E32D4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223978; cv=none; b=UuqKwmUXhcyp3niljOeAOfMgpbbUtkF+SUSZ9h4Wzoo+2aZY1zTGeqM3keDdudhWRNTZqJ1O2DmlTop5yHksk88lVVNlfPhTXXQNhWF/Q9lBXOVsfPuf6un+YpMdj8gTCSxQ9JJvlI09nICs4cf0eDUvWBAOeLTrCQosTr/M1gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223978; c=relaxed/simple;
	bh=ljSYGUKoLDTXsKObxNS/4LJp3u+C/OrF1P+fya2ivGg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rnAXzhW6ph18jmJ7AfBIKnryNh67BEC7UqxYOvNBDW2QEm5nIh2wJ0TkSY93Zpn2h2iHfZdmH5j8qBLFdNiVytvIPC7R1gImvMtvdy+nL3pz/2oerm8opSQLKs4GqTGZEdx83ZmKMIc92TNSak4wHyG90x4fD1aaXeqlyFEe0BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jvN4th6Q; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4349f160d62so45893065e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733223975; x=1733828775; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5y5ad0avUs5r379umO5xs4htnxZ4LiFXVwnGLxowvNw=;
        b=jvN4th6QFgWV6BYuy2oid2F7cnhN8eKcy1cIghtquMsYKKbt5H3jZoJeVTFiQZ5U4g
         SYtT4I8kOXfwFs2iw6y7WLsLpQsFgyxadnf7mopFboXIDnO0gdhvyT/77NjpwIJpABxF
         0dy8Q5wHWLyDp+Xiez1Vhnjkn0m3tift4Z2NXpHeQ/COacbdSj3+UsEuDwo/tq+meIOK
         Exwns69Kgc6Bk4XcMzfpdl4oE4L65JXn5CykOHpdty/3V4fMstUr1ftBC6YIShzbGzcF
         N1KPGsovVVOI3j/zYBfErODY6ebIN/6BlbEFUplLQIdla7amCSLsRPrAvdt2MkvhHaAE
         orPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733223975; x=1733828775;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5y5ad0avUs5r379umO5xs4htnxZ4LiFXVwnGLxowvNw=;
        b=ol5WR6IVefBLb03+D1lqbG51MaHnU1pE94JH+Is85uqCSbITRtPwl4gq+gPinibTHv
         a+TFSW99LoWvARleIq7ELkUgFhNX07c4xL96oyiyYlK/8y5PACby9lA6XTQlXUbSToT5
         mKIXVt+R5qNCz+LgRFTI2i1dEJkpKff5/TK1jKDi0nHp0MF9hz+ycJVqqPx702GcNdL2
         3axLzwqdtTdItMAOtUfvlW17HG4otgMFTO42oQcgCR51pIZYY7uBcUgAKRkvB5jpu/5c
         tN1IXuMNXjmc5f+Y7CWSISZZepOuvZ8+9jgP2NhZPVRSxoFGRdeOUnH9SJ4Uh16i/hB+
         LlkA==
X-Forwarded-Encrypted: i=1; AJvYcCUOVGnWCQ92W7cWmn9klNzBlgHSz7S0rTOqVQKLCadNi0jjRUyMiNyaURNCONW4AuCPxCniDq8WVdh27IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvLkdtJfKYum+dZtF5HCsr9mA1gD4DY9+jo6inXbpAECdNS0Gw
	lKE97uojtpxysyrXeGDEwOW8LmQmPGdlnY6yj5uYvkplJceDvI3YlthlsyGDNEQ=
X-Gm-Gg: ASbGnctPfRkpBSvorXzFjHERxBCwNG+qsJ7K1naH9XQCoBYiQl4q6ltKQsmEdqPIUmI
	aq7GhnfV65GZ3EpJC4aIAywZKMslOlDL8+MBxvXIIS2RIRxT9rmIN+gLAtmPfGPiWp4lVWmgGC8
	d2pwaxIapMCyOrb7UFAoOvfaVynyT+IYZqKzpn7Y89y+OY3yT9l37kQp4Qs2YOCGxL7TwU07Z6d
	2xiK9gDzGdkdktbgwzhx0BRWDYH+YJm2PDXfDDQ6LPgsgBJ26yghWA=
X-Google-Smtp-Source: AGHT+IGLmTRJVKICc1kAtHcJQX0sTL1Ubtwsn5MKrksTZEqwhDb+BEw5tNQRlwNX5ov75IPA38SNyg==
X-Received: by 2002:a05:600c:3b8c:b0:434:a4bc:535b with SMTP id 5b1f17b1804b1-434d09bf66dmr16906005e9.11.1733223975578;
        Tue, 03 Dec 2024 03:06:15 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bc5asm183847755e9.2.2024.12.03.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:06:15 -0800 (PST)
Message-ID: <d1bade77b5281c1de6b2ddcb4dbbd033e455a116.camel@linaro.org>
Subject: Re: [PATCH 1/4] power: supply: add support for max77759 fuel gauge
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Thomas Antoine <t.antoine@uclouvain.be>, Sebastian Reichel
 <sre@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Dimitri Fedrau
 <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>,  Peter Griffin <peter.griffin@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Date: Tue, 03 Dec 2024 11:06:14 +0000
In-Reply-To: <61a54367-2406-4106-bf8b-9fda4f2d11a6@uclouvain.be>
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
	 <20241202-b4-gs101_max77759_fg-v1-1-98d2fa7bfe30@uclouvain.be>
	 <c377f3302c6c282ad826211c859e2b65bb1222cb.camel@linaro.org>
	 <8f585460a1bc52f78a6d0867aed87398bde30152.camel@linaro.org>
	 <18629c9edd295a524a1c9764f013a0e97e0b275f.camel@linaro.org>
	 <61a54367-2406-4106-bf8b-9fda4f2d11a6@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-03 at 11:30 +0100, Thomas Antoine wrote:
>=20
> Should I explicitly deny their use in the code for the max77759 or is it
> just for information?

I'd probably do something like this, which will indeed deny their reading
and/or writing, both via debugfs, and also normal driver access via
readmap_read()/write() etc:

static const struct regmap_range max77759_registers[] =3D {
	regmap_reg_range(0x00, 0x4f),
	regmap_reg_range(0xb0, 0xbf),
	regmap_reg_range(0xd0, 0xd0),
	regmap_reg_range(0xdc, 0xdf),
	regmap_reg_range(0xfb, 0xfb),
	regmap_reg_range(0xff, 0xff),
};

static const struct regmap_range max77759_ro_registers[] =3D {
	regmap_reg_range(0x3d, 0x3d),
	regmap_reg_range(0xfb, 0xfb),
	regmap_reg_range(0xff, 0xff),
};

static const struct regmap_access_table max77759_write_table =3D {
	.yes_ranges =3D max77759_registers,
	.n_yes_ranges =3D ARRAY_SIZE(max77759_registers),
	.no_ranges =3D max77759_ro_registers,
	.n_no_ranges =3D ARRAY_SIZE(max77759_ro_registers),
};

static const struct regmap_access_table max77759_rd_table =3D {
	.yes_ranges =3D max77759_registers,
	.n_yes_ranges =3D ARRAY_SIZE(max77759_registers),
};

static const struct regmap_config max77759_regmap_config =3D {
	.reg_bits =3D 8,
	.val_bits =3D 8,
	.max_register =3D 0xff,
	.wr_table =3D &max77759_write_table,
	.rd_table =3D &max77759_rd_table,
	.cache_type =3D REGCACHE_NONE,
};

And maybe without cache for now. Most are probably not cacheable anyway.

Cheers,
Andre'


