Return-Path: <linux-kernel+bounces-199683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B20188D8AD3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA532834D7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F4513B28D;
	Mon,  3 Jun 2024 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ibAw2Iff"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94364BAA6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445961; cv=none; b=ULLU+wzKMNC/s5slPrAoiktWPHeXtIVBlFi8tI+eDjA4hh0yhnvYSWBTM1ptFiLO2bdhfCq7qFKS5jSERmGIMVr9n37HiKEzuNrNDwt+0vhMgUbVq3iD3zRXbcsFehBM/bJFQ+nvIZrRDdMX9zzDjuxStKoX+YLAMaEWNFsGLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445961; c=relaxed/simple;
	bh=FSLO+d4F1dv+klupvQtAZTClWMiTIDukqWdU6ZYMums=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=S00FWeIm0OWbSdmBivPD5M6efCFEKAgpatZOiiDr4GwC9eDYXqkYg5MuKSdW+6CwXOOFrd4Deqg0AV6VbF4XEBu2k0G7LAxYNSeyqrL5Q0Cr1m4a1HbLUNu6yZD0wBTNdRyRJECI9cXgJKAXxVbc4ALK+nQBD6fIlPfm770feEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ibAw2Iff; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a033c2e9fso6093700a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717445958; x=1718050758; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE9jYYLZ0PrSccgsEhjOgnrd5/z1uEs9526Bwz64hQs=;
        b=ibAw2IffHcp+i5KrioL5AHBSH+HKiMGO6REuLPXzH9+7RBmtDPWMYNdxaap7TreiEh
         4InBerosOT1DAidnXiaiqJJ7fp+/7DL+djeWN6HBzSFeMepWc3EdqCAZDTzd3jSpbISO
         /xnLc96ISNNgnn1CAeDTHYmP7m2p8Wacg11dFAPD1gQ/ZLmBCaMesqvJqOVqyUCLeJjN
         Y+xy3kfv51ehqEgZcylW2LhCG3uzIWntzdKazbTvJz0bEIh03eNiBsLUOez7boHSJbKt
         UK8nTYUHESJLzDDS6jZJJiIgomD9Y99hZDsQowMf+dzp7HuovUfOZEQHBZROHq7NOoNx
         H5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717445958; x=1718050758;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NE9jYYLZ0PrSccgsEhjOgnrd5/z1uEs9526Bwz64hQs=;
        b=ekSrlFMZllWHiniLzPjp2wR4uueruB0tNUFjeZfBHHuEli6D4L8mjdmoH7HotcsIQI
         5ghmH4Ab1dl1nYm6Q6EXaVL1OuvuvGa5f3cS8AEe1fk/25lsRi+5YUXqgjmS+zNB11kO
         vyKe3Zz0pHWnJF+CIOYLBayvK0KfPPSgK808WhluIyxYnWrqUcsFaD00M0X33iVBqyrI
         ZBiltfvzlf+bV/OjRwTMKVz7KsgQZCtFqUryd+MSv1FAuwb+YNTXbEYp1KSu+QwcmI1X
         UHQT2XwgLY0OzdwVBflJnyiF3MgwEJ9dCmGQqAUoynrQHxiJ8OJ3Iz/defKf7IHiESE/
         WcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJv+huiNWJlnqtfBJs2ZRC8Uvl6tkKV76H4e8s48i7CdkzGB6a6X4gclTA/ELZz5XvflZK0+6CmuX69R+U7rme1JKoTaZezBCfPpLv
X-Gm-Message-State: AOJu0Yw7iWIqhb20bUqaBihKIPJORgaLMZr0mBXmfjwSZQKSPOwiy3/K
	VH+gB3fKkifPcyZTwut5i3JhDkQwyvbcOIzsesy8+BHZV53x9MheQSlD7GmOemzhwRmmNMXVUxi
	jlv8=
