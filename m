Return-Path: <linux-kernel+bounces-336837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775CC984199
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE9C4B2592F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB38153828;
	Tue, 24 Sep 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="140cO1Hu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DAD149C69
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168621; cv=none; b=qEuPqcLGka3hseNQBN7w5mR0di0GkkExFNQyNmHo8F2dGEilbTz9wJxDuOZwazytfnze8AiVhQZjhdi9RmSobWVxC3PIHnOqflOCb2hxXl6iZ4i3Ti4hdmfQN2qudDFrJgwpCfFjXDM19MUBMIF25RUay9bP1wpsjFOyoKUZkQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168621; c=relaxed/simple;
	bh=p8nbCGai57reXfPOXsWJ7pPJbBAt7uEKGiLBqdJnJps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGU540JfkkuitZgjA5zb6/YdGHqzFIhrH7GoPMekTw8PObgNKDDR+ik+JGMgTNdvMcz1NvO/p6f5CLvAUy7KQY6wqmjiBVjtoU7KP50efonsxrrjEaV9Q7ic4vVesD3BeMUo2F5giWqJUlXArsep+Q+DkabLLeb/gmqIJ4fwf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=140cO1Hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376AEC4CEC5;
	Tue, 24 Sep 2024 09:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727168621;
	bh=p8nbCGai57reXfPOXsWJ7pPJbBAt7uEKGiLBqdJnJps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=140cO1HuzU17XCk2Y8kQ6+GmhGG3ySdC/KGE/xseZ0a/vZna3mgv0FIumfY/vMrBt
	 WsVPSm4+r4cY7PbTomDIXBJWqVateWuRdY7TAA42/ERP8hqfRT7zQ0njmjpKkwUtRV
	 RJlsYRNOhnRHDlYfBSXm7MWCuneR6GOdPd/XJYa0=
Date: Tue, 24 Sep 2024 11:03:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: yangerkun@huawei.com, chuck.lever@oracle.com, brauner@kernel.org,
	sashal@kernel.org, Coly Li <colyli@suse.de>,
	"yukuai (C)" <yukuai3@huawei.com>, linux-kernel@vger.kernel.org,
	cve@kernel.org
Subject: Re: CVE-2024-46701: libfs: fix infinite directory reads for offset
 dir
Message-ID: <2024092400-appointee-sensation-ddb1@gregkh>
References: <b378c634-102f-e115-e925-0a20dc450ff7@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b378c634-102f-e115-e925-0a20dc450ff7@huaweicloud.com>

On Tue, Sep 24, 2024 at 03:35:33PM +0800, Yu Kuai wrote:
> Hi, all!
> 
> This is a request to close this CVE.
> 
> First of all, I think this really is not a kernel BUG, the deadloop
> only exist in user side and user must rename between each readdir
> syscall:
> 
> while (readdr() > 0)
> 	rename()

Sounds like a real thing that users can do, so why does this not fit the
definition of "vulnerability" as documented by cve.org?

> On the other hand, v6.6 is affected by this CVE, and this fix can't
> be backported to v6.6 because the patchset [1] must be backported first
> to expand offset from 32-bit to 64-bit.(This kind of refactor will
> break kabi, hence it's not acceptable in our downstream kernels)

That's your business decision, and does not affect if we do, or do not,
assign a CVE at all.  Go work with your management if you wish to change
this as it does not pertain to the community in any way.

thanks,

greg k-h

