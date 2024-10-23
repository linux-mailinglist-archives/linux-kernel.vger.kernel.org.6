Return-Path: <linux-kernel+bounces-377798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E20F9AC6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2037C1F240DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101DD19CCEC;
	Wed, 23 Oct 2024 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F8eYGl/L"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9787152517;
	Wed, 23 Oct 2024 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676976; cv=none; b=bh7fMds71yZs2mtOjkKzke3Kvj1iF+5lddXKiC8kYFVOrHzXkuQpYMSGrc7gt84gIjHAjoxUb3Ds6MQIUc5LO85Cc+zNpqUAJzLTvHEcxZgvujT25lsCfwfF3UMVIQKt7cTChomD1zONEKaSTe6kK3ENdgj0oNpDqNwuWFf0aQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676976; c=relaxed/simple;
	bh=Dpxy4vF3XNvZI84aiJIK5yFUJGSX//wdjUwQYvCatgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwQUKunxhczvU/Laa6M8beIjC5lxEf72uyIArtU+PgtHzI0I3neqxhW2rnqZ6Rsu/ihFsdlNgRcISEcPOU5vk+2SPALDXexWf9v8Z4j6AVccjj4oMpXog3NsbGFJ0PpUOTT9DHp8F9Et51BHIlFpLcdH0vyTPVsrqXKaCvJvpAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F8eYGl/L; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DE4520003;
	Wed, 23 Oct 2024 09:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729676966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5rNzgUZyWrtBSbaLrqGd7OPbJDTaej+TlqFpiYfr5w=;
	b=F8eYGl/LUBLH5b5Qbnd7lJ8YsELa2AQ0vy3Ybz2eaaPly6sCgzpuebVN4kemUl9fWuTNhz
	8NEvWEaI81iXglBSAOCmf0xB/nJWq48qkvmb3GTf/5L+a/uO7twrYokRpy+GQAnKesoj9z
	AmZG+kTk+Dfgco6KAMJ28M4LCBlpeybWl1GtRRdNpokUsl1Li1PIzgaobDgkor0B989FXU
	3RNzD6i/t8PKUYoRHKtiMD+pR29ikp5HTDP2ttBWHW6vEFhjSQ6Sn0PJktpD1tbPMRhIWK
	hX8Zcm1bhpGJ+wYwu+qb5VtQUBV2Reubwe/kxOk/Nid3XXy4dHxB4BJ6KJ+Bbg==
Date: Wed, 23 Oct 2024 11:49:23 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] mtd: rawnand: fix double free in
 atmel_pmecc_create_user()
Message-ID: <20241023114923.18e8e1b2@xps-13>
In-Reply-To: <7d809e5f-32e1-4438-9cc6-3167f27dd239@stanley.mountain>
References: <7d809e5f-32e1-4438-9cc6-3167f27dd239@stanley.mountain>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Dan,

dan.carpenter@linaro.org wrote on Wed, 23 Oct 2024 11:40:56 +0300:

> The "user" pointer was converted from being allocated with kzalloc() to
> being allocated by devm_kzalloc().  Calling kfree(user) will lead to a
> double free.
>=20
> Fixes: 6d734f1bfc33 ("mtd: rawnand: atmel: Fix possible memory leak")

Hm, I missed it. Thanks for the fix!

Thanks,
Miqu=C3=A8l

