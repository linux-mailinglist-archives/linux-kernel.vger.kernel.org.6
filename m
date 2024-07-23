Return-Path: <linux-kernel+bounces-260160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFB293A3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56426281DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07676157E91;
	Tue, 23 Jul 2024 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7Gj3kXw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73C157A74
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749627; cv=none; b=XIDIj8Ia1oO91O2zVjT58XiBf/93krLE8CLrNO90Q4Tw75NXaGiJ5n9TfC+KRQdrbMwZGXJyFgb94RIdAuc6UuYwR0yKh4pGIQ6lJKjht63pYbXgKIZw/KQxDIqBPpMkCmu6ClpMaZ5byhH3XpR6COfHqrruHJUTnAgkr2GbdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749627; c=relaxed/simple;
	bh=QgL4SRJ15Uy7klGovV5PQE9jBMQGYBNBiX0F7BXEcJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XirxIgjIgFWRpt9ZFv56G7lYuMucnkYyNpinQt+Wmjg7wtWvsLxYNR3ktRohBB2gALpoXj/jtaEHnguUHoSwKxbcRiCNG6NAg5BOSB1hXBAWAqOKOJe+9ycN8q1vBf8JXyyfIdOyCNVbHroRD49BvEpekNnFsNz3uu/PyN5HaZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7Gj3kXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBD7C4AF0A;
	Tue, 23 Jul 2024 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721749626;
	bh=QgL4SRJ15Uy7klGovV5PQE9jBMQGYBNBiX0F7BXEcJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7Gj3kXwz+xz0ebI2sNFYZ5231qmg8Y+qMQIkAWkhN5Olyc8hW6dDZxfqs+LBq01n
	 k/2/50ysPepHgWMtLkV3UQtKJQ/NXYR5cthR2mr1JSU96WSfPzMQkk2oPfGXKgxspj
	 hZJJKSRVJzxs/MZPlmSrfiVFqbXuOEOOsqtuiD74z/2qxnzF/ErmUGXNaFQq7MDLO/
	 RJu4MMVmc4rR0yixcjq3QveOJ3axmn/ifkqQzmXcKKQEo4/0Bjoe6Or9e0RWFM7zxQ
	 MHUmFNMyuNABHfcQXPCX5zNWwXa3w3Dnq8Bf4U8p4X1sGRyAxpvIhqZfdVpgee+Xvq
	 Wq6tJUd+0kMig==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Fangrui Song <maskray@google.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/vdso: Remove --hash-style=sysv
Date: Tue, 23 Jul 2024 16:46:54 +0100
Message-Id: <172174490407.279838.17045807844160700585.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240718173423.1574395-1-maskray@google.com>
References: <20240718173423.1574395-1-maskray@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Jul 2024 10:34:23 -0700, Fangrui Song wrote:
> glibc added support for .gnu.hash in 2006 and .hash has been obsoleted
> for more than one decade in many Linux distributions.  Using
> --hash-style=sysv might imply unaddressed issues and confuse readers.
> 
> Just drop the option and rely on the linker default, which is likely
> "both", or "gnu" when the distribution really wants to eliminate sysv
> hash overhead.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64/vdso: Remove --hash-style=sysv
      https://git.kernel.org/arm64/c/48f6430505c0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

