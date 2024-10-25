Return-Path: <linux-kernel+bounces-381578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C35D9B0113
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4DD281105
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D80A1FDF8B;
	Fri, 25 Oct 2024 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TEG60jEl"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2FF1D90A2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855223; cv=none; b=W2bnhMY6xoahrLcUD19gHXgFGhwGkKWtpHHBiZFD8dLPAY6nayqoAxC0udgIoLGLgbWzf0n9SylmB8llwxYF2U4ZZFsG2J9HtDs1fq1E0Ry3tGorAqHfwouxdaZu4pWsHfwNVyzh3ZVr9yRS9QutP/fF1AoG00qpU2EsD45Obw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855223; c=relaxed/simple;
	bh=WI7XrMwtXL077tWZKycguwQfQ38m20vMCPsqD+m+N3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHyU2ucmkPXJdGdyK8dD83EAzWoEugav7vM4YNhqdRJs2uGj6RGXSkSkigT90vG9a5hnmJM8UT4BT/ls80mIkMXdSHu4tvV7umomT3kfNenu+8gBGdyY0sDjVCFsAA3OCYIvXzGTjH3rxEb14Wm0SL2jVMxVhMo99W2yX4eHz18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TEG60jEl; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fe06fbdc6so608324241.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729855220; x=1730460020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI7XrMwtXL077tWZKycguwQfQ38m20vMCPsqD+m+N3M=;
        b=TEG60jElpzEJC1VT5+OpLoLh7NHPJDqvghx13/98TBO75B/lWbpz8YtKUt8JdPFU5q
         h/A+M43tkLl8JpPOIb/OFOJDi+A+gOPU9JL1AELX58S0ny9E/0l+kQQfNr85YgUogu2t
         mTzcSz+y9YJ8rVjN+FpM1g+ZnVLZ1neu2QPAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729855220; x=1730460020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WI7XrMwtXL077tWZKycguwQfQ38m20vMCPsqD+m+N3M=;
        b=vKrgPTZSCEqZ/ZbgPwYVK2o9rZNIxGQqMjVfx2tvjCniWJD82PC/jp2T2YsvocxiyE
         2i0krJXOGtu+3C/Q72n/Lyi30P3w7uHWY1FZ+eojm694DXDPj5GPQFVILhydMEjDNCBT
         5sTXIl9KU/iBwBvExlDdQrShjDCoHu2XRNyrf7PT7km2+RrPAktCsu79ku5N+zL3MHFm
         yAg4fCVyJhIfAFo/vi7jMzkD0e4xebJs8Yjs29w6hlqX/EqWsKoj9KDqz95/saR2/sCq
         N2pUrbO48BcsA8Tbjh1Hhu1thPJwhja0jiUicQ+EHrU4nRBQ2s9gKQXzxMi+sUpUNFuq
         15+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvhOWBdjR0mj/BVutaR/to9RZswdVrXwcvL2nR2LeZZ5GNz2KXHT1Ni+erAA3tUuyezMR7R6WxlpWVWAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI2nguS0RRVpH7SuCeyehURZrQyg1rJAcAyJ3b0KnRwVv5Ob/X
	POxvxMJ+iw+PrcLxgCovKHf4NMoBfJhRPgkAbiT7OOF+1NY/kOjdtKzW4DCmB0QLE+b2Bquqjvb
	XWw==
X-Google-Smtp-Source: AGHT+IHUJQ+0w5q7dCg3ndpuAoEop8YeFUbYAc+/P9/kq7kWDT1pQ4LT9iVoi505uBrMulG6YEnPWA==
X-Received: by 2002:a05:6102:2ac3:b0:4a4:726f:6dac with SMTP id ada2fe7eead31-4a751a926cfmr10833885137.2.1729855220226;
        Fri, 25 Oct 2024 04:20:20 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a8c523551asm170865137.9.2024.10.25.04.20.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 04:20:19 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84fc0212a60so521947241.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:20:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBiDmYi9eP91cz74hJZdDulYdMko124cicNW42uBWzspyvkqL6PetueHOJwLmYUKeHIJ4KhCrj0ivsv5w=@vger.kernel.org
X-Received: by 2002:a05:6102:954:b0:4a5:b712:2c94 with SMTP id
 ada2fe7eead31-4a751bff426mr11555515137.14.1729855218618; Fri, 25 Oct 2024
 04:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025075630.3917458-1-wenst@chromium.org>
In-Reply-To: <20241025075630.3917458-1-wenst@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Oct 2024 19:19:40 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhPsPRYk_w0n9or7KrEhF_UzLjN8MFCL6xw_FLR1b1++A@mail.gmail.com>
Message-ID: <CAC=S1nhPsPRYk_w0n9or7KrEhF_UzLjN8MFCL6xw_FLR1b1++A@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8183: Disable DPI display
 output by default
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 3:56=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> This reverts commit 377548f05bd0905db52a1d50e5b328b9b4eb049d.
>
> Most SoC dtsi files have the display output interfaces disabled by
> default, and only enabled on boards that utilize them. The MT8183
> has it backwards: the display outputs are left enabled by default,
> and only disabled at the board level.
>
> Reverse the situation for the DPI output so that it follows the
> normal scheme. For ease of backporting the DSI output is handled
> in a separate patch.
>
> Fixes: 009d855a26fd ("arm64: dts: mt8183: add dpi node to mt8183")
> Fixes: 377548f05bd0 ("arm64: dts: mediatek: mt8183-kukui: Disable DPI dis=
play interface")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Fei Shao <fshao@chromium.org>

