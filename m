Return-Path: <linux-kernel+bounces-374674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AA79A6E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D471F229F3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9587A1C4609;
	Mon, 21 Oct 2024 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ye9KiAH7"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5E1C3F3D;
	Mon, 21 Oct 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525269; cv=none; b=j8D68C/Gr844p3rw6AkgNoX6I3UBGuJthPBm1zcCyACfrqLvhUC2Xo+akXwdL01HMocRQf6VW+dQOZBjFcQuwEwh9ewrZLBAZ/gj41e+fJpzTSIE9tV5MFXK2c30OvtQ/1uw+PSeKGoe9QTCQdzFCaD7l1fY+SZ8cA7cKS06jZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525269; c=relaxed/simple;
	bh=G9g+40I8y3M6ZPqDqPCDEioYPdPdVJlcAMLaxbn18jQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GoqTO0T4nXP4++5kL1fLJwQK41f9Tlzqd8GloSFGrxHFoWAeImign9ZKImeW7cnn/j5eIJy+fGOO7uunEf50Gn6BXb1cCvPCocpjYUd3ueFNKX41BuFiYrt8cMK6KkhLf2ZH8GQdI4dntdxMZlZdqw6eZsn1SZraLELCwFb/G6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Ye9KiAH7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8EC2042B3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729525266; bh=ObyUSrRbCbrFOSElhJg5GzVNZKZY84H+OFfgijxbNy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ye9KiAH7hiuBxzbb3obwZA9Kjr+0PSpvkkUJ4fKy+0WhYP9fD8BEjlD6MrLOGhqSc
	 sW2z9Cdr+KMwB6Owu/MZIZxoz/nYSlvqQnPtbQTvijg6nOvjghErkFMjKYwgBtACnc
	 mR34yM7IT8xnNIMnXv5HT1PcVl1kx7IN1l31/VjpC5n8Dq1201fLmElDgwlLxKoBbz
	 zgQe/QbW20uF1k10aQJSXJkB1gqmnZ2eMzGeIx8T/z6YEfyHn1nuuZhB8WhAKebdJQ
	 Hcyn4ELq1j6cVCnbt5EcXBhJd2KUklckxA3DwmUSMhfsZ4ZF1hIAqgriXkvXONWs+x
	 KiatALe7XZgww==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8EC2042B3D;
	Mon, 21 Oct 2024 15:41:06 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, Dongliang Mu
 <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/zh_CN: update the translation of
 process/email-clients.rst
In-Reply-To: <20241018014908.3783976-1-dzm91@hust.edu.cn>
References: <20241018014908.3783976-1-dzm91@hust.edu.cn>
Date: Mon, 21 Oct 2024 09:41:05 -0600
Message-ID: <87a5extqem.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Update to commit 91031ca349ee ("docs: improve comment consistency in
> .muttrc example configuration")
>
> scripts/checktransupdate.py reports:
>
> Documentation/translations/zh_CN/process/email-clients.rst
> commit 91031ca349ee ("docs: improve comment consistency in .muttrc
> example configuration")
> commit 7fe7de7be828 ("Docs/process/email-clients: Document HacKerMaiL")
> commit 9c03bc90c065 ("Documentation: process: Revert "Document suitability
> of Proton Mail for kernel development"")
> commit 1d2ed9234c85 ("Documentation: process: Document suitability of
> Proton Mail for kernel development")
> 4 commits needs resolving in total
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v1->v2: revise the script name
>  .../translations/zh_CN/process/email-clients.rst         | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Applied, thanks.

jon

