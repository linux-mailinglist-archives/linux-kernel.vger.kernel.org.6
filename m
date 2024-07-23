Return-Path: <linux-kernel+bounces-259535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C5E939803
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19E81C21A44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64E1139CE3;
	Tue, 23 Jul 2024 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PVTXrXJ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702D136E3F;
	Tue, 23 Jul 2024 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721699030; cv=none; b=pQzWglqJg7CYv1r+WkRj2pxmbknqQF/L2cKc7zkbxeoGb9HfAUD333c9LDZMO8PSjNHxHj6mqMfURGxjGmv5RFA7G54dmz5T7hFMDeWTiE3/kL6U9nr1BOzKzSiqjo83G3d5XlTZMKJMVG2/nk2b/5mMCCsBKE98c+ZuSS/FBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721699030; c=relaxed/simple;
	bh=uLE4/Kk/lWZmHiZavjPUPKJ4gYq6j64EmWnd8S2dSew=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZIyV1HaMPVSg5cUQ/S7SRnG8GgwA7P2K/WUXlr7PdsbSTbiVT4HsIOZkOhNOpp7qdw6VLSkT6QEWzoDWA000BYy8CseBXxiolJlbcGl0YZWKeAMgDzdgFvVrRuUPVhmjcOAxrwTJLnjn7onLg/kmylkoGLkqFQ7ar1ni9+S/e+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PVTXrXJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A4DC116B1;
	Tue, 23 Jul 2024 01:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721699029;
	bh=uLE4/Kk/lWZmHiZavjPUPKJ4gYq6j64EmWnd8S2dSew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PVTXrXJ0noRS7iTqzd+vPAnX0VHUg2MDw3tsmuDzh9F7od1olKPkNiUtapKIHv3WW
	 3Mr7XTwhNkRmuyaJwdSjzpY7+lS9raO/zWCTZ4Uiby3NGcUG6NBeI9bQRsxhsaZ2Hr
	 7RrlQ+LBwT8c0S+Hdi+4JqJqFnDc/nilJ6pCgxow=
Date: Mon, 22 Jul 2024 18:43:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, urezki@gmail.com, hch@infradead.org, kees@kernel.org,
 ojeda@kernel.org, wedsonaf@gmail.com, mhocko@kernel.org,
 mpe@ellerman.id.au, chandan.babu@oracle.com, christian.koenig@amd.com,
 maz@kernel.org, oliver.upton@linux.dev, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: kvmalloc: align kvrealloc() with krealloc()
Message-Id: <20240722184348.3df3b433c8f49f123e1c8d9e@linux-foundation.org>
In-Reply-To: <20240722163111.4766-3-dakr@kernel.org>
References: <20240722163111.4766-1-dakr@kernel.org>
	<20240722163111.4766-3-dakr@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 18:29:24 +0200 Danilo Krummrich <dakr@kernel.org> wrote:

> Besides the obvious (and desired) difference between krealloc() and
> kvrealloc(), there is some inconsistency in their function signatures
> and behavior:
> 
>  - krealloc() frees the memory when the requested size is zero, whereas
>    kvrealloc() simply returns a pointer to the existing allocation.

The old kvrealloc() behavior actually sounds somewhat useful.  You've
checked that no existing sites were relying on this?

And that all existing kvrealloc() callers were (incorrectly) checking
for NULL?  Seems that way.


