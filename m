Return-Path: <linux-kernel+bounces-526730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8896EA40286
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733B017CF84
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00A0204F60;
	Fri, 21 Feb 2025 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuSHkfzf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90D3FD1;
	Fri, 21 Feb 2025 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176254; cv=none; b=VWGVNobiNLyqJDvf1K7SIxwk6pJfDVLYO99wgbM7rNQBB+ByEEP1RXW7w0tN1daUjIqHVPSW8nCjNNEWkpQ2CqgTfi9JkswnKpPDpy1CgRL3heS9LbtSC4GYihRJ0C6DW1TDFREicfrysaOo4k4MVVe/U1ix82hxRdiSoIYQCQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176254; c=relaxed/simple;
	bh=zqSQJ2nItJxAmcLhpr+YNwKtAwSoDSxjxXX4H9cP31E=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Hjb1NkwqdcjDnI+Q7rF04379Dc2lmNYNhkPOyiQlGtyukK0pEEbeQnN3CJwAW3iasR/FLSEY12pfG5xdFQetMfx9d9XsPV0ajv/qHIC+Y1mTo2QXbBUPqY7ER6qTjSOE9MRByaecQ0fCya7LCC8t8M9IFmd5m86L5PvrZURgMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuSHkfzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D9EC4CED6;
	Fri, 21 Feb 2025 22:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740176253;
	bh=zqSQJ2nItJxAmcLhpr+YNwKtAwSoDSxjxXX4H9cP31E=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ZuSHkfzfm3y+C6pKoGDXkq6uKMeA1PFNKvqIQSmopCIU3PSS3028k0smW8r/TgTmu
	 TdpsFwaMhrnCIUmtZKf9zJIXMB9gsb1FVdKpbbZHiR/aIJKmJKg9n+jdmMhaMKlYP/
	 F7iwULDR9e6ogLVAXBEN9e4Q1IFO0mE/zikMbne2254GJBQfk08WFQ6MNpRsNeHuDX
	 vDFM3M7j0jHWtPPRlWxH6mFUyCezNbKPYLgkfm6pFVsnNhnQzE77ORPgQpp945e5hW
	 Qpf+FVEiCwGWAj56/HkeysTYCwLLEESlOgEOm+LNwTLQ79685juFCbNQYuwJ2qBIx0
	 YUdlPo4W4rjcw==
Date: Fri, 21 Feb 2025 16:17:31 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: broonie@kernel.org, Guenter Roeck <linux@roeck-us.net>, 
 conor@kernel.org, Jean Delvare <jdelvare@suse.com>, 
 linux-hwmon@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20250221213837.1594057-1-naresh.solanki@9elements.com>
References: <20250221213837.1594057-1-naresh.solanki@9elements.com>
Message-Id: <174017625167.177256.18090844178565157862.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: ir38060: Move & update dt
 binding


On Sat, 22 Feb 2025 03:08:34 +0530, Naresh Solanki wrote:
> Move dt binding under hwmon/pmbus & align accordingly.
> 
> Previously the DT binding was invalid & wouldn't work with pmbus driver.
> Pmbus driver expects a regulator node & hence added the same.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
> Changes in V2:
> 1. Update commit message
> ---
>  .../hwmon/pmbus/infineon,ir38060.yaml         | 61 +++++++++++++++++++
>  .../bindings/regulator/infineon,ir38060.yaml  | 45 --------------
>  2 files changed, 61 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir38060.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir38060.yaml: maintainers:0: 'Not Me.' does not match '@'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250221213837.1594057-1-naresh.solanki@9elements.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


