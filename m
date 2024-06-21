Return-Path: <linux-kernel+bounces-223952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5926D911AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDC81F234C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F3F137776;
	Fri, 21 Jun 2024 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C1kzQMOF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB3612F365
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950216; cv=none; b=F96w3hTz3oDVBwPjq8Xie9O0x2+lPyo9Z0jumdDRZVGfQ+69GhHyA5nO6oSajNmTrlgXg2TJA+R04+LI9tI4Wa5+sjciGuGyDliSlHx/8ZC49Dbc/0BSB8DOSoMAY50HuC3AhhxzwLm2c7xlQrRUf2cQRi+9EnOQlhdz34iPj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950216; c=relaxed/simple;
	bh=kLRDQCrw01pQj3Ch73XEpCdn23/2OfH+RbeuwjhvM7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H02HeU8+mamUv/XcEiDA9WaNDXEn3LY3gsHbheLM1WAwqHXzV5RnHi7VWmjoFKUEgD/nd+cYzEdhv8oWYW0wTNQPAOvkMyQKCTDpF0dIbvA32C6bDvvschsh7+diYoCwWwi0HASXjHf2V199eIW3/Jk30ZbH1lRynLS/9RyQuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C1kzQMOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15291C2BBFC;
	Fri, 21 Jun 2024 06:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718950215;
	bh=kLRDQCrw01pQj3Ch73XEpCdn23/2OfH+RbeuwjhvM7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1kzQMOFY+JL+enBwCDy5PDueq9TVfRr5VB3C/53ymsBQIBWRrMVpK637LrUvgFE5
	 3vuBObdsrhPw2lAkgJfTeJMCUXYwQH3+OcQrR+5mtoTPIXgmLyIW5wVbOYzgcTvv1a
	 0gAFQsJ2+EMn/zwq7wLTd9Q1y54XAx/EygjurmfI=
Date: Fri, 21 Jun 2024 08:10:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu-Ting Tseng <yutingtseng@google.com>
Cc: cmllamas@google.com, tkjos@google.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] binder: frozen notification
Message-ID: <2024062106-edge-visiting-23b5@gregkh>
References: <20240618221925.108173-1-yutingtseng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618221925.108173-1-yutingtseng@google.com>

On Tue, Jun 18, 2024 at 03:19:08PM -0700, Yu-Ting Tseng wrote:
> Frozen processes present a significant challenge in binder transactions.
> When a process is frozen, it cannot, by design, accept and/or respond to
> binder transactions. As a result, the sender needs to adjust its
> behavior, such as postponing transactions until the peer process
> unfreezes. However, there is currently no way to subscribe to these
> state change events, making it impossible to implement frozen-aware
> behaviors efficiently.
> 
> Introduce a binder API for subscribing to frozen state change events.
> This allows programs to react to changes in peer process state,
> mitigating issues related to binder transactions sent to frozen
> processes.
> 
> Implementation details:
> For a given binder_ref, the staet of frozen notification can be one of
> the followings:
> 1. Userspace doesn't want a notification. binder_ref->freeze is null.
> 2. Userspace wants a notification but none is in flight.
>    list_empty(&binder_ref->freeze->work.entry) = true
> 3. A notification is in flight and waiting to be read by userspace.
>    binder_ref_freeze.sent is false.
> 4. A notification was read by userspace and kernel is waiting for an ack.
>    binder_ref_freeze.sent is true.
> 
> When a notification is in flight, new state change events are coalesced into
> the existing binder_ref_freeze struct. If userspace hasn't picked up the
> notification yet, the driver simply rewrites the state. Otherwise, the
> notification is flagged as requiring a resend, which will be performed
> once userspace acks the original notification that's inflight.

As this is adding a new user/kernel api, where are the corrisponding
changes to userspace to show how this is being used?

> +		case BINDER_WORK_FROZEN_BINDER:
> +		case BINDER_WORK_UNFROZEN_BINDER: {
> +			struct binder_ref_freeze *freeze;
> +			struct binder_frozen_state_info info;
> +
> +			freeze = container_of(w, struct binder_ref_freeze, work);
> +			info.is_frozen = w->type == BINDER_WORK_FROZEN_BINDER;
> +			info.cookie = freeze->cookie;
> +			freeze->sent = true;
> +			binder_enqueue_work_ilocked(w, &proc->delivered_freeze);
> +			binder_inner_proc_unlock(proc);
> +
> +			if (put_user(BR_FROZEN_BINDER, (uint32_t __user *)ptr))
> +				return -EFAULT;
> +			ptr += sizeof(uint32_t);
> +			if (put_user(info.cookie,
> +				     (binder_uintptr_t __user *)ptr))
> +				return -EFAULT;
> +			ptr += sizeof(binder_uintptr_t);
> +			if (put_user(info.is_frozen, (uint32_t __user *)ptr))
> +				return -EFAULT;
> +			ptr += sizeof(uint32_t);

Multiple put_user() calls seems slow to me, why not properly cast this
to a structure and just copy the whole thing at once?  That would remove
the multiple checks from happening and take advantage of the fact that
cpus can copy data very quickly.

Or is this not a "hot path" at all where performance matters?

thanks,

greg k-h

