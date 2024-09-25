Return-Path: <linux-kernel+bounces-337836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C90984F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EA8280AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99349DDA0;
	Wed, 25 Sep 2024 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="asfP+YMH"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D698610B;
	Wed, 25 Sep 2024 00:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727225104; cv=none; b=iakNV5ZeMEvOYHFpkp6ZGmjH+hWrcbXMWSe8n1jVS2Kima9B1QdMXuy2NxQxbKISXlodLLkD4mWtUkLZkACx+hwh5QKogjoMPk8bwgjw6zNRSJo42UjiF0SvhXs02mWPigk4czs5HXp2uDTwNQIX8qt9W9a0U2csg6OTRtHl/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727225104; c=relaxed/simple;
	bh=6JVRpKCH9cHfAasD5GfZRsMLYICc/pWXRy4XsRTrw5Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GE0v80A8ZqR4Q0pPYt541uu73tK1gheXnNylvR2Bnu7OnYEUclr6ilKLWi+/EM7tZh9AwQnVoeap3Sghu8Pr/qsWG5BogEGv3vA5rR4zWJdvMVaSx7TGatU8X0co5v/rMahwc2cnPwBIsj0UkljzLgyfDIW303usx0RX8qT1QX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=asfP+YMH; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727225099;
	bh=z7YwqmSIkfJy5eX2ybGSz+Sd5B75kF2SWxpx8EP5VkI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=asfP+YMHmfgGOL0ZsKC7bu9cAqOPlM1ZiPn5BDumFOYtrQvxfe/F6/6V68J8OIFWE
	 k5YxDKMdCs1vQUNf8NKcQe1l7IF7yHoMlrxCOGHD4Aro4WbMtZnV9ntjVnrqoGYTQf
	 Yku+tGJ0FUEVZ7ZF/KKtpZqcAHbn2lBr4XrSoSE/Wh7vTPWK0yjmHJTnaTsfUgxRnP
	 0zHgDiy52qfViLTJp/6rJjXEVl+/LEL7uQuknFbAY01hnhdlc1OsiMqr0CQosc5OOK
	 ttqZ1rsBYzT5zIuQ+WAy1+Io4TBW4Biqx31QY5uBQIeTiXCAAcj6Tkd2gx1n/voEl2
	 BXGs16V86CNrg==
Received: from [127.0.1.1] (ppp118-210-177-92.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.92])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3E81C64C85;
	Wed, 25 Sep 2024 08:44:58 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joel@jms.id.au, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, patrick@stwcx.xyz, amithash@meta.com, 
 Yang Chen <yangchen.openbmc@gmail.com>
Cc: Jerry.Lin@quantatw.com
In-Reply-To: <20240924140215.2484170-1-yangchen.openbmc@gmail.com>
References: <20240924140215.2484170-1-yangchen.openbmc@gmail.com>
Subject: Re: [PATCH v1 0/3] Revise Meta (Facebook) Minerva BMC (AST2600)
Message-Id: <172722509817.374662.7338401100529556748.b4-ty@codeconstruct.com.au>
Date: Wed, 25 Sep 2024 10:14:58 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Tue, 24 Sep 2024 22:02:12 +0800, Yang Chen wrote:
> Revise linux device tree entry related to Meta (Facebook) Minerva specific
> devices connected to BMC (AST2600) SoC.
> 
> Yang Chen (3):
>   ARM: dts: aspeed: minerva: Revise the SGPIO line name
>   ARM: dts: aspeed: minerva: change the i2c mux number for FCBs
>   ARM: dts: aspeed: minerva: add fru device for other blades
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


