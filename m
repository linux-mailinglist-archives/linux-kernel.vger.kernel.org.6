Return-Path: <linux-kernel+bounces-187597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE108CD50A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3E41F23925
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9FB14A633;
	Thu, 23 May 2024 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FjsqnGa7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7C1E520;
	Thu, 23 May 2024 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472301; cv=none; b=V8DULV6TVU17fdw++6mOmBIzS33jrYxASUMjr6bVn0mm3H9k8q2o+Snt0Un2Ks+DPb2yzB8jgK/3tK+Ov/AZvC1v9yx3AaFY6SHccIBVbpnniXcoph6atPCNDWAJye4KGdwkuKvwVw03vSlMgbeXJSWXW0aaXbL9MMRMmB3SDeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472301; c=relaxed/simple;
	bh=1et2PxtbezH44I/Nd1x4uPl/r56dJ2xZ4EP8a2FYE5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9yBtRfcDVyEjNtErqpOmHkoLMSTiY8aVtIahJHJzDUbWJJJjyEzTYtt83GbdnPsgrwTPTaB4Di4OqoONzwtsIWzHr8LyBVynJxiR+LkxfByAvUTUkmZ58A+z9J48fTRvIkE7TqLu44VjE4rdKNkBw+eBiidgLt1jTnWHbjNgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FjsqnGa7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D83BC2BD10;
	Thu, 23 May 2024 13:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716472300;
	bh=1et2PxtbezH44I/Nd1x4uPl/r56dJ2xZ4EP8a2FYE5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjsqnGa7A1brIi8LHk/vqWUtAhg1Tnr4COtATu3EYpNNtfkJUnrRkAudBU7XUvb4e
	 aog/a933kJfA85OP2svrPj1XxXXd6KJq2irIVOKUHMHEVLHHpStmAiphKBs75zPgve
	 8Qa+4W81r9Q/S5jbjvIOIxGWLIWmmpAdk/3WF1a0=
Date: Thu, 23 May 2024 15:51:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: zhengzucheng <zhengzucheng@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-cve-announce@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Jun.Ma2@amd.com, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-26650: platform/x86: p2sb: Allow p2sb_bar() calls
 during PCI device probe
Message-ID: <2024052316-subtotal-fragrance-15e3@gregkh>
References: <20240326175007.1388794-18-lee@kernel.org>
 <Zkz2qpUP-HVROO1I@tiehlicka>
 <da7e8c85-52fd-b2f4-83da-751f812de6ae@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da7e8c85-52fd-b2f4-83da-751f812de6ae@huawei.com>

On Thu, May 23, 2024 at 04:50:18PM +0800, zhengzucheng wrote:
> 
> 在 2024/5/22 3:31, Michal Hocko 写道:
> > This patch has been reverted in upstream by 03c6284df179 ("Revert
> > "drm/amd/amdgpu: Fix potential ioremap() memory leaks in
> > amdgpu_device_init()"") and based on the changelog the CVE should be
> > rejected.
> 
> hi Michal Hocko
> 
> This reverted patch was previously used to resolve CVE-2024-35928 ?
> 
> so CVE-2024-35928 should be rejected?
> 
> 
> commit 03c6284df179de3a4a6e0684764b1c71d2a405e2
> Author: Ma Jun <Jun.Ma2@amd.com>
> Date:   Tue Mar 19 15:24:03 2024 +0800
> 
>     Revert "drm/amd/amdgpu: Fix potential ioremap() memory leaks in
> amdgpu_device_init()"
> 
>     This patch causes the following iounmap erorr and calltrace
>     iounmap: bad address 00000000d0b3631f
> 
>     The original patch was unjustified because amdgpu_device_fini_sw() will
>     always cleanup the rmmio mapping.
> 
>     This reverts commit eb4f139888f636614dab3bcce97ff61cefc4b3a7.
> 
>     Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>     Suggested-by: Christian König <christian.koenig@amd.com>
>     Reviewed-by: Christian König <christian.koenig@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Yes, this should be rejected, I'll go do that now, thanks for pointing
out the revert, we missed that.

greg k-h

