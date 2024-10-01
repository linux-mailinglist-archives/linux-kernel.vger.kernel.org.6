Return-Path: <linux-kernel+bounces-345885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2EE98BC6E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F439B23B02
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2285D1BF7E0;
	Tue,  1 Oct 2024 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8W37A3o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69E1C243F
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786588; cv=none; b=FaoI35H0oA67SsG4Twa/iyL+WqjJa2yyI8Toa6XCEuQjXLulJBNkE5x/2IZ39QeCL3we7adPnXsVj1KSA4uzDv5qGVUALga5DVp/AHWoHH5FeTX98x3UMTYRxPvmBZGIvlhPZ9sYEM3oCwoECwy9Bg0FXo+jezUfXPLdKoa4RkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786588; c=relaxed/simple;
	bh=i/NOaICWoBDmIs5m38L9neAlEc/xMzIGN73bTpBOZeE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ui183SsMeY/M3/Z97M6iQeRtfVAlrPJzYN1Q4dmTzo9CShBuS4lTSKPZEzWn9m4uwv+xoWkNlOZu5ZKdyh8iiUKNGeUtYMbCxC50r5BdmyB4mw8ildi0sCKyDF2aTj0Tr4T3RFXLvfrAywIp3+GBPiSaXnJ0YS/EiqFG240w2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8W37A3o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727786585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZZwkLCrIjRhjwyetK5HgYU6fwijbH3MWN7r4wKk24Q=;
	b=c8W37A3oELmjdnn8OUaqG1AX4h6GoQOK/reyc8TrEmwFBjWVpP1FAmIh+Go7tSbZCWyNVh
	BrC38mpytBAHyOVdIQnQYteqenmvFEdf/luQjhspSJIMvzCA2RzEQMwI2UwO0Uyt3QgJD4
	u8Rt7gweWA+uDOhA1df+v7YkcB0TCAw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-OvgqxY5dMTCe95n3-dbUKg-1; Tue, 01 Oct 2024 08:43:04 -0400
X-MC-Unique: OvgqxY5dMTCe95n3-dbUKg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb471a230so41821545e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 05:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786583; x=1728391383;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZZwkLCrIjRhjwyetK5HgYU6fwijbH3MWN7r4wKk24Q=;
        b=OBl1uRCYZZT31RVxS9l7TRJGffnq7GA/DnfQtm4CvDBPaA8JRzNqeH6H+Liuj4FJ9X
         HSuygvux3tmCvirFr1yIq5UcuNKiGtXaLPUNAdWoQKbXiCDzH5XtZoiSjAxTPgmvEGlE
         dUo4BbXT7bX4eeyAsSF1kI/K148NJWu5B9XvIfqWYtidM9kTD7ZqSTQ0AgSVXDxJE/G3
         2/Z9E4q/zBjqZdPIEwW5zAuBhktxnmo6TvnznQQvGroR6cCczwH7JLNqIdlziYZJLkbf
         rSUIDAJIbWxr7qSSNUMKxRk9N9KqfnIOIBDVQb9fUrLQPxKaHdeiHlT66niy3i9kVksL
         UGxg==
X-Forwarded-Encrypted: i=1; AJvYcCV8R3jRkDy/QvvPLZqj5bi7xbGcSF5uxYQVb7n+eeJ41V+cSb9ECZI2J6NZspsMqXxoQ3YvyWPlDdp42JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXypbAogYLBu5tUHkfn8F7YcZ2VQ7uLg9ZKN8lyYlzn0mwIPXP
	j1NgN0okq3KymJixAumIwMLbJbtB5Vtqkm8cfSQIIgYPvBAfoOG+0wbCyblZjXpAeRrqNLoqioo
	zN1A4spNyGB//gGXtIBrIRunsFPCwJo3pQIa1IxAfn6oTBJBvE5nSbN8jGe1W9g==
X-Received: by 2002:a05:600c:1d25:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-42f584a20f0mr124885955e9.31.1727786583153;
        Tue, 01 Oct 2024 05:43:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHogCrKXi/LLAK0Yw/SyE+LUwqB53YlzciFZKHfFpK4j+UOGuKZEYk3OW+MVNbB7x8klnkLJg==
X-Received: by 2002:a05:600c:1d25:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-42f584a20f0mr124885715e9.31.1727786582790;
        Tue, 01 Oct 2024 05:43:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36292sm179550505e9.32.2024.10.01.05.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 05:43:02 -0700 (PDT)
