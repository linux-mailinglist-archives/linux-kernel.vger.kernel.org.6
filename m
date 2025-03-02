Return-Path: <linux-kernel+bounces-540463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6BFA4B0ED
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277E016C34F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05671D8DFB;
	Sun,  2 Mar 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blNeppaT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3377AA944;
	Sun,  2 Mar 2025 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740911627; cv=none; b=m6DEl3LRAK4vil7iQp8mPzTzxG47fwz0jb+InGA5SI8g23ZqJZSHe4CffKEsB0VmWchokYW71Hp3PzwMahpLChzl+8aS/HFevA0NFj9JmKZ9R9wxIefkplsVY7ii10Ifu2zFTHU6F9RtDZD2S47TpEQn+wJGXuwn2QZueiKjavw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740911627; c=relaxed/simple;
	bh=5igBtm41WVG9TfJJgntVRppVAiT8ZGfFHmRjD2xk044=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGygHVMOwBuREgSqDEvauDrn/S1jitebtqcgqvKqUGkDJK5kw8mjvJH+Mg4RNXgyS7qC3KqhHJpXMQDtjj7X1VU+I4s7NmclVCLqYX1eNNYdnvp5Tk9/j7CzkQkVsaXhyMY9/WC8qDKw7OK77aTqFHXQzpUyC32B2QsGBmcjyQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blNeppaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823D1C4CEEA;
	Sun,  2 Mar 2025 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740911626;
	bh=5igBtm41WVG9TfJJgntVRppVAiT8ZGfFHmRjD2xk044=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=blNeppaTMVaj6wEh0CVmk9YH0lmIp4rBf4CQNZ90ZosIELmjV1e1J3bnxznAfZgbJ
	 pQlXiPsr9lm2INxgTcGMTQEmmJ11Z9hWK+BJ73phJz82KO1NNI55b5O85hlI0SLSH0
	 TgQ5hAbpl2WABdwnWKgfSJegPcYfJtK9doju1Do3HWtXAgiYjyshLa2P0qBxubB81k
	 poR31rtN4Td9H4puP2Q5D3t/j/T2i2regN1sLYRuq1imnIpusGnsda1Cm3p5z8uOz8
	 Emr8TQntVC7lx7JG3muKVmz2NoqTSOtETb5Iw9cRKQeYrTpLQXxLj9P3bALvIanZba
	 tAv0P68bcDFPQ==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fe98d173daso5609117a91.1;
        Sun, 02 Mar 2025 02:33:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPtE+rGYCZKcRcMMIdCIoM7xS7GuvUVn77jLa7oGJ4rYkP33PKHmWbHo9OT1QQ7jsjX5iLbxHKx3oHolMM@vger.kernel.org, AJvYcCXlEDnYQUlydV3crORibu3Fx5FYz43lcJIA8OYYiSS8K24TOdxzG78Vb1LDWdKdSazEENqlFq2/p2Tz@vger.kernel.org
X-Gm-Message-State: AOJu0YyzmtYeqmpuoPxL/uCLyXi0A8uMTv12AZAhTwuatfV/2BC00U2I
	YROyjVcLdVUu1/NIqF/RRDW/qsqtQ3kYf4t0Yuoi+1Ug4iuvgZ/Lod9E87ndvYU37zOQJ8Qqpzh
	0YyWsbtg2jxsN9NYgTqjLZlCa4A==
X-Google-Smtp-Source: AGHT+IE4yOAy4wKEhTzGzHrtS4sGrkbKCLya/s6+oGg2/VOrOdOUVnYPATsFzlyBtOl0Sgc3vtSnbz58G2fw2hekZNg=
X-Received: by 2002:a17:90b:3890:b0:2ee:aed2:c15c with SMTP id
 98e67ed59e1d1-2febabf19a6mr14172100a91.28.1740911625947; Sun, 02 Mar 2025
 02:33:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-2-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sun, 2 Mar 2025 18:34:33 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9GJ9FRLZVu3EguCKHipK7SfwtVKJtm2cjTSZPTMzz7MA@mail.gmail.com>
X-Gm-Features: AQ5f1JrYwE5Hn_kv29jSXXxzOoJp6L1YscuJYu18bGgxJ2qo6QWbanRGU55J3Ts
Message-ID: <CAAOTY_9GJ9FRLZVu3EguCKHipK7SfwtVKJtm2cjTSZPTMzz7MA@mail.gmail.com>
Subject: Re: [PATCH v7 01/43] dt-bindings: display: mediatek: dpi: Add MT8195
 and MT8188 compat
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com, 
	jie.qiu@mediatek.com, junzhi.zhao@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
	dmitry.baryshkov@linaro.org, lewis.liao@mediatek.com, 
	ives.chenjh@mediatek.com, tommyyl.chen@mediatek.com, 
	jason-jh.lin@mediatek.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2025=E5=B9=B42=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:=
49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add compatibles for the Digital Parallel Interface (DPI) block
> found in the MT8195 and MT8188 SoCs: inside of the chip, this one
> is directly connected to the HDMI block.

Applied to mediatek-drm-next [1], thanks.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.=
git/log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml   | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.=
yaml
> index 0f1e556dc8ef..5670715efa5c 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> @@ -27,6 +27,7 @@ properties:
>            - mediatek,mt8188-dp-intf
>            - mediatek,mt8192-dpi
>            - mediatek,mt8195-dp-intf
> +          - mediatek,mt8195-dpi
>        - items:
>            - enum:
>                - mediatek,mt6795-dpi
> @@ -35,6 +36,10 @@ properties:
>            - enum:
>                - mediatek,mt8365-dpi
>            - const: mediatek,mt8192-dpi
> +      - items:
> +          - enum:
> +              - mediatek,mt8188-dpi
> +          - const: mediatek,mt8195-dpi
>
>    reg:
>      maxItems: 1
> --
> 2.48.1
>

