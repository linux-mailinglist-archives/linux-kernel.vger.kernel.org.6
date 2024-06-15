Return-Path: <linux-kernel+bounces-215628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CA690952C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 03:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40711C2162C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000A1440C;
	Sat, 15 Jun 2024 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gpBsYYuM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466101FB4
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718414392; cv=none; b=fB1IaGpN+D/oWnloqwSMpm2CgsolAXbaEZz6aox4kU/kOLNM+RU3S5diUgeoKdaKAqIfBt1yPTf9BBt2DTfw1/+T3sYxL8phAQRcQ7UXkPvemi/25n3FSz5lCJKW6mY9enOYZaP5wwHDMakqHmAEc8cmWYUnpvTlr3wXEJLv6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718414392; c=relaxed/simple;
	bh=ilNXTmA99Z0S3RmVkDwTAq3gTOlyn5NNkcxVzym5pxo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZCo20tLqADswUw7q6gXoTHUE0Nsn3IiJWpjG8h29i9iD/r/iGm0uq3Ug3Tyb7KpSE1OGnMzdyYQdxd4C+x+OJXu9ndPHbG40xDs/T65V04CuXmZ1QkWZ1zBday18DJ69US+tU5hPgI7g90JrQlQd7mmhjvKzAFf3buxIw+FCmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gpBsYYuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5BDC2BD10;
	Sat, 15 Jun 2024 01:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718414391;
	bh=ilNXTmA99Z0S3RmVkDwTAq3gTOlyn5NNkcxVzym5pxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gpBsYYuMFqpgRL4nip0qVXAWMcvM2hVCCIGgF6FeqesFYqYu5gsDug5FV8kGGtYUk
	 XI1XdXs8YSQsZSQuZoXLqMEUec/2i2AiLk73P8KOq/azYdsqJm0yakL/8FY6VhU3iJ
	 blbPXAXB9IxUFxyND049OFuSImTIHfDwAZNVln+w=
Date: Fri, 14 Jun 2024 18:19:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com,
 souravpanda@google.com, keescook@chromium.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: handle profiling for fake memory allocations
 during compaction
Message-Id: <20240614181950.d5cd06acba24339401c98d6d@linux-foundation.org>
In-Reply-To: <20240614230504.3849136-1-surenb@google.com>
References: <20240614230504.3849136-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 16:05:04 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> During compaction isolated free pages are marked allocated so that they
> can be split and/or freed. For that, post_alloc_hook() is used inside
> split_map_pages() and release_free_list(). split_map_pages() marks free
> pages allocated, splits the pages and then lets alloc_contig_range_noprof()
> free those pages. release_free_list() marks free pages and immediately
> frees them. This usage of post_alloc_hook() affect memory allocation
> profiling because these functions might not be called from an instrumented
> allocator, therefore current->alloc_tag is NULL and when debugging is
> enabled (CONFIG_MEM_ALLOC_PROFILING_DEBUG=y) that causes warnings.

It would be helpful to quote the warnings for the changelog.  And a
Reported-by:/Closes: if appropriate.

I'm assuming we want this in 6.10-rcX?

Please help in identifying the Fixes:, for anyone who might be
backporting allocation profiling.


