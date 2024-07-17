Return-Path: <linux-kernel+bounces-254856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ECC933889
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2678283FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407A1224F2;
	Wed, 17 Jul 2024 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y7sa5tEz"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A82F1BDD0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203703; cv=none; b=NSwh8S8YuE9AXMGFr4nbyDe6hWdWdaCQwAEeJa/s22y+iP5GlVQKEE9aOCMXT4bWQEvDna29kAwNx5yT8r7sJVKA5XLVM5RaOY7hwvBM6J5WPEF9UGDOg2dKxM9OCKU5KeSVO5oKQWT7tISKHmIwLni2CI27aQqvx5u2A2a9cwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203703; c=relaxed/simple;
	bh=MqXRoyu++yzlzJmUG9Y7pYwOlmDuCpEVeJ5eSmjL0cI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bROzFIbWcUoU+t8KF8kHUtk3l8N3JA3Hf8CAvcRN1EZrf84cwA/sJgDwVOQtCXuDJg5n940S0u8LpZgjW1djKreNPK9YJXEc7vwRfYqIZ0irGneiQ66HLskHU8KL7iqWJ6RHhzhkYzjr8E8EvX7QdUhT+QzpdkVqWOn1zR7jFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y7sa5tEz; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0944C0007;
	Wed, 17 Jul 2024 08:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721203699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqXRoyu++yzlzJmUG9Y7pYwOlmDuCpEVeJ5eSmjL0cI=;
	b=Y7sa5tEz850gZM1XOiEWwVa4KTa3gRride+NaPYEpMFUeBfpNcFgkKmTordoF++xizsgoe
	EdeijD+RhjKkaNoE8e2k6QqlbQedMDKd/RWtgICfuLkZVFVumJwbwVHs+VOTIaloVTdBhy
	7gPK+ll4b08sjJiOK/iStXozbbk4mzf3PUwY4ZiFjKilbvT3hLVscKz1OnphJRI6cSh3Ml
	Qb7aWIGgSOHXzL/nkEFCHkb6XvfaGSW+QaFUjeN+AkcucLKXB8DRH2qXFm2u4nPo6mddmO
	YGbtVAFzzF+FR5d0SjBY39GzoASlALDBbVabB9JSuy9N9nXWV3IpX1LXcuAJzg==
Date: Wed, 17 Jul 2024 10:08:15 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH] mtd: spinand: macronix: Fixed warning: Function
 paramteter or member not described
Message-ID: <20240717100815.238cc0ae@xps-13>
In-Reply-To: <20240711083611.364431-1-linchengming884@gmail.com>
References: <20240711083611.364431-1-linchengming884@gmail.com>
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

Hi Cheng,

linchengming884@gmail.com wrote on Thu, 11 Jul 2024 16:36:11 +0800:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>=20
> Fixed the warnings: Function paramteter or member 'xxx' not described
>=20
> Reported-by: kernel test robot <lkp@intel.com>

I know this robot tells you to create a patch and credit it, but that's
not how it is supposed to work. Only do that if your patch has already
been accepted. Here in this case you need to send a v2.

> Closes: https://lore.kernel.org/oe-kbuild-all/202407110520.pbPnrOlM-lkp@i=
ntel.com/
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>

Thanks,
Miqu=C3=A8l

