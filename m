Return-Path: <linux-kernel+bounces-171679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D478BE736
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E8C282754
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B43516ABD5;
	Tue,  7 May 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZdYdMfZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF36C168B02;
	Tue,  7 May 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095023; cv=none; b=iNyw4mNwrkPAhXTovpM0/QpNLDOImshI7raHh90/qS/hnfsqXi1kd7tiubAt48f1bY7v6uz+dKXt8OyYNMNnaHURYthtCJtAXHHvI/O+Xm62u9qRqESx42DoxlVW1rXCH8Cge5G1rg5mbWU6Ys3gs+rCELBbhWdkHhzeRfudUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095023; c=relaxed/simple;
	bh=zyJu9yBHUsDZEwiqz7xPlI0025aurXNawhHfPRrtkwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoWdokkIZThdfSeuRjKiBveF7709T8jbhnlHrJTPYMXrdAdlbO3/41dYxJwUpgq2yXLEa2GS8CKNFzFXCjADcrOAB/Fz77rBJK74M8nXQ+HOf5YcmFNQ2Gog6mEPLp0Zq9iOILOzu6pRVLr6NUpGXBDLSptlET3Ib41PlDbAp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZdYdMfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0BDC2BBFC;
	Tue,  7 May 2024 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715095023;
	bh=zyJu9yBHUsDZEwiqz7xPlI0025aurXNawhHfPRrtkwg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=pZdYdMfZiA8TSK6gKH55RQbGK5Oagt5SyYfZL0flIEayMhhFIvLbQBzYQv5c//RWK
	 BxviT6ItG19vjkwcTRYxnGhRPWTZ9vkFbbOkbPOSHU9XY1RJWh1O/Vfp4pe3Xc5QDQ
	 U4Eyx5Z+skvIEjg49wYGNGHFz3nZkjc+mOfuUYNKmXdPS+I6Pqu3qUjdCtwhGqFOGH
	 wBZETCUBut8DPWi+9Du6+Ogo/WbeH6CAoEuC5LVwP98BJ+8uCcNN3UUlREzW64bKcb
	 PHDTSu1L4IdME+R4kg39WJ+Hlj9yJo3drMSAlZjAoWhqSPptIViDbnbswwOoJJsr8s
	 0xtD9EZbvuiXg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2df848f9325so38624901fa.1;
        Tue, 07 May 2024 08:17:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYP3G9M/EAQ+XqaPIbvVh6sS5UXbWxnJbac2SN9vYOVU+PpPhLAmJMXBGdpG7rML+BcOSPES5JZRtHIxEj7AMrXEQ9HvTPC1+K0k0zo3p72wTpxbQk4+S76hlWoPF+Kr7u+/+Z5J1XyQ==
X-Gm-Message-State: AOJu0YydTjEin2vANqSQSaC9qSmcB3h/LzL7JZBtb3zdmhguckZCGKX2
	rIvJPalLs7gVKWD5uhCt9yUPfnMm2+AMesxaC1Fv49ZBLKEDCQ9HECwNMjZBHxF5OkFSEPHuuuT
	I+zfNPQFIjxrJ+iSXJ05jgxCLLKs=
X-Google-Smtp-Source: AGHT+IEHukVmyg4VBnBczawNkg5xVFPgcAhPJDAvsYtrkmQdlKZstUvc83S09YCQ/qrduDkmFw5t2m++iSbLEQQBNMY=
X-Received: by 2002:a2e:a212:0:b0:2df:e2d1:f4b5 with SMTP id
 h18-20020a2ea212000000b002dfe2d1f4b5mr9127593ljm.21.1715095021888; Tue, 07
 May 2024 08:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507041343.272569-1-wens@kernel.org> <Zjo-sri2pdGvKhSf@finisterre.sirena.org.uk>
In-Reply-To: <Zjo-sri2pdGvKhSf@finisterre.sirena.org.uk>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 7 May 2024 23:16:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Avo0X-NRt5AxfsiZOuAAp2MgBxJBn5hu2yN6PjdtDFA@mail.gmail.com>
Message-ID: <CAGb2v67Avo0X-NRt5AxfsiZOuAAp2MgBxJBn5hu2yN6PjdtDFA@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 0/2] regulator: sun20i: Add Allwinner D1 LDOs driver
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 10:46=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, May 07, 2024 at 12:13:41PM +0800, Chen-Yu Tsai wrote:
>
> > This is a resend of the Allwinner D1 LDO driver series, separated by
> > subsystem. This part contains just the regulator driver bits. The sunxi
> > SRAM binding part will be sent out after the merge window due to a
> > conflict in next.
>
> ...
>
> > A binding and driver change is required for the SRAM controller, to
> > accept the regulators device as its child node.
>
> This says that the driver depends on the SRAM change which isn't getting
> merged this time round?

The SRAM driver change was already merged. The regulator DT binding doesn't
depend on the SRAM binding change; it's the other way around: the SRAM
binding change adds a reference to the new regulator binding.

Hope that explains things.

ChenYu

