Return-Path: <linux-kernel+bounces-526309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483ACA3FCFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0511688B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C194024C676;
	Fri, 21 Feb 2025 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzjWBLIb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26973214A85;
	Fri, 21 Feb 2025 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157718; cv=none; b=N7kjrsf9wOk4BS3MF6HcGH1Hc/ZBfqXC4zj+k6V+IYvEeRiaIrsbrLJVr5xn/0pD6cmBm1VDF9R+79TEMN3dNPUXuGs93BH8QZ5jCQ8hS7UjhoCuIi/5ys20gaLq+YQIxJmS4ph9yLvD5DT/ZWZ7C3t1rqJun22TSAFahbaus48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157718; c=relaxed/simple;
	bh=s5eo+jWFRpAipFm09lCIDLtuXzM+294r4TRujXXE5u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEUv7asuDd37lKcVCDHj+sXxu4syvlMZ+Xxi4oP/d+cI4cPnWJ7OyAhU+MOJNF+7gchuhBkf120B2GBYcD8UOBMZmGt+jzO4RJ4LP9gyCWrBhxUld5J1KbgCkREhidiSph3HGMjRmDHA2oFdYvBo8fT1HwFGsgKdga/gItQt6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzjWBLIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060DDC4CEEB;
	Fri, 21 Feb 2025 17:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740157718;
	bh=s5eo+jWFRpAipFm09lCIDLtuXzM+294r4TRujXXE5u0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GzjWBLIbRxpFtvcpYed3KJH5oTstoyhONMh/76infiaUq8+BKchsHfECQe7rxsIqF
	 qFcpc8lIOphgU56JOdmPiHKujaATg0VW9uoRwxwBPQfyI3sPAXrly4pFA18F7KGWNL
	 NwoG9XpzqWnq+f+a0L78ehWlYynKd4CiEsPHyaZrD4oAmPCR9IYJYgqMx1K2vds61F
	 FEmTYM4LhyFNfXyTfRI0N1ACovuQO4ZA4AeXRs5g0uVERIQI+fDEDiDFZmPsvnKVm8
	 pj9479jGjo1KY/PzySQYuxqdo61I+bvpRxMZCkBO3lFaJX9yUMRAOjxaBY5wzIgPsG
	 yBAgKohor6mFA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e04f87584dso3551980a12.3;
        Fri, 21 Feb 2025 09:08:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1wazPxrwvqWoLP25eyGM8yj8jKq/K+wgXAtmpanZtQUiYDj5JQ5JnEbqE0THwp5TeMIeOL0YmbPPh2YeA@vger.kernel.org, AJvYcCXTHCTn5HG1IZSf/vM76Mn+S1bWy8jxV0ogBXb3HFQu1iZ+vMn1jkxIHasrXj3l9dhUF03BrvB/zSZL@vger.kernel.org
X-Gm-Message-State: AOJu0YwswD8TG3+TIEx9W0yWXU/EWtGrxzfvjk8rxdKllb8rnpUB45UO
	g05XkT63FcuNxzrsO5Yy51AxxUvzF+Mi97na/jmE198i9ALiKpGzHFskGWapml/2g+P5zWDQJCn
	BZ61ZsRWb3OR8QTwd9ZYr1i/1Wg==
X-Google-Smtp-Source: AGHT+IF3O3vdI8KmOvbFRUGPLCBofMuxQiMkHrsWb3wzJcHfb8wAPbp8iF9eEU1cB0o4czpk21gl9NW97USVLhVQ01s=
X-Received: by 2002:a05:6402:e02:b0:5e0:9ec6:12d1 with SMTP id
 4fb4d7f45d1cf-5e0b70f0800mr4060556a12.18.1740157716547; Fri, 21 Feb 2025
 09:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218090427.20318-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250218090427.20318-1-angelogioacchino.delregno@collabora.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 21 Feb 2025 11:08:25 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+4+=3ccuwa1whv+UQ56H6ueia4Mqy2z73M-5D15zZw=Q@mail.gmail.com>
X-Gm-Features: AWEUYZmwuM1JP26BKUCaWcwByGaIWjPB3I55aqksnOcD6mvIR49_PbC1vcSeCe8
Message-ID: <CAL_Jsq+4+=3ccuwa1whv+UQ56H6ueia4Mqy2z73M-5D15zZw=Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: mediatek: dsc: Add MT8188 compatible
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com, pablo.sun@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 3:04=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add compatible for Display Stream Compression (DSC) IP found in
> the display controller of the MT8188 SoC.
>
> This IP is fully compatible with the one found on MT8195.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsc.yaml     | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring (Arm) <robh@kernel.org>

