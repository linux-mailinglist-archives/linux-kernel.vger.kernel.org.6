Return-Path: <linux-kernel+bounces-575129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D6CA6EDD7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4AE168423
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA481F12F9;
	Tue, 25 Mar 2025 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JM0jx9RR"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027F254869
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899006; cv=none; b=nUkRU710sNGDgOkSexJKaqrXinLyoAbY87JRx3scnm+AjOBmsU87nAcpkYmZYFj5v9fiRtEGmVeX2p5liiV/WWwXEeJz7sCUXzXK8drTBUSy4ibGoBKNaWKX5YZQ4uZ5oJj9eFFRvAz3NFnnmQ0eAIXpXnZojvnCoJKeAKI9nBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899006; c=relaxed/simple;
	bh=rw8y9VnPnejJL6hybk/2JjnjQWKkV5LPZp+ps37jAk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFaRCM71TVE4MW0UC1IVRZ/n4qjPxxtvalmeasM0DndmEOkf56qDo5l9QkRWm2avdrN8SPxervpE58MNhn6fn2p+sokfV5W4PBNb26yQ4gx2fmOtvOnca0MZq8uaF84zcQ6BMIFUzw085FR7T3zjxWtZDRor1sk1qG+LPsd/730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JM0jx9RR; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G7nYKqTlrwdciC2jlP0mlhTruy9qnVkXuAUEoJVLEPw=; b=JM0jx9RRsbWAMbDY+0P4VKr5+m
	qyIhmhu40UDT6hTolRqFS/45dxTdSeynMLoZ8izG8GXqOCQOcFKzyKwpAczVaVfADa7QV0cQ6QET9
	I8Tx4piQeOkVhy/7oyaIoX7KGSZAsc5IRCUn1bCwwAJT8rwxYgQvIHBqZAe9zWqPW6GmICq3ToO+Q
	hLGru0+ngK8ZHHbqFiIaDDU43oZ/qboY9htiX8dSpEVST1Ognm1uT644pCxIUcOVR0MeHOnO9cCRg
	7m3c0wZNqVjCnCTo6O226ZXw3o0QGa0vKHjVZeG5vsv36luGS8WdhD4mBmJk4vWKxodpzjnI4Kv12
	XDOSikCA==;
Received: from [189.7.87.178] (helo=[192.168.0.224])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tx1di-00670B-Rp; Tue, 25 Mar 2025 11:36:11 +0100
Message-ID: <a6b35845-6a4e-4488-8ece-04a4c1e920d5@igalia.com>
Date: Tue, 25 Mar 2025 07:36:05 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vc4: plane: fix inconsistent indenting warning
To: Charles Han <hanchunchao@inspur.com>, mripard@kernel.org,
 dave.stevenson@raspberrypi.com, kernel-list@raspberrypi.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250325081232.4217-1-hanchunchao@inspur.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20250325081232.4217-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Charles,

I already applied this patch earlier this month as I mentioned in this
e-mail [1]. Here is the commit [2].

[1] 
https://lore.kernel.org/dri-devel/f5f920ec-be44-48d3-ae4d-bd385c3a4a5b@igalia.com/
[2] 
https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/ce468a7b63f1e4e2b09f951ca0a7c8d402fed746

Best Regards,
- Maíra

On 25/03/25 05:12, Charles Han wrote:
> Fix below inconsistent indenting smatch warning.
> smatch warnings:
> drivers/gpu/drm/vc4/vc4_plane.c:2083 vc6_plane_mode_set() warn: inconsistent indenting
> 
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>   drivers/gpu/drm/vc4/vc4_plane.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
> index c5e84d3494d2..056d344c5411 100644
> --- a/drivers/gpu/drm/vc4/vc4_plane.c
> +++ b/drivers/gpu/drm/vc4/vc4_plane.c
> @@ -2080,7 +2080,7 @@ static int vc6_plane_mode_set(struct drm_plane *plane,
>   			/* HPPF plane 1 */
>   			vc4_dlist_write(vc4_state, kernel);
>   			/* VPPF plane 1 */
> -				vc4_dlist_write(vc4_state, kernel);
> +			vc4_dlist_write(vc4_state, kernel);
>   		}
>   	}
>   


