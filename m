Return-Path: <linux-kernel+bounces-521711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E4A3C15E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231EC3BBA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682161EFF9D;
	Wed, 19 Feb 2025 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrMrzmT6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416D1EF0AC;
	Wed, 19 Feb 2025 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973767; cv=none; b=MsPbZcXDtYw6u2oJPzIhDvy+a8Xl23nJNnn8NrdYxJCZRZ3cx0mGXNN/1ilB2mLxix8ttx1jEQvcwmjPnj7xzO9UuSEfOthg9egyz0s5MR5l1Pn3y3+4upOwOMl4rNIvhd+toF4GpzH8QvezA3tBp0okI7I2DWeBQOtvdz5if0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973767; c=relaxed/simple;
	bh=Zti3H5sZRXPrT/wgsFtd7JosJu7DWgxLjY1/qLK8CAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sk6tUZf28SDPSEGS91+/jPHdnPB9Zek5u562/P5405zdmuI2ojs0ur/sL3fS1cS75WW65ooaRYJb9B+rVzoK5Bki2m99JGwFLt89fR+IwZ0qxb7BMBFXdMYN0dSOjRgFnKvmxZLQ8IxMqYTrg3vjwbuy+83riM0E+/lkkUo+IuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrMrzmT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C55C4CED1;
	Wed, 19 Feb 2025 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973767;
	bh=Zti3H5sZRXPrT/wgsFtd7JosJu7DWgxLjY1/qLK8CAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrMrzmT6/Ttxw+lY5X5liP3ZDX6ejkZBxuz/lGmpZGqbwip9NN10iMpwRvaflgzRa
	 tWdglfSTcSLji0kw5orVPYOUDGM/9P51NmBNjy4AkUPKNxnWHqoTSHzLOUlKfnXiXh
	 RrlblesBsQgwpGOHTqcfL7HnB2QrxbA72zVqo9CSERMPxJbMz6+ExoavDfnk8tEmQi
	 6HrZskyWLtmww6efpGT7GMdgyQ3CS+NUTCxQGTJknkKv1iuC63SPvS/LncZ7W7cW3C
	 zjZzevxDBBkcnvhrE8Lxrzbq6ip/0IJZ/b/DnUsUxKtRL1qn7aNgqwfc4laoMCiuef
	 X2eIEvx8Av5GA==
Date: Wed, 19 Feb 2025 15:02:42 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Zhi Wang <zhiw@nvidia.com>, Lyude Paul <lyude@redhat.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Timur Tabi <ttabi@nvidia.com>, Dave Airlie <airlied@redhat.com>,
	Ben Skeggs <bskeggs@nvidia.com>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/nouveau: Fix error pointer dereference in
 r535_gsp_msgq_recv()
Message-ID: <Z7Xkgr5zP23VRhx1@polis>
References: <b7052ac0-98e4-433b-ad58-f563bf51858c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7052ac0-98e4-433b-ad58-f563bf51858c@stanley.mountain>

On Mon, Feb 17, 2025 at 10:31:21AM +0300, Dan Carpenter wrote:
> If "rpc" is an error pointer then return directly.  Otherwise it leads
> to an error pointer dereference.
> 
> Fixes: 50f290053d79 ("drm/nouveau: support handling the return of large GSP message")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to drm-misc-next, thanks!

