Return-Path: <linux-kernel+bounces-180771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF018C72E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6284FB23093
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACBD13E888;
	Thu, 16 May 2024 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NX2Z0NGa"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6E613E419
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848339; cv=none; b=KT1r6M5f4CnEdQh5Dh5RMu7PfK0567MZObJ72SRUMBHUXpP7RJOo7gFkLsXjVoFJQ6Ccl3o/3Ygo2uVpYH5vSMX46gX3TwhMagifo5Cw3ImJKl02AcBhBdgCgSkLD0tQ0nDqAeklU2jwvGQ8PDi80aWvTxa8wP1+1ULdA4+IlRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848339; c=relaxed/simple;
	bh=N3F4LANa81kWz5jS+zElqxrFqvp6HyHFZXEGk+FZp2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgrUPK6BP68Ak1I2chP1DBMzKxc6F41zhXB1oF54EcIbdqxO1Qt/ch7eovaT841fMUIt07faXf/xF8oA9KZxzCzKl65YBCB5WhUAMRtVJtpH4OTdKnAcQ+Ckxp2kLXqqXxQK/dv/XIG/ptqGg7DjroIdAUXlofh2g9ziFIUord0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NX2Z0NGa; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F9C91C0003;
	Thu, 16 May 2024 08:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715848335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CeoEgDzrf8v+3ybZyI2qi/yVTnST3l7VSUfdHfTW0U=;
	b=NX2Z0NGaTiPVsDW8QZg3U7UpGgybZS0a7rLSrTVJbWrixdTFRo1Z51MHIfFLR7xifbA1ZM
	uQ5IQ5EZEIQJnjdRqczPADjFh5GZ8ocjCtWWOudPzbu95pScuUUeHgRzieTBLr6uCG/fKd
	3lmEWBeNtFh1wk9wHKi8BrMuEXl2QlU5HGH63cOTHP8vg8B6I1nNUuDuJz43cIswb0wUFW
	G0reP4DCvEn50JudYxHMRJCWAi30IytD/Hra4yEJbm6l7/FqTRvJ/BfUHOL/0Pl+mmPvFd
	FlMNlT6Di3t5Bm30k4ENKooN75eBxxHlrQZUnwDidyjtqMDNAV+89MCZwZJpJQ==
Date: Thu, 16 May 2024 10:32:14 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mtd: nand: mxc_nand: implement exec_op
Message-ID: <20240516103214.57a8ce33@xps-13>
In-Reply-To: <20240514-mtd-nand-mxc-nand-exec-op-v3-2-3e6f45fd3d82@pengutronix.de>
References: <20240514-mtd-nand-mxc-nand-exec-op-v3-0-3e6f45fd3d82@pengutronix.de>
	<20240514-mtd-nand-mxc-nand-exec-op-v3-2-3e6f45fd3d82@pengutronix.de>
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

> +static const struct nand_op_parser mxcnd_op_parser =3D NAND_OP_PARSER(
> +	NAND_OP_PARSER_PATTERN(mxcnd_do_exec_op,
> +			       NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +			       NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> +			       NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +			       NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> +			       NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, MAX_DATA_SIZE)),

CMD, ADDR, CMD, DATA is the RNDOUT pattern. So it is now working fine?
Or did you forget to adapt the patterns to your use case?


Thanks,
Miqu=C3=A8l

