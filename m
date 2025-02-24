Return-Path: <linux-kernel+bounces-529655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 826B5A4294A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9577A6096
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93AD2641E9;
	Mon, 24 Feb 2025 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj/5A4d6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16762263F26;
	Mon, 24 Feb 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417563; cv=none; b=nORxHtFTlkDMAWtl4D7iNNJIA5yqfcPaF+aCTsiP5Fh7eOBUZd0mQC2ukYCxuQLwwqX7ewtYoLSINI+acT2tkUb+KTS2dgtxHza9M0LuR3YgFYerCoXUm43JD3vZfrMd7jtv4xVFPXWU6rLb6iLZM3KlD46+X9PfCVXFUYcPtaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417563; c=relaxed/simple;
	bh=DqLA3R9+ncfGcr/YJS6lhTf2TaveCWhzLJel4MYNo6I=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=K/QVkVf7vaOBt93/nMmZuvE9H5OnyGgJl6loaUkpw3A1PHw7syCDxFea95JKSuaNPh8vslGQEjd3Uuy2mW3+EFeK18+/DTjC22svL8Yr73VnShMdhOzEaIMWYPeLhfEw3mm9oO8q8wjoaN+DjB92s1gEscOM6IuuFPqPywjE8eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj/5A4d6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9ADC4CEEB;
	Mon, 24 Feb 2025 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740417561;
	bh=DqLA3R9+ncfGcr/YJS6lhTf2TaveCWhzLJel4MYNo6I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=oj/5A4d6B52s9netUSHzaXDHUKauk4ZcSJNpUdrGaxvCn3ezRAPD/QQgUpzHjFm8X
	 f7h1I9h9c3piFl0NU62S/i0PL1ErNr0MKeaC8ADaF9VbT15kotJwl2t1to39SP/jNY
	 bn6N5EXWAA6d4cigSjRIPgSOPtnVRmnW0FQW+ll+UHHHNeTMG+4MqDGCwTtMi2DBse
	 rDBqxn9i1tPyVu5UKn3YYJZ8rfMJh43d0JGdXGi2CQgxm9yBtkmwVImJhhLQkNyTrs
	 OK26oVeHXewjJaBw/jQElWNnnMCC2kMkmRT+p6ckzKEzWk0MfYEWWZUnXrPVb1YDxM
	 UC96q7730INBA==
Date: Mon, 24 Feb 2025 11:19:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
 Takashi Iwai <tiwai@suse.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 patches@opensource.cirrus.com, Saravana Kannan <saravanak@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-sound@vger.kernel.org, 
 Jaroslav Kysela <perex@perex.cz>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>
In-Reply-To: <20250224155500.52462-4-francesco@dolcini.it>
References: <20250224155500.52462-1-francesco@dolcini.it>
 <20250224155500.52462-4-francesco@dolcini.it>
Message-Id: <174041755964.3547413.4477664481191696884.robh@kernel.org>
Subject: Re: [PATCH v2 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC
 and EQ support


On Mon, 24 Feb 2025 16:54:58 +0100, Francesco Dolcini wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> Add two properties to select the IN1L/DMICDAT1 and IN2R/DMICDAT2
> functionality:
> - wlf,in1l-as-dmicdat1
> - wlf,in1r-as-dmicdat2
> 
> Add a property to describe the GPIO configuration registers, that can be
> used to set the four multifunction pins:
> - wlf,gpio-cfg
> 
> Add a property to describe the mic bias control registers:
> - wlf,mic-cfg
> 
> Add two properties to describe the Dynamic Range Controller (DRC),
> allowing multiple named configurations where each config sets the 4 DRC
> registers (R40-R43):
> - wlf,drc-cfg-regs
> - wlf,drc-cfg-names
> 
> Add three properties to describe the equalizer (ReTune Mobile), allowing
> multiple named configurations (associated with a samplerate) that set
> the 24 (R134-R157) EQ registers:
> - wlf,retune-mobile-cfg-regs
> - wlf,retune-mobile-cfg-names
> - wlf,retune-mobile-cfg-rates
> 
> Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> v2: Added an example of how to use the ReTune Mobile config properties
> v1: https://lore.kernel.org/lkml/20250206163152.423199-4-francesco@dolcini.it/
> ---
>  .../devicetree/bindings/sound/wlf,wm8904.yaml | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/wlf,wm8904.yaml:167:111: [warning] line too long (154 > 110 characters) (line-length)
./Documentation/devicetree/bindings/sound/wlf,wm8904.yaml:172:111: [warning] line too long (154 > 110 characters) (line-length)
./Documentation/devicetree/bindings/sound/wlf,wm8904.yaml:177:111: [warning] line too long (154 > 110 characters) (line-length)

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/sound/wlf,wm8904.example.dts:52.17-18 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/sound/wlf,wm8904.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1511: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250224155500.52462-4-francesco@dolcini.it

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


