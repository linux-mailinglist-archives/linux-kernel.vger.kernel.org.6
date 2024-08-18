Return-Path: <linux-kernel+bounces-291087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 138ED955D15
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437F21C20EF1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5298D1420D8;
	Sun, 18 Aug 2024 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg0r7r7C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1521CABF;
	Sun, 18 Aug 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723993679; cv=none; b=tFqC4M4FugBU68m7jU/QdxFWPXAnowyK+g2DzdZgLARE4koOQTY75L5OwrIZhqVvEkd6O4e1wJlFxfa1JLHDkg/jw3/6AdH0xsHJ8rOV86xFBunn6ziGSj3Ki4UVgGIe0CoEalHJNwwOt+zwVxv6DkiRYXFsjxo/mIs3bH6Xin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723993679; c=relaxed/simple;
	bh=C46N4m4z7zsS9XGctzhVTS5q4ELPLk7grJWi29nWOEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW0Mu1MfwUn09/hG9z1RgfYHKiAxJqbM4k4dUV6gcIdZN9Ru3UzoPQ3/8UaqWwrNmZ9yA6iqg9I7PkZ4Yo4MGggrOVx/QBDcIRo2jcR+D1LwTv4rzPMfNSRABDHryxnjbY/rw8nrjjFXZSYXtDih5DsglmDR4+S6iwIJeAed3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg0r7r7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04EBC32786;
	Sun, 18 Aug 2024 15:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723993679;
	bh=C46N4m4z7zsS9XGctzhVTS5q4ELPLk7grJWi29nWOEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wg0r7r7CU6mSiCccVB+Gtua6zbqbYLYrtWnL08yhnx2rUucSADhTM6eqnsEfbgPM6
	 mEf6Q2RV0HcOUw36jJhI9mkbsXhPQrw/NBEUElw65PBXYdVlsPq166mjxAI1RxpRUX
	 GoaqQA10Xo9LS1r6uv6Zj5yI7IRo/w6xI1AKwEE+CgQsWWP7175xLi8NCbaKyWOoIh
	 odQdJMszxeifF22xh8tjMPnBOeAzVZ5vnpW0zj6FRVppFJLKg04TpbbA2TEgWtoyVN
	 5dBI2hWroy1WbuLLDvkg0d7YzoXIju3YvvU03ZfmCCyrOq/XzS4jrSWt7AZ8dEs0ed
	 YOaJFjRSNqYWg==
Date: Sun, 18 Aug 2024 09:07:57 -0600
From: Rob Herring <robh@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] dt-bindings: bluetooth: bring the HW description closer
 to reality for wcn6855
Message-ID: <20240818150757.GA80633-robh@kernel.org>
References: <20240813190131.154889-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813190131.154889-1-brgl@bgdev.pl>

On Tue, Aug 13, 2024 at 09:01:31PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Describe the inputs from the PMU that the Bluetooth module on wcn6855
> consumes and drop the ones from the host.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Note: This breaks the current contract but the only two users of wcn6855
> upstream - sc8280xp based boards - will be updated in DTS patches sent
> separately.

This needs to be in the commit msg.

Otherwise,

Acked-by: Rob Herring (Arm) <robh@kernel.org>

> 
>  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml     | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> index 68c5ed111417..64a5c5004862 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> @@ -172,14 +172,14 @@ allOf:
>                - qcom,wcn6855-bt
>      then:
>        required:
> -        - enable-gpios
> -        - swctrl-gpios
> -        - vddio-supply
> -        - vddbtcxmx-supply
>          - vddrfacmn-supply
> +        - vddaon-supply
> +        - vddwlcx-supply
> +        - vddwlmx-supply
> +        - vddbtcmx-supply
>          - vddrfa0p8-supply
>          - vddrfa1p2-supply
> -        - vddrfa1p7-supply
> +        - vddrfa1p8-supply
>    - if:
>        properties:
>          compatible:
> -- 
> 2.43.0
> 

