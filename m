Return-Path: <linux-kernel+bounces-328911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E8C978AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DAE2814B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D1E155A34;
	Fri, 13 Sep 2024 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnskXcut"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B42149C4A;
	Fri, 13 Sep 2024 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263564; cv=none; b=I5CuVuQJdEdwr+HFg+0i7NiVPUF9sRXyxrqcNKxcM9TzQgmgRWJqlff+hFfjNAhl0mE78oa9GA/YUJlxiBdaEzH3cf2hZZ9g8hgP4ngI9kDQh+NuyZp/Ii3SWBQ0nDRJnY/c3NZpbznI7mmPCZ7BctgeQxbw2378qXWY9I0/KRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263564; c=relaxed/simple;
	bh=29lldcaIiks9/LfCKap1Yktuq2JC3H3MvPcdHX/euBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6PijhI4CFkNzxiwNgxOuaNC96Nd6Lh3YtKpPIOOvaiHzEXtrKfTzt/UrCWsDaDcMMscptum9e6owgairaTrR857iNwR1g5LgWoE50C5t7pNxz/S3R/bp6tmzXod79TN4QBj1sicannVbQ61EHPeZG1zaFh0vWJjTYxo7p9p698=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnskXcut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCCDC4CEC0;
	Fri, 13 Sep 2024 21:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726263563;
	bh=29lldcaIiks9/LfCKap1Yktuq2JC3H3MvPcdHX/euBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TnskXcutylpvBl9psxUrUfUCRPAzJGzmd8y9uJnn49340vS09VnNflnBAhFARrcMn
	 IeSpHw6/nWrPg1N6jtMkHHEJpBw96cHY8PioWhedzjHpsV3dwmsC2vTS8f9vlANP5p
	 +HoUS4oiP2V76PpFhUocCnKBbWUPVpSkWJAOgahqgRMzQ9pkJy/TUgljsiqiOHeWj/
	 fu6o5gKxrN51JtIBvAdl8ErSWEHkk/S9RiuQ6CZapIx8/DrqfSYzBAACLCSsdgblPm
	 6TFJvXE/t+34KGDYtsxzIHLLGK5ePjSCFibY6KWREM9KQP4r5wyoCIO35Q1RDacKa+
	 bfRvrVFijIrcg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5367ae52a01so1959695e87.3;
        Fri, 13 Sep 2024 14:39:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX86voZFnCBD9cZHuKyHMUdhlAqRZxuUsPx/UYhYs2HiHMTWTuwJ1Me7YR7je7Bic0mCvoSodf+jrSr@vger.kernel.org, AJvYcCXD+bfKuY/sjtgBXU1kpBzYPFThu1ryJ5/onfxgj0GjQ1tXuYJFzTXadcIBQ2cYR6HKv5IsCbqE+8GAe9+o@vger.kernel.org
X-Gm-Message-State: AOJu0YxuccCcyyvqZrEcPCp6YpqYgQ7Rj3xDBw0yg+Y/ld8K5M+mw59A
	W7wuQgTmjcMH8oaKyRobyT8YkyvRtoUKpfctE4UK/ONus+oAuREoZ/3kCqQo1Q/93ijKY8OyPbX
	k9fUNgh3oWKzkxvvIgOPdfQJu1Q==
X-Google-Smtp-Source: AGHT+IHja0EdX+FTr55htGcN7Jpd0i8VmeMa2FJm1kpulhqYl5C0BU8PCxBt6UcQdsqHXvue4VOMzQdKb8SnPRakjGM=
X-Received: by 2002:a05:6512:2393:b0:52e:98f6:c21f with SMTP id
 2adb3069b0e04-5367fec3915mr2947015e87.16.1726263562116; Fri, 13 Sep 2024
 14:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912144430.3161717-1-treapking@chromium.org> <20240912144430.3161717-2-treapking@chromium.org>
In-Reply-To: <20240912144430.3161717-2-treapking@chromium.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 13 Sep 2024 16:39:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLhnuqASgOab7RjdrUxGs4ags8CutL0K9Vr_57HmL+TpQ@mail.gmail.com>
Message-ID: <CAL_JsqLhnuqASgOab7RjdrUxGs4ags8CutL0K9Vr_57HmL+TpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: mediatek: dpi: Add
 power-domains to the bindings
To: Pin-yen Lin <treapking@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, CK Hu <ck.hu@mediatek.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, Fabien Parent <fparent@baylibre.com>, 
	Jitao shi <jitao.shi@mediatek.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 9:44=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> The power-domains property is used by most DT nodes using mediatek,dpi
> bindings. Add this to the bindings to fix the schema check error.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  .../bindings/display/mediatek/mediatek,dpi.yaml           | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.=
yaml
> index 5ca7679d5427..7e0bb88f5856 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> @@ -42,6 +42,12 @@ properties:
>    interrupts:
>      maxItems: 1
>
> +  power-domains:
> +    description:
> +      A phandle and PM domain specifier as defined by bindings
> +      of the power controller specified by phandle. See
> +      Documentation/devicetree/bindings/power/power-domain.yaml for deta=
ils.

power-domains was already added recently, but mt8183 was not included.
So you'll need to adjust the if/then schema for it.

Rob

