Return-Path: <linux-kernel+bounces-246675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDC892C518
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DD71F23341
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82183180046;
	Tue,  9 Jul 2024 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DDl8M0DG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A8212E1E9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720558907; cv=none; b=poJ5EzsSHKT9YRWZxaidiDzypJH0lNEEj1NapwMyvry6iBeAlqZ1gd4QTV69qbwNGK/waRd72+t7w/ya4vZjBhJYS3BatNcL8PjxYkM6UMaqkHVLXhQBVyv0qVkVzea8VADJTXT2pYhycd6Y1SQsElc9TUh6paF1rXWQOie/+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720558907; c=relaxed/simple;
	bh=nkrdbazMCHas+a0mbP2+whIlpF50KyfgU5mX6kt1h5I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=vGW2xfL1CE+wp6R41ggpSq6GGeiaF/fVrZNOJSDVy5VcSWLwpqU4P+7eFoCh3vXjGeyLnnwamVhpHGlM1TGmv56bX/u2psvOwbHf+A9c0oeES1LriduqIJFZmFIdbJf7ONv1uC3wC5rFJATdHrg3vDnjwrVX6NHKlAQ7Qfo6/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DDl8M0DG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF879C3277B;
	Tue,  9 Jul 2024 21:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720558907;
	bh=nkrdbazMCHas+a0mbP2+whIlpF50KyfgU5mX6kt1h5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DDl8M0DGgSr5RFS9OcSCoJUpy4t8+fF1B4lbxyLC9qhY0NeBqAV89EmIl1QThq9gj
	 o4qVOGRGzvDSN+O2nJd8AAcKDtnzRq02ibHPp2REdcx2xVgn/DW7VVY2C5v8e6C6nF
	 L60f8rmb0s/pnZhfTcem76jPzD8psOhOLawski30=
Date: Tue, 9 Jul 2024 14:01:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Zi Yan
 <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>, Hugh Dickins
 <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Huang Ying
 <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/migrate: Putback split folios when numa hint
 migration fails
Message-Id: <20240709140146.d56769d71a596e6fd11901f2@linux-foundation.org>
In-Reply-To: <Zo1Nd_aLq_tFDMoc@x1n>
References: <20240708215537.2630610-1-peterx@redhat.com>
	<20240708160407.a0c51eb11d0403c161d27540@linux-foundation.org>
	<Zo1Nd_aLq_tFDMoc@x1n>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jul 2024 10:47:19 -0400 Peter Xu <peterx@redhat.com> wrote:

> Considering that nobody yelled after rc5 until now, and this is only
> something I observed when looking at the more severe issue Hugh fixed..
> maybe we should target this for next release, then stablize it and wait for
> a backport to 6.10?

Sure, let's do that.

