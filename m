Return-Path: <linux-kernel+bounces-200684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB3D8FB352
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5C21C22A29
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50F514658A;
	Tue,  4 Jun 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+B4Tyjw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5E4144D23
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507042; cv=none; b=rCplv2jrKMCgnZ9RMR8UKokBHK5FdKMwpuOEX3dRUSNBEAuK9oIocqTZe6iT5muVxd+Nhn6zaboCEP6257IpnYD4XwPgvdsQ640lGjvVEiDihYwpOAbcSPJzxQKaXw9gwtDOALmPWf0P7XW9OzSVF+8F/Cj+NKuOUPzfHk3RbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507042; c=relaxed/simple;
	bh=9jHucXNWh3fPhzv3jEjUYgJvngK+uwydH0NF8rFlbCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzZRgptebDxWQGVGdjPTQ5VP1FS6xbSsuvqkD9Ev0shfTZwHg4UpBwtwVzJX38xv+yOmh30Ppa3J+X/7bHdsuUr56t4j+QFb1DVDDyCumUALzcBTqEz0htYoVFDqvXG3Optk+91KJJ5mVGpP3csAxLWbrI3b57hlJJ6SUy8WAwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+B4Tyjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1769AC4AF07;
	Tue,  4 Jun 2024 13:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717507041;
	bh=9jHucXNWh3fPhzv3jEjUYgJvngK+uwydH0NF8rFlbCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C+B4Tyjwrp7wU1SVntgOMtFwnTyBng4pAinkeJm1/O/Y+grnZVDQrv6uCdoNoHLyk
	 vgEuiMkprH4spWvdliLzg9svCMTzER/RPlQpH3TMYLzVjPxg21VdrttWLYdh5gKzoU
	 h9jvyjpUl8Z7ButGFfYbsIj8Kx/BCSAFcKTPQiIlKu61rsIlONpbEPQAjFhbuDyo8K
	 80owf5u4mqEikA1o7aghRGSo5zy6bAwymI9Asv2fL3oEw8dIlA3QxDoVIqgWIRz5Gw
	 NNaxmVrIsvFhLc1stdUZq0jA5NHRDNXdHmWr/WsNlDqBTuNBBDY/Cc/3kxbGmY/X8m
	 Zli7QDAvc5A/Q==
From: Mike Rapoport <rppt@kernel.org>
To: Borislav Petkov <bp@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Narasimhan V <Narasimhan.V@amd.com>
Subject: Re: [PATCH] x86/mm/numa: Use NUMA_NO_NODE when calling memblock_set_node()
Date: Tue,  4 Jun 2024 16:16:57 +0300
Message-ID: <171750701353.925406.16431237983148253122.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603141005.23261-1-bp@kernel.org>
References: <20240603141005.23261-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mike Rapoport (IBM) <rppt@kernel.org>

On Mon, 03 Jun 2024 16:10:05 +0200, Borislav Petkov wrote:
> memblock_set_node() warns about using MAX_NUMNODES, see
> 
>   e0eec24e2e19 ("memblock: make memblock_set_node() also warn about use of MAX_NUMNODES")
> 
> for details.
> 
> 
> [...]

Applied to fixes branch of memblock.git tree, thanks!

[1/1] x86/mm/numa: Use NUMA_NO_NODE when calling memblock_set_node()
      commit: c55f3cc2d9f241d6e45336fd48dafa755c012297

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: fixes

--
Sincerely yours,
Mike.


