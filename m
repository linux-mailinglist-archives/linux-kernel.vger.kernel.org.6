Return-Path: <linux-kernel+bounces-515181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126FEA36163
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0477A16DD2F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F66267722;
	Fri, 14 Feb 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/+gwtSA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9A6266EF6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546268; cv=none; b=bSladh2+bw4kWiEiZlLJde3cP4C+MHyqPvBt+00mJhzN+1tAJQx+tM8GU8w8R7rZ+KvMOAqHLCeieusgKHMu+3tHKR+NWbNctnE5kZaXUIlx3IW0mgaqyZ5t8rX8mwUr92ysvrHcZ/dQq60mZSNWua5PKEIcffi/oUSHu/NV/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546268; c=relaxed/simple;
	bh=yUWhsdLXquBFliy+se8TSDZmPvKV+fFHFYB5zXQhUe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJZanYsvTQvAIA0/0OnTi7tVBvsXk9LEt/I3k/4VbQDnZc6WUD3JNF+2lY5zPndouFBWI39Ci4rsD4sWTNHm4auXYttNyGUCoQ0C9f3pQcQShAzKs4pqx/2x/tEdojt06BkbjpI2zKQBSBhRtze0b3Op1dMFTmvgMxBl4dQJDGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/+gwtSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A0BC4CEDD;
	Fri, 14 Feb 2025 15:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739546267;
	bh=yUWhsdLXquBFliy+se8TSDZmPvKV+fFHFYB5zXQhUe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/+gwtSAeRBU050KjhKjZHk5dxHPPz+g2fAFi1wycA/n9bQHe7e5nZoTLMBChS2ul
	 edDiW0GOUSy8Hem7JDVDqH0xZtcx8g6sWBXBUacTFozYJuV/b76Guh9Ssy8rp9DBms
	 lALhoeay6XpxfJ4x+6hqbaO8TI9RRKTpsrLyrWRYy9UY/x5ME13HW3MP+ZISiNH7w9
	 xB8ehqRn41x754lGlUbN8IfYm7IiQ4x1JCHH3dctugHgsYCL5c/COnzmQMnc4FS+n6
	 9f9WcQFnWhFR3mYfXfK7BCOAwdEIfmBAg6WjsRY3ljz6P5o2I0gIVduS+0lrpcpoof
	 7TVRwL6Oms7PA==
Date: Fri, 14 Feb 2025 16:17:42 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v1 1/2] nouveau/svm: fix missing folio unlock + put after
 make_device_exclusive_range()
Message-ID: <Z69eloo_7LM6NneO@cassiopeiae>
References: <20250124181524.3584236-1-david@redhat.com>
 <20250124181524.3584236-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124181524.3584236-2-david@redhat.com>

On Fri, Jan 24, 2025 at 07:15:23PM +0100, David Hildenbrand wrote:
> In case we have to retry the loop, we are missing to unlock+put the
> folio. In that case, we will keep failing make_device_exclusive_range()
> because we cannot grab the folio lock, and even return from the function
> with the folio locked and referenced, effectively never succeeding the
> make_device_exclusive_range().
> 
> While at it, convert the other unlock+put to use a folio as well.
> 
> This was found by code inspection.
> 
> Fixes: 8f187163eb89 ("nouveau/svm: implement atomic SVM access")
> Signed-off-by: David Hildenbrand <david@redhat.com>

Applied to drm-misc-fixes, thanks!

