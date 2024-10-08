Return-Path: <linux-kernel+bounces-355447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786B9995258
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D55A1C24FB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8B118CBED;
	Tue,  8 Oct 2024 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tukaani.org header.i=@tukaani.org header.b="PWu/6xw0"
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62811F951
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399007; cv=none; b=pHILw3adJCFt0bBsjE04xSOl5X2rIF0VObFg0e9cIgtnUd4tfsQuqPWQgtoQO/kGdcacHGC5tz7dxd9icpAy39wiPiE7y9OAUqh3HkV47oWqsU2+ChHJplEDBX5QF1aOhKGwvtFQaSUCx3W9kmKu47KL+Q5HXKNZocET1QGbL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399007; c=relaxed/simple;
	bh=DuNywl2Gjq1wchr0y1kLqo+JtbZJn3PMKg1oXGV3xqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkhQWVLx81NojhrS8wfZGlB2s7K+RDi3YsVMjl1I6Wq4OHRlhvhzhP76d5r7W4IMqQ9GmZwgP8miIfrOzkG7T8ZaFoy5lPfAb0HYVhQhGRfvgkubR4nnrUzEsgQb95NXt7Dh6q1K+InBY0qAyPl6YRrL/ZyzNlkhdaMp/bOxiRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; dkim=pass (2048-bit key) header.d=tukaani.org header.i=@tukaani.org header.b=PWu/6xw0; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id 090A341B71;
	Tue,  8 Oct 2024 17:40:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tukaani.org
	; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=skHFFeXpOmsK/OrL7+Gzu4w0unnUHlHJgWLiWB68k78=; b=PWu/6xw0QXrrSooFdtD4jaU5tD
	NreoBzuon7q/kMt+MRWUshvxvPaKtjSnMWU2bEYiTuY2WriHNi4Wr9YRoo3B19yide/Kt2/H8WwPB
	CvjyOdbpXgWd9wgWKUJA0yGKW6byWq8Cl4UPRyt30Sh0+s0+3qVemW9CynP2T3dGb7GnqwhC+J2yY
	qwPuk6Om2w12iaFnHttlnVzP7BS+MhweZNT/uk+h6c6rAO34ocEQkrD8Amd6HTTZR9lGckWyyPCBX
	tnzt+bRUUWvO7jlvphPTADbZtoHQ7OHoICGve6pNRaLayR1IVZ9Lrb8n3/531FNNP0XwoRbPq3g6K
	2IdJ2AEQ==;
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1syBNi-0000000GRTL-2LHn;
	Tue, 08 Oct 2024 17:40:13 +0300
Date: Tue, 8 Oct 2024 17:40:13 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>, Vishnu Sanal T
 <t.v.s10123@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: possible memory leak in unxz()
Message-ID: <20241008174013.7b957a99@kaneli>
In-Reply-To: <20241007185045.00d57782b2f446acc7a78215@linux-foundation.org>
References: <20241006072542.66442-2-t.v.s10123@gmail.com>
	<20241007185045.00d57782b2f446acc7a78215@linux-foundation.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

In short, I dont want this patch to be merged, especially with its
current misleading commit message.

On 2024-10-07 Andrew Morton wrote:
> must_free_in needn't exist - `in' is always non-NULL here.

No, must_free_in is needed. The API (defined in
include/linux/decompress/generic.h) packs three different functions
into a single function:

1. Buffer to buffer (from "in"/"inbuf" to "out"/"outbuf")
2. Buffer ("in"/"inbuf") to callback function (flush)
3. Callback function (fill) to callback function (flush)

The callback functions need input and output buffers. For "flush", the
buffer always has to be allocated.

But, for some reason, generic.h says that "fill" can use the input
buffer provided by the caller when it's non-NULL. Thus, unxz()
allocates "in" conditionally and must_free_in is needed to avoid
freeing "in" when unxz() didn't allocate it.

I don't know if anything actually uses this subvariant where fill !=
NULL && in != NULL. Several other lib/decompress_*.c files support it
too although unlzo and unlz4 don't. So perhaps the feature is an
unneeded complication. Getting rid of this feature could make the code
less confusing. It would also allow making the "in" pointer
const-correct for buffer-to-{buffer,callback} cases.

> And free(NULL) is OK anwyay.

No, it's not. The free() implementation in
include/linux/decompress/mm.h doesn't check for NULL; each free() just
decrements the allocation counter. Thus free(NULL) would desync it.

As I wrote two days ago[1], this patch doesn't fix a memory leak or any
other bugs, and thus the commit message is incorrect. Still, I wasn't
really against the patch two days ago but I am now. I see the code
being misunderstood, and I feel this patch doesn't make it more
understandable.

[1] https://lore.kernel.org/lkml/20241006211720.5d7199b0@kaneli/

-- 
Lasse Collin

