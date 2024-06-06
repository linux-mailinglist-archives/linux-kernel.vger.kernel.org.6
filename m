Return-Path: <linux-kernel+bounces-205135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C778FF7EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B652881E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D346C13F015;
	Thu,  6 Jun 2024 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zsAdcru/"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624406CDC8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 23:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715078; cv=none; b=T+LZxxvCUSkmuuQuromzCoEEGUh7WcDBtS6tRTwjRwFIc+ZjYD0WL1GfaXsise42L4/AUUE2vg60Kp74Z5cN5I4afSUIwkiX0jU/pEjlu7L6xPfyVtkRkM23o1DVM4qZukXopSL/UgrNV6GT5k1KlEKGUJ2QAFdsuA5SnlrlLdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715078; c=relaxed/simple;
	bh=Q8bxSKsew92PdeFJ/YvuL9+HqLlwXrZwlBtMxipH6zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgsR1cOKVg8bxcjq+lSmai5R8abLbfzZXhRQC6y2U0QSYIS1dkrjimoSX29cSReLUa96Tx+YsF/qHrjTw7wV9aMij3ySBAUVt/Nxd2GtKqshbBfsz1zz3WVsLdwoLVDoY7rhzfX0y2nkLi59J38ZqqnnoCZjt1IfaEV31VEOzTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zsAdcru/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35e4aaa0f33so1571404f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 16:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717715075; x=1718319875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8bxSKsew92PdeFJ/YvuL9+HqLlwXrZwlBtMxipH6zQ=;
        b=zsAdcru/iAIoDNDHYCQbDFyh06dJIBLwZxDBTtirqrOmyKsQpapVO1xyhVwJJ0VKAw
         Gdy571chKnxSnLBCx0DlLJq2VfbNASZcLX9BY1OcSsPdlDJNB/Ei/224oNVQxrr5vYIr
         2YEscKow2FPW/VEKx1bvgZBqSYhrHuR5B0IkzF1uEMGhVUI4Y6Vq3dHscOZhYvu9htMs
         vyLTtw3Hy6V7vLIIvrLP7AZaGzpRXOF7oDT3QZ8Zuy4LoMILQDqQ2zjCvLFBaWc57/EY
         w3IRQcJSGs1OEpTjCGOgkmWRAq7N/7GX9jnTHCZ3ucMBU2lp8SCpKuIr6hv3zRrDSzva
         HDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715075; x=1718319875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8bxSKsew92PdeFJ/YvuL9+HqLlwXrZwlBtMxipH6zQ=;
        b=Df6naQJ9lQ4qrpDkmprmoOMzrF286PlNS/dFN0GSbTcS1G1T2xQwRdlCmNbmQqYxir
         /aLTCem2LtdGTjYbg6ywIbkasnh3qfzEBaKHY3ECGgSIpjQFCTIzzfg0lBwClrtQ/ccW
         N3d+2oqpchElSwg4dEU5xXYZ9BlYo1E4YdpJBgefg4QSN3z4GRXmRR974iLXf6gasLI4
         N96cSuKPCuPLJctgHS/crpIUeJ0GTk8stJivKrtpFFQvk/gWevg1MaQLFhweuM51dgV+
         zs76OyKeA1zjjBJxuKm9USHcg9Z5LbWDTRuLwfd+wuJjbFX/6Z7J5ZDtd7HuMIC8StB4
         9OOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX7a+1h7eeuyAAzV8mh6BBPEBWJOzMFLvB2RdLrK5shHNbha3GsjH+vre7dSI7ZzuPYWUbdveUCjvVImEgz3SLvBN6rClAWgUOyEjy
X-Gm-Message-State: AOJu0Yx5bBQRosEYXyLXmTUXlaPB0DVjKWuAD/NR0td1d6jC6+Ph7N6r
	vLm7OLjaA2SM3c1T+fTkenycHTZHBG3QBIy9eh2TdVK1eTJk0K+1X+/8A6CCRpYX788MDr0sECx
	EcbMc9WVLeyg2hXbiL/v/gAhejfGrjh7CamgK
