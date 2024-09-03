Return-Path: <linux-kernel+bounces-312730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA959969A74
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21361F2423D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02911C62A6;
	Tue,  3 Sep 2024 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YlSo8KaS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCC619CC3F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360142; cv=none; b=XGkfDget5H4nMCpFxF4klHsQXMcQnN5W2drbt50hbuWApk2ispMg0T6orqec2oDmcnyL7KIUkAqwKhdOquZ4ghlVjJjLg5kCwYgqsm0cqLxMshr+YtlhwrCSzUuyal5+2F9hcMy1neDQE4AEsIY8j0eBPgejfyjIEr1TloRvsJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360142; c=relaxed/simple;
	bh=VtSl96nmF/LCjNO2esvvA9cTDZJDeTeuiBlr6O5ZeXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Atb3+ZwNjC3pJihZ+BEmZux/od39Y67x7QuhL4xYrfXwXfx5krzu3EUE7TeBFrpe08nEpi+YiKTjXLByUoy9A8kNlcghMt5xTN1VLkOVG68+TL1l887bZYpdQiQBt6hOsvStKhr88f3o95VBZU1ZUjRRb5cvX26jG5qADxZhq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YlSo8KaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC6EC4CEC4;
	Tue,  3 Sep 2024 10:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360141;
	bh=VtSl96nmF/LCjNO2esvvA9cTDZJDeTeuiBlr6O5ZeXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YlSo8KaSkLEWPdHpsVV3WIMQkTuHFLKjF8WLgPUBlNRvIz2l4K/95RD6WzAW51XtE
	 IffhN8kVYyaSq7wOlS7WCMIYyryLgvbCxHm02uqWYv9g5vjzU5mO9axFka2Yqgm4xv
	 YnBv1+JfGRS4FRPWwNaxTe7j1k9m2Z/4iLZEG9U4=
Date: Tue, 3 Sep 2024 12:19:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, Sukrut Bellary <sukrut.bellary@linux.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 1/1] misc: fastrpc: Fix double free of 'buf' in error path
Message-ID: <2024090311-foam-pouncing-fcdd@gregkh>
References: <20240902141409.70371-1-srinivas.kandagatla@linaro.org>
 <20240902141409.70371-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902141409.70371-2-srinivas.kandagatla@linaro.org>

On Mon, Sep 02, 2024 at 03:14:09PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Sukrut Bellary <sukrut.bellary@linux.com>
> 
> smatch warning:
> drivers/misc/fastrpc.c:1926 fastrpc_req_mmap() error: double free of 'buf'
> 
> In fastrpc_req_mmap() error path, the fastrpc buffer is freed in
> fastrpc_req_munmap_impl() if unmap is successful.
> 
> But in the end, there is an unconditional call to fastrpc_buf_free().
> So the above case triggers the double free of fastrpc buf.
> 
> Fixes: 72fa6f7820c4 ("misc: fastrpc: Rework fastrpc_req_munmap")
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/misc/fastrpc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Any reason you forgot a cc: stable@ on this?

I'll go add it by hand...


