Return-Path: <linux-kernel+bounces-294827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024AE95931D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA001C211F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC96F14D2B1;
	Wed, 21 Aug 2024 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R7HEaks7"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A73399F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724209213; cv=none; b=PTEOXhRtRu+epPBC6q9I69jVJRnnMnaY2hhUbtjfIZtSv/q0mfxhHl8ein0nyHtz++zgAQ2uKOvmJoGAx9NmyXZcRDHR2DIuLfCONPgyoerxCwtZnfFsbr2C8WOBiltcDMP9KWY4YQ9y4/4otl2wLdPykH0fCFAQXuozCdU0CTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724209213; c=relaxed/simple;
	bh=CLZ/NIZxhXx1FXyXaXy1vKylUoTXXpbfEmR/+PUQjaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNRiDlIc5u1WxKG/tf3ZBI24uhGhg9Lm4HDbE8dugKruJhl5iklnav07HliTGxsp4pW6ZWDVYCzxjFK/HUcxv9n3jv6We+YU5IjbB/qPdsyAnsC/YhMpfZrK5QDPR1NQnic4FK/6KEYHdNFVghP1vBmdslAOsWQgeO4Um4SEIUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R7HEaks7; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Aug 2024 23:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724209207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2hULG21rclCb9I+HJ9p84QjMIeBzlJa/ANZ4hgOfEjk=;
	b=R7HEaks7ApCj3ddn8tAGXjXJS/S+4MzUX5a5yZvStESg3eclUlYCgMEAVj9acC1Jirlmau
	MIoTNEDzvk5BWW4KIPqXzusbtBa2JzJM+nLHIfSZQMQ1AUL5exRqraXOJLWOQQXwIEneiB
	9qwOVZiUI90rYfhMpm/4JL/uZ5gnKnQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] bcachefs: Add journal v2 entry nr value check
Message-ID: <zdrkmfo2ln2t7e3oh3mz3yr2xs67qm3ea4wfe4fnv6zw4fk4pd@k5peuzfz5ods>
References: <20240821023355.1619187-1-lizhi.xu@windriver.com>
 <20240821025737.1785348-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821025737.1785348-1-lizhi.xu@windriver.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 21, 2024 at 10:57:37AM GMT, Lizhi Xu wrote:
> When the nr value of a signle entry or their sum overflows, it will
> cause the value of ja->nr to be incorrect, this will result in the
> allocated memory to ja->buckets being too small, leading to out of
> bounds access in bch2_dev_journal_init.
> 
> Reported-by: syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  fs/bcachefs/journal_sb.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/journal_sb.c b/fs/bcachefs/journal_sb.c
> index db80e506e3ab..230ed99130e4 100644
> --- a/fs/bcachefs/journal_sb.c
> +++ b/fs/bcachefs/journal_sb.c
> @@ -107,6 +107,7 @@ static int bch2_sb_journal_v2_validate(struct bch_sb *sb, struct bch_sb_field *f
>  	unsigned nr;
>  	unsigned i;
>  	struct u64_range *b;
> +	u64 total_nr = 0, entry_nr;
>  
>  	nr = bch2_sb_field_journal_v2_nr_entries(journal);
>  	if (!nr)
> @@ -117,8 +118,21 @@ static int bch2_sb_journal_v2_validate(struct bch_sb *sb, struct bch_sb_field *f
>  		return -BCH_ERR_ENOMEM_sb_journal_v2_validate;
>  
>  	for (i = 0; i < nr; i++) {
> +		entry_nr = le64_to_cpu(journal->d[i].nr);
> +		if (entry_nr > UINT_MAX) {
> +			prt_printf(err, "Journal v2 entry d[%u] nr %llu overflow\n",
> +				i, entry_nr);
> +			goto err;
> +		}

This check is unnecessary; we know the sum can't overflow a u64 because
we're also checking that the entries are nonoverlapping.

> +		total_nr += entry_nr;
>  		b[i].start = le64_to_cpu(journal->d[i].start);
> -		b[i].end = b[i].start + le64_to_cpu(journal->d[i].nr);
> +		b[i].end = b[i].start + entry_nr;
> +	}
> +
> +	if (total_nr > UINT_MAX) {
> +		prt_printf(err, "Sum of journal v2 entries nr %llu overflow\n",
> +				total_nr);
> +		goto err;
>  	}
>  
>  	sort(b, nr, sizeof(*b), u64_range_cmp, NULL);
> -- 
> 2.43.0
> 

