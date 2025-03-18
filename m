Return-Path: <linux-kernel+bounces-566511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F33A678FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C57007AC36D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52EC21146C;
	Tue, 18 Mar 2025 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WqQ7OlNj"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EB617A2E0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314713; cv=none; b=r6EkVju3WUM+FFbEO5aVp9l2OOAlhGJWqcxO4cGfGg7djOMeZcplN0QJ+5r18IGLss+bR9qhuZI7anxuwEtdU2jw1Z1gL36/uvO+n6xUy7NMWO1g4ovVrq3gzFR0dZOTB5kQACCwrlpeoV6v907djDwRH7hoiSDXJHPdBPS8+eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314713; c=relaxed/simple;
	bh=9CiRYV4nFmJ3lsldkjEBqD9ZoIMj0GxoXa0FyxvjIcY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FIpXiQBEYNI80O/5iHFkPCPS5rqi5F1rxrzyl5L+lbmYqW3L3t9HLf2s/XD4Q68zKSK1JfSgzPwnyHFCxBvWW9Zr6fXwrLxMiEEFQQlQMlvnm3lhkWGY0SeIHPVFU/Ni0o1uzz8GYYMAddBpZMJAyPGfYVODgxrcvM2xGxsuAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WqQ7OlNj; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27C0D441C7;
	Tue, 18 Mar 2025 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742314705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0HsYsgklxio8eVU/7K0gaHJr/wooyxavQcTZxJyn+o=;
	b=WqQ7OlNjvPTcrrerHK/OrXGUVVthZEjd5zDedy71Cp+n5qThfEu4AKSnBcFMURAfaDECNi
	vA7HoankcVboOzPyozrxpfgeEXUCDO5sJZwQTyjqOvrE7v87ucDnB3Wpc7BcB3RRt8R7n6
	16H1nrkjB5w/kowfhNBWsy7n6PhHCWmM8JWyw5zwKW31HMZIeOWW/juFABAjgCXMt+cLBi
	bTX3UkkdfhoemeDmxVMvIu/lWb8iH1qMsYt/PSH/LTfoqcS2qep+asnjuojj10vzpsVKgb
	f/tz3R3TszNzfK23EEzby3/x+cN7b+sq3m4XX/60M9RiFpux5T9PggVhgLRCMg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20250313091631.243346-1-andriy.shevchenko@linux.intel.com>
References: <20250313091631.243346-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] mtd: mtdpart: Do not supply NULL to printf()
Message-Id: <174231470500.980193.12972335219396659014.b4-ty@bootlin.com>
Date: Tue, 18 Mar 2025 17:18:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevjghfuffkffggtgfgofesthekredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieffhfeulefgtdeltefgleevgffgheduledvheduudelgfehlefgheeivedvgeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhts
 hdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 13 Mar 2025 11:15:53 +0200, Andy Shevchenko wrote:
> GCC compiler is not happy about NULL being supplied as printf() parameter:
> 
> drivers/mtd/mtdpart.c:693:34: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
> 
> Move the code after the parser test for NULL, and drop the ternary completely.
> The user can deduct this since when it's not NULL two messages will be printed.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: mtdpart: Do not supply NULL to printf()
      commit: 6bc9f42739889eaaaa47b90f48e4ef8323efa3ea

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


