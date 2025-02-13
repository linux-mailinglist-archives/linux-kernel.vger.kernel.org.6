Return-Path: <linux-kernel+bounces-512524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00047A33A76
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0FB3A986B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDDA20C481;
	Thu, 13 Feb 2025 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItxKbILe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3995835944;
	Thu, 13 Feb 2025 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437110; cv=none; b=swOZQtmnVfmwAr5FD2sRcsz5mvNJWb/LsML+fXBzuUovVXRAo6aHRP5c8OU4O9hR3hglWO0tEZMoczN1nymA0eq1pBqL9FXZfXGI2piUyFEpeGxOlHJg9XtdK2aY9eY1p8H5g/LEida3xKSuz06tuIa6aEeaLoAeaLVy+LfPm8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437110; c=relaxed/simple;
	bh=YJu0nHS2qGx3nviRf9AY7LRO097uHNLwmCAGmqR5Ocs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLtc+sdaunCSbMiwXduf4MnpTa62KxXiNtMht1cAoPZhWsokCylX2dsiuFGPZz2XgyE4S+Dwi6jNjyBTajAd3l8gpWVGnG/0uUPkMsMDrkwT713pafT2ar9t2Si8vTcgN1+wzTG3j+bQ7gpNtLA0q7RVQbTyY0muiDsha7Ntjl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItxKbILe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2A9C4CED1;
	Thu, 13 Feb 2025 08:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739437110;
	bh=YJu0nHS2qGx3nviRf9AY7LRO097uHNLwmCAGmqR5Ocs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ItxKbILe/RICgn7IPSqQ4uB/f8uQfLSymwefI+hsygoydxGgM7M7VqPgGO0lb55Qr
	 gBRGFFYiFrXGRYMRnuaBfBGsox183p6iybfenqLyiuz5ppn6NOu8l/aZ98FNwrv/ZK
	 3cCTg5GmFAQmsqzbmRD3z7jFT+yBMMeBXrsa34y8G27JGJfwBC8a6OeErPGBF/KcaV
	 8j4IBUdNu9+yC4vkyKuUv8KOssjanuYy2DA2hJY12UDGp4M0NmJMC0r05LJrzJjbFG
	 qZ2rJWyB61AlMXI49zCXrBENjuAgnSDkfGHvuVeamwKajtajrT0vfdKzWCdv4CWGUR
	 1vDFAXAYH8Wtg==
Date: Thu, 13 Feb 2025 09:58:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: hwmon: gpio-fan: Add optional regulator
 support
Message-ID: <20250213-ludicrous-tarantula-of-priority-b09e5d@krzk-bin>
References: <20250210145934.761280-1-alexander.stein@ew.tq-group.com>
 <20250210145934.761280-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210145934.761280-2-alexander.stein@ew.tq-group.com>

On Mon, Feb 10, 2025 at 03:59:29PM +0100, Alexander Stein wrote:
> This adds an optional regulator support (e.g. switchable supply) to the

Add an...

> GPIO fan binding.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/hwmon/gpio-fan.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> index 7f30cfc873506..d5386990ab153 100644
> --- a/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> @@ -23,6 +23,9 @@ properties:
>    alarm-gpios:
>      maxItems: 1
>  
> +  fan-supply:
> +    description: Phandle to the regulator that provides power to the fan.

Look how fan-common.yaml writes it. It is really not necessary to say
that phandle is a phandle.

"Power supply for fan."

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


