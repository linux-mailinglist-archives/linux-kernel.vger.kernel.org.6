Return-Path: <linux-kernel+bounces-232658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE06691AC70
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC301F22883
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C576719938C;
	Thu, 27 Jun 2024 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="VlS/Nbrw"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410815278F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505197; cv=none; b=Unzq3rIePeqi+75gVT9mmY+So7To5CwIgAt9TxfyoqQjNW1li5YAkHMR4KiW0wqjt8Zq8ff+2FOHEEGZxeB7z12I1k6FYVobzgkiv4YknvaQQZZxd3U8sjVdCKgmxI4yIXhJZZFBls7hAoiheVZv4SC8hjud9C/X4gXbsp3YzRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505197; c=relaxed/simple;
	bh=ShIPcqmQB5Xc15XjhG2AdGn5NMWWbZset19CjmSEbM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILT9yB0BgLEkqzN+3LLYEyK03+7MQyBCt/lJZiTe4qTcRWF96Vc0NA3L/2AsAJjFyZmoIFbbbg2yxg5Ss5dwNhwXfNjHdzvwPBV7cGs8BuoCnK9NdvDVVh/SscKO1boXqsKGbCviLRfAqxmH1Me1nzQNNKQ4D7aCK20Yrb6taA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=VlS/Nbrw; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6a3652a732fso32045766d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1719505193; x=1720109993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bThwXXxLsCowTNiAzmwpR6Uu07x6nxuk7Uem+NxoepQ=;
        b=VlS/NbrwpSpk8gTMcrTcD8pZlmOkjVRLIjaxDZmmZA2OukVOlOOCE0hh/AJoYsnqzN
         jvTJkHdMDE7LA6RhoLl+aRzqZdsrwJY6DQBpgDLBNMBSMmc37ArBG3wcWuV1bK/tOPW1
         e4tbTiad4q0/Sv4funKCACVG/AhA6HXMnL+C6LD9sS4ou36m9NMFas2DsbtPser0EM74
         gMSlhIWix/jwSzLVbhV+BApGVmb+UO5MPkr+E03x56HKvtK5/lj+JjkT3Fgruz1fqu2G
         SIv3ywCo8N6EHelLEsysoKMQ5dk//QUWi1u+sT+tnNAeB+gmZvmSw5UHEwy2dQcYpSTo
         be2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505193; x=1720109993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bThwXXxLsCowTNiAzmwpR6Uu07x6nxuk7Uem+NxoepQ=;
        b=fTuC5ajSlJ64uSsTqOoOi057hHO/jpDJ39jCuFOHkW2UC3dLaJSstK6n+7gWrLZ55Y
         mSDadIAwgVEcilzwbvBBLE5RhOF8hVd/4SsmWzQbiATdxwLjQvcjgbaxdJMNfntxUZkm
         R2ElBx0+uwxFk1+VYKkTQtZ5Yk3A4ZfAZIZh1sibLWZk5JTLszbsRLZlQQKSL3guIOTB
         Ly0s7kfzqjqqg2He+yraga//1sHoNrPnhInnMcKbA4/3Rm2lgzC4zLvjKA5ry4eMjS2P
         GgF7fdN59OqwDObejgRda0VrIryfEVAMt3Mcgh+NZDDRyH5Dw3RNrrd6fZLXMkbl0oXI
         Sweg==
X-Forwarded-Encrypted: i=1; AJvYcCUy3xjxGW1SPP72Wq5U3SwTyaurRs14ybcCJFCuk/aK9aVGkCnJgXQNtzB4yx+587xkvSt/thtZKJC/FwndQzcfWgSiRiDn6vdkGcX3
X-Gm-Message-State: AOJu0YyLbcR2JHB3uE3RpiYX/nmZl6k6Jwv8cb/I382nP1dOYRzaCJv+
	QmTy4s8ettFXS6rFX5nifqCyQ9rWWa8dxLj0xFncRjYOmXhHVfSr0tXMXxu2MLU=
X-Google-Smtp-Source: AGHT+IHH909svJOhMGT/Wjd/PkB+PwNb7jRISJkkhTcb9iE8KHrNS3Tsj4OTdZtT8qZCGAuUZE8xzw==
X-Received: by 2002:a05:6214:20e2:b0:6b5:24b:f430 with SMTP id 6a1803df08f44-6b540a91d2emr173819906d6.40.1719505193568;
        Thu, 27 Jun 2024 09:19:53 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59266eadasm6248656d6.89.2024.06.27.09.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:19:53 -0700 (PDT)
Date: Thu, 27 Jun 2024 12:19:52 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, david@redhat.com,
	ying.huang@intel.com, hughd@google.com, willy@infradead.org,
	yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v7 2/2] mm: remove code to handle same filled pages
Message-ID: <20240627161952.GB469122@cmpxchg.org>
References: <20240627105730.3110705-1-usamaarif642@gmail.com>
 <20240627105730.3110705-3-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627105730.3110705-3-usamaarif642@gmail.com>

On Thu, Jun 27, 2024 at 11:55:30AM +0100, Usama Arif wrote:
> With an earlier commit to handle zero-filled pages in swap directly,
> and with only 1% of the same-filled pages being non-zero, zswap no
> longer needs to handle same-filled pages and can just work on compressed
> pages.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Excellent!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

