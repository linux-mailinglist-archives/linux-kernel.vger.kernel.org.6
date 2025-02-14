Return-Path: <linux-kernel+bounces-514303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEDAA35554
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043DB7A49B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E21519AC;
	Fri, 14 Feb 2025 03:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eM5kZLib"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0706D8837
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739504022; cv=none; b=W7OEon5LGkwKlj+Fuey0AXpVP7tm13KVUU6irUUpySiupxyhMpLd4wBeclJe+Wc0T8vJU1ESOUp3skeTrYycDrcqiqvovs0a8VtM9hz6Twm3e56T8m/x8TaJH7PkQ7uKjWIaVc8vgNAVPhJgh1Y9RXaDeGCCutYJpfvt3/6jSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739504022; c=relaxed/simple;
	bh=3CP6vNBG5tNZM6/S8Q8LiID/LtJNbg0Lf7gVE9Ngjdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxj9gnTY8hu130hzZskb6cGAUVeks148zwwWDZXUhYekRbd5DCQedpl4rFyy5yVVxUWVfZx1EUKa30KAWzduaDosnci5ZbCbvMByYdssnrEydwkWdZGUFSXst9l2r4idG0QIIakYyYPZZeTycZcW1wPgHBQSzkSD3NRAM68Sm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eM5kZLib; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f6d2642faso41682385ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739504020; x=1740108820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWwj1KR66ci0MimMVTAf+7EryvAhOmVMzbLfi/0Mh9s=;
        b=eM5kZLibMmKK3ZxBGh5/cfi1EuK7cjMfsP7va6tE8k75znruEhIDNdrgk78+1rhgs5
         kSvAMxT2ufODgEWntsYrE/kFiAF/YOKOl+5akVg6VQYuAzq2qGt40zz/4epBMi4bz3kJ
         uzeG7tTdWX1KUYnzGeOd4xeRK8+AuDYXJgvYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739504020; x=1740108820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWwj1KR66ci0MimMVTAf+7EryvAhOmVMzbLfi/0Mh9s=;
        b=Y9GUWxFTnuPRzEXJakeosVFT7s/OoCpIH48ZPuh3dfwf25cmqlmZll8Wb//UEiEt5/
         LDGRhyFO4PCnh/M3tC7cpOLOcDoPh8SWE9buXiEwQj8sZd0oa2860fJsYJ6GRQDv1Mz6
         lzsyGwT5QQwQVQzB51qD4PG+sl0lAgF9VmdZlYzdf5cEkMJMZnjzLjGcnox3xlV4LQ9Y
         d4EXTYyQNwEQ8Z/lNWlMagY/6/CuZIP0jTSAYLzKpu0zvtI2nHqet2jVM/C5RDKQIGkm
         hZwYC9as+RORaZIefyoQqqfEsr3NBMgQcAgtoHcwrxHGsbKJKKYeElma0j7bMNb3NvAP
         l8lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUjE9/0VtTHQqwKBa3rAOwOjABDW2rf6XCfx2H769fqaH32y8tbK1Wh71ou31+GHTkyaqKq1S43lld4S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyekszbNYIEeSa0E5qZzUZwWoeXqSLRVnrbBvdCs8w6VNFyzzSy
	2vQV/W43uA7Cn0V8TSrZUVqQpT7S0BVvOxi8YwSoZc30uXHy3zsRgPD06nd+BA==
X-Gm-Gg: ASbGncup6/ZimttMWJQYiKpq1sjj4ut6Q478bJs35Qs2QhhlQp5HJbrJas5bJVLncPe
	18eV3ESJIQNGA9e6jxYV1GNI6EWEeT5ppwX/tda/5sqz4j0fXponDDD3XADI7mhoPH3rVGG/JSS
	yZY++HkY+o6QpBqwJtIWEhf1Tj2Ll/kaVoNuIMluIOycXiUnXyKtx0QPRScCTPgJ06NWZk0x1rq
	maLuJTWHRQJxdR85DbuRp4nfgS9vvtxq8ntY7eh/HYGn79695vz1ac8BPA7sVKes8lgoCVt0fw9
	X65BbDb+kuC7XzJ0+8I=
