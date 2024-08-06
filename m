Return-Path: <linux-kernel+bounces-275712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C58F9488F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DB61F23BCA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C5433D2;
	Tue,  6 Aug 2024 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoFr6dyY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C800E33997
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722922214; cv=none; b=sa4MRNx9/QO4Xr5AujcDUu5I3g75WFQKcxD8X0foyH0H+f0kW/7t4b1vGHC7n4rJOy13HkRr7Ly6hLKfdTvwoeuh0pW13JIf/Y+1AUqp7lET+Q8fYLNWbo4vkH9LRmKE5wu8CmNOuieoBS0WdybMsbmNKbhnsvjVnJtzsItbCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722922214; c=relaxed/simple;
	bh=KaNeUAHgiqp6QV2fqucdpTpJYEXXXEUowELrZ/Gs27c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5ObCIygH+ggHjXbMceG+UYBzjfsY+fewGzoen6re+fuWAVxKhwUkxmt0JwlxOcinQJ9Cm/sAMt4uu7CX3inLt7vU144IfmLOFPhlybPzLkMNetZzjbRVZtN8nGyTakc/hLyM07tbo1TMmY39WAlxh8LzD1TulBZXX7NK9ojPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoFr6dyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06F0C32786;
	Tue,  6 Aug 2024 05:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722922214;
	bh=KaNeUAHgiqp6QV2fqucdpTpJYEXXXEUowELrZ/Gs27c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uoFr6dyYUrljQ7Q1s9ShzvTQREF4tJJ9U9mWA51kB4obC5f0sv9RQg3Xs1UcjUQ6H
	 0ghwKqmtkJ8ED6hqNeXn2NSwcoXuP0wLXR31wzsZUltP/mGNuxXgHTduTvllIvW8OR
	 8M3LILHUQ9qUCUj+Jl72wkeIZ8nyOzh1S44ISZo6G2HOTgERhw0w/pOH0bzgWdSg/y
	 yEzPfyoDEec1wjwEeP3skfOw7dS0tlFmF1rAp83hQG8IuvJvTBeqeOXJ3zBySmU+BW
	 4mwOLTuKA00qxPV9MAHCTCZmfjxDeTO1vCz/RbKZkgW7pGjhr4wxi6e2FtHcwN8VAf
	 MuVY+dIjZLesg==
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 1/5] memblock test: fix implicit declaration of function 'virt_to_phys'
Date: Tue,  6 Aug 2024 08:29:55 +0300
Message-ID: <172292212609.683365.1994697129673079403.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806010319.29194-1-richard.weiyang@gmail.com>
References: <20240806010319.29194-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Tue, 06 Aug 2024 01:03:15 +0000, Wei Yang wrote:
> Commit 94ff46de4a73 ("memblock: Move late alloc warning down to phys
> alloc") introduce the usage of virt_to_phys(), which is not defined in
> memblock tests.
> 
> Define it in mm.h to fix the build error.
> 
> 
> [...]

Applied to for-next branch of memblock.git tree, thanks!

[1/5] memblock test: fix implicit declaration of function 'virt_to_phys'
      commit: 39f64e402f659890a99d415eaf63a01f3b80a9a8
[2/5] memblock test: add the definition of __setup()
      commit: 9f76c2ade323121f9006f6a529e0795317e16b5c
[3/5] memblock test: fix implicit declaration of function 'memparse'
      commit: a88cde5769d523e4ae6aad61237e4a5f6bd2309a
[4/5] memblock test: fix implicit declaration of function 'isspace'
      commit: 8ac13bc7c266102f1068faafa5314522b68ebe65
[5/5] memblock test: fix implicit declaration of function 'strscpy'
      commit: 9e3d665384fca2a1c56283c7a79a968243ef4614

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: for-next

--
Sincerely yours,
Mike.


