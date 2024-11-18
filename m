Return-Path: <linux-kernel+bounces-412794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB519D0F72
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FEB1B2418D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F8194A53;
	Mon, 18 Nov 2024 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L39MPsC6"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A315539D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927532; cv=none; b=n1YKQdnwurXN+v/lmvwi7Drds2fbaRdIpTyz93as58sN4T5Pt3nN4jWWZ3sDox0oFjw5S+8HPjI42pcdXCtVDocddp96A6kfeLAi1s0nI8otEMmLU8b1HPdORSyPRakhNMMRbWBg0D2uT/itvgE4PwIt1u1IdjXfxDEq89VJ9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927532; c=relaxed/simple;
	bh=vXaBGWR07f8ge1xeXOPSaCwmqO/Cy55m2joFSOl39so=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PxO24vnBhodpN3REMf5ThjbJxieCdD7GHJFnhkVCfi8AcprH7XuM85BZoE+mHEo/X08Y7ULqMP6IE34XsnR4ZXjB9w0DJ8p4dr9A4tBJ4VSWYH2Vj/gtAYs18mRoOAvfglTrvdl/nhjlp8cwvOLOrBgrXfp3ToGtwfUz0DGHV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L39MPsC6; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76B85C0003;
	Mon, 18 Nov 2024 10:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731927523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXaBGWR07f8ge1xeXOPSaCwmqO/Cy55m2joFSOl39so=;
	b=L39MPsC6OBLQl/5e2f5dKe8qyENmtiOV8QJ2P0a1KGnnpJEZd1tCO2Dpp6gVQp6rt1glHD
	EZp6o0PFivl3D9sH+U6jJ/JC/3kEQ9gMDpI1FL2NqEN77B9G3uJza5UsgNnAIgrdr3ot44
	c2/gZEykQAqW90ng1vfJeoCEigS2SyDTqgCLnCGATHB40NvnJQ9Q+o4BQNGiEpMpwPs+i2
	GfSMNEX0JajxgPc3Nq0xtPB5sJfoOKmVAxN+glAyCyP9wuJOzVZBlxCbd3WuiP2mXPrMIC
	ZzAEYoYzP7rp4if1qJtD3bffKew0/9/BFapB4zIMMnaHVVrhhlRmnwwSA5TLQQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,  Daniel Golle
 <daniel@makrotopia.org>,  Chia-Lin Kao <acelan.kao@canonical.com>,  Mika
 Westerberg <mika.westerberg@linux.intel.com>,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <linux-arm-kernel@lists.infradead.org>,
  <linux-mediatek@lists.infradead.org>,  Steven Liu
 <Steven.Liu@mediatek.com>
Subject: Re: [RFC PATCH nand/next 2/4] include: mtd: Add CASN page
 definition and related structs.
In-Reply-To: <20241020132722.20565-3-SkyLake.Huang@mediatek.com> (Sky Huang's
	message of "Sun, 20 Oct 2024 21:27:20 +0800")
References: <20241020132722.20565-1-SkyLake.Huang@mediatek.com>
	<20241020132722.20565-3-SkyLake.Huang@mediatek.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 11:58:39 +0100
Message-ID: <8734jozu3k.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 20/10/2024 at 21:27:20 +08, Sky Huang <SkyLake.Huang@mediatek.com> wrote:

> From: "Sky Huang" <skylake.huang@mediatek.com>
>
> This patch adds CASN page definition. You can see corresponding
> table in CASN page application note referred in cover letter.
> (https://github.com/mtk-openwrt/doc/blob/
> main/CASN%20Page%20Introduction.pdf)

Please don't break URLs. They become no longer clickable.

>
> +
> +struct SPINAND_FLAGS {

No upper case struct type please.

Thanks,
Miqu=C3=A8l

