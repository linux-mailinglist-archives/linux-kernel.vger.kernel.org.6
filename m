Return-Path: <linux-kernel+bounces-513263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473B1A34714
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D0916C9A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1615214A605;
	Thu, 13 Feb 2025 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DIs7JKMt"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A268114658D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460332; cv=none; b=ReKF/A+1gG94B6U8aSMkzGX3IIX9sbVuE/cWMd7aEOs5iWdMqc/xNJ5frijGmJhFEseIRLFyyZRlWkQcjoiX1uF+T+l/RTX0Bf6VtKorvwR7coosxZQbAwElGGbfl2KuexKgsFzqJp2RMqBY/inJyX378DMECx1KtRQM/RSKVOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460332; c=relaxed/simple;
	bh=47MX4lxq18x870VrivuXRInAcdpWr6+m9NQ2x2mmm4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U00g/s5+XjXxU8BaG/P57cZhJMwJ2pBqbk10pQDq+1q4hmfRVu5ixoCOsLhIJVVd3NkZvTaUgxQIc0steZv+EgaefV2t0xEJjHPcdn5TxS9faxVw6RyGb3W8bljjvUBgU0C0EVGlxKm5EzcZLlqIXmsfMDatbQmB1GLyilNzVF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DIs7JKMt; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Feb 2025 15:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739460326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qn2aq+FZ3Hyqy2TbNenZIG+7osbs9ZE4AKyqzZGbbyw=;
	b=DIs7JKMtT/YsgYOIQdrgvaPADhWvCup7aZLxJ2zgyVcB3izlX78OSJl+ACBmh0MhI3Rwaq
	BLF37xY4f/7vnNOdhOx1S9ULcX+GEW6jwj+E1oaGNOoBzcMqqHLiDHrC9Ov6cGmiKNLqpi
	ujNrnsjYiy/tZxWUdw/g1BtppKJAgC8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCHv4 14/17] zsmalloc: make zspage lock preemptible
Message-ID: <Z64O3w2p1NrXoicl@google.com>
References: <6uhsj4bckhursiblkxe54azfgyqal6tq2de3lpkxw6omkised6@uylodcjruuei>
 <Z6ThGFt6wyNpx9xi@google.com>
 <wnffho5jguo24wfy3qv5tvovoargezbu4kcvpk43ludrhyfo6i@6ogtvk5ivfjc>
 <Z6Z2l9uovxAiED6q@google.com>
 <droaoze6w4atf7guiv6t4imhcmkpteyvoaigdnw5p3vdg75ebx@m56xi2y527i4>
 <Z6y_3xS_8pmZ2bCz@google.com>
 <rbco2k74plqedtqvn6ebu6wwssy5urw5mjvsk6n576d3urbjnx@tq43anmdvq35>
 <25268fbedb82a06ba0c13e2c490b164846ef508b@linux.dev>
 <huhxeq3k4q5lscj5xy6lldivku2wps6midxmt4swr67mce4nva@7mxupdxphs5a>
 <y6y67njsxrc3orfpqjkj5jsy2jma77mmwhxirt3vb7h6uhlylx@5ftvcrqmjtce>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y6y67njsxrc3orfpqjkj5jsy2jma77mmwhxirt3vb7h6uhlylx@5ftvcrqmjtce>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 13, 2025 at 05:22:20PM +0900, Sergey Senozhatsky wrote:
> On (25/02/13 16:21), Sergey Senozhatsky wrote:
> > BASE
> > ====
> > 
> > 1363.64user 157.08system 1:30.89elapsed 1673%CPU (0avgtext+0avgdata 825692maxresident)k
> > 
> > lock stats
> > 
> >                               class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
> >                    &pool->migrate_lock-R:             0              0           0.00           0.00           0.00           0.00          10001         702081           0.14         104.74      125571.64           0.18
> >                             &class->lock:             1              1           0.25           0.25           0.25           0.25           6320         840542           0.06         809.72      191214.87           0.23
> >                          &zspage->lock-R:             0              0           0.00           0.00           0.00           0.00           6452         664129           0.12         660.24      201888.61           0.30
> >                 &zram->table[index].lock:             0              0           0.00           0.00           0.00           0.00        1716362        3096466           0.07         811.10      365551.24           0.12
> >                             &zstrm->lock:             0              0           0.00           0.00           0.00           0.00              0         664129           1.68        1004.80    14853571.32          22.37
> > 
> > PATCHED
> > =======
> > 
> > 1366.50user 154.89system 1:30.33elapsed 1684%CPU (0avgtext+0avgdata 825692maxresident)k
> > 
> > lock stats
> > 
> >                               class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
> >                          &pool->lock#3-R:             0              0           0.00           0.00           0.00           0.00           3648         701979           0.12          44.09      107333.02           0.15
> >                             &class->lock:             0              0           0.00           0.00           0.00           0.00           5038         840434           0.06        1245.90      211814.60           0.25
> >                          zsmalloc-page-R:             0              0           0.00           0.00           0.00           0.00              0         664078           0.05         699.35      236641.75           0.36
> >                         zram-entry->lock:             0              0           0.00           0.00           0.00           0.00              0        3098328           0.06        2987.02      313339.11           0.10
> >    &per_cpu_ptr(comp->stream, cpu)->lock:             0              0           0.00           0.00           0.00           0.00             23         664078           1.77        7071.30    14838397.61          22.34
> 
> So...
> 
> I added lock-stat handling to zspage->lock and to zram (in zram it's only
> trylock that we can track, but it doesn't really bother me).  I also
> renamed zsmalloc-page-R to old zspage->lock-R and zram-entry->lock to
> old zram->table[index].lock, just in case if anyone cares.
> 
> Now bounces stats for zspage->lock and zram->table[index].lock look
> pretty much like in BASE case.
> 
> PATCHED
> =======
> 
>                               class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
>                          &pool->lock#3-R:             0              0           0.00           0.00           0.00           0.00           2702         703841           0.22         873.90      197110.49           0.28
>                             &class->lock:             0              0           0.00           0.00           0.00           0.00           4590         842336           0.10        3329.63      256595.70           0.30
>                           zspage->lock-R:             0              0           0.00           0.00           0.00           0.00           4750         665011           0.08        3360.60      258402.21           0.39
>                  zram->table[index].lock:             0              0           0.00           0.00           0.00           0.00        1722291        3099346           0.12        6943.09      721282.34           0.23
>    &per_cpu_ptr(comp->stream, cpu)->lock:             0              0           0.00           0.00           0.00           0.00             23         665011           2.84        7062.18    14896206.16          22.40
> 

holdtime-max and holdtime-total are higher in the patched kernel. Not
sure if this is just an artifact of lock holders being preemtible. 

