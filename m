Return-Path: <linux-kernel+bounces-241066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB1D9276B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704711C220B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DD01AC22E;
	Thu,  4 Jul 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqzzvSmK"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352987E9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098160; cv=none; b=BjXLEN9jhVFD/jdPpONbqHAegBr4HHH6tfUfNl42XeAoESFh2EItgrjCSGDpieVd8FAD7CI0HS+eXVj4FqNTA0dnKvZGnU/qddCEuUl/bnd9Q/1XdOsdUtz9tKp00Fa7aQkdKfg5EFHoHK6tfQ79wU2+FIZCUpWDmQ5N+L3umxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098160; c=relaxed/simple;
	bh=OJMMd6j0eHYohD4KNrlzeaqt+5lH6QDGMb7JktsdYXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roVR+Ie+bHUYkJNEF5chj1Q9RGvVMooYoaZXC3uLmbDnX0BePSo50Y4G8CV8UUquc5BYhLhcdPHFhXQZtfIV7CywH0ZgIJWEAumxBbd9WY/qSXhfLbWLHLjXeRbbij1op9E4/nJ9Wosy6tTPAR4plbwFbeV38xUfjef4xAF+D8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqzzvSmK; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so7228241fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 06:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720098157; x=1720702957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYzELPqhwd90nc3XRq3C8yvVVSaVJeIDbfmf6pI/VMY=;
        b=QqzzvSmKespufV9juHfmEt7FtIJpnBoWORZqnNDkX3AUMZGpAEgYVMAmkuakYFXoiY
         /2N2IpSBxaw4+h6KBnqwj+2O1KAj2Xo3JS9M2+tmiG5XSVscyBIzQ6ZcuF33wearM3IJ
         k2MtbJXUqNJj4wpJ3UXqQcbwxsb0qqKMcRpqrxPAh8F09hGckmLmmg2hc3JNNJjULy9z
         cwSUeoLk9jyWI9SHMtHCW2j7yYjWTdYwXkBznAguBCf59M/xXYMxi6OY+AhoUy6tbOsb
         XCyHPhDsoxBhAbiLZagYD2ORbd0+0FKeU6oG4Dvlh+9TgAULC8MtCj4SC76GrzqRX/ak
         Z/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720098157; x=1720702957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYzELPqhwd90nc3XRq3C8yvVVSaVJeIDbfmf6pI/VMY=;
        b=HJ9GAuut5DWEalhM2labaSuswnesWerYYyoXTGxSS+CRhfIFOYxL6kewCbdPgBhPWO
         5dzb1nZRT6U5owvl+QWbwoRcnzGD9/Si9vPNjCGUn59tHTazI3N0luuR33pW7zshVF1v
         QnBS5yLKz71Wisek0GNTwppNkhYyyBed2zmdVaeSv//Aud145WImlNMUcLW+V8uTlGGs
         Fp3L2Tl1mn03MNYL/5I7NJx8lYQQNRTpgtAShpaDAZ3Ufd5P8wboUx/PwU0TycN6zGCK
         X588V6Amb0EO4/EJFn8C9DQugo4WtXvDFW8xGKnjaQMFZVj4cwaF3nRonQC9ynqf6Z1K
         rCng==
X-Forwarded-Encrypted: i=1; AJvYcCXPWb+tw9dR0FgiVpjPjvmbIYtWIL+PKq4qSZZt25c00/6m3RRFm6zutlvVc4rVtnCS/EJ5AwArZyvyLOjJyOx9DytSKaVEb5gI+cTT
X-Gm-Message-State: AOJu0Yzvo3OFSWIDqIboxuA1iZGxJA/BN7Qc9n4yegjQumfc2q4X1bCM
	kdHFC5i6dzQ5yLHRqwRIquHcDkNSuT5tCe0QyAaveH5LaXNUQutC6HLU+fMK
X-Google-Smtp-Source: AGHT+IHB46KLyRy+mPjFpVofOsGJPEp7Rjn1ERtbNbQDfpsh5s651UESQ96G1+TDXCIuqikePoFkaA==
X-Received: by 2002:a2e:960a:0:b0:2ec:5467:dcb6 with SMTP id 38308e7fff4ca-2ee8ee0ad5fmr10167491fa.52.1720098156565;
        Thu, 04 Jul 2024 06:02:36 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1dd97bsm23029815e9.15.2024.07.04.06.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 06:02:36 -0700 (PDT)
Message-ID: <574f6d9f-4978-4ec0-9aa1-76817dd70686@gmail.com>
Date: Thu, 4 Jul 2024 15:02:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] drm/radeon: remove load callback & drm_dev_alloc
To: Hoi Pok Wu <wuhoipok@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240630165949.117634-1-wuhoipok@gmail.com>
 <748e1bd6-6c40-443d-acbc-3d379229d068@suse.de>
 <CANyH0kDFSn6voXWnF-91fYufRT=Y3eRBLG66JBXz2_=rxJHXfg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CANyH0kDFSn6voXWnF-91fYufRT=Y3eRBLG66JBXz2_=rxJHXfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 04.07.24 um 06:58 schrieb Hoi Pok Wu:
