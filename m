Return-Path: <linux-kernel+bounces-432547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3019E4CCA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE32A188190B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEFD17BB35;
	Thu,  5 Dec 2024 03:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FEFNrATf"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119228F7D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 03:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733370076; cv=none; b=W8/msDnEwyErusBR5OS32LCbtNa4EW+3t+KmtA9sA4BYYpuq1dUex3qmi1r8Bs9mJVbPlLfdYLXVLnHgnsKorRInJ5mmBsrd2w7d7uF3B9ChL5pxNCx1B9pU6jBifQYxQCv3/h1NppabrnIE9EcprZE3jccFEbwdlD/b77Vbfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733370076; c=relaxed/simple;
	bh=8ILclPDNeqSnZ4d4adFACLlkV1PYPYXs8E36ta2tDWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0ZAHitNLiJuWjIjxHwWtifrRvfPJv/Xg3hXzBBt8K/yDpVepftQ6Wsvi1gOxw6o5tvGF3pR51NBzelCCNMbihVEhGM97y9BMFj1BFdrcpaqQWhVpqdloPlJzIuEuAU4K5+sfBPd/9I/RU6ZccooGfuMiUIaAfW8dOHh0Sb5WeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FEFNrATf; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e2129be67so558489e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 19:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733370073; x=1733974873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwfLitJcijVjn3mYmWjqS2pZ/U3vybZ9MoCggOPZX9Y=;
        b=FEFNrATfOjEwDJIJwKs7wzBSAJxytdGtTNh8t0ehBYRV5mQsDmQCkunBeaH3uVocTx
         PzJWfAr8GeqrpFT7e08l0OwQtfycDP2EWh51hjg4yvIcROg+GFDKH6h7kbLzcw5m0gxy
         wJ9pgvF0/wG1MhHXpyoOvtv5zK7ULh3OGV/H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733370073; x=1733974873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwfLitJcijVjn3mYmWjqS2pZ/U3vybZ9MoCggOPZX9Y=;
        b=m4WaKVMC3K01GbyEimeytUrNOqLdRZkiCG+GtrrEYjwMDp37oBtRVN8juGNJE7Y4U4
         qK8qjG3pQqRCHqqA2FUH0zK6hLgAj3j6vEVPxnqKKvLzj9w8P66Wh9Om0kX23bZSSbsV
         6K03pBPB4XMbEXdcvjJQgy+SxrkHe3adJ8UD+nIgtZNDa7ocVnmIJwzCgIxgM6XWzxwt
         g0j9qhsZ0qeUDFRXEYXwRi+5x88pNyLjPhigQ4ek4ndHzloKTqQdEd4Tga3fPV5pklUC
         /gwaxJc+3I/4ia0UsGK72pmyO9ChvomlOjNAc5vWVStMNxyZ8/0FgrBqQk8IfY3Uv+/f
         Q7hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVMpfCvamCmllahCnEnKoWioydLlJsQqs3buXxWdgG6HuhM1qXLRRVJ3K3W+85Gczo7Y+Cu/za3Jps4aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SZdgo2TmzLc+FOAFk/X4KM8TpP4DnzDCOx7vZWLR15okC9Vm
	PTi36x/uGGOHANLhDAVM2WQyePfn4H+o8gp1/GfNCkZM178r5ONoOv/6G43MwVzvHnsMfycg0Yd
	dKxNX6u23LTrYMpqaOzzRavMYqYVAJf/m7Z7r
X-Gm-Gg: ASbGncuUYZNAx3A7BOC2YdFhoFAr/A9IyUUvS5B3qyD+UO9fXx4CN3YAxKflwq9KR6P
	3hfcJH97ONLYXoIIMZQbxQMtJzToCZAGwduRb0FRr1Ac+9lE7vWcVzNqJToI=
X-Google-Smtp-Source: AGHT+IHqgDnUkKGPY8hz6ukhVqJstOuAN0fggL2+fodGywtVNADNTkDdluEMvlUwqS+eqw7nTOCdm7Cyv8kDB7dlMcU=
X-Received: by 2002:a05:6512:2822:b0:53e:228a:85b with SMTP id
 2adb3069b0e04-53e228a0a02mr191564e87.11.1733370073161; Wed, 04 Dec 2024
 19:41:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204092855.1365638-1-wenst@chromium.org> <20241204092855.1365638-2-wenst@chromium.org>
 <4762E5F1-59F2-40D1-9D22-724107623AAB@public-files.de>
In-Reply-To: <4762E5F1-59F2-40D1-9D22-724107623AAB@public-files.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 5 Dec 2024 11:41:01 +0800
Message-ID: <CAGXv+5EYf9-r88nv7zDo8JFGhMFyzVPU1gBNwkETvGTp+27q0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mtk-sd: Document compatibles that
 need two register ranges
To: frank-w@public-files.de
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 6:38=E2=80=AFPM Frank Wunderlich <frank-w@public-fil=
es.de> wrote:
>
> Am 4. Dezember 2024 10:28:52 MEZ schrieb Chen-Yu Tsai <wenst@chromium.org=
>:
> >Besides the MT8183's MMC controller and all its compatible derivatives,
> >the recently added MT7986 and MT8196 also require two register ranges.
> >This is based on the actual device trees.
>
> Hi
>
> Mt7988 is similar to mt7986 (only using different clock settings) and usi=
ng 2 reg too.
>
> Currently there is no mmc node in mt7988 dts (i currently upstreaming it)=
 so i guess this is why you have not yet noticed it.
>
> See this for more:
>
> https://patchwork.kernel.org/project/linux-mediatek/patch/20241202122602.=
30734-3-linux@fw-web.de/

I think I noticed it at the beginning, but it then slipped my mind. I
might have gotten it mixed up with mt7986.

> Maybe you can add mt7988 compatible here too in v2.

Will do.

Thanks
ChenYu

> Regards Frank
>
> >Properly enforce this in the binding.
> >
> >Fixes: 4a8bd2b07d88 ("dt-bindings: mmc: mtk-sd: Add mt7988 SoC")
> >Fixes: 58927c9dc4ab ("dt-bindings: mmc: mtk-sd: Add support for MT8196")
> >Cc: Frank Wunderlich <frank-w@public-files.de>
> >Cc: Andy-ld Lu <andy-ld.lu@mediatek.com>
> >Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >---
> > Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 9 ++++++++-
> > 1 file changed, 8 insertions(+), 1 deletion(-)
> >
> >diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documen=
tation/devicetree/bindings/mmc/mtk-sd.yaml
> >index f86ebd81f5a5..9ea035928563 100644
> >--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> >+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> >@@ -235,11 +235,18 @@ allOf:
> >       properties:
> >         compatible:
> >           contains:
> >-            const: mediatek,mt8183-mmc
> >+            enum:
> >+              - mediatek,mt7986-mmc
> >+              - mediatek,mt8183-mmc
> >+              - mediatek,mt8196-mmc
> >     then:
> >       properties:
> >         reg:
> >           minItems: 2
> >+    else:
> >+      properties:
> >+        reg:
> >+          maxItems: 1
> >
> >   - if:
> >       properties:
>
>
> regards Frank

