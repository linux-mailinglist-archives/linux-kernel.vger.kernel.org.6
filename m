Return-Path: <linux-kernel+bounces-554559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AD7A599E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93277168D06
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D8E22D4D5;
	Mon, 10 Mar 2025 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJ5w/NOM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06B822CBF4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620248; cv=none; b=ZHssaaD72sKyv6fVUWVtyZ92aw905+8WxrN6qi/mrHLBVdIaMS05R5tG7I+JAgqZ6XqyIaJh8WjwI0iMjvPxUW4OkBQVGiTwSbXlbC2+TzaHW0S2yie1AdcBEa+Mqtj/Dpy5rJFLr5cCFQWwOR7CdDiBaxkep0fxhPSywbeZG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620248; c=relaxed/simple;
	bh=32ornFgYDzLX06VXtu/aitU/lwumH5Om/O2eqBU7m44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7AAzKVve/XT9wOsZW52+QEFe3S15yTrY8gqm72JySow5mWQ/OIkF4ELDnb2TiETZ0UJ8ry5SnROMJQRNHvMtbACvPk7/MbRkOkJyDi1hvo6gyGqhrto2l+G+X7CcjGFlXtgg+qvtjTeoJqQovT2P1wO3lrPM8Iwz/EuSRTULjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJ5w/NOM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741620245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/l8k+SbLwqAOBHFF4siM3ptx7x9gmuKHDcMneNXbJ8=;
	b=NJ5w/NOMRpD0G8xNzoA1SFutYzdqnHMOcbdp3ZQdWbdvZwCmWr3ZuMzvbjMhvnJRkkKLoB
	c1RodYLyN8o7vUykaLRCiGx0EJ14bNEGj4TojxFpQlNlBKTMhh8AOAnbTCm1LnZyni5TFR
	VUBdvM357Baw0haNj/H9K1MrFs+NRWI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-7o7wdnd2NnmDnANDLe812g-1; Mon, 10 Mar 2025 11:24:04 -0400
X-MC-Unique: 7o7wdnd2NnmDnANDLe812g-1
X-Mimecast-MFC-AGG-ID: 7o7wdnd2NnmDnANDLe812g_1741620243
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac218738618so306973466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741620243; x=1742225043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/l8k+SbLwqAOBHFF4siM3ptx7x9gmuKHDcMneNXbJ8=;
        b=NzOrUicNB0i/IcrGkckzNjKsRYEzn6Pdbpk7YLOECohYKUV9UTi2z3AN25lyhjvvHy
         AOZJPo/hW4R1k/wYX3heOwiDMh3MyUEX8DmShKmaEtG5Z+xOjaLZoaEgAq0N6u54dUWx
         l3mUffo0Aix8MgKrqwl2XcR1yvypCR4ijBygeVy3ANmUNvelQULTe3y/TrWSBBzKAvyE
         U8Oqbc2ly0UtkafRkp6dnx/VWh+TQH492/ErM/YVHcDp0hu3DpzEISedWxdInC3RNArH
         vEAVqV8lagij6gwsx04hQUSbGyeZU/VxRPZRsSlaG1PM+pWCpyv+hMHG4SEhqTvHNiYW
         QiWg==
X-Forwarded-Encrypted: i=1; AJvYcCVdzi4MjMiRbtHCQDSY8qIIWrpNFDRp73IEh4zjlK8ZBLGKdY6w5bzkMguicE8xPoyZ6Nb1vHgVlBUykKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxJNyRGlZbbggfIJkesiI1bI4cEfI92D/cgQl79znHzZ1QjJem
	tJQP4tD9NHrq/jn5rRBg6wlRacQC8qasrSzHgyEQ0W0mnNegqAkHBwxFS1BuJhKfsINFVaIqdP/
	Cqh+5umfqgoZxsAvcb96+xLq8xp3nnAa+yYvsKkedQnexJB6cCfJzTAi6dWD8Cg==
