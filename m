Return-Path: <linux-kernel+bounces-290756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6682955844
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 16:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2269D1C20CC0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2631474BC;
	Sat, 17 Aug 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bwz7ZyLO"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE6C1DDF5;
	Sat, 17 Aug 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723903196; cv=none; b=kb/sHGCFNIBqz0hRzrN1Mm1njMOkwos4P6kxkjoZuaC/hE914/OVbN0xP+SmJQIPUHaSf3O34EqHGSh1Mw5g3rwaUYXAunRD2Et4bMY4wqkR2ejCdRyoqIntGEGBfdERFnReaU3dy7Qp3eNR+cNRQHvaSr+H2x4jLMjiVN5/KJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723903196; c=relaxed/simple;
	bh=hJEqTiSdRGD77P0iUW66tLZRf62k9GMot5GWstyJnSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DkYNlHLpTglybxYcfZO5iLllf7XQQv8sY9GGLKH7qKsRr3Yl7gd5g5dPSC7GlhXBnP0K9Rt4J9W3n06qsYb0GhJcR6RTxf2/U9g88V+MVLka4zUOFoeLENYL7BRyEX6rlrS0HUvlbk+nEjzUO6Cu/ANGXcscccSj26DghKL9U0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bwz7ZyLO; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5498841A87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1723903194; bh=g/7uCImxhrpsfdclZNlVGGCCwv21FyVoGk0Z26mZ7PQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bwz7ZyLOTXNdhs2KDcFkvA4VbKL1Ec/F6DkJ+eAYDTQC9tJ1acfO/t/GDO69EO/y1
	 ASbdIU81EcCrvOZJ/bMuVL4MJnL2zBPEdfj+jglZZHBdNKKAj6o+ZN3Q90pS9/pbLy
	 SUhQODrk3zHQ+6CD3ccv7AfKVfS/GUWvCUgRbTnjJEW2T2s3WWEw+Egkx9u7yD014A
	 lgmcjcUIPuVEpkHKUTciLOFprASj9vdMyiGv7wjaKzYNYDGg2LVp3zOiQJp+C4eBBX
	 oSw+I1z50D/4GZ6VDSxZ7bUgi5C2j8prIafKCaRfqpQ5AzbNAwVhRZn+b9R9lG+mXz
	 QBYRRq2kqdjcw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5498841A87;
	Sat, 17 Aug 2024 13:59:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Haoyang Liu <tttturtleruss@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6] docs/zh_CN: Add dev-tools/kcsan Chinese translation
In-Reply-To: <64426130-d59a-47a1-8bf2-3b72fb0cc030@hust.edu.cn>
References: <20240810082245.5934-1-tttturtleruss@hust.edu.cn>
 <87ttfkhzl2.fsf@trenco.lwn.net>
 <64426130-d59a-47a1-8bf2-3b72fb0cc030@hust.edu.cn>
Date: Sat, 17 Aug 2024 07:59:53 -0600
Message-ID: <871q2ni71i.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Haoyang Liu <tttturtleruss@hust.edu.cn> writes:

> I'm sorry for the warnings my patch introduced. I thought they were 
> harmless so I ignored them. I will replace the duplicated inclusion with 
> a note and a link to the original document.

The problem with "harmless" warnings is that they bury the real
warnings, which are then not noticed.  Trying to get the warnings out of
the docs build is an ongoing battle; it is important not to add more.

Thanks,

jon

