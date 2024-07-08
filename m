Return-Path: <linux-kernel+bounces-244871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE76392AAAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE12B21525
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C691146D53;
	Mon,  8 Jul 2024 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="av0MUt9N"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8516BA29;
	Mon,  8 Jul 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471074; cv=none; b=g7tqSON6cNFxpSS8WiAOE9B8YHJfBeAa4qVZxQislP3XUw4EsjJju4X74dBJWE1ba2JHkvYQKQ3GqJjJbovZQcNd6E67O/kayUUheh1fSM/8NEM6+/ZEvXHfNLSdwOu81wrN+TNvk/O5up1N5FE28U2RvlWQG3XsIfTfSOWV1gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471074; c=relaxed/simple;
	bh=mo4uIm8yE7RrfkHDvUCvGxDtl0e9GHqXF0pg0kMkkWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn79ND2qIYHlCc2H5vPkd4vZAl3gzApLWy/PCLAlmSMK30tSo59u8BBgwQbxQrID6VlpEKYhFqkmZPTPQL/0cEBH7XOtlZLmCjQDLSdXLuvC+DMrKyMqkwAVUHWmmxo2UYY/hLwEFrH9GIAGOAvm7tRLTvP1BR9xdWik7jaDljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=av0MUt9N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bEIonm8o3Z//EQ4oEDJ3E4tPRrv5MLDelE43erip8lc=; b=av0MUt9NkaEABUi+JvBsD3Yw8i
	+zFK3QP5oYo23xmQfM7HfGMUvZdQqJ2u6/yum4OXxCthC/4EWU0jNhUnY3U5FYsVRXLll1ZbQa6Bm
	1EhwZVsAzds4A3b8YUM5LKUlIlJAVjmlgsNeq3tEpq6eyEB8OA5boQw1KsNkoWOMGx++3ZOqRE0Kn
	Hz9m2QjpAJjHnTUzjkVK3f97s1Tev8VXzn6SDV2loGz8TfpdwEq02AF/g5jP5MYDIglXt1kcSez/g
	uSCrtPFHJHKi5yZoxXKyptTgXWr4H6Z8f0wkAsQNzfncNm28kMv4MLPkOsyRUMZV0hZY5xg93PnzR
	i+KBa6Xw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQv7P-00000004zCW-1Qg4;
	Mon, 08 Jul 2024 20:37:51 +0000
Date: Mon, 8 Jul 2024 13:37:51 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org,
	chrisi.schrefl@gmail.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH v2 2/2] firmware_loader: fix soundness issue in
 `request_internal`
Message-ID: <ZoxOHxHze2ynJS-q@bombadil.infradead.org>
References: <20240708200724.3203-1-dakr@redhat.com>
 <20240708200724.3203-2-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708200724.3203-2-dakr@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Jul 08, 2024 at 10:07:21PM +0200, Danilo Krummrich wrote:
> `request_internal` must be called with one of the following function
> pointers: request_firmware(), firmware_request_nowarn(),
> firmware_request_platform() or request_firmware_direct().
> 
> The previous `FwFunc` alias did not guarantee this, which is unsound.
> 
> In order to fix this up, implement `FwFunc` as new type with a
> corresponding type invariant.
> 
> Reported-by: Gary Guo <gary@garyguo.net>
> Closes: https://lore.kernel.org/lkml/20240620143611.7995e0bb@eugeo/
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

While you're at it, can you go ahead and extend out selftest coverage
for the firmware_loader so we can test Rust too? Could these issues
have been caught with a selftest? If not why not?

  Luis

