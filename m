Return-Path: <linux-kernel+bounces-381579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11BE9B0116
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9881F22B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098DA1DD0C7;
	Fri, 25 Oct 2024 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dgZYGt89"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2771D90A2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855283; cv=none; b=cpivvLScLfiA3SnEHNzuzCzWoYyk+MddXZvl+7saaWqeW+OI+xALxkCVYOP8zR2KZ8rZaOBFi2ybBHvBEueD751P73aYJ+CdrzQarXf2tJ+LSIlxBqZ2I/gmd2kffuZ6iQjrNWZybEIS5WP1BkHZiLbsXcj91kFCYwIjMmLHJL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855283; c=relaxed/simple;
	bh=6sRf6jyLr7Lp7D8SrksXFJe24XLraz/lmXNXBNiv60s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flwZMeQTxWRgqtJqLEvjNJvMJa+DvEM5tpzVGzIl+uWwoe/8qbe+MY+fPeeIuHMs+OzA2l249+U/lzY+HhFTLOZw4XGC/CBiAcYF2gg+1unmZcmcQ/dGEEchYrJe78ZbpniO0zZJC1g7eF+Q+2ZM+76QmL6f18tQ+0FvZeihT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dgZYGt89; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4a470d330a5so740408137.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729855280; x=1730460080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sRf6jyLr7Lp7D8SrksXFJe24XLraz/lmXNXBNiv60s=;
        b=dgZYGt89DnwtWon5AqlfqrEyoRDGMnrEyXPIuK//Xe7dqb1i3z0MOQHNpTXpCf3X7y
         5lJ0bzsnhBo+WtTjqgHUL5xvEOJmru/CZ7/KvUz0BvnFS1Tkv/lj9xYC8uR3SIww61BQ
         xoZVD1SLn5FqtFczG9FThcTQPBVWBZZsSLXqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729855280; x=1730460080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sRf6jyLr7Lp7D8SrksXFJe24XLraz/lmXNXBNiv60s=;
        b=OYfVG4QuAvm1/HJjv4GdJe1a4L4yazOJMTK+GDi988oK3OXAEAofFF5O6B+Vd6wHxE
         u58rH+Iams43vmo/3uAqFGVKeskXaCXdyBpgxwcmHCLAQMIkr4LAPUl06dg7P4MBCkXX
         /WoZSXWIIGA3RJEzLi97oer/p8zWdT+9xSJD3SW1t08B9CbQOQodiZ2SgCB0tFqIT86+
         3khn9a+JufUzHNlkITKoyN96AzbygnTYcyvqxr3/jOL/0thRzfTeaiJuFlvgYxLzf6TJ
         rxiwNkrpwoorWIAV+KPyrRiTs105X3Cr/+isjQW1e2opkbFwhJRcB/PQugwyyw1/jTMK
         /VFg==
X-Forwarded-Encrypted: i=1; AJvYcCUlM/yVAzH2sF0qOe1PRwXQ5Rx55jzEYP1E+GNQWYQ+g3Mp/l2Y2ruaWo6WUtgrBTrW/h0pX2fufFvfheo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvI/QszK/4cUNBABJiX0KhgpHiT1wXDc1RQMgpWE33iYfyBW1s
	daH4TpSVPTmjYbQ4hp1pWSE8YhOWTRfbnZj6n+eBEjPHLZMM91f0VkPE/opUH80P8Eeq4v/FzLj
	6Fg==
X-Google-Smtp-Source: AGHT+IExtJzGG7XZ/GBBwb2p8GdEeRoRPYTNSq2zEyX2X9wyORPSyBNaftootqhRk1/7ezh4ULO1dw==
X-Received: by 2002:a05:6102:54a2:b0:4a4:849b:760c with SMTP id ada2fe7eead31-4a751c9284bmr11294934137.18.1729855280159;
        Fri, 25 Oct 2024 04:21:20 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a8c5398b48sm165936137.31.2024.10.25.04.21.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 04:21:19 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4a47f8a9168so669338137.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:21:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWICmrP1Ld3LR8n5ZFKE9qA2lWYRF5bjMOgpshEufbGhhgXrIPnNa4A9VISQyuJcuISw5ED2fS7lZd65Go=@vger.kernel.org
X-Received: by 2002:a05:6102:a47:b0:4a4:8346:186d with SMTP id
 ada2fe7eead31-4a751cbd6ffmr12043723137.26.1729855278733; Fri, 25 Oct 2024
 04:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025075630.3917458-1-wenst@chromium.org> <20241025075630.3917458-2-wenst@chromium.org>
In-Reply-To: <20241025075630.3917458-2-wenst@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Oct 2024 19:20:42 +0800
X-Gmail-Original-Message-ID: <CAC=S1nip+CN=YEA7qWgZzx4wY666Qpn1-S2yMHw_jQTcjGcRDg@mail.gmail.com>
Message-ID: <CAC=S1nip+CN=YEA7qWgZzx4wY666Qpn1-S2yMHw_jQTcjGcRDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8183: Disable DSI display
 output by default
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 3:58=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> Most SoC dtsi files have the display output interfaces disabled by
> default, and only enabled on boards that utilize them. The MT8183
> has it backwards: the display outputs are left enabled by default,
> and only disabled at the board level.
>
> Reverse the situation for the DSI output so that it follows the
> normal scheme. For ease of backporting the DPI output is handled
> in a separate patch.
>
> Fixes: 88ec840270e6 ("arm64: dts: mt8183: Add dsi node")
> Fixes: 19b6403f1e2a ("arm64: dts: mt8183: add mt8183 pumpkin board")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Fei Shao <fshao@chromium.org>

