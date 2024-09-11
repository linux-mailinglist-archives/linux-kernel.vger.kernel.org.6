Return-Path: <linux-kernel+bounces-325257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E073975701
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A36B28AE23
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB24C1ABECE;
	Wed, 11 Sep 2024 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGrDlH6X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7F41AAE24;
	Wed, 11 Sep 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068380; cv=none; b=Q3VtYKNTOxJyuMOqtAK2DKgc+Adp3KoOALb8Mi0lxBJZ7+0nsVQ+8RXSmdN/KkZkHQpGMMbKBHgGBpE9bSmDo3IbbMRR9r+Ir4JJXSb/Z76eIs4rW7yBfeNnm7i+ap85Z1VpwtpfYtbLULz3IQDTq1KahZC0JsjNMhNf3VaGg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068380; c=relaxed/simple;
	bh=sfAd1RJm9xWGep7rzAdDYP5SkbbDYA93DYShCFEOqsc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=bn5Sqt/oRqccExBmczIFFWI/5kQdl8rZD4WZZp0k8Togu+gXzNnsrbvVJhLFe4tbDXkEEelTa52RLrSo973VvkCqGSV0TBk4H46Sj466MeROeoSmS3SNGreXLNvwJeycS/ihqgcJIXDXW/UfimLTGPzrZ3GExcucr/0rPFJcNmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGrDlH6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D887C4CEC0;
	Wed, 11 Sep 2024 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726068379;
	bh=sfAd1RJm9xWGep7rzAdDYP5SkbbDYA93DYShCFEOqsc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iGrDlH6XYuTyIqfvLgKyE3MMbL2FLiXoPJl51itJ/Pel+ywK9KLRiMCEXpubgtJTZ
	 BOGI5yM+xWOnLvsUrPZ2Sh7H9jY5HMPbBxOdzc7pbJ23Gp2Zj7WTvfCsgLMYoGEhx3
	 hUNRP1DXj/DQ9LrdhnNk4A7XrxBtQUsFFlS1NUUyjhWYi9XYdgU5HN7ZaXveM+ux/U
	 2oqtB5WRHJJYnSedLO2NYXu/ReZlo47zq6UJPJPpPCVCdnI/PjUThUWLQCNSX51QVr
	 KdhkYXu4/DPbpDtRW/hmaF+t1n17MMLExwsDesvW/n7P6nincMEG0AS/X6CLEbyvCp
	 5ihwlFv/uP4DQ==
Date: Wed, 11 Sep 2024 10:26:18 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, 
 Derek Kiernan <derek.kiernan@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
 Alice Ryhl <aliceryhl@google.com>, Benno Lossin <benno.lossin@proton.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 robertcnelson@beagleboard.org, d-gole@ti.com, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 jkridner@beagleboard.org, Tero Kristo <kristo@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Miguel Ojeda <ojeda@kernel.org>, 
 rust-for-linux@vger.kernel.org, Gary Guo <gary@garyguo.net>, 
 fabien.parent@linaro.org, Dragan Cvetic <dragan.cvetic@amd.com>, 
 Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
 lorforlinux@beagleboard.org, Boqun Feng <boqun.feng@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240911-mikrobus-dt-v1-2-3ded4dc879e7@beagleboard.org>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-2-3ded4dc879e7@beagleboard.org>
Message-Id: <172606837860.404675.7012990684888155394.robh@kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: connector: Add MikorBUS connector


On Wed, 11 Sep 2024 19:57:19 +0530, Ayush Singh wrote:
> Add DT bindings for mikroBUS interface. MikroBUS [0] is an open standard
> developed by MikroElektronika for connecting add-on boards to
> microcontrollers or microprocessors.
> 
> MikroBUS connector node will optionally act as nexus nodes for routing
> GPIOs and PWM.
> 
> For GPIOs, the following pin numbering should be followed:
> 
>   0: PWM
>   1: INT
>   2: RX
>   3: TX
>   4: SCL
>   5: SDA
>   6: MOSI
>   7: MISO
>   8: SCK
>   9: CS
>   10: RST
>   11: AN
> 
> For PWM, the PWM pin should be on channel 0.
> 
> I am not quite sure how to deal with the nexus node properties
> (#gpio-cells, gpio-map, gpio-map-mask, gpio-map-pass-thru) since they
> seem to conflict with upstream gpio schema (gpio-controller is a
> dependency of #gpio-cells).
> 
> [0]: https://www.mikroe.com/
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  .../bindings/connector/mikrobus-connector.yaml     | 40 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 +++
>  2 files changed, 45 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/connector/mikrobus-connector.example.dtb: mikrobus-connector0: 'gpio-controller' is a dependency of '#gpio-cells'
	from schema $id: http://devicetree.org/schemas/gpio/gpio.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240911-mikrobus-dt-v1-2-3ded4dc879e7@beagleboard.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


