Return-Path: <linux-kernel+bounces-281715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA1C94DA31
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 04:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCDCCB21DC6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 02:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E98131BAF;
	Sat, 10 Aug 2024 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g5uHBYuw"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC995C613
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723257618; cv=none; b=fpBphC20xvEi3+LAIoBQ8P+u0hfTzcXavVh7dRiqDmbPU4J6cVv8mBfCwBZxT+AQPqe+UR2jPoQrDzZoUW5oVP/IbyjCT7PtZs0aUakaOx8hfP5lUZR1m/zYw/84ZVXeaQ3o7eFEi+CPX0mZh2SoW5RG8mN0gJ5CqXp/tQzrtZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723257618; c=relaxed/simple;
	bh=/t4N2EpRej9Nw8dBm5BekuDxs4KN8eEZDhvk9yRRrCg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fLKgh6Wj/3gmjoXVXqj5KVDvwxsVXa5TijlLvuqLHOgnthZ/RmffpB7Nw11UgLpCT3zRq5EoCmsSYLOPIajQwT23A+rdRVKAvOaRNNHyFYlg/q+QhYuq0MHKjlPyCgSzimEJ20/+SKBMgw4imYitZ5Zo1LAufyUWaW9wVXxSsAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g5uHBYuw; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723257612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/t4N2EpRej9Nw8dBm5BekuDxs4KN8eEZDhvk9yRRrCg=;
	b=g5uHBYuw68UX4C7Nli5TccRTBS5K0bOHFp11jm7Cq2fGikdF8n3+EMxSwqgv0fBVpXxPMg
	A0P4h1fs86Ier/tFI6v08e0r8bgzh8JAqG4ZyxtRJcJC13SW0ZrJZ0UahCtuVITCW/ZRYp
	Zub2TPPjvRXT8DqJY9YjTVs1L/PWMtc=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v5 1/3] mm: don't account memmap on failure
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240809191020.1142142-2-pasha.tatashin@soleen.com>
Date: Sat, 10 Aug 2024 10:39:35 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-cxl@vger.kernel.org,
 cerasuolodomenico@gmail.com,
 Johannes Weiner <hannes@cmpxchg.org>,
 Joel Granados <j.granados@samsung.com>,
 lizhijian@fujitsu.com,
 Nhat Pham <nphamcs@gmail.com>,
 David Rientjes <rientjes@google.com>,
 Mike Rapoport <rppt@kernel.org>,
 Sourav Panda <souravpanda@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Matthew Wilcox <willy@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>,
 yi.zhang@redhat.com,
 alison.schofield@intel.com,
 David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <073C55C4-927C-4942-AFF1-E2D9D039F138@linux.dev>
References: <20240809191020.1142142-1-pasha.tatashin@soleen.com>
 <20240809191020.1142142-2-pasha.tatashin@soleen.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 10, 2024, at 03:10, Pasha Tatashin <pasha.tatashin@soleen.com> =
wrote:
>=20
> When we fail to allocate the mmemmap in alloc_vmemmap_page_list(), do
> not account any already-allocated pages: we're going to free all them
> before we return from the function.
>=20
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>



