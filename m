Return-Path: <linux-kernel+bounces-233087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F3D91B21C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DB01C223D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83811A2542;
	Thu, 27 Jun 2024 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASJTHe7v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155FA2837F;
	Thu, 27 Jun 2024 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526907; cv=none; b=R4q+d32QN5Hzq8Udan72dqHTfg8b5HUJ6K/kFTsTKmQw4VUYdSZlGe23MtOMANjHwMKUFggbex2Cem6kcgT2KBHfMmTMJzKymA4JW2ZbRvksquCFtLugJJgupeKNhB7pk9O1q9B93IpxQtS6RB5dPFZB4V97xfQ+9i6MhCQAqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526907; c=relaxed/simple;
	bh=SmASSkNIQUG8VLWsW1zspcVeuBuoZnFMDAEdYCsTYBs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=J1hc5l7a5/QT2CTI9d0NJZGwzHMJJNActvqFZ7gmdHDecw6m8df0eQs6VnBIptHjup8JHtKasE5ya7PobjrYNKMOsubOjdm+mJfA4BbqjksxD7J5IIAxa1wli9zQCeGQsnJXRPJinbQsI8V80sKjzfcSRhXWeWAxftnFmzbcpIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASJTHe7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F891C2BBFC;
	Thu, 27 Jun 2024 22:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719526906;
	bh=SmASSkNIQUG8VLWsW1zspcVeuBuoZnFMDAEdYCsTYBs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ASJTHe7vt4y9L8Iu4knPDGP7pRfaBnA5Z1mUInqj4snW5blWqtw3tlkAo7Io0Q2xP
	 a34gjjD75dqr1K+JD8W6ZL11+G5CaT1zbK03uZsLqGew1yjRTDC0eEFJ7nRCJcokOb
	 Ex+VFojXTf6vItVZzcuMZMj/Rstm4RSBodu/FATJKXOIIgp2L7uNPdw4fZX09OesSB
	 MpMlDGRLMlwmHjrIjb+WcxET1GIcGk2fWcTUwRka6D3ksrIxaluPs0isJNp/hM0lrF
	 Yn+MuDhesEHHDtD4nVSgc3uZa6TikiraaBwZ/JqqOZjPOZ7wuE1Sjvu3lTbUVbs59l
	 C8qtdeKu/FYrQ==
Date: Thu, 27 Jun 2024 16:21:45 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 linux-arm-kernel@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, 
 Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20240627205309.28742-2-ansuelsmth@gmail.com>
References: <20240627205309.28742-1-ansuelsmth@gmail.com>
 <20240627205309.28742-2-ansuelsmth@gmail.com>
Message-Id: <171952690505.706895.16327382675464090624.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: clock: mediatek: add syscon
 compatible for mt7622 pciesys


On Thu, 27 Jun 2024 22:52:57 +0200, Christian Marangi wrote:
> Add required syscon compatible for mt7622 pciesys. This is required for
> SATA interface as the regs are shared.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/mediatek,mt7622-pciesys.yaml           | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.example.dtb: clock-controller@1a100800: compatible: 'oneOf' conditional failed, one must be fixed:
	['mediatek,mt7622-pciesys'] is too short
	'mediatek,mt7629-pciesys' was expected
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt7622-pciesys.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240627205309.28742-2-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


