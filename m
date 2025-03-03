Return-Path: <linux-kernel+bounces-542206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B670A4C702
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19208171695
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D8822A4DF;
	Mon,  3 Mar 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SDIXkAym"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E757215F52
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018798; cv=none; b=cothPNp6el11xP7+2U/Oym0PWCP60IMVbWOigc4s56NXe1A0sWccOYzmxyIoYiLLwKvCVpzsW2Xu0h9+0/pzlqZusjMPvg4Xwd2ASIerGvKpJBPjdk4OQHJzX0OonhlaFKcXS6nLG7+FO11gXQiZ+dpEw+ecgAuvraSGpMppn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018798; c=relaxed/simple;
	bh=KaGmUQu6vX9CGkW4/xHWmqzfNUCeiOrjklvyH7jHB5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga5mJpuH1VATuX4qhJ1RNv+EYN9CgaJc13rxQwju3+efeEeC3FZCuELT5d8xyqoTfP9K1dl10R/ZMHs+E8ic3eWo30hNqy2EzOrstT2IInri0gnpHLQUZBnZTcmRwG8bsBWWn8GEIEKuSy7FC+KNvxkGexaDhZSX35WuX7PLBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SDIXkAym; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3b3e11f28so172897485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741018796; x=1741623596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=npU4Q2NKzI8EHqsYS1IQDm8fptT5XAkaolwjBVod8c4=;
        b=SDIXkAym6QpvZf/ycYItY0gcvJ2Luwu0rESmvOBnp9L0IiAeeSIiqJo9LLXMytzrqY
         0o7mwgOzQgpovHsxfS4k6qgWya1xhKzN5xUXD9qrE9mIULvuzfbWkHpSPqrjrAyHh3c4
         vpPedX2t2QblzbEEXUNLQlNj/dqCEGdK0SuTQsR3CUW0ONRAehtsruj3Y3rPu+9CiCgM
         9J1hEqHR3T6/moJESIaxrzZap1Culj9UjTZQy5XnxxBDHBMoYy8k3TPeXY1kr+HUFu/F
         1bszyMRAFFG9WVT4jCnVZwC5anw7GMdc4Kj253fIplivOnch3FRaXDWevLEjGpk2seY1
         B4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741018796; x=1741623596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npU4Q2NKzI8EHqsYS1IQDm8fptT5XAkaolwjBVod8c4=;
        b=o52xmI5UnVfGfcKfQ45FjJW3Du8rV58nK3effMx4ZLS8n55cz4WB6yH6pjAAONfTrG
         HUVXFvEnPNWDcEVamWIMQiT6jIUEIzedVneCjyLA9l7AhQTeXcZjbXiHNvryhpZB6LA+
         fXIsrOW6eG6BLEJi0UkJWSqzvuujxgY6tkX42qcTcEv3VRNijk8KB6gUqu9TOgHPgshb
         Z3bF43kRUG9TIhtCo5Y68dEFUhIY6lxQ1GIjv3sQDKYRPG7UqGjTddWNOxX0YtJGbJ9h
         ZRPjA/8qj6tfwOyvbD0IzKwKD89wgJkellZh11weomoHhoSevckwIkTP3Wxqt3vc3HJ6
         UhXg==
X-Forwarded-Encrypted: i=1; AJvYcCVi1DBL4WM/PchFEuqwrHq5cB7oyJOyL0kmrFKh5mS937gA7saChpmcFT0mV3Gth0LTSbNwV/YnIuKUg5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeR2EpWqffFrh3A/Hu9dj732BpskTunEQ+aBJU8N+6JoriTRgG
	qh6jHEzvkMSEAIh6vRRUXaHs7isBHMS4TTqBOw/HGsNa4niqrP8sg751ZjnpBSk=
X-Gm-Gg: ASbGncvuPiSJ2xIkztbNmPSp850hzbP/9sbx051MI78cV3IQofZA/xtYWQztPQDzyyM
	srLVV2v1vqHlzer8waVE0VyHyNxSsiT1DCt7St3TREpmhj3uvSV6tYeJtmws8TxHXYWJXs4VYMx
	p4Om/T1FZrcycPYSsWacBYXV8r1SeXWSDpoQmaw6CUvYN7TLNgz25+sh5X3K9FVTOvW//J+C+lV
	gmGG/VbWt/ytjYwuAZHLirJdLcNvTMSPmlo1+D4x2FMEpTmrZvUvsM7D3/jnnPsWZswBSi8b5Bc
	nY5X5P2iOfI3iApjBka9yv4UbY/zr6JnVtOGqXo4q76NTko6A0Wyh7wRRHRZ7oygbiyPlut1XV+
	Ic0h4ktQsVbhyE46lVKUEYLBmd5U=
X-Google-Smtp-Source: AGHT+IFrkNQWQ1CiJuDWkCSRKag4xlr1szBO39O50NkgwvocW88WS9f8hGcizY9NgWfP7fb3nWp2Qw==
X-Received: by 2002:a0c:c387:0:b0:6e8:adee:2e6a with SMTP id 6a1803df08f44-6e8adee2f29mr134420576d6.36.1741018796194;
        Mon, 03 Mar 2025 08:19:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec0f8sm54776936d6.120.2025.03.03.08.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:19:55 -0800 (PST)
Date: Mon, 3 Mar 2025 11:19:53 -0500
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, harry.yoo@oracle.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	gregkh@linuxfoundation.org, rakie.kim@sk.com,
	akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z8XWqQdPC7245FA2@gourry-fedora-PF4VCD3F>
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
 <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>

On Thu, Feb 27, 2025 at 11:32:26AM +0900, Honggyu Kim wrote:
> 
> But using N_MEMORY doesn't fix this problem and it hides the entire CXL
> memory nodes in our system because the CXL memory isn't detected at this
> point of creating node*.  Maybe there is some difference when multiple
> CXL memory is detected as a single node.
> 

Hm, well, the node is "created" during early boot when ACPI tables are
read and the CFMW are discovered - but they aren't necessarily "online"
at the time they're created.

There is no true concept of a "Hotplug NUMA Node" - as the node must be
created at boot time. (tl;dr: N_POSSIBLE will never change).

This patch may have been a bit overzealous of us, I forgot to ask
whether N_MEMORY is set for nodes created but not onlined at boot. So
this is a good observation.

It also doesn't help that this may introduce a subtle race condition.

If a node exists (N_POSSIBLE) but hasn't been onlined (!N_MEMORY) and
bandwidth information is reported - then we store the bandwidth info
but don't include the node in the reduction.  Then if the node comes
online later, we don't re-trigger reduction.

Joshua we should just drop this patch for now and work with Honggyu and
friends separately on this issue.  In the meantime we can stick with
N_POSSIBLE.

There are more problems in this space - namely how to handle a system
whereby 8 CXL nodes are "possible" but the user only configures 2 (as
described by Hyonggye here).  We will probably need to introduce
hotplug/node on/offline callbacks to re-configure weights.

~Gregory

