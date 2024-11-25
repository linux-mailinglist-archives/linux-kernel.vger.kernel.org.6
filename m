Return-Path: <linux-kernel+bounces-421639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D28C29D8DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982DD2865D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4254318E368;
	Mon, 25 Nov 2024 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JUIMQDg+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576429CF0;
	Mon, 25 Nov 2024 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569426; cv=none; b=Ue6Td8NnBc3px3FQSqIBZ/gJ9uJF1SyMXJFGmqKIKUewdbzy0zgmrATIEToy1rsBkNxYjPt3xDnbVGCyrAqHjAITg+piiaHYLsYHzfy8+w34CC4hbUAbqpVJ0Bx146eIAEp4Aqb/WxwfThmay63Y6pEhn7+b71qBOI/LrqREFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569426; c=relaxed/simple;
	bh=B6FwcP4XBJ4QO7dJiQSM5YSpZC1ktGDPOxqF4PKJnoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiqsVkvZrWQ5IEn0mdCAAoJ5I4idadyJKBpaDQRNqidYdpvyHZWREf+l5fE9coLorl8GbUJgtopxJZZ8DVxW5ZjXkFYpsoW2UPxZPOVWuzth/DEgf0QJt0+tZhUuxLaAAYATOYT1jNqUvWAArbZ7w/JkdSX4p+M0KEgwudh9dBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JUIMQDg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B05C4CECE;
	Mon, 25 Nov 2024 21:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732569426;
	bh=B6FwcP4XBJ4QO7dJiQSM5YSpZC1ktGDPOxqF4PKJnoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUIMQDg+sb96YOH969rymHVDS3uHIj3VAzALL7Vn4fdKVupL217YEkI94v+hSJC5T
	 5rdQ6kXIW/jhBCcUTv7nyIWPquXGuHztaGlC1mII8X1GHCGK+pbv/WL5Eyby02xork
	 fJKF8p4UtjgvO00FJpzZ4vV2WRZvputFi4810ChA=
Date: Mon, 25 Nov 2024 22:16:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nanyong Sun <sunnanyong@huawei.com>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org, aha310510@gmail.com,
	Hugh Dickins <hughd@google.com>
Subject: Re: CVE-2024-50228: mm: shmem: fix data-race in shmem_getattr()
Message-ID: <2024112552-wish-oboe-1b91@gregkh>
References: <2024110928-CVE-2024-50228-7a2a@gregkh>
 <c51f4d84-1f38-b099-dbd0-a89d78400625@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c51f4d84-1f38-b099-dbd0-a89d78400625@huawei.com>

On Mon, Nov 25, 2024 at 03:49:44PM +0800, Nanyong Sun wrote:
> Hi Greg,
>   Will this CVE be rejected in the future? This patch has introduced a
> problem and has been reverted:
> https://lore.kernel.org/all/20241116233053.F1FBAC4CEC3@smtp.kernel.org/T/
> 

What is the git commit id of this change?  Is it in Linus's tree yet?
And did the original syzbot splat get fixed some other way?

thanks,

greg k-h

