Return-Path: <linux-kernel+bounces-564852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3C0A65BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467654202B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEBD1B4235;
	Mon, 17 Mar 2025 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlETLpx5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774661527B4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234421; cv=none; b=aadsIB3dCOmUrNZ4MlZxMFSLCFqRED7VJov0PZT44CbQtTCbiReDYxsOLHm6wPaEeAV1rlsEwuaZmLYF4iyD8ybyT1LejlbqUMTUrRzX0Ow0Nv3iKKuX10YIH9wLovY/n5z+1anQ/QFm/Z6pI8Ei2RyeUbSZ6jOlVZZr/Gc9qXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234421; c=relaxed/simple;
	bh=EcZtPtzu8REfqQJkX/KH4pfuoWeHznxmJu2fk/3OhFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pqn5flfsE4LF9HDYYY1j/lKYaUqSjMHmkmC7Ed5vg3n3e5KdNOjg/4lPzUaWtk1ANbjB3SdQAJpEPTM15gN3cvlXyycxwjXXesBPcqOKlvqWaraFO5nqM6Ezbhh+BESUyOXUPPIrRcfxy2+gnBjgPQYvQjDiumXhA3VhLZJrAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlETLpx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5675DC4CEEE;
	Mon, 17 Mar 2025 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742234420;
	bh=EcZtPtzu8REfqQJkX/KH4pfuoWeHznxmJu2fk/3OhFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlETLpx5ZVazICSyF9/NwKMTg8lm727346FXmrTN6KuzEIkSArgRID9HyJ5kBVvLF
	 ifSwTwRgZ5qCZ6l1Y8gaFFtJ4dPpE4ljdB41Lav4BAieuULEH/+akvy0Hs4nAHdlza
	 P5uaJSSRUqIHYuuIYbKKzYxIkRFJ659TWxHy9rAqkWMghnh0rqOJt6HAXVr6Py03bK
	 osOQkDj9tN2WI/VxQGrbidg9vNre08b5aTtBJqm/EYN7cT34BcL6ZbIFaJiXeBDwZy
	 JoP91JtEOr5TYSK5YJwY10XQCqulIwNbHcUIU//5BSatX1jzOdD5d0O5pyfwU42HiT
	 4/uTlrqqruduQ==
Date: Mon, 17 Mar 2025 12:00:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, loberman@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM config
 option
Message-ID: <Z9hjMtuyd6Y0FJPy@kbusch-mbp.dhcp.thefacebook.com>
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-3-jmeneghi@redhat.com>
 <20250305143353.GB18526@lst.de>
 <03e7cc64-fafd-405e-a07a-4bc6d0e1d743@redhat.com>
 <20250312051958.GA11824@lst.de>
 <cd731f6e-c0e0-4ea7-9012-5860b0be2920@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd731f6e-c0e0-4ea7-9012-5860b0be2920@redhat.com>

On Thu, Mar 13, 2025 at 05:46:25PM -0400, John Meneghini wrote:
> Our RHEL customers do this all of the time to enable DMMP with their NVMe devices. This has caused tremendous
> confusion and turmoil with our RHEL customers who keep on turning nvme-multipath off even when we ship
> RHEL with nvme-multipath on and we tell them turning it off is not supported.
> 
> I finally decided that there is no good way to control this situation w/out removing the
> core.nvme_multipath parameter while CONFIG_NVME_MULTIPATH is enabled.
> 
> This patch enables distros like RHEL simply config out the parameter w/out impacting all of the people out
> there who currently want and use the run time switch when CONFIG_NVME_MULTIPATH is enabled.
> 
> Please let me know what I need to do to make these patches less confusing and get them accepted upstream.

It'd be one thing if it was just me lamenting the loss of the parameter,
but Hannes has customers with a very real and obvious use case for it,
even if Christoph hasn't encountered many (or any?) devices that fall
into that trap. So, from my perspective, I really think pcie hotplug
handling needs to be sorted out before we can just force these to
subscribe to the native mulitpath virtual device hierarchy.

In the meantime, I know RHEL has done out of tree patches for many
reasons, so it shouldn't be a big deal to change the module_param type
from "bool" to "bool_enable_only" in your kernel releases.

