Return-Path: <linux-kernel+bounces-173530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C728C01D8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31233285F97
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1617012A169;
	Wed,  8 May 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdK4UBEe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76F83A19;
	Wed,  8 May 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185218; cv=none; b=SJdTn66RZztQnVcjL1GK+qOoUEEuidxWt1fAD2i3DUMlkavLH3BIDyXsPuFo7twU9EcqDx7/EOxqJO+exPDJQdCrPH+42FCIHsWWy4U0+wWwX1ZDFS/nTHVZ5iR3q86EgnY6a1IqUlxkw+aJelDzj9pRSjRZtKIEYp4ZKrhn+3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185218; c=relaxed/simple;
	bh=7Bcs9egzutasXmQ3GODsdhVNrBN1zsWCrT3shblN2JM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=F9LFIwiIy5IFcUfdXuOx+y+GtGrp4YzfgytRrDLZK3l+zR/+Y/nP1hb5T9F/kpRHh5STszlVJxcmehxIg3Gcv7k8zuWraQ5dwo7WTvSyJO+EMzPq8GrsTUgSXANU3CFk+0fm6ygh53Z5nEZNPEE8NF6NHCxzrv1koZBSO4lGaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdK4UBEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E39C113CC;
	Wed,  8 May 2024 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715185218;
	bh=7Bcs9egzutasXmQ3GODsdhVNrBN1zsWCrT3shblN2JM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HdK4UBEeqasVn1Z9Gn+ouAO3JvJmVmtdl++v4Hzvmibx+MGABOUUfOwptnu2av+eO
	 /Mpj+/zadxpDUBDMuTiYbJ+CdfFNdftsoqN+mrw6FbW3jdXLaLSGcw1pcYY4A+sGkK
	 Hq2WZkkoVZCwCwqtgM46GE0hBmXcWXkq3K2zzzi+9DXmylBY+QtELrshQWlPDDagem
	 k3UJN75Vif1TOkRW+WmD+INlP7qFLGOfOIBMbULDsOh99gXZmy+EXb1GpC/TC+IG5J
	 UMGMnD5c7+lIeV1FmocU45NIUCod+sSWhgJ9TyclaSvLrWpLc3If9mCik8XY57KXoe
	 91iPEBxTpbNEg==
Date: Wed, 08 May 2024 11:20:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Michael Turquette <mturquette@baylibre.com>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh+dt@kernel.org>, linux-amlogic@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <20240508144259.191843-4-jan.dakinevich@salutedevices.com>
References: <20240508144259.191843-1-jan.dakinevich@salutedevices.com>
 <20240508144259.191843-4-jan.dakinevich@salutedevices.com>
Message-Id: <171518521621.2161709.4756483901685009302.robh@kernel.org>
Subject: Re: [APPROACH 2 2/2] dt-bindings: clock: meson: Convert
 axg-audio-clkc to YAML format


On Wed, 08 May 2024 17:42:59 +0300, Jan Dakinevich wrote:
> Convert Amlogic AXG Audio Clock Controller binding to yaml.
> 
> Signed-off-by: Alexander Stein <alexander.stein@mailbox.org>
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  .../bindings/clock/amlogic,axg-audio-clkc.txt |  59 ------
>  .../clock/amlogic,axg-audio-clkc.yaml         | 181 ++++++++++++++++++
>  2 files changed, 181 insertions(+), 59 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.example.dtb: clock-controller@0: clocks: [[4294967295, 35], [4294967295, 11], [4294967295, 12], [4294967295, 13], [4294967295, 14], [4294967295, 69], [4294967295, 3], [4294967295, 4], [4294967295, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240508144259.191843-4-jan.dakinevich@salutedevices.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


