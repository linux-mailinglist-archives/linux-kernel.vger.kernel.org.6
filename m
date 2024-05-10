Return-Path: <linux-kernel+bounces-175194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF54D8C1C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED8B1F230FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D81113BAF7;
	Fri, 10 May 2024 01:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WznK5tlS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EAB13BACC;
	Fri, 10 May 2024 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304236; cv=none; b=KQy9f1HugCmhxs4FlZzUv2Eu70JtdeQCaBQke4o2vkCXPSHhocqHTjo+i/rvzpwSYGLcQ7GbYbIGTEKtF+pwd4D2FK/OZYFwZut60oQYB0tJF89yItWilcMNZP+gUeL+6zH5xvsPx9I5UK2jSXGzvyzypsWOX/rOryAYXZRbXi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304236; c=relaxed/simple;
	bh=tIyORSm6DKfQad0bExBOsbDG3bWKnUdmlkmb3uP/VY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpOq2fGaGZadJobV0ukgyEhg7+qDc0Xxd1E3tdydAgcx47E/GClvejYeCp0jRI1FBa7xCtT4rCWSVn60EVSHF82whpY1nL8nfVWHis0kvg2XtgfZJUrG8tGk8XSXuLDaspX+/PLQ9dfxDk3NIP6K/asmckQzacegsFLOMkqggJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WznK5tlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF57BC116B1;
	Fri, 10 May 2024 01:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715304236;
	bh=tIyORSm6DKfQad0bExBOsbDG3bWKnUdmlkmb3uP/VY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WznK5tlS6cb5FZPFvUTkVUxaKLtE9OHpwcxChR6TS1xr6gla47v2Fspn4KO+5bMWf
	 6GC1OpBsnFOvoVGWxDT429Rjoh5zrG5OXloyP8cY+faxaCOILrCw/BPSbpDUI5t2n/
	 y8LTRZiAi2CXSnslUU+CNPKcPDs9+Qt5tJGOI1vVbqZ7LVoFG45WeNVhavY7Z9v4Yv
	 /Sfh+RxxkkjKqs8PnO8BcqL4bViFOS1jLEdFcD5b84+MEjw8LDue+z3nm0ssrbkX1f
	 mk2bryTrOWHbSGklza+C9N+W9S9E+cacdVmZcP7ZBaImRxahllsC17zGvCoK7fOaNG
	 Hx/6ELgMit/ng==
Date: Fri, 10 May 2024 01:23:54 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v16 4/9] ext4: Reuse generic_ci_match for ci comparisons
Message-ID: <20240510012354.GC1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-5-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-5-eugen.hristev@collabora.com>

On Fri, Apr 05, 2024 at 03:13:27PM +0300, Eugen Hristev wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Instead of reimplementing ext4_match_ci, use the new libfs helper.
> 
> It also adds a comment explaining why fname->cf_name.name must be
> checked prior to the encryption hash optimization, because that tripped
> me before.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/ext4/namei.c | 91 +++++++++++++++----------------------------------
>  1 file changed, 27 insertions(+), 64 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

