Return-Path: <linux-kernel+bounces-374676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27359A6E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE6E1F24549
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E121C460E;
	Mon, 21 Oct 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="b7Kwv6qM"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F18A1C3F09;
	Mon, 21 Oct 2024 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525318; cv=none; b=lqJ04t0aCqBZTU33TiKQmYayz4jFWYIbRpsM+OqBd3pIP4QVP7OHRPAVPG91TdPRg+phRI6dA0ovPFdu98WVLgJvu5rQpT5Q4bK0ye0koSTLWHa8U50DZW/2t3zHUw5NjSnZeaprb6rH90cRFZA8H3xLtbshQprQUeW6uQwl+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525318; c=relaxed/simple;
	bh=FMpS0Lsl+VBRqbb3k6riNLLqD+xLpIh15GzMW5SXq7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rAgaPw9c/kkBaCoBJE/YPRUU0vVOtZTht0r6NW5vPRo2NdOAFAA6WBzySEJ47efRR2Q0pXtMum6mktlUR+Cq0c2DIll7F7ivvgVB/ft69woUUe8mQaMKnzp0YDHnpACDqY/jhVGMWL9kJn85P+D6+7wUjGwQnOLptN/Xcgaf77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=b7Kwv6qM; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9E76842B3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729525316; bh=yHZtiOPkYumw5Q6y1t2bZkvKcfsinMNcU7MREGar9ng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b7Kwv6qMQ6XADaK6eCKoTvN9mnCOWpR3i4Y9zQ79ciUTkEyeCa7XIOxvXpTrOBg18
	 xI39/1gRkz/dRrK3XiYfKccVdqLYg+DGSAcx4DqH1XN8VOWgKZ9zDpK5aiaOW2O+Si
	 LS/JAc2tMiIFeI9M4ChKNW/Pxy6tmR4d8I9aF4MDEE/zIf5Q+j8FNCMaeHLeTFwk63
	 5Zc+UVPSDQVtY84mgNYV58cuSIRskXD+kpcWnmI+/cJevf13h1NsXut7lI3DBKSEig
	 uu3xsYphcfbzCW7JHwLy2cP10WgrKkJSNP2luvwdRfphG8eHUuxSBLQIEL3l418A7I
	 bPgYE0wB/iVlQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9E76842B3D;
	Mon, 21 Oct 2024 15:41:56 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, SeongJae Park
 <sj@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>, Federico Vaga
 <federico.vaga@vaga.pv.it>, Thorsten Blum <thorsten.blum@toblux.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/zh_CN: update the translation of
 process/coding-style.rst
In-Reply-To: <20241018014609.3781089-1-dzm91@hust.edu.cn>
References: <20241018014609.3781089-1-dzm91@hust.edu.cn>
Date: Mon, 21 Oct 2024 09:41:55 -0600
Message-ID: <875xpltqd8.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Update to commit c5d436f05a3f ("docs/process: fix typos")
>
> scripts/checktransupdate.py reports:
>
> Documentation/translations/zh_CN/process/coding-style.rst
> commit c5d436f05a3f ("docs/process: fix typos")
> commit 82b8000c28b5 ("net: drop special comment style")
> 2 commits needs resolving in total
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v1->v2: revise the script name
>  .../translations/zh_CN/process/coding-style.rst       | 11 -----------
>  1 file changed, 11 deletions(-)

Applied, thanks.

jon

