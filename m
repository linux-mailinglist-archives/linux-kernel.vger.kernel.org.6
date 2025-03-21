Return-Path: <linux-kernel+bounces-570836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD292A6B52C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4AE7A5576
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284FF1EDA01;
	Fri, 21 Mar 2025 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kx09pCwx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A662AF1B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542699; cv=none; b=SjPmFnuthda1NGw2vJvPToK/TQCjPGhmsp9dmOOkbBtqM5zB+oL0ZnUUvbBMQEubVl4qON/r5zYyaHBxQ6tH6LQDiBryZMUXsutjAoaZmoZOiHVkqty9vNGe7LZ6JAHxD1usiYThg/24TqoHrCNZLDYm5alrOcMaDthhCGnil6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542699; c=relaxed/simple;
	bh=l0VIPYFLHjZyYMnrRoz2CliTVTlrHCbXw1r7TfXfI4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uczhREBDu+K9uwwseY1RIzbYbcC37t4tsL1NgAiVV9TvaHbFcdV9Ud1Vf7XHkmAXBJlN4dRBFQz6jUQrJMQR/dpJpWIG4znFUuKa0ILDt5px14wnO1L77LOcqNoQo/flNmONmkV/lybNXo76O3koqU8bURD7DyjCjBLAt/yRbXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kx09pCwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7765BC4CEE3;
	Fri, 21 Mar 2025 07:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742542699;
	bh=l0VIPYFLHjZyYMnrRoz2CliTVTlrHCbXw1r7TfXfI4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kx09pCwx8NVwQMhoCA38LUPlGeLH5CM3HQAZofaUiXcomQlx+diX9w+DeaSxFDqcO
	 Yy7sKrRYYVGmAbHRk847LZIFRntfuMYnLNqa05/vDqTD6Ky3VYicvdtl8egRYaMVaw
	 jLYwAftSSZMso9XjEYs+vXS/gMKcmQMNxSYcZEb7BMDTrF/hWDFsBm9MH/a7igjyMe
	 nBFOqYEoPotOTh5hmru/zrUJSoGIp9yBC+L5fbJwEatreysWr1y3YapxmMYifmuqUp
	 O4XPtiC2ZIlOGiiLOoY0q0V+z7a9bnFg84rgGIsRjzS8yUagyoZGwLREZ39emkoDCj
	 j5CMSJwVjtHyw==
Date: Fri, 21 Mar 2025 08:38:14 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, "terrelln@fb.com" <terrelln@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"brgerst@gmail.com" <brgerst@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Compile problems w/gcc 9.4.0 in linux-next
Message-ID: <Z90XZqJVwuWkarnX@gmail.com>
References: <SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>
 <SN6PR02MB415765C109AF9820DDC3AF0FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41575C4BA0C467B1C95EEB21D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41575C4BA0C467B1C95EEB21D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>


* Michael Kelley <mhklinux@outlook.com> wrote:

> > What are your thoughts as maintainers of lib/zstd?
> 
> FYI, the same segfault occurs with gcc 10.5. The problem is fixed
> in gcc 11.4.

So the patch below would work this around on GCC9 and GCC10?

Thanks,

	Ingo

==============>
 lib/zstd/common/portability_macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/common/portability_macros.h b/lib/zstd/common/portability_macros.h
index 0e3b2c0a527d..0dde8bf56595 100644
--- a/lib/zstd/common/portability_macros.h
+++ b/lib/zstd/common/portability_macros.h
@@ -55,7 +55,7 @@
 #ifndef DYNAMIC_BMI2
   #if ((defined(__clang__) && __has_attribute(__target__)) \
       || (defined(__GNUC__) \
-          && (__GNUC__ >= 5 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 8)))) \
+          && (__GNUC__ >= 11))) \
       && (defined(__x86_64__) || defined(_M_X64)) \
       && !defined(__BMI2__)
   #  define DYNAMIC_BMI2 1


