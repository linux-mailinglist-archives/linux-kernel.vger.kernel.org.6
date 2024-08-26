Return-Path: <linux-kernel+bounces-301373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A9E95EFB3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429981C214BB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E1C15533F;
	Mon, 26 Aug 2024 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyEH/Jfn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4075A15530F;
	Mon, 26 Aug 2024 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724671613; cv=none; b=jgJFuDXb+Izn6fA0S/Iz5bzPj2lAO2mG2AEbk2ws/GIY3CCutOLPBfi+SaSmFVqr8e6nN+zZ3DESMTTETCW8k5V540YBspTU0LyoaJhhMaqQqDv/h+pfR5LatMda2zWX/3cKd4gZKpgktZv0WUdjyqjqjFjx31f52yujxjG8tm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724671613; c=relaxed/simple;
	bh=r00LN1PqLZDKXFjf8rfhrFzUtip5a5fFuozdHqUWlDo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=VkW/QoH0AvvpwT8LAYwT0BWKTl0e1nxpF7DsyZgqXnnkpLxO9aaEWh3BJbeBKW31dnlGsXWHxhN5cul+FdLtfmRzYPRwTjXXhi6SxNbqu2E/yIxhTtUc2w2VFFQ3Iqa5+MrO8EuMUHUP3dJ8E0DoxB5D5lSRDLrWgCh0yHezJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyEH/Jfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8803EC4FF4B;
	Mon, 26 Aug 2024 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724671612;
	bh=r00LN1PqLZDKXFjf8rfhrFzUtip5a5fFuozdHqUWlDo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uyEH/Jfn4Dh6ZgtAzNXKgKkV9A/qsGf8uDHHdfXANj7xiWFYQ0xBIc62M+9cSdVmW
	 xtc7Ix+96NijchZXFupg6CTeRQl1BA5FyXuqPGt2/HTINkwmQTlVS5pNYn3xcAwsdw
	 bi44aAZi5pW/niIIqcq0xqnHCUCeyYI3NxL1sbfLn0jTrQN/LbaBTkd2lbhmS2ODue
	 a2/jrShopjAnVTO+1DbRa4+A9UUFSR9c3NVY4UI47yMIGpd5lnjxubYAW4TQR9TvVL
	 SHnBrO5el8pBmyjpYFbTMkcRsLcDuAB04BPcI9pLR7MMG5/URB33NALbKgIq8nuELQ
	 uq0yIhxsnqtwg==
Date: Mon, 26 Aug 2024 06:26:50 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: linux-sound@vger.kernel.org, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, patches@opensource.cirrus.com, 
 David Rhodes <david.rhodes@cirrus.com>
In-Reply-To: <20240826-cs4271-yaml-v1-1-dad3f0b041ef@maquefel.me>
References: <20240826-cs4271-yaml-v1-1-dad3f0b041ef@maquefel.me>
Message-Id: <172467161080.3913761.4311461906537952608.robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: cirrus,cs4271: Convert to dtschema


On Mon, 26 Aug 2024 12:53:08 +0300, Nikita Shubin wrote:
> Convert the Cirrus Logic CS4271 audio CODEC bindings to DT schema.
> 
> Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Link: https://lore.kernel.org/all/20240715-ep93xx-v11-0-4e924efda795@maquefel.me
> ---
> This is complementary patch to ep93xx DT conversion series.
> 
> Based on "ASoC: dt-bindings: cirrus,cs4270: Convert to dtschema" patch.
> ---
>  .../devicetree/bindings/sound/cirrus,cs4271.yaml   | 91 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/sound/cs4271.txt | 57 --------------
>  2 files changed, 91 insertions(+), 57 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml:91:4: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240826-cs4271-yaml-v1-1-dad3f0b041ef@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


