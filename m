Return-Path: <linux-kernel+bounces-512485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE58A339DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DC43A7EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E26F20B7F3;
	Thu, 13 Feb 2025 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JeyJZ/iU"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15213B29B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434948; cv=none; b=gIKWYtaeMJ0RBY6oZDtwRkyQPknuDHo4e2kfEMRLZkjHDUJyU3LEeiE8tni4auXfnoY2gGxvURszLoeoq+2BVLGga9YnoQmkyXJ6f2ea27Rz/YRA9W2svpDfnQhLU3sQyFyYB5Tfhm86IrBfMfeN84hx7BG8dJ8UMY4rKX5bCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434948; c=relaxed/simple;
	bh=nUYZisqU0mZn5bw8svBDnGd7UrX3hTLpgaySdw3sGkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3RWztIudt0CltL2Dui05UHS/QM0tUbCqTX9+Xesu0h5CVUZxRWnjHBqXNpKitGkxJYEx9yj6u/4KlD1morjq0c04SBpHXv3suDsKTnaiGshEh2dPq9tJrcSLpDpJF+b5ms1zNMmjB7gJHyd2aBwRVCF/latZzINy10n1LsW3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JeyJZ/iU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220d398bea9so7846625ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739434946; x=1740039746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=el37H95Ti0G7XNGLIK1QP9vWYFy2OzwJJ+Ft/L8FLdE=;
        b=JeyJZ/iUIssyMMcpJILTv78zVrOLQJBbYx+DPfrfY8vE5I7tPAJKp2SXzTO9x0B7MT
         zeDQK4IO1CTJve9ayto35Nqv7bhgtXMloKPxnequO2Ky0naDvdpyVsS3SvazETgVFFul
         0hgsSLBUj2lk/4l01571HR5whxFhHQq8KCUSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739434946; x=1740039746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el37H95Ti0G7XNGLIK1QP9vWYFy2OzwJJ+Ft/L8FLdE=;
        b=eBVRSuoJEpB3TLkkucrd2AgjCJN/YoHNfdGuvH1dgvgdUhiEIcodi4tsT2tHC+4p9a
         Pp1R1ZewFpxgus8gtXNTpOFdtX/uEA7S0COyybObt4+CZI2b5zbp2lKUDqjkBqzjI/DN
         PW7AEyGFufqwS/Jp8lVY8Dl489v/ZIwcqrV9ZAK369R538h3LdJ7DjxJMREak1Gt1SOf
         QYpk/SvIoQWpZmwgDSxOVQcO1mUsO5uZD70SYxgjgwFJssqu4Zqhw/NXtcPYK3IHhF9f
         11lAEzM7YzsP2ztaqwGcAvbmRoBNBLPFjkuSdT1CbSDoIJ4K6DSYjUeyurVaGi9cv4W9
         hx+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDsxmLoYNCKaKNUOgLp98a7IJ04XjFFLoGXcC94Ulp2zzC9y07Gxlbz27/uNDdDmsc2yZNXpSxY4L1U6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9juzubhyEVOIzM1FnINVl0xuH80DM6I/PFx30jTnbWHlTyGY
	Su7JlNXA4xeRnzMeSuIZLBYporsoTatuvTqMA0080hJKiOPDQwUgjdPQKNnB9Xit+FSC8yzlTYw
	=
X-Gm-Gg: ASbGncts0tySCkfhEViSqe2fi2y/GOzHFYP1VAG/3q5oRv8OJkalYx/G+0HPocKiNCZ
	iWFnaSa7tS5Dgf/SK3QPjQb+ZotZSgTzto6oYgCYigkpGnOiStNYTrBWxG15Lxm8AmHWyxswI/o
	8gAJxIx83oKfg5DVwCMfjcAg+qjKq+3WEwrpicdfV4iINkGGJ49LRIndArKFroOcXheP2GiYuz8
	aGBUkXbpIxMvjC6tV9ZnWR+7L8Ydnug4Vh8bjukcR6kGv61Dr6XhxNDHiyHN2wqDI7QiKhKjeYe
	MBekRZoJ1jPVnRIyhfI=
X-Google-Smtp-Source: AGHT+IGMCaQ7jEqGYb/dNVjb8sIoODFN2dM+ydbX1/RuoKXY9x64CCsWG6ItNnsUtcKBOcrmjFKtew==
X-Received: by 2002:a05:6a00:cd2:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-7322c380e4bmr625117b3a.8.1739434946381;
        Thu, 13 Feb 2025 00:22:26 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3ed3:97ce:5f5f:1f61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568af8sm723384b3a.48.2025.02.13.00.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 00:22:25 -0800 (PST)
