Return-Path: <linux-kernel+bounces-432999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7659E52D2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4EA1883724
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8B51DACAF;
	Thu,  5 Dec 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="adT0bqqf"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B371A8F90
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395417; cv=none; b=HSPWadZKsxnNOMWZt1gYWpKRWcaaPhPAxG94UTkUTcUpaI9qKp/FdQbGpTrDcQ3yIWfxGudrLNNpMmC+KkacL0w2OEQLRl27e+2uOMGbUyEuhmVBgDjoK7VKxmOFglQPiY13ZLmSQiPi2hgIWU88Lc+qLq4ZyyAWzJ8pLuK36ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395417; c=relaxed/simple;
	bh=0J46msOTtINQyWl85h4mLdFl6n3LTJtMAgrqyDHHEV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgl9r4uO2bomQszwoygFzERG5OsStCAwEEXt51Y44jkUVzYeaJgKi6eEg0xPG8pZTbfaOsd8Hn7tC24reKw0HMRgLU4088a2o/lLIKNoBq+spBPNeuKJs/b9CYhe/ofQSQtZValrg9X7szhNTIWmdwta8AXbZs2pjJfG/C2j8Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=adT0bqqf; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2862DFF804;
	Thu,  5 Dec 2024 10:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733395413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/neGO5Y8BfT1iCWWi0dB/xELDJS6gvdEM2M7lIFYIM=;
	b=adT0bqqf8s1X5wQYJ3GBojglkRsOD/HSIzN+k4zjZ9h5oFXPLlVrbVBze8/0U6iePLmass
	xCfOFyUr3V/Lt6u7UAsqi7h+KTkEmFGdxdxZkLQmE4+6nC9ThxIDHQERLE7GawyUGuxBOQ
	xhtdk18snDYDgnNG4frhUfepqqpP+LJNCHIYNj4r8Ukewer3a3ESC5djp/CCpQzzI3PRG3
	lbp1dtEQHdhtTu5eH110p9zfALvXAbRp/P0Qv/cqCJgzSdJgUql2Q3elMpqHgAd1OUWEk7
	Lo4LY1IkrluY3NFIrCz8LcgHzjysq0i9HEr+Iy6SD3ICynUIpnzOCxwIEhGEfQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Bohdan Chubuk <chbgdn@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: add support for FORESEE F35SQA001G
Date: Thu,  5 Dec 2024 11:43:24 +0100
Message-ID: <173339519115.766262.10964911797107048383.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241110205048.1751377-1-chbgdn@gmail.com>
References: <20241110205048.1751377-1-chbgdn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Sun, 10 Nov 2024 22:50:47 +0200, Bohdan Chubuk wrote:
> Add support for FORESEE F35SQA001G SPI NAND.
> 
> Similar to F35SQA002G, but differs in capacity.
> Datasheet:
>   -  https://cdn.ozdisan.com/ETicaret_Dosya/704795_871495.pdf
> 
> Tested on Xiaomi AX3000T flashed with OpenWRT.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: spinand: add support for FORESEE F35SQA001G

Patche(s) will be available within hours on:
mtd/linux.git

Kind regards,
Miquèl

