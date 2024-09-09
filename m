Return-Path: <linux-kernel+bounces-320718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F749970F7B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA68E1F21F6E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A99F1AED4E;
	Mon,  9 Sep 2024 07:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GjzcB163"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1111AE859
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866431; cv=none; b=Kje0FflWDrUHkJREXDN7D4EY+1w0KGp/7DKRTaY9Gy/YpURnYtpaYJsjbGERcFB50jI/r3SJseEXucWBaFZOe47O18O2Wd6DOaqgMvMXI8ys/UfshybISj45pAOm6KlQciodsm8jrAA8ukgUAHA+vz3IHUUgJoSUmLHdQx9mosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866431; c=relaxed/simple;
	bh=YuIxzNfIZ3Yn0pjIGqtgmvpDDa9xlMz2MnTcytszYwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcuV52nJb0iSA+R2IMiB0689aTkuVKD8cboINgx+FnzejKcjUUkh58YEG9Qc+ILcFomEUrBKkg3j/D/kFpHj6pDzGlvRfP96D5Mrir++TuHmsQ9qiDdcvcUwu6aPdqwFBGP82OEIo7QJT8EFgTsyDVU5pC1zreSz8KutWSeaqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GjzcB163; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so11962745e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725866428; x=1726471228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUYgRrt73R/AzDLyM5Jg4uBo6/bxbCoymCk3p5vIpyk=;
        b=GjzcB163OlHF5FFymVdBW/yI8TiupldbpYA0y95WotUQbQPFD+zvrC+DXBGK6vJ091
         e9aOxhWexOo87xUcIoQ4hpdFdIQM60Rwh9HO2egRYA0mRw9UBXQ7dC7LwHxAP5NAZ+5M
         L1Tz2G+PiPbjSkJSWPoWgKaoaRM9k9Apj4pNw64WYJV+Vnxa2Kp+0WMO96VFedDmouA3
         QSKLpCNIwCQG1mmx+xkIIV7faPGVj46g/aU4ECyGLo0TQnmwvWIz/uUbILg7LTQmUt7R
         SaAPiov2FwnG8BWXQxpJ2HReywcG8ugHR7P5NJ+Z7gpKX6A8DW8terL49jggVlppSByU
         TDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866428; x=1726471228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUYgRrt73R/AzDLyM5Jg4uBo6/bxbCoymCk3p5vIpyk=;
        b=KEsNp6xRWqn02inOjOQB1IDFgCtJlmpm336ZoEZkZQYy4kZCfBoOdJMnOd5Au4R83h
         CcAqxlagonE49QHbLPxrNX6AH+8Pw1UFW8T67G51bzo2X9T51/Pnpo9O3vSoE4Rr91Xk
         2/Yz1NcAgggLIwl3YU2sN0azFkAJurFxjGngoEs57NuUR7C/sHultnt7XnsMwQNaHQ2+
         b8rPWsV7BXjnF4ij2RmnvB2mLQJjuUsz4IMfvwDXZvFSayEtTg2xZK1M7XWgWLUT/mfn
         Ltew2yg0F544NweUmv4R2miGUAkBD1hqrxIKXgSKPKH7L3Qn9zFO0azk6oZj31UiQfY9
         4oIw==
X-Forwarded-Encrypted: i=1; AJvYcCWGAJ41/SduZdJOk9Xj6x2vh80AhSgRaM7yexCRoZPzr7nGMOB7hGIxBBqGJV17/c1dQIsYbmurrQSBxBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXEINCEEd4DVM+nPntfvtw6ng6CXEc9GbRrzCQKZeKb+Vsvzal
	Jl/QZhPTXXFxaWenyXaXylZoOqNmoOlhDZoCuWZ6N1GrDWQR4s3U5U6Hoqh56FU=
X-Google-Smtp-Source: AGHT+IFIiDSRSYeBEcV92W79htAPHfJxh9us1KZqt+JswhX3Is2KoO8v4vNKGbVTCpDoomhtPcTkdw==
X-Received: by 2002:a05:600c:22cf:b0:42c:a8cb:6a75 with SMTP id 5b1f17b1804b1-42ca8cb6c5amr55206885e9.17.1725866427774;
        Mon, 09 Sep 2024 00:20:27 -0700 (PDT)
Received: from localhost (109-81-94-251.rct.o2.cz. [109.81.94.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caf436998sm65861645e9.29.2024.09.09.00.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:20:27 -0700 (PDT)
Date: Mon, 9 Sep 2024 09:20:26 +0200
From: Michal Hocko <mhocko@suse.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
	yosryahmed@google.com, hannes@cmpxchg.org, almasrymina@google.com,
	roman.gushchin@linux.dev, gthelen@google.com, dseo3@uci.edu,
	a.manzanares@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim interface
Message-ID: <Zt6hur2TZJUrJ2IU@tiehlicka>
References: <20240904162740.1043168-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904162740.1043168-1-dave@stgolabs.net>

On Wed 04-09-24 09:27:40, Davidlohr Bueso wrote:
> This adds support for allowing proactive reclaim in general on a
> NUMA system. A per-node interface extends support for beyond a
> memcg-specific interface, respecting the current semantics of
> memory.reclaim: respecting aging LRU and not supporting
> artificially triggering eviction on nodes belonging to non-bottom
> tiers.
> 
> This patch allows userspace to do:
> 
>      echo 512M swappiness=10 > /sys/devices/system/node/nodeX/reclaim
> 
> One of the premises for this is to semantically align as best as
> possible with memory.reclaim. During a brief time memcg did
> support nodemask until 55ab834a86a9 (Revert "mm: add nodes=
> arg to memory.reclaim"), for which semantics around reclaim
> (eviction) vs demotion were not clear, rendering charging
> expectations to be broken.
> 
> With this approach:
> 
> 1. Users who do not use memcg can benefit from proactive reclaim.

It would be great to have some specific examples here. Is there a
specific reason memcg is not used?

> 2. Proactive reclaim on top tiers will trigger demotion, for which
> memory is still byte-addressable. Reclaiming on the bottom nodes
> will trigger evicting to swap (the traditional sense of reclaim).
> This follows the semantics of what is today part of the aging process
> on tiered memory, mirroring what every other form of reclaim does
> (reactive and memcg proactive reclaim). Furthermore per-node proactive
> reclaim is not as susceptible to the memcg charging problem mentioned
> above.
> 
> 3. Unlike memcg, there should be no surprises of callers expecting
> reclaim but instead got a demotion. Essentially relying on behavior
> of shrink_folio_list() after 6b426d071419 (mm: disable top-tier
> fallback to reclaim on proactive reclaim), without the expectations
> of try_to_free_mem_cgroup_pages().

I am not sure I understand. If you demote then you effectively reclaim
because you free up memory on the specific node. Or do I just misread
what you mean? Maybe you meant to say that the overall memory
consumption on all nodes is not affected?

Your point 4 and 5 follows up on this so we should better clarify that
before going there.

-- 
Michal Hocko
SUSE Labs

