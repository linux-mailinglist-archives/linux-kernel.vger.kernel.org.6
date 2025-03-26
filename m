Return-Path: <linux-kernel+bounces-576951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C02AA71687
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5648189CF55
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6461DF72C;
	Wed, 26 Mar 2025 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dTz/KXdR"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480A56B81
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991586; cv=none; b=i2lmRoNHzN6Ycv9aPG1s5AnwdVsYj1806H0sD1nJ04wVQwi1HdSqr1d8JOm5gBxQUHxt15lV9WVDTqWMR6X2lsuAg0E570IqKwxG4rYXOqOPxyVEdiyhCupq5DhHMya3gN4cQzRnC1TlYW2FL6WkxFvcYSZft2zGyNp5cqPrJDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991586; c=relaxed/simple;
	bh=tvwT/fpOuTFYDbfORjAlX35n2nxm8ikfrhI81rjIqYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX8L0k4KyHlV/iV6WIEneLYxoKzL9YnIrGnIOjf5utyRXYHCuTssAkJS7WgP6S0QjGfHAoNwZoLQS3cpwc+qoPy1eXU7844jne1yZemARuDKYR6o9rKcIh3JTBZ8KuDxD2NQHlIfy3oNuWboXYh8QKZM5BULwBbZn4OLGMx5TEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dTz/KXdR; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Mar 2025 08:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742991579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/oaVHLFbWzKfUEG7Im5cPFtABNfTMHVrsIL6fXyC1Gk=;
	b=dTz/KXdRsI44K0SbkNy86I+cCZp2Dz0Xl3EzwAlFHMIEIOhmqWsRbn1YSd2Q3oEQ+DhoPW
	N2N3a5dWi6J8qRoNOwh9+/yFlL9zhbiY+A6x2AsynSziDlS4GvDwtnQYqGFH0WE7YRrufQ
	Jr4sh3AqEGax7XnAW39N0LMtZapqPjI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Alan Huang <mmpgouride@gmail.com>
Cc: Roxana Nicolescu <nicolescu.roxana@protonmail.com>, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] bcachefs: replace deprecated strncpy() with strscpy()
Message-ID: <bmjvipermsvb454mdh5zmlmw4gv4oub5fgh4eowedlit75gqei@3or3va3e52ce>
References: <20250326094449.16473-1-nicolescu.roxana@protonmail.com>
 <5F3AB2BC-43DA-47A6-A07A-72540B327D11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5F3AB2BC-43DA-47A6-A07A-72540B327D11@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 26, 2025 at 06:02:31PM +0800, Alan Huang wrote:
> On Mar 26, 2025, at 17:44, Roxana Nicolescu <nicolescu.roxana@protonmail.com> wrote:
> > 
> > strncpy() is deprecated for NUL-terminated destination buffers. Use
> > strscpy() instead.
> > 
> > Link: https://github.com/KSPP/linux/issues/90
> > Signed-off-by: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
> > ---
> > fs/bcachefs/btree_trans_commit.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/bcachefs/btree_trans_commit.c b/fs/bcachefs/btree_trans_commit.c
> > index c4f524b2ca9a..7ab25b425d11 100644
> > --- a/fs/bcachefs/btree_trans_commit.c
> > +++ b/fs/bcachefs/btree_trans_commit.c
> > @@ -364,7 +364,7 @@ static noinline void journal_transaction_name(struct btree_trans *trans)
> > struct jset_entry_log *l =
> > container_of(entry, struct jset_entry_log, entry);
> > 
> > - strncpy(l->d, trans->fn, JSET_ENTRY_LOG_U64s * sizeof(u64));
> > + strscpy(l->d, trans->fn, JSET_ENTRY_LOG_U64s * sizeof(u64));
> 
> The last time I asked Kent about this line, he didn’t want this.

Yes, the destination buffer isn't required to be nul terminated.

But it seems we should add a comment explaining that :)

