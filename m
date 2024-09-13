Return-Path: <linux-kernel+bounces-327693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCF9779CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC032892ED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0EE1BC090;
	Fri, 13 Sep 2024 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMuyapwK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D107777107
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726213102; cv=none; b=B3xjPylumGOW+iPxnWGOSKtA4xDZLr9CU1LFSgcTQT3lqi1MPeEEheUKDlrP+k6ZYbsOz5AEollS/spF4i5evFN/sWGNwq7VYuuV+r63RBH0XxC8Uu406Kbd2hnByHZ+8EceDBl1tiKUoItbWmaxyRKeUYoHvQBo9NzPMO896z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726213102; c=relaxed/simple;
	bh=Avl4iry6mR0AB1YY7uHRw42ef7yROe7C/fBOKfnsI2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iv2CzE5894LqkDDb1LYCxUIKgzowRIJiS3AQk7CBz5KOB8rO7/D+jEn2MqgwaaRt+WM0nIumnACo1Ys+8Fge+ccDax0fBaWtVQvc5/XDlqiBjBiUXnsWWwpK/kj5OJNEpi3+aT4bFL7RPTJx1dWlqJcfKRVP0xRdf/y22yAZEOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMuyapwK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726213099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Avl4iry6mR0AB1YY7uHRw42ef7yROe7C/fBOKfnsI2s=;
	b=OMuyapwK5q6IOc3mRQT1tLhr3iq7aMp6QBS4gEIn7govJRJJTRx0W7p96qoDDD0TR98hlp
	6J8zBwYRKgIE0rbyq7UvFJRkx+0DSoZ95F0m37e59krMPMrTziYnqSa/z0L88cD3Ag6kgn
	3IcmzrEnupXSU8d+Ad2LHCWNkQKyS5E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-YELBMcFxMk22lccDXnzvDg-1; Fri, 13 Sep 2024 03:38:18 -0400
X-MC-Unique: YELBMcFxMk22lccDXnzvDg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3750b4feb9fso882304f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 00:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726213097; x=1726817897;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Avl4iry6mR0AB1YY7uHRw42ef7yROe7C/fBOKfnsI2s=;
        b=EmUaLsDMRiDloEC2jy38HTVyNgVDxd5bnH31FLYsc4qL7D6DeTzXYDa73ZqRe9ryxL
         qpXf/yqwCluabIrCaBJ8SYgd0C8Ruc8kKKkepbD2pGC5lIbacvd9SvGvK2qy2hsmyqBh
         buepObyXwW5ZM/CQ1oONlKJ2VFXF3xW1vwGUYwtcv4sekKEsON2OSp66ND8363zhcT6C
         YfJ4rtH8S6tLULgmtMehuW+MSiqW70mgZHgdjLpv/O+N9SO1JAwLIHVyLNbhydOJXFP0
         bbwaG7Wc2p0AOkOOKUruMgNbQIEL1s9VhzB9HYOnNc1kwebmn/otz60fPe87Y8MgrXAq
         7kcA==
X-Forwarded-Encrypted: i=1; AJvYcCUwqqKNY5dpM3i+rud+HeGxxXhMBscX77XydE+Sovl7LJl9aPlMi+MkZSD417OXeJUqBvOqnZB35p5ErsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLM2iFKK2ItZFr3YWzjtyZAFeWWZX3CsK8IPp6f7ZBaZg0x6Le
	CLGB167vKOFjXEmfZKOG78qOGItjG72ijSL9naYcRRc3OOKVL0LDp268L/hokYIwjxdwbQp8t5q
	J51fqSNfXOpg6dIy5+UX9C04z08gfPUaZox05UGTIWVvao3Vq20H38od7OGxNEA==
X-Received: by 2002:a5d:4575:0:b0:374:cb8e:4b43 with SMTP id ffacd0b85a97d-378c2810ca9mr2670651f8f.32.1726213096923;
        Fri, 13 Sep 2024 00:38:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwvEaryqUUG8XQkoN2seMqJGO6so+gHVrF76d6zn7a0hT0g5VoWxTmfEzo3MdgpuhPsRUXQQ==
X-Received: by 2002:a5d:4575:0:b0:374:cb8e:4b43 with SMTP id ffacd0b85a97d-378c2810ca9mr2670632f8f.32.1726213096336;
        Fri, 13 Sep 2024 00:38:16 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a279sm16180955f8f.9.2024.09.13.00.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 00:38:16 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Danilo
 Krummrich
 <dakr@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, jyri.sarha@iki.fi,
 tomi.valkeinen@ideasonboard.com, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, praneeth@ti.com, nm@ti.com, vigneshr@ti.com,
 r-ravikumar@ti.com, j-choudhary@ti.com, grandmaster@al2klimov.de,
 caihuoqing@baidu.com, ahalaney@redhat.com, cai.huoqing@linux.dev,
 colin.i.king@gmail.com, dmitry.baryshkov@linaro.org,
 geert+renesas@glider.be, laurent.pinchart@ideasonboard.com,
 robh@kernel.org, sam@ravnborg.org, simona.vetter@ffwll.ch,
 ville.syrjala@linux.intel.com, wangxiaojun11@huawei.com,
 yuanjilin@cdjrlc.com, yuehaibing@huawei.com
Subject: Re: [PATCH] drm/tidss: Add MIT license along with GPL-2.0
In-Reply-To: <3y4pqlazkuofc37s6zlw7waqzmtdl5iydhm4i3i45n6d6pnflc@osyocv7wxtif>
References: <20240912171142.3241719-1-devarsht@ti.com>
 <c501c5d3-d715-4ac5-98be-35d23ad1cfbe@kernel.org>
 <3y4pqlazkuofc37s6zlw7waqzmtdl5iydhm4i3i45n6d6pnflc@osyocv7wxtif>
Date: Fri, 13 Sep 2024 09:38:14 +0200
Message-ID: <87ed5oypeh.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> writes:

> Hello,
>
> On Thu, Sep 12, 2024 at 10:47:31PM +0200, Danilo Krummrich wrote:
>> On 9/12/24 7:11 PM, Devarsh Thakkar wrote:
>> > Modify license to include dual licensing as GPL-2.0-only OR MIT licens=
e for
>> > tidss display driver. This allows other operating system ecosystems su=
ch as
>> > Zephyr and also the commercial firmwares to refer and derive code from=
 this
>> > display driver in a more permissive manner.
>> >=20
>> > Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>>=20
>> My only contribution to this driver was through DRM refactorings,
>> but anyways:
>>=20
>> Acked-by: Danilo Krummrich <dakr@kernel.org>
>
> Similar for me. I only touched one of the affected files with a
> refactoring change (34cdd1f691ade28abd36ce3cab8f9d442f43bf3f). I don't
> assume this gives me any copyright to that driver, but to simplify
> things:
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>

Similar for me too. My only change to this driver I think was to add DRM
panic support in commit b2cb6011bcaf ("drm/tidss: Add drm_panic support").

But I'm also OK with the change, so:

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


