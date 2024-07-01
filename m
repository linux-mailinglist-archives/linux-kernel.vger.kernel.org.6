Return-Path: <linux-kernel+bounces-235959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D71FC91DBC1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F4B1C22254
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE130128372;
	Mon,  1 Jul 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A4yxTbo9"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B52C859
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719827631; cv=none; b=T0K1uN3wxh7VVUEVpA5cQg7e2C1cD0gDs2w1u7fDEystJ27/JFy2D4+KR9TrU/Klj38ASgENceYpZA1gTtvJ36HtRL+s/6JhfiE4FFwaHEHuFn13YlNxdCvye7qZngMZGHWquhRkBIKvur4unFez1AZ3Je1om33TIJUbt+V1S28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719827631; c=relaxed/simple;
	bh=vM2BqcsoybpKJKE+WB6Ic7BDJbuXe+TuXSwmVKkGXbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqiYC2yEGzRehrbP1VZ7TC2FLcLTu2WfmEyxALoBiFoK16r2H6KFni4cZLU1HMXyffbyrOfAw0TX6Kvmxdx5SkyqNxKrLhJ9WcdDFJ03DjJeQ/Bdnq/dZIZWDqudigwNDTHUPafQb+TFlU9ltrUdCNcXWiGbpWQtFv9YGvBGJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A4yxTbo9; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB6041BF20A;
	Mon,  1 Jul 2024 09:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719827627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vM2BqcsoybpKJKE+WB6Ic7BDJbuXe+TuXSwmVKkGXbg=;
	b=A4yxTbo9rV4rBfvnnUuQptK4TfLtqGMChbEgNYd6E8BKwOjiCLfX2sgIaAMguQTzcsihBi
	KgfjdQdj5Ft+LOnxc0QLq2tF/OcBU4YkU5s0vWZ5tmzgVaCKYZsHXswt9YUl9maOMLwBNT
	v4gxgMPjYeMLmn8d0FSiohuoyKMp1G7ZUkMs9e3P1oHs0QIYNGoG4nOW4DouRixMfKdeES
	FMRKQxIuBm52i/1Kg2D3mpckzIEZijEUH80yRCfMNPUavlCRsY6wWzGZ849Alnh2miC3Sa
	nOS8N6nJW0MNfr6JKkyx90LNjpKhkrfdqB6tDxypgjAK2GeSTVt+356Oehmfkg==
Date: Mon, 1 Jul 2024 11:53:45 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Richard
 Weinberger <richard@nod.at>
Subject: Re: [PATCH] mtd: nand: mxc_nand: always copy_spare() for page write
Message-ID: <20240701115345.3ca6fef7@xps-13>
In-Reply-To: <20240528203006.1479230-1-s.hauer@pengutronix.de>
References: <20240528203006.1479230-1-s.hauer@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Sascha,

s.hauer@pengutronix.de wrote on Tue, 28 May 2024 22:30:06 +0200:

> When doing a page write we always have to copy the OOB data in place,
> as the controller will always write it. Not copying it means we write
> random data to the OOB area.
>=20
> Fixes: 3df54960b63cc ("mtd: nand: mxc_nand: implement exec_op")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> Miquel, feel free to fixup the original patch with this.

Sorry for the delay, I'm now fixing up the original patch with this one.

Thanks for the follow-up.

BTW I've changed the titles to "mtd: rawnand: mxc:" to match the naming
changes since the introduction of spi-nand.

Cheers,
Miqu=C3=A8l