X-Google-Smtp-Source: AGHT+IGCGZ7cF+tHbsfD6KOVH6D6GrgBTp1TEU5e+4nXy9DMXeQtp8U//GR6FwSKI00bG8jWZoX3Eg==
X-Received: by 2002:a50:cc9a:0:b0:579:a956:76fd with SMTP id 4fb4d7f45d1cf-57a363eb01dmr8280627a12.8.1717445957901;
        Mon, 03 Jun 2024 13:19:17 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1083:f101:b82c:e1f8:a3c2:1047])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a3173c8c3sm5888800a12.0.2024.06.03.13.19.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2024 13:19:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] drm: Combine identical if/elif code blocks
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <CAB3Z9RJ3RXOMc887N3cJntC1U24HXLkS4jm72xZtcDxNawRN3Q@mail.gmail.com>
Date: Mon, 3 Jun 2024 22:19:05 +0200
Cc: David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6365BD12-0283-4FCA-B84B-95DD6ADB5438@toblux.com>
References: <20240513212836.292589-3-thorsten.blum@toblux.com>
 <CAB3Z9RJ+VVAvVfKWF2LCzH3288vi6CF7uv+g+qbeu_L0c_k0Nw@mail.gmail.com>
 <60613D48-7C93-4B9F-894C-CE70E5F8D123@toblux.com>
 <227C6981-AFFC-4E0E-A95F-BF8979D5AD2A@toblux.com>
 <CAB3Z9RJ3RXOMc887N3cJntC1U24HXLkS4jm72xZtcDxNawRN3Q@mail.gmail.com>
To: Luc Ma <onion0709@gmail.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 16. May 2024, at 03:24, Luc Ma <onion0709@gmail.com> wrote:
> On Wed, 15 May 2024 at 17:31, Thorsten Blum <thorsten.blum@toblux.com> =
wrote:
>> On 15. May 2024, at 11:22, Thorsten Blum <thorsten.blum@toblux.com> =
wrote:
>>> On 15. May 2024, at 09:43, Luc Ma <onion0709@gmail.com> wrote:
>>>> On Tue, 14 May 2024 at 19:37, Thorsten Blum =
<thorsten.blum@toblux.com> wrote:
>>>>>=20
>>>>> Merge the identical if/elif code blocks and remove the following =
two
>>>>> warnings reported by make includecheck:
>>>>>=20
>>>>>     asm/ioctl.h is included more than once
>>>>>     linux/types.h is included more than once
>>>>>=20
>>>>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>>>>> ---
>>>>> include/uapi/drm/drm.h | 8 +-------
>>>>> 1 file changed, 1 insertion(+), 7 deletions(-)
>>>>>=20
>>>>> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
>>>>> index 16122819edfe..315af7b19c97 100644
>>>>> --- a/include/uapi/drm/drm.h
>>>>> +++ b/include/uapi/drm/drm.h
>>>>> @@ -35,13 +35,7 @@
>>>>> #ifndef _DRM_H_
>>>>> #define _DRM_H_
>>>>>=20
>>>>> -#if defined(__KERNEL__)
>>>>> -
>>>>> -#include <linux/types.h>
>>>>> -#include <asm/ioctl.h>
>>>>> -typedef unsigned int drm_handle_t;
>>>>> -
>>>>> -#elif defined(__linux__)
>>>>=20
>>>> I think it is intentionally like that. Please see
>>>> https://patchwork.freedesktop.org/patch/78747/
>>>=20
>>> Thank you for the link.
>>>=20
>>> Does anyone know if the reason for the change from 2016 ("make
>>> headers_install can't handle fancy conditions, ...") is still valid?
>=20
> I guess it is. If you can try ./scripts/unifdef as below[1], you might
> find out the thing.
>=20
> =
[1]https://elixir.bootlin.com/linux/v6.9/source/scripts/headers_install.sh=
#L41

I just tested it with make headers_install and it worked fine.

Thorsten=

