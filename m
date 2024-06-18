Return-Path: <linux-kernel+bounces-219803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6359290D7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E993528142F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2250D757FC;
	Tue, 18 Jun 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liKcmHch"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E074595D;
	Tue, 18 Jun 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726014; cv=none; b=MkE6lEQlQMroi1xpaLi7nKm2GSviNcqrYHWgU5dylmyQlgTNBRIUszijsmtmNRiYxr/tMGa+KmUE55wUFAXRDTaTa5GJYTQoLs3JpZ+wz3Zsb+IHljPo1OP5oGkXDhzb2oV3/tTpSeKbbHq6gVKiC1hW6oxJhavGXifynfs6ojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726014; c=relaxed/simple;
	bh=8j9kZpWYFKPJ17/JFfrQ8rAerVTi3N6sqkeVogOAF5Y=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=WG9nbaMh/V0RsPd9W6p/yAVNG1vceI5TQ/qP3juyq5QeQmgMf9J1MyBGqVCwKz89zusDTvr9hGTQbPFNXytzGFL/Q+fu220WNkT7IbaaJsfFtsLR0MTySOqp15CZK6DQDCDQ1A3yW/fNUWBsEoQXQsDPrZoGfGkndvJ+0KoRJlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liKcmHch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A25CC3277B;
	Tue, 18 Jun 2024 15:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718726014;
	bh=8j9kZpWYFKPJ17/JFfrQ8rAerVTi3N6sqkeVogOAF5Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=liKcmHchZywAUJiiUirezQREET7vPhK/wCFZlVIDs7jnonsq3Kh17hLXJw825F4UP
	 NtGShLSrljqguoliTg9Qdseg9Nm+yyru3mLT8HRfDfrdGyghRK7u42TBtv93Hj+/oE
	 FL+7xS3Wmd6vMJlo3iDLKOXFkKDRtYBgnkSClVh6vkKNqkXXpj44H4rn7GNBuw2FEi
	 fZwrVy/2K/3Rks1gcw1oCjOy1FY12CHsN/qVdu899FUyX+O+9fw4MHhMAcdm7rjI3d
	 2mB+QsoBcAi9EK1M71M7mNDk/8K2PCH4KDTCvVqrKrecmwRtxkjk6rZAHdz8zaf6fY
	 f1ds39dCJ9gAQ==
Date: Tue, 18 Jun 2024 09:53:33 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, jstephan@baylibre.com, 
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 dlechner@baylibre.com, Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Michael Hennerich <Michael.Hennerich@analog.com>
In-Reply-To: <20240618-cleanup-ad7606-v1-5-f1854d5c779d@baylibre.com>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
 <20240618-cleanup-ad7606-v1-5-f1854d5c779d@baylibre.com>
Message-Id: <171872601308.2592859.9209680647249959738.robh@kernel.org>
Subject: Re: [PATCH 5/9] dt-bindings: iio: adc: adi,ad7606: add conditions


On Tue, 18 Jun 2024 14:02:37 +0000, Guillaume Stols wrote:
> Since the driver supports several parts that present differences in
> their layout and behaviour, it is necessary to describe the differences
> from one chip to another.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 50 +++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7606.example.dtb: adc@0: adi,sw-mode: False schema does not allow True
	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240618-cleanup-ad7606-v1-5-f1854d5c779d@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


