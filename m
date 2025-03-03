Return-Path: <linux-kernel+bounces-542661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3CBA4CC1C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C20173ACE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7CF23278D;
	Mon,  3 Mar 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4R/4wfq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693581C9EB1;
	Mon,  3 Mar 2025 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030872; cv=none; b=ByKdGSmimiP5QFIB56olwtYQX5iTE5w1j1WdkAAQmRQL5FhPK9hNYrvA9A5wmm5bPfWNXGoHtE50441K55TEJmzriReRdb8C4OVJbY//iFYCx0Heu2E2Lqj+s8T2SrZ4/+yC6rXk+sR8WoJyJhh0HMWADg9AFXv/YwkyhM9Ecj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030872; c=relaxed/simple;
	bh=KZ7XHt3siA+yNszSiXHA6b2kocbImvk02r3QUZ/DZZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6QmaJpLfiKhJ321TEe8/umjG5/5+LqyuIAjTeUd4xo0gk7q/mil8HVYtZ7uCQO3n1uEILaFtjA7knoNCe4M6oK+0MK4O3AZ4aFPgNnil9zv50NrcIIzQRCZ2DzKfrqEvmZpVyW4a3he8pEihBABvJ0Y+8xGrismTdJ0CI2smng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4R/4wfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726B8C4CED6;
	Mon,  3 Mar 2025 19:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741030871;
	bh=KZ7XHt3siA+yNszSiXHA6b2kocbImvk02r3QUZ/DZZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4R/4wfqdlrIGvmcugqLfadqwrTOGhj7dTagqcKlM/tk0jdSaoHVHBi5NoHg/J+y6
	 2KFr/inmJ3UqWjEeYw+YYmQRr5G59RaZxbjV2H+TQrTVVL4RnjU1vYJyneFxFuSbcW
	 wc7nBI7LXcCvC6j708R2cjA6L7Dj/r1YRsS4Z+v9hJ0CvbBRDla/G6qWowhMfVCmMY
	 cvnl/DVYxMqxHe8biHWokNOEAx/gE2dN5chjNK17bYd0WzE0l6IJx8W6X+1Vy3Uk7K
	 o8hM7ZcIqrjiedyi2XMAWIZxlGo+TG4NubYoUedcd26BrriSqAucab1v6bmVXMl1bb
	 NV0ZC/Fnj+zgg==
Date: Mon, 3 Mar 2025 20:41:06 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Simona Vetter <simona@ffwll.ch>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] drm/nouveau: Add a jump label in
 nouveau_gem_ioctl_pushbuf()
Message-ID: <Z8YF0kkYLlh1m5ys@pollux>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
 <809905c6-73c0-75a6-1226-048d8cb8dfda@web.de>
 <684bfc0d-7e1d-40f1-b1b7-d6ed64fcd8b7@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <684bfc0d-7e1d-40f1-b1b7-d6ed64fcd8b7@web.de>

On Mon, Mar 03, 2025 at 06:49:07PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 5 Apr 2023 18:38:54 +0200
> 
> The label “out_prevalid” was used to jump to another pointer check
> despite of the detail in the implementation of the function
> “nouveau_gem_ioctl_pushbuf” that it was determined already in one case
> that the corresponding variable contained an error pointer
> because of a failed call of the function “u_memcpya”.
> 
> Thus use an additional label.
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 2be65641642e ("drm/nouveau: fix relocations applying logic and a double-free")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I'm not entirely sure, but I remember that we had this discussion already.

Can you please send patches from the same address as indicated by your SoB?