Date: Thu, 13 Feb 2025 17:22:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kairui Song <ryncsn@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv4 14/17] zsmalloc: make zspage lock preemptible
Message-ID: <y6y67njsxrc3orfpqjkj5jsy2jma77mmwhxirt3vb7h6uhlylx@5ftvcrqmjtce>
References: <Z6O2oPP7lyRGXer_@google.com>
 <6uhsj4bckhursiblkxe54azfgyqal6tq2de3lpkxw6omkised6@uylodcjruuei>
 <Z6ThGFt6wyNpx9xi@google.com>
 <wnffho5jguo24wfy3qv5tvovoargezbu4kcvpk43ludrhyfo6i@6ogtvk5ivfjc>
 <Z6Z2l9uovxAiED6q@google.com>
 <droaoze6w4atf7guiv6t4imhcmkpteyvoaigdnw5p3vdg75ebx@m56xi2y527i4>
 <Z6y_3xS_8pmZ2bCz@google.com>
 <rbco2k74plqedtqvn6ebu6wwssy5urw5mjvsk6n576d3urbjnx@tq43anmdvq35>
 <25268fbedb82a06ba0c13e2c490b164846ef508b@linux.dev>
 <huhxeq3k4q5lscj5xy6lldivku2wps6midxmt4swr67mce4nva@7mxupdxphs5a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <huhxeq3k4q5lscj5xy6lldivku2wps6midxmt4swr67mce4nva@7mxupdxphs5a>

On (25/02/13 16:21), Sergey Senozhatsky wrote:
> BASE
> ====
> 
> 1363.64user 157.08system 1:30.89elapsed 1673%CPU (0avgtext+0avgdata 825692maxresident)k
> 
> lock stats
> 
>                               class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
>                    &pool->migrate_lock-R:             0              0           0.00           0.00           0.00           0.00          10001         702081           0.14         104.74      125571.64           0.18
>                             &class->lock:             1              1           0.25           0.25           0.25           0.25           6320         840542           0.06         809.72      191214.87           0.23
>                          &zspage->lock-R:             0              0           0.00           0.00           0.00           0.00           6452         664129           0.12         660.24      201888.61           0.30
>                 &zram->table[index].lock:             0              0           0.00           0.00           0.00           0.00        1716362        3096466           0.07         811.10      365551.24           0.12
>                             &zstrm->lock:             0              0           0.00           0.00           0.00           0.00              0         664129           1.68        1004.80    14853571.32          22.37
> 
> PATCHED
> =======
> 
> 1366.50user 154.89system 1:30.33elapsed 1684%CPU (0avgtext+0avgdata 825692maxresident)k
> 
> lock stats
> 
>                               class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
>                          &pool->lock#3-R:             0              0           0.00           0.00           0.00           0.00           3648         701979           0.12          44.09      107333.02           0.15
>                             &class->lock:             0              0           0.00           0.00           0.00           0.00           5038         840434           0.06        1245.90      211814.60           0.25
>                          zsmalloc-page-R:             0              0           0.00           0.00           0.00           0.00              0         664078           0.05         699.35      236641.75           0.36
>                         zram-entry->lock:             0              0           0.00           0.00           0.00           0.00              0        3098328           0.06        2987.02      313339.11           0.10
>    &per_cpu_ptr(comp->stream, cpu)->lock:             0              0           0.00           0.00           0.00           0.00             23         664078           1.77        7071.30    14838397.61          22.34

So...

I added lock-stat handling to zspage->lock and to zram (in zram it's only
trylock that we can track, but it doesn't really bother me).  I also
renamed zsmalloc-page-R to old zspage->lock-R and zram-entry->lock to
old zram->table[index].lock, just in case if anyone cares.

Now bounces stats for zspage->lock and zram->table[index].lock look
pretty much like in BASE case.

PATCHED
=======

                              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
                         &pool->lock#3-R:             0              0           0.00           0.00           0.00           0.00           2702         703841           0.22         873.90      197110.49           0.28
                            &class->lock:             0              0           0.00           0.00           0.00           0.00           4590         842336           0.10        3329.63      256595.70           0.30
                          zspage->lock-R:             0              0           0.00           0.00           0.00           0.00           4750         665011           0.08        3360.60      258402.21           0.39
                 zram->table[index].lock:             0              0           0.00           0.00           0.00           0.00        1722291        3099346           0.12        6943.09      721282.34           0.23
   &per_cpu_ptr(comp->stream, cpu)->lock:             0              0           0.00           0.00           0.00           0.00             23         665011           2.84        7062.18    14896206.16          22.40


