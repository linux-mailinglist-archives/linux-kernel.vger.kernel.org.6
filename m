Return-Path: <linux-kernel+bounces-395161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AF09BB999
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9331F22AB5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22C81C0DED;
	Mon,  4 Nov 2024 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhkgX+5D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21391BF804;
	Mon,  4 Nov 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735840; cv=none; b=EmR9DSsedWgf0FJm3DyFrQR/xzQIxxuUUt3ErDh1jDJeCsrw0f2sMDoPqOSDr3pb8TEhWDy5S3lUFm+GY5lqPisYYmGY0Rr8OKMrpmxJCkjOr+Nnv4dUDwY7OY37Thlgyx0RM0SE8oyQesEt8ogj6xzNqmlfn6uN9sejHpoGJgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735840; c=relaxed/simple;
	bh=du3D9Ti6JlIpp3Bx+I1pxH4VeSvLJQ6Ys6/W+ho9O+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAvTcX/dqcIVtnHY1xsWWwobKEjXECVxnPRuKXi6ieszFlb9sG5lbrFAQxNAdbTlvWLs+1zppp71djb4In2RtZ48IwiQJi3m/SqipElemU0JtcPGqH3Aa+F/WLozLv9sUH0a754cTBK2S8LttJrxpOXBrCc6H0JTUqKEO+Tcp14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhkgX+5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9567FC4CECE;
	Mon,  4 Nov 2024 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730735838;
	bh=du3D9Ti6JlIpp3Bx+I1pxH4VeSvLJQ6Ys6/W+ho9O+k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WhkgX+5Dt2lESakf8onXXzW7cZ5C/VqXTnynUXelk6LMEmiXhiiS5uKvIiglYRRQd
	 r9RgkSZwoBub61J/vu+uTCqUEU5Ysp0D09w42GTSBZWCxX1EfAehu9alRA25tch2LA
	 f0lxhUclCAfrEgeCiP7XMk73AL1jAXLjj481hlXxCSN67ZjIMUU0zsbjfEbevIoMJ/
	 5WrBNrm/zPmv3jByyuHyNh2s3y8gktj41YrXr6X8tTIgUsbLAz6duPWeSGogxZ43h5
	 iX9Q6SKBCIk9tK5vr7TMzpOKsV2UaAlMIR8AmfYR6NIq/rmyqePpo/iA+7ZCt7RwqH
	 axASATQSWEtlQ==
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e28fe07e97dso4350588276.3;
        Mon, 04 Nov 2024 07:57:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+ajockVYa4qSm+DAZ3DMOHSyKKIchZzwafAKVJBKdZ+d8Tb/GIhiXazyIsnXtS7oYqkpZ+rS/QkM+@vger.kernel.org, AJvYcCWBYEyUPPlUVQjRL+F6XxtiwyzU//nfg+lZxIHevxI3gHujcmZzJ6DrtkeYjJW7ObPJMaGBjdQTt3X4299F@vger.kernel.org, AJvYcCWG5fZkjSNfwgtq2jMeIhuR8zmlmW+si2gErxRA0/UIkRffkD8soBRGwHRUAOIzeU6bZDxYsIdb2rFcD2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLbTX72UxhtMSv1sUjIpU/70lyRo7DfMEjcDdNzbS8Gf5MN1F
	4DaZbnku/yh9nCI9m+fpmfjl7PzurQGwMqNuf+oTrclOCIT4uuW8q1mrLvrkiS+0Q4W6cM3NjBL
	xKAlTYFPrBiLr3o0htcObQtvRZA==
X-Google-Smtp-Source: AGHT+IFJthhkSzkBdnbiB5dDIi1s/eaCvQbG6JsPmn7TbVCmrz/zQ6MVdpFKk0iB6A/Zy7+RL9YE/wF2HoO/7hQxgz4=
X-Received: by 2002:a05:6902:3188:b0:e33:25e2:4af6 with SMTP id
 3f1490d57ef6-e3325e24e4amr5209097276.6.1730735837784; Mon, 04 Nov 2024
 07:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102125712.2647325-1-csokas.bence@prolan.hu> <20241102125712.2647325-3-csokas.bence@prolan.hu>
In-Reply-To: <20241102125712.2647325-3-csokas.bence@prolan.hu>
From: Rob Herring <robh@kernel.org>
Date: Mon, 4 Nov 2024 09:57:06 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+BFBTUT_VrkmCTV-XBmNvscGF0Bzfj7LEeytRea55aBg@mail.gmail.com>
Message-ID: <CAL_Jsq+BFBTUT_VrkmCTV-XBmNvscGF0Bzfj7LEeytRea55aBg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: sound: Add Allwinner suniv F1C100s
 Audio Codec
To: =?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 8:00=E2=80=AFAM Cs=C3=B3k=C3=A1s, Bence <csokas.benc=
e@prolan.hu> wrote:
>
> Add compatible string for Allwinner suniv F1C100s audio codec.
>
> [ csokas.bence: Reimplement Mesih Kilinc's binding in YAML ]
> Signed-off-by: Cs=C3=B3k=C3=A1s, Bence <csokas.bence@prolan.hu>
> ---
>  .../sound/allwinner,sun4i-a10-codec.yaml      | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

