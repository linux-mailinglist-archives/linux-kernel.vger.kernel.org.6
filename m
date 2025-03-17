Return-Path: <linux-kernel+bounces-564885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2646A65C42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A00E17D80B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A691C8627;
	Mon, 17 Mar 2025 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="yZlwgGe5"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74EE1C6FEA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235541; cv=none; b=r5wl2tojvlvdcxRbFAF7hiWGDzoYHRQ1dJ8dXtPWh4BlTz5m+GbnjQuw4pd3jKRCwcviMzzqbaGWrMYiohXSBYksuiIu7Ra/u+rtEQjCWWfnkmaMgcxnbH/kFRZx6vgQECp6Ck5trQillZBNK1kEIPGfe08CJsyJtIArrfISxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235541; c=relaxed/simple;
	bh=XY35LuhQF+cA/uKthhJz6fw6a4pFTwgy5cet0LYLh4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZz5EY8cLDVyONmYpq2vGzGg47r8i6D9GBG3s0oxeLEfSZeJz8+25nm8o9v+rQEUosh0hsgSiVf6NKg9OTxgKKRlyD8hCn8jWD1PfRo4gLJnYaJdudJ0MIVJmsb1sj62uE1oADEz0WmAcakZ+tPMWDOGc4A0Wwvtf1xULocKbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=yZlwgGe5; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c04df48a5bso467341785a.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742235536; x=1742840336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs5FRMsdqp/BT81c+IUYvUcJpd3cBpM8V6qAiLgpjPs=;
        b=yZlwgGe5fmZ9wq0fRgXfLtveE+dzXBs8x8G7Eix+lkG3pyfphChQ5u3jD8A3AmFhdr
         0jRMDt4L7Uc2hhmT2ccehYEY7YaaDvq1mOHh8GK/aJ7roAp9a7e6s/tzV5vhX5UrHo9b
         yLNOJgAY9mjHGnpWaObyB4yJqjg6AG1w8kkhqVVB8OEGZstpzanouVF9dKAW6SWpfScp
         CurOLP4Zq5aQp+Q43aYNfLWWJboaAzIFUPp5MMbLK7HyGCV6+5jH+TuEicdbJlMvPkCA
         z4qDKG9ZcZUlH1Qkubb5jclF4l30QOP/gZDMe0hSf/z08V/cS+swBfGBsSAfOofKu7PT
         Z2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235536; x=1742840336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fs5FRMsdqp/BT81c+IUYvUcJpd3cBpM8V6qAiLgpjPs=;
        b=p9adea9FwxJL7X7sh/QNSMJRuoJ7zqlh8Ko6UmNPBuNXRjoItFsVoELTsvn1wikOtm
         kvKEXkKgK6WWLeMhLFEyz9JzUlpjhnsBTxWXc8HqHRFPudIV7I9p0CLMIAOrorlZCY2Z
         Vvni5cEj8JV1meqnCW9Ilm+eRvs5Tiir4T1Qwka7masy+LIbjbHhWjdFFwBUeFPN0BPf
         JvJgJ3YpattsJiasqpdyOwjFmgxdDwg64l0c1yHfHdTNR4frdPLWbg8h2kMpfQ7d+TjX
         uMT87BbCtr2WknOZFEduqN/iJ1LeQKh19lXNcIiujEs8xYm9Cftdat9QuHriQc5WCIGc
         jk2A==
X-Forwarded-Encrypted: i=1; AJvYcCXbGPZj/ffyvhrGB11GSHcP0sBVZkBEYZwImhvndXUPlAZQd8ZT6C7hU1iun5qKt3oR0Snt9LznMzUd++c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+lkD9M3Xeh8EPXIrDjljjKD+XHnqlPQXrnNdE8Sl1BwrQr7k
	V7SrHm7enQEDRLIW02BWLUuItIXVXnZUVnNjOFL4x2UFSpwPKP1cHN9s3bzt81s=
X-Gm-Gg: ASbGncuvCIuvcxjOV4oRn4+QeIUMorOAuR3WRPBIgb0594tKS4pbu48PAvtL0OUIOJV
	aYF1R0DqeqGhKIi4jDPtdNHz+lNHZm3c7TxreFpNie6PYpkJDgIaLwzecB8pVVRrfz0uHr405Wa
	N3sW5UdrlqBy4fAQAWp7MTfAcodyc8jO9yrnx2rgnXKv2Hb6yPHGcX1LKe1T+gqia5pc8C5yN3j
	Y9dKpwEa0a3zhxu+ZS4/JlUS1zbnH9P9ve3f1/1tZME90A8D3a8IcQnnpSWDpFiaVVOA64zgEme
	p31vcIWwnAgccTw5x36hs6XStyFOncKRFLNplCKAyqwCO6uwwfKhpA==
X-Google-Smtp-Source: AGHT+IGDO7z/jJycwpThPXWNMRYFlUkK/xin8Ffvpsmfo+RNv6m+nTJPfrYCHQRCo7pCvqqjyD58VQ==
X-Received: by 2002:a05:6214:1d25:b0:6e8:9086:261 with SMTP id 6a1803df08f44-6eaea996d8dmr195571526d6.3.1742235536659;
        Mon, 17 Mar 2025 11:18:56 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade254502sm57587546d6.59.2025.03.17.11.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:18:55 -0700 (PDT)
Date: Mon, 17 Mar 2025 14:18:51 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@compxchg.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: compaction: push watermark into
 compaction_suitable() callers
Message-ID: <20250317181851.GA1694060@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
 <20250313210647.1314586-2-hannes@cmpxchg.org>
 <005ace8b-07fa-01d4-b54b-394a3e029c07@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005ace8b-07fa-01d4-b54b-394a3e029c07@google.com>

On Sat, Mar 15, 2025 at 09:28:16PM -0700, Hugh Dickins wrote:
> [PATCH] mm: compaction: push watermark into compaction_suitable() callers fix
> 
> Stop oops on out-of-range highest_zoneidx: compaction_suitable() pass
> args to __compaction_suitable() in the order which it is expecting.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/compaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 4a2ccb82d0b2..b5c9e8fd39f1 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2433,7 +2433,7 @@ bool compaction_suitable(struct zone *zone, int order, unsigned long watermark,
>  	enum compact_result compact_result;
>  	bool suitable;
>  
> -	suitable = __compaction_suitable(zone, order, highest_zoneidx, watermark,
> +	suitable = __compaction_suitable(zone, order, watermark, highest_zoneidx,
>  					 zone_page_state(zone, NR_FREE_PAGES));

Ouch, thanks for the fix Hugh.

This obviously didn't crash for me, but I re-ran the benchmarks with
your fix in my test environment.

This affects the direct compaction path, and I indeed see a minor
uptick in direct compaction, with a larger reduction in daemon work.

Compact daemon scanned migrate        2455570.93 (    +0.00%)   1770142.33 (   -27.91%)
Compact daemon scanned free           2429309.20 (    +0.00%)   1604744.00 (   -33.94%)
Compact direct scanned migrate          40136.60 (    +0.00%)     58326.67 (   +45.32%)
Compact direct scanned free             22127.13 (    +0.00%)     52216.93 (  +135.98%)
Compact total migrate scanned         2495707.53 (    +0.00%)   1828469.00 (   -26.74%)
Compact total free scanned            2451436.33 (    +0.00%)   1656960.93 (   -32.41%)

It doesn't change the overall A/B picture between baseline and the
series, so I'm comfortable keeping the current changelog results.

