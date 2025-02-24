Return-Path: <linux-kernel+bounces-529183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E8DA420D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1798A167640
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743F248869;
	Mon, 24 Feb 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bkRLBWZS"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063E92571B8;
	Mon, 24 Feb 2025 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404024; cv=none; b=DR5O5S/9blL8rBpekKkZ/GPrbUk9F475GRbLn6DksjxITrMU6Gv+LeOuUFOuA4vmzrZl/2P/MDyqtV0N1KIaFRNmpy9TEVXYWgn8LScnWfQ7WaqPgHDW/kkcoiqS1y/ngAZmy21VrUp4LUnA/qiR3YR6q0mEeHZpe5ilznNTYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404024; c=relaxed/simple;
	bh=XqzTQYDdjRp+kJRIiPtsJDmCZ/ltriwS9uE21T5YcRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbXFx0Xkp8yc5eR+IJv2a+lqceCdPAFksSS/0HbyOlqCk3LpvoZuoUDSdysSEZ/u/aCA/2ZfQXM2ehRNcTRLDGJRSBTyQeu7t/gTrt6UUfvd5RfWh8jnBmQR1awgiBX6ZcdIoP5CGrPFMytL6SNQw+k+pKaI2d+SvO+GzjmrSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bkRLBWZS; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5874E432EB;
	Mon, 24 Feb 2025 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740404018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIagspXsyAvHsd8swjUvOQxymK0QzUmAeQhYVXlxXmw=;
	b=bkRLBWZSZYwEnqDK+klu7rd0l1E+6IiG/EYUYbESdAfhkj4M9ALlTJHtr+pVyFDLerKsE/
	T1hopPA/Z0C32ITyH4ZsnAWWStf9Bpeyx2lXc+mvhad48M4ewoWgz7gZI2oG6TgsE3k+Sd
	98JOcpeli4mW61IPIk8R4h+AvcFEzVKQbtp9S4hp4l0qvqhNsJm8VXZMqdGi0vfnTE4XSg
	Nh9cOR7gZ/e0+9Rgw6KF05mjQv4hBr1iclFE18TVDRfwt+b6CCmKgMajR5bofvM6vNmcss
	My0CYfv4Gl0NhQFesREjV+1ixiwIf0wkPDsC0oIAeGSmrd9hEKAWWwYConETxA==
Date: Mon, 24 Feb 2025 14:33:36 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl: fsl_qmc_audio: Remove unnecessary bool
 conversions
Message-ID: <20250224143336.75fe1e10@bootlin.com>
In-Reply-To: <20250223202741.1916-2-thorsten.blum@linux.dev>
References: <20250223202741.1916-2-thorsten.blum@linux.dev>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepthhhohhrshhtvghnrdgslhhumheslhhinhhugidruggvvhdprhgtphhtthhopehshhgvnhhgjhhiuhdrfigrnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepighiuhgsohdrnfgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehnihgtohhlvghothhsuhhkrgesghhmrghilhdrtghomhdprhgtphhtthhop
 ehlghhirhgufihoohgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvrhgvgiesphgvrhgvgidrtgii
X-GND-Sasl: herve.codina@bootlin.com

On Sun, 23 Feb 2025 21:27:41 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Remove unnecessary bool conversions and simplify the code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  sound/soc/fsl/fsl_qmc_audio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
> index e257b8adafe0..b2979290c973 100644
> --- a/sound/soc/fsl/fsl_qmc_audio.c
> +++ b/sound/soc/fsl/fsl_qmc_audio.c

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

