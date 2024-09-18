Return-Path: <linux-kernel+bounces-332977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED3F97C1C6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 00:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B1A1C217B5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE181CB31C;
	Wed, 18 Sep 2024 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HytxGIx0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1099107A0;
	Wed, 18 Sep 2024 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726697154; cv=none; b=W/5xp9uxAvg60iqndgWKQ/Q0oGMusYkCtriG8m+vYYDCGRSzS/vN/VOaWVKrPcWUkLggfcufaTEF8fjJCH1I0SHhqxpInKNmWUji2I4YxaaAkvWPgYw+a7+2kps/ATtgMZd8YvePSFahvCKFrcIrBmJOTpa9np6WlICzjUZXrwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726697154; c=relaxed/simple;
	bh=cgstcUehN5VFn4zlnu537vRmdjTjlflTYe2aXldB7nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sey9Ts1jP95MVWdwCLzlcthoXr9gSnu4ot2u+bchN8faweqYzuIxTQUy3/3ZDjS0YyLa0804yJ296/3jMCkNI2aFhhGXYAFlvB+1JpMf3L1K/WkRUpCipopakF1m28M6pTdff8Gfi4yFnUuh/xBDN37GwlJayBEOcv2lmkDJ/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HytxGIx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378FEC4CEC7;
	Wed, 18 Sep 2024 22:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726697154;
	bh=cgstcUehN5VFn4zlnu537vRmdjTjlflTYe2aXldB7nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HytxGIx0sZvxygUX2fMMLg1CIj3SUmuzTpQ3SRV93+V6KC74PLjwbP+OgVjnUO3X8
	 3fzey17anr96jceWyCQhZ0FtBJfoRXL1wtDuJvdtyq0JhiRFduddr5DorFPdhmzZe/
	 /QpMcCShDDLPvjBgvTYWsvxAf3ojgxnMgVZZmfpmbZ+opPSxbMIYEHXKT2/3wSeFUa
	 T8h/UgGDLTzvNLOQ/UKpXSGffMOVZdxL2jIjQmXGuQqs31JBiTuzCwDVzLvp4T+5WU
	 wAOiXFfv2t5XW92qfdkRfG5D9VJG089L7tIg2yNsj9TYA0cxe5EhWv4u/1ChoId6iH
	 ae5P2I78apoKg==
Date: Wed, 18 Sep 2024 17:05:53 -0500
From: Rob Herring <robh@kernel.org>
To: Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>,
	Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Khanh Pham <khpham@amperecomputing.com>
Subject: Re: [PATCH] dt-bindings: hwmon: Add adt7462
Message-ID: <20240918220553.GA2216504-robh@kernel.org>
References: <20240918103212.591204-1-chanh@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918103212.591204-1-chanh@os.amperecomputing.com>

On Wed, Sep 18, 2024 at 10:32:12AM +0000, Chanh Nguyen wrote:
> Add device tree binding and example for adt7462 device.
> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>  .../bindings/hwmon/onnn,adt7462.yaml          | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/onnn,adt7462.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/onnn,adt7462.yaml b/Documentation/devicetree/bindings/hwmon/onnn,adt7462.yaml
> new file mode 100644
> index 000000000000..4a980cca419a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/onnn,adt7462.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/onnn,adt7462.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ON Semiconductor ADT7462 Temperature, Voltage Monitor and Fan Controller
> +
> +maintainers:
> +  - Chanh Nguyen <chanh@os.amperecomputing.com>
> +
> +description: |
> +  The ADT7462 has temperature monitors, voltage monitors and multiple PWN Fan
> +  controllers.
> +
> +  The ADT7462 supports monitoring and controlling up to four PWM Fan Drive
> +  Outputs and eight TACH Inputs Measures. The ADT7462 supports reading a single
> +  on chip temperature sensor and three remote temperature sensors. There are up
> +  to 13 voltage monitoring inputs, ranging from 12V to 0.9V.
> +
> +  Datasheets:
> +    https://www.onsemi.com/pub/Collateral/ADT7462-D.PDF
> +
> +properties:
> +  compatible:
> +    const: onnn,adt7462
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1

How would this work? 'resets' generally is used for on-chip devices and 
a reset controller. That doesn't exist at the board level. A standalone 
device typically uses a GPIO lines if there's a s/w controlled reset. 
That would be the 'reset-gpios' property.

Rob

