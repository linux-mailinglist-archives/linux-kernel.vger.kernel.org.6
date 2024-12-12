Return-Path: <linux-kernel+bounces-443604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBF19EFA19
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC54189B0DB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E03D22652F;
	Thu, 12 Dec 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u8n3ip1q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0D6223E62;
	Thu, 12 Dec 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025928; cv=none; b=sIZo8y4bCsoKbGqRlf/AyEeoR3yDuc0PCoJOY1poRxpvuPwQ06n3jQi260C2vFpre1kuog1m+FE6C6ciRs23ViXX152O7uz19rCiAgUo6oqUwJd46+KWmBL2Lf8wgKvJM8rGMLP7kaaGRD4+E2p4xnZvn/krGcYItybvIub2FTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025928; c=relaxed/simple;
	bh=aCbOBKmXI6T2fN4nEiYRnzcwAcIWJCW03o1gSzvlFOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kvcg+TRs7S3zW2Hy/Im7ckEcTjljNQczRJe9qaWU/t8xtDZAGSv3Mux06H9EMK5UY0W7AyRv8MkcMQ7b7pPzAqDE1MOKkBv2mvoGzTWA2LvmabUEyHrH2J7Z6ARbsSKUyxNfVR+pbo5tGRKCxTXsPyVo+Y1r96oX6l5ogi4Kacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u8n3ip1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CA4C4CECE;
	Thu, 12 Dec 2024 17:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025928;
	bh=aCbOBKmXI6T2fN4nEiYRnzcwAcIWJCW03o1gSzvlFOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8n3ip1qn4J2WaM7gBF4gowUe8vx4B+YhKNIRavmS/tO0pD7jNxai5rxaAcQ/1JlE
	 KAO2btOYlImdPBsINecs0iBsBtDi3YAXBHyZvyTdw8/pADzvfiDN9ME8lY6Y+SjBlg
	 LTEUWJ3acBTY0SvKOWHI61LVi6vsYrPmpbBnL/Ig=
Date: Thu, 12 Dec 2024 16:21:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yuxuan Luo <yuxuan.luo@canonical.com>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-53102: nvme: make keep-alive synchronous operation
Message-ID: <2024121211-exclude-whacky-27a8@gregkh>
References: <2024112507-CVE-2024-53102-a45c@gregkh>
 <wggouxdfutckxi7fatpmpo74j5bvannhzp25g5lrjvyi7qffc2@6y5fbuse6ypo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wggouxdfutckxi7fatpmpo74j5bvannhzp25g5lrjvyi7qffc2@6y5fbuse6ypo>

On Wed, Dec 11, 2024 at 02:09:34PM -0500, Yuxuan Luo wrote:
> Hi Greg,
> 
> The fix commit for CVE-2024-53102, d06923670b5ia ("nvme: make keep-alive
> synchronous operation"), has been reverted by 84488282166d ("Revert "nvme: make
> keep-alive synchronous operation"") and the follow-up commit for the fix commit
> , e9869c85c811 ("nvme-fabrics: fix kernel crash while shutting down
> controller") fixes CVE-2024-45013. Does that mean CVE-2024-53102 has been
> invalidated by the revert commit? If so, will you reject CVE-2024-53102?

Now rejected, thanks.

greg k-h

