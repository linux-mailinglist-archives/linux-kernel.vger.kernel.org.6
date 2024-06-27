Return-Path: <linux-kernel+bounces-231902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 417CA91A01E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4C71F23D60
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB993481DB;
	Thu, 27 Jun 2024 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cL6pkM+w"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C54779D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472416; cv=none; b=h3xgy+SfFzCTGokQ7YVMG+aMjku5NIlVPP16+p1ilxelKlxf8P/Ff7S5cS6UI/Nha7Na4tPzdmw2fi1bpnlf+Z3bCacF/5zsdksRqNODTA1g7KkpCqcwUaXAmxYdTtmBYbmXyHrMD3aB67hywRFumm/7A+bXCMWt4SV+uRj0Ock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472416; c=relaxed/simple;
	bh=OunEzO/AYwbaIN0s6eaU896UIyKqDZ7uDcqDS/GgQpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSYAxg2BU1/UyMtTpNucbNkNoaGVuBtTxyfNBa5zSjbOK+BP2o3s5ZARy5jxfFPKiN/jZjDpn3jpsosOgYlLjP/yWzEeD0hvcsxfbqRJ0Zph8b/Hj6bap1ZqT+tfPCYgG53rfmelDCatVIu4p5AQJqXx9hqTI9CH8SMj43DPVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cL6pkM+w; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso1405249a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719472410; x=1720077210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjSqYVstGY+dnCOqDR7QEfoeCBWvYJSBI8B7JErfM6o=;
        b=cL6pkM+wLOXXQSqQnyCVoAoSXVvDiJXfHze7IBnrMy3C9R+UFNmKEBZy0wr+pz5Eza
         NbgYJyMDBaQUs5t349K72l86mtfn9um7AsQdxKebKOKrtMcoShYwj9kxVHyb4Z+9F2mQ
         PlM6XdEaT4xtYYsmBdQsrwoGjzD9EDUP8xBGPKsqy9wIk9PSRtduFDSGmWBShaS4hbPw
         XZ5B7hmC8ZIiDiuK538f3WXSuytK0mvuQeVUuHK7rTLJYsM6vMuW6THrc/rsoGfqM5S7
         FJzwbBrfPTljX8D6PO2QiE6bTQH9YnF89fBjfxbTmo1zkikjA9GPynQetrXufZWtRKlI
         NNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719472410; x=1720077210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjSqYVstGY+dnCOqDR7QEfoeCBWvYJSBI8B7JErfM6o=;
        b=s0z/FgWyDUJ3P+GfAvN2oM5VBciZeeDfugaXYX7aS+1Yeqyr5g9hwg2koVrCuaGu68
         8lKU9inxt/EBGM4Yct/lVS8juzaBhJt87DPOvMlYsdq1mRkd5GPdLzT7AKYWTL5KVbMY
         Yc9cy2WFxGAHzMM3J9GiwlyL0oWt4HDepNUMKphDELZq0+REXS3Q857VP06AGHBtNYCZ
         GW8lrvx3XKMrM2zVEetKCWaWzxJLB5VDGXzrh359ylklOYtKmPfmG+jpXaXv2yMCvHjY
         XswzO9YjjuxGoExfPA1XPGZpxTR14gaMijVYeYCQwr4S4ZnIf91Ig+saNyqKwZ0CZJqs
         AVpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW77ohDHXkDxRGJiQx6kuDgvM0VByBC+D6amCHeWngjEYfmWGWL4UNVbSW96DmPT2q0+djD7We1jzkTB2ypZh4kksapylmRV2vaxz6k
X-Gm-Message-State: AOJu0YyhhpGjyu8ezZEqX1HrJYobq+UCFt9gIfR16ngI/doGhUZBWSRw
	KmX06N1LJotL+dCbVR3YhwuMn7A0b9ipXQl0PIKjZIrkVNVrFQsyD/tQDgL9ekU=
X-Google-Smtp-Source: AGHT+IHQM+6N2TxfZxDlu1yZpXj1sEKyksdVN3G4/fMpiXtja6nFqYy2Yne2kCXQS07WmpUm6iav4w==
X-Received: by 2002:a17:906:ba8b:b0:a6f:4f2c:1936 with SMTP id a640c23a62f3a-a727f706bf5mr398227766b.44.1719472409930;
        Thu, 27 Jun 2024 00:13:29 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d71f5acsm31349466b.68.2024.06.27.00.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:13:29 -0700 (PDT)
Date: Thu, 27 Jun 2024 09:13:29 +0200
From: Michal Hocko <mhocko@suse.com>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: memcg: remove redundant
 seq_buf_has_overflowed()
Message-ID: <Zn0RGTZxrEUnI1KZ@tiehlicka>
References: <20240626094232.2432891-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626094232.2432891-1-xiujianfeng@huawei.com>

On Wed 26-06-24 09:42:32, Xiu Jianfeng wrote:
> Both the end of memory_stat_format() and memcg_stat_format() will call
> WARN_ON_ONCE(seq_buf_has_overflowed()). However, memory_stat_format()
> is the only caller of memcg_stat_format(), when memcg is on the default
> hierarchy, seq_buf_has_overflowed() will be executed twice, so remove
> the reduntant one.

Shouldn't we rather remove both? Are they giving us anything useful
actually? Would a simpl pr_warn be sufficient? Afterall all we care
about is to learn that we need to grow the buffer size because our stats
do not fit anymore. It is not really important whether that is an OOM or
cgroupfs interface path.

> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  mm/memcontrol.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 974bd160838c..776d22bc66a2 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1846,9 +1846,6 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  			       vm_event_name(memcg_vm_event_stat[i]),
>  			       memcg_events(memcg, memcg_vm_event_stat[i]));
>  	}
> -
> -	/* The above should easily fit into one page */
> -	WARN_ON_ONCE(seq_buf_has_overflowed(s));
>  }
>  
>  static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs

