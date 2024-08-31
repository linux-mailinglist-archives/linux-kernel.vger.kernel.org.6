Return-Path: <linux-kernel+bounces-309731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05505966FD6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B561C21D35
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 06:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FAC16C451;
	Sat, 31 Aug 2024 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="MDoyvHM5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DGOJYmEP"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB86114D28F;
	Sat, 31 Aug 2024 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725086597; cv=none; b=eU39XZniegHHy/dDdkoSFLLwkgkgMpYSe4ZXRO56nmkU5T17juAtQoDz3Xt771oWwaJMMZyNGCtHGOcYQyrm2wo8y1zyP7xAQP0YEoW84Ey8RQq9bH1TdJbkRgXD7pL79IeU6CfmLNFwiJ2DYRctuc6tRtRtg84XJ4KzZ+LQ4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725086597; c=relaxed/simple;
	bh=sovnmn2rGKHWaDPS2NXaCqNFTLQYAXjs6Sh8/7tv7DE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=jiWvR7XxBoV3SYbjpOhBeGmVqQDJrLw0KW/61UdCvzHZRUixZfyWp97yyg3UREFn9tfbRJsI9ZneumfjzSIsHog0IykkUS71TfAOy2yqFLsQn5RT8ZK/60R5oqGWpgKnjzJAx+l5ZeTqL5+ztYG8hei3qzpXbL+w/WzqjJfu7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=MDoyvHM5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DGOJYmEP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0B7B61140636;
	Sat, 31 Aug 2024 02:43:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 31 Aug 2024 02:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1725086595; x=1725172995; bh=qlDUq7+Pbr+KcskQVJhLgUOd48TYNCLc
	46ToPfunZ1Q=; b=MDoyvHM5E9tNTD3xeCY2EhC7m0jpq/Rlg2IfnHZ8LrENmuZr
	IAUe9XcpumZKXPdmiIOtynJpaP7oUS7NQX4+FY2IJdcjVyCECfBOFpVe5IMSL+8B
	YQl90fsg1fSdLokOQsqBDq9KcZhIPKwMigxWR4kbsbUI/vLhQWIC6ZRLHueR8oXN
	x8PIXRQKjRewjekRkh90dPZw7BwPzR2JM+oIjPCqZfdYAsmZbjp7dvisIfxq+rhY
	blMXw3kvDjFAi8T3kRJkKToC7ipRc/rjPbBIIOBVO5cP7DNeedmOlLWb1va2hJhO
	d3sJ3t573JHKucDtyIBrp+utz1oK4KhY/cfNdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725086595; x=
	1725172995; bh=qlDUq7+Pbr+KcskQVJhLgUOd48TYNCLc46ToPfunZ1Q=; b=D
	GOJYmEPc2NlZHW/vyjadmTcJmxCPxCcARlZX/AVmCP7EXiZZItt4OcXHhG7TsPh2
	9NgzITY/Iiu50s9gnwyL2PKIZvfOQrDHzLqWaN/mPVHsWbFs6lMwupYIHIjRzjKo
	NfUVVSJqmooTEoBXi5ntmBUBsSYontIHEf8zGFK50IsxPZzQBrUb3i2pFN1RrfuB
	etkC5DNij9rt9wvSKFc80nQMm/NQ5xtiXIMjdSL5d3mgmkocJnQ6p7oTb2AP/mx4
	/B5ytK0yH5Py7yheo90ud42+uxmWQfjTPFjkj48lY6XXnKIHMB/NplOkBfzFd/gX
	pLTyGwFNERJpu//EWkZRg==
X-ME-Sender: <xms:gbvSZrG0jObeOMXzpLxfaimaFIn7LP_qGmxEEFEUBpCSSt7iri2PDg>
    <xme:gbvSZoURYu3Usnaf1U9lxFDKpGSURagupL3YCBXbgio5X1LWm8tjgPxfyXAJhB98-
    q8qLnQNSy66kXRbJ2Q>
X-ME-Received: <xmr:gbvSZtJLe6IaK0NuZABfrDabWx46fQ2WymdR7il1oy10sIwdwdYTJyiz34K2ml0HZL8E-EHO4q5fatZWy42dmN4ql-acFGpHySvUKgXBPfq9wWrQMNbm4NnV21Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpegtgffhggfufffkfhevjgfvofesthhqmhdthhdt
    jeenucfhrhhomhepufhvvghnucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrd
    guvghvqeenucggtffrrghtthgvrhhnpedvhfdtudduvdeujeeufffgudekvdefvefgueei
    iedvledtheegieevffdtteekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghrtghp
    thhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeimphhoshhtmhgrrh
    hkvghtohhssdhuphhsthhrvggrmhhinhhgsehlihhsthhsrdhsrhdrhhhtpdhrtghpthht
    oheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqd
    hkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeht
    ghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehkrhiikhdoughtsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhnuhigrdgu
    vghvpdhrtghpthhtohepthhofihinhgthhgvnhhmihesghhmrghilhdrtghomhdprhgtph
    htthhopehkohhnrhgrugdrugihsggtihhosehsohhmrghinhhlihhnvgdrohhrghdprhgt
    phhtthhopehmrghrtggrnhesmhgrrhgtrghnrdhsth
X-ME-Proxy: <xmx:gbvSZpFgGTuLxHEJdj6-Q2yjYliVPEi_hw7E9I-5CIVGlqmywERnuA>
    <xmx:gbvSZhUogPaG7Qzyo-NCoVNv6l4Auq4pAIRzl2Ab6Sp3wNOFBgf5eg>
    <xmx:gbvSZkOL1sLehbKl1f5904XzWTKzxNioDA0c5iWYGAUwl_uavzAlJA>
    <xmx:gbvSZg0P2aQbIKsBhFBWIWjJxnYh9uyj63tVEqM350BFBUze7Cgbtw>
    <xmx:g7vSZmXiDQoU3jmVqilTn48MmvUP-cwTurzVMDDHwz2yzzIBBRaPBek9>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Aug 2024 02:43:13 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Sven Peter <sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/4] dt-bindings: apple,aic: Document A7-A11 compatibles
Date: Sat, 31 Aug 2024 08:43:01 +0200
Message-Id: <5EE567C6-95A1-4441-8D29-E365B975B34F@svenpeter.dev>
References: <20240831055605.3542-2-towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, konrad.dybcio@somainline.org,
 ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20240831055605.3542-2-towinchenmi@gmail.com>
To: Nick Chan <towinchenmi@gmail.com>
X-Mailer: iPhone Mail (21G93)


> On 31. Aug 2024, at 07:57, Nick Chan <towinchenmi@gmail.com> wrote:
>=20
> =EF=BB=BFDocument and describe the compatibles for Apple A7-A11 SoCs.
>=20
> There are three feature levels:
> - apple,aic: No fast IPI, for A7-A10
> - apple,t8015-aic: fast IPI, global only, for A11
> - apple,t8103-aic: fast IPI with local and global support, for M1
>=20
> Each feature level is an extension of the previous, for example, M1 will
> also work with the A7 feature level.
>=20
> All of A7-M1 gets its own SoC-specific compatible, and the "apple,aic"
> compatible as a fallback.
>=20
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@svenpeter.dev>


> .../bindings/interrupt-controller/apple,aic.yaml   | 14 +++++++++++++-
> 1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,=
aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.=
yaml
> index 698588e9aa86..4be9b596a790 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yam=
l
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yam=
l
> @@ -31,13 +31,25 @@ description: |
>   This device also represents the FIQ interrupt sources on platforms using=
 AIC,
>   which do not go through a discrete interrupt controller.
>=20
> +  IPIs may be performed via MMIO registers on all variants of AIC. Starti=
ng
> +  from A11, system registers may also be used for "fast" IPIs. Starting f=
rom
> +  M1, even faster IPIs within the same cluster may be achieved by writing=
 to
> +  a "local" fast IPI register as opposed to using the "global" fast IPI
> +  register.
> +
> allOf:
>   - $ref: /schemas/interrupt-controller.yaml#
>=20
> properties:
>   compatible:
>     items:
> -      - const: apple,t8103-aic
> +      - enum:
> +          - apple,s5l8960x-aic
> +          - apple,t7000-aic
> +          - apple,s8000-aic
> +          - apple,t8010-aic
> +          - apple,t8015-aic
> +          - apple,t8103-aic
>       - const: apple,aic
>=20
>   interrupt-controller: true
> --
> 2.46.0
>=20


