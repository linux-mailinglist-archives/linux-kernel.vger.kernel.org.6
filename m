Return-Path: <linux-kernel+bounces-235762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AD591D959
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D38F1C216A2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C1E78C63;
	Mon,  1 Jul 2024 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nOwrn1G/"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62716C144;
	Mon,  1 Jul 2024 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820054; cv=none; b=LU9SfX34soFNaco4kZ6ccFqLtz0IRmwGFeevTpQMLyjcYfHgp2cMFWOYiXC6vY+FCtYMClFZmVXeSrJ+6SKkAUH33DQHdlh/1Dl8tTLJsI/Q9aH++oug68Sj+9QkmByTW4/BBd8cGMwfxVJdWJzTNyLf8s/AjEkb+nokJk5T1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820054; c=relaxed/simple;
	bh=62EtLx2rOQcXg46lhp8cb5zB/P0swEUokGwSyGI8wpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEuABL052L1RWgh/ItWep7hkE6oRFsSBbjZZp6Hmp03XrNwb2yK+OzSgYXtwuMLUUu8G2sGFAjk4b4VTp9PeNY7+L0678hiBEZbZAzg9JSINcKPCvJP5/s13MhSvd6F6rTobFYNee7JlXBRNts9hHXh/J5fqohrPjNXCOBoD0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nOwrn1G/; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDF99C0009;
	Mon,  1 Jul 2024 07:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719820043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSzCTTdVM/tcdktgKnj2I7uwAMajiojP6tk7tkVB+GU=;
	b=nOwrn1G/VVmjuD7GQhpAhtIOYD4Tk851VLzUI1ZTims5TqG4tZlpA7uSctgxtqbkI2K0Xj
	Nt7nlclZz9+hXabDud4SgSZrf1t0kwzdWf+0Of1xY8LXrf7cx4G4A3+uzneL3wK2ZwZS/z
	G6fOkCA5hspB4XuvatPoJSSf6RUlWv7PbcrhNxpDANZ2+l4lbXcGIPOkOiBOypxLqIANp+
	cR4r9RisDQab29H9k/zdkGFuwjlX9I6h4JU2gyDKM4IEyogbotiWf9VaNa0YGXMfuxBkSa
	zlt0sXdai9zB1+kvOGYnBomUFCe57yzDpOCXQ2X0hYLWj6dslwC+Nj9kHyH5pg==
Date: Mon, 1 Jul 2024 09:47:19 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 10/10] ASoC: fsl: fsl_qmc_audio: Add support for
 non-interleaved mode.
Message-ID: <20240701094719.14f2eda3@bootlin.com>
In-Reply-To: <20240620084300.397853-11-herve.codina@bootlin.com>
References: <20240620084300.397853-1-herve.codina@bootlin.com>
	<20240620084300.397853-11-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

On Thu, 20 Jun 2024 10:42:57 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

...
> +static bool qmc_audio_access_is_interleaved(snd_pcm_access_t access)
> +{
> +	switch (access) {
> +	case SNDRV_PCM_ACCESS_MMAP_INTERLEAVED:
> +	case SNDRV_PCM_ACCESS_RW_INTERLEAVED:
> +		return true;
> +	default:
> +		return false;
> +	}
> +};
> +

The ';' at the end of the function should not be here and will be removed
in the next iteration.
Also, this function will be changed to
--- 8< ---
static bool qmc_audio_access_is_interleaved(snd_pcm_access_t access)
{
	switch (access) {
	case SNDRV_PCM_ACCESS_MMAP_INTERLEAVED:
	case SNDRV_PCM_ACCESS_RW_INTERLEAVED:
		return true;
	default:
		break;
	}
	return false;
}
--- 8< ---

Hervé

