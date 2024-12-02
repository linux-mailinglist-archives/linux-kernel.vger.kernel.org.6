Return-Path: <linux-kernel+bounces-428056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AF79E0C2C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7F38B3F70F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2630F1B6D0A;
	Mon,  2 Dec 2024 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dOd2Y00O"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7221DB365;
	Mon,  2 Dec 2024 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159547; cv=none; b=S4J53vNA+3pP2y5m3mhqo1y2G0cx5iCX7rNtAVM8IUuaXhyIa0m3RPYKPqfCJK+DNUMuPRZnmvUeb2Xitrfd5JHsOvWECsUWevxoDxiKJGIzK42cXL3T5kVqRzs/encjkiuEh5T1qNDfA6bEk/nEHFq+qeOjCNpFW58p6exa9dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159547; c=relaxed/simple;
	bh=1wWZ7fiRP9gE9JCFyAgOI7dw3VHBnqkjNo+5YZTFyJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=djke5cIfVjy0N6ZaalZpD0IiTYtEGx9FSJlbc298wPu1S6hClsybczOhXE7UpmFCV5K2zZia4EMu8zoV+PAuzLcWvHM6r97I25nO8bpSh1N42fnwdJ6398GyPNYd7NMt68gOiO5RTKc4IonDnQNp/6YAV+SEd8A1NrsR/D0MiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dOd2Y00O; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D6B351BF207;
	Mon,  2 Dec 2024 17:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733159543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9oap0oF4sIkKizsm9t9eIwyMY648c0ihv0oz5piM+FQ=;
	b=dOd2Y00O4a8ZrBgx36PTQYGqD1UEHeBkeBVYd3Psk2MsbekT3buZO3UBMYzEAeXX1ZLsa1
	siCsfpjtO+2s2ZfAXLETNwPH3tJnBM0VWaG4d3m9YhTqvaStaHe4bo/6h/UsSMp0eR/Wvt
	Tfk/ryzMZx9lHWhvUprBWj7QkKtWOTZOlpK0CX9ispLk6kdUNPwdOftAZit/4LtyjF2TUn
	j/MzkhngnZu2AhW5mWTdvYcvXvUImcCWIGnh8ej3bBNB0lFPQ/kq7+WrBN8sj0IvkDA9iM
	5OEgKpyqU9FKUTLPD2RL0cvafjwUZ70qwP9yzyaDeOYiOUn2sRcKAToYRcTLeQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui-Ping Chen <hpchen0nvt@gmail.com>
Cc: richard@nod.at,  vigneshr@ti.com,  robh@kernel.org,  krzk+dt@kernel.org,
  conor+dt@kernel.org,  nikita.shubin@maquefel.me,  arnd@arndb.de,
  vkoul@kernel.org,  esben@geanix.com,
  linux-arm-kernel@lists.infradead.org,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
In-Reply-To: <20241125052524.135362-3-hpchen0nvt@gmail.com> (Hui-Ping Chen's
	message of "Mon, 25 Nov 2024 05:25:24 +0000")
References: <20241125052524.135362-1-hpchen0nvt@gmail.com>
	<20241125052524.135362-3-hpchen0nvt@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 02 Dec 2024 18:12:22 +0100
Message-ID: <875xo257rd.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

> +static int ma35_nand_attach_chip(struct nand_chip *chip)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	struct device *dev =3D mtd->dev.parent;
> +	u32 reg;
> +
> +	if (chip->options & NAND_BUSWIDTH_16) {
> +		dev_err(dev, "16 bits bus width not supported");
> +		return -EINVAL;
> +	}
> +
> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~PSIZE_MASK);
> +	if (mtd->writesize =3D=3D 2048)
> +		writel(reg | PSIZE_2K, nand->regs + MA35_NFI_REG_NANDCTL);
> +	else if (mtd->writesize =3D=3D 4096)
> +		writel(reg | PSIZE_4K, nand->regs + MA35_NFI_REG_NANDCTL);
> +	else if (mtd->writesize =3D=3D 8192)
> +		writel(reg | PSIZE_8K, nand->regs + MA35_NFI_REG_NANDCTL);

You should error out if the writesize is not supported.

Thanks,
Miqu=C3=A8l

