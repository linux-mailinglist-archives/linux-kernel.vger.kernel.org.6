Return-Path: <linux-kernel+bounces-195830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8B48D5261
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD7A282092
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8889158874;
	Thu, 30 May 2024 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RTP/6QD1"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D614D428;
	Thu, 30 May 2024 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717097745; cv=none; b=IgLAK2W8tLFn8CTT4ue19HY9PCuLUYEC5PotyAI0ATMipxJOHlzhifjqXOi8bEC04hFGXguyjj8tJgMF33vpnLbc7sjw03WIL6b42N6oVAWEcV64OweZQ0JqtuJevZA3cfOCspzYm+7+jsN5MdKh9O126HDGpO8P1UMGL0KQbvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717097745; c=relaxed/simple;
	bh=zZ95PbAGHDZITMHqBFl4Fcs/YNpUG8IRO3W6hR/wDOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gw0x4I7uAf74+/S2oiRFKLOowBXIeCcBRI0wK6T0MMR1hl8a9urn6Iaj4vq+8uG6b6ZUbVtiTIL5mOkKtH8z1sZOgXDOs7BTqQqWLy454svLyeReVAQoWNprrM5vcGBTYBv/Gy3cAzgXLEHsehkPBPRwK3YKIqf9Z9JWN2ow/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RTP/6QD1; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CE61247C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1717097743; bh=EJcE2U0fTyieXXqvhCcgmZrobv5ZLgZuvcLqFu5r9Jg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RTP/6QD1F55Ia6jC+xzKTthycw4g+OhaGPQJDjW6loRLP0ZSayfOY4yHR6esSsBg9
	 LR/y5/93RpN7QIxdyrsCBYZ2uwmRGPuikN7DUe9U6k9cujN8BRHBt0yBeiYYBP5tSn
	 RH/EaWYrjS7IC28u/rsy9yOBLmXIcPVi6rWP2AIy3ctc5m8ESNUxa7CRXjVZ5pVkwG
	 O24NqloKuNXSsJjkePIDOKEKTmHBe3fUbmAp8sNWJUZjUfRa3fv38bR+4TtdwZk9e3
	 Ubr4HGuLFFJhlzbE4xIuF6T0RZ99TIScwVMlD3ZfwU9hweEygrTXe/pp7T11lLQFTM
	 aOzSaU6GSvQKQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CE61247C39;
	Thu, 30 May 2024 19:35:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc-guide: kernel-doc: document Returns: spelling
In-Reply-To: <20240522224726.10498-1-rdunlap@infradead.org>
References: <20240522224726.10498-1-rdunlap@infradead.org>
Date: Thu, 30 May 2024 13:35:42 -0600
Message-ID: <87ed9jcctt.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> scripts/kernel-doc accepts "Return:" or "Returns:" for describing the
> return value of a function or function-like macro, so document this
> alternative spelling and use it in an example.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/doc-guide/kernel-doc.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon

