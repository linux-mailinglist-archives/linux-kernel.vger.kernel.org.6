Return-Path: <linux-kernel+bounces-512396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BB7A338BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8413A6783
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558E52080EE;
	Thu, 13 Feb 2025 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MrMcJV6g"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B2D20766B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431300; cv=none; b=lVWf1naWoP6I/8CCm5YK7E0X18vOELJRFJ3TY1EQKLb1F43H3lG//tjq1MsOcO9X0U3Q45OXPvOcvrrJJyaLueiUCjrsjIYLjscbSJ6J/znaxeqPjOzp3V57H9prfWavfL30Es+I42UqHiFiewMJoiOOeMzoqoSBM3zyhnAfO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431300; c=relaxed/simple;
	bh=GE8T84RxcCWKKCHACB70lEaGn9zzdUJ584guTWIe8ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKB02x/0NwrryWWUqKpbTL+h1j97yo5ggMvzpLkGeF7of9tt7//Cn2/RxYxhg3YoDFchAKZyizuzxjDKIfFOhHKX/NlYJsyKALGS7/qgGuW75q9c76Kr4dd4TZzMKL9rcmVzgdFbuBibdFgmAsPeelEyEBu0C1hIrZ8fQUxDz+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MrMcJV6g; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d398bea9so7229075ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739431298; x=1740036098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BU3EWX6NrO4XjLrf6OxWj7A2H39JQ/DGxsHXZ8vqb08=;
        b=MrMcJV6giunKfCKuBxa1bhC0XUESqdtwh4t1H0APRjEFy6eqTtdZwq5dl/g3wmD+vt
         L4KjTvmU+wT4SAV1xNoqKxThtZaUvXWUloH+lwvXgx1/xPj3JuXlfEuMjJyUhMs6M9SR
         RTKN29ptzYNkiYkWx0hGoAiFqqhb9QiwzavoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431298; x=1740036098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU3EWX6NrO4XjLrf6OxWj7A2H39JQ/DGxsHXZ8vqb08=;
        b=PPyqI0Z4IS75bRGMyB30e7yCHAtSZAqSgr9PYHjMCcD/fwwykP/sG0Q2k8vbpd8Ssg
         9MvbgCzxEpHpcI2+bIKTxYlhrm+0miG7SU+l/AUjmzqPnFi2/ulLJssKf64vumkAgNHf
         lzymvEKVdMmkmzbOIm2IZL8c+YGuP/2npeTjPNs4gasm0UsVAJ+oqYj1ynK4U32vQNRC
         sSYm+5aD+al0cmL3/TnCOb0YYJXpNHIEsqOYw6QKTBEXuSFaVpiIZ2WmYf65Wuih6+58
         rqD3opiMLRGMXhWBUKDiimvPQGjtWLldfn7hqpzNc4FS2rguY6EhYiIAoTMT9zOn2R0p
         +zVA==
X-Forwarded-Encrypted: i=1; AJvYcCX/jOdfi4UPIUqQgPyvfGFPtyaZius0zPGS/Vs+2WUXcUVOvvg7LSa4ikXuLgo4CZgxzKs380OVJ2BssJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAJ0ZApwNeq3H8gZrMRrHHYpoM8ctcwB1JTm4Tk0+LIM4G9gx
	WisT2Ylbf2LQUSgexxBN4u8yQWWDgbieeAc/MBgTfB5ss5gDbmFJDcm+X+C0bw==
X-Gm-Gg: ASbGncsm85LsFKRPTeQ7xjA44K1yVpTWftFOTMqXBGgtr2HEyUfL8DjZIG1tXqOmlpG
	cE8cYA1rYE8JO1lRpbM/IzZKb4ES6aVrEiFCxJh/4M8mi59gj/wplh+HwbOn+rOIkmY5ob5KVsI
	j1yQuSybOWuD6hWsRdvhnLS50CxzHeOqOkT6kOvkzirQOPltAzHJirF6ZqhvABzn5287WiqCp2m
	cEjlUgHlcx7VNMddVI3ByycCbcSNE/548aid/jhsTlKg4vNi2D+Anp3qC4cpw7KURoKTQOkUhCU
	N4MdMMMjH9kfsZMXnOs=
X-Google-Smtp-Source: AGHT+IGrrMRSC9vH8hDZG+Sr73gos+a8WvcZbQzmGErKu6FhLXQnnI1jbWLKVzxORygaoGElOvivdg==
X-Received: by 2002:a05:6a21:78a8:b0:1e1:cdff:5f18 with SMTP id adf61e73a8af0-1ee5c72e4f4mr10509093637.4.1739431298139;
        Wed, 12 Feb 2025 23:21:38 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3ed3:97ce:5f5f:1f61])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb57c5e00dsm573320a12.12.2025.02.12.23.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 23:21:37 -0800 (PST)
Date: Thu, 13 Feb 2025 16:21:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCHv4 14/17] zsmalloc: make zspage lock preemptible
Message-ID: <huhxeq3k4q5lscj5xy6lldivku2wps6midxmt4swr67mce4nva@7mxupdxphs5a>
References: <6vtpamir4bvn3snlj36tfmnmpcbd6ks6m3sdn7ewmoles7jhau@nbezqbnoukzv>
 <Z6O2oPP7lyRGXer_@google.com>
 <6uhsj4bckhursiblkxe54azfgyqal6tq2de3lpkxw6omkised6@uylodcjruuei>
 <Z6ThGFt6wyNpx9xi@google.com>
 <wnffho5jguo24wfy3qv5tvovoargezbu4kcvpk43ludrhyfo6i@6ogtvk5ivfjc>
 <Z6Z2l9uovxAiED6q@google.com>
 <droaoze6w4atf7guiv6t4imhcmkpteyvoaigdnw5p3vdg75ebx@m56xi2y527i4>
 <Z6y_3xS_8pmZ2bCz@google.com>
 <rbco2k74plqedtqvn6ebu6wwssy5urw5mjvsk6n576d3urbjnx@tq43anmdvq35>
 <25268fbedb82a06ba0c13e2c490b164846ef508b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25268fbedb82a06ba0c13e2c490b164846ef508b@linux.dev>

On (25/02/13 02:57), Yosry Ahmed wrote:
> > > I think we also need some high level testing (e.g. concurrent
> > >
> > >  swapins/swapouts) to find that out. I think that's what Kairui's testing
> > >
> > >  covers.
> > >
> >
> > I do a fair amount of high-level testing: heavy parallel (make -j36 and
> >
> > parallel dd) workloads (multiple zram devices configuration - zram0 ext4,
> >
> > zram1 writeback device, zram2 swap) w/ and w/o lockdep. In addition I also
> >
> > run these workloads under heavy memory pressure (a 4GB VM), when oom-killer
> >
> > starts to run around with a pair of scissors. But it's mostly regression
> >
> > testing.
> >

// JFI it seems your email client/service for some reason injects a lot
// of empty lines

> If we can get some numbers from these parallel workloads that would be better than the perf stats imo.

make -j24  CONFIG_PREEMPT


BASE
====

1363.64user 157.08system 1:30.89elapsed 1673%CPU (0avgtext+0avgdata 825692maxresident)k

lock stats

                              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
                   &pool->migrate_lock-R:             0              0           0.00           0.00           0.00           0.00          10001         702081           0.14         104.74      125571.64           0.18
                            &class->lock:             1              1           0.25           0.25           0.25           0.25           6320         840542           0.06         809.72      191214.87           0.23
                         &zspage->lock-R:             0              0           0.00           0.00           0.00           0.00           6452         664129           0.12         660.24      201888.61           0.30
                &zram->table[index].lock:             0              0           0.00           0.00           0.00           0.00        1716362        3096466           0.07         811.10      365551.24           0.12
                            &zstrm->lock:             0              0           0.00           0.00           0.00           0.00              0         664129           1.68        1004.80    14853571.32          22.37

PATCHED
=======

1366.50user 154.89system 1:30.33elapsed 1684%CPU (0avgtext+0avgdata 825692maxresident)k

lock stats

                              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
                         &pool->lock#3-R:             0              0           0.00           0.00           0.00           0.00           3648         701979           0.12          44.09      107333.02           0.15
                            &class->lock:             0              0           0.00           0.00           0.00           0.00           5038         840434           0.06        1245.90      211814.60           0.25
                         zsmalloc-page-R:             0              0           0.00           0.00           0.00           0.00              0         664078           0.05         699.35      236641.75           0.36
                        zram-entry->lock:             0              0           0.00           0.00           0.00           0.00              0        3098328           0.06        2987.02      313339.11           0.10
   &per_cpu_ptr(comp->stream, cpu)->lock:             0              0           0.00           0.00           0.00           0.00             23         664078           1.77        7071.30    14838397.61          22.34

