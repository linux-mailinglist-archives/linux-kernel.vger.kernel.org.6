Return-Path: <linux-kernel+bounces-427795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B669E0679
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882C216BDDE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21E820B208;
	Mon,  2 Dec 2024 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1vvMkVv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD81120966B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151286; cv=none; b=pZ2QU7rDqUNICJTu+zG1XV6wzEYVpDK+GP35cIBA8GUZahibkJBbR2Khulk7Nj8yxKj5tkXPqlFa/OsmvcvJ0tahtfj1K7O77VRnlGDTBEXNgt2e9l46GuhgX4fdrB1nfM65LhiZ8+trKuBY/GW8uWXQDAUBI8G0Qu/rGxL8v0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151286; c=relaxed/simple;
	bh=YkotplpWgvyOXrU9knIdvnssVPPUv+zNS5lUYYpij08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPgKW98ajrQugK1ljsPpUE3lXHAAGGe8P1RNEcw28Fuao0cORe5qGkUTH1SNCiIKM+mDwJM0Y6pG7CS7byOykF14h4amzJDSv9HVXiHIYbG6SJ7WS6Zk61aTLvlORhktQmTz3UYGXwOvPHnmdwZiz86VbGkKCYk5QQBlC6eQHEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1vvMkVv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733151283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MetsKcKHKPlrQ9kSF4BsZc6nqtrjJYVyYpKo+i2OZqc=;
	b=A1vvMkVvnG+9/vuW5KUEUG28mNGjoRyxzRiBJZqxpH7Oz6YlKhyEeQLchePe2c+qx+L8Zn
	B9Os6mJiuKLqvkIpQzlxGrF1q2p1v2VMc00iAGBF4VDjswaSIUGRfmGSKzFHrhAuSE6qCt
	2x4zPGV2MrYOqQwV/gXfF5KFhKaQVsc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-ejroUkUhPQ-UjLMU8u4vNg-1; Mon, 02 Dec 2024 09:54:42 -0500
X-MC-Unique: ejroUkUhPQ-UjLMU8u4vNg-1
X-Mimecast-MFC-AGG-ID: ejroUkUhPQ-UjLMU8u4vNg
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d0d322ce63so1480296a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151279; x=1733756079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MetsKcKHKPlrQ9kSF4BsZc6nqtrjJYVyYpKo+i2OZqc=;
        b=LXedtYbOa4ApnC4CAnOSaM72BifO0MU3DfUDrUHLJbFzDuoI1UErhouH/Fimh8AHaM
         uod4HvUky9Z60x65Srlu4raAs7287UNiguCacshuoHkEFnLPFnUgRSjkE9OVPw2R1OlM
         +T2QatXXN3DKrfIjadAz3NB7773o4sWUXVBtbHn2xx4mWrk0f+zr4KzD4pxxrXpFFphz
         zH3Ffqn/wKz2XnK8Zbc/k672Tms4eMomoupzgzo3zzipA9IKw3RNnulp/F8T/GoI9+pB
         +uMl+7yrOR20/3S1dM2/RJV5Wt1A9I2aRpBJMSasqBEcscwlm/AuU6x0fJgMPtPVzmyG
         9hCw==
X-Forwarded-Encrypted: i=1; AJvYcCULNenwJ/YtwWl/8nB5Bj8AEAvIuli+dlIMb2M16s2wVHjJoIj151Jjoxn11rTA769k0uXi2WUTv65ThKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1CeQe0FQ7sSnZPWoVlmNpoOUMK5lKKnbVdPD6LnDd15hPJm7U
	FobwnAcsPwe6vAn48p1EtldAJgEoWI+T+uVTGZCP6U73cVV8h/UKZMnF8TAkA+DA9WP8EMlaA+z
	hQMZGmhjZ8s67XqefQilWlhPUb3iA8q9Rpwp5skShFKqR+1KbWqkKRqDv9SryvgE/cdl+DQ==
X-Gm-Gg: ASbGncs3UoOpc2fO+PD9sDWQDw9TncNm6EV0l7jHop2/8K8Y8Sagtl/wA8+Rgha4fDj
	u+762qCcRMkdU57xrZ3bvEu5KUeBwS7nc5Zcr27WsEefo/ik589PJ30FKYzoSCKZoBJLuPpGAwY
	qsrvQtGq17kSgyVdg2nrt/yv8DpHEbDTwlYv57JWBcuOhOv63jFjrbYa4cISvEMFPheVrdVXsU3
	M+rV4tOlfiTK0M0ii6nZEEzUSSIxYORyysLDc81jm7rS5uBRJ/QJg==
X-Received: by 2002:a17:906:3143:b0:aa5:11fa:626d with SMTP id a640c23a62f3a-aa580ee013dmr2564964966b.3.1733151279429;
        Mon, 02 Dec 2024 06:54:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErVqjQc7dxU3TLbgy9NhmIynnHt4bXAbwnBykBPSLMWV+p8ar+3Kk4B/qStLwDd3H5TbcjSg==
X-Received: by 2002:a17:906:3143:b0:aa5:11fa:626d with SMTP id a640c23a62f3a-aa580ee013dmr2564960266b.3.1733151279019;
        Mon, 02 Dec 2024 06:54:39 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996dc902sm514802966b.50.2024.12.02.06.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:54:38 -0800 (PST)
Message-ID: <f6045267-6398-494e-8058-0d451b84c7c9@redhat.com>
Date: Mon, 2 Dec 2024 15:54:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] media: uvcvideo: Support partial control reads and
 minor changes
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
References: <20241128-uvc-readless-v5-0-cf16ed282af8@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241128-uvc-readless-v5-0-cf16ed282af8@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 28-Nov-24 9:53 PM, Ricardo Ribalda wrote:
> Some cameras do not return all the bytes requested from a control
> if it can fit in less bytes. Eg: returning 0xab instead of 0x00ab.
> Support these devices.
> 
> Also, now that we are at it, improve uvc_query_ctrl() logging.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thank you for the new version, I've replaced the 2 patches in:
https://gitlab.freedesktop.org/linux-media/users/uvc/-/commits/next/

with this new version.

Regards,

Hans

 
> ---
> Changes in v5:
> - Improve comment.
> - Link to v4: https://lore.kernel.org/r/20241120-uvc-readless-v4-0-4672dbef3d46@chromium.org
> 
> Changes in v4:
> - Improve comment.
> - Keep old likely(ret == size)
> - Link to v3: https://lore.kernel.org/r/20241118-uvc-readless-v3-0-d97c1a3084d0@chromium.org
> 
> Changes in v3:
> - Improve documentation.
> - Do not change return sequence.
> - Use dev_ratelimit and dev_warn_once
> - Link to v2: https://lore.kernel.org/r/20241008-uvc-readless-v2-0-04d9d51aee56@chromium.org
> 
> Changes in v2:
> - Rewrite error handling (Thanks Sakari)
> - Discard 2/3. It is not needed after rewriting the error handling.
> - Link to v1: https://lore.kernel.org/r/20241008-uvc-readless-v1-0-042ac4581f44@chromium.org
> 
> ---
> Ricardo Ribalda (2):
>       media: uvcvideo: Support partial control reads
>       media: uvcvideo: Add more logging to uvc_query_ctrl()
> 
>  drivers/media/usb/uvc/uvc_video.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> ---
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> change-id: 20241008-uvc-readless-23f9b8cad0b3
> 
> Best regards,