X-Gm-Gg: ASbGncs2ujeSHs0ZHIfAI0ERdmgJcQbpLmfRU6APshdT+yJXx1qQDN02v7dzaOYzrLI
	rFE46nTSoL1AsKBxFXlApmLzMdLRAxkDRwPBofknKAXssh7g1zbQl0JPYJwNdcJNEgoH2ncws5t
	OsqsKTme9JFif0vMbZvho7tAbSYW6gbkM5PWtbETbxWaMsvwnHRN6Qf5aKCsgL1VV5p3Tr8YvAk
	eShQ7m+D8dFw0/CiKW2MoIiaOdEwTfLC1lSz+HzgyVaovvIghl66sL/rmeH1ArpaZMTt3cUhaCT
	pr/dOfODEsxGoMUgfeI=
X-Received: by 2002:a05:6402:50c9:b0:5dc:80ba:dda1 with SMTP id 4fb4d7f45d1cf-5e5e22bda31mr32394018a12.9.1741620242785;
        Mon, 10 Mar 2025 08:24:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGWJp4OmWENK0TghYc6B4IScukYdvpFNY++I6ScXPdNyaiXupqiZztXxu64W0DqJ0roLTpng==
X-Received: by 2002:a05:6402:50c9:b0:5dc:80ba:dda1 with SMTP id 4fb4d7f45d1cf-5e5e22bda31mr32393964a12.9.1741620242392;
        Mon, 10 Mar 2025 08:24:02 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74aa96bsm7091793a12.48.2025.03.10.08.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 08:24:01 -0700 (PDT)
Message-ID: <cf81d1e8-3378-463f-948b-6c894e73a1b0@redhat.com>
Date: Mon, 10 Mar 2025 16:24:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] media: uvcvideo: Implement Granular Power Saving
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <20250303-uvc-granpower-ng-v5-0-a3dfbe29fe91@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250303-uvc-granpower-ng-v5-0-a3dfbe29fe91@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 3-Mar-25 20:13, Ricardo Ribalda wrote:
> Right now we power-up the device when a user open() the device and we
> power it off when the last user close() the first video node.
> 
> This behaviour affects the power consumption of the device is multiple
> use cases, such as:
> - Polling the privacy gpio
> - udev probing the device
> 
> This patchset introduces a more granular power saving behaviour where
> the camera is only awaken when needed. It is compatible with
> asynchronous controls.
> 
> While developing this patchset, two bugs were found. The patchset has
> been developed so these fixes can be taken independently.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Changes in v5:
> - Improve "media: uvcvideo: Make power management granular" commit
>   message.
> - Link to v4: https://lore.kernel.org/r/20250226-uvc-granpower-ng-v4-0-3ec9be906048@chromium.org

Thank you for the new version.

I've merge the entire series into:
https://gitlab.freedesktop.org/linux-media/users/uvc/ -next now.

Regards,

Hans





> Changes in v4:
> - CodeStyle
> - Create uvc_pm_ functions
> - Link to v3: https://lore.kernel.org/r/20250206-uvc-granpower-ng-v3-0-32d0d7b0c5d8@chromium.org
> 
> Changes in v3:
> - Fix build error on sh4.
> - Link to v2: https://lore.kernel.org/r/20250203-uvc-granpower-ng-v2-0-bef4b55e7b67@chromium.org
> 
> Changes in v2:
> - Add missing semicolon.
> - Rebase on top of media-committers/next
> - Link to v1: https://lore.kernel.org/r/20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org
> 
> ---
> Ricardo Ribalda (5):
>       media: uvcvideo: Keep streaming state in the file handle
>       media: uvcvideo: Create uvc_pm_(get|put) functions
>       media: uvcvideo: Increase/decrease the PM counter per IOCTL
>       media: uvcvideo: Make power management granular
>       media: uvcvideo: Do not turn on the camera for some ioctls
> 
>  drivers/media/usb/uvc/uvc_ctrl.c | 13 +++++-
>  drivers/media/usb/uvc/uvc_v4l2.c | 99 ++++++++++++++++++++++++++++++----------
>  drivers/media/usb/uvc/uvcvideo.h |  6 +++
>  3 files changed, 92 insertions(+), 26 deletions(-)
> ---
> base-commit: d98e9213a768a3cc3a99f5e1abe09ad3baff2104
> change-id: 20241126-uvc-granpower-ng-069185a6d474
> 
> Best regards,


