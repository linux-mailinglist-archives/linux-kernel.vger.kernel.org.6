Return-Path: <linux-kernel+bounces-352532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D03F1992063
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0CAB21501
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 18:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAF6189917;
	Sun,  6 Oct 2024 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tukaani.org header.i=@tukaani.org header.b="glYvYWRe"
Received: from mailscanner06.zoner.fi (mailscanner06.zoner.fi [5.44.246.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896B320B
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.44.246.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728239039; cv=none; b=iRZnCiWh7gnATJ5qU6Ad3AR0CRKLyaS0RqxEw/+BEYN0z0+uZb2W4blv33+cutcS7+Mq67VgWxoE2kjisNBXvqMqq1h2phHR9Isnb2nuFTgL+AF/tfT9n4yUCcpAJTpOamv9YkDHRLLsY7mpAk+omMvl1Th0WNLskTtyfaRioU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728239039; c=relaxed/simple;
	bh=+76Q3HYForwnXQm69vgEv/XmppgpMLh2JE7jkJ9VQVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcVAOVajl6DRvKcAgggaW/GEyn99EXO7I0Oii6x+Xb47Fam5H9S0IqoxWnTt1D3dfGLnRj1i8wFSRdnlon6V9LzwfSGkGokxraZaZXM1pdTzi4CVMqJ2vMR6Xopnt7TYbOKHHhgBfyz0atnFDrs9xVD4BBsvHVvut1NFGiA5Eqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; dkim=pass (2048-bit key) header.d=tukaani.org header.i=@tukaani.org header.b=glYvYWRe; arc=none smtp.client-ip=5.44.246.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner06.zoner.fi (Postfix) with ESMTPS id 0C4D22140A;
	Sun,  6 Oct 2024 21:17:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tukaani.org
	; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uoCS2W19yrxCB0EMd7AKu5ADJwQd78uVXPEXM2gQ7R4=; b=glYvYWReLNEtqxcWJ/vRuGb/o9
	c9v41Y1TJXk9Opc0fkkD18SreD15AwN/IN9W4XoJAqu4tf6Ml4iRk7AAAbl+FOXY82yK9Cci5UQfH
	zT5HeVxTocu5fQQWgYSucMTjJlexOIyLQKWTHDQO5VwEt7AbGfIJcth41rZg5U2JU05rqTQ6vN03n
	r5XDBX13C5/u9Sh3hpK791etK77B7KhSWvJjua3702SY8tzbayrxeyiVo8gXWF+pdMQ6n+UosmLcK
	a9tHAp+YDvYSftXuilecdE1MHqpbJGMNUr9+EHcjY/IEkm/z7PXQw21FqFjSYwMgqX159aWFDJuRn
	fplcujEA==;
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sxVoj-00000003AN2-2W1C;
	Sun, 06 Oct 2024 21:17:20 +0300
Date: Sun, 6 Oct 2024 21:17:20 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Vishnu Sanal T <t.v.s10123@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] fix: possible memory leak in unxz()
Message-ID: <20241006211720.5d7199b0@kaneli>
In-Reply-To: <20241006072542.66442-2-t.v.s10123@gmail.com>
References: <20241006072542.66442-2-t.v.s10123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-10-06 Vishnu Sanal T wrote:
> Fixes possible memory leak in the function unxz() in
> lib/decompress_unxz.c forgets to free the pointer 'in', when
> the statement if (fill == NULL && flush == NULL) is true.

unxz() looks confusing but a memory leak shouldn't be possible. If "in"
is NULL then "fill" must be non-NULL. Otherwise the caller isn't
following the API defined in include/linux/decompress/generic.h and
things might break in other ways too. (I find the generic.h API
somewhat hairy.)

Note that both "in" and "fill" are allowed to be non-NULL at the same
time. That's why the code checks for "in == NULL" instead of "fill !=
NULL" before allocating memory.

The current malloc+free usage in unxz() is such that freeing is done in
reverse order compared to mallocs. I guess it's not important. At least
include/linux/decompress/mm.h doesn't care.

I think your patch makes it more obvious that there is no memory leak.
Perhaps it might help static analyzers too. The change shouldn't break
anything. On the other hand, it makes it less obvious to human readers
that free(in) is only needed when fill != NULL.

I didn't test but I guess that it shouldn't increase code size when
fill == NULL && flush == NULL. That is, compilers should see that
must_free_in must be false in that case. Even if they don't, it's not
many bytes.

I'm not in favor of this patch because the unxz() function is quite
delicate due to the API it is implementing, and the patch doesn't fix a
memory leak (unless the API is misused and then those misuses should be
fixed). On the other hand, I'm not against this patch either *if* other
developers think this is an improvement. In that case the commit
message should be changed since it's not fixing an actual memory leak.

Thanks!

-- 
Lasse Collin

