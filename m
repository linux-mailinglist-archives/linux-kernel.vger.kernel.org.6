Return-Path: <linux-kernel+bounces-364076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B038E99CAE1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754D2283FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FF01A76CD;
	Mon, 14 Oct 2024 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="hrQFYktC"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F70A1514CB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910841; cv=none; b=o6mE6M0iwwe27ta2C38Zg0E7+GBggZlb2rHItKsSsi2On/GRYgb4q8ZwhbgbUnT4Byz2b4zTkUnr9MRAwnAxPlL/km7buzKfmTXr78gYy/7z7YLjoBSI1WgdCzrC88OwWT7DwGyEZM7wzH69TLutjTQnT8Y14nTtWNBKLgz4VE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910841; c=relaxed/simple;
	bh=FF2RSxljEXLgy/Y1MMjK+7zYN3e31dBSTEd2m9uLVpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biyxqJDb3yhJ/rNnraisK3kboXnpzNY3/jfqXQWxBhk9ZO0fC6B6Mt2jdpDnYVBo2nmA4ixP+HenOzngg6C+YGkUmRke00QbEl5m/AxenXw0yBx1IcZqqND8w8HIm0ozwK9Id+Sm4+W/nirzPsga7xpYjpaOMS9Ps0i64VOClu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=hrQFYktC; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-28862804c9dso1710130fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1728910838; x=1729515638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HcEOyQjDS7a6A9bsQE6vr5VWzjSUJouS2AgRnzgA9wE=;
        b=hrQFYktCrvxtBR7P0NQi6nFi/uUviDMuWHsRbiiz6UoGkRZPqRPZ6qa/Hn8FbD6Kkd
         Me/4CM/KZxTQIoW2CpP85InKFaUDeeVHQIFBVPKiUdnwdCOVjHewiUDugZQ/4PzaWWSc
         os64B17Q1DTgtOcgpuG0iTNQe5SjRCxKU6mLp8MpSgGq+XJ4cbieHvBROa+fcDND6Zeg
         tlC6y5UmpKilESO4MAADEXxnvdGL9HopJLCr85bmZt+KfBaToexCE7velV4YizPC/Lvp
         hxhkCMHl0ygzzXhEKxrAyGtM4wZXMfPrVSQnkfwtC3tFBYvZ16qcNRAidaXTPw/HXu+Q
         lagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910838; x=1729515638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcEOyQjDS7a6A9bsQE6vr5VWzjSUJouS2AgRnzgA9wE=;
        b=Bw4aBsnNGc5d/Ul4hkZd9FWTKQXadHw8hnL6u3sd84LaR7xax8VO4llbJg2qqEhZsL
         bN/gaubVIydx19bgA0blzK9i5RNtKOlWYpvzKVSp1IncusIGbqsiXTH9n41VaDsReWYw
         MNpGBnw5ArRNwIxM6RoO5qxKZoYhqEl+nqlW4YKR7MjhwhPC94WIn2SWv6yOEbHgsLMr
         Ai1D3mfApDGX7FNzKEoA+H9vqsDe0BxbJmhUfuU3QDTW5MEKAVqYMV1TwKskkR45S/nR
         mMZ8YVXmkJ3LP/Cuulv8s3SS09xAee8tRNgppdq8F5hTuRp2apvhyeMH3X0ZmcTARTqf
         xB/w==
X-Forwarded-Encrypted: i=1; AJvYcCWgiT87JZb7uyK1iXKkJrGiEoIKUwnHHofJYQOctjXZsfYKY4ExZ5UY7SgFkIEsfzZh/poh167R9wBMSD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/D2FTMuoyJmUhEw28cgvlN0T8ccw9uGoZk3V/wa+r7G36uE/
	ERXqIQFF/0wZmWCmSnI+lL2tufmAZkgtM9yAmOT0stbAq+yPROcEpy1UQp0JAwm4yrYgL9gDbSS
	T
X-Google-Smtp-Source: AGHT+IGls0KX1bRa/5udb60IOUG7S3+RObbDPF9EP/nc4moCuctIsvmDxZp8/MHeexJO2YJQ3fajDQ==
X-Received: by 2002:a05:6214:300a:b0:6cb:55e4:54d5 with SMTP id 6a1803df08f44-6cbe5239cc6mr302364356d6.10.1728910819640;
        Mon, 14 Oct 2024 06:00:19 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85a5d49sm44835096d6.29.2024.10.14.06.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:00:18 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:00:17 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Michal Hocko <mhocko@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 03/57] mm/memcontrol: Fix seq_buf size to save
 memory when PAGE_SIZE is large
Message-ID: <20241014130017.GA1021@cmpxchg.org>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014105912.3207374-3-ryan.roberts@arm.com>

On Mon, Oct 14, 2024 at 11:58:10AM +0100, Ryan Roberts wrote:
> Previously the seq_buf used for accumulating the memory.stat output was
> sized at PAGE_SIZE. But the amount of output is invariant to PAGE_SIZE;
> If 4K is enough on a 4K page system, then it should also be enough on a
> 64K page system, so we can save 60K om the static buffer used in
> mem_cgroup_print_oom_meminfo(). Let's make it so.
> 
> This also has the beneficial side effect of removing a place in the code
> that assumed PAGE_SIZE is a compile-time constant. So this helps our
> quest towards supporting boot-time page size selection.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

