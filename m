Return-Path: <linux-kernel+bounces-272472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D32945C8E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7B51C21E19
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0AE1DE872;
	Fri,  2 Aug 2024 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dlac/QV1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gJG8OpeN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C830114A603
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596104; cv=none; b=kwksegNDMkf/cFtR25Vd5eKeao4L0takkLSSdE9uz8uQjkEy+avc3r4z8Nvcp+zwkiEcRFlJYKx/0XsuuCevmLhQfnFJZI9B4gnTgEO26CcQdKYknt1351LpL7vP7Liv5/yxZQetjITijffSf4oitmGer5dshtX+a5BWGxZ+Ii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596104; c=relaxed/simple;
	bh=YiHh+VK8T7vBnkZpp/gm4r57RlPbLzHjSW1iJatnamQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C2apy3Azfl3VwTDsoeAZRjvVeD1+CIo0NLR+OvBSs6DTa8jq+dys/ifs/opfok61BxQk11QDQ+AfdbCVnn71OAb5agpwjIfl5DGDw4wF4my7BZ2ebbt2rQTdcc3l3IAZzQabt3rg9Pf28YduoK7+csyMfU11x+Vk93Gz2ErX7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dlac/QV1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gJG8OpeN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722596101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09bf5Wb9MBlcdoXBnx4GnW9Utu1dIVSOsIXiHFTFG9A=;
	b=dlac/QV1bSdgNqoHMEjazmthjGamUGl0Ees0CsmQS8kmrf8FVzMDa8ZiN9237Jn4gaiF7o
	LuAq2DpBsrh3BeBjAShopPw8NCTSlXB8wx1xuCOkunuCzWWIf0Rhd2Olw0817oVP2XkGHg
	CZZdb2tTniETMmXrOPykL/gRsJHqlwIeD5cp4lQJ1XH8Lakjw2+yqKa4cgDM6Y0A+DzuF4
	/VRqo0hJ79q1aFqDfM0dpq73ZP3iOXXXr6flpR+1HKliw4HSrbbJPCxwmdoCcYC/JHZNm5
	Et9EIQLEAFOwNYDCkcPE0HV3/I1FTWQVU0pTU4LP0xV6Cdmsb7a+sQo9pSjYrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722596101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09bf5Wb9MBlcdoXBnx4GnW9Utu1dIVSOsIXiHFTFG9A=;
	b=gJG8OpeN567ZTbVRv1LMD0vwF2KyonPLw0bAAXHLnF08Xvten74lDQ/UBiTkxEhXdX0OvV
	yZpmbKeK8N2cEHBw==
To: Vincent Chen <vincent.chen@sifive.com>, anup@brainfault.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 vincent.chen@sifive.com
Subject: Re: [PATCH] irqchip: let the probe of APLIC be earlier than IMSIC
In-Reply-To: <20240802075741.316968-1-vincent.chen@sifive.com>
References: <20240802075741.316968-1-vincent.chen@sifive.com>
Date: Fri, 02 Aug 2024 12:55:00 +0200
Message-ID: <87mslv19ff.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 02 2024 at 15:57, Vincent Chen wrote:
> When the debug message of driver/base/dd.c is enabled, the following
> error messages are present in the boot log:
>
> [    0.207941] platform d000000.aplic: error -EPROBE_DEFER: supplier
> 28000000.imsics not ready
> [    0.208115] platform d000000.aplic: Added to deferred list

Deferred probing is not an error.

> The reason for this error message is that the probe of APLIC is executed
> earlier than IMSIC. This error also causes all the platform devices
> connected to the APLIC to be added to the deferred list. Because both
> APLIC and IMSIC are registered by device_initcall, this patch adjusts the
> compile order of APLIC and IMSIC to ensure that the probe of IMSIC is
> executed earlier than the probe of APLIC.

And no we are not playing silly ordering games just to suppress a debug
output.

Thanks,

        tglx

