Return-Path: <linux-kernel+bounces-543457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B7AA4D5DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFB6170EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4351F9F75;
	Tue,  4 Mar 2025 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xo5APdBg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211301F9A8B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075910; cv=none; b=Ch+HOLChVnnsV7ZmzQ2lvnvCSUYsNT53OOg012imUW4MiBIj3eIvG9Rchfl9UYlSsSiLLkgLkzPYPUljbyr5TVRZHhaS4MCD6l6ZsDjFOuqOWaujDNaqPR02mZugRcGYgr96aFkshgTkej/48rXbTAF3ZofeMVNosdvvKY3ChB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075910; c=relaxed/simple;
	bh=PTleApijGcXJCM0OtIk1SVoikxBFpczb9jEcak3wAW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSJ+ytZKYKFfXFBrW9F/PUOjzikGxDAhPoWxYXqdHmuskyL9bpd1VYiRg1J4WI5VbmPRRBIcjiNTuFuBfX65QI419KeqGOEITAVqnEmqleUCMgzC1uC/5FG5zuYkmIOnEprgqJ9wyieHJJMyaBSW/AgfkxxgwHuXiJtmrlH+yz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xo5APdBg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741075907;
	bh=PTleApijGcXJCM0OtIk1SVoikxBFpczb9jEcak3wAW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xo5APdBgPTTiQPYDNI9JFlnKyOz4H8I6/FyvtRONXY2zZx56J30trt0lt25bZaXBG
	 L7ZoJHs5iB/XDDBMZm4P0gM2PdsDDdCkKSwM2d+01G2TLf8GVXWhiPpizy9LcOBFTA
	 TplDCLRRxzTwhWaxqqf9OUmLFf0btdrUK9CFubIS0fXHYUnu71zhVdoXlH6P3I0Akz
	 0mL5j+33n+3FOPpKJLbvLMBYhYOK30CMVjVUlHwChA5W/T7fqTdWWhBcBI/1YDJaFG
	 RBDtVm+sYAdNVvaQ1KaBmuAAc+oLobuR7iwzsWH6lZ9dUaZ5vHUsMUh7PedLLUu8Ip
	 6v5ljFY90ajgQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 948BD17E061D;
	Tue,  4 Mar 2025 09:11:46 +0100 (CET)
Date: Tue, 4 Mar 2025 09:11:41 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ashley Smith <ashley.smith@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Heiko Stuebner
 <heiko@sntech.de>, kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panthor: Update CS_STATUS_ defines to correct
 values
Message-ID: <20250304091141.50f21736@collabora.com>
In-Reply-To: <20250303180444.3768993-1-ashley.smith@collabora.com>
References: <20250303180444.3768993-1-ashley.smith@collabora.com>
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

On Mon,  3 Mar 2025 18:04:32 +0000
Ashley Smith <ashley.smith@collabora.com> wrote:

> Values for SC_STATUS_BLOCKED_REASON_ are documented in the G610 "Odin"
> GPU specification (CS_STATUS_BLOCKED_REASON register).
> 
> This change updates the defines to the correct values.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Signed-off-by: Ashley Smith <ashley.smith@collabora.com>

Adding my

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

back, so whoever ends up applying this patch doesn't have to add it
manually.

> ---
> Changes in v2:
>   - Rename _RES to _RESOURCE
> ---
>  drivers/gpu/drm/panthor/panthor_fw.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
> index 22448abde992..6598d96c6d2a 100644
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
> +#define CS_STATUS_BLOCKED_REASON_RESOURCE	5
> +#define CS_STATUS_BLOCKED_REASON_FLUSH		6
>  #define CS_STATUS_BLOCKED_REASON_MASK		GENMASK(3, 0)
>  	u32 status_blocked_reason;
>  	u32 status_wait_sync_value_hi;
> 
> base-commit: 16e57a72780931c3c70dbc928aeee4a0518075de


