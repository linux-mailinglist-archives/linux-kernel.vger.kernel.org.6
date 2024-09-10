Return-Path: <linux-kernel+bounces-323742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD929742CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408921F2634C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE011A7072;
	Tue, 10 Sep 2024 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0YijEvE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5051A4F28;
	Tue, 10 Sep 2024 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994441; cv=none; b=j67hFRFVjKZPZGpTTI9OJT8lmv/GQ/h3XVaXjKuH2a0Xex91a3S1zIUo8yvlV3FalTRPWW2SExe2rvAuQ9KbmRlONcUn6CypsI4QRf97zFZTg0sViZkMWKqaOFers0eJXHWKfHL38vV/eLQhaQHCkQkdaC/sjhYUhwx8S4gxRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994441; c=relaxed/simple;
	bh=JdxdxkG/6x0uIfBpsQYwT4dEbZj3QzBmj2e6DVyQYtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4nkWu1+qYtlkw8aPcOWQ+6BtTNU1wGGa3YtL3gvx0gRmBpv/GFYbcX7lpnU4m2Fes7EKKLnsa611elFtpb7vIWqBUR24dCJOQZlDUpawC3rVQspUz0DCE79Olykq85t2zQ6M7ES4z7NOYgzgqCkNPXmAAy0vmTAkh/iy7roPWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0YijEvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E10C4CEC3;
	Tue, 10 Sep 2024 18:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725994440;
	bh=JdxdxkG/6x0uIfBpsQYwT4dEbZj3QzBmj2e6DVyQYtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0YijEvEcmD+wCWVwwkRhVIpMZaBgh5fVYgMKeWXgJc4fMo4w6QfL/qW7MVR3cn74
	 ST/DPI6AuxCilzTCatt7f1Bd6Yw6/QIic5+9yvHaE9fp/62S1P6SRmf15opQejgOEF
	 EWv8flbhGDq/uv5X/kppuQrIpgV+zdVTN6EhpFnUxQQNOzy2rlP5w+blmgzCIXPVcS
	 hcPaR7QCFE0TyoVRRKeUoVYRm4BJl4HO6lGim4dcG+lbzEWAJbR0JNv7rOeFZ5cBDb
	 p/rlMI7uaEJrQhi+hux2ZKKI3FFBwl0iplIIMevn28S1mkFaYdZ2hQd9GprcO+hg1/
	 yLiUvgpPJZrIQ==
Date: Tue, 10 Sep 2024 18:53:59 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev
Subject: Re: drivers/md/dm-integrity.c:521 sb_mac() error: __builtin_memcmp()
 'actual_mac' too small (64 vs 448)
Message-ID: <20240910185359.GA2482240@google.com>
References: <e8c80d61-2c74-4b50-ab50-2cf1291df9bc@stanley.mountain>
 <20240910172001.GD2642@sol.localdomain>
 <d09d8b14-9ea8-4802-9c37-2cd60a75b0fa@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09d8b14-9ea8-4802-9c37-2cd60a75b0fa@stanley.mountain>

On Tue, Sep 10, 2024 at 09:41:34PM +0300, Dan Carpenter wrote:
> Generally, we try avoid silencing warnings just for silencing them unless it
> makes the code more readable.
> 
> The other way to silence this warning would be to delete the check on line 500
> because if it can't be larger than 64 then it can't be larger than 448.  It's
> not like SECTOR_SIZE is going to get smaller in the future.

But maybe sizeof(struct superblock) could get larger in the future.

- Eric

