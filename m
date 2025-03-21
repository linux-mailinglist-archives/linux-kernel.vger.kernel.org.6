Return-Path: <linux-kernel+bounces-572107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE1DA6C687
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33633A9259
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859B62206B8;
	Fri, 21 Mar 2025 23:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rW6gV7HH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9551EF39F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742601193; cv=none; b=o0hX8+rDLLofDgf9YIi836R88ljJd7Sgqn9COsEDyFgw1wuYlc74PtyLH0Mk87DyGVMxyKpnerGXc9UQ5bWJTB/ZE8Ix1jVAWctAvk0A607BxwgEAUyEjfQAeD0+Z7P7KkJ3DzaSAK8BgSPrniQUUxFyx6kYd0dB+MwwuY3+2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742601193; c=relaxed/simple;
	bh=TEY2yXDUKVYLRAs/dwMUuBs9Jo4hjLJ/j1NqGNyR9go=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iB5eqYtpx5ILbfcsUq6PeRkDREQFTUm/I1toBHyuKi0pGGIm8AWnb8RO3Na8m5fyiCedc90q0N1XDkfBNzIpuK1IKkEUjl/R+Z3jQUPbR5r9J5y8lSJrIaE1xmmW4Wyn+ujryW3LqKMrS+Lys/uxbxAoewp9Y906Wjg7bJjz1CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rW6gV7HH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEB5C4CEE3;
	Fri, 21 Mar 2025 23:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742601192;
	bh=TEY2yXDUKVYLRAs/dwMUuBs9Jo4hjLJ/j1NqGNyR9go=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rW6gV7HHwLr9jI43m29FCZC/a4Swa6sR+2sZTxWGun/kXZIYrs73OXMUkQLooC+w0
	 GMGtNes09qEvSPOqCGz0CWdAGfeDX0d7KngrQt4h4m9/lUYHPoibFKkeRWccG61tM3
	 nknKLsvmnsXOGeYMNjg3ERazLJRGiLOJ/iNyjZ+s=
Date: Fri, 21 Mar 2025 16:53:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Gavin Shan <gshan@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 linmiaohe@huawei.com, gehao@kylinos.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v2 2/2] mm/debug: Fix parameter passed to
 page_mapcount_is_type()
Message-Id: <20250321165311.fac5a8d9b37c69d977df210b@linux-foundation.org>
In-Reply-To: <3e6040c1-81f4-4977-bbb7-70908104aa45@redhat.com>
References: <20250321120222.1456770-1-gshan@redhat.com>
	<20250321120222.1456770-3-gshan@redhat.com>
	<809792d8-8717-41d9-8dd8-ca91a5b54a28@suse.cz>
	<3e6040c1-81f4-4977-bbb7-70908104aa45@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 16:38:29 +0100 David Hildenbrand <david@redhat.com> wrote:

> >> -	mapcount = page_mapcount_is_type(mapcount) ? 0 : mapcount + 1;
> >> +	mapcount = page_mapcount_is_type(mapcount) ? 0 : mapcount;
> > 
> > At this point it would be perhaps more obvious:
> > 
> > if (page_mapcount_is_type(mapcount))
> > 	mapcount = 0;
> 
> Agreed, maybe Andrew can fix that up.

Sure.  I'll be adding this series to the 6.15-rc1 pile.

