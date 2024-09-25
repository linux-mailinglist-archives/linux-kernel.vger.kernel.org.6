Return-Path: <linux-kernel+bounces-339595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0705698676B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C89282DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59431146A68;
	Wed, 25 Sep 2024 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcVq6oZW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68B6208CA;
	Wed, 25 Sep 2024 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294946; cv=none; b=tXcd8MkLwv78yX3LXvU0Da64CNqEheRMAsbWcRNoOJOn10Ax23GKXDX5clXqsVlwx7Q/6x/BRytqxDXElV7Gy2NvUAyWs08M9UMgGKWQddUmQqAWABj/y4+LWcGMq5wReYIs2nv5moE17L6uU7jdzYLJnpBZIIJoUF+NL6mTXTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294946; c=relaxed/simple;
	bh=mz1xkwV7INFNOPSmzqN86RyKVeM0Wso0y9Wzf0C3xVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfprvpJV4UagAUYehB2gHOwpFjmNwhd2T4o7UW76McJf/w2sChGryKsPasWUgV69D2UOV+BEtuvc7n0TecZ5MDoqcORvUJCv/9IIUl7zef59+VM28/dzUN17s7HZb/KQ4bYZkOiRXuPgv1hfaZYi6pirXNOuYEMIuluLOBh8zhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcVq6oZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABC6C4CEC3;
	Wed, 25 Sep 2024 20:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727294946;
	bh=mz1xkwV7INFNOPSmzqN86RyKVeM0Wso0y9Wzf0C3xVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DcVq6oZW8YMD4hGNF87idYrH7WteO6V0Md3YAGWmJofWTgHN7EV9CIaiOSOTNtQ1o
	 1o0eR+SiBoqx+/9nSijZX0cEdJqclih4Z8xwHBSSCPqJHh7ZwJpmkKKtEH0VP0ZRIh
	 N7NiUp7F3Z5u4QHaxKje4vHQNmawhEVbHc5SiUPGBaZfo01Zz80YiHUgjzqIqjFXAS
	 94yDk/ufxS8ytieOUSnnDJoSGABAaut5Bwwnhq4Pg8YyRFmr/oSrrkUT7H67i//LQi
	 atEPXE29ONj1AuWFi89D943mjTczLHyCwaptk2q+flopglU3xXFdbLWe8qXB0BxAlB
	 Vf45sIxMTgbWQ==
Date: Wed, 25 Sep 2024 21:09:02 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: systemport: Add error pointer checks in
 bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
Message-ID: <20240925200902.GC4029621@kernel.org>
References: <20240925152927.4579-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925152927.4579-1-kdipendra88@gmail.com>

On Wed, Sep 25, 2024 at 03:29:26PM +0000, Dipendra Khadka wrote:
> Add error pointer checks in bcm_sysport_map_queues() and
> bcm_sysport_unmap_queues() after calling dsa_port_from_netdev().
> 
> Fixes: 1593cd40d785 ("net: systemport: use standard netdevice notifier to detect DSA presence")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> ---
> v4:
>  - Removed wrong and used correct Fixes: tag
> v3: https://lore.kernel.org/all/20240924185634.2358-1-kdipendra88@gmail.com/
>  - Updated patch subject
>  - Updated patch description
>  - Added Fixes: tags
>  - Fixed typo from PRT_ERR to PTR_ERR
>  - Error is checked just after  assignment
> v2: https://lore.kernel.org/all/20240923053900.1310-1-kdipendra88@gmail.com/
>  - Change the subject of the patch to net
> v1: https://lore.kernel.org/all/20240922181739.50056-1-kdipendra88@gmail.com/

Thanks for all the updates, this version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


