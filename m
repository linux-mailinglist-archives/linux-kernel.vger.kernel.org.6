Return-Path: <linux-kernel+bounces-357440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B76799713D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095D2281E4F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52601F4734;
	Wed,  9 Oct 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CfPzSDFG"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4231F4727;
	Wed,  9 Oct 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490429; cv=none; b=YdW2uiFmh0o/uNZfJ88wVRCoR8F97UB66bdZSwjjrVSh98sftjdyncJlZeHjORWEXvUO2Nfn1mdOYb4PCEge8NwCkhO0FKHR9/UPZ0W82DPmPV1tqTtdY8ZqwzbW7mwhJXwCaNVM9J8aLZvAmAkrHtyzBxTv6Pk11Q7T9lkYuJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490429; c=relaxed/simple;
	bh=k2AauQCxT5E9o8Og7vMo0KTkdk0cTiSbjAs/VD9in4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GKAtA6CaRvNizvFcxXdREdD/t1d4CZidFPbTwc1CLgrqKqW8DGQgQgJGLC58XzOP+WAFQT+GgA7gG+0CFpT/SddB8k7TrFQTWuF61xQ3lp7Xvsx8d4fhzuQkdjw4yzgcjds9laAqoSk049DzhYxFifK/jqpR8IjlVhhs1CRbxA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CfPzSDFG; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5B74F42BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728490422; bh=CDzpyu2oFSqa5srLpZeVEFvn8kV26o/3REyRaSpzS1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CfPzSDFGBJruqkA8eajmYJHlOs5R5/st8DkhYhb6TcUudxTeVpRjWM4FzyXQCLwmt
	 n6pPp4BEwJ7yhLhR1tMJx5ngnuxMDjCz6bXdCcXpBhTZjBc7DgkPmX2mWAJjWgGoOS
	 Gjc5PcAHI9Az1V2mVo2g58xmLnyXxHxClXKeWEqyV26IRHjbY572Sen7PDE+1ZdotH
	 O6hgZ2f0HUl/vzesvns4ZqAkPDpf9z4+ntRLv18k4U2mdB9ei7FMdBZAHoFVfEuzPc
	 xKAzUJ6Nkh3bxtg5Z99g9zUaJxAKv3+VMyk9SEdZcwRVJupyAdVMQlqWJixOOr1myU
	 fQiMtJJ3p6fUw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5B74F42BFE;
	Wed,  9 Oct 2024 16:13:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Pengyu Zhang <zpenya1314@gmail.com>, alexs@kernel.org,
 siyanteng@loongson.cn, seakeel@gmail.com, si.yanteng@linux.dev
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 zpenya1314@gmail.com, yaxin_wang_uestc@163.com, zenghui.yu@linux.dev
Subject: Re: [PATCH v4] Docs/zh_CN: Translate page_tables.rst to Simplified
 Chinese
In-Reply-To: <20241008153824.4691-1-zpenya1314@gmail.com>
References: <20241008153824.4691-1-zpenya1314@gmail.com>
Date: Wed, 09 Oct 2024 10:13:41 -0600
Message-ID: <87plo9b6fe.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pengyu Zhang <zpenya1314@gmail.com> writes:

> This patch provides a Simplified Chinese translation of the
> "page_tables.rst" document, aimed at improving accessibility
> for Chinese-speaking developers and users.
>
> The translation prioritizes technical accuracy and readability,
> ensuring that the content remains clear and informative for
> its intended audience.
>
> Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
> ---
>  Documentation/translations/zh_CN/mm/index.rst |   1 +
>  .../translations/zh_CN/mm/page_tables.rst     | 221 ++++++++++++++++++
>  2 files changed, 222 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/mm/page_tables.rst

When posting revised versions of patches, please always include (below
the "---" line) a summary of what has changed.

It looks like Alex reviewed the previous version; is there a reason you
didn't include the Reviewed-by tag?  Unless something comes up, my plan
is to add that back and apply this in the near future.

Thanks,

jon

