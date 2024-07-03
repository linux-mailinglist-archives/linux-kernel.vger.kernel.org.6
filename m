Return-Path: <linux-kernel+bounces-240312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A755926BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F921F22855
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CDC191F69;
	Wed,  3 Jul 2024 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="O/8I++eg"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5613C3EE;
	Wed,  3 Jul 2024 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720046259; cv=none; b=NKsyoavO/zJnb4gWvD7xVUPYeTbggji9DhrSiXRXBSUgx85I/XcfTiajlSW1Q6YZI0Jh6UaYOqMOuqKEvPHOCvAAjrqkuj5NOUXd4bElHWqoww/e49KBIpFKLWnwaUsqzs0ubmBJHwNTtsyPamYw8Gnyl36XTMvNG1jwDJ2hgn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720046259; c=relaxed/simple;
	bh=/jSnlMas1/hJX6ALElgjVjHxZSGjr0nCSwZK+OJ3aTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ae6iy1+yEwJY9j2nIDQ1Jq4NaTB3AhJzrml1ctx5Ck04Bws5A//hMjOirq+J/rgA6I1fEjlUCiFZQbTIVGP+KZaapltioUaRRLxognnzttalso/PGc7VZT3PBURS6FSkxn2mU32eF5KqoMN77P/Aawz4s1VVr0RtWGxVfGqjyI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=O/8I++eg; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 82C8B4189E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720046255; bh=Efvc/8PLu9Kd9WJZ3KSbA+E7Yu4xyZkmgSdx0WQsiSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=O/8I++egDrI8nedmW1NCz7xsXtoaKiAm/OGdpS4S9NpiViAd9UoqEudoFiIRE1zWS
	 pKcPZnzHfXG3Q8Ph9pxb6qZ7wYHrZgs8AQqzgxM/HZXvhRih1WEi+kAlIoiDJsAW03
	 I8Dx5mNUjpyFLpZHhGg38AFCL+Jdr1TRaQ8bDFll3U65nfqq5VxXmCrgA6WT1mYhRJ
	 KdFonovXtBMKM46oLQBoiBEfXyTH6LuLwnUt+jav8lH55EZ++Dq+65wji8ru255Djx
	 wEy215rRkyp2pkNzLrQrOKHiDV57xwc1U8L32iG/N01iss6xzD2HylnJWdSizLKvj2
	 KfOnBZsaS6yLQ==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 82C8B4189E;
	Wed,  3 Jul 2024 22:37:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jiri Kastner <cz172638@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cz172638@gmail.com, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [PATCH v2] Documentation/tools/rv: fix document header
In-Reply-To: <20240626203906.191841-1-cz172638@gmail.com>
References: <20240626150727.156397-1-cz172638@gmail.com>
 <20240626203906.191841-1-cz172638@gmail.com>
Date: Wed, 03 Jul 2024 16:37:34 -0600
Message-ID: <878qyit841.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiri Kastner <cz172638@gmail.com> writes:

> Signed-off-by: Jiri Kastner <cz172638@gmail.com>
> ---
>  Documentation/tools/rv/rv-mon.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/tools/rv/rv-mon.rst b/Documentation/tools/rv/rv-mon.rst
> index af0f329a7c9c..4d86fd55eb59 100644
> --- a/Documentation/tools/rv/rv-mon.rst
> +++ b/Documentation/tools/rv/rv-mon.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -=======
> -rv-list
> -=======
> +======
> +rv-mon
> +======

I have applied this, but:

- When you send an updated version of a patch, include a note saying
  what has changed.

- You left out the changelog text; I took your words from the first
  version.

Thanks,

jon

