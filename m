Return-Path: <linux-kernel+bounces-519477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F529A39D51
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D67168A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B122686B5;
	Tue, 18 Feb 2025 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxVc1ZCY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139F26770D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884882; cv=none; b=q+7qLYPArvlBYFZ2o5rYHdWvaiMZqsz0LOvWTROSQD+xyPpUayZXTaC/GPn+0fgKum1p+/6AFvl00HmG60C/9ABsFJiu/ylUGlrP6nihuhVOY7fPQNQFxm/PgeKR+2yBe4msHYKD5RslEBPKfN3v0yu6zuJw3wnHi2x9BrBfoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884882; c=relaxed/simple;
	bh=rQ/axHZRJRRdmBz4VAmLFXQZe132Qs0TFcbIj6lst7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q8pNJYgVz8TanGoHJqnD1j8edjO2s4NVvNVZoFGTVU2fJijwTUKJgcn/0nGvXNT2L/p8ZoKzmp91wgQC+dYNA1h81poA/wqp2azWxlWKgEscv7dvXVb+0hurZc2iQ4P1bI4ztyKLs2i1MtC7vsKqXQEt5QpoBGfDZiWAKdR64CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxVc1ZCY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739884880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSnXHVdEvvsfyug8OIP2Wl81Rt6heXTzkbKQhrQ+C1Y=;
	b=SxVc1ZCYRlj9LfeVVekDbjgL8PGVXp5dZ68zyFOKwijDIVwz77eBK6fFrnB7vcZ7mlWbj0
	7fTjzGngVpSoFsIIpr+PojUJByydh1liQxjy2pjbkOZeYUjUzZGoxHcAhRFeUzJU/tKfic
	7Tp520cmFdIUDv7JvGGG1bVdmYqc+bA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-DT8uQMI2Ng6_1o5osRy4Yg-1; Tue, 18 Feb 2025 08:21:18 -0500
X-MC-Unique: DT8uQMI2Ng6_1o5osRy4Yg-1
X-Mimecast-MFC-AGG-ID: DT8uQMI2Ng6_1o5osRy4Yg_1739884877
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f36fcf4b3so1986408f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739884877; x=1740489677;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSnXHVdEvvsfyug8OIP2Wl81Rt6heXTzkbKQhrQ+C1Y=;
        b=gC2lnXlWzKYJnBlEiRT6NBISggKWuu7bl5YVbUweFpPlRtMVpUSdWIibtNO3sPmqo2
         TaVX4IR5hoOw+zr93d9scCdvlBDlDqRR4jsHUoAXocSVwDsKSchqNczYmmqMjUKSrvBV
         omzSL2u/qaPcBcQye5AvFptWGsKE3qmcMWiE3U0LaGGgUfwxlGiJ5ooJvA5o3rsyqneG
         SK0suvMXUpGAtPg6lQILHSvAxgYi91vB1mLlvBxM8l8bkjT3odTjTx+iwYduZ4/7AQh0
         Qsl7sd2RTXFJrgltsbdGGAAVTOmTcux1Qf/IScmXn2tqOuLl49AvV4N2YeeaPpFDfwVY
         YehA==
X-Forwarded-Encrypted: i=1; AJvYcCW+pOKIY/b1zjiFf6J+DajQn+fKPFaa6bWgpb1c40+hHTtUoUg1qs77GoVULN7sc+kdahbqTnfZdfMnc/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzIwTz41zKpJ3541lUjxDc95j+ih1poXUD6SMK/nEpip2gFIcp
	y2nxVoJP89/jRMiD6T7lnMJ6fIUyRMfws5EbK1Jgj8ceQiVpZxl+GHGKs9jvzp3F3QJMNli/0Zm
	z+B3w4T21fnhjHV30Kzj85EyaNANuyV6pKXTW2Xz+VUPVjVNw0xP60oz+s7CSBA==
X-Gm-Gg: ASbGncs8m/u3GUwmiwZfnSSPvMj/Tz2bCyKqMt8bbiA2NRTPcfYDO2jk7Z1AhBXvWhn
	rvMtKl8rK6lt7cA1bif1d4KXgopn68GkMFhS62+o5CWw2nPgjd2hyLk5p4Xw0leMdOLXDD3Rh2W
	/DJwg5aGJBUjSxWwIwcgF+fE683FbZeXRbtpC8bitX/MGtyLXKXrpFwUvoE9eZpe6agoO1RSGQZ
	8joO66RCvXNSFtSbB3I9jQiWjrXy78dD/x3YopTIFxEH8FP7C8j5m2dRPyDNakpZ0ZvQ1XRgF6J
	YJtJ07u2Doc35sbTyOYngQaFGT6OFMkWJClCLZlmLRIcWM4s1epqJ3hrFU58uAI=
X-Received: by 2002:a5d:638f:0:b0:38f:2a5e:f169 with SMTP id ffacd0b85a97d-38f33f4e45amr8497510f8f.37.1739884877504;
        Tue, 18 Feb 2025 05:21:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCdb//YXiSCidN9MOxkwBcoVco7O5TeiSbVrPdKZfn6mLHPk77sBotfkp09/v9hBezhruwTA==
X-Received: by 2002:a5d:638f:0:b0:38f:2a5e:f169 with SMTP id ffacd0b85a97d-38f33f4e45amr8497483f8f.37.1739884877159;
        Tue, 18 Feb 2025 05:21:17 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25913eb6sm15124034f8f.51.2025.02.18.05.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:21:16 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drm: bridge: add ssd2825 RGB/DSI bridge support
In-Reply-To: <CAPVz0n1MdCccD5gHK0Z-mMHJ4Erf59_pBSU3+Jenmfr92Fky9g@mail.gmail.com>
References: <20250217140910.108175-1-clamor95@gmail.com>
 <c19bd9b3-86c4-4f1a-beb9-b6aed32b3ef5@suse.de>
 <CAPVz0n0WG1Q51SONb4fmkzi4q7Q0sZ_aKSLrLnGboNNya6nO+Q@mail.gmail.com>
 <871pvvqu0i.fsf@minerva.mail-host-address-is-not-set>
 <CAPVz0n1MdCccD5gHK0Z-mMHJ4Erf59_pBSU3+Jenmfr92Fky9g@mail.gmail.com>
Date: Tue, 18 Feb 2025 14:21:15 +0100
Message-ID: <87y0y3pewk.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Svyatoslav Ryhel <clamor95@gmail.com> writes:

[...]

>> Exactly. Both chips are from the same vendor (Solomon Systech [0]) and my
>> guess is that the SSD prefix means "Solomon Systech Device" or something
>> like that.
>>
>> [0]: https://www.solomon-systech.com
>>
>
> You are correct, vendor is the same, I have not denied that, but the
> this device is not related to product drivers which already exist in
> the Linux Kernel.
>

Oh yes, I didn't mean that are related.

I was just explaining to Thomas why both devices were named "Solomon SSD*"
even when they are quite different and can't be supported by same driver.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


