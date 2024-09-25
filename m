Return-Path: <linux-kernel+bounces-339617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDFC9867DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F7B1F257CE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E7E154C15;
	Wed, 25 Sep 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rN6nfYWX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F01130E58
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727297472; cv=none; b=QGUqd/BUdrC+CYIye95KH8WltK4OogGlipCMh9WM3JscgeqhbIy++mFu/8fwiS2rG2w98Ajgykm+87WS5xWBgFM7H/dp8mIsKwfGsFacGKe/gsAfWckTkkjhGei3+v61ieH8CKjkLWMXQVYm9L3/djcFXRWpFH3slMy8gphx4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727297472; c=relaxed/simple;
	bh=YjI364IwGFp7fSAZmhwGwSO6y7Xxx/BQNQLBXZyxl8Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CvNIbLVmV2ofN0HgxS52lfsW9RJljA5pLMrajqxzceNrQETFbw4u/WnfsDF0bj4YXys7a9dVMMbf5yVACWLRgCB/oZNhEgRF43RzzP3dtDXcpkqZB0tVQb+pGY8oPIJwZaAWVKTIN1oFEnBQ5psfq7OCjhhaRcMkeWL59ZWjigw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rN6nfYWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5451C4CEC3;
	Wed, 25 Sep 2024 20:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727297472;
	bh=YjI364IwGFp7fSAZmhwGwSO6y7Xxx/BQNQLBXZyxl8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rN6nfYWXa6A8OwG98JwxNdimUmeTuLBDije5l3qJbbm0bOKzBefkWcxrg3l32N7kK
	 6fjf/6VCdgQaNhdU06FfL7sIVFlcjwK4uc9JDUNfGMNCp3yfRhUxQ8C0Kkd5aD2J2c
	 o98Jgw4ooUtiM/TGWMrPsR73bMFIvpQ9YidFhECA=
Date: Wed, 25 Sep 2024 13:51:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
Subject: Re: [PATCH] mm: fix shrink nr.unqueued_dirty counter issue
Message-Id: <20240925135111.4a82c0a126114d3f8bcc7abd@linux-foundation.org>
In-Reply-To: <20240112012353.1387-1-justinjiang@vivo.com>
References: <20240112012353.1387-1-justinjiang@vivo.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 09:23:52 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:

> It is needed to ensure sc->nr.unqueued_dirty > 0, which can avoid to
> set PGDAT_DIRTY flag when sc->nr.unqueued_dirty and sc->nr.file_taken
> are both zero at the same time.
> 
> ...
>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5957,7 +5957,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
>  
>  		/* Allow kswapd to start writing pages during reclaim.*/
> -		if (sc->nr.unqueued_dirty == sc->nr.file_taken)
> +		if (sc->nr.unqueued_dirty &&
> +			sc->nr.unqueued_dirty == sc->nr.file_taken)
>  			set_bit(PGDAT_DIRTY, &pgdat->flags);
>  

Seems sensible.  Was this discovered by code inspection, or is there
some observable runtime effect?  If the latter, can you please describe
that effect?

