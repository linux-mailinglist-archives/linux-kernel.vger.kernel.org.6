Return-Path: <linux-kernel+bounces-381174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9397B9AFB8D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E02B232C7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EDF1C07F7;
	Fri, 25 Oct 2024 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IuCzne0F"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20951C3F36
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842803; cv=none; b=G5dbdnUi95FUMORir4O9DwPphaSpkQn/5wP9qQ46QXDtClk61KrVG/FE8IovOVg4LvVXcmeBDwyt9slLytXvIufA3QQTeWgArK+rneJo5V4JnURNySTL2qRKU4QIuuSDL5dbaUmYPgpU+wARMhPaKObBcufaApqRkGgYQ3A4HpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842803; c=relaxed/simple;
	bh=40gzCCCrme78XnXow8uMr43mimnWIXjTPd1lXyTSI+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PP8RnI6ZmlXa8M2Ydz7NrydZyj9R/ARfSz2dKTkzH0MIx2F7fe0P0XvmJF+Y1qh/kS45UkPHkpzv87ZRebVzSTiObiHhfgX4vwcvu5l+PvRlhiG034AdijpYvd6Ie/6YfBjaGTNmLs6AT5AqWwz7Kx2/rlq1XWBnc+hU3/gjKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IuCzne0F; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0915FE000A;
	Fri, 25 Oct 2024 07:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729842799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40gzCCCrme78XnXow8uMr43mimnWIXjTPd1lXyTSI+U=;
	b=IuCzne0Fr3k0KaXrKhpVRMZVA1u6pTHH9Am/Wm0n59VP/F2yx2O8IKisftSqHdeMKul+OL
	LzlmcJvDa0eXXJsAjhnKPfCKTzLV2FESm92bMfSHgTPllJLbgUShjXHaSeI+hSsVImsIgV
	Gx+aMJqgATor5HN6VOBIQS6TWpFRMLt+ezca5yea4f8alOciSTrUMvJaJ2uy4N2ASU+K+9
	2G3cMfLrJzocnWsr1GAtFEyjTsGz+N1p2n1GRIL89X6l7xNxSLiANbiA95q+6bwIePF/pa
	UJ+jIOdGhowjUsvO58Z3z8KK1mqDP8dW+wH8dK2HdzKwxcvaQQF8ZkfVwqlBsQ==
Date: Fri, 25 Oct 2024 09:53:18 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Culhane <conor.culhane@silvaco.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Clark Wang <xiaoning.wang@nxp.com>,
 linux-i3c@lists.infradead.org (moderated list:SILVACO I3C DUAL-ROLE
 MASTER), linux-kernel@vger.kernel.org (open list), imx@lists.linux.dev
Subject: Re: [PATCH 1/1] i3c: master: svc: Modify enabled_events bit 7:0 to
 act as IBI enable counter
Message-ID: <20241025095318.4785df2c@xps-13>
In-Reply-To: <20241024203855.1584416-1-Frank.Li@nxp.com>
References: <20241024203855.1584416-1-Frank.Li@nxp.com>
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

Frank.Li@nxp.com wrote on Thu, 24 Oct 2024 16:38:55 -0400:

> Fix issue where disabling IBI on one device disables the entire IBI
> interrupt. Modify bit 7:0 of enabled_events to serve as an IBI enable

Is this bitfield arbitrary?

Is there a rationale behind it?

> counter, ensuring that the system IBI interrupt is disabled only when all
> I3C devices have IBI disabled.
>=20
> Cc: stable@kernel.org
> Fixes: 7ff730ca458e ("i3c: master: svc: enable the interrupt in the enabl=
e ibi function")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Anyway,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

