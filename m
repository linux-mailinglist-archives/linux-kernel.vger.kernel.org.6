Return-Path: <linux-kernel+bounces-265523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3A993F261
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D041C21AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DECD142E67;
	Mon, 29 Jul 2024 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZkGz5I0K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rg1u5OqV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776A25F873
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248218; cv=none; b=J998EhebFZ/v2PEX7EpH0fSY4omEnUmhHiOG7+UPTOrQoWuXDzq4fTFh9tpaofCS6KTndg70Bb6ydG7nrIrxmY1p7SlyyG2AkwmLHCYE9hc42Vp+otlVx2gvGQBMoGh46+l+/R9mIbf+nwSaKsvhRywuqXd77OwJRqXwkOcRm/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248218; c=relaxed/simple;
	bh=D+cmHL6psmu93hkwlKYxF8HmceliGKHfIxyfDEiB/Zw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oul+51D+hkD30YUgrM5zq/zq2QlnoK97T1Z89BeZTRbwI3/ufKKJbExUVnEB42bL0jJK8ovtaS+HO3/ROWhIhMRJD4C8opNWs8m5chrkz9nb00fT1Ci8Yn0sb/BCyR4/74eZ6wcPs/BBWrIhwd47qLVCDzCHdhDl7n96PmfGlg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZkGz5I0K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rg1u5OqV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722248215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kYbgH/y1QYwwxFLyoP85RzM2wLlKZ8GrLW/TPRIdkUI=;
	b=ZkGz5I0K7sRG/pt3/HSDW6/Gk1yo3vwZAftPzhSyt//wXGpaj+J0fFcKLRQ3nGOkX2hIo8
	p+mzvqWSUTqbrqqVzhWhN7xhb40XBGSx63F+I7K2L3vE8zbjsLy/Yu4ZjTXzpyTzkP+mFi
	myCcSGPQl9GMjnAk9RjlsO7O5uKhbBFvZ1ban6ZjdKGJaRSbfOvUnaqnjusmi49EO9WHFH
	P4aZBtdbYLALUIh0FkDO96BTFgXxXIqGUh3HP95LkKGn8cPsmUDARGd6cjJ+BuZ8gkt9S9
	eEqX/iMj08XEmhOQqNn/nAcS7SpUTJ9B+AobJgjgDsXq/31vV7vZtIChTnRGEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722248215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kYbgH/y1QYwwxFLyoP85RzM2wLlKZ8GrLW/TPRIdkUI=;
	b=rg1u5OqVOKT1jKAZC7NGEMJUDY+hkjxX92d/m8y7Jebe3icmC/bLfGOFwwCYDuRrRU/iFm
	6TjB7qYxaQ8N7/BQ==
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: varshini.rajendran@microchip.com, Hari Prasath
 <Hari.PrasathGE@microchip.com>
Subject: Re: [PATCH v6 17/27] irqchip/atmel-aic5: Add support for sam9x7 aic
In-Reply-To: <20240729070829.1991064-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
 <20240729070829.1991064-1-varshini.rajendran@microchip.com>
Date: Mon, 29 Jul 2024 12:16:55 +0200
Message-ID: <87o76g8puw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 29 2024 at 12:38, Varshini Rajendran wrote:
> +
> +#define NR_SAM9X7_IRQS		70
> +
> +static int __init sam9x7_aic5_of_init(struct device_node *node,
> +				      struct device_node *parent)

Please get rid of the pointless line break.

Thanks,

        tglx

