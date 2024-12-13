Return-Path: <linux-kernel+bounces-444034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B1D9EFFD3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8E91885BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8DB1DE89B;
	Thu, 12 Dec 2024 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chaosfield.at header.i=jakob.riepler@chaosfield.at header.b="g70W0U+Z"
Received: from sender2-op-o11.zoho.eu (mail360-sender21.zoho.eu [185.230.214.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1B1D63E0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.230.214.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044908; cv=pass; b=HXvqYW51ngXbsJSeUaYYSUps+Ck5mFCQz7GHEy/5+GAsq/Dj/lwrgkpHSntAlv/8CEhWQ557P1ixmBltvxmWZgf9Tl727YM7AqdOW8lz8mhPEOd0iPQAiGkfVAjEH2Oh2VPZQZAfOZpek1jA7dicWF2DZidJ60HpmGZz9RIAL4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044908; c=relaxed/simple;
	bh=fOeJ+VId+r8rs1PtzHqzP6oBzIM1aJl9uxiUAGon0r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXFgCPwVARuQ/O6Zn4Kf7rT0BXv5Rtb+rxCeffGVMv+9P4QyQ3A/S4bNjA56qXE3tF6KXkG6bmOKC06UujnKkhfx6BuxNw5z0Hs+eIKT7pPcrROwQDQYedNOckAYg0MKVBI1FLvWdRTNyZlNDdAq4pSejvp/3QPYPncJuwmAcTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chaosfield.at; spf=pass smtp.mailfrom=chaosfield.at; dkim=pass (1024-bit key) header.d=chaosfield.at header.i=jakob.riepler@chaosfield.at header.b=g70W0U+Z; arc=pass smtp.client-ip=185.230.214.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chaosfield.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosfield.at
ARC-Seal: i=1; a=rsa-sha256; t=1734044871; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=buPMkNkGUYplLP41rFnWGvqef7N83S4oqdORtvZTKaUgEDAqtQe/6nmRLe8Dmmee+llVnJ7+CqnztLe6k4a9/QhjKmpN/MT/w+YdrqHskhbE7/Q2FCRjF6227/pcgXaSLd8BcWbbx1L7rL1Bgfr5+Hyl/2Q4sm8sutsYzgc0ln8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1734044871; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Qss3BnfSWtjL5lPZ7nnPFbAgulpX61J2zjVH612BlJk=; 
	b=O88HzqYhAKQN9+Uv+SdEnNaYnghoE5W3Jt2lt5VQn031p5t+Hn2ng8HKj7z9FcjUrV7lBBNZCrmjLmeYYuxaEKBFXLpHluuiCntdAdyjrzrhEGyg2JHCdmDEpi/Qf27yS2VXikXeGJjGNecYRECSyWs4ZwMz0GOhWlKOz2zDvuc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=chaosfield.at;
	spf=pass  smtp.mailfrom=jakob.riepler@chaosfield.at;
	dmarc=pass header.from=<jakob.riepler@chaosfield.at>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734044871;
	s=zohoeu1; d=chaosfield.at; i=jakob.riepler@chaosfield.at;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Qss3BnfSWtjL5lPZ7nnPFbAgulpX61J2zjVH612BlJk=;
	b=g70W0U+Z1hhCo9nLEV78f5PdvbqqRU5RnrU4xFJ3oeIZGSWKkl4JBkeYQcO/TzRq
	7r43aA63wAE5s/UalLY5qQ4lEnw/asJKaOVUDOQ7l8QYv9VIhrfAJ5uuqOs27PAXoRb
	b/r2PI1vsj/J8fNpwADkUEKBRwBURKB/6MYg36H4=
Received: by mx.zoho.eu with SMTPS id 1734044868365346.6246386230723;
	Fri, 13 Dec 2024 00:07:48 +0100 (CET)
Message-ID: <d021d011-d5d4-4692-973a-f5a45be8db94@chaosfield.at>
Date: Fri, 13 Dec 2024 00:07:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] leds: pwm-multicolor: Disable PWM when going to
 suspend
To: Lee Jones <lee@kernel.org>, Jakob Riepler <jakob+lkml@chaosfield.at>
Cc: Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <d7d930bc-4c82-4272-b2c6-88f7cac5a3e1@chaosfield.at>
 <50bbd767-b0e0-4788-975b-f5d9598208e5@chaosfield.at>
 <20241212174356.GJ7139@google.com>
Content-Language: de-DE, en-GB-large
From: Jakob Riepler <jakob.riepler@chaosfield.at>
In-Reply-To: <20241212174356.GJ7139@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

> I get a warning that this patch is corrupt as well.
> 
> How are you creating them?

`git format-patch` and thunderbird with the settings mentioned in the 
kernel documentation.

> Please use `git format-patch`, `git send-email` or `b4`.

If you'd like I can resend with a different mail server - I had trouble 
setting up `git send-email` with my primary mail provider (enforced oauth)

- Jakob

