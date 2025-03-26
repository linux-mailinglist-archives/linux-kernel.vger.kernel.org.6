Return-Path: <linux-kernel+bounces-577166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA31A71947
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950947A4CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6811F2B8B;
	Wed, 26 Mar 2025 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AsUx8/vw"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA721DEFD7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000490; cv=none; b=TcvuwVtqmHqwto2RE1KbWudO90WhktfqK7vbwDs6VRVAlAAcp7LZ5PkaDh3a9mfiumDIQY0Wi5LafoJ9AcJCT53EQUP+E90lacfl/FzQiyMDaJ4pTAVYMGitqUAnwMVwBZa98dRLGlzKnpFiRzNTD8pLJJ1KX9HZqM92y6OxP/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000490; c=relaxed/simple;
	bh=P/YGDyAuI5cdqgreFYOTvG0r4vimRMchc6eat/dWEEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6Bl991+jqTb73bUNRm2fVLbDGRxsB1b7RVh5OSbjSUe+X+YD9AxYr1eYfUkd5OW0v4yQEKcxMSZQUaMUail1WqeOE1A8BLCCgI9SVXu9WdXAjetE9kB3G0jQgdJtODa3j420PrwpCO5ky+9rKubySS86APMZ5pQ51pE8zlKjl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AsUx8/vw; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Mar 2025 10:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743000484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xeUr8pi1jeRPBjVWF8zaOS4IrJNw7MAtgeOuC7rRdTo=;
	b=AsUx8/vwPjbbb4SPcOLAD1Oyq5bVqDikcrp620Zrw4gKD3QGFetMyFo6CRasIMl3bXHQz6
	TrN5ndV4i5L7PFkQ3iDhcySCDh+O5JQNe7wrH8hdIyO3oSlNRL4aUaYEM7iBxyQDHk78/3
	eLaBuqebdZPxWlf1gTkU9Ze1r5ohBNc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
Cc: Alan Huang <mmpgouride@gmail.com>, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] bcachefs: replace deprecated strncpy() with strscpy()
Message-ID: <wdagx2vwyv7s2t2tcndwmambwdhmoitvhmnzcopdl3xkfq6ct2@evmzpxnuhi4e>
References: <20250326094449.16473-1-nicolescu.roxana@protonmail.com>
 <5F3AB2BC-43DA-47A6-A07A-72540B327D11@gmail.com>
 <bmjvipermsvb454mdh5zmlmw4gv4oub5fgh4eowedlit75gqei@3or3va3e52ce>
 <MnHJR6KH9EcCqnLtdxKf3XYBSQQbvXWJafG28O2C2itnS_eETVFoDMfVvFva3dkLMZ-LPRWUhG2g_5HBY_lPZkWOYW2aOg_T4YWTrzXmVZ0=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MnHJR6KH9EcCqnLtdxKf3XYBSQQbvXWJafG28O2C2itnS_eETVFoDMfVvFva3dkLMZ-LPRWUhG2g_5HBY_lPZkWOYW2aOg_T4YWTrzXmVZ0=@protonmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 26, 2025 at 02:40:22PM +0000, Roxana Nicolescu wrote:
> On Wednesday, March 26th, 2025 at 1:19 PM, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > On Wed, Mar 26, 2025 at 06:02:31PM +0800, Alan Huang wrote:
> > 
> > > On Mar 26, 2025, at 17:44, Roxana Nicolescu nicolescu.roxana@protonmail.com wrote:
> > > 
> > > > strncpy() is deprecated for NUL-terminated destination buffers. Use
> > > > strscpy() instead.
> > > > 
> > > > Link: https://github.com/KSPP/linux/issues/90
> > > > Signed-off-by: Roxana Nicolescu nicolescu.roxana@protonmail.com
> > > > ---
> > > > fs/bcachefs/btree_trans_commit.c | 2 +-
> > > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/bcachefs/btree_trans_commit.c b/fs/bcachefs/btree_trans_commit.c
> > > > index c4f524b2ca9a..7ab25b425d11 100644
> > > > --- a/fs/bcachefs/btree_trans_commit.c
> > > > +++ b/fs/bcachefs/btree_trans_commit.c
> > > > @@ -364,7 +364,7 @@ static noinline void journal_transaction_name(struct btree_trans *trans)
> > > > struct jset_entry_log *l =
> > > > container_of(entry, struct jset_entry_log, entry);
> > > > 
> > > > - strncpy(l->d, trans->fn, JSET_ENTRY_LOG_U64s * sizeof(u64));
> > > > + strscpy(l->d, trans->fn, JSET_ENTRY_LOG_U64s * sizeof(u64));
> > > 
> > > The last time I asked Kent about this line, he didn’t want this.
> > 
> > 
> > Yes, the destination buffer isn't required to be nul terminated.
> > 
> > But it seems we should add a comment explaining that :)
> 
> I should have checked the mailing list before, but I will keep this in mind for my next contributions.
> I wonder if we should use memcpy in this case. This is also recommended by the security team here https://github.com/KSPP/linux/issues/90
> This will also prevent other people from trying to send a similar patch in the future.

Or better, a new helper: when we're copying to a fixed size buffer we
really want to zero out the rest of the buffer - we don't just want a
single terminating nul.

This has come up in other places in bcachefs, see __bch2_fs_log_msg() in
btree_update.c, and I would imagine the code for updating superblock
labels as well.

