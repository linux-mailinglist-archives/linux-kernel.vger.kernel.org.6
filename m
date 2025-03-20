Return-Path: <linux-kernel+bounces-570335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 222CBA6AF05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C8C8A52C2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8229222425B;
	Thu, 20 Mar 2025 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftQosuKT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02431465B4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501722; cv=none; b=Kn1OsYQ/NKOCVx3kmwyGOu75Z1qksc59ItWye3GiTbGq2EeHbGOBNPPT4r5iQ8z6/Nr2CD8go3dl0L7EzOdBYFmGXsSkltKDgIX97gPfX+XqrJONfm6wCXBwe4nbnoI4fzP0GIkC7uV856/x5XCr+sSihd6DIQUj7B8AMdoOoJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501722; c=relaxed/simple;
	bh=WDbvPSqBjTg7wYfVhWLiaIXXqOk4KLK0lv+0872ZAFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oN2kKftU8Jsrudt6exL31auYIjklaZ98rd+EZBKVy0gBIZmdracCY9NmZM88LLLdTyCYGBc/Twl8+8HR8lpjPLAWMq2LGWGEzyAueR6Ez1q/XQG5aqvSZoX5FG4iDr9Ur7qW1p872T++gSczHwg/nKNnsFRkUvPkL670zvHYGs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftQosuKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8FDC4CEDD;
	Thu, 20 Mar 2025 20:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742501721;
	bh=WDbvPSqBjTg7wYfVhWLiaIXXqOk4KLK0lv+0872ZAFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftQosuKTgM76TyOQYBZ/KsAh7vIyb9Zx2X6EqH5Lpyparu8AEOF3uflOm/CrUKEaf
	 9JG5e362bwVtFtRgy2JtLKEZDeL4fB1DZOxQE4RUN+I/fEmclGtLba8PvGt7wgEJWK
	 CDMzhMUPYNN/Ymu4pSB6UwNy4+eNb0Mb1Y/AwS1jyEuEo3d1/VtAynV/DV+VyDNsmK
	 H5lsvGxNh7914G+Ewpm2HCFZvVVkWIXKBpf1pqS4C7uW5xMaUL1VpnqZYzTYnvmkzR
	 Eqt1Wop94OINiRiHN4N3cgUSigLbUil7twsBKA8kE7uUGg/FkLlQNiUaYOrWlHs2NM
	 AthmzkeRfj7gw==
Date: Thu, 20 Mar 2025 14:15:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: shaopeijie@cestc.cn
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	zhang.guanghui@cestc.cn, gechangzhong@cestc.cn
Subject: Re: [PATCH] nvme-tcp: fix selinux denied when calling sock_sendmsg
Message-ID: <Z9x3V_mp4VcZgJOD@kbusch-mbp.dhcp.thefacebook.com>
References: <20250320063523.2201926-1-shaopeijie@cestc.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320063523.2201926-1-shaopeijie@cestc.cn>

On Thu, Mar 20, 2025 at 02:35:23PM +0800, shaopeijie@cestc.cn wrote:
> From: Peijie Shao <shaopeijie@cestc.cn>
> 
> In a SELinux enabled kernel, socket_create() initializes the
> security label of the socket using the security label of the
> calling process, this typically works well.
> 
> However, in a containerized environment like Kubernetes,
> problem arises when a privileged container(domain spc_t)
> connects to an NVMe target and mounts the NVMe as persistent
> storage for unprivileged containers(domain container_t).
> 
> This is because the container_t domain cannot access
> resources labeled with spc_t, resulting in socket_sendmsg
> returning -EACCES.
> 
> The solution is to use socket_create_kern() instead of
> socket_create(), which labels the socket context to kernel_t.
> Access control will then be handled by the VFS layer rather
> than the socket itself.

Thanks, applied to nvme-6.15.