X-Google-Smtp-Source: AGHT+IGfKu8GCyHss7A0fzkmGAXuAZw8ZVlbxzPX7Md011kCn7oVjvjpflSy8Gs4VzJFgsXWjLX4rVqw9mOPvuUX7+E=
X-Received: by 2002:a5d:6da2:0:b0:35d:a567:40b8 with SMTP id
 ffacd0b85a97d-35efee11d3fmr1050487f8f.59.1717715074495; Thu, 06 Jun 2024
 16:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604175340.218175-1-yosryahmed@google.com> <ZmI573n9-SoK4dIg@google.com>
In-Reply-To: <ZmI573n9-SoK4dIg@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 6 Jun 2024 16:03:55 -0700
Message-ID: <CAJD7tkbO+ZLdhs-9BpthztZX32i8C4=QEnoiXGS7bM399nqwzg@mail.gmail.com>
Subject: Re: [PATCH] mm: zsmalloc: share slab caches for all zsmalloc zpools
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Vlastimil Babka <vbabka@suse.cz>, 
	David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, 
	Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:36=E2=80=AFPM Minchan Kim <minchan@kernel.org> wro=
te:
>
> On Tue, Jun 04, 2024 at 05:53:40PM +0000, Yosry Ahmed wrote:
> > Zswap creates multiple zpools to improve concurrency. Each zsmalloc
> > zpool creates its own 'zs_handle' and 'zspage' slab caches. Currently w=
e
> > end up with 32 slab caches of each type.
> >
> > Since each slab cache holds some free objects, we end up with a lot of
> > free objects distributed among the separate zpool caches. Slab caches
> > are designed to handle concurrent allocations by using percpu
> > structures, so having a single instance of each cache should be enough,
> > and avoids wasting more memory than needed due to fragmentation.
> >
> > Additionally, having more slab caches than needed unnecessarily slows
> > down code paths that iterate slab_caches.
> >
> > In the results reported by Eric in [1], the amount of unused slab memor=
y
> > in these caches goes down from 242808 bytes to 29216 bytes (-88%). This
> > is calculated by (num_objs - active_objs) * objsize for each 'zs_handle=
'
> > and 'zspage' cache. Although this patch did not help with the allocatio=
n
> > failure reported by Eric with zswap + zsmalloc, I think it is still
> > worth merging on its own.
> >
> > [1]https://lore.kernel.org/lkml/20240604134458.3ae4396a@yea/
>
> I doubt this is the right direction.
>
> Zsmalloc is used for various purposes, each with different object
> lifecycles. For example, swap operations relatively involve short-lived
> objects, while filesystem use cases might have longer-lived objects.
> This mix of lifecycles could lead to fragmentation with this approach.

Even in a swapfile, some objects can be short-lived and some objects
can be long-lived, and the line between swap and file systems both
becomes blurry with shmem/tmpfs. I don't think having separate caches
here is vital, but I am not generally familiar with the file system
use cases and I don't have data to prove/disprove it.

>
> I believe the original problem arose when zsmalloc reduced its lock
> granularity from the class level to a global level. And then, Zswap went
> to mitigate the issue with multiple zpools, but it's essentially another
> bandaid on top of the existing problem, IMO.

IIRC we reduced the granularity when we added writeback support to
zsmalloc, which was relatively recent. I think we have seen lock
contention with zsmalloc long before that. We have had a similar patch
internally to use multiple zpools in zswap for many years now.

+Yu Zhao

Yu has more historical context about this, I am hoping he will shed
more light about this.

>
> The correct approach would be to further reduce the zsmalloc lock
> granularity.

I definitely agree that the correct approach should be to fix the lock
contention at the source and drop zswap's usage of multiple zpools.
Nonetheless, I think this patch provides value in the meantime. The
fragmentation within the slab caches is real with zswap's use case.
OTOH, sharing a cache between swap and file system use cases leading
to fragmentation within the same slab cache is a less severe problem
in my opinion.

That being said, I don't feel strongly. If you really don't like this
patch I am fine with dropping it.

