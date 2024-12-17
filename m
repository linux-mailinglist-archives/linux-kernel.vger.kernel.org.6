Return-Path: <linux-kernel+bounces-449095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDAC9F49BC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAFD188B12C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649EB1EC00F;
	Tue, 17 Dec 2024 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pv81gis4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5EE23DE;
	Tue, 17 Dec 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434487; cv=none; b=cuRRDU2Gll6e3aSJs+yjTwPlLYpAWeTJeSzWNOXJYuLatVjUUqRe928NXkIvft1dQSUSOGS64c0z6sL17psPzb07a6gewdMHZeHZb0w0XjeIpwQnRFDUlgyoBeAf2X3kdU2RZ3YPGUPXs46eC3DbqWyx1hDdnSKZVUyADze653Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434487; c=relaxed/simple;
	bh=s5vK3vqWBeHhLp5xzRCQJldT103A0i54JjSN+MTyT8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHw1SWDuwiNECtTTTxrKEYwgi8UcI+1QreWbd2UnxSLOiotnFMeL6/kYduf2aCBaqW79k6gN8ufs6x7D2Nh9x4szOvkK3dHzUfcMuZT+RdZ6AJ/8kzvXj0BHiKPFsBTYFUoU3FEhEzdK15se3NRcZDdhTRXRWLYw/FPEEMFhTto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pv81gis4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10141C4CED3;
	Tue, 17 Dec 2024 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734434487;
	bh=s5vK3vqWBeHhLp5xzRCQJldT103A0i54JjSN+MTyT8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pv81gis4dLGqoebSqNaB4sZFJMizri+86Nhpo1NOkUH1rzZP+VH9DNfuA11C6b8iD
	 /dEHMm76FjxT05+pB24/5rDtmrSeMHMUKczet63l3PnRqTBv+xkU2L78XzlC+8bDeF
	 xvhqx3BXzlhTB7yNMXPsscARuB4IbdoZflcTDIu7+dUaORt8ZNcBD73GOgnUUaTqIj
	 pci1GPVySE+mDm0JdiViVKnSOvKIg18YdJ6NTtsdL4JioODFoRNfv1Vj7ei7humRmG
	 xD8tJAaw5mVIIarlskCmtr/HD8XTDXTzCAN/GBBPuejOh7v3Gy24gHvlqxGVW8WVtn
	 okjOkklEn4efQ==
Date: Tue, 17 Dec 2024 05:21:25 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Scott Branden <sbranden@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] dt-bindings: power: Convert raspberrypi,bcm2835-power
 to Dt schema
Message-ID: <173443448203.859628.7169765786016335364.robh@kernel.org>
References: <20241216-raspberrypi-bcm2835-power-v5-1-222fc244132b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216-raspberrypi-bcm2835-power-v5-1-222fc244132b@gmail.com>


On Mon, 16 Dec 2024 17:07:00 +0000, Karan Sanghavi wrote:
> Convert the raspberrypi,bcm2835-power binding to Dt schema
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
> Changes in v5:
> - Added maintainers for the power domain
> - Link to v4: https://lore.kernel.org/r/20241028-raspberrypi-bcm2835-power-v4-1-acf44abd45ff@gmail.com
> 
> Changes in v4:
> - Corrected misindentations and random differences.
> - Link to v3: https://lore.kernel.org/r/20241026-raspberrypi-bcm2835-power-v3-1-6621e075d33f@gmail.com
> 
> Changes in v3:
> - Applied changes as per the feedback received for title and description
> - Removed power label and renamed node to power-controller
> - Moved the file from bindings/soc/bcm to bindings/power
> - Link to v2: https://lore.kernel.org/r/20241022-raspberrypi-bcm2835-power-v2-1-1a4a8a8a5737@gmail.com
> 
> Changes in v2:
> - Added original file maintainers
> - Removed unnecessary headers from example and formating from description
> - Link to v1: https://lore.kernel.org/r/20241019-raspberrypi-bcm2835-power-v1-1-75e924dc3745@gmail.com
> ---
>  .../bindings/power/raspberrypi,bcm2835-power.yaml  | 42 +++++++++++++++++++
>  .../bindings/soc/bcm/raspberrypi,bcm2835-power.txt | 47 ----------------------
>  2 files changed, 42 insertions(+), 47 deletions(-)
> 

Applied, thanks!


