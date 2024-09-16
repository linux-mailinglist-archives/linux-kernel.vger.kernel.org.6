Return-Path: <linux-kernel+bounces-330976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41BB97A6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD63F281308
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316715B10C;
	Mon, 16 Sep 2024 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad4X7v/v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1C143C63;
	Mon, 16 Sep 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507393; cv=none; b=AY0XSVmlopzEO7Ee/EHUuYnZeEgbXg6vluxdG61zEwqZn4LaHjsdxzpCiDQ/PRfh8ky1l1BP1zo1duS6RHYEATMjILH9GGnvCTmbJvvLuwLDPW9Kje/yDeqy7IknzzxX7AcbHXl87GFxGvRrJmabm7uROK8SOELpOUuzo0X27o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507393; c=relaxed/simple;
	bh=nBMpe9G5hX+7mnkTEs+rD8NKlNfpBVsk7V90+43erik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8Pii/O4CEaB2mxbOHpy4AZq86chcCB1Pn4NWE+joemGmbZerWl19W4/s3B/o9EIDHrn/+dh715ivG96AdL6OkcIpP1xa3KS6p+7+RmP+GEYaQaklLsqclZLrNGFIksT+9gzZziEmB/89t9pQ6BxYDmqIgdwMd1Nlbi9tGkVLLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad4X7v/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D086AC4CEC4;
	Mon, 16 Sep 2024 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726507393;
	bh=nBMpe9G5hX+7mnkTEs+rD8NKlNfpBVsk7V90+43erik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ad4X7v/v7VOIVBO5YYXnJF6fy7P7yN6RTL+277um3XnwWhj9KpGXfHuDCZJUWlw1G
	 4YWGavyLmyw6nMohxL6DbeB5LlsCweNA2Xe7R1TWx8mx739Z3Y375FTkL4TEWZE/pV
	 C2TY0sqoINVoBIyQ55c5wt/SbTAfPqcR5nuJk/fWFW5NoaFexcHEJScsrQlrMqp8rP
	 dhCr/jqrKmOtdOPQfSqVbd4OvdQHAXUEBXQFyaJ5oTD19vLE/LzwNHuyi3SBUuvfXF
	 08TGx2pAB0r61UPwg3qD9bsa37VkiZ1rQRed0aN4cA9NT98NCdNLna0zBTIzqWFnOS
	 f3xVO8HlQVdww==
Date: Mon, 16 Sep 2024 12:23:11 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] dt-bindings: clock: convert amlogic,meson8b-clkc.txt to
 dtschema
Message-ID: <172650738929.834858.9318382302373477607.robh@kernel.org>
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson8-clkc-v1-1-e0b8623c090d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson8-clkc-v1-1-e0b8623c090d@linaro.org>


On Wed, 11 Sep 2024 17:09:06 +0200, Neil Armstrong wrote:
> Convert the Amlogic Meson8, Meson8b and Meson8m2 Clock and
> Reset Controller to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/clock/amlogic,meson8-clkc.yaml        | 45 +++++++++++++++++++
>  .../bindings/clock/amlogic,meson8b-clkc.txt        | 51 ----------------------
>  2 files changed, 45 insertions(+), 51 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


