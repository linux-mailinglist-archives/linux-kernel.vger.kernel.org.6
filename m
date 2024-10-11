Return-Path: <linux-kernel+bounces-361255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C0C99A5B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E04F286695
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0029215015;
	Fri, 11 Oct 2024 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="lJvNMdTo"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2024431;
	Fri, 11 Oct 2024 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655394; cv=none; b=QOyq/O5Bcq5Gg39YdiRfRmZkOnuGNnLEa0defX/pmNY6QUcsv8+ymP3jnfiaSlsP9t4ME5wtyHsnweF8K2xurGFWLpPGzp7MPAF3Pb2HJwwV8lmOESTCevUm4cTdJpq5UcwdfO2UFTaT451MThPhT/ve7yLoVfyPCjCAgj3rxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655394; c=relaxed/simple;
	bh=n1WOgztgdZol/yqRy+BG+Mbi1frWGk6AMzu1Epuh+V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b1PO/nyXnSz6efGAfIeJzcWu+xeBS2j4ZwhRqI61OIybRpv/uDPOgnBJP3S8fKk9AZMKZ8dEcaWD97vhNwSVuvHHidmZa8FhD54xW2P+Fd854GEvftLXpPvQiRA4sdML/cWaRSCxfzp6R5kuRIgWvt5uzQS301znkoKhOYU1ccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=lJvNMdTo; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XQ7QS5CYqzDq6L;
	Fri, 11 Oct 2024 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1728654848; bh=n1WOgztgdZol/yqRy+BG+Mbi1frWGk6AMzu1Epuh+V4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=lJvNMdTozdaJX+XqPr/cNp3cqj41SoepdQ0WV/W7Mq35yhjskxEf9sLWm6ujQ4rTD
	 pUZ+tua2dPphvIxtCGs5dUFIz+SWqdd0AXQ6WvvzFJeAR9fsixNXMSi7maZ3R4Uda7
	 nORsfHJrjMVetgI1cs0PtHVOrL+4hERm2Rm+dmps=
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4XQ7QK6MYsz9tt6;
	Fri, 11 Oct 2024 13:54:01 +0000 (UTC)
X-Riseup-User-ID: DE0616E53A0FE088A8995C5F0A19FD8B9EDA153B7652DC58E32077D8E8E2CD23
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4XQ7QB6JnQzFrsK;
	Fri, 11 Oct 2024 13:53:54 +0000 (UTC)
Message-ID: <608074ed-567c-4e6d-b1c2-9e0ecf1d102b@riseup.net>
Date: Fri, 11 Oct 2024 10:53:52 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v12 09/15] drm/vkms: Remove useless drm_rotation_simplify
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Simona Vetter <simona@ffwll.ch>, rdunlap@infradead.org,
 arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi,
 Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 thomas.petazzoni@bootlin.com, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, seanpaul@google.com, marcheu@google.com,
 nicolejadeyee@google.com
References: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
 <20241007-yuv-v12-9-01c1ada6fec8@bootlin.com>
 <Zwjxo2TEAR3PelO9@louis-chauvet-laptop>
Content-Language: en-US
From: Maira Canal <mairacanal@riseup.net>
In-Reply-To: <Zwjxo2TEAR3PelO9@louis-chauvet-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 10/11/24 06:36, Louis Chauvet wrote:
> 
> Hi all,
> 
> Until this point, this series has not received any major comments since
> v9. I will commit patches 1-9 next week if there are no further comments.
> 

Although we are maintainers of VKMS, it isn't recommended that we push
our own changes without even the Ack of another person. Please, read the
"drm-misc Committer Guidelines" [1].

I can ack patches 05/15, 07/15, and 09/15, but it would be more
beneficial for the community if you ask for an ack (from me or from the
DRM maintainers, which are always around), instead of saying that you
are going to commit the patches without any review.

[1] 
https://drm.pages.freedesktop.org/maintainer-tools/committer/committer-drm-misc.html

Best Regards,
- Maíra

> For patches 10-15, I am currently waiting for feedback from Maxime to
> send the next iteration with a fix for kunit tests.
> 
> Thanks,
> Louis Chauvet
> 
> On 07/10/24 - 18:10, Louis Chauvet wrote:
>> As all the rotation are now supported by VKMS, this simplification does
>> not make sense anymore, so remove it.
>>
>> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
>> ---
>>   drivers/gpu/drm/vkms/vkms_plane.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
>> index 8875bed76410..5a028ee96c91 100644
>> --- a/drivers/gpu/drm/vkms/vkms_plane.c
>> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
>> @@ -115,12 +115,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
>>   	frame_info->fb = fb;
>>   	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
>>   	drm_framebuffer_get(frame_info->fb);
>> -	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
>> -									  DRM_MODE_ROTATE_90 |
>> -									  DRM_MODE_ROTATE_270 |
>> -									  DRM_MODE_REFLECT_X |
>> -									  DRM_MODE_REFLECT_Y);
>> -
>> +	frame_info->rotation = new_state->rotation;
>>   
>>   	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
>>   }
>>
>> -- 
>> 2.46.2
>>