X-Google-Smtp-Source: AGHT+IGAMjAyYitJ/PuVWBKWSZI7OXnX7FkQeLCk13N2I5HTwIdj4sYm2eua0ju7hcsVjf476FULhg==
X-Received: by 2002:a17:902:e74e:b0:20c:9936:f0ab with SMTP id d9443c01a7336-220bbc739cdmr154394835ad.47.1739504020152;
        Thu, 13 Feb 2025 19:33:40 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d558528asm19680795ad.216.2025.02.13.19.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 19:33:39 -0800 (PST)
Date: Fri, 14 Feb 2025 12:33:33 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCHv4 14/17] zsmalloc: make zspage lock preemptible
Message-ID: <sio5jxzi5fsdcfpgbifna6d6ipwvbrxftogeyxpqim74yeptd4@gaqzwxsrkoud>
References: <Z6ThGFt6wyNpx9xi@google.com>
 <wnffho5jguo24wfy3qv5tvovoargezbu4kcvpk43ludrhyfo6i@6ogtvk5ivfjc>
 <Z6Z2l9uovxAiED6q@google.com>
 <droaoze6w4atf7guiv6t4imhcmkpteyvoaigdnw5p3vdg75ebx@m56xi2y527i4>
 <Z6y_3xS_8pmZ2bCz@google.com>
 <rbco2k74plqedtqvn6ebu6wwssy5urw5mjvsk6n576d3urbjnx@tq43anmdvq35>
 <25268fbedb82a06ba0c13e2c490b164846ef508b@linux.dev>
 <huhxeq3k4q5lscj5xy6lldivku2wps6midxmt4swr67mce4nva@7mxupdxphs5a>
 <y6y67njsxrc3orfpqjkj5jsy2jma77mmwhxirt3vb7h6uhlylx@5ftvcrqmjtce>
 <Z64O3w2p1NrXoicl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z64O3w2p1NrXoicl@google.com>

