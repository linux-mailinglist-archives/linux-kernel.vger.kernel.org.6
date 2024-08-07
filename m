Return-Path: <linux-kernel+bounces-278298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8781B94AE70
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DAA1C20917
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EBD13BAE3;
	Wed,  7 Aug 2024 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="l6H67RLe"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4B313A276;
	Wed,  7 Aug 2024 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049526; cv=none; b=YhRyllWmTdTZTZP4zw7ZbayQcrD2nXZMGD7XQIl3tYDo73S6+xrt+HdE6MC+H8VdDsP9iyWuph1Vg9sgDAdbdw2X2hSHedpHYYJO9WtlMnEbtit1BesH2Ln4WgKMYZhnChj7QaHwfuDFDXMH5SXA45/AtgbJSewuitUFhd2PSM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049526; c=relaxed/simple;
	bh=UxpYNmysupzBoIQQBBUTvSFug8fRS32+rHyuUIu6XkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t3JLKpPsnLrSotVKvrq8RohHl57o8REKVzarrs5NI4O6fmXdcjhvbwe52s2vda3lAeYO1elWk4xrygUNvMzWnu4ArdQnqTVlCDboO7Zx0XP/mYtdM3O9cfDj2KnfsQroFnm10GTA2oH+zG0OOrndfEGlxw5udETfSg92gppXWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=l6H67RLe; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 55B12418B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1723049119; bh=UxpYNmysupzBoIQQBBUTvSFug8fRS32+rHyuUIu6XkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=l6H67RLermtz1uMEwU3DCUQvKyDLYR9Xomjro+hO7nmMVGmqd1XzRN2cW+gqq9qaA
	 18mbkCswq7gzXYC0vxe3x5P2XchHGuRoHKRt4CW8Uo/n4EahGkzbPPLThJLK3JV8o4
	 QXqZPdqfxvCaT0aa+65gddtNOds32JHYJnMLWyDB4KaP7bQKyzrbF7FYGJKdvGvvPD
	 Pp9UgDmgR0ieY1ZaeTVojHYiktiwFWEZdZbzDNylQRgt3KlZRcQUUtnanzyTehoIDN
	 2Wg74K4wzY18iMif680DbUmrEaHoTDuIRx2v2eu/FwDi8T5zgrRkVTXdFfszNQwlhS
	 pu3PisCiAuApg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 55B12418B1;
	Wed,  7 Aug 2024 16:45:19 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Haoyang Liu <tttturtleruss@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5] docs/zh_CN: Add dev-tools/kcsan Chinese translation
In-Reply-To: <d6eec1da-0e79-432f-a5cf-7dc8c59f28c1@hust.edu.cn>
References: <20240807162720.46588-1-tttturtleruss@hust.edu.cn>
 <d6eec1da-0e79-432f-a5cf-7dc8c59f28c1@hust.edu.cn>
Date: Wed, 07 Aug 2024 10:45:18 -0600
Message-ID: <87r0b0th7l.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Haoyang Liu <tttturtleruss@hust.edu.cn> writes:

> This is a mistake but I missed it before sending this patch.
>
> What should I do to revert or correct this patch?
>
> Thanks for your help and patience.

Send a v6 with the correction made - but wait a while for other reviews
first.

Thanks,

jon

