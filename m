Return-Path: <linux-kernel+bounces-553020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F08A5829D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CE53ABED8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67921A4F0A;
	Sun,  9 Mar 2025 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TLZuxei1"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772DECF
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741511908; cv=none; b=DW93AatKZ6trr8h0kCKMOS9BRB46RuLetx/b0fukSn9OmiPI9IXODPXvYCz7aAaGjUkAx4E2js7uM8sy3VBGBGx8U9dapVES3c4WyuHk9gOOO3SHjo3ASjsK1oC3k0auw4513iXqyEqCEir7WbbFMk20bzHthyu2gLeB/MrA7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741511908; c=relaxed/simple;
	bh=dBq5zZ/avVcurnY2sBq4jgbs2ahFnew/Iz5d1wxGBSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1Xc8hM1kagAH0GavYhMVnOVPtzdXUjiPt14f26NPdjydZDAisJocQTwghtvpVHRy4dE294ToUBFhOMjmSMdIbTxInFYt+MmP34pUKjn4RyznH5m+U53iINUCI+KMcWbd5joCeaU+EEy1D3gXaoo7ED70zEkk6MTy7JbQQbrdz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TLZuxei1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e6341e4d0b4so3121267276.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 01:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741511905; x=1742116705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wS4IhIBI1yx2mGgdeLumrUYH4CZGsZF+Y3g2R+4QCNM=;
        b=TLZuxei19UUVIskRAgzvKWFi2M3eNsRu+H9BYmlYMCXn7j0LOSArgQBy7UXdRyXEbK
         r67Q2WKyvCGh627aYt5hxcEwEyd6PGYJ762ZuoVQk7cIkIvANWXYeVNxl7BITCHn2a2H
         7nKW7Q8nFaKY6jxfobixBSZN6mS8QOL7uU2D4pHPQbdGXt9tFm7mhbLtIBLtkk50pP5M
         FhYgxSmWt9IBVADyQrbBD87Hj63rj1bssLUqUQxgTK3cDgO/4Lzw7y/Q1TtM3V0Et8up
         KQ7rCIza0KU8FZOsLHkuIMnUBfZqJkxoMdq2qQqYjp7TmWVAJPzPOKVc4BZcxj/Pw6ay
         JikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741511905; x=1742116705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wS4IhIBI1yx2mGgdeLumrUYH4CZGsZF+Y3g2R+4QCNM=;
        b=GRGR/ApkGae6Hw/IGukqVfBLSWb/UqMwDkF7pQrqsBSChuvUllqdd7C0VQlzkfeokS
         fy6PlJkPDv66N92nj229YqRweN5alqrIQu6DvgZHno4Bn1Xn4RZakBOWD5JPQPXAg1kw
         kLJbvqFoKdty0EguVWsGd0AN3L+FHCGeu5r5SYM1zpLORrEm+ZEYcWnBSZvtQBmbeLax
         tZzMwTXzZCM2mCYIbd+MNadNb5plre1BIPu+fM+jDXYY/htZGVSkuRQtgjZA5Z+/HPI8
         qY3PTczdEoPqRJLTIa9AOBGXu/BwHmqkBJbPL2R1SL28kJpzahSzIrsqABX0z96JhJdQ
         7sfA==
X-Forwarded-Encrypted: i=1; AJvYcCXw9FaF9YYOYhiB3iQRp8id132lL7sifWqVIqn2PMQza3iO1J+BhAcfRBjjgC+Fn2EzE2l4fFRzhgWi3Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8QnI/tPN4oEP+xRC0c8wLtUJ/Lg6bT/5vdxk9mM5ZbDzE1rGQ
	wcAGScL96AYppwUHpEXrlpFHXLthqjjDRXl/KFN1xztF9JlH9QuxW9SoP5jji6zM1FQDjU5QxSg
	E3Y/a1vVllbYeBIl/rViRBu3OCAHaLre2LyzV5w==
X-Gm-Gg: ASbGncs5vlS4Tv3TwsEMaYlZPsbh4e7eVRYOFNl6s+yZjzS4Ki0knQbWOU+ELS9oGpF
	UxKQEgbh3nd+2pnU4S13h2WrOrsagSxdqcsEJtyPmshU0qRFYbDYXM4AO3bYDE0grAsg7AKrBSJ
	TFV9TXJ30A27eB2LNZAagqGxqcG4lZ8AGkzsTVLAjUP/BODm+G+WY=
X-Google-Smtp-Source: AGHT+IHmsF91K1D6VLx4YvpkoZQQE1k1xzhlV0FUEYyz+Ynn23igUj9beuV6WExyljR4D+jdGEc0UrQaoLqBGQ5Y8I4=
X-Received: by 2002:a5b:f4f:0:b0:e63:7084:fc01 with SMTP id
 3f1490d57ef6-e637084fc04mr5253669276.0.1741511905671; Sun, 09 Mar 2025
 01:18:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com> <20250308-phy-sam-hdptx-bpc-v5-4-35087287f9d1@collabora.com>
In-Reply-To: <20250308-phy-sam-hdptx-bpc-v5-4-35087287f9d1@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 9 Mar 2025 11:18:14 +0200
X-Gm-Features: AQ5f1JqwlpVv48DTqejukDRuK53dcVgbu-cHC1EtLzGRaEU0x0TorpoDNNMztSM
Message-ID: <CAA8EJpo0073Ub-WNdQoAq0=Zvet8M9aan3e6v9cnKORCTkqMKw@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] phy: rockchip: samsung-hdptx: Drop unused struct lcpll_config
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
	Sandor Yu <Sandor.yu@nxp.com>, Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> This is just a leftover from downstream support for HDMI 2.1.
> Remove the unused struct for now.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 31 -----------------------
>  1 file changed, 31 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

