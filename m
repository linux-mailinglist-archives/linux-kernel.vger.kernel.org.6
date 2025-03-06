Return-Path: <linux-kernel+bounces-549532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39793A553A1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A396178595
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DE525B671;
	Thu,  6 Mar 2025 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvyeca8q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B7725CC9F;
	Thu,  6 Mar 2025 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283691; cv=none; b=TfhFE0J1TIUmzVT5kHeHQwxWgyhT6EG9qEQzsJRGtlLTb2wIboP3heTxTcXVw/75FiX90nWXztWAgOSEWd4GfAuJ6GBkdv3lJbBYP5EqipDHEZO6g3TPmWtZyxsAEjpk54xJfvEievrMAncEXZpgcN/MCmPEv4cvaVlxjre0eog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283691; c=relaxed/simple;
	bh=qdm0HXf809KweRtwUqUjuGRSBGOGTK1ZwZaRFgirYRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvA+OHro7Y5F2jI+JZalXBGtk4K4uYjnWVOnx9biV+AQSJr5DayVH3AEJ4iU/z5654+4o6Bmtt6mhwTLNl8E/dCAUx543R+NUdBr8TZkh2JIChonwqhxMHwtKlOAYYg/7tQEHmMeXa6KnEcC64cZsY6vkcBVIUPnqBn03hTrgyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvyeca8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22CEC4CEE4;
	Thu,  6 Mar 2025 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283690;
	bh=qdm0HXf809KweRtwUqUjuGRSBGOGTK1ZwZaRFgirYRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvyeca8qxs7P3W1cB3g1bfO7xa34ZgU6UzS/2Xw2Ke8Y5C+SHP42WUYKTCA/XDjSz
	 FjbkFpLBkmJ68b7CEwE9qW2Iz0u9aFlQbYa7hPxav/f5BwY+9xjfwIjSM80HNOTp1q
	 deE5Xv3bzsptGL79GvA31/lWGAxZiQ4mVAsy2U2VB5QLW6En9wYGDzl0lBFgxgXKcd
	 HtICT7lmTGARxxeBF/1IN/Bx1ztga1oBogdPLEmauOzTMIrybmbYCgGdnLPuVx+HOi
	 eKDaqhfLtiO+g7wrIFMgzJz12m3R0G+Bh6USaIIo3MCOvBUS/2U9lUgHjU7AHeNsYd
	 bT/69fw5lyhTQ==
Date: Thu, 6 Mar 2025 11:54:47 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	David Airlie <airlied@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: mitsubishi,aa104xd12: Allow
 jeida-18 for data-mapping
Message-ID: <174128367535.567143.5317524679699355354.robh@kernel.org>
References: <20250225210316.3043357-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225210316.3043357-1-robh@kernel.org>


On Tue, 25 Feb 2025 15:03:14 -0600, Rob Herring (Arm) wrote:
> There's both a user and the datasheet[1] indicate that 6-bpp is supported
> as well.
> 
> [1] https://agdisplays.com/pub/media/catalog/datasheet/Mitsubishi/AA104XD12.pdf
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/display/panel/mitsubishi,aa104xd12.yaml          | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Applied, thanks!


