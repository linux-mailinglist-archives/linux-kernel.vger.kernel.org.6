Return-Path: <linux-kernel+bounces-549854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B18BA557E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61CB7A3973
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B7C204080;
	Thu,  6 Mar 2025 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KISjB8Ls"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D21A2388;
	Thu,  6 Mar 2025 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294516; cv=none; b=Qf5Rp975zjZEcLb2Q6Dgp3hM/j1+i97fzEWpouL6xmWwtQtAy8Uil0aqV+a5TZHPAu/0q0NyU2sxO6ZGiib6SyznRDpVpksZxqXSSi3wHW3W2BYpJ5JAg64Wqv8RYF83ayncn5ds53MZnmkj+wPrYJtZ2NjpLTzxcwSGkqdnI/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294516; c=relaxed/simple;
	bh=NBkQDk9tCiWWODrBi0/mEt8JJqp9N1T5ZIn3Q1otpqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPR2JODxtDluGji3rGrF8kRYaxOoYBVZveDMsZyau1VcztpLu1DGkJedmHTBjNw79sype9XdrzB+AwSbek5ka/0+Ru/XXIvJpKdNuzG7sSya+PivHDsJGYfSIJAy+kJ5Zq85mD/RavgAXGNh/Vqerfh2qSW5drmSKhjYKSEwXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KISjB8Ls; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97BCB43201;
	Thu,  6 Mar 2025 20:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741294506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5aJhBiQDFvCwYftHFCwv+tUCyIrz3hX4zlIz1yyReJI=;
	b=KISjB8LsvVdhyCgdKws94SLNy9wP1zUpkit8wyQgt9VeAPxI4b+rDqNmK60CF2Aj56fsWA
	co9CIH9zbWF0MVis9zQgUikrRXqi1ZsNE3szZ+nLkxcWzEzk2B2JcMFQZK6bg8COSMjo0W
	N4pp6VzQTF3K1Nj0FaSEA9ThCkntYjtAnMezNjloixU0DzwAXORSfi7vF7HylG6BWmRpA1
	dVwS2UhyQOKjWQslLE01F+nap1NOj7JX/pSP+VQXzNl/xOwR/Wh9uGm4AhXIf5eQSdpXS1
	v4TOLvexF5cEu/8kbZLoe/upfMfnqziSgbLGPFckUWLmTN/Va0wDiyV/Jyp+Bw==
Date: Thu, 6 Mar 2025 21:55:02 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
	Michal Simek <michal.simek@amd.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:I3C SUBSYSTEM" <linux-i3c@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: i3c: dw: Add power-domains
Message-ID: <174129444615.1163689.13836504837262083923.b4-ty@bootlin.com>
References: <fb8adcd318b1023ca6b90d294e46ae3b59dc1280.1740490666.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8adcd318b1023ca6b90d294e46ae3b59dc1280.1740490666.git.michal.simek@amd.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieejfefhffekjeeuheevueevjedvleevjeetudffheeutdffudefjeduffeuvddtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepjeejrdduhedtrddvgeeirddvudehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepjeejrdduhedtrddvgeeirddvudehpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhonhhsthhrsehmohhnshhtrhdrvghupdhrtghpthhtohepghhithesgihilhhinhigrdgtohhmpdhrtghpthhtohepmhhitghhrghlrdhsihhmvghksegrmhgur
 dgtohhmpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 25 Feb 2025 14:37:48 +0100, Michal Simek wrote:
> Describe optional power-domains property.
> 
> 

Applied, thanks!

[1/1] dt-bindings: i3c: dw: Add power-domains
      https://git.kernel.org/abelloni/c/59f994e6e332

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

