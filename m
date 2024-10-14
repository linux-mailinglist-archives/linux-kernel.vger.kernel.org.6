Return-Path: <linux-kernel+bounces-364199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633BE99CCA1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946661C21FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA291A76AC;
	Mon, 14 Oct 2024 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZquEgqO"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EEC1547F3;
	Mon, 14 Oct 2024 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915625; cv=none; b=PDi1nrrpT0SKEx91SNQ2f6QoWtXdI1/J9Jl0t/t8+AJMeYnu+iFHIZRT8Ymz5AUyWSjHpkVKeYjWwf2sLqDxa1/LIeutB6aTfTUkyKR+52dUeVStnKaZhLRjUNOZEQLPGH54lPvWLp9Z0bFDZOEKlrnQcAF1sxI6AmuN4Lyq33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915625; c=relaxed/simple;
	bh=1U2eFcy8btOrX7BWJkQL0y+3D3BkWa7uYK0HJXmC4Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdGOrjUI07EEdsRETOvo2Oia7yiGDPB43whXfSDjm4KRi3yRAD2zl/Mb83PFQ/5mRPswcCx3seJ2lYVurpM/1n3GwvFdDAN0aIg1k+Ok3hfsghg0+HZK9wHChjZzsEZOfELHQWvVeTTyD7kGE3R4g/ohR88SNFUbyshg/QacDm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZquEgqO; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f1292a9bso1445530e87.2;
        Mon, 14 Oct 2024 07:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728915622; x=1729520422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U2eFcy8btOrX7BWJkQL0y+3D3BkWa7uYK0HJXmC4Kc=;
        b=gZquEgqO3m7oJ/yhf7NyWsdDTaqwXiel7VT4fzvGjCowK/pxJKjwv45HlI1nBaUgor
         fl1eHal+85cVtujw7YyV19N54r3OV6VF3Xc09gP6VfVL5av6ZSm7WVbnU7gg4UADwF/X
         gd7jUhRVsNiLxABmyvno3WrbF8TDXRPjp09b71SivhGCWbW+3CuJwgVlgyauTdeX8oIF
         QxBgGAkBJU3mW2e4CAsY++NIZoTQm1xZMzV/VnKGsbyJDSagnAgfY2ZP1KzDkOvnzpwB
         Y3QQxw5X6TrtzHETXkpEZMRGseQnrP6rIk/IPhRF5Bx9ZMmaK/kEV0RKn9OHlCpC+dE2
         u/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728915622; x=1729520422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1U2eFcy8btOrX7BWJkQL0y+3D3BkWa7uYK0HJXmC4Kc=;
        b=n5GbEOBLptQm8wlbWw67qhKFVtqwqfYWLXEkcG9PWx2kgUUTMRWW64NdrYyXtfRNaK
         i1UvwYjU804orQNsjFzbN2MuANXV5GuC76D19oO/Sd2Qq2ocZdhWWG+5GfvWGd78kxa4
         VMD63ocTMTbMpB5sz/mkYAtJ98eiE0t/PQBNJ5FO+CTZlyBuvqgLH81hdbcY5VPsj64L
         D5Y0znL1vLDnldLYgD3irtSaQK12gEB2pKMKUoFHI8hb3Uk465lNsrnic4cZHgu76a2t
         VGLrhFrkw2s5zpTKp2XwmgKW1zHsMLdAykx0W118+D/AirKiLmCDCTO3FJ5REluF3SLZ
         +KDg==
X-Forwarded-Encrypted: i=1; AJvYcCV7o6JNxTAkCwXpMBKy6klYnfeHD5+Vpj8AC1/1OisPQ6c3xng4ecPe1tv1IaP6qHIndcmYTzneadLhl23M@vger.kernel.org, AJvYcCX3/F6pWDRXugMdJyg6dRcp9ovR5DRddajT8cxlfg32mVDoNuv10zm0yO+yJ2v/DgFquweBXhFs37Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTtt9CL+CDxmlH/RHEgSTu7q+fndEJG0hGcFiGy5Q6Na2gnhYr
	vfHYMUAtAnR9/gRQRcMf0/0Vq59fn50PTgXch6e5Xg4LK26V3f0yQ8YxSeJs97wwngDH4OfGa3y
	IA8Eu1Yzv9cXBydI+oxTpwec7rwD2cSAK
X-Google-Smtp-Source: AGHT+IHEFNvqDXKt0pGhSKYkU7CMdg6N4XcIBaTaCc0yZ8gHXEwcN8ltk8mVyRKlKqEx2HfiESSWu0MqDfFpoe9gndQ=
X-Received: by 2002:ac2:4e16:0:b0:536:554a:24c2 with SMTP id
 2adb3069b0e04-539da3c5ee1mr6119083e87.13.1728915621449; Mon, 14 Oct 2024
 07:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014-imx-clk-v1-v1-0-ee75876d3102@nxp.com> <20241014-imx-clk-v1-v1-1-ee75876d3102@nxp.com>
In-Reply-To: <20241014-imx-clk-v1-v1-1-ee75876d3102@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 14 Oct 2024 11:20:09 -0300
Message-ID: <CAOMZO5Ct1u6d8gnrSEbBW6b+sOdz3W=1oF0y21hdcUFdr0ymzg@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: lpcg-scu: SW workaround for errata (e10858)
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Aisheng Dong <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:03=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> +/* e10858 -LPCG clock gating register synchronization errata */

Please share the link to the errata doc that contains this e10858.

