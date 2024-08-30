Return-Path: <linux-kernel+bounces-308596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966F965F54
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C43B1C20C99
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D77617C20F;
	Fri, 30 Aug 2024 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VU3AzKja"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C10A175D34;
	Fri, 30 Aug 2024 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013952; cv=none; b=q84S5KZONLg96CyzIKM2oZg8qgaRZcFynbsqRONHV0ZBnV/YWK3nR9rsaWhfFpMCtYzE2Zqjauz2DpGICuEGAuzDpAvA+Ix5xNOIc3pcXWm1qZ9hKp92wA1EJY0lpIqQ/Je26uJuOi2X6M1x/f4RgocO3MoaRfRJG6qUNqKZuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013952; c=relaxed/simple;
	bh=jjDlW+cQgGblR5H0eyDFZ9wc5gM0aWiRDWbhjQ5p9dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBnEp3Fyg4BNyPv56acqe9+nUgquavYXIqNtyKRWi7Bik0u8PRkG8QNkq3ONnVjVyByBJcdY0AkDmlI1kbOoWUspJzqn96icIVo8eczW+xv1bu7zZRs1kvgXLWnrjpr2GCOJKveLdaSv3xtytlxLw7FevovwzmarPKmE8K8/Q5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VU3AzKja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F724C4CEC4;
	Fri, 30 Aug 2024 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013950;
	bh=jjDlW+cQgGblR5H0eyDFZ9wc5gM0aWiRDWbhjQ5p9dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VU3AzKjamEtchMvJ8FYCKohasgrX9fWV6uMfaEn75HZBrB2fMyKbQi3Q3CzN9XlKN
	 xsaUY6v2wH9NQoA2UcJuFn8P8/dLA5+jl9xZWdM+lcw2UpPiSxPRxjM372a/D+GhxQ
	 ozpkrkumx7YwSJklC6DoSCwxMlF+asdQaTrtctjk=
Date: Fri, 30 Aug 2024 12:32:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yibin Ding <Yibin.Ding@unisoc.com>
Cc: djakov@kernel.org, rafael@kernel.org, yibin.ding01@gmail.com,
	niuzhiguo84@gmail.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hao_hao.Wang@unisoc.com,
	Ke.Wang@unisoc.com
Subject: Re: [PATCH 0/2] Added debugfs node initialization and null pointer
 detection.
Message-ID: <2024083057-factor-bonfire-73de@gregkh>
References: <20240830102153.408675-1-Yibin.Ding@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830102153.408675-1-Yibin.Ding@unisoc.com>

On Fri, Aug 30, 2024 at 06:21:53PM +0800, Yibin Ding wrote:
> From: Yibin Ding <Yibin.ding@unisoc.com>
> 
> The two debugfs nodes (/sys/kernel/debug/interconnect/test_client/dst_node,
> src_node) do not initialize the character pointers before creation. For
> such uninitialized nodes, direct access will cause a crash due to accessing
> a null pointer.
> For example, directly execute the following command after booting:
>     cat /sys/kernel/debug/interconnect/test_client/dst_node.
> 
> Therefore, for the problem nodes, it is necessary to add initialization
> operations and null pointer detection when accessing.
> 
> Yibin Ding (2):
>   interconnect: Add character pointer initialization
>   debugfs: Fix crash problem caused by accessing uninitialized nodes
> 
>  drivers/interconnect/debugfs-client.c | 10 ++++++++--
>  fs/debugfs/file.c                     |  4 ++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> -- 
> 2.25.1
> 

This series is not properly threaded for some reason.  Can you resend
using a tool (like git send-email or something else) that preserves it
so that our tools can correctly pick them up?

thanks,

greg k-h

