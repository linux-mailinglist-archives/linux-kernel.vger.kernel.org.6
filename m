Return-Path: <linux-kernel+bounces-197621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB82E8D6D2F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA0F1C2158F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 00:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F71D3C30;
	Sat,  1 Jun 2024 00:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XEPfHq95"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419FEDC
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717202305; cv=none; b=K1CGsHDPAMKk8FzFIUgE/aYK7DAPv12jo4t4B73MMbr4DSD0ShB+q15AjY5AMdQvUSH0wQILYC7EuvSE0A0IvTWpVMtOTVYLrUC4udbOs6uDn5iTVNxleEGO/LZYI+Mds8FU2OugrpOwmDbRdlTRY6AB6PzaNtw4Gui1HERKx7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717202305; c=relaxed/simple;
	bh=4hmjM0UxydhUZza82YHCth9Sj1TFopzUWYdExi8Y+ps=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WOj7m0qFjlZ7ORO+ArWxzq8KqEEG1gvTOHGs0eGY71vhUm04zLS4CUfa4ZpnIj3JrH0uujlEkbVxdL3gDosKbSu6EJSTvhwY/msxIU8Lo62I6hkCenSpj7k5PNOQ+7Gofk6osKAqSMbPEFqhzdM03L9DsfphTZg7K3TydgMc0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XEPfHq95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4326CC116B1;
	Sat,  1 Jun 2024 00:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717202304;
	bh=4hmjM0UxydhUZza82YHCth9Sj1TFopzUWYdExi8Y+ps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XEPfHq95tZ1aJQMXPja1E8IqZy4rexHmWp0iBOOB0OTCFho8Ql7VXEbGMzYigg3hd
	 JjHiPLp3BFSTHPZwBzry59vy+fTxRAuDunP8li0et+GKwmB8ZgG8lWdyZ8DPubGIA8
	 Em/a/V2spFlZopuIqcVPUKi2KOCXslvHZ3Q10FLM=
Date: Fri, 31 May 2024 17:38:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, jpoimboe@kernel.org,
 kent.overstreet@linux.dev, peterz@infradead.org, nphamcs@gmail.com,
 cerasuolodomenico@gmail.com, surenb@google.com, lizhijian@fujitsu.com,
 willy@infradead.org, vbabka@suse.cz, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] vmstat: Kernel stack usage histogram
Message-Id: <20240531173823.4ec7b4693a4e433b1da91e75@linux-foundation.org>
In-Reply-To: <CA+CK2bCuiDAv05Xu6OuKB=gqJ5NM20F_uUyJV8E=XH=r47ik=Q@mail.gmail.com>
References: <20240530170259.852088-1-pasha.tatashin@soleen.com>
	<cq7537bswpnbsmeiw3rh4ffrgqky4iufsaurukpk2flxts6jcu@6ctttkclvf3f>
	<CA+CK2bCuiDAv05Xu6OuKB=gqJ5NM20F_uUyJV8E=XH=r47ik=Q@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 20:14:17 -0400 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> > Couple of questions:
> >
> > 1. In future with your on-demand kstack allocation feature, will these
> > metrics still be useful? (I think so but I want to know your take)

I do think the changelog for this patch should reference the dynamic
stack feature.  It strengthens the justification for adding this patch.

> It depends on how on-demand allocation is implemented. On hardware
> that supports faults on kernel stacks, we will have other metrics that
> show the total number of pages allocated for stacks. On hardware where
> faults are not supported, we will most likely have some optimization
> where only some threads are extended, and for those, these metrics
> will still be very useful.

Also useful changelog info for this patch.

Pasha, could you please prepare some additional text which I can paste
in?  Thanks.

