Return-Path: <linux-kernel+bounces-266470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F420F94004D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC081C22243
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA418D4B0;
	Mon, 29 Jul 2024 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EILztsLB"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A218C347;
	Mon, 29 Jul 2024 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288163; cv=none; b=fG8IwBXFCbuiz8peftIDVKBKRUBhmcRQCA/h3SrkcKI3N8hhybWT7doDCjk5dPA3P1WXogKSP0QNH4+DRIafa1jBtQSZqxy/7BI2xUBQ/rw4rZxgMkcesBnu8cXtZhZZ6g+L3OijSri10ez9vRTDYP5UDzBe+l6l1TcBHHOef1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288163; c=relaxed/simple;
	bh=R9AYkBOD/2XH88pLTZUnOyZr105dFQRdKQvbOfY7Zgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kx3t5EqsqmHnGyyX3+sKTQT0c60d9vdqGuy3XfkTVUVk09hjvchOdxpTsm5Q/5kw42T+K3pfORphdGz/MOTaq0o6girMZ1QrCk5czIIfSC5fIv2LxHdbog/GC4eZI1WEVJlRC+4dvK5FvdjEVxS+NZH/bfO9WKebt7nNyVSCK9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EILztsLB; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 52EBA418A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1722288161; bh=RyWZEF0uE9/GpLstC3B/M0wdGvTdWYuUuUk/b7Hmmtw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EILztsLBvixPKyKKQiXvht4WAw9bjPe5PsvtOjA7Qy4IBLaVa1wWZBbVHyqEq5ICZ
	 F9TRmffappnsBxtwjR/aWl7XIJ6+DbxayS0XcEaQzBBZcCBcINzbvn2w7DSrO83IP5
	 Cpo9jyWPXg/af4l6XEfe1kRiLqJWXaTju37ko5fMlKHXK6iDxy2syqGqXp/LNIjqLu
	 S64TJ/Vg/WbdgO0NdVaOOrMHrQtsj8wt6Y88b+t45Wf5W2pH79jhBVjfzbxZp+ulyb
	 /dSJrEYdXdadtg7PjMFOgS9xBiI7aYQUMqxf5Y8w+/DtUYSlf23aEE2gk+nlnIDLnd
	 0mr4mTOp3qJ4w==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 52EBA418A0;
	Mon, 29 Jul 2024 21:22:41 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: si.yanteng@linux.dev, Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] docs/zh_CN: add the translation of
 kbuild/headers_install.rst
In-Reply-To: <a17a7994657696fbba9c9be29c35629ef512f85b@linux.dev>
References: <20240726145754.2598197-1-dzm91@hust.edu.cn>
 <a17a7994657696fbba9c9be29c35629ef512f85b@linux.dev>
Date: Mon, 29 Jul 2024 15:22:40 -0600
Message-ID: <8734nrao67.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

si.yanteng@linux.dev writes:

>> \ No newline at end of file
> Add a blankline.
>
> With this:
>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

I went ahead, applied the patch, and fixed this.  Next time, it would be
nice if I didn't have to do that final step :)

Thanks,

jon

