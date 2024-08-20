Return-Path: <linux-kernel+bounces-294674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E395913B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1541C225CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A5D1C8236;
	Tue, 20 Aug 2024 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h+cGN+vM"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B314D2A3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724196867; cv=none; b=tZx/93rnw7Mc49m8Zn5aBDsIGT5K4/eDArGsXg3Pj5lLuxXc9i4LTdZ0uHURGqgGUeQEshueGWubTVSPexDxoYz7orRibZECkPoRXnOR2GO9WpsmyiVIuNYZkZJL5zvEPQvTqykjdm3rYX6S6KDQ2ZvpyvMR0kc9Rh6/tBfl1F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724196867; c=relaxed/simple;
	bh=syn+XDhv+5W5sGaxvkCD1Cf/uLhSBsAomgMfjeFIlqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF+n+KCQ5J8k6RWA2iM3BzuJeU+UU69+1y2OHS37MYRVoujfdUhgu/GudGYZYj3gD+SYyyOsQpiGj3PUd7br7yFH5i+WNi8QRibP8KH45IohvTaD3/0rdJbn+S/inQ0RzaPfM/9a9pRzPuOoM8920l6B9dL2dAcx+e2vl32dLlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h+cGN+vM; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Aug 2024 19:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724196863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yjri1bvpCDcJTfjHDDEUJmZWU96ylEGFys1S9b6VxAQ=;
	b=h+cGN+vM5RvmWRXMMUY2ZLWUL+DmojfJ7M3Jo/2vnjPFzrF8nEWFxbKz4WaevZZsnEfFlO
	pLZ2NchbHX/81OwfR8YDO+LgHldA/606Wp1FjiBiNsrYiIQyto1zrDVA0mJLL9BSHY+F+s
	cuYNQxQ+iostCqIjd0KdJtQZZ0ZduBw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] bcachefs: Add journal v2 entry nr value check
Message-ID: <rtuy45ppvbi7yoighz2uvxwauotsyt5jr6kwfp4bsp2g43f342@k4hnm3xmqotz>
References: <m5tgdpvt4bzaikdmhlxzwrceww5vh5b237qesdosf6nn4hyhan@4brk2v5w26u4>
 <20240820071145.1109560-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820071145.1109560-1-lizhi.xu@windriver.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 20, 2024 at 03:11:45PM GMT, Lizhi Xu wrote:
> When journal v2 entry nr overflow, it will cause the value of ja->nr to
> be incorrect, this will result in the allocated memory to ja->buckets
> being too small, leading to out of bounds access in bch2_dev_journal_init.
> 
> Reported-by: syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  fs/bcachefs/journal_sb.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/bcachefs/journal_sb.c b/fs/bcachefs/journal_sb.c
> index db80e506e3ab..db2b2100e4e5 100644
> --- a/fs/bcachefs/journal_sb.c
> +++ b/fs/bcachefs/journal_sb.c
> @@ -119,6 +119,11 @@ static int bch2_sb_journal_v2_validate(struct bch_sb *sb, struct bch_sb_field *f
>  	for (i = 0; i < nr; i++) {
>  		b[i].start = le64_to_cpu(journal->d[i].start);
>  		b[i].end = b[i].start + le64_to_cpu(journal->d[i].nr);
> +		if (le64_to_cpu(journal->d[i].nr) > UINT_MAX) {
> +			prt_printf(err, "journal v2 entry d[%u].nr %llu overflow\n",
> +				i, le64_to_cpu(journal->d[i].nr));
> +			goto err;
> +		}

no, you need to sum up _all_ the entries and verify the total doesn't
overflow UINT_MAX

