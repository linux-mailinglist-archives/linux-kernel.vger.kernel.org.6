Return-Path: <linux-kernel+bounces-569141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C4FA69F07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 05:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A76189654E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90331D63F6;
	Thu, 20 Mar 2025 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCk9eEcJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663526AF5;
	Thu, 20 Mar 2025 04:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742444894; cv=none; b=noC57teeuZKw4Jlrapcm9bJ7zcEyB1llgkfKV4tuk1SgLZnOktZSSqGUsJGwxjdUT+99Yu7D/WctAZ2KgyGiXYJW8hdseKTL3mf9ZoWvHIEa8Cwf0eldIu/tPzP5e/jIBQYezo2SLYwKZ6hEeIoFc+WA7ACd1Zo9RNTyJKRhZv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742444894; c=relaxed/simple;
	bh=aPxXWfMVVlCrz1Tsr1dm7hBdMh7cE/iDLBs/zpr0aQ0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=keg9aR5CALBLc7yEMlksudXixpwi17f8/Noj1M/gegIQ1yjnBGtfa+LZbvpEvbHC8/KAoCkBkMl3mwtjqGWLLXXCQxaGeMmHbuFA7DoVnZeHS+N1njJXUkzanYX4Rb6TrPZMm0p86XmeJPFhh58RvzK2mcunJpJqgkqyyMBeJhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCk9eEcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EDCC4CEDD;
	Thu, 20 Mar 2025 04:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742444893;
	bh=aPxXWfMVVlCrz1Tsr1dm7hBdMh7cE/iDLBs/zpr0aQ0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=oCk9eEcJgai12daLGbvcg0HJkOWBEYwzhsn1ivhE/1lPXZp3Sdpey/TBGyPoXuvKJ
	 70CDvY7zr40/gcyyAW1qzHX6fjrPnEKLvSiUlZm9NZgKsieNYtqhyqNFZp03uJl1SO
	 hgYLYSug8wCz/wjRTzEpBNn3XfE2Keth0XlFdxX5Pccr5gWZpDzDgeOJUkHySlw/rr
	 0tV0Ey1gSGXkpGjHZLLSeIlLMULyUW4ar08zl5ofYJk6BVWb8ezhtD4oEA7ZAw/97L
	 +1MsXSkELbwJVYmxsMLu6dyWxNNmJcD9KKXCMOERm3wRSn831JYpJDqN5rH032Fnr2
	 W4Kc5wBAPsCAQ==
Date: Wed, 19 Mar 2025 23:28:12 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 devicetree@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
 Takashi Iwai <tiwai@suse.com>, Conor Dooley <conor+dt@kernel.org>, 
 Xiangzhi.Tang@mediatek.com, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-sound@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, 
 Jjian.Zhou@mediatek.com, linux-arm-kernel@lists.infradead.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org
To: "hailong.fan" <hailong.fan@mediatek.com>
In-Reply-To: <20250320031753.13669-3-hailong.fan@mediatek.com>
References: <20250320031753.13669-1-hailong.fan@mediatek.com>
 <20250320031753.13669-3-hailong.fan@mediatek.com>
Message-Id: <174244489218.3285851.2715414657089059683.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: dsp: mediatek: add mt8196 dsp
 document


On Thu, 20 Mar 2025 11:17:25 +0800, hailong.fan wrote:
> This patch adds mt8196 dsp document. The dsp is used for Sound Open
> Firmware driver node. It includes registers,  clocks, memory regions,
> and mailbox for dsp.
> 
> Signed-off-by: hailong.fan <hailong.fan@mediatek.com>
> ---
>  .../bindings/dsp/mediatek,mt8196-dsp.yaml     | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.example.dts:18:18: fatal error: dt-bindings/clock/mt8196-clk.h: No such file or directory
   18 |         #include <dt-bindings/clock/mt8196-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1522: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250320031753.13669-3-hailong.fan@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


