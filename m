Return-Path: <linux-kernel+bounces-209282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A4490312E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3983A1F2A86C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4540170859;
	Tue, 11 Jun 2024 05:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuB7FUOu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301F2433C4;
	Tue, 11 Jun 2024 05:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083839; cv=none; b=AwVDATx7ORXQBbj8OgalcjjCsYbUXlXRvnVXe/tQzePte2sAT41CYhoYX5PPqQYqU1XtfnSHzo/ZE4hWzQthe1hE+U++PCs2S5JbodbryEp0KwTVG7oTA2CtjKWtRPKMU/fFJgmhDKJkqaiRiHi5sdu/YhRuMc79RL44XlOFWbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083839; c=relaxed/simple;
	bh=mYrRznVRP3/LER6a3P+Bz/NvuHfeT8MQQDa9NDjpK+w=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=GLsW750wyHlz9eUDlp0hdKjPRSPzv2tH895kNMl7aWIhCuo+Jot9O34azvVdXhd7Ipz1OiNjhPYba9qdJs4IdHjb58s9pjVpR2W7ppFA/vuwPyTe/545/grWQdBscNs4E7juuP68zd5K4c1rvolZXsMzf1npoGs21BPfO4OLzh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuB7FUOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9A1C3277B;
	Tue, 11 Jun 2024 05:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718083838;
	bh=mYrRznVRP3/LER6a3P+Bz/NvuHfeT8MQQDa9NDjpK+w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QuB7FUOuWPKOZp5mRnLxVa54EASLNyohTlp038o5kMMOJ9Xzs4HjBrFT2JnBOfZ0K
	 dIILW20JcO/FU8XPH8ib8jxIn92zmBjyLJyE3/R7WJV1ff+QoEw/3fXP6wuDb6PCIY
	 MQAVluODUz5CbjhwUcw9+NnOHJ8e+AgNGekwEy/hLA9iQIdTmejX3qIVSQp5AT5SUY
	 Yqa+J/xwz8eQhbR9aI1gXD1zOYIgQmI/xHk0bGDGfVLnz0gV0z8LJYbSFVIi+G0nbf
	 61OLFqJbwuQfZsUg/rgO14OF7OpNe3BF0d05rau+44abQHM9LJNLXVDJVZo8y5b5Js
	 h8tP9ZlOKTvmg==
Date: Mon, 10 Jun 2024 23:30:37 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kanak Shilledar <kanakshilledar111@protonmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Kursad Oney <kursad.oney@broadcom.com>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Anand Gore <anand.gore@broadcom.com>
In-Reply-To: <20240611035329.33648-2-kanakshilledar@gmail.com>
References: <20240611035329.33648-2-kanakshilledar@gmail.com>
Message-Id: <171808383738.4093720.10401571726065539411.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: reset: brcm,bcm63138-pmb: convert to yaml


On Tue, 11 Jun 2024 09:23:23 +0530, Kanak Shilledar wrote:
> Convert the Broadcom BCM63138 Processor Monitor Bus to newer DT
> schema. Created DT schema based on the .txt file which had `compatible`,
> `reg` and `"#reset-cells" as required properties.
> Added one line description which was missing in the original .txt file.
> Added Philipp Zabel as the maintainer (took from MAINTAINERS file).
> 
> Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> ---
>  .../bindings/reset/brcm,bcm63138-pmb.txt      | 19 --------
>  .../bindings/reset/brcm,bcm63138-pmb.yaml     | 43 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.example.dtb: reset-controller@4800c0: '#power-domain-cells' is a required property
	from schema $id: http://devicetree.org/schemas/power/brcm,bcm-pmb.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.example.dtb: reset-controller@4800c0: '#reset-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/power/brcm,bcm-pmb.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240611035329.33648-2-kanakshilledar@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


