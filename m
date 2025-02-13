Return-Path: <linux-kernel+bounces-512896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9827A33EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7F8A7A1CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A751D215059;
	Thu, 13 Feb 2025 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvfBdKMj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120FA207E01
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449065; cv=none; b=O4cutOyU7LCNmL7ptmMiTpQrqpKOKGVzPcCz1Pxm4DxnmdR5fltd+9se57SsSbfjCp80sk4YhCEuZnPQt1XvXw0pFZSWFric92OEwPNQ9Q65Ohg8wNXF0kaEel55j+46w6Ul51bSS8TCpTZAQCM3WaBvSnAdb7rfpFY2dlYZuj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449065; c=relaxed/simple;
	bh=8JAGRpkkF4BFORpO2ZXJZWdxCcVAaj9LxZ7dG60lCKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn4FwAQ2oPOwUw2gvjIDrbKECYyRsdLO22KJKzpDYNPCqBzRwUeEFHhVq2KvtBgfCyHU7VqeswNCwM4VE/+k7rUk6kkPMwFwv06fDkEUTn+Rj0ye7a73t7soKbHgowfKJM0Ewf2zHKYPxTGCRHzD6QXVlSoj2BUpRMHgq/UsWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvfBdKMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83458C4CED1;
	Thu, 13 Feb 2025 12:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739449064;
	bh=8JAGRpkkF4BFORpO2ZXJZWdxCcVAaj9LxZ7dG60lCKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvfBdKMjTF6yHhtWWJnipKdieoFAS1iI18bQ0krXYEafFa6Qci2NgBx/+El86NP/f
	 w72sM+X3TUAr/B22Yl8YxF1/Dz6GxUlqkHllYQajGxy+3TbY6IQvJVyN/ivLdwSCIr
	 UAbhuT4kRx7F7XudHWeLYscCY90UJas9N25Lbi5PVNfH5xSoPnyKrIr2eOzMVPmCq5
	 IC1ZVeWkFHBP255v/9lk1d6GqFXRWM93ubR7asVl6wYLzHvqMZuQrJGZcyZ5y1sPG9
	 6+JsvXU62+8aO3S1m60CM1zVgXzZKGkboNdqWSRPdr7gySmja6AF1Od0X29IeOhSg7
	 ecQiItnBhlstg==
Date: Thu, 13 Feb 2025 12:17:40 +0000
From: Will Deacon <will@kernel.org>
To: Junlong li <zhuizhuhaomeng@gmail.com>
Cc: oleg@redhat.com, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace: Fix error handling in
 ptrace_hbp_get_initialised_bp
Message-ID: <20250213121738.GA11596@willie-the-truck>
References: <CAN5X4L9L2ught_h4M3_oe_aTMALki6nJPh9M-3KmdDx6WswffQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN5X4L9L2ught_h4M3_oe_aTMALki6nJPh9M-3KmdDx6WswffQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 12, 2025 at 07:35:46PM +0800, Junlong li wrote:
>    From b824aece318ed38666621610af7807e70831f964 Mon Sep 17 00:00:00 2001
>    From: lijunlong <[1]lijunlong@openresty.com>
>    Date: Wed, 12 Feb 2025 19:15:46 +0800
>    Subject: [PATCH] ptrace: Fix error handling in
>    ptrace_hbp_get_initialised_bp
> 
>    The function ptrace_hbp_get_event() returns ERR_PTR(-EINVAL) on error,
>    but ptrace_hbp_get_initialised_bp() was checking for NULL instead of
>    using IS_ERR(). This could lead to incorrect error handling and
>    potential issues when trying to create a new breakpoint event.

Can you please give an example of how this goes wrong?

>    Change the condition from:
>        if (!bp)
>    to:
>        if (IS_ERR(bp))
> 
>    This ensures proper error checking and maintains consistency with
>    the error handling mechanism used by ptrace_hbp_get_event().
> 
>    Signed-off-by: lijunlong [2]zhuizhuhaomeng@gmail.com
>    ---
>     arch/arm64/kernel/ptrace.c | 2 +-
>     1 file changed, 1 insertion(+), 1 deletion(-)
> 
>    diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>    index 0d022599eb61..3bf549b540b1 100644
>    --- a/arch/arm64/kernel/ptrace.c
>    +++ b/arch/arm64/kernel/ptrace.c
>    @@ -414,7 +414,7 @@ static struct perf_event
>    *ptrace_hbp_get_initialised_bp(unsigned int note_type,
>     {
>            struct perf_event *bp = ptrace_hbp_get_event(note_type, tsk, idx);
>     
>    -       if (!bp)
>    +       if (IS_ERR(bp))
>                    bp = ptrace_hbp_create(note_type, tsk, idx);

I think this change actually causes a problem.

In the current code, ptrace_hbp_get_event() can return:

 - An error if the note type is unknown or the index is out-of-bounds
 - NULL if the relevant breakpoint has not yet been created
 - The breakpoint pointer if it exists

So, in the case of getting NULL back, we lazily create the breakpoint.

Is it pretty? Hell no! But I'm not entirely sure it's broken, either.

Will