> Thanks a lot for your help Thomas.
>
> On Wed, Jul 3, 2024 at 4:52 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Hi
>>
>> Am 30.06.24 um 18:59 schrieb Wu Hoi Pok:
>>> .load and drm_dev_alloc are deprecated. These patch series aims to
>>> remove them.
>>>
>>> v3: Both v1 and v2 sucks. v3 improves greatly on readability.
>> Very nice, thank you. I tested the patches with Radeon hardware and did
>> not find issues. AFAICT this can be merged as-is. I think it should go
>> into the amd trees. Maybe Alex or Christian can pick it up.
>>
>> Thanks for sticking with it.

Nice work guys. Skimming over it it looks ok to me, but maybe Alex has 
some more notes.

Regards,
Christian.

>>
>> Best regards
>> Thomas
>>
>>> Wu Hoi Pok (6):
>>>     drm/radeon: change variable name "dev" to "ddev" for consistency
>>>     drm/radeon: remove load callback from kms_driver
>>>     drm/radeon: use variable flags as parameter
>>>     drm/radeon: add helper rdev_to_drm(rdev)
>>>     drm/radeon: change rdev->ddev to rdev_to_drm(rdev)
>>>     drm/radeon: change drm_dev_alloc to devm_drm_dev_alloc
>>>
>>>    drivers/gpu/drm/radeon/atombios_encoders.c |  2 +-
>>>    drivers/gpu/drm/radeon/cik.c               | 14 ++--
>>>    drivers/gpu/drm/radeon/dce6_afmt.c         |  2 +-
>>>    drivers/gpu/drm/radeon/evergreen.c         | 12 ++--
>>>    drivers/gpu/drm/radeon/ni.c                |  2 +-
>>>    drivers/gpu/drm/radeon/r100.c              | 24 +++----
>>>    drivers/gpu/drm/radeon/r300.c              |  6 +-
>>>    drivers/gpu/drm/radeon/r420.c              |  6 +-
>>>    drivers/gpu/drm/radeon/r520.c              |  2 +-
>>>    drivers/gpu/drm/radeon/r600.c              | 12 ++--
>>>    drivers/gpu/drm/radeon/r600_cs.c           |  2 +-
>>>    drivers/gpu/drm/radeon/r600_dpm.c          |  4 +-
>>>    drivers/gpu/drm/radeon/r600_hdmi.c         |  2 +-
>>>    drivers/gpu/drm/radeon/radeon.h            |  7 +-
>>>    drivers/gpu/drm/radeon/radeon_acpi.c       | 10 +--
>>>    drivers/gpu/drm/radeon/radeon_agp.c        |  2 +-
>>>    drivers/gpu/drm/radeon/radeon_atombios.c   |  2 +-
>>>    drivers/gpu/drm/radeon/radeon_audio.c      |  4 +-
>>>    drivers/gpu/drm/radeon/radeon_combios.c    | 12 ++--
>>>    drivers/gpu/drm/radeon/radeon_device.c     | 13 ++--
>>>    drivers/gpu/drm/radeon/radeon_display.c    | 74 +++++++++++-----------
>>>    drivers/gpu/drm/radeon/radeon_drv.c        | 27 +++++---
>>>    drivers/gpu/drm/radeon/radeon_fbdev.c      | 26 ++++----
>>>    drivers/gpu/drm/radeon/radeon_fence.c      |  8 +--
>>>    drivers/gpu/drm/radeon/radeon_gem.c        |  2 +-
>>>    drivers/gpu/drm/radeon/radeon_i2c.c        |  2 +-
>>>    drivers/gpu/drm/radeon/radeon_ib.c         |  2 +-
>>>    drivers/gpu/drm/radeon/radeon_irq_kms.c    | 12 ++--
>>>    drivers/gpu/drm/radeon/radeon_kms.c        |  8 +--
>>>    drivers/gpu/drm/radeon/radeon_object.c     |  2 +-
>>>    drivers/gpu/drm/radeon/radeon_pm.c         | 20 +++---
>>>    drivers/gpu/drm/radeon/radeon_ring.c       |  2 +-
>>>    drivers/gpu/drm/radeon/radeon_ttm.c        |  6 +-
>>>    drivers/gpu/drm/radeon/rs400.c             |  6 +-
>>>    drivers/gpu/drm/radeon/rs600.c             | 14 ++--
>>>    drivers/gpu/drm/radeon/rs690.c             |  2 +-
>>>    drivers/gpu/drm/radeon/rv515.c             |  4 +-
>>>    drivers/gpu/drm/radeon/rv770.c             |  2 +-
>>>    drivers/gpu/drm/radeon/si.c                |  4 +-
>>>    39 files changed, 184 insertions(+), 179 deletions(-)
>>>
>> --
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstrasse 146, 90461 Nuernberg, Germany
>> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
>> HRB 36809 (AG Nuernberg)
>>


