Return-Path: <linux-kernel+bounces-515240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6309A36233
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0DD01894E25
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8698826738C;
	Fri, 14 Feb 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YqVe5pFN"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42B266EED;
	Fri, 14 Feb 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548103; cv=none; b=Ttr9n9k1Vfgzx1wZD9ELFEuhLEG/+B679vCKajqUGZtnNrXmOmoystpGkn3V8WB14nEV7348IGSAgAwBX3qcozgA/BztLPxClkHV7y0wUHff1/9GMcxiAFSBbKPiElXZYvGtslwlPCanYIiQgNwVopTYrxgKYCWjfrScmY0PAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548103; c=relaxed/simple;
	bh=U6APWy5eOU+ky4g87wOhQunp/dT8xYdyxswb5jLwX44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qP0CSGlEbYpUnVFYYxE5sOSnyXO36RXcItRUw7pvdjEpd60I5uhESG9iHCcrExgGUs/ymmQZVnnYOcga/X5JdoJ4qeF9m8CYAYdex9x8Yjv7zsbd5fjRqqharA6vUQ17DHb2Bj5zBhlknXuheE8g0N9qdYgQs7NbtZkULDMwvNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YqVe5pFN; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D83BF44097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739548096; bh=pmXNAyicDftXc6ZJLRxXI2RG+kkbtih3VXkcOU4b68g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YqVe5pFNr4JVDYdQlVXYMPZngj1R0UhwTVXQcIF55QjDXoUMXkKUXmF6X4C9zRmee
	 Zmo+UgX6p1G4S7/Rm9ET/2HrsxlIVYzayNy4KoArjF7op9NcOHeQyB6birrWvWM9kU
	 KfQz9V0AhCsazVXiEDRbIx4bLsbYhUHCTGFDe9Ya8zS4e5ZEssm/k+M/f+V+CPma52
	 n5ZZDxOHMbiktzE8yF/snqQdEvV+sp0oUnk8rQk+0l+2jnQDVOGdnIneISeX+XvRxt
	 4H3KFsf4Vfk5tca0UPl7KqkKC/jd/jSIMLmGs/Ovwmu0BQwDwRt9skLPzsUFyBFh5q
	 hYetK8BYxteFw==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D83BF44097;
	Fri, 14 Feb 2025 15:48:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: David Reaver <me@davidreaver.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: David Reaver <me@davidreaver.com>, Jens Axboe <axboe@kernel.dk>,
 Konstantin Khlebnikov <koct9i@gmail.com>, linux-doc@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: iostats: Rewrite intro, remove outdated formats
In-Reply-To: <20250214051432.207630-1-me@davidreaver.com>
References: <0e8c8ead-423a-45f3-9e10-020334ef8907@infradead.org>
 <20250214051432.207630-1-me@davidreaver.com>
Date: Fri, 14 Feb 2025 08:48:15 -0700
Message-ID: <87frkgzfwg.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Reaver <me@davidreaver.com> writes:

> The discussion of file formats for very old kernel versions obscured the
> key information in this document. Additionally, the introduction was
> missing a discussion of flush fields added in b6866318657 ("block: add
> iostat counters for flush requests") [1].
>
> Rewrite the introduction to discuss only the current kernel's disk I/O stat
> file formats. Also, clean up wording to be more concise.
>
> Link: https://lore.kernel.org/lkml/157433282607.7928.5202409984272248322.stgit@buzz/T/ [1]
>
> Signed-off-by: David Reaver <me@davidreaver.com>
> ---
>
> Thanks for the encouragement Randy. Here is a rewrite of the intro.
>
> This patch is mutually exclusive with the original patch I started this
> thread with. Let me know if I should submit it as a standalone thread.
> (I'm fairly new to contributing to the kernel.)

As a separate thread is generally better; no need to resend, though, if
there are no other changes.

But ... I'm not quite sure what "mutually exclusive" means here.  That
they don't conflict, or that they cannot both be applied...?

Thanks,

jon

