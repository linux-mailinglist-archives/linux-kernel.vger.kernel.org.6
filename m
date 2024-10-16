Return-Path: <linux-kernel+bounces-367909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889789A0835
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C5228572F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFBE15C147;
	Wed, 16 Oct 2024 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3rsI39t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3A202F98;
	Wed, 16 Oct 2024 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077439; cv=none; b=ZDdUyFHCXJ6dsn/DBhnsqRu8CVnXprZ1O2XeBzUsJlCCIv+jg1uga5y6hq4QMYAZj5oqO/yFxHWjSblwGGg2sYxu1E05jfQl9yLo6enT4kZk6SJmhCWfZYNSDNN8ZflHYp35fTs5oXTRzpXFTLOdHn5ojW6iKrKTp2swKrhdQS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077439; c=relaxed/simple;
	bh=GsENx6MRmJMQiorSNSy4id1PzrrPiwHu0oIg0u7RwA4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=R05pxkpEMqyEIWWqwltaZJMZ+TZsg19DBI1Pgto6N5PdUs8Dai0lFpCwMCVgVXHiAi4eE8s+aCFFN0abqiT4drGvQbVzMee/PT+fk0LuUsFvTUZ0qy1wzaC+e1t4qKvjtIG1CCsl9MqaMTOsji2m1Xtbjyi/syuechP3DUFEhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3rsI39t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A6FC4CEC5;
	Wed, 16 Oct 2024 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729077439;
	bh=GsENx6MRmJMQiorSNSy4id1PzrrPiwHu0oIg0u7RwA4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=f3rsI39t+cDkTDCAnD2Y04dMHOsf29eiCP80VorJiTmbHrJsD4tBgche2VXgeDAMY
	 IzKM4cBV40v89YVkPyUK0qkMzUpkICLagon3hiMhRiGqsc5qlLD41DfGZ+CSHz7nn4
	 rnqW5agUPokRadfIG5lQNjQk2SxwRLh06Ioq+GUmx8aYNOlQy5WHuSkOd2ijVdhRqj
	 yKRdimw3E5m0UEXQA+tH8NuNQIpqt7OQ0s7cjLVvYqlmsckwAkcJ/x7EVD6Cfd1UDf
	 aHrDYth/RasVqKyb1K36NcV85aFniF77xU/aTDX6o7+aVwTapPajFqeChHCxxk7yvY
	 ZMCObSdHmuWew==
Date: Wed, 16 Oct 2024 06:17:18 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, 
 patches@opensource.cirrus.com, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, asahi@lists.linux.dev, 
 David Rhodes <david.rhodes@cirrus.com>
In-Reply-To: <20241016-cs42l84-v1-1-8d7e9d437d2d@gmail.com>
References: <20241016-cs42l84-v1-0-8d7e9d437d2d@gmail.com>
 <20241016-cs42l84-v1-1-8d7e9d437d2d@gmail.com>
Message-Id: <172907743814.946384.14631158473077396509.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: sound: Add CS42L84 codec


On Wed, 16 Oct 2024 20:41:00 +1000, James Calligeros wrote:
> From: Martin Povišer <povik+lin@cutebit.org>
> 
> CS42L84 is a headphone jack codec made by Cirrus Logic and seen in Apple
> computer models starting with 2021 Macbook Pros. It is not a publicly
> documented part. To a degree the part is similar to the public CS42L42.
> (The L84 superseded L83 seen in earlier Apple models, and the L83 was
> pretty much the same as L42.)
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                                                 |  1 +
>  2 files changed, 61 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/sound/cirrus,cs42l84.example.dts:25.45-46 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:129: Documentation/devicetree/bindings/sound/cirrus,cs42l84.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1442: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241016-cs42l84-v1-1-8d7e9d437d2d@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


