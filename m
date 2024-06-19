Return-Path: <linux-kernel+bounces-221793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CC490F89A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C341F22F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023E515AD93;
	Wed, 19 Jun 2024 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1zB9xn9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4895E14277
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834005; cv=none; b=qkVJfNkoEiTzm6R+KFKxFpKfGCACtYMcelsK7607dkTqHHGbIChawXSFB0Y2XLuGtljjZFUIyo6oGvu2At5iTzHk+e+4+9CQf1wxdTF+zJUry3Ow2KCYKCVV7kusW2N8Pcz9JuxyYpMebW8we9UunuMg5mmdDzPiMvFHk7SBXac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834005; c=relaxed/simple;
	bh=ik3/SNXZztDENIS5byMNDl0QRzOh2H6BTGRmfxVgcuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8+jUj8viXJJjVhh1NxCHLqdhhmVk1/Yf+nz82xdFDoqD5TzL2TOEEOd2NEOBnI0n2tVdGjWdJbO8HMgQiLAYnOeWRYKqgMytEM1y3bsXpApsA/fXB28YYRl7a3kMJU7GelPbJXDVmkIBzlNeww/gZdaOwU8SCh3Ox7xvOSvEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1zB9xn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6148C2BBFC;
	Wed, 19 Jun 2024 21:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718834004;
	bh=ik3/SNXZztDENIS5byMNDl0QRzOh2H6BTGRmfxVgcuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1zB9xn9PvO4oADyyjfHM2Q0NGTOVIJ7z4g57z/oJr6A/oHVAIdEJATJOOuidDa5A
	 9/N+e8dtHDrb/q5Ohf8ze/yylnIzgJlEGZSz404dN5dpwCl38O59CXMPVKbX5eIf2u
	 ZPH5IV9fzCQS1jW2kOStUX9oKlAVNAQSLoyuAtEY5L0Pn1eQMBBCiTSo4i/n3aSm7R
	 THVBAHm0Bj9xG/7nZzVn4K1U9BvXBdZ/mp3dRQFbmIf3l1OWJiuTRC4Grsl6/F2mIZ
	 9EGyTR8r8fqS32z3tLIP/PWv8ZaqQRwosXeVqkT1Pv7ypVPBJ4XbYHo5YPN/tjxAor
	 508Vlya81i+9Q==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	James Gowans <jgowans@amazon.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Alex Graf <graf@amazon.de>
Subject: Re: [PATCH v2] memblock: Move late alloc warning down to phys alloc
Date: Thu, 20 Jun 2024 00:53:06 +0300
Message-ID: <171883398192.3581885.4505580925551979480.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619095555.85980-1-jgowans@amazon.com>
References: <20240619095555.85980-1-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mike Rapoport (IBM) <rppt@kernel.org>

On Wed, 19 Jun 2024 11:55:55 +0200, James Gowans wrote:
> If a driver/subsystem tries to do an allocation after the memblock
> allocations have been freed and the memory handed to the buddy
> allocator, it will not actually be legal to use that allocation: the
> buddy allocator owns the memory. Currently this mis-use is handled by
> the memblock function which does allocations and returns virtual
> addresses by printing a warning and doing a kmalloc instead. However
> the physical allocation function does not to do this check - callers of
> the physical alloc function are unprotected against mis-use.
> 
> [...]

Applied to for-next branch of memblock.git tree, thanks!

[1/1] memblock: Move late alloc warning down to phys alloc
      commit: 94ff46de4a738e7916b68ab5cc0b0380729f02af

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: for-next

--
Sincerely yours,
Mike.


