Return-Path: <linux-kernel+bounces-291311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D139560BB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D049B21F81
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458041BC2F;
	Mon, 19 Aug 2024 01:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Q+VWMumz"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52841B960;
	Mon, 19 Aug 2024 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724029770; cv=none; b=YJPBx+ZQC0f0vl9dyZy6QugjOjlJ6/r0fcc+s8c3jkCjqtCm/r796t52burKUzyLRnucaqW5SKrFgVZUoRsFXNMHT9ivYmKhOSFjRrIjLAmHAUy+5b0lFAFviLBAmSawBBh7qcIaKjTc+jEAMF04qj0ovAevAPTqN6xu2UEh/jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724029770; c=relaxed/simple;
	bh=kzwT82yi8n1rnIzHNMQaH0H2G4LDrKB1GLHDWHib9Wc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JW3wrMGs4Qj22gFWFF8znQVzUoFFLVBO/uFOfe1ATmANN94Fw2x6LJYcIdUiiWZG2Hl9eNl4KCzAFFlWBWuiwkxPwyLfNzkJ4euS11DUSZJHABnHq/R9GR4tOh3ZM7kYJC23jYt5lTQRoKtUUo+Y3E/kPfsMJZIylFVSYnCKFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Q+VWMumz; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1724029767;
	bh=yz/+8B9GNOVhFnORnm/MLst64QryVyajcI2MoXzptos=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q+VWMumzjT3Nzwdjm0TlYIGyknFPM4eKf4kW9trjvLOIvRo895HR48Y7SEpoC85+r
	 pQ4r3ONfEMTNP2at0VN0Wc+KlREvrtGBRSy3NeGG1x/U9rd0kKHsbCOAtLaEIAaU32
	 9afugKe/ihfprMF1yhPS9VwtAIoTeSU7NWhPVD1EUrCGE2zw9HYvQR6o4y90+J8MLZ
	 ph29j2DmIds6O9iA979G18Cg9CpDwtvmLWqCjJ68TtP3HBnio0Xoyv9MRfu2xoct9W
	 7EL4nCseAtKFWqvobUtkqBK4DuSJMfallcvb0Zr8iK1MYnDgZvKtOTtnPDooIMaLSX
	 VoHjW09jzGxfg==
Received: from [192.168.68.112] (ppp118-210-94-119.adl-adc-lon-bras32.tpg.internode.on.net [118.210.94.119])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4837D64BE9;
	Mon, 19 Aug 2024 09:09:26 +0800 (AWST)
Message-ID: <0935f710c5d4e306f616bb2a35bd0d75dd9e84c8.camel@codeconstruct.com.au>
Subject: Re: [PATCH v12 00/28] Add i2c-mux and eeprom devices for Meta
 Yosemite 4
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Mon, 19 Aug 2024 10:39:25 +0930
In-Reply-To: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-16 at 17:23 +0800, Delphine CC Chiu wrote:
> Changelog:
>   - v12
>     - Fix GPIO linename typo and add missing GPIO pin initial state.

Please make sure to run `./scripts/checkpatch.pl` and `make dtbs_check`
over each patch in your series before sending it. Also, please respond
to review comments. Either acknowledge them and change your work, or
discuss the problems to get consensus on how the changes should
proceed.

Your patches will not be merged if you don't engage with the feedback
from the people reviewing them.

Finally, as it stands, the additions in the series amount to 75% of the
existing devicetree. I feel like it would be more effective to replace
it in a single patch or rename the existing devicetree out of the way,
and not try to maintain a 28-patch series. I assume all these changes
correspond to an iteration of the hardware design rather than some set
of incremental changes in their own right, in which case a new
devicetree seems appropriate.

Andrew

