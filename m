Return-Path: <linux-kernel+bounces-443536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0282C9EF64D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2354189CA1A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0785222D4B;
	Thu, 12 Dec 2024 17:06:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6142C2210CD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023202; cv=none; b=MF/ZypJFj4qVaZ5B88mgNviH7rBxYkf4UZOirF9sfAaIdb6mAmX3HN4ZBOE+050hUOJ6QWYqE4tGVe0CfpJI+mxyUSJBAJhC6XwQZSf76YGtWdRZ4cU9RiMG3OXvY5BTBoeY8w/DI1OmLRDquf8fp/tLoCAGKbv8YDjP3n4RXYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023202; c=relaxed/simple;
	bh=lfYpe5IA28ehfjPHm7v+f5zW70qGrwqazO+wTSM4rZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmYcwH/MwCX6xl7WMrBwBtBzpZ/WZz2S8TyABhF8TSlNUiv3HyV0a4cqzWvUh4BNmTSP0iqFE96pmBRUfTRw2V/jIMcKeUQIyvUvwZFyjZbWZEPl2YriQiJowMxK58dw6U+coW05CqDpgxj9PzEtK/LMpzmAYQgtjFYRjQ7aFjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0D3E1762;
	Thu, 12 Dec 2024 09:07:07 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E23073F58B;
	Thu, 12 Dec 2024 09:06:38 -0800 (PST)
Date: Thu, 12 Dec 2024 17:06:36 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Zeng Heng <zengheng4@huawei.com>,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH 1/6] arm_mpam: Clean up config update checks in
 mpam_apply_config()
Message-ID: <Z1sYHLZQBW9girSf@e133380.arm.com>
References: <20241212154000.330467-1-Dave.Martin@arm.com>
 <20241212154000.330467-2-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212154000.330467-2-Dave.Martin@arm.com>

Hi all,

On Thu, Dec 12, 2024 at 03:39:55PM +0000, Dave Martin wrote:
> In mpam_apply_config(), a simple memcmp() test is used to check
> whether the config passed by the caller is already installed or
> not.
> 
> This check will never find a match except (very occasionally) by
> accident, since the component's version of the struct contains
> things that the caller won't pass or doesn't know (such as the
> garbage collection record).  There might also be random padding.
> 
> This may result in MSCs being reprogrammed unnecessarily.
> 
> Instead, only compare fields that the caller specified.  If
> anything is present in the caller's config and doesn't match the
> installed config, paste it across.  If nothing was pasted across
> then the MSC reprogramming step is skipped (as the previous code
> attempted to do).
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> ---
> 
> There are comments in the code suggesting a change of this sort.
> I may or may not have gone in the right direction with this, and
> I have only tried to clean up the behaviour rather than optimising.
> 
> No attempt is made to skip unnecessary MSC register updates if the MSC
> reprogramming goes ahead.
> 
> NOT well tested, yet.
> ---

Oops, git rebase didn't spot that this patch had already been applied,
due to adjacent hunks inserted in the meantime from other patches.

This patch can be dropped from this series.

[...]

Cheers
---Dave

