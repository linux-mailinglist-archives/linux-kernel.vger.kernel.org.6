Return-Path: <linux-kernel+bounces-427972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 481579E0827
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088AF2855DC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0E617A583;
	Mon,  2 Dec 2024 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aYKwJeVx"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3424172BB9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156076; cv=none; b=fhsbIL7KWREmuWujCNvz4Z1WJscQ2GEflOcSlbOv6r0vwLAsUsk5agrVYhCe+O9GgigAWYC0R1VTIrtmnH4umqYU4cCj1Ior/KFZAin7Awwfx3k95eDH50vYRD1/3WPvqLk4WyJWDIduo7hDdNESgUJOxW+XtiBJDuVGA5hXVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156076; c=relaxed/simple;
	bh=7jZTOSAwZM687/4IxljIJ+4sBELVFnFczjjMTXnd6MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLvPjobCnRBrKvCA7JJ4ANoSSxmmDealsDaJsXdx1Fsxp2Ws0HXnuUdCRT55t3dfIDsjcEKzhcp3lUW6RNOq8c0AWa/Iy1L8P13viZfscUyVmcrqkE6O3VPKzm+Frh79nZFXMSymf7BqYzs9URli0P3Hg+YvlHiYKUZz53gyEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aYKwJeVx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53df6322ea7so7530736e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733156073; x=1733760873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZViN9u7WEeef4ck6iMwRDaJEybzCZmgvmXDAyqUy/E=;
        b=aYKwJeVx9+vLfq3X5codTQF5nUmclO2Q/rU9C2pdAp64AnSG7lfFdK1jkvURGKWhAZ
         kebBDvciphjx0r4ILsDLXlD615kKOrHYh5r94TjtW5ptnxFMTxUN7VjXa+ozKOZomGq7
         OR6WnPphLnxlyTx1ibEmwmFtV2IeVPBej38Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156073; x=1733760873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZViN9u7WEeef4ck6iMwRDaJEybzCZmgvmXDAyqUy/E=;
        b=Eyx7qbJY52Qud7bQ3Wsa2/1D8vBL0ZydwTiW8JdCs8fWoHdeb3qxeOpR16o3lHyT1/
         RBJmORTLNl0umaVVPq0o27tvtQGBgwXlLJsPgPgw3l8GuEgMYTsCKyXaYuMtJ6RN7ojj
         7iralY9x/71fVsZFsavImAxYT8js1VUDpZJceBL0+Gx+2OqKEoRqN1nxjRMH+M8fN582
         FEpwoLWAnAHSW3UcaS3DfYuPT/qNM3OHnydlz19vvBBUA4nBkIcHbeTzCsLm/lprRKLa
         I9BYVzdkorwVmMiJbDvLn+/oCeQgV3NBaC+UywIgUPybkj7sFgkE9zlaFy68vugxAdpo
         1Sdw==
X-Forwarded-Encrypted: i=1; AJvYcCVILkLi9bsh/uW8pL9cyE0oNjdqbICnyvizSRz1iGkqjIIN+LZMp0jLNWd1jjyNxQBs5+W9QDnOexM7QJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzptgLleRWxmr3Ks8GsCCsZLw4+GpkAmpm3pzhV4uF6oobCbyyi
	kYE8fHZxeu/jwfNPUTd+y6IPKnsraHTdTO0wRm6EibB874mvH+3ZYyR/iUFBAfyt+VaEjxAgCXy
	hNg==
X-Gm-Gg: ASbGncvMnkEVqlnCcEctqq4MWOAdM5/zT8Za02bscsOSH/wBIA9cMKdvhbcNx8azX+b
	7dh62/N2Evs8agO9wnsRsbOX16gjjPg0IcPK5bKb4kyahvQ9dok9eU8ZthCu8v/E3/xGK/15Qty
	Ry6BCGdjlAE1LkfkY2w1+yhv7tYIhy8HJmhawv8B3d2r7bFi9ffRsc5BsBAGdZCGXNa3P1REPh5
	iYX+amPEIVNrwmTnb059be/pxyaTA3sCu48z/J3W6wqqlI36nbk5Zbo89oDDIwGGh0+EAi+9S1N
	4Cn6EBlVPAVSig==
X-Google-Smtp-Source: AGHT+IHjhWB6hrWqBybzIo08Liq4lohpdV4kC2MITh5Hy6IZYX/0pbUoOct40J1AnRatZ/Pxq7LoMQ==
X-Received: by 2002:a05:6512:2f9:b0:53d:f091:652c with SMTP id 2adb3069b0e04-53df0916593mr12493182e87.23.1733156072280;
        Mon, 02 Dec 2024 08:14:32 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df643110asm1516900e87.32.2024.12.02.08.14.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 08:14:31 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df6322ea7so7530637e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:14:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3awDxzhboK/LrZX7fcpFsGAovFbQDBkvEV7cBFJZKKXD6TpGkaqzFuKRvOhqeMyGCsDFfvvY1h8ghPsA=@vger.kernel.org
X-Received: by 2002:a05:6512:2396:b0:53d:ed0a:8113 with SMTP id
 2adb3069b0e04-53df00d01b2mr15721785e87.14.1733155628493; Mon, 02 Dec 2024
 08:07:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130-hp-omnibook-x14-v2-0-72227bc6bbf4@oldschoolsolutions.biz>
 <20241130-hp-omnibook-x14-v2-3-72227bc6bbf4@oldschoolsolutions.biz>
In-Reply-To: <20241130-hp-omnibook-x14-v2-3-72227bc6bbf4@oldschoolsolutions.biz>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 2 Dec 2024 08:06:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VJR3O=8xHtdPapwtDS2ShL3SVTyvzNgOTNjp4U7OGO4A@mail.gmail.com>
Message-ID: <CAD=FV=VJR3O=8xHtdPapwtDS2ShL3SVTyvzNgOTNjp4U7OGO4A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/panel-edp: Add unknown BOE panel for HP
 Omnibook X14
To: jens.glathe@oldschoolsolutions.biz
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Kalle Valo <kvalo@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 30, 2024 at 11:09=E2=80=AFAM Jens Glathe via B4 Relay
<devnull+jens.glathe.oldschoolsolutions.biz@kernel.org> wrote:
>
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>
> Seems to be like NV140DRM-N61 but with touch. Haven't disassembled
> the lid to look.
>
> Due to lack of information, use the delay_200_500_e200 timings like
> many other BOE panels do for now.
>
> The raw EDID of the panel is:
>
> 00 ff ff ff ff ff ff 00 09 e5 93 0c 00 00 00 00
> 25 21 01 04 a5 1e 13 78 03 ee 95 a3 54 4c 99 26
> 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 a4 57 c0 dc 80 78 78 50 30 20
> f6 0c 2e bc 10 00 00 1a 6d 3a c0 dc 80 78 78 50
> 30 20 f6 0c 2e bc 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0d 36 ff 0a 3c 96 0f 09 15 96 00 00 00 01 8b
>
> There are no timings in it, sadly.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

You should drop this patch from your series since I already landed v1:

c1bae6802ee9 drm/panel-edp: Add unknown BOE panel for HP Omnibook X14

