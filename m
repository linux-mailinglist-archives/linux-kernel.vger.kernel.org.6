Return-Path: <linux-kernel+bounces-296803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AAA95AF4F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44545B266AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1235674E;
	Thu, 22 Aug 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gfUuRZiZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F4446556
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311870; cv=none; b=N9acfHzwNDO1Z4ptd62se4W/irD8gFXwlhVpHug+2rc2QASbzpPrgd6VPnrpO4UCT9+e8JNGSPDgT1G3qJdmXQxd72wLs5ktyWkBMusUaPIlyt+FnveBVt/fq5v4hsxO0NaVtuEdUcbfJylRcPfygDDkWJMzT/kYpe/SPH7jhbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311870; c=relaxed/simple;
	bh=8wqQK50/xFyio0FwQpB4MQF0xYTxsbzw3vUZXAVew5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOTEBZ2+noZxZWJPn4xnEaWmU1Gp6NJItDBh7u+XrggSRQy5vtGQ6IB7FtcDdtqO1jszt4MyAYTdJ4CsSyvh1wBCEDO5n8Rxc5hGjmlGdMGYiRj5j38MXz7n4hlo7/jKf7roPsQWm09vynPhLAc0t9FqMo4dMh5QO6uxyw5NM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gfUuRZiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09181C4AF09;
	Thu, 22 Aug 2024 07:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724311870;
	bh=8wqQK50/xFyio0FwQpB4MQF0xYTxsbzw3vUZXAVew5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gfUuRZiZY/KalJ3Zie61jZc8BvLOKWCF35l3A2gXDpr1Nac+OlehmFgEFAMbH1+dG
	 b6a6Lb0JxtqkxlONorkbmy2O7W+v5auN6L53LbvV2Jcmj/uQhx8qBFscihi6P7AkiL
	 +EdPgS9b7OSXPMHOvQBg3WcRjs2kCXFaLNhYCIpE=
Date: Thu, 22 Aug 2024 15:31:07 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Juergen Gross <jgross@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2022-48900: xen/netfront: react properly to failing
 gnttab_end_foreign_access_ref()
Message-ID: <2024082247-multitask-bacterium-4713@gregkh>
References: <2024082210-CVE-2022-48900-c15e@gregkh>
 <608fefca-79e1-4982-9d77-56a56890dd90@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <608fefca-79e1-4982-9d77-56a56890dd90@suse.com>

On Thu, Aug 22, 2024 at 07:46:10AM +0200, Juergen Gross wrote:
> Please revoke this CVE, as CVE-2022-23042 has been allocated for this issue
> 2 years ago already.

Ugh, my fault, I caught many others of these "by hand" but this slipped
through.

> This is even clearly visible ...

Yes, but NOT in the cve.org entry at all, which is what I use to match
against.  Again, why are these commit ids NOT in the cve.org entries?
I know this came up before, but I still find it quite odd.

thanks,

greg k-h

