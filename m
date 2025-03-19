Return-Path: <linux-kernel+bounces-568718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03286A69995
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B007A8CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053A51F4164;
	Wed, 19 Mar 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="IglDzcCe"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878232147F5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413126; cv=none; b=NHSC1EkjRLSkW67MrwH9n6l0iMiGMkjC+xkKdSCYhvjEteTLyP+groPLqYVSbnOTC59AHd/rUVUvCSa8FYb6zJzUg8jkD1UmXVqvpkHuWzp+BIzQjEBKDQJHgaI/TZSZMtwN4sYDBfOVd48/etMb5AkUds/1mSHcOG+XRF8Iom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413126; c=relaxed/simple;
	bh=iTVzyjVND7+F0XXvBx/0F1D8RMJY6QzOoyEcjmniBXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnMYTGv6+6K+zLYcovZC0T6gfsfqU8oLJJWunXOZiszF0wiMWklxd5/K4/zbGmbGC96Xr6pnvFaTB1eZ92+eCvelf3NLxsncc0tscAHGZxZ80oRHYR2tGmd/+AwNTntkwOj9kN1SFchPvSJNKQc0BoIQifyMT41d+CvUAseJv/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=IglDzcCe; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46c8474d8daso588401cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742413123; x=1743017923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOsixAo0ygM8pbnBoreCQ/wxYJRqmZpkjLr4PFhJr7E=;
        b=IglDzcCeE+YAudSJLwaui9djKhAZxmY4ZElk6SRJWKTu8/scg8ianfxGmjGsgVijR0
         RDkeX8rkyxN7cPzDnmXXdL2/RnH5MrLq/+jNRGB12L/j6mXkCyasrBvgXaTS2xrjDvVa
         8f9PxbdMnUvsXXy9xcIGqmxjTWAvLDHgiOzU8L6dyDjQoc+eJqGzBJZ1smQEgorhO6xB
         T7Gb9c87DoliY7MusUT4S+C8x3qW1nZJjomkNtUtqYFKQ9/jcDFB2tWbr0gaxYaDO1wr
         7jW8DIgFjhtIA6ZvY0cYg9YP+sV5YhCNA557DkR6t3J+CPlv0TfAGV19zj+3wnfqHerc
         4lRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742413123; x=1743017923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOsixAo0ygM8pbnBoreCQ/wxYJRqmZpkjLr4PFhJr7E=;
        b=lX0cjuSTbgVLK/qYcp9SKOS4l1SYqcY5leueW9PQOjKkuKa5+l9A95jy2ZCMtmgQ/f
         X35bgLuUa39Q19O713i9UfpeADqyuVRYI4H1fm72VUei+4XMvsqplu50bVI7GQydguCy
         GpQSN7sfXANIf/8ICNxWy6mYKsjiD8lirNE967gNhV75cakTBpQJaUghJIBJBVNJ4zy+
         V3GEG0pJF2asH76tOSMvbi3iGJ8Gu97ZKyhpxQt8w9Qnc89GB7g5QT3FtA82gSC2F59z
         mNy3eoVoOXLAjAmcUxanM6sJLf2ocyFB4oMqsWJ0PavQx8+aZa6eiBLn5g1SCRX260je
         VDsg==
X-Forwarded-Encrypted: i=1; AJvYcCUIx3ionMlkJZR934YaCDrBk6+kGs7Ay3ukVGRmUgRJwV1sx9Tjq5Q8UyC0rZnFPWyj2eZz00ZB4mAjs5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhID75ppKaOY9vD5u6OqYuuIpNpGWANQ7HR243mGKNbxGmpSuA
	8c/L8X6TVHHVsAbevI1veYfOP7ptzN2E0H5qDRiGJmjMdSTpFlIFb0jDgUVcOaAIhbeCZPXhU1L
	R
X-Gm-Gg: ASbGncvw2NZoMty0rH64P3bbnvD7bTC7BMoZKPsw62AFRcV2GzTiHjPZspJbH32Oqcc
	l9lxiY9P9RQVcn1jLprj9C8bDMJ9E76d0JVVHOaKi7ArftwqOJ3OSMoasSgB3/W4EYjHnAK4rJv
	wNPQi2iS1SdRHI1wwWX3YEVT2+f6em0MD5jMfUkVQ54vaFh+/7kS8gc2n+ARsV4BXj5tjvjG1Y/
	lwu6NM7mTSUWz1n5jb0Ac4vNgnKgnMdQhPsuIwkR6D4pDcdrP/w+wUrbMJkiceY95YkJLNINsnS
	5+VHFPPvsWisNvZpBfnz6uNw1Oh0j7SyWWV6Vp/b2HQ=
X-Google-Smtp-Source: AGHT+IEnyT/QaZRGxSVvO87lm/uVpwiSi1//kCoa1GAM0k0kXVv6aSSGuoigVDhf/LPLiuSPY6r6Kw==
X-Received: by 2002:a05:622a:1e1b:b0:476:91a5:c832 with SMTP id d75a77b69052e-47708378761mr64518621cf.32.1742413123208;
        Wed, 19 Mar 2025 12:38:43 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb824a8csm83290581cf.65.2025.03.19.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:38:42 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:38:38 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, kasong@tencent.com,
	Zeng Jingxiang <linuszeng@tencent.com>
Subject: Re: [RFC 0/5] add option to restore swap account to cgroupv1 mode
Message-ID: <20250319193838.GE1876369@cmpxchg.org>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>

On Wed, Mar 19, 2025 at 02:41:43PM +0800, Jingxiang Zeng wrote:
> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> memsw account is a very useful knob for container memory
> overcommitting: It's a great abstraction of the "expected total
> memory usage" of a container, so containers can't allocate too
> much memory using SWAP, but still be able to SWAP out.
> 
> For a simple example, with memsw.limit == memory.limit, containers
> can't exceed their original memory limit, even with SWAP enabled, they
> get OOM killed as how they used to, but the host is now able to
> offload cold pages.
> 
> Similar ability seems absent with V2: With memory.swap.max == 0, the
> host can't use SWAP to reclaim container memory at all. But with a
> value larger than that, containers are able to overuse memory, causing
> delayed OOM kill, thrashing, CPU/Memory usage ratio could be heavily
> out of balance, especially with compress SWAP backends.
> 
> This patch set adds two interfaces to control the behavior of the
> memory.swap.max/current in cgroupv2:
> 
> CONFIG_MEMSW_ACCOUNT_ON_DFL
> cgroup.memsw_account_on_dfl={0, 1}
> 
> When one of the interfaces is enabled: memory.swap.current and
> memory.swap.max represents the usage/limit of swap.
> When neither is enabled (default behavior),memory.swap.current and
> memory.swap.max represents the usage/limit of memory+swap.

This should be new knobs, e.g. memory.memsw.current, memory.memsw.max.

Overloading the existing swap knobs is confusing.

And there doesn't seem to be a good reason to make the behavior
either-or anyway. If memory.swap.max=max (default), it won't interfere
with the memsw operation. And it's at least conceivable somebody might
want to set both, memsw.max > swap.max, to get some flexibility while
excluding the craziest edge cases.

