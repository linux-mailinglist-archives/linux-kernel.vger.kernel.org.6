Return-Path: <linux-kernel+bounces-374655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F09A6E25
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAEC282B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D4119F133;
	Mon, 21 Oct 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FZOMfv5i"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A236719DF9E;
	Mon, 21 Oct 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524625; cv=none; b=okKtNkixrEgmLcvJS6fe+x1WXsy72vW4hvqL62A9J40Nz288OV8n6LL6juSP7qn77A/wmSnnZ1Sbl19N9nEX3uMF5358H2CuaFvutuciQI0VY2QBqvh+pW40qiERZzRVhaBjI4K47c9zlZ5SIvImF97MmTNfbpeLmC6Hp3nUIOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524625; c=relaxed/simple;
	bh=TT2QyUsGNicsEgyMGPRC93OUkdpWgPpagvhS1C5I2+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nwJOrN13Cn2RXqNxblyfqC2tuskaAgdH2dtcOPNRStHk+HjaYQG6hjnIOTnllWnlSay0ROTpG6GvQASkWF1Jd3E3DXd19CQFsYV1667P4TG8R2kxls3mOf5dpLsn8j6E6uh4ElUNu9d9IHQqvH5niEJs58oam8XImIenlBbB0Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FZOMfv5i; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7824C42B3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729524622; bh=H489kSdhQ7TfamFhivHgfmOh2p+oCYztU/4FDtLuF/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FZOMfv5iZ2y4qwAJuurbUlIhHY9HRI7+mt9DxBgnbUNavAeMJ/IBLD7bmhhvWj6x2
	 s6IKtHw6NzxSsdMNSg/ZVTywpj+GRYcPfTEDACDkqsXSVdyXYoGoXHMfwRHyGcKzRm
	 eMIp/exaqLz3WxeV8Ik+c655l/DL3p8SZB05hED7d/u+qDqNe1x52QmCuZFpp5SmF5
	 Jabkxdwem4IXPu11psrBZnDIkNwGXA+Dma5HoaPd97FegINy7a4iBkK5EKmTvHCr0p
	 +Z8bQlMWDplkVPxoG9oMzERmNlhbm6PXrX7NlA1kbrWTyx0eFqPX44GuYJqaA1AgbW
	 zVO02kR+t7V3g==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7824C42B3D;
	Mon, 21 Oct 2024 15:30:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, Dongliang Mu
 <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs/zh_CN: add the translations of
 kbuild/reproducible-builds.rst
In-Reply-To: <dcd09bf28f52ba0461b26f800fdbb145c879a313.1729259177.git.dzm91@hust.edu.cn>
References: <cover.1729259177.git.dzm91@hust.edu.cn>
 <dcd09bf28f52ba0461b26f800fdbb145c879a313.1729259177.git.dzm91@hust.edu.cn>
Date: Mon, 21 Oct 2024 09:30:21 -0600
Message-ID: <87r089tqwi.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Finish the translation of kbuild/reproducible-builds.rst and move
> reproducible-builds.rst from TODO to the main body.
>
> Update to commit 114ff6fe6cfb ("Documentation: kbuild: Add description
> of git for reproducible builds")
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  .../translations/zh_CN/kbuild/index.rst       |   2 +-
>  .../zh_CN/kbuild/reproducible-builds.rst      | 114 ++++++++++++++++++
>  2 files changed, 115 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/kbuild/reproducible-builds.rst
>
I've applied this (patch #1 was already applied).

jon

