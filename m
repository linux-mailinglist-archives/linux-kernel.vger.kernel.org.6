Return-Path: <linux-kernel+bounces-524741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A5EA3E689
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B44A3AE932
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8903B1EDA2E;
	Thu, 20 Feb 2025 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPLpjFZI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A621E571F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086841; cv=none; b=Sc00uOwWlZi+zufquJg5XqC2FCc4cn+5CmHPUwyUwDfEhlByzIluTIoAUYl+T+2RNU6n87TZDQr6CkmSlnjbRMW9Lu+PH3Jx0QVxRBbiqOXjO6LskfixUQBPm6SY1pGpVlYwv4bwJ2bH5gEsaGS+1oJu3kUZpvwXzzdUlG3qea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086841; c=relaxed/simple;
	bh=iIqHBdZbODZFAezKSmEuJy1ahGoWulZJQKNGafPbVkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0TDc3/r3smkTqYYUn2mht2HQbXTXuT87GFup6spjjsIgDAmPvEzwPCzII4ozK2+QTtzd4NRrmsauEsM41js1fmg38CW1abiWVMgr18iiM4Tf9wH+bVWs5sKcWH2lBNQVnPilp00uGK2gYi7PwyOvc2MMZQYPO24wyUSwlM+2lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPLpjFZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11520C4CED1;
	Thu, 20 Feb 2025 21:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740086840;
	bh=iIqHBdZbODZFAezKSmEuJy1ahGoWulZJQKNGafPbVkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPLpjFZIGs45k9AmeRbnIt4HkRF059DEeB614kbUy2zsRtQEA8ShQUtIEdOd3LT0A
	 rDmpFBW2n/4qQP9Z2abhqsubwbyY0g71IAxlj3qHjM0w72Ksq8RC7qIh0rynN8h4E1
	 63aLRPXIc/bBZ7Tu2XYvdPN2SyApGX4xBGlJDW3ODuOI86AcA+03SM84t6K5WTNlDd
	 G8mNqq1bMe8pRIUKhoNAH9u++q2Lh3JbWUM4PSes+6e8FQtvwml5LX5jIj1X9DptmA
	 cIfbrES4MxWQDN0v6YbNJOj1Q3p0in6jazNqZwrPXhjFm2ZtZbOGmpie/nVxF3cJ5I
	 e4XTuYeezl9wQ==
Date: Thu, 20 Feb 2025 13:27:18 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2 2/2] objtool: Use fPIE compatible ELF sections for C
 jump tables
Message-ID: <20250220212718.idjwb33t44d6fjbk@jpoimboe>
References: <20250219105542.2418786-4-ardb+git@google.com>
 <20250219105542.2418786-6-ardb+git@google.com>
 <20250220212515.on6esv3rffkmdbkq@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220212515.on6esv3rffkmdbkq@jpoimboe>

On Thu, Feb 20, 2025 at 01:25:17PM -0800, Josh Poimboeuf wrote:
> > Fixes: c5b1184decc8 ("compiler.h: specify correct attribute for .rodata..c_jump_table")
> 
> Reported-by: https://lore.kernel.org/202501141306.GYbbghj5-lkp@intel.com

Or rather:

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202501141306.GYbbghj5-lkp@intel.com/

-- 
Josh

