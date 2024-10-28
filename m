Return-Path: <linux-kernel+bounces-384806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4BB9B2EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2B01F21DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02A0194080;
	Mon, 28 Oct 2024 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PeHK4msd"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392C1D2F73
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114090; cv=none; b=u550UPWnCS6qsZK8+aTpS8CMX5Zd5yTtwtq2KGAIXnZXXwRPo9ayu6aTYkxh3QUy5JD5mCMT/Fb4rdlhRHZpHunsb1wJvaHouQCGTQeFidJv277zxnDEcMT/r4P69JCY6anMhuKReoox1OrMMW4v/UDj7ikP+EHKxDC1q7gPVm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114090; c=relaxed/simple;
	bh=jis7Kv52BEjG9fhKdic+D6aCcwWpTNhVCT1ZsGHn5WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6UOIoU9yZntGmiw+N1aAQTtWQVddIbRy7iCsCeUbZuT5Jno8XHNAZggd68SrhNdJDIExkC0wCiULAmwWUBf7SSGNA53PLwTZAOd+jaBGNgKyLgSpspjMfd6Rf0uqgJHnbXcQTnaAI6KghZSeDmLRkYBbaDIUN+IKeZko/PeX1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PeHK4msd; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e605ffe10cso2488929b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730114087; x=1730718887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANRl9fyJhN3L3pKsYoqtRh0fyM37Mr+toNEHHpk2z1g=;
        b=PeHK4msdH6kUQ50cbtxr4GvP0rk4Wcj/FbGLUt+qdQcWM6X31/Jdk9UqDq7/QEBVF2
         tTutzWAHDXMOxw36wjgN3L03ceJSwSncd3CWoakQ9hbhdGWO/RGMFVXNpOLFIS4HlNLJ
         8wQXj8xF4sM53v/ucVIlxLgVk37FrawTHsSso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730114087; x=1730718887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANRl9fyJhN3L3pKsYoqtRh0fyM37Mr+toNEHHpk2z1g=;
        b=HGHXVJ2L0kon2ZEjlu4ZFZEP8EjCfsAibzevvT7CpEmpeAuyu997m2tNQGqByHQLFX
         QE7xSmvtKVVHgUBc4gNqHXEkJpBsF7Kz0MEfM+kvoq7gHophO1Wt2mKbPTDptC8sAJl0
         /UHV1xAEXHABf4JlJH8GhdyaqWG/rY37NW4FPNwhxXEyFkNKbRsYtYYQdHe+i+AEQT+B
         Any5BITSn3bOtrQyhFbj6R9d604tyJhmg5cJVqVAVKfArhRBr5/QihwAJaJHneB+2Rb9
         KqfHVhPVGXUZ+Y3BMRErqO6Nc7ngGOeprR54F7ILs3cWT5Ro++UHkc4bfvKgeBRlxtYU
         hUAw==
X-Forwarded-Encrypted: i=1; AJvYcCU8r6wDb16oWjOXSmwsm/h2sw14qgByDp/wqSuLUaaEV95ndnaq4FndYh92fFwbmTvOXfDFwwGx9jRIZc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRN2tgp55x0VgngC1yD56mbrF0Fg3SmqNP5LpsNwW/Vp6iUEOe
	JOnERvaD2PDZbZQDqQJrjsxigRKSHTYTfsBHGl5bgyaGwVeEw4+Zsz8NVcvynZJaWo6lcxpY5s4
	=
X-Google-Smtp-Source: AGHT+IE23MwwE93nlj7/w2cFqZanijivdUXiWjNQyBoz+N6Em86YN27KRuKxCe7S3PV2W4vsumO3Bw==
X-Received: by 2002:a05:6808:1a20:b0:3db:1cd1:cadd with SMTP id 5614622812f47-3e638248ba8mr5613337b6e.18.1730114087023;
        Mon, 28 Oct 2024 04:14:47 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6324957f8sm1438751b6e.29.2024.10.28.04.14.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 04:14:46 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e605ffe10cso2488916b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:14:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdxu6S+ImVCkSKT33T7KkPfPL5/eJMyoDGCjhuzsgw33yLRPofbgFWadhLLptMBfOAOQXCXhUiEsz4qE8=@vger.kernel.org
X-Received: by 2002:a05:6122:2a41:b0:50d:5f75:f7d9 with SMTP id
 71dfb90a1353d-51015109f5dmr4172633e0c.9.1730113723870; Mon, 28 Oct 2024
 04:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025104310.1210946-1-fshao@chromium.org> <5vjaxo652w5hici5hxi3t6o2r5vkggrz25lqvm3or5fip3svke@fttqk5wabxqb>
In-Reply-To: <5vjaxo652w5hici5hxi3t6o2r5vkggrz25lqvm3or5fip3svke@fttqk5wabxqb>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 28 Oct 2024 19:08:05 +0800
X-Gmail-Original-Message-ID: <CAC=S1ng7zRR-Ek1AQ7W6DhhB82=yVpMZq6JfzPEbWWb67knCVg@mail.gmail.com>
Message-ID: <CAC=S1ng7zRR-Ek1AQ7W6DhhB82=yVpMZq6JfzPEbWWb67knCVg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: mediatek: dp: Add #sound-dai-cells property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
	Jitao shi <jitao.shi@mediatek.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 4:52=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Fri, Oct 25, 2024 at 06:42:45PM +0800, Fei Shao wrote:
> > The MediaTek DP hardware supports audio, and the "#sound-dai-cells"
> > property is required to describe DAI links and audio routing.
> >
> > Add "#sound-dai-cells" property to the binding and filter out non-DP
> > compatibles, as MediaTek eDP doesn't support audio.
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > ---
> >
> >  .../bindings/display/mediatek/mediatek,dp.yaml   | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediate=
k,dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.=
yaml
> > index 2aef1eb32e11..c05c2b409780 100644
> > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.ya=
ml
> > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.ya=
ml
> > @@ -42,6 +42,9 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >
> > +  "#sound-dai-cells":
> > +    const: 0
> > +
> >    ports:
> >      $ref: /schemas/graph.yaml#/properties/ports
> >      properties:
> > @@ -87,6 +90,19 @@ required:
> >
>
> You need to reference dai-common instead, since this is DAI.

I'll add that. And if I understand your feedback in another patch
correctly, I assume I need to reference dai-common and also keep the
original #sound-dai-cells lines for the number of DAIs, so I'll keep
that. Please correct me if I'm wrong.

>
> >  additionalProperties: false
>
> and this becomes unevaluatedProperties: false

Acknowledged.

Regards,
Fei

>
> Best regards,
> Krzysztof
>

