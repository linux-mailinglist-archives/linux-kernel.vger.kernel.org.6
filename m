Return-Path: <linux-kernel+bounces-309524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986C3966C4C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268DF284274
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EAF1C1AA8;
	Fri, 30 Aug 2024 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plYfkSHS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C00136337
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725056783; cv=none; b=AxzzfVJD3R9X/t/+YJy4UvseMuqRvo1sZ54g/WTkHBlny1sjqmDSSiAreuvPXLjX5pWQOp1qk2cCzSQtqYVAlKUyrUFk3ILBai9mnv67ZmKlthSreLDVSA7sp1XjRchM244VNVkFD/fS9YxgN7LTK84MdZochXg4A+UJY9C8A3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725056783; c=relaxed/simple;
	bh=sajjnYuYMwDyd+czAB4UYUbUROYfVhH/oX0xWtYzRyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+87IwD8y3E1RWqXDCLUNOsQdJkwfnHHVSSh6Bz7VMFkSFmo84pfF7t8sJug+P7B/cLLzH3hdfpgz4R90LFa13EyttowP9ahJzwwCGU5EYE6lQIU8gwmQt8IrdHGd5VxfnCv5b9mSk2xMyTEghL0ejzBtISmBbtGi1galQti448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plYfkSHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089C2C4CEC2;
	Fri, 30 Aug 2024 22:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725056782;
	bh=sajjnYuYMwDyd+czAB4UYUbUROYfVhH/oX0xWtYzRyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=plYfkSHSa1F+LS/F1fUv8vlmqKkU5tfFPA+o++khm52zWIblDJlzBXNixohkIpeX6
	 DkDTpcMgQrX7YDjLdG1aTBABbGSo9gatUOGWOwygZZyDf2JmoRxolBcVR+eXt2Wkku
	 pIypw6BwE14X3tvEjnfKcOpXhZhymWg9pFG9Wt/lhBgfuMyXE5U2HvZcKcRBcRlolj
	 caEpULFVa6JT/Z03YxVVI58NPHNQh9HyBL2OoAivpnmQjmjqCEEDQYnC2PyALNIiu+
	 JPkSTzfvYS4tDefzDAWOJ+vwjnF+hTl/7ri2dwF8PBnOoykgCJNuetLFZbMk0imYPZ
	 SkRHDCYkzCG5w==
Date: Sat, 31 Aug 2024 00:26:17 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: kherbst@redhat.com, lyude@redhat.com, airlied@gmail.com,
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] drm/nouveau: Use for_each_child_of_node_scoped()
Message-ID: <ZtJHCUVFWkEkezRi@pollux.localdomain>
References: <20240830073654.3539640-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830073654.3539640-1-ruanjinjie@huawei.com>

On Fri, Aug 30, 2024 at 03:36:54PM +0800, Jinjie Ruan wrote:
> Avoids the need for manual cleanup of_node_put() in early exits
> from the loop.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Applied to drm-misc-next, thanks!

