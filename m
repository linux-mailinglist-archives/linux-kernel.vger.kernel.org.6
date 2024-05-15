Return-Path: <linux-kernel+bounces-179705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4678C63B3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC891C22939
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7046458ADB;
	Wed, 15 May 2024 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="tM4U3c0J"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BD558235
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765481; cv=none; b=hdHVYCQweD1uBS6gIVQv0L8FRketYjS28cAI2XqOJp7xvO2uJdgWPrDgT5/7mBrwDdPVLure3NlKdDbsIoBuyp57FMtCOpV9Gry5uY9rVVp8HYeiWMDblOJDFMDhsjPucVmPjg+sRRW0RpDeKCJo1PFFlg8Gfp7SwuhGT16g7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765481; c=relaxed/simple;
	bh=Hzey0cCbkFphYgF1vjC3+uado6EHXgaj7zoOaR/Cr6Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HC00YVlKsE6fhJcvCjrNsI20osiBXm1bn+2Gb5FTkBa1D6Nerd0MDkVl18e/X5emCpdDIAEmiuGhElF4mH2AXdYpkzkupjUXSM88ll6hJ8yyblEfTVnZSHvjCA6vXUJczHRl2cRN9s9yiY8AI631BP5S+23cbLhp0vTu7MzeuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=tM4U3c0J; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42017f8de7aso19932285e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715765478; x=1716370278; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6G3NLZQ7adr3CERsJjkdE8ocBCFRaDGrcowv5jfCJI=;
        b=tM4U3c0JxvGQ7SFj/SFxTA3SSdGTxMRZr/7efww4CJJWT3Yp1xwziIhMlszRN65cS/
         vPM/o3qfJELoc3dRn3Y0EfLYDTE0HNsnsuyv1Ojowsz+r9hL2SYFSX0OO9jxppWjf0Y5
         mnh9KapMUSxsTU1+B2yu3zQIQyNcYkBOXNUrIvKortuTS6gUmkbjMMoVK7vMxN+c0LGM
         xgAqwhZmh/G3wwrWlQ1CHFL6UCY9t/tCTEwjkmYEXrE7WaQfHH2khnNezULElvjQCDc8
         e9vevuTz/eL02K5Hhu7TtNkNSTPFuE7Plcyyu9V84YgqWHS/sI2/zmUk8Rrg9pk2nAJx
         3AbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715765478; x=1716370278;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6G3NLZQ7adr3CERsJjkdE8ocBCFRaDGrcowv5jfCJI=;
        b=IeuU63YbBZRSuDr+bftLe5W+klauT/An7Lkg9X2o7/aUPxy2RbzYKFfyWUnDkf00uf
         WD8cVRoNUw1izyYPeElhVCjH0qfOjGzjiyHGxsXxLK24wBbAHJ31WQd9PpEGhib/xG4s
         b3EbwG1iU5g1MgMSNd/YBkPVz6E52m8D0/nvfbOJKbs/OlKABlW8L0K8tahn1F7vdpu2
         x6NhK4jqMWU7TW899h8ZV8dyxxiLg3uYsTb79APoiSxKudjE2XZ4jbil+sFavjeLhKAn
         bGCK6qSi3KyWozrCgXTl/6dVZh/KqqM8Nhtv7Rxmw7biJ4r+AJV8eDTTL8WTGNl5ZRF6
         H/LQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9PLPRW3LlLij19TfQ/80b3/q6/Os9ZgPcMoisTj4iiqp0aCWmsF5axxoAmSCzDTST4zDI2IbyM474OgmoHNpnpeRK12J1lNhE03Mv
X-Gm-Message-State: AOJu0YwivfanohkwTuAuOGCzqgz8TLaCz9HRHsw0ABgqTPjIfF2sr03g
	vRwCrVP0ex955EYWp3rWTHKUudTcn8yeM15zlpA1QYcwZ0oOXlVENTgz7di8XMD1PZxEzCuRg3X
	4
