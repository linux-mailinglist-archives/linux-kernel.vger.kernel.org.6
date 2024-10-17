Return-Path: <linux-kernel+bounces-369185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954F69A1A13
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6A7B21B78
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49CB146013;
	Thu, 17 Oct 2024 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bXurL2c2"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D5137C35
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729142014; cv=none; b=cw+3ZNkNVgx1UUg0JjrMfxqgn9Lr4NkJW1GPMzaGnkjSu6K3twb7vf9Qy9Go+LXj8Jeu7L8Gl2JV2HHFuGi77oty5gIva+pmUBRpP/TWejM1PGzBX79N2SrM+Api9WWNKLWXNbVBRT3Lvyek89UKgQFvAc0q6BlOkxnV3PUjFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729142014; c=relaxed/simple;
	bh=6V6eNGdE0SPvqcSpqgKb+DQULJcURDQCfkY0VUPRIas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIiYjdGDPdXECOso9QhVspnV1bOX7m/VF0SNJmEd6n08ejq9HAtOIPrYYzfo0sfZJRR3y60gH9eqVpR9Dl7BJzPwGdRTpNsRjEbC1uM33Pn5pRV3DxYgsZHp/Mv3jDF5HQkO2Wh/oEjesvyO38J7hLXzt7l00AkrSquOgRA/o3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bXurL2c2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so538600e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729142009; x=1729746809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V6eNGdE0SPvqcSpqgKb+DQULJcURDQCfkY0VUPRIas=;
        b=bXurL2c2zXRW1vZ6OfSZLMolriV7qrpw5pGwH1BNh3VOrGYBlsvmx3fNPjzMAj4EJn
         ZfOwiocEDKv2/Y4NfmxGzqfVmp164w7MTxkxiQaeelHAS2GP0JS6AhAVTrCTsbhyoAoj
         Pr2VqiZNktsSSClkXjjRFUvusWI7qaaB6DAKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729142009; x=1729746809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V6eNGdE0SPvqcSpqgKb+DQULJcURDQCfkY0VUPRIas=;
        b=ZfTWaR1RtgkLjQGu/GIZ3pcLN8YufyO+o4uR4V3jD3FrwogzJhpdnnAuuZyAvDK9T8
         QqJ4nK1xhBBbUutlT//J8o+nSt+yVvZVh8MA0pX5nhl1h2FBlM00cTZnSP7m9Y2C1Hgy
         zGHq2A4BjdDXD+5vEzWTUvoMtBfyeoWcFffH9LntlfPfzAKKb69WFt+rcl8XsTJ4B3Xz
         MzLfnOt+y9eAQcTRlL7KQLkQDlthCBrkW26EbhxR5XpoHq/qrwjn982X15JNVVN+0gBi
         VWCk7lRqxYa6/Le2JTOKhcCEJsA5A0G+VgpCzUleZyZXAdTX9RksJgbEbvQXCLWJyHVE
         PV4g==
X-Forwarded-Encrypted: i=1; AJvYcCUmhfcXl+FGMHRKrphUJOtFv9tA5C7a39/Rm2P7SoMcLs9rIQh05sjmNeWQmM0iKpvvKmW6k8Wpe/9Pjyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SluydMrX2Ui8G/Y7ON7gHTTSi7bVuVw8IzFTCyEQGvcemej7
	hz+rwoui0seqrrJS7cPwKSQAVJWM0YvTgErNWTvuhIDmXlWW3zLy29NOuG6Bf+IBsEL/BPrNwaM
	Y4BHGI+FnPA9C6iwrdKO0AMzeaAMtPj+9HO6W
X-Google-Smtp-Source: AGHT+IFjzb2wpcnGWFDBZjNo1M6JPjsOZT8OvpkoK5cl54wpJ09jbG8ZH+YgyEBJvP+ZZVXYFVWt2kcbszuvdny5JUo=
X-Received: by 2002:a05:6512:1292:b0:53a:bb9:b54a with SMTP id
 2adb3069b0e04-53a0bb9b6f0mr1366138e87.48.1729142008876; Wed, 16 Oct 2024
 22:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016223312.3430051-1-treapking@chromium.org>
In-Reply-To: <20241016223312.3430051-1-treapking@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 17 Oct 2024 13:13:17 +0800
Message-ID: <CAGXv+5FEEXYu_h=_cnLGfwVQh5kdf0KpRFKfUYgFsR5oV9s=nQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8183: Add port node to mt8183.dtsi
To: Pin-yen Lin <treapking@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Jitao Shi <jitao.shi@mediatek.com>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 6:33=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Add the port node to fix the binding schema check. Also update
> mt8183-kukui to reference the new port node.
>
> Fixes: 88ec840270e6 ("arm64: dts: mt8183: Add dsi node")
> Fixes: 27eaf34df364 ("arm64: dts: mt8183: config dsi node")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

