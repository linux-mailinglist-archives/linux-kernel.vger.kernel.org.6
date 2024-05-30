Return-Path: <linux-kernel+bounces-195844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96AE8D52B5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01581C229DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91E0142E6F;
	Thu, 30 May 2024 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="NINj71SQ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89A433CA;
	Thu, 30 May 2024 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717099069; cv=none; b=DCWTa2gAlvU0P1BlNDqX7A4KmX6mv2sBwPIMDJXMJsBW52MNa2s1T0h50XeBFkIex/5qmN/ix84GULAbSrklrvp5xDtVpYI/jEw4P52wDKq7n1XgLTIvkEUQXIDMQ56HSXObbQ9ZPbkp1VrYmBTUr17+zd7GsyWDAYVVigzVfA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717099069; c=relaxed/simple;
	bh=70Z6Hwch5cDX1Yag0UqBCh6oP6TsMaD/hqajVrV9aAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HXPuk2s8iCsVkuW4uQjz1MgJQULnOQeXxZ6IQZJ938Hzj9vFZkx7Hssaf+npUlbWgWwL1pBEHsmvrY4o1LkKiKoxk3eywpsx0w/yiWxESnakZENS7AOruGBvJC9anepoyI/8u7P7ZX1RKfIgXViUBGda4XInzTRrVsILSOPtIII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=NINj71SQ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8FA1A47C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1717099065; bh=70Z6Hwch5cDX1Yag0UqBCh6oP6TsMaD/hqajVrV9aAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NINj71SQ5RKm42gjS56ALOFe5BwtgBRPzAFWF7Sp8OLpdSxFbuhOPHp6rezJ6qIYx
	 7zIQTrLkA/SAVPpfCTsdkkANt/rTREKwRWdSfc8Ep2GnShsFVOMn6lwnogaEtbfoos
	 Hwm9Kx3qYgZaNpPyFQzYpVVp1agJF0A5MaNVaJIQSNmkdKuzkLcJrrpXwX8ZxVyI57
	 1iYXELLAdUzpEFYbIZUI93Jsps27HR8PQ6bj9FYkW4nCe6h+XyBxZwqdCs7HujaqYa
	 S3yZw9ZlFThOfJDyYxXBC0birY9a4cGgvfUTjXjuUVgq2GTQJt8ozj4/jgSiTDRJv4
	 UJwu82eIUJ2hA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8FA1A47C39;
	Thu, 30 May 2024 19:57:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Karel Balej <balejk@matfyz.cz>, Thorsten Leemhuis <linux@leemhuis.info>,
 regressions@lists.linux.dev, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: balejk@matfyz.cz
Subject: Re: [PATCH docs-next v3] docs: handling-regressions.rst: recommend
 using "Closes:" tags
In-Reply-To: <20240513084145.2460-1-balejk@matfyz.cz>
References: <20240513084145.2460-1-balejk@matfyz.cz>
Date: Thu, 30 May 2024 13:57:44 -0600
Message-ID: <871q5jcbt3.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karel Balej <balejk@matfyz.cz> writes:

> Update the handling-regressions guide to recommend using "Closes:" tags
> rather than "Link:" when referencing fixed reports. The latter was used
> originally but now is only recommended when the given patch only fixes
> part of the issue, as described in submitting-patches. Briefly mention
> that and also note that regzbot currently doesn't make a distinction.
>
> Also fix a typo.
>
> Acked-by: Thorsten Leemhuis <linux@leemhuis.info>
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---

Applied, thanks.

jon

