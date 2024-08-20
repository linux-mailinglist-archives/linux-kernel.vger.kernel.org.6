Return-Path: <linux-kernel+bounces-293250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 050C3957C85
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EDE1F25283
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253145EE97;
	Tue, 20 Aug 2024 04:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LF3Zb4lb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB4928685
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724128857; cv=none; b=TvMdxPXBEC+LtFsvnM8ee4lekTAJL+ZdKT5EQx6I1nCttJ8sn9nghZNTMOa8GCEQPPgCla8uyN7ot+VCl+7yCqXJwTo9tcSwvPbGu+2N3pVZ43HyHCfJe8hV87mtSH0wCG5iyybt8y8yA7GBKB3xho9G1+wRiqfoIzebT2PL01Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724128857; c=relaxed/simple;
	bh=lxLBe2HRcNF7J8oGCvBcLAykY2824pBpNcSJqIMsKAw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TTZvPQtmPfUBpBYuD2/tT0RYb+GHy2IKCh+JZUeAzeBcVRnArSBRXKWaykhSB+QpLJ7N1M/MJPr2t5x1FhAfu/Sx4TX3HTAnkN128p61C+NUMB+ojtmtA8/K9vQ7jG88OxnCqrtBu+sf2GNPN6gaZemWvgN9ABrIwHoMdHo//9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LF3Zb4lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543ADC4AF09;
	Tue, 20 Aug 2024 04:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724128856;
	bh=lxLBe2HRcNF7J8oGCvBcLAykY2824pBpNcSJqIMsKAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LF3Zb4lbY0O8p4DrLSfOhMM1rZkVKt4aHHqhnOwYe6T139vDoAmT/P1JH75hGxHja
	 eRw7xPe9eZPktzkPYD+ZPSRBm6xKolHNlTdUclLsiXxdl07OZ6zEk3q7rDuWvej2Jd
	 nqh08eM2j4y8+zMN+qJ97WsxIjqpINCvHtkYlvnw=
Date: Mon, 19 Aug 2024 21:40:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: alexs@kernel.org
Cc: linux-kernel@vger.kernel.org (open list), linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: skip less than check for MAX_NR_ZONES
Message-Id: <20240819214055.978b33eae88004d35b9ce634@linux-foundation.org>
In-Reply-To: <20240819112628.372883-1-alexs@kernel.org>
References: <20240819112628.372883-1-alexs@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 19:26:28 +0800 alexs@kernel.org wrote:

> From: Alex Shi <alexs@kernel.org>
> 
> Remove unnecessary '<' check for ZONES_SHIFT assignment.
> 
> ...
>
> --- a/include/linux/page-flags-layout.h
> +++ b/include/linux/page-flags-layout.h
> @@ -14,7 +14,7 @@
>   */
>  #if MAX_NR_ZONES < 2
>  #define ZONES_SHIFT 0
> -#elif MAX_NR_ZONES <= 2
> +#elif MAX_NR_ZONES == 2
>  #define ZONES_SHIFT 1
>  #elif MAX_NR_ZONES <= 4
>  #define ZONES_SHIFT 2

mmm, why.  I think it looks more logical (and certainly more
consistent) the way things are now.


