Return-Path: <linux-kernel+bounces-268383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D149423F8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CF8BB234B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D25846F;
	Wed, 31 Jul 2024 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cPT8PPFu"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2CE46B5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722387176; cv=none; b=UnCyKTddKv1zYsrNOY5p3agcOSs8BrvACm/3pZFUTb4MDFUH7EOq3dmoF5BJZYJurpe1YPVelaRLJ2dmAVsMSjS5PdUXOqoexQ9+oL//bUzdM/XamQ+0/ckIs7l2v5OeN32kvs6vuUzAfNvBUuNe+obBwrV9farYgAh/QcOAXn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722387176; c=relaxed/simple;
	bh=RFzBDEACN54BlktdwPVLsaXYKHqevn8Ah3qOD6p3lVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7o/CJ21GWNQa+hi+WMRkYkxHcG+SLKc5eiQOQvHIWbnFaYDBaLyX+Fw64uEI6Ma6kJ3e5h9tJcxjKwH5nInKgRTXNwqJfHVze31awH1c7FLrELEti8oV66Uqm3sUXxkwm/0wJte64uqAce72v/KHQcqTBE6LUtOE+bNsK3yXBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cPT8PPFu; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 30 Jul 2024 20:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722387172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QdOSEkeUenRtcbHdw9g4dXOoiO0ucmftbM8CCNfxNnE=;
	b=cPT8PPFuUL/funWQ6votzxwr0H5FXftlOS+Uv2sTnM0jARnERS8SgUFIqDTICep4theyTS
	jKsB9vIPE9/Gr6+7rPNExFF924QL2KWQAZ9Hey1WpD2DGuSfqad9jch9ehtHnYR6QYgEqm
	EXlSDOlkBJM2av5R7kx86ypnbbXotDg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+05d7520be047c9be86e0@syzkaller.appspotmail.com, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bcachefs: Add checks for entry's _data bytes
Message-ID: <apj4zcnnq5nwcly4mnl76uiuwibkzayqd3beeum3p436kycksf@co4yrhzxo7kl>
References: <000000000000b2c0fc061e6cb26b@google.com>
 <tencent_3D4E4FB18DDDA5988DE9920ADDDFDD859907@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3D4E4FB18DDDA5988DE9920ADDDFDD859907@qq.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 30, 2024 at 12:10:19PM GMT, Edward Adam Davis wrote:
> syzbot report slab-out-of-bounds in journal_entry_dev_usage_to_text,
> it because vstruct_bytes(entry) smaller than sizeof(struct 
> jset_entry_dev_usage), overflow occurs when calculating the difference in
> jset_entry_dev_usage_nr_types(u).
> 
> Reported-by: syzbot+05d7520be047c9be86e0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=05d7520be047c9be86e0
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/bcachefs/sb-clean.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
> index 47f10ab57f40..278e1a25159a 100644
> --- a/fs/bcachefs/sb-clean.c
> +++ b/fs/bcachefs/sb-clean.c
> @@ -310,6 +310,9 @@ static void bch2_sb_clean_to_text(struct printbuf *out, struct bch_sb *sb,
>  		    !entry->u64s)
>  			continue;
>  
> +		if (vstruct_bytes(entry) < sizeof(struct jset_entry_dev_usage))
> +			continue;

This is wrong: you haven't checked the entry type and you're assuming
it's a dev_usage entry.

The check should go in journal_entry_dev_usage_to_text().

