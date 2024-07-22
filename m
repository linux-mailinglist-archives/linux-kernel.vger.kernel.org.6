Return-Path: <linux-kernel+bounces-259295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698429393AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26552280CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC3170853;
	Mon, 22 Jul 2024 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2WNLCWN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1FC770E6;
	Mon, 22 Jul 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673686; cv=none; b=K522epVRfF0xUcpXlMIF5ID0TelWbYRr9ihIGa3sk9/eqNLGZZtY8lm5MMkzxaxuPfJR5CPObN/KzKdbDYlhbkBzGu/+6+FOQY2EmGxrgrgNpW6cz8sjI91jE0EE1NBfPSkuANJzsaDwcbr5PlaoUUhbWq8fiZAXC45irc4n/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673686; c=relaxed/simple;
	bh=h5mbJ7t5ivHy/PWadTFK/BJ4etiqberYVgGf9dR3IOE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ZWWSXckQpcNdUwZMSHRW5sTnCaCymDSGnf2+doj/hCCl3Re7gb+nn1w5bTGYWefz/oExv4BJm/XJm+28PdYSAggdlZ7HYGASisGmcxZjUXN6IpJwrwpAwKlEfV2CHsz+obYpoMAXlAM3NcBvyvroE5ssmA4Fl3mTT3h/ZL1Xecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2WNLCWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA5AC116B1;
	Mon, 22 Jul 2024 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721673685;
	bh=h5mbJ7t5ivHy/PWadTFK/BJ4etiqberYVgGf9dR3IOE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=u2WNLCWN/RqaubhEldyvLueeykYUa1YGoieC9uZ0rDwiejU2PJPRWT+LweYXOQM+E
	 WQfQqpBPqlab4P5vgt5KUHh1e4MZHxNPryINHt6spjuM1a5Mv5RbzhBIfWPaoCimUk
	 /51mqUMFHDoVZTwISTTWLv93SU7zwDQ9GlKMb/dTtqfBebAFAzai+vRSM/r203Xa3x
	 C4XgnR1zoKJU/7/NKzvJqujQUBjUhnk1m8p8pHOatYh5Wm0ozRpBIzqQV/6VOt29Dv
	 AlkTNQVp7YWUVYzCmvZmzT91OC0a3YfwGp3yS5s6kttga9s8EyeZlZ3A5DlFesQGVP
	 0AJyc0e2730dw==
Date: Mon, 22 Jul 2024 12:41:21 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: ysionneau@kalrayinc.com
Cc: linux-kernel@vger.kernel.org, Jonathan Borne <jborne@kalrayinc.com>, 
 Conor Dooley <conor+dt@kernel.org>, Julian Vetter <jvetter@kalrayinc.com>, 
 devicetree@vger.kernel.org, Jules Maselbas <jmaselbas@zdiv.net>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240722094226.21602-5-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-5-ysionneau@kalrayinc.com>
Message-Id: <172167364005.4163.3691215563464644723.robh@kernel.org>
Subject: Re: [RFC PATCH v3 04/37] dt-bindings: Add binding for
 kalray,coolidge-apic-gic


On Mon, 22 Jul 2024 11:41:15 +0200, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> Add binding for Kalray Coolidge APIC GIC interrupt controller.
> 
> Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> 
> Notes:
> 
> V2 -> V3: Fixed bindings to adhere to dt-schema
> ---
>  .../kalray,coolidge-apic-gic.yaml             | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-gic.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-gic.example.dtb: interrupt-controller@a20000: reg: [[0, 10616832], [0, 73728]] is too long
	from schema $id: http://devicetree.org/schemas/interrupt-controller/kalray,coolidge-apic-gic.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240722094226.21602-5-ysionneau@kalrayinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


