Return-Path: <linux-kernel+bounces-550598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBDBA561CF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C0E1884F69
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902F11A7AE3;
	Fri,  7 Mar 2025 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uzS+Bb3h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jvzlICJ+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B61A4E9E;
	Fri,  7 Mar 2025 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741332587; cv=none; b=jfrYKmUP39W9T4bw/MyPM7GEWwu7Tax0Jmy6RfndxYog9aaEhyvqGeWzVrP0vj74JG940vrcJqiWlNB2vCZRl9+qgrKxCnycGhUPigvUMtdMFGVehp7FodT6IJSWvCMQI5jPJ0EZGXzldKrpNBIG/uM9XW2Hbat2n4or5xXvgRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741332587; c=relaxed/simple;
	bh=6HGQLlWSoK+5RydpzDF3V5oysgqjMllADgJLZnvsSpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P64kGv1pkNZkMBn+2uDvS+AIh1XI+wMK7B7d3yw+0SsItT5e+7bdOGnBXfiHSEaG7XnAykqirKwrNV9tCOQrGZ00cHHgz28I3Up4QyV3oY51HesUPqIM1Jrknby/pXrsO6xLe+WH1qHv4s7whzpl1roxl9oKM0G18wMDGzXQzSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uzS+Bb3h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jvzlICJ+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741332583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/WWLpb5STJ4E9HKptpFyE8OtdVIxQ5Lh8Y5krflY3QY=;
	b=uzS+Bb3hnCqx/32zoV79G652YJU9dEJUZ907RdBaM988vMOm6cy1xFI5SG0b0PQccf+GOC
	7HnhHzQPyDXIsIJKkoO20brcC0fxVdoAwqm+osAI9RCIELYOwlIF8Dj124WfZ1LhHKOPzW
	MJC1ZqgCaD5nMKxuGKAWD14O20qKLVr0B8yS3Z2czEhfPVCoeTAafidFYGq8XPDUYa4PkN
	A8mAL9eX2sAHp1+kODOG6FP60myIbC2Y95C7rTEDfSenrVaIhvYyyHVJStxp3Jww/NZxpN
	vPJJaX5IlKL080d0W9lbPwgFkaUM5+2gXS0YBtWGhpfzKDs3e9pq6veDAsXveA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741332583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/WWLpb5STJ4E9HKptpFyE8OtdVIxQ5Lh8Y5krflY3QY=;
	b=jvzlICJ+gFguLlzx7hmzvmunSuYCmtov+nV4Vh2WxoZGBh7dk6QykUdKEQaiocDeQhBS/w
	b/WGk1luZya/ItDA==
To: Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
 <inochiama@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, Longbin Li
 <looong.bin@gmail.com>
Subject: Re: [PATCH v2 2/2] irqchip/sg2042-msi: Add the Sophgo SG2044 MSI
 interrupt controller
In-Reply-To: <20250307010649.422359-3-inochiama@gmail.com>
References: <20250307010649.422359-1-inochiama@gmail.com>
 <20250307010649.422359-3-inochiama@gmail.com>
Date: Fri, 07 Mar 2025 08:29:42 +0100
Message-ID: <87jz9147tl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Inochi!

On Fri, Mar 07 2025 at 09:06, Inochi Amaoto wrote:
> Add support for Sophgo SG2044 MSI interrupt controller.

I asked you in my reply to V1 to split this up into two patches:

  "The conversion of the existing code to this should be a preparatory patch
   for ease of review and the support for the new chip built on top."

And yet you come back with a patch doing both things at once. Feel free
to ignore me...

Thanks,

        tglx





