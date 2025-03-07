Return-Path: <linux-kernel+bounces-551697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE10A56FA0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB91189AE74
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D8423F40D;
	Fri,  7 Mar 2025 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sTMNuu3y"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0206223E227
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369880; cv=none; b=ZoZxLldSnIA4iu7F3dwrTEmgHoMfncljJEDhBtRcFgo5NnonGVIEfz975YRDSl0hGaQElFwF0Gex1kizo/5P8CbopHEdQbp1QHv1dtQtTGMCjFxLBRmiEELk5YXBcG7fiYaP3e4Rm4t9tr6pIWdZ6fC6oQM1Zofjm09J47Et32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369880; c=relaxed/simple;
	bh=4eYoVXz9byhRWXUVeCRZzyjBpS2VnJ3o4+kQ06tRzgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjmAebt5tF7rLIk5M7ZJf5DEZgVpiOadhm1uZnwlA2yesCuDVyIYdOF1SGyDWS4e+pCg7AoJ3HNbza4dvHgcw8K6SSbCYwL/CFIbT2UDP6DrYTlVQYY+7kzouyW+rOeNck0+8fXiiKYV9bQOTUTtrcdSofQcMTy5s3JPbAqhBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sTMNuu3y; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3be0d212fso312479385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741369878; x=1741974678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10uJGrqMsFBItujH17O3D7mXz4AwXzBXZFwQYXseYww=;
        b=sTMNuu3yRDp4vKTkPNX3jWOUOrlYb1O48y1b7VGIR83XwcVGkI7TOyg8L2YslPhdfH
         QEylZq7Wru5jNpe+1/Zsk34iLky04gKdKF0H31Qu6GgYk+zbPMVIE68JBWcofpItYnlh
         28su6lh0uIZ2xKdxEDwaFr+16jLxyq9KlYm0UaK6lexN69dw8D2HPsbF2N4aimjcFb5f
         6Op3l9a13EfslWyKhMJpagzFt+p375xD8+jppwPS16CqZwpHZnpVETd2SDiFK9C19HVg
         /Zk5gI32yT+7DuxRSd7jdwKoby1Msm2e1l6QDPmfcICHO1gGyTaww0Frmw7C9PHzG2GC
         whlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741369878; x=1741974678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10uJGrqMsFBItujH17O3D7mXz4AwXzBXZFwQYXseYww=;
        b=C5CaI6Rr/x9OJW4syciWxcxuaKXJLxSCiXPRJvhubzLHHunpCC6+5Oe1OE0pYhYPZ4
         sllE5VGt3KnfOHz1Vn3/RAKSr+FA1LfY5Kx4czDW23vcpuGqX8WL2VRfnrp9Igm0mOYO
         ma3ZA77U8L8eHJdA4Fidm3R8NrGA3BluTXYqgDE3ljc43mvbzhy2vnArGJxj6rYSsIYg
         QrT1JEQDie/Wl/wMNXI/fFC7fJPIo+ZGcqggUCgk/dO2Hiv13ilgny1E7gvFZLvkJdCQ
         NwS8U5tuRnFdTt587tp70wa624H8+T/20tQdX4LqRz00SPgkr5u2B7dmJAMWzJl+aH2c
         G9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVDACn6hBezXOM+H/I+bUat+Di7z/NSrz8qwx9FgoQbR//+KGvf2xR5QIAnKCgdtEcwsn8NU8JoWdJMbWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/ZsWfca/M5TxKX0lMTKWUCOCRhgqT4Gvfan/IvQlIaRzgpbz
	glhHkjNAabJwvNCGz0vnX4fQT99iO0Au89O3qkRli6UyKVTl59XFweD6tCIQuXE=
X-Gm-Gg: ASbGncvqJdEJA00GmM1Didkd25Z+urbjB6zEfDk1xC7yl5b6QU4jHSpZWBXjpAQIwNy
	zVo40UYZ7IEJNUS7K4AcoyV2ICgMOgXWAT307Z3jdF7LUixDby5OBFS1kjng/wBiH3zTQi33H2z
	6exW3VO4bNsG2x9W9sSlRXxASj3zwAANP5etc/kuy/JlpnA23tBxroNPgLFnsuWcU5Nz91AwEcu
	9nO5kjshrpmB2O6IHtej0WzSlRQW0rTaHX9VN/Is9xe9J9KW6p008OGnvo74ZLQ+2KRjTQfe9DV
	Ggv2QY51ZcKa+EQOqZnpowo6f7RAsYALXONxJWIDZ88XZw6pOIbY6aZtvcC3LwBq4BYfZkwRAng
	pLRo5Z9yKvsaZY1OEuLjg31Jau/E=
X-Google-Smtp-Source: AGHT+IERTGeaFD6Oo8MeSWNHRrnPOT/UcHdFepnkS2d57xd8PUhjt0HaOYtF9qIzkGsUGgvoWm3nJg==
X-Received: by 2002:a05:620a:8905:b0:7c0:b0eb:4fa9 with SMTP id af79cd13be357-7c4e16781f3mr735549585a.5.1741369877806;
        Fri, 07 Mar 2025 09:51:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5511c63sm267058185a.113.2025.03.07.09.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:51:17 -0800 (PST)
Date: Fri, 7 Mar 2025 12:51:15 -0500
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
	harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
	gregkh@linuxfoundation.org, rakie.kim@sk.com,
	akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z8syE7l5H35pk9T5@gourry-fedora-PF4VCD3F>
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
 <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
 <Z8cqe3BCdobsV4-2@gourry-fedora-PF4VCD3F>
 <f64819e2-8dc6-4907-b8bf-faec66eecd0e@sk.com>
 <Z8ncOp2H54WE4C5s@gourry-fedora-PF4VCD3F>
 <9c0d8aa8-cac7-4679-aece-af88e8129345@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c0d8aa8-cac7-4679-aece-af88e8129345@sk.com>

On Fri, Mar 07, 2025 at 08:46:46PM +0900, Honggyu Kim wrote:
> You can see more info below.
> 
>   $ cd /sys/devices/system/node
> 
>   $ ls -d node*
>   node0  node1  node2  node3
> 
>   $ cat possible
>   0-11

We're split across two threads now, but i'll add this context

I'm basically asking whether there should be 12 nodes possible. It seems
like there should only be 4 nodes possible - 2 for sockets, 2 for host
bridges.

Unless I'm misunderstanding, it should be the case that a given physical
address can only be hosted by 1 numa node (proximity domain).

So it *should* be the case that you either have 4 nodes possible or 10
nodes possible, not 12.  But I could be missing a piece of context.

> Which command do we need for this info specifically?  My output doesn't
> provide some useful info for that.
> 
>   $ acpidump -b
>   $ iasl -d *
>   $ cat cedt.dsl
>       ...
>   **** Unknown ACPI table signature [CEDT]
>

You probably have an old version of acpidump here, you might need to get
a newer version that knows about the CEDT.

You'll also want to get all the Memory Affinity entries from srat.dsl

> Not sure about it.  This must be fixed ASAP because current kernel is
> broken on this issue and the fix should go into hotfix tree first.
>

I agree something is broken, I'm not convinced what is broken.

> If you can think this is just a bandaid, but leaving it bleeding as is
> not the right approach.
>

This affects userland, we shouldn't thrash on this. Lets get it right.

~Gregory

