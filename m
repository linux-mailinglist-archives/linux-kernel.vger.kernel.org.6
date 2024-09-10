Return-Path: <linux-kernel+bounces-323255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD29E973A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9801B2823CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEFD19580F;
	Tue, 10 Sep 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQFCrKww"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310C1922DC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979389; cv=none; b=rcmPcPzQhAzSaI6Lhq2eKQLzoBHQ0itzTZ4piDTGwnxUn7VxSaFkbqYNdJdV1RJ1g2o6EB6u9qyaQYKe7O//hDpSebJbYGXiWZ48OgaUPoPtFE4DP/gooPH4cEV3wxWjgHk0roLFYMv3LaQytBnimOnu0/UsYVz4NZM1G4vYeNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979389; c=relaxed/simple;
	bh=VlJEdr9QYYpPIyU5cbd/1O5G+ppN4AVPoZzjKFByU3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR0O9n+CxYGTQxqa9JuG5Um+EhQimGPfrVEEqZ66MZDLV1YnFZFh5LLaHv4vmuyG8s5qv141cyCbBPaPLa0iokB7ddcmckR7MWOPOCRz+Xmo6K4DWAALg88xrGfy6pweF0PVmtECcbg/ee4cRewWqYgtGoFf2wYPYPNflHTjHhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQFCrKww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8AEC4CEC3;
	Tue, 10 Sep 2024 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979389;
	bh=VlJEdr9QYYpPIyU5cbd/1O5G+ppN4AVPoZzjKFByU3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQFCrKwwilRlkyw/wFXCL4rvB78DwNqGTBkq7sGC0eGSi82I9KPF7UKbZS4hSbW5a
	 z2FdLX6AfjcOS24KTu5m/VRJkslQ1qAIX5jW3/w428JCnSuDxn9L7p81qiaOFbTLgS
	 mxufpKvUQo+jCzgfQ9FvAxpAbB1jvaMPE22VZQ7qTOAHdHcLOZwtcl/qQImWG1TuuT
	 WElkoTMNjp9l8LYWFWk2iSYBPQHM4c+fxWDDFBLit/voM9zPlOc+EmHpZ1SwUyZIKO
	 wpz9tHUQM6cElcdfn3X+0Haw51SWVkggwcaO/bHQ3VbHTTycKXLrBxKCAQ/LX77Aid
	 ACK4jZoR0IztQ==
Date: Tue, 10 Sep 2024 08:43:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix link failure for TCP auth
Message-ID: <ZuBa-nuGAPs7aHK_@kbusch-mbp>
References: <20240909202118.811697-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909202118.811697-1-arnd@kernel.org>

On Mon, Sep 09, 2024 at 08:21:09PM +0000, Arnd Bergmann wrote:
> The nvme fabric driver calls the nvme_tls_key_lookup() function from
> nvmf_parse_key() when the keyring is enabled, but this is broken in a
> configuration with CONFIG_NVME_FABRICS=y and CONFIG_NVME_TCP=m because
> this leads to the function definition being in a loadable module:
> 
> x86_64-linux-ld: vmlinux.o: in function `nvmf_parse_key':
> fabrics.c:(.text+0xb1bdec): undefined reference to `nvme_tls_key_lookup'
> 
> Move the 'select' up to CONFIG_NVME_FABRICS itself to force this
> part to be built-in as well if needed.

Thanks, applied to nvme-6.12.

I even try to test for these odd module vs built-in scenarios, but I
missed this one. :(
 
> It may alternatively be possible to rework the code so the
> keyring is only referenced when CONFIG_NVME_HOST_AUTH is also
> set, but this version is simpler and leaves the code unchanged.

That sounds like a cleaner solution longer term, but I agree your patch
is the simpler way to handle the breakage.

