Return-Path: <linux-kernel+bounces-542034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F442A4C4DB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF7F3A7EB0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117B521480E;
	Mon,  3 Mar 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IY5Ot7im"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDAC2144D8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015373; cv=none; b=Mh7O62vbly1gbS3HHcRT+NZzg/DbFagX3ruRzdys4oRvXhrfuR0rUfVA1OqkIERBxALBo8RDUPE6zXMoxPfr6Jx+M/Rq5r3noSUwtIEX1KuOmWWRC34oWfmfP76t4Ze11sR7nec8GvE8S8xIzMb2gjoisaL/YEtLmhVT4gCqxCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015373; c=relaxed/simple;
	bh=9nNZBR8ulxcMWT/rE4CRC8o0CEGdzGUM1bgO3F5PiHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUxFAhXhhwzsElF2gh+9vIhCQWm/yi1VzkKf0TiPRLywWZ8c/+DXCQIyWhOwtdVhjmpmQI+56wBaec8RM1iYeFGWl8k6PIiL42MQROyWi/gvUDOoP/6tBKpg2DVqzMYgIqwrSyB192mg5NLA+ogbvaLLhruLBVZvhvSO9apA/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IY5Ot7im; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741015369;
	bh=9nNZBR8ulxcMWT/rE4CRC8o0CEGdzGUM1bgO3F5PiHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IY5Ot7im1fkeAwUnJV2V9VqIF9ku9fh7F+dmZxdPMrUhLbhVsMpOKvGr5VhAt9FUI
	 uNlhJlybGZTGHU92EQBAGi2hhDmnAAcxFXYe9DZrLETzd1RWCbMvTk23oGtxofB3M4
	 iyqBwfhMMi6c0V0+vOVHMiOYJabZiaHX68ZohrXNUNd0Mae8XOWpAf+t5Gp1CxX0G0
	 LCVKDLz/OBbXw446BwswP2VnlI9dPNZgZYqIgC9ano3+xw0PLxLxvoqhvwbRo+Pg1R
	 6l12llV0nQFNWhdAce0/8u7VXRGIb6XliuDj/B98vKZkoJi4E5cIm/vHmlpfzcA7PU
	 bGdhIrca6EeKg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1C6B817E0657;
	Mon,  3 Mar 2025 16:22:49 +0100 (CET)
Date: Mon, 3 Mar 2025 16:22:43 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ashley Smith <ashley.smith@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Update CS_STATUS_ defines to correct
 values
Message-ID: <20250303162243.42c9c85b@collabora.com>
In-Reply-To: <20250303151840.3669656-1-ashley.smith@collabora.com>
References: <20250303151840.3669656-1-ashley.smith@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Mar 2025 15:18:37 +0000
Ashley Smith <ashley.smith@collabora.com> wrote:

> Values for SC_STATUS_BLOCKED_REASON_ are documented at https://arm.pages.collabora.com/mali-docs/g610-odin-csf/register/CS_KERNEL_OUTPUT_BLOCK.htm#rp_CS_KERNEL_OUTPUT_BLOCK/CS_STATUS_BLOCKED_REASON
> 
> This change updates the defines to the correct values.
> 
> Signed-off-by: Ashley Smith <ashley.smith@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_fw.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
> index 22448abde992..4d3c8b585dcb 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw.h
> @@ -102,9 +102,9 @@ struct panthor_fw_cs_output_iface {
>  #define CS_STATUS_BLOCKED_REASON_SB_WAIT	1
>  #define CS_STATUS_BLOCKED_REASON_PROGRESS_WAIT	2
>  #define CS_STATUS_BLOCKED_REASON_SYNC_WAIT	3
> -#define CS_STATUS_BLOCKED_REASON_DEFERRED	5
> -#define CS_STATUS_BLOCKED_REASON_RES		6
> -#define CS_STATUS_BLOCKED_REASON_FLUSH		7
> +#define CS_STATUS_BLOCKED_REASON_DEFERRED	4
> +#define CS_STATUS_BLOCKED_REASON_RES		5
> +#define CS_STATUS_BLOCKED_REASON_FLUSH		6
>  #define CS_STATUS_BLOCKED_REASON_MASK		GENMASK(3, 0)
>  	u32 status_blocked_reason;
>  	u32 status_wait_sync_value_hi;
> 
> base-commit: 16e57a72780931c3c70dbc928aeee4a0518075de


