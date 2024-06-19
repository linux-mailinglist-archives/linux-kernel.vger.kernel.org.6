Return-Path: <linux-kernel+bounces-220970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 194B190E9F2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4F6B23D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8257A13D8BF;
	Wed, 19 Jun 2024 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ezkOXUhv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF088248C;
	Wed, 19 Jun 2024 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797345; cv=none; b=EiH4yVmjJjIT2WHFap+CfThm8SVNg2Oc6GVBfVqVwcTMXIBK/h9QaWX/LTg8DyxuufpTKTaKhmJwF7Pld9P23iarvHl75v3+KwlMMI5AvPv7pQXe/6XEUzwl9aakKQZCwCV5OWFGjFbbRECq08Yrd6VYFkvjxol5g3xXPwsRj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797345; c=relaxed/simple;
	bh=9nbzgzoMSz4g+t+2ea0rpY+XNFLSLRWc62G32S+O2Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQnX3je+1ErrMN/xcYYjxwzY3680oKGW6jXxOWyJhMqXNkTlpVEENVHR28nKUHfzzP9xHamySd9cw8F4uwxSHXQJs9K7RcyTqqRLbXhHCC2ZPqo6VpLcOB0NqxyRSXzS07+u0jWv3XcLMHfduG6jOuCHo9qqIZRGXZNoCAeUArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ezkOXUhv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718797342;
	bh=9nbzgzoMSz4g+t+2ea0rpY+XNFLSLRWc62G32S+O2Hs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ezkOXUhvHectTqnAcLrhzNGBcHg0uPI4mgEc0gMmVkR4o6ewz6Sbxha3wkztemMX6
	 uL3bzjdXpLqqY9By9GL5Bz22MupxTL5Qoadk4KDY1o/2AzE80dgdRMInlEv+Dn0ibx
	 JK4rOev2qmubnpn1wxRFmsZiDm30OFcjLHvlNxyr6BQw8r54L+6FM7p0Wuf52nqwMU
	 mFN5YM8nUfFHLeG2DbVOF/hj/bmyL2X+GqCJw3UIkPQMuKjq3NBYOFzklf6wXtjLgw
	 E+5Ke0utNmc8ROdmwksPXzWNnwqW/VbJueTgBkNtNqiaMxpqkwrZzUJwMsCszJ/N3G
	 WBxe4JGqAi+tg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 969F737804CF;
	Wed, 19 Jun 2024 11:42:21 +0000 (UTC)
Date: Wed, 19 Jun 2024 13:42:20 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, steven.price@arm.com,
 matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 0/2] drm/panfrost: Add MT8188 support
Message-ID: <20240619134220.683ae228@collabora.com>
In-Reply-To: <20240611085602.491324-1-angelogioacchino.delregno@collabora.com>
References: <20240611085602.491324-1-angelogioacchino.delregno@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 10:56:00 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
wrote:

> Changes in v3:
>  - Added comment stating that MT8188 uses same supplies as MT8183
>    as requested by Steven
> 
> Changes in v2:
>  - Fixed bindings to restrict number of power domains for MT8188's
>    GPU to three like MT8183(b).
> 
> This series adds support for MT8188's Mali-G57 MC3.
> 
> AngeloGioacchino Del Regno (2):
>   dt-bindings: gpu: mali-bifrost: Add compatible for MT8188 SoC
>   drm/panfrost: Add support for Mali on the MT8188 SoC

Queued to drm-misc-next.

Thanks,

Boris

> 
>  .../devicetree/bindings/gpu/arm,mali-bifrost.yaml      |  5 ++++-
>  drivers/gpu/drm/panfrost/panfrost_drv.c                | 10 ++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 


