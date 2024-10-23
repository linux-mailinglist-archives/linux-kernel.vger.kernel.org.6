Return-Path: <linux-kernel+bounces-378483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063EF9AD133
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C75C1C21F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A954E1CB536;
	Wed, 23 Oct 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+Y50mUD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1413313B792
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701620; cv=none; b=eWYYJXWGyxHsXz1G7TLHQtjxotQSCPIiB98EBg0Jbfbus0YCaL9ux8x2jcxNUaj5Lo8VTC5dYpdWBdiIa+inbQ/VNCjdY9qlOA6hKMPsNyRqoCFSLjSGwFMuYQed6EjxVfS3HLROMeX8PFwCVCBE6ktnCDlkMbssTncSo+eku1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701620; c=relaxed/simple;
	bh=EaGnaP7igIMuIpgZ7RhMmhMiAYISKgyP9cmiZwCDk0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqsW8RyTjRJ3US25pGYXiRpCnrSat+633ObPeHjRxr5Qp6ztrI8e5azODoKBPcKRkashq56yuUN1ocUVswL5nTzSXYsm7S3ySTcLGDMWxPB9o1/4khEwrud4IJJxulPRZIJjMrONUQ2BUI2OKztPTac18Pa9P991oD7vEeLZb3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+Y50mUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CF8C4CEC6;
	Wed, 23 Oct 2024 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729701619;
	bh=EaGnaP7igIMuIpgZ7RhMmhMiAYISKgyP9cmiZwCDk0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+Y50mUDAN4zL4uMUG5gygzWU+9fdZ713E7sh50ZMFris2r7nDp8q3F0p19D3VXXJ
	 s2Sot94dwvug37Md3VXLDmkrYwaKMod4LxKe3dr46bGhLkGkh+grWjUvW+giCyy4UI
	 LrlAjVpV7bXkwgWBKyn1irNHrVb9YCx5u/zx5k5UP1xFrLxXKTeKZTXrtiIQ6UEgPA
	 PiW+5B7vEQ7Q4XLr+0fdNVk+h+68iBrJkhd11ntiJChjsz67qCLc3/BdGAide2prdL
	 Ghojpg5rd5+i28+AiUnF2lO5UUEtqxaUk1Rh3iALaty4jaPSKUD3GA6QzpWlLR/M78
	 7XoLB2aIZHSxw==
Date: Wed, 23 Oct 2024 17:40:15 +0100
From: Will Deacon <will@kernel.org>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
	ptosi@google.com, oliver.upton@linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Return early when break handler is found on
 linked-list
Message-ID: <20241023164014.GE29251@willie-the-truck>
References: <20240827110046.3209679-1-liaochang1@huawei.com>
 <Zs3LnYkXL5sg2yBH@J2N7QTR9R3.cambridge.arm.com>
 <f9357dff-1f08-42ce-b6c2-93b3a2d9336f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9357dff-1f08-42ce-b6c2-93b3a2d9336f@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 23, 2024 at 09:52:27AM +0800, Liao, Chang wrote:
> Kindly ping.
> 
> I'd like to get your input on the next step. Should I send a v2 patch
> that only removes the WARN_ON() as Will suggested? Or should I push
> forward the refactoring of calling BRK hook [1].

If you have the bandwidth to tackle Mark's refactoring idea, then please
feel free to send a series. Otherwise, I'm happy to merge the v2. We
could even do both.

Will

