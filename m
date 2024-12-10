Return-Path: <linux-kernel+bounces-439304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD039EAD72
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E33E188DBCC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C612080F1;
	Tue, 10 Dec 2024 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="E3hp/VzP"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF0F2080C0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824606; cv=none; b=qUEizE1Bo9dcKej/Prdx85rcWcnTgHP1N5RcvtnEB2KijxKdIin1zztSgdMe3mNfSa3+iSQV9Ck4d1sLTD9ZdKEiam+gTtiYz17mvyKYCa2BzLmp809d0ZiNhk+FHphnzW+LjMBIiKxxl3tEjm0d92gZ8FTqQ9Wa67rqbaQbolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824606; c=relaxed/simple;
	bh=kOBH0vMe0xTQDXgWPorv7i1vsjSVrIhgJ0QqbJFZGP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qsxde8ZCO+RRLheeUgJI/J9VzaGSMszSVTlRHBAaMcTnwW9IQC81Ono0ItaFsjJM8SmRyqmGPSuSXrRtXWhoPSgIF+CC+NKcgFTCKxacO5Bkzl1DR6i/kFF8fcggnoeh7cHxyA4K4SwJ1zkqIVK0OkUSj9rEpKhjP6gz815j55U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=E3hp/VzP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so2248689f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733824602; x=1734429402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOBH0vMe0xTQDXgWPorv7i1vsjSVrIhgJ0QqbJFZGP4=;
        b=E3hp/VzPKLaBQJc1w6MPAgYZfc+1H0YB+8+rJ9EWrPGFWPT0kztjQZSoiyATSyUr0i
         KcKWcx+yWush0dy/9+4PGpr3fBbZoTMu1OYglSVIyB5OZ48/+rXqyat1oaAR53cpDXw5
         Yi33RHKyuCPGSiNqz5vAa2VpcN469IMWx4kXi8jr20d18DDyQtNe7u5uJ2LaZ11vWqTR
         bDxUU3JWcEu+x2xQqtRb9HVrkGtzRb2/cVHZlFZBh46kvDe1qi8/ytwZ0n2iwseJYqEJ
         99s09Sp6TjtT7UUq5q48TdGZ4lBWrFjUNucASTgDO0h7RTtiTQ2z+dxnPoOXgcbDivrG
         6bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733824602; x=1734429402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOBH0vMe0xTQDXgWPorv7i1vsjSVrIhgJ0QqbJFZGP4=;
        b=oTfg4+yPwCyssPpRmkvWamdq81HmBMXtQUAYxo561lWA3Im1ta0vTa9684jR9XjC/H
         qSIYq1x4tlYcEVz/FWd+sWAC1riNqpXKD7MJWFFDm8dA9oAnBBq1uJa/gD8hi3MJlso+
         JL25DxbBVYX3PMQ/i1sU78b6LZOUF7gbU9PgyNToHqe4CnRlMFyeIPP0cb9NhV/eBbqf
         Dkh6bRbXIdi4STACKiIwRXldl3Drso7fHZM/nFzRjbhJh2KTugSfESQVTUY86sFFKDi9
         s6X+6IvIlu30IKhfoM2Nxl/CP8+qN623K8dYaI8I8oQyF/Aqr4AOJRNBBHG8RRka9SYt
         TJzw==
X-Forwarded-Encrypted: i=1; AJvYcCWtV4jB0seFtl1tRFYvzfbWLnw1zomPWYUUsn7aCttjl7uUxkCTtQmPO14s8Xv2ZeFUpcnIVTDHea3cIM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBR12kY+hwGltZUvN6PXVi7tmb4GwhtXRZEdDqNvbPBCUDDMkI
	EAaNheDH2dvxmh9gATCCg7NEcK7rTZwnwXyvtmP0jQuFftBOlWm0hmuNxq3z4u4=
X-Gm-Gg: ASbGncu4cjlBSNWHRWJWi7XvMciAZnKrV2RoqvQcGECb+M0Y+bdSSPrPWTsGuuOYMhP
	yDAMLIfkHqqg5BvO0bwtjw4dYt7+j3po0NHw7Vm0SFI24G21Y1T6D+U8fTTieCCUAXTpIzHZ104
	4ANHYdNPGJF90DFrsSf7nZLu6FwScExVSYDl4fAqDY8YL/Wn0ngKc/uV0+6iYOsfMq+hNxytiz5
	urkvTEAjbOuRzjF2oKIqt5gqiYHYXx+FmdwTbX84jPSJsArlyTmPJwgTljg+H8=
X-Google-Smtp-Source: AGHT+IGBn3J/kwjMkMOumD3GgGk3HgegGtxShYE8MGa5RyAHXgSBmzxZuUlRrYhXtKyrcLpn+/1Lzg==
X-Received: by 2002:a5d:6c6d:0:b0:382:4926:98fa with SMTP id ffacd0b85a97d-386453fe979mr2475238f8f.40.1733824602299;
        Tue, 10 Dec 2024 01:56:42 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190989fsm15684319f8f.73.2024.12.10.01.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 01:56:41 -0800 (PST)
Message-ID: <ed0f6c49-8e39-4cc6-ba93-35a9372bb532@tuxon.dev>
Date: Tue, 10 Dec 2024 11:56:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/25] ASoC: renesas: rz-ssi: Use goto label names that
 specify their actions
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, lgirdwood@gmail.com,
 broonie@kernel.org, magnus.damm@gmail.com, linus.walleij@linaro.org,
 perex@perex.cz, tiwai@suse.com, p.zabel@pengutronix.de,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241113133540.2005850-1-claudiu.beznea.uj@bp.renesas.com>
 <20241113133540.2005850-15-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdU+_NuLp2FuwwcLfJRe2ssMtp=z7fqcsANgYfFehTNJGg@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdU+_NuLp2FuwwcLfJRe2ssMtp=z7fqcsANgYfFehTNJGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 09.12.2024 15:51, Geert Uytterhoeven wrote:
> Inside this block there are several return statements.
> As we know DMA is not available when we get here, these do not
> need to call rz_ssi_release_dma_channels() hence do not use
> "goto err_release_dma_chs".
> However, this may be missed when making future changes.
> So perhaps it may be prudent to make this safer, by moving this inside
> the failure branch of the rz_ssi_dma_request() check above?

I agree! As this series is already big enough I would prefer to handle it
after it is integrated. Keeping it like this doesn't impact the RZ/G3S support.

Are you OK with this approach?

Thank you for your review,
Claudiu

