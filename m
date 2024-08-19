Return-Path: <linux-kernel+bounces-291560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88867956412
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53351C21450
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC31156C65;
	Mon, 19 Aug 2024 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BKF3gIbA"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2101459FA
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051141; cv=none; b=LtGsgiHghpbPksuG6U8ptO0q6W/onyex9ey5ZandGK6TsvzW+vbF7RI1aDhqtxdUFsW+BRmHkfFrIloh+AvHkHN5/LPTFspZB8kCje4nnqveWgFI049IpMiYzRjIc1qqR9LeyRXzr8JulOGFa39+PFdM5fAE77aF6Urk28sW44k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051141; c=relaxed/simple;
	bh=T9Y62f2DIIF/V88ldljhigA4Dp8H2X8QqcZNdaf4ZYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1NMV8ZORJdi0Re4zD/+OFzHhbgoNDBHj4xXR7uzKSd99PO+Ify9I2p4Sie1Zl8rzgiI7LpD0fkRxsoRwkY9ZPJCp94fR4gOidVgzPESryKD50ovl+a47vwlwyNWEmvE2LR3wpgbf5XEALlvnyVnMeuJJlMJQhqTN8gKlSrGva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BKF3gIbA; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 19 Aug 2024 03:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724051137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/7Gmrd59qu/7SzqrqUoDXDfHJTJIVrS/Gs1u+PpM7c=;
	b=BKF3gIbAMWpzBdoFQSO1U0435cFaYsFTcOK6HeDbVf4saBmmD9WxvPjZoqKelEu2jU2GOb
	X73z9qN13HkojyaM5XxY/2/LIY+khALJPEM2w/K/AzJdWdADW9gQCLXy5R14njB+HmcOIz
	BCNCR0GZma64G0P0dwPE0dFDwE+QSUk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bcachefs: Fix oob in bch2_dev_journal_init
Message-ID: <m5tgdpvt4bzaikdmhlxzwrceww5vh5b237qesdosf6nn4hyhan@4brk2v5w26u4>
References: <00000000000071b7c5061ff83639@google.com>
 <20240819064754.35606-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819064754.35606-1-lizhi.xu@windriver.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 19, 2024 at 02:47:54PM GMT, Lizhi Xu wrote:
> When journal v2 entry nr overflow, it will cause the value of ja->nr to
> be incorrect, this will result in the allocated memory to ja->buckets
> being too small, leading to out of bounds access.
> 
> Reported-by: syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=47ecc948aadfb2ab3efc
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  fs/bcachefs/journal.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/journal.c b/fs/bcachefs/journal.c
> index 13669dd0e375..d4fb5a23b3f6 100644
> --- a/fs/bcachefs/journal.c
> +++ b/fs/bcachefs/journal.c
> @@ -1307,8 +1307,18 @@ int bch2_dev_journal_init(struct bch_dev *ca, struct bch_sb *sb)
>  	if (journal_buckets_v2) {
>  		unsigned nr = bch2_sb_field_journal_v2_nr_entries(journal_buckets_v2);
>  
> -		for (unsigned i = 0; i < nr; i++)
> +		for (unsigned i = 0; i < nr; i++) {
>  			ja->nr += le64_to_cpu(journal_buckets_v2->d[i].nr);
> +			if (le64_to_cpu(journal_buckets_v2->d[i].nr) > UINT_MAX) {
> +				struct bch_fs *c = ca->fs;
> +				struct printbuf buf = PRINTBUF;
> +				prt_printf(&buf, "journal v2 entry d[%u].nr %lu overflow!\n", i,
> +					le64_to_cpu(journal_buckets_v2->d[i].nr));
> +				bch_info(c, "%s", buf.buf);
> +				printbuf_exit(&buf);
> +				return -BCH_ERR_ENOMEM_dev_journal_init;
> +			}
> +		}

this should be done in the validation code

