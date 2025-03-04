Return-Path: <linux-kernel+bounces-543240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91C7A4D318
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBEAC7A2E95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E371F4299;
	Tue,  4 Mar 2025 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rNVrfx/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7F79F5;
	Tue,  4 Mar 2025 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741066941; cv=none; b=onY7XdsKwUTsIeYTHMUnDxTxnAGXky2PHbOoWrKI+NtQr4IkSLniIoPBN1O+EIcV78RTOINg9MO8e76Nt53EeAVpdWVKfrDMoHox/qfz7KxiEVZnkmzhhdn9vGq0KQhIFEcJMZa3j5PJi05pvfMxjvokCQ28TU+TWBon0B2kfTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741066941; c=relaxed/simple;
	bh=8Z5n4kGB2srzAQCm5xP+b+zgd9cKFC+UmyUzoBPDdXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGNGk7eEkvEf6AWbTCB/QU7mBqrqMWpGAYPQVKnzcofARhXLvJV0MPj9HONsZAQLEEo5rljLN6sxgzFmIjHs2jarx/ahTVCKhEpq57c0LkmZzwdL/F6gvPVoNzYhEtMMlQHdVR9vMy/ARIllbxFc87zm1+ezOZdE3V/KVmoeVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rNVrfx/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B22C4CEE5;
	Tue,  4 Mar 2025 05:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741066940;
	bh=8Z5n4kGB2srzAQCm5xP+b+zgd9cKFC+UmyUzoBPDdXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNVrfx/FrfZEo/ufXKgWLwA4cQ0JybvUgQkxXeOd5qIUpfZCrfI0dI415c3NSL4gu
	 dN8R41E/xICGosumAiCp017Xc9285RJIlHKB1SxqNEqVe5mdCHnhhtXZc5Wz65o59T
	 0+sT5DI5RdplnQx2Qf3BrmYHD7XNqz8AIllANihc=
Date: Tue, 4 Mar 2025 06:42:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] rust: add cdev for rust bindings helper
Message-ID: <2025030451-polka-lustfully-1edd@gregkh>
References: <20250304040450.697235-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304040450.697235-1-sidong.yang@furiosa.ai>

On Tue, Mar 04, 2025 at 01:04:49PM +0900, Sidong Yang wrote:
> This patch adds cdev rust bindings.

Ok, but why?

And why not cc: the cdev maintainer?  :)

You'll need a much better changelog here, as well as a reason why you
need this and can't just use the miscdev binding instead.  Have you
tried that one out?

> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> ---
>  rust/bindings/bindings_helper.h | 1 +
>  rust/helpers/cdev.c             | 3 +++
>  rust/helpers/helpers.c          | 1 +
>  3 files changed, 5 insertions(+)
>  create mode 100644 rust/helpers/cdev.c
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index f46cf3bb7069..07145905bc10 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -10,6 +10,7 @@
>  #include <linux/blk-mq.h>
>  #include <linux/blk_types.h>
>  #include <linux/blkdev.h>
> +#include <linux/cdev.h>
>  #include <linux/cred.h>
>  #include <linux/device/faux.h>
>  #include <linux/errname.h>
> diff --git a/rust/helpers/cdev.c b/rust/helpers/cdev.c
> new file mode 100644
> index 000000000000..929aa5359a47
> --- /dev/null
> +++ b/rust/helpers/cdev.c
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/cdev.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 0640b7e115be..6aa69761409e 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -11,6 +11,7 @@
>  #include "bug.c"
>  #include "build_assert.c"
>  #include "build_bug.c"
> +#include "cdev.c"
>  #include "cred.c"
>  #include "device.c"
>  #include "err.c"
> -- 
> 2.34.1
> 

I think you're missing the actual bindings here, right?

confused,

greg k-h