On (25/02/13 15:25), Yosry Ahmed wrote:
> On Thu, Feb 13, 2025 at 05:22:20PM +0900, Sergey Senozhatsky wrote:
> > On (25/02/13 16:21), Sergey Senozhatsky wrote:
> > > BASE
> > > ====
> > > 
> > > 1363.64user 157.08system 1:30.89elapsed 1673%CPU (0avgtext+0avgdata 825692maxresident)k
> > > 
> > > lock stats
> > > 
> > >                               class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
> > >                    &pool->migrate_lock-R:             0              0           0.00           0.00           0.00           0.00          10001         702081           0.14         104.74      125571.64           0.18
> > >                             &class->lock:             1              1           0.25           0.25           0.25           0.25           6320         840542           0.06         809.72      191214.87           0.23
> > >                          &zspage->lock-R:             0              0           0.00           0.00           0.00           0.00           6452         664129           0.12         660.24      201888.61           0.30
> > >                 &zram->table[index].lock:             0              0           0.00           0.00           0.00           0.00        1716362        3096466           0.07         811.10      365551.24           0.12
> > >                             &zstrm->lock:             0              0           0.00           0.00           0.00           0.00              0         664129           1.68        1004.80    14853571.32          22.37
> > > 
> > > PATCHED
> > > =======
> > > 
> > > 1366.50user 154.89system 1:30.33elapsed 1684%CPU (0avgtext+0avgdata 825692maxresident)k
> > > 
> > > lock stats
> > > 
> > >                               class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
> > >                          &pool->lock#3-R:             0              0           0.00           0.00           0.00           0.00           3648         701979           0.12          44.09      107333.02           0.15
> > >                             &class->lock:             0              0           0.00           0.00           0.00           0.00           5038         840434           0.06        1245.90      211814.60           0.25
> > >                          zsmalloc-page-R:             0              0           0.00           0.00           0.00           0.00              0         664078           0.05         699.35      236641.75           0.36
> > >                         zram-entry->lock:             0              0           0.00           0.00           0.00           0.00              0        3098328           0.06        2987.02      313339.11           0.10
> > >    &per_cpu_ptr(comp->stream, cpu)->lock:             0              0           0.00           0.00           0.00           0.00             23         664078           1.77        7071.30    14838397.61          22.34
> > 
> > So...
> > 
> > I added lock-stat handling to zspage->lock and to zram (in zram it's only
> > trylock that we can track, but it doesn't really bother me).  I also
> > renamed zsmalloc-page-R to old zspage->lock-R and zram-entry->lock to
> > old zram->table[index].lock, just in case if anyone cares.
> > 
> > Now bounces stats for zspage->lock and zram->table[index].lock look
> > pretty much like in BASE case.
> > 
> > PATCHED
> > =======
> > 
> >                               class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
> >                          &pool->lock#3-R:             0              0           0.00           0.00           0.00           0.00           2702         703841           0.22         873.90      197110.49           0.28
> >                             &class->lock:             0              0           0.00           0.00           0.00           0.00           4590         842336           0.10        3329.63      256595.70           0.30
> >                           zspage->lock-R:             0              0           0.00           0.00           0.00           0.00           4750         665011           0.08        3360.60      258402.21           0.39
> >                  zram->table[index].lock:             0              0           0.00           0.00           0.00           0.00        1722291        3099346           0.12        6943.09      721282.34           0.23
> >    &per_cpu_ptr(comp->stream, cpu)->lock:             0              0           0.00           0.00           0.00           0.00             23         665011           2.84        7062.18    14896206.16          22.40
> > 
> 
> holdtime-max and holdtime-total are higher in the patched kernel. Not
> sure if this is just an artifact of lock holders being preemtible. 

Hmm, pool->lock shouldn't be affected at all, however BASE holds it much
longer than PATCHED

        holdtime-max            holdtime-total
BASE    104.74                  125571.64
PATCHED 44.09                   107333.02

Doesn't make sense.  I can understand zspage->lock and
zram->table[index].lock, but for zram->table[index] things look
strange (comparing run #1 and #2)

        holdtime-total
BASE    365551.24
PATCHED 313339.11

And run #3 is in its own league.



Very likely just a very very bad way to test things.


Re-based on 6.14.0-rc2-next-20250213.


BASE
====

PREEMPT_NONE

                              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
                   &pool->migrate_lock-R:             0              0           0.00           0.00           0.00           0.00           3624         702276           0.15          35.96      126562.90           0.18
                            &class->lock:             0              0           0.00           0.00           0.00           0.00           5084         840733           0.06         795.26      183238.22           0.22
                         &zspage->lock-R:             0              0           0.00           0.00           0.00           0.00           5358         664228           0.12          43.71      192732.71           0.29
                &zram->table[index].lock:             0              0           0.00           0.00           0.00           0.00        1528645        3095862           0.07         764.76      370881.23           0.12
                            &zstrm->lock:             0              0           0.00           0.00           0.00           0.00              0         664228           2.52        2033.81    14605911.45          21.99

PREEMPT_VOLUNTARY

                              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
                   &pool->migrate_lock-R:             0              0           0.00           0.00           0.00           0.00           3039         699556           0.14          50.78      125553.59           0.18
                            &class->lock:             0              0           0.00           0.00           0.00           0.00           5259         838005           0.06         943.43      177108.05           0.21
                         &zspage->lock-R:             0              0           0.00           0.00           0.00           0.00           5581         664096           0.12          81.56      190235.48           0.29
                &zram->table[index].lock:             0              0           0.00           0.00           0.00           0.00        1731706        3098570           0.07         796.87      366934.54           0.12
                            &zstrm->lock:             0              0           0.00           0.00           0.00           0.00              0         664096           3.38        5074.72    14472697.91          21.79

PREEMPT

                              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
                   &pool->migrate_lock-R:             0              0           0.00           0.00           0.00           0.00           2545         701827           0.14         773.56      125463.37           0.18
                            &class->lock:             0              0           0.00           0.00           0.00           0.00           4697         840281           0.06        1701.18      231657.38           0.28
                         &zspage->lock-R:             0              0           0.00           0.00           0.00           0.00           4778         664002           0.12         755.62      181215.17           0.27
                &zram->table[index].lock:             0              0           0.00           0.00           0.00           0.00        1731737        3096937           0.07        1703.92      384633.29           0.12
                            &zstrm->lock:             0              0           0.00           0.00           0.00           0.00              0         664002           2.85        3603.20    14586900.58          21.97


So somehow holdtime-max for per-CPU stream is 2.5x higher for PREEMPT_VOLUNTARY
than for PREEMPT_NONE.  And class->lock holdtime-total is much much higher for
PREEMPT than for any other preemption models.  And that's BASE kernel, which
runs fully atomic zsmalloc and zram.  I call this rubbish.

