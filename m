Return-Path: <linux-kernel+bounces-199248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE2E8D845A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9895F283901
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741D012EBD6;
	Mon,  3 Jun 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AqckkOyg"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69BE12EBCC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422566; cv=none; b=AOld1QfZKnuR9S2yf6XqVpt1lHVFmVmjWDuzfP0/RtEA5W1bMusZXHY27GRUvb72B9z8gJ6j9C+P+ZEG2tVHx5KxxafJBUEaVFdMq9uVfRYKzU+mKiwY7d2U77whd7RzjidTcpXE1F6JBB4Atx2o00X6O3VwEF80dliBLwrMgyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422566; c=relaxed/simple;
	bh=z9K5vR7nav8alZNy7Ozvejb3OKNpcsYE3Cftk5p10Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZS28bOzSboPF7xIAB/ZtybfMU8CNQ5JJxb/K8uTbjYEH90F+CRHqa+Wm6hBe7jHFRD0mD4TwcWPJxN1v8KDGesb3MYhkD3jch9oDMtmx1i/SP3GtK1nh6a0iNAlKJ9ct4RHQF4FM6NdLkOPoWW9a50vypjn2jYQ7Wt/8ht7bok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AqckkOyg; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BECF1BF206;
	Mon,  3 Jun 2024 13:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717422563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9K5vR7nav8alZNy7Ozvejb3OKNpcsYE3Cftk5p10Yc=;
	b=AqckkOygqLn9SRaAoRNMxvTe3hG4ggDylcf4QJ5+QOa9MMn0EDTuOql6MC7pgK4pNBNNoU
	KzjrUnUBDJrVwWpFTYQinKJWB3ZBEXDA/U0zK2Y6gHRpedMkbL1cKnAuzF0kye3nJgRqT7
	S3mOVhiAOA5wT5YhOyEzVtr1hqn923rLfx5HLNLwaA2OeIFqz+oKFdkZR8o3U6dHx5A4rk
	rodnFu7g5iI29Tl1aPwAAHrJiSTXD1rmYsW+M23jtKUxC2+cQxQFXfHcNhUE5c6gUD3BcB
	XgvCdFjbeggzHgLJIicAiH31l7bGuAGIPsJTpFtnr9eNQr+J/qrObd1i7Hs1AA==
Date: Mon, 3 Jun 2024 15:49:18 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Culhane <conor.culhane@silvaco.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org (moderated
 list:SILVACO I3C DUAL-ROLE MASTER), linux-kernel@vger.kernel.org (open
 list), imx@lists.linux.dev
Subject: Re: [PATCH 1/1] i3c: master: svc: fix IBIWON not set if IBI follow
 a hot join
Message-ID: <20240603154918.4b0c95b2@xps-13>
In-Reply-To: <20240531154308.1246214-1-Frank.Li@nxp.com>
References: <20240531154308.1246214-1-Frank.Li@nxp.com>
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

Hi Frank,

Frank.Li@nxp.com wrote on Fri, 31 May 2024 11:43:08 -0400:

> When an In-Band Interrupt(IBI) occurs after svc_i3c_master_do_daa_locked(=
),
> typically triggered during a Hot Join (HJ) event, the IBIWON flag fails to
> be set when issuing an auto IBI command.
>=20
> The issue stems from the omission of emitting STOP upon successful
> execution of svc_i3c_master_do_daa_locked(). Consequently, the controller
> interprets it as a repeat start when emitting the auto IBI command. Per t=
he
> I3C specification, an IBI should never occur during a repeat start, thus
> preventing the IBIWON flag from being set.
>=20
> Emit STOP regardless of the success or failure of
> svc_i3c_master_do_daa_locked() to match I3C spec requirement.
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")

There was no hot-join support in this commit. You can probably use
instead:

Fixes: 05b26c31a485 ("i3c: master: svc: add hot join support")

Thanks,
Miqu=C3=A8l

