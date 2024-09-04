Return-Path: <linux-kernel+bounces-315522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E6196C3A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9209F288695
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53D61E1328;
	Wed,  4 Sep 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpZRFciJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFEC1E131E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466370; cv=none; b=fH2Qnb0LGod2hFUB/k7Gl4CQMjNf7GbGXH0pmxs82K4KMTX83GMT70LJv1AOF4N1aQbKRahwHqqtnsgPCPu33/ViKScLFqTJQ8bgLeL7l3a3BSJLOlrj88xq4Y9XGris5wYqBuXkM4DYqW8uYIHMpP+pE1MoNTaCHiJyHOpPV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466370; c=relaxed/simple;
	bh=d/doR/JL0ZZavYnwvua0tMiOuVXU0is+Pqdk1vjC6as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/UsH42Ek4S517Emr9x/CueMKXBCItdZUMDhiCVv5+Xe9F7I/8V+jINqpvExhFGngIlwlLSB7hnCYt4XIfOH1mmSVLctKkzt6karO3/ma0iWE8uumIvdX79ygWBsLBiesCRVrwx+AMKHgPY64Qr8L9rj0BoHnUMokiZZHG43Sa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpZRFciJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1ACC4CEC6;
	Wed,  4 Sep 2024 16:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725466370;
	bh=d/doR/JL0ZZavYnwvua0tMiOuVXU0is+Pqdk1vjC6as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FpZRFciJGtNYCRCWhmdkeTfmD71as3iDF5RuhPfw5DqmVrhy6yrXnyNNc+Sln4ZLf
	 Xjh3dLkbeFG87RTZnAj061KwSlThSg44zlzNW1Ikqyj73qunes1FvhTWxw8eqm2Ll1
	 MYVKJAgCs5IfBSANYDBQpJuQrKMZ9UG2nR4Hum5pqmIOiqg19s0Stb4Lmhd4KDkSnP
	 u5yRFRN05A7AXzdaiK/DG/ei+zrvnLCVM2TsDS3L4ouEeNgZSPfvq/oLYBRjhcAUpj
	 Y0/5BfmI0l0YXz2OtszlmUgVfdaCAgQBp9Nw6bqlWbj4oiJ9khKn2F8CuYUBrfuZeb
	 rkLmDv4DX+KYw==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Tesarik <ptesarik@suse.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rong Qianfeng <rongqianfeng@vivo.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v2] arm64/mm: Delete __init region from memblock.reserved
Date: Wed,  4 Sep 2024 17:12:35 +0100
Message-Id: <172546358699.2660943.13177261820713486518.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240902023940.43227-1-rongqianfeng@vivo.com>
References: <20240902023940.43227-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 02 Sep 2024 10:39:35 +0800, Rong Qianfeng wrote:
> If CONFIG_ARCH_KEEP_MEMBLOCK is enabled, the memory information in
> memblock will be retained.  We release the __init memory here, and
> we should also delete the corresponding region in memblock.reserved,
> which allows debugfs/memblock/reserved to display correct memory
> information.
> 
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Delete __init region from memblock.reserved
      https://git.kernel.org/arm64/c/1db9716d4487

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

