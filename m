Return-Path: <linux-kernel+bounces-346603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C816998C68E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCCA283516
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644881CDFDE;
	Tue,  1 Oct 2024 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pSbPFkAY"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB41CDFD8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813596; cv=none; b=hgRd+Ocm/Mj88hgPwUt/Ip8WWTWqlNqf+o01+zVpygsiozQynZKHgeSgT9Cym0oqa7tLJu9O5iIdDseKx68h78cy+U4n0u7kdHXiEslXmn7vARiF5yn1Hi1JcMGhsn1qQBywWYrXlHl4dBeAuYDeu5WaXtIVSAqjUpHvBy6DQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813596; c=relaxed/simple;
	bh=KnKZYbEikk3xZI7gKm9ZgpIsdiL1FXE8DWWLSpCufZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roR9s7ck/lePFPERUQ67x4pRzmwjYH7R5j2w/w/wHSFSIATQob2fiH76G0gMty4YWMhsR6nNF0rCy/gLFfN1ng9annREl8wISdhqbbFtsJIKGMJAVSgYYMXA3Tiu4+VDMPR6wDzJK74UV9+PojdYxC24Il0fKC2a/i5ifm7fnpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pSbPFkAY; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E44421C0002;
	Tue,  1 Oct 2024 20:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727813593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeYmk7FskEa2du4K8gi2eh15B3ito3tBITmnpXUtYQw=;
	b=pSbPFkAYspT8i9dq7N+o0X4btRnJz6IENXq/faIpo7brbOa8fc2TQuOlEG06jZ/hWhM5O+
	2dISfZ6FDnk/5A43hRTlO0RKUygw3ETmRYWx+VvBC13UzT2druHjDu9PWNHZFL4JISv77U
	9wprPLo31j6RzPBkMEuu8KzI09w2bTieOQs0JdjLErBV2+Ck911EFew8RN0Za4cmXLAuQK
	dA2VDdIbtinPOVTb//xemg97Cw70oofj0GOaE9HmiIAy5UJwOQsamS5ixE6O8cdZ/QlO7S
	+l/z4BMeFVyUwriezMUBDO30gWNMFnx8+B2+qRbEAOSZEbib3EO89U0b24mqzQ==
Date: Tue, 1 Oct 2024 22:13:11 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Culhane <conor.culhane@silvaco.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v5 3/6] i3c: master: svc: need check IBIWON for
 dynamtica address assign
Message-ID: <20241001221311.119e5c46@xps-13>
In-Reply-To: <20241001-svc-i3c-hj-v5-3-480ab8aed849@nxp.com>
References: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
	<20241001-svc-i3c-hj-v5-3-480ab8aed849@nxp.com>
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

Hi Frank,

Frank.Li@nxp.com wrote on Tue, 01 Oct 2024 12:02:52 -0400:

> When sending REQUEST_PROC_DAA, emit START and address 7E. Address
> arbitration may occur at this time if other devices trigger HJ, IBI, or
> CR events.
>=20
> When IBIWON happen during a REQUEST_PROC_DAA, NACK the IBI request then
> send a repeated start to continue current dynamtica address assign.

					dynamic address assignment?

With this fixed,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

