Return-Path: <linux-kernel+bounces-520358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C41A3A911
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54B4178A53
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C701E0E08;
	Tue, 18 Feb 2025 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gHIkD4zo"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24A1D618A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910343; cv=none; b=H11keqs0C7AlbvbL7QblR79fYtUyXDDKZMg5tTAsVWYtTw7JP3YQOAwGVmBW4LSobuckD+eOMXHVGR5X/6KkmVYsT1UzXlXd4dJtFXNJ5rFU6TyhB5gQ9O3pbJ3yG+8EhUF4Ve6uvQrSGITxRaUuNay2eA2EI5H7zMxZCSd+QHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910343; c=relaxed/simple;
	bh=cDkEeHC9gnLs+ohg4PIIyzg8RBeo4zppUQIu/rcKYug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+VqzWu55B6potAshnPSp+hIlQhZHTR2cSb1Ny/gwOOB76e8CMxa/GchhHjCDmvnwYAiLwosKhveKRkkQd0aj9Hnuw7n+eqCm1COOnROQ2hAPgP1KW0y3aRV0ipaOHMkIS42P9znVLgMGnusJbUWgxfL+3FF7DdIPLPHnZyq++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gHIkD4zo; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e67bc04a3bso30604316d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739910339; x=1740515139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=22K3K8H/Z4VEtlmzFLZqURw4WdVHs3LP2poxDfotsZE=;
        b=gHIkD4zoR5M7kIF6gESfGO6ZGntALAOdRrImpbY/3pCxKxl33jSyuKS3rIEYXbvkHg
         PH2GkmoZbt6LPZO2zwiirLkna8cOA/Qk6l06Fo3fzq+htVrZX5Pp9RiL+0xrgD1Be2He
         AEtrJ/eTsaTSYzttNoZAef+eavyKoWSbY5Xl2iEgIMR+wYdS+O3IGAHtUpf6Yqh6Lh1P
         d+bbJfW3aqjY2j94gM9jW5XIBIFZkwwrRnRe09zZKbyTBZg9RYGYGxcO1ZHY0ZdBLEGp
         AL3ozj6SAdDq4Z8Hzzts/CnsmcIw43p/GZewaWKA+sLHV5jMniP8JLuPJMTCWJRS9ntw
         NUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739910339; x=1740515139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22K3K8H/Z4VEtlmzFLZqURw4WdVHs3LP2poxDfotsZE=;
        b=NK1H8OOYHgLLypDSpi9tjelk2dtEwh75rIZk6kiaJwFHWLoiYPgkpUdXcDtGgYvocI
         EbmdrejTJjPglpUhCzzQMdlHaMqP0eC9mBIcPW5Kvv5NC+rtjfaXZ6JHxM/rjWzBatOl
         qawgamQ2C0nK7JrzNFkQRSvTVMwEj5j9MqI3Iar62SWlR7jNswfkzZwjGbCGSEcQUYYz
         vYLt61Bn/+yknnlKOMNTKocTgLgVrgcrDjos/4gauAIb0IYPhb3tRYiLf0aqNpFlMKr8
         Z1d2wN3+R3sDi2cmYlYsRm6TBzkmQnUGIDsGHW/ZEF1MhCv8tv5AvehurGiM3kd5su+Y
         GYGw==
X-Forwarded-Encrypted: i=1; AJvYcCXGZgodj8Il6A+HNuIVOHTooui5FFG6sxamSoasCIMCxmRS0JffRwVedCIYulj9ECYurnnwXPMH3u7OC2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xphJhuEVVPfmyjHvQc61edZN92KFOhIykKTV5kKGSmfOv9hO
	2VQEFPSZbIbFWrakDSs3XUdS5oRsYj9sI4++hcY/oOIxbIlYvRJ71XxZqnSuxhw=
X-Gm-Gg: ASbGncsxFXVBY02I/obIkfDYLSMAlHrifn4FGT7NhEWOb5mFr/bQfYFvaj7lAo+jpsU
	zwyD3+TTn/M3qPX6Zcesr3+hZ+DV6qT+NYNqTZu7YnUDACoZpn8Md5raAgl3n4j7aGSTRAkU/RH
	z4MuRB0Qkq9g3/yi827Yx3iK7AA4RedBv29H9XvosOkU21OinG4UPOIy0iztwnQEZ9sbSx8v14a
	USzUZzYMmctEo8/7A8jUdKPYZgXTpF4yJi873dIfwPnuQqu0baB77oIpacWZKT8Ov14TwMGEHwd
	+aL4FG96Cp7lEqQ68/tJ+ZhOtWYZ4EsUvnGVjoQlaiV6cp+yLdxogYTPpZlGkNhH/HDp8D9zqQ=
	=
X-Google-Smtp-Source: AGHT+IEI19wWOEv8YZ18w+TjkiABH7btIaZS7NvAL6Op0w+BcszJCj70Cd8D/1/PYxxqGY2625dWkA==
X-Received: by 2002:a05:6214:300e:b0:6e6:5bb2:c1a6 with SMTP id 6a1803df08f44-6e66cd064f7mr220329296d6.28.1739910339666;
        Tue, 18 Feb 2025 12:25:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09a14d45dsm308921585a.10.2025.02.18.12.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 12:25:38 -0800 (PST)
Date: Tue, 18 Feb 2025 15:25:37 -0500
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>

On Tue, Feb 18, 2025 at 08:25:59PM +0100, David Hildenbrand wrote:
> On 18.02.25 19:04, Gregory Price wrote:
> 
> Hm?
> 
> If you enable memmap_on_memory, we will place the memmap on that carved-out
> region, independent of ZONE_NORMAL/ZONE_MOVABLE etc. It's the "altmap".
>
> Reason that we can place the memmap on a ZONE_MOVABLE is because, although
> it is "unmovable", we told memory offlining code that it doesn't have to
> care about offlining that memmap carveout, there is no migration to be done.
> Just offline the block (memmap gets stale) and remove that block (memmap
> gets removed).
> 
> If there is a reason where we carve out the memmap and *not* use it, that
> case must be fixed.
> 

Hm, I managed to trace down the wrong path on this particular code.

I will go back and redo my tests to sanity check, but here's what I
would expect to see:

1) if memmap_on_memory is off, and hotplug capacity (node1) is
   zone_movable - then zone_normal (node0) should have N pages
   accounted in nr_memmap_pages

   1a) when dropping these memory blocks, I should see node0 memory
       use drop by 4GB - since this is just GFP_KERNEL pages.

2) if memmap_on_memory is on, and hotplug capacity (node1) is
   zone_movable - then each memory block (256MB) should appear
   as 252MB (-4MB of 64-byte page structs).  For 256GB (my system)
   I should see a total of 252GB of onlined memory (-4GB of page struct)

   2a) when dropping these memory blocks, I should see node0 memory use
       stay the same - since it was vmemmap usage.

I will double check that this isn't working as expected, and i'll double
check for a build option as well.

stupid question - it sorta seems like you'd want this as the default
setting for driver-managed hotplug memory blocks, but I suppose for
very small blocks there's problems (as described in the docs).

:thinking: - is it silly to suggest maybe a per-driver memmap_on_memory
setting rather than just a global setting?  For CXL capacity, this seems
like a no-brainer since blocks can't be smaller than 256MB (per spec).

~Gregory