X-Google-Smtp-Source: AGHT+IEWq6C+Q69fwOKt2Hhmyp59PTVplWyL7OAWiHlAN1uxl4iQWE0fRjH5iltmnd9peTcPahGTlw==
X-Received: by 2002:a05:600c:46d0:b0:41b:d08d:dce4 with SMTP id 5b1f17b1804b1-41feaa2f3c4mr133082205e9.5.1715765478259;
        Wed, 15 May 2024 02:31:18 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:b167:7b8d:34fb:4ec8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42010ca475asm146321755e9.16.2024.05.15.02.31.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2024 02:31:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] drm: Combine identical if/elif code blocks
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <60613D48-7C93-4B9F-894C-CE70E5F8D123@toblux.com>
Date: Wed, 15 May 2024 11:31:06 +0200
Cc: David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <227C6981-AFFC-4E0E-A95F-BF8979D5AD2A@toblux.com>
References: <20240513212836.292589-3-thorsten.blum@toblux.com>
 <CAB3Z9RJ+VVAvVfKWF2LCzH3288vi6CF7uv+g+qbeu_L0c_k0Nw@mail.gmail.com>
 <60613D48-7C93-4B9F-894C-CE70E5F8D123@toblux.com>
To: Luc Ma <onion0709@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 15. May 2024, at 11:22, Thorsten Blum <thorsten.blum@toblux.com> =
wrote:
> On 15. May 2024, at 09:43, Luc Ma <onion0709@gmail.com> wrote:
>> On Tue, 14 May 2024 at 19:37, Thorsten Blum =
<thorsten.blum@toblux.com> wrote:
>>>=20
>>> Merge the identical if/elif code blocks and remove the following two
>>> warnings reported by make includecheck:
>>>=20
>>>      asm/ioctl.h is included more than once
>>>      linux/types.h is included more than once
>>>=20
>>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>>> ---
>>> include/uapi/drm/drm.h | 8 +-------
>>> 1 file changed, 1 insertion(+), 7 deletions(-)
>>>=20
>>> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
>>> index 16122819edfe..315af7b19c97 100644
>>> --- a/include/uapi/drm/drm.h
>>> +++ b/include/uapi/drm/drm.h
>>> @@ -35,13 +35,7 @@
>>> #ifndef _DRM_H_
>>> #define _DRM_H_
>>>=20
>>> -#if defined(__KERNEL__)
>>> -
>>> -#include <linux/types.h>
>>> -#include <asm/ioctl.h>
>>> -typedef unsigned int drm_handle_t;
>>> -
>>> -#elif defined(__linux__)
>>=20
>> I think it is intentionally like that. Please see
>> https://patchwork.freedesktop.org/patch/78747/
>=20
> Thank you for the link.
>=20
> Does anyone know if the reason for the change from 2016 ("make
> headers_install can't handle fancy conditions, ...") is still valid?
>=20
> Other headers use the same #if directive:
>=20
> fs/ext4/ext4.h:948:#if defined(__KERNEL__) || defined(__linux__)
> include/uapi/sound/asound.h:11:#if defined(__KERNEL__) || =
defined(__linux__)
>=20
> And there are many others using similar conditions:
>=20
> arch/arm/include/uapi/asm/swab.h:27:#if !defined(__KERNEL__) || =
__LINUX_ARM_ARCH__ < 6
> arch/sparc/include/uapi/asm/signal.h:92:#if defined(__KERNEL__) || =
defined(__WANT_POSIX1B_SIGNALS__)
> arch/sparc/include/uapi/asm/termios.h:8:#if defined(__KERNEL__) || =
defined(__DEFINE_BSD_TERMIOS)
> include/uapi/linux/soundcard.h:1040:#if !defined(__KERNEL__) || =
defined(USE_SEQ_MACROS)
> include/uapi/linux/stat.h:7:#if defined(__KERNEL__) || =
!defined(__GLIBC__) || (__GLIBC__ < 2)
> include/uapi/sound/asound.h:11:#if defined(__KERNEL__) || =
defined(__linux__)
> ...
>=20
> Thanks,
> Thorsten

Re-sending this to linux-kernel@vger.kernel.org because the mailing list
somehow got lost in Luc's reply.=

