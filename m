Return-Path: <linux-kernel+bounces-553369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 604FAA58830
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 21:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6C37A1AEB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202A1DED67;
	Sun,  9 Mar 2025 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="neZOkEP2"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8539D1C700F
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741552203; cv=none; b=uwfLhGDqED9EwvvZ2DVAbmZzWjcwG7ZLwe3B+Zcy20Mee7ORbghGte7rHrPhezgFyOzsztIInWU/8DRw/tk+XzMEXgNeftH5MzwO2Jgd5cKPhPk1MPWu7qBlSkD7BhE0TGvAhVcTkBeEqh3XRJ/5XZFxQu5lqSSSEH3VsaJTxKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741552203; c=relaxed/simple;
	bh=ThF7kvzYa/E8fSC9vAFOMgeWn7KWFG0cDjaRmzAahuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LcEwvTl/oH2/8SKp/LvwloWs7LJ1AERGNaQoKOC9q24F8LCXWJmAza2DA8fgKyz64hlo/dVlPkKWHYCNv4mWg3Gli5QTr+1Pluuw4m+6IhOQSY66MMH6Powmz5moLYxVJ36VBTN4LRYMwWFvRBzDzs0VfAR0N0hpxYw7fPWSffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=neZOkEP2; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CiEwnW3BQBlaW9eYp7f+XfrbZdqWq7TjAzBqepm4H+A=; b=neZOkEP20YdgIPBes3WtdpM6vu
	tpDWoqgoT6fU7i8ycIAGeS/tR1LU7KOQ2jLfn8rCrIgAN4916ger6SDuxb6ZsV4CjXXg4BIOStqPj
	xzKj7o0wjjBLc9K0NaM3tqnkj/7z4okausFcDGw2VVoG23o6n4YyOgw3yGYfWsYKfRLKEn/3DPxCe
	G9Zgb3KIvtGxtQ7PBG2w2U8WUdM+gtWjjI2R/5VieBy1wcyfhx9BR3UmASl0TkDVtISSYk+zD+0z1
	r7h6r6C10kuCjpxpRHzyjnXk6LxJwDc1UU1AcxT2EhAErInOBD5Lj+Q9FpsROF5m5QEm3MhjmK2PT
	39YGNSuA==;
Received: from [189.7.87.170] (helo=[192.168.0.224])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1trNGx-006EjL-2m; Sun, 09 Mar 2025 21:29:25 +0100
Message-ID: <f5f920ec-be44-48d3-ae4d-bd385c3a4a5b@igalia.com>
Date: Sun, 9 Mar 2025 17:29:16 -0300
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
References: <20250305102107.2595-1-hanchunchao@inspur.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20250305102107.2595-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Charles,

On 05/03/25 07:21, Charles Han wrote:
> Fix below inconsistent indenting smatch warning.
> smatch warnings:
> drivers/gpu/drm/vc4/vc4_plane.c:2083 vc6_plane_mode_set() warn: inconsistent indenting
> 
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Applied to misc/kernel.git (drm-misc-next).

Best Regards,
- Maíra

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


