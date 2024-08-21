Return-Path: <linux-kernel+bounces-295884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EFB95A28D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDDC1B235FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1506E14E2DE;
	Wed, 21 Aug 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9BVfte1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6AE13B28D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256845; cv=none; b=tw29GuIwSYMZjSUBrfsfSqIJEGhscvPm2A2h5biXhageiXujKxtJsPn2/BdbUOR2IGVv/6gsP7uuxqyDX0lOSkGu60uUl6NDPTXaZDmpuUN+nNqD5dN39Q5DAU4B4Fb1dhfLJYE8hpfPYQmkWV9sgo6kNI1riGMJxeHXe5JiwLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256845; c=relaxed/simple;
	bh=pDN+szbBGjXEAYzF+z89k/J+jvjnlEYJHIMA7TqGcKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0Q8kca2ZuV7aknm8G4OQVxuQqx1ntPXZanK2bEJq6Hvo9lCQ9a4v7fP6bAUjb+qOD+Z7+vkYe0r85RcjdVNa5prnyUVZTCOPW3WfpMRtyjDZlRLgzAZ2dQvgCJ1G2Wu/vqLDeaIa8lmrE5MhkGOWRq0EZLORqaMJBb26D8FzqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9BVfte1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3585C32786;
	Wed, 21 Aug 2024 16:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724256845;
	bh=pDN+szbBGjXEAYzF+z89k/J+jvjnlEYJHIMA7TqGcKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9BVfte1p176HCiE9vqYa67eERB1h2PAzpmf177/RMbuaSR7mj9obxlKhcTM7Ug35
	 AMR0L0aVEXZn7RUX+A3kL7cSK1Y4Dq8pM4vdSU5VYABeHO+A+H7KIgnosoW/dIdo79
	 LuifFiABrh92xZdG0EuRURfDDJln82CB7PXmBwoBFkbQCAgcVXnIR2Dfe6N7QoUYYY
	 LYJ/iKF8RdcwkUgjwvsVjJQoDMJnHyxVVDExnnGXYoHFleb4NlNekEu5SHOy6QPs1d
	 mgy/+xyRfQ6l+TcyNXr63iAeYJCNmUuV/C2cOOHnmyHHnlm6tvxuM715gIf6D6ZaI5
	 hTAxF2v7YwdTQ==
Date: Wed, 21 Aug 2024 06:14:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <ZsYSS6FXFNi9W5Wx@slm.duckdns.org>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815070339.346160-1-senozhatsky@chromium.org>

On Thu, Aug 15, 2024 at 04:02:58PM +0900, Sergey Senozhatsky wrote:
> wq->lockdep_map is set only after __alloc_workqueue()
> successfully returns. However, on its error path
> __alloc_workqueue() may call destroy_workqueue() which
> expects wq->lockdep_map to be already set, which results
> in a null-ptr-deref in touch_wq_lockdep_map().
> 
> Add a simple NULL-check to touch_wq_lockdep_map().
> 
> Oops: general protection fault, probably for non-canonical address
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> RIP: 0010:__lock_acquire+0x81/0x7800
> [..]
> Call Trace:
>  <TASK>
>  ? __die_body+0x66/0xb0
>  ? die_addr+0xb2/0xe0
>  ? exc_general_protection+0x300/0x470
>  ? asm_exc_general_protection+0x22/0x30
>  ? __lock_acquire+0x81/0x7800
>  ? mark_lock+0x94/0x330
>  ? __lock_acquire+0x12fd/0x7800
>  ? __lock_acquire+0x3439/0x7800
>  lock_acquire+0x14c/0x3e0
>  ? __flush_workqueue+0x167/0x13a0
>  ? __init_swait_queue_head+0xaf/0x150
>  ? __flush_workqueue+0x167/0x13a0
>  __flush_workqueue+0x17d/0x13a0
>  ? __flush_workqueue+0x167/0x13a0
>  ? lock_release+0x50f/0x830
>  ? drain_workqueue+0x94/0x300
>  drain_workqueue+0xe3/0x300
>  destroy_workqueue+0xac/0xc40
>  ? workqueue_sysfs_register+0x159/0x2f0
>  __alloc_workqueue+0x1506/0x1760
>  alloc_workqueue+0x61/0x150
> ...
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Applied to wq/for-6.12.

Thanks.

-- 
tejun

