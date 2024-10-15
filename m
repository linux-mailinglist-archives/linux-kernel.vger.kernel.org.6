Return-Path: <linux-kernel+bounces-366800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B307199FA91
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356CB1F227AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E10721E3B8;
	Tue, 15 Oct 2024 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="oAyM3Qas"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2D21E3A9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029166; cv=none; b=K+P5Ed/q7EK3narM5/N1z5xbE+qfe+vyZRl6z5pytLH5CkLG/Y6geeBtiIswnFacF/Oiyt7AvdKT8/qFeQ3zHgBfm3u3ge/oZ+oQRc3z0EyZWeDdO3gqESjNpSNML7fiZCwoNzWneokfwoS5eQeBECmMat/E/fcmUzqRWdF+5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029166; c=relaxed/simple;
	bh=jtxwWdoUKQ0tGJP0G+GgNotUiNZm86NOcaw379kmBxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGG/v7HFS9aI2DJKeQxekU048CZSc1zyqxehodv1uVcxw/1cPHXnuXWd8P/kDx7oQ8NlDLvS/pUwHkvIvuCkeo1dEAmO/m6x3j5avRVWXfem34rr/mNIQ+lymN1QL2+kHMj3/M8dlZx8nfRwgea4dlD2EyuRs8rzDrnZvM7vHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=oAyM3Qas; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e2e4237da4so48968067b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1729029162; x=1729633962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1oJFgXOwSRuzJnR58wr9vPC8wf4XOC8c7+Si6KvvQ78=;
        b=oAyM3Qas8tnV3eIByw1S+dc6/gc9kV4sn1ciq78r7Q5HBh+WkWJjgflJP6uzQ1V69o
         0go+AKO9ForLyjgj24CFlrV87ttHRNfBCqs57fLbvQJSPrgVGNBu7tx6TkZjGReaF7Gu
         du1ZFRXxuFKDM4nPfa1ziHrkB3MEQ7dv0Iq5KWWu8rtlN2uEWv8pFOcVsXowfAD4XAYS
         pDJUj/T8TEOWTO+JIHZf01JGQL6j50U9Xhc9wiy94kZTF/8EH+Oi/ZA19yRkQVwvho+o
         u/og8glFKCTRlh8gV6iYZJw3988FPqyvrzx8So+b7XStcoet2cmU1O5qEji60jX5sCiq
         J1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729029162; x=1729633962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oJFgXOwSRuzJnR58wr9vPC8wf4XOC8c7+Si6KvvQ78=;
        b=uI4lghnBk3BTEvlXYP/3eQClNEsvPqOL8Mw/z8gTBcr52giy3+VxYaifcFLq4b1KfT
         wPXF3ubG3bP+fD+fAXxMu2OO++gbkP8zw9K1jvdqj+fXtOSpHzdbKwMI4af9z4eHGCwF
         RtfoacwcL8+xC7TFcfCPeCPwRe6mj7rNz/W+fmeWXqbGN9L2JvhcKmenTVfHkQsZdynO
         OAp/6ZOls0SMQWRmTMFx8q/wjj4HCsWwahgHhaiZy7Y57K2+p4qhSJF996z/rCIk+0HX
         n7T8nG7dSXnbMFF/BsQAdM+DENvdJteNgjcjQ57tKbkcfy/4/EeWU3wXtPkhFGQp0w8O
         Wmcg==
X-Forwarded-Encrypted: i=1; AJvYcCUyRIV2yXccZtn+GHjUMm17K4mxfhY7F6Pc585Ee6itsnjZRMUOV08h5sDBS/ozdLvlS5Hhps8q1+dBosc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrkTkNTl/7LYuvqbWIrI1PHMSwYM72FmgP9aSN2YuYh8i+VUK8
	CwM6jYIItZ/RLfK5zy7L+UE4mfXeVkdzCIN3YwvlnAPjo4oy0wLabfzvVw14bPs=
X-Google-Smtp-Source: AGHT+IH5UZWftcNq2mZ72neDmq/CCGqUmV17SBh3z1fpFfyeoqwKgS7AMaFGzXqNsMhh6bMNKb2bCA==
X-Received: by 2002:a05:690c:13:b0:6ad:deb1:c8e0 with SMTP id 00721157ae682-6e3479bfbdfmr144705457b3.18.1729029162162;
        Tue, 15 Oct 2024 14:52:42 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22959ad3sm11138006d6.85.2024.10.15.14.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 14:52:41 -0700 (PDT)
Date: Tue, 15 Oct 2024 17:52:36 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] memcg: add tracing for memcg stat updates
Message-ID: <20241015215236.GA1052@cmpxchg.org>
References: <20241015213721.3804209-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015213721.3804209-1-shakeel.butt@linux.dev>

On Tue, Oct 15, 2024 at 02:37:21PM -0700, Shakeel Butt wrote:
> The memcg stats are maintained in rstat infrastructure which provides very
> fast updates side and reasonable read side.  However memcg added plethora
> of stats and made the read side, which is cgroup rstat flush, very slow.
> To solve that, threshold was added in the memcg stats read side i.e.  no
> need to flush the stats if updates are within the threshold.
> 
> This threshold based improvement worked for sometime but more stats were
> added to memcg and also the read codepath was getting triggered in the
> performance sensitive paths which made threshold based ratelimiting
> ineffective.  We need more visibility into the hot and cold stats i.e.
> stats with a lot of updates.  Let's add trace to get that visibility.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: JP Kobryn <inwardvessel@gmail.com>
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

