Return-Path: <linux-kernel+bounces-527252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2616A408DB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEB819C496B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47A0145A03;
	Sat, 22 Feb 2025 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PVjxKF81"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03CB2CCDB
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740233176; cv=none; b=os9AQwfwy/OJ6bAOr7xLQ2cyap9wEJ22Phx378G/cvoMNDu2+t11pSNXpf8sNWBuQuOgrjTbMbcHAaKlZJAaKyWvdEDEWetR2rS8YPXD18q5Zm4VhUBKrloPRiSS1r6KlDlmUHii/OZ+C4jqNSN7D+lnKQQ3WTEuz2RpnRLj6ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740233176; c=relaxed/simple;
	bh=aCEVF1BAhwemJ43M2vwCh6uK7pP+ZrY6ggeYcgnQE1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7cc4/x/l+1Npe4Ps5d/ZuZ0BDSAPX/wlkiJmovtJHAqfIS89yLIe1/lFkClBu2r/m/9wfgU64meKO6kE+U/fhtmN4idJCp5LyYmhZOKBeVnmj/Yl2wiTT+5nGjY+5CD0AXiVPWuoBJngr5i6cQZCynKDi7ZSTL1ZNibO0ld1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PVjxKF81; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 09:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740233162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJZAfuHFSG58xkTLtoZ0BFKFcxsJvIXoeL6Lmp4EeYs=;
	b=PVjxKF816MgY55IapKnt39kqjcOREtN9I9yoRBHxoBFsdjIhMI88XmdMZbHdKK7X5JiyCj
	Zw0KOlRghU9ZgRHZ+qZFMCYpnrQXkVT8LmTqy3CEfEd6nD75+TB/jRoVAGI1PzQ4ujU/jY
	ynkGxys74JyWHqYy5AFWqgWujQYjgDE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Remove duplicate condition in return statement
Message-ID: <f7zphgeldym3m6rdlygmfrzwlgpdqzptvv2bwrq2jotpt2yadp@y7vck65ft3qy>
References: <20250222133100.369710-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222133100.369710-2-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 22, 2025 at 02:31:01PM +0100, Thorsten Blum wrote:
> The last two conditions in the return statement are identical. Remove
> one of them.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  fs/bcachefs/extents.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/bcachefs/extents.h b/fs/bcachefs/extents.h
> index 620b284aa34f..8afcf2c75015 100644
> --- a/fs/bcachefs/extents.h
> +++ b/fs/bcachefs/extents.h
> @@ -703,7 +703,6 @@ static inline bool bch2_extent_ptr_eq(struct bch_extent_ptr ptr1,
>  	return (ptr1.cached	== ptr2.cached &&
>  		ptr1.unwritten	== ptr2.unwritten &&
>  		ptr1.offset	== ptr2.offset &&
> -		ptr1.dev	== ptr2.dev &&
>  		ptr1.dev	== ptr2.dev);

Actually should have been checking gen:


From b0e5e78f7e890c48b69e24d19e82597daa2d9cf0 Mon Sep 17 00:00:00 2001
From: Kent Overstreet <kent.overstreet@linux.dev>
Date: Sat, 22 Feb 2025 09:05:36 -0500
Subject: [PATCH] bcachefs: fix bch2_extent_ptr_eq()

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/fs/bcachefs/extents.h b/fs/bcachefs/extents.h
index 8fae6b23a341..ed160aaa9546 100644
--- a/fs/bcachefs/extents.h
+++ b/fs/bcachefs/extents.h
@@ -704,7 +704,7 @@ static inline bool bch2_extent_ptr_eq(struct bch_extent_ptr ptr1,
 		ptr1.unwritten	== ptr2.unwritten &&
 		ptr1.offset	== ptr2.offset &&
 		ptr1.dev	== ptr2.dev &&
-		ptr1.dev	== ptr2.dev);
+		ptr1.gen	== ptr2.gen);
 }
 
 void bch2_ptr_swab(struct bkey_s);

