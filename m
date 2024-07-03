Return-Path: <linux-kernel+bounces-240293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E93926B6A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121E01F2346B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBFD1940B9;
	Wed,  3 Jul 2024 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="siIf+619"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B1192B8B;
	Wed,  3 Jul 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045224; cv=none; b=jM+Gg1PToiFnQs4pNIwN91cliJVDzLfq9tGzhEDtSKunK/fse1cbD9E+xNpuVJMwXWKnZmIjCDs9cnCibG0RlSuQg0XKhzkxkgX3cIX3pw0m4DjWp5+tkK0mPCNTwUlbrvNi70zpcnc1wBXi7GzT2VXNNcv6MRDdONa2rOeNVxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045224; c=relaxed/simple;
	bh=hcPIFbainurPpTAFoI4UPkBI6xrcioZq8/qiC6q7334=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uez3WggjQQKoQlThLpnK2DBAdw3xS7PRXZ6jw+xcAtWXRWh1wEmexWnCaXwYbjq+COs4rBdpsVb+nO+T14XZZRHgQa5RQAPXyvjWObVxugumCHyPXRhYXRzbJabjlYXJ+hti2+LVXiuqvcR1GY6BBEmyEopymtkp2xFNAqGcvjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=siIf+619; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A7E3E4189E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720045222; bh=OtfBMzDwoTAjncrqEtY71x8y8FIwAWmDwFzR5bHhNaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=siIf+619bTrPmOauGDWFK/OWw9H6/FE3EGxoC9ZA3Fa3zmsPAlIwbtdjDTt9tVWYc
	 DmDQXu7lx7LDORdMtPqRP9O/JwJW9CjNtsn5QzqRNJqM+ywlBcPYTJndGZOkFvFZzs
	 7ODiCOB/wjehAhOk16g8YIvRWmIQhlmABeu3BqaKs6x3GyQC6zmubv9xs8p+kZvk5G
	 D3lyEV3gC/H9L4u1G50F8qop4CCEsBL45F3wWBjRnBrnLf4o2jTlQEjFdyBrHUrb8C
	 CdAy6qg5fpPFRnZzQFl/XL4gUh3ngAnwC4Yp1ZVlZeUMaoyIjSPFrsKZswDEhkVJlN
	 alrq7fp4L9AAA==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A7E3E4189E;
	Wed,  3 Jul 2024 22:20:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Docs/mm: rename legacy docs to unsorted docs
In-Reply-To: <20240701190512.49379-1-sj@kernel.org>
References: <20240701190512.49379-1-sj@kernel.org>
Date: Wed, 03 Jul 2024 16:20:21 -0600
Message-ID: <87jzi2t8wq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

SeongJae Park <sj@kernel.org> writes:

> The work for changing the memory mangement documentation outline has
> started from 2022.  For that, old documents have placed under new
> chapter, "Legacy Documentations".  The plan is to eventually move all
> old documentations into new outline, while asking new documents to be
> added on the new outline from the beginning.
>
> However, it is unclear where on the new outline each document should be
> placed for some cases.  Meanwhile, the name ("legacy") makes readers
> feel the documents under the chapter might be outdated or not actively
> maintained.  The absence of clear criteria for new outline also makes
> new documents difficult to find where those should be placed.  A new
> document was put on the bottom of the new outline recently, apparently
> not based on a clear guideline but just because it is the bottom of the
> list.
>
> Rename the "Legagy Documentation" chapter to "Unsorted Documentations"
> with minor fixups.

Series applied, thanks.

jon