Message-ID: <9f86a94a-02da-496d-81cd-5a2306520c6d@redhat.com>
Date: Tue, 1 Oct 2024 14:43:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add dce6 drm_panic support
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Lu Yao <yaolu@kylinos.cn>, ckoenig.leichtzumerken@gmail.com,
 daniel@ffwll.ch, Xinhui.Pan@amd.com, airlied@gmail.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, srinivasan.shanmugam@amd.com,
 sunil.khatri@amd.com
References: <20240802071752.116541-1-yaolu@kylinos.cn>
 <20240812060914.102614-1-yaolu@kylinos.cn>
 <CADnq5_OcUgV9dgAynDCQnm9NS+QCvhBiHvxWnhWqi2qqhh=zXg@mail.gmail.com>
 <16352ae0-7e61-440d-8c04-7ec912f9bf9a@redhat.com>
 <CADnq5_O7njHcvu0ejvVPPKF7szsbEQ8oFfHr9GTyD+zAe2EJ8g@mail.gmail.com>
 <8a1afe12-4d59-4cbd-aede-fce22f8fb979@redhat.com>
Content-Language: en-US, fr
In-Reply-To: <8a1afe12-4d59-4cbd-aede-fce22f8fb979@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/09/2024 10:33, Jocelyn Falempe wrote:
> On 24/09/2024 16:02, Alex Deucher wrote:
>> On Fri, Sep 20, 2024 at 11:36 AM Jocelyn Falempe <jfalempe@redhat.com> 
>> wrote:
>>>
>>> On 17/09/2024 15:21, Alex Deucher wrote:
>>>> On Mon, Aug 12, 2024 at 2:10 AM Lu Yao <yaolu@kylinos.cn> wrote:
>>>>>
>>>>> Add support for the drm_panic module, which displays a pretty user
>>>>> friendly message on the screen when a Linux kernel panic occurs.
>>>>>
>>>>> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
>>>>
>>>> Patch looks good to me.  Any chance you want to convert the other
>>>> non-DC dce files (dce_v8_0.c, dce_v10_0.c, dce_v11_0.c) while you are
>>>> at it?
>>>
>>> I've made a similar patch in amdgpu_dm_plane.c, and it works on a Radeon
>>> pro w6400.
>>> But it only works when I'm in a VT terminal (so the framebuffer is
>>> linear and CPU accessible).
>>> When under Gnome/Wayland, the flag AMDGPU_GEM_CREATE_NO_CPU_ACCESS is
>>> set, so that means I can't vmap it ?
>>
>> It just means that the application does not need CPU access.  Whether
>> or not the CPU can access the buffer or not depends on the size of the
>> PCI BAR.  E.g., if the driver or bios has resized the PCI BAR, then
>> the CPU can access the entire BAR, but if not you are generally
>> limited to the first 256M of framebuffer.
> 
> I tried to use ttm_bo_kmap() anyway, it returns a valid virtual address, 
> but writing to it has no effect on the display.
>>
>>>
>>> Also I don't know if there is a similar way to disable
>>> tiling/compression on this hardware.
>>
>> UNP_GRPH_CONTROL on chips with DCE display hardware and
>> DCSURF_ADDR_CONFIG and DCSURF_TILING_CONFIG on DCN display hardware.

I've now a working Prototype on a Radeon pro W6400.

Here is what I do to disable tiling:

REG_UPDATE(DCHUBP_REQ_SIZE_CONFIG, SWATH_HEIGHT, 0);
REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, DC_SW_LINEAR);

REG_UPDATE_6(DCSURF_SURFACE_CONTROL,
		PRIMARY_SURFACE_DCC_EN, 0,
		PRIMARY_SURFACE_DCC_IND_BLK, 0,
		PRIMARY_SURFACE_DCC_IND_BLK_C, 0,
		SECONDARY_SURFACE_DCC_EN, 0,
		SECONDARY_SURFACE_DCC_IND_BLK, 0,
		SECONDARY_SURFACE_DCC_IND_BLK_C, 0);

I also need to call this, to refresh the display:

hubp->funcs->hubp_program_surface_flip_and_addr(hubp, 
&dc_plane_state->address, dc_plane_state->flip_immediate);

And I use a modified version of amdgpu_ttm_access_memory() to write to 
the framebuffer.

I will send a patch when I've time to make a clean version.

Best regards,

-- 

Jocelyn


