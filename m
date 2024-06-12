Return-Path: <linux-kernel+bounces-211102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5449E904D21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7FF2826ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F40F16C445;
	Wed, 12 Jun 2024 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQn8E3Kd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF53169ACF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178598; cv=none; b=H8j4qP8t8eoViqi066IQFThLemTw/O1W/m2PsPaQ9SCn/WIgbrswEp+bnEUUjp0VGr9bAs6uOjiWLPSU8gqlKKamxHu3nCne/5qTBZGz0XpINOzK+75ANvR3Aqbw6BzgU7EkhL773geug8xzvJbzb0DwD8Ydhwp9X4TDXJenYv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178598; c=relaxed/simple;
	bh=ZKxDuZ9ntXNIIPhfkdeYI6FLW7SiBSvG27NW9i1F67Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MxpN5zkwl+IYN+0YNwLKndZdC++obBcPGMDyKj5ZvMOAkRqokej/m/dIs0tp/Pxc3GoF6REMC0D1VtijctJRQxuTyeGGZByLG+bc1rtIcpRlAtKBzgks0qQuoUTaP9m2WoY6MAamps6Ry1CZAZI9HulcmWANC4ri3biy4QLbofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQn8E3Kd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718178596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKxDuZ9ntXNIIPhfkdeYI6FLW7SiBSvG27NW9i1F67Y=;
	b=XQn8E3KdJBeOYJ9kHY2AEePK8mNRgesMFEVadFHbJHqTui7vMo6/cqhChki4pKcDZcPJn9
	GABO6ACaJpM9f+r8S5/5xKDeehWhw/JZpCl/xNaWsFnfLHPA+qoKPvdF5FLhPe3laO7tPe
	IPWyCxHPgHubVpMzuffTfyPzICDundY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-anevUC_6P5iwc--zCeOAhQ-1; Wed, 12 Jun 2024 03:49:49 -0400
X-MC-Unique: anevUC_6P5iwc--zCeOAhQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f15fae680so1345249f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718178588; x=1718783388;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKxDuZ9ntXNIIPhfkdeYI6FLW7SiBSvG27NW9i1F67Y=;
        b=VMsFXp+PeDPyodOZjcVit2Mpc8miya2QrhYIe+AJIg8NUSyT/O2K2yDch1dHP6sey0
         oYdwJWo4UbZv3H/G8hY+vajV1gUWbvZrh7iAn61eHka/ynPYIVq5PB2hhYtdoB2plVML
         cKfcFSjeZB6nVPG3FWeE1ysE+qJELcZEwj8mU+qD21r5pa/LmaQMb9U91PCrMYV6PbPS
         X0FLI6eTJdPFHakNKgBVzqdc9js4Nl4iTJbOQpfMOnD59IjjZkFVXQAp+av+YBzyMpza
         0jsDnvqwHrgcw+1fYpoQwEItlIj6i1aK9QPX1lo5kZEUFg9NRlIuccmDdinOXEpj9xbL
         Gppw==
X-Forwarded-Encrypted: i=1; AJvYcCXOBJtnIwqkEUUdL5n02fHJuGl2wbHu6sumzOSgvbyPl/+j6Y+TkVcBH6JC+s+/mZp9cVgSiGg64jy+jcO/50JbCkko+yylLEappFsj
X-Gm-Message-State: AOJu0YxP3Au0ixxPqOQy5yG+hNeACfHapxnoXb4AYq5VHv+O5fvbxDtK
	CN3vMQLadga0sGSv3DdDs2aJw/Udg7hFGlIkUwa4mN1U1Xhkzagsysx/O/SyFQF2K68sAcwj8GA
	WvYn6NFKwLZY/S64yRNm3Ndu7K5rtTCQldBsPcSRdwM5KLEEaVp8SCWHA8m6zYA==
X-Received: by 2002:adf:a3cc:0:b0:35f:1c27:4520 with SMTP id ffacd0b85a97d-35fe8940368mr611470f8f.70.1718178588373;
        Wed, 12 Jun 2024 00:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKAPKA3NydN1HfhRMshyH4ixhOfCaN6U5l2ihyWJ97s/Qvnara/m2quSOqhTxCgY3IobtRMg==
X-Received: by 2002:adf:a3cc:0:b0:35f:1c27:4520 with SMTP id ffacd0b85a97d-35fe8940368mr611451f8f.70.1718178587927;
        Wed, 12 Jun 2024 00:49:47 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f228cbfb8sm8065167f8f.57.2024.06.12.00.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:49:47 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Peng Fan <peng.fan@nxp.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/fbdev-dma: fix getting smem_start
In-Reply-To: <e307fdc0-553d-4946-9017-ed3a28e9cae2@suse.de>
References: <20240604080328.4024838-1-peng.fan@oss.nxp.com>
 <8f4a6d80-dd3e-422f-88af-d26f50c973ff@suse.de>
 <e307fdc0-553d-4946-9017-ed3a28e9cae2@suse.de>
Date: Wed, 12 Jun 2024 09:49:46 +0200
Message-ID: <87cyomsiqt.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Hi
>
> Am 10.06.24 um 10:47 schrieb Thomas Zimmermann:
>> Hi
>>
>> Am 04.06.24 um 10:03 schrieb Peng Fan (OSS):
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> If 'info->screen_buffer' locates in vmalloc address space, virt_to_page
>>> will not be able to get correct results. With CONFIG_DEBUG_VM and
>>> CONFIG_DEBUG_VIRTUAL enabled on ARM64, there is dump below:
>>
>> Which graphics driver triggers this bug?
>>
>>> [=C2=A0=C2=A0=C2=A0 3.536043] ------------[ cut here ]------------
>>> [=C2=A0=C2=A0=C2=A0 3.540716] virt_to_phys used for non-linear address:=
=20
>>> 000000007fc4f540 (0xffff800086001000)
>>> [=C2=A0=C2=A0=C2=A0 3.552628] WARNING: CPU: 4 PID: 61 at arch/arm64/mm/=
physaddr.c:12=20
>>> __virt_to_phys+0x68/0x98
>>> [=C2=A0=C2=A0=C2=A0 3.565455] Modules linked in:
>>> [=C2=A0=C2=A0=C2=A0 3.568525] CPU: 4 PID: 61 Comm: kworker/u12:5 Not ta=
inted=20
>>> 6.6.23-06226-g4986cc3e1b75-dirty #250
>>> [=C2=A0=C2=A0=C2=A0 3.577310] Hardware name: NXP i.MX95 19X19 board (DT)
>>> [=C2=A0=C2=A0=C2=A0 3.582452] Workqueue: events_unbound deferred_probe_=
work_func
>>> [=C2=A0=C2=A0=C2=A0 3.588291] pstate: 60400009 (nZCv daif +PAN -UAO -TC=
O -DIT -SSBS=20
>>> BTYPE=3D--)
>>> [=C2=A0=C2=A0=C2=A0 3.595233] pc : __virt_to_phys+0x68/0x98
>>> [=C2=A0=C2=A0=C2=A0 3.599246] lr : __virt_to_phys+0x68/0x98
>>> [=C2=A0=C2=A0=C2=A0 3.603276] sp : ffff800083603990
>>> [=C2=A0=C2=A0=C2=A0 3.677939] Call trace:
>>> [=C2=A0=C2=A0=C2=A0 3.680393]=C2=A0 __virt_to_phys+0x68/0x98
>>> [=C2=A0=C2=A0=C2=A0 3.684067]=C2=A0 drm_fbdev_dma_helper_fb_probe+0x138=
/0x238
>>> [=C2=A0=C2=A0=C2=A0 3.689214] __drm_fb_helper_initial_config_and_unlock=
+0x2b0/0x4c0
>>> [=C2=A0=C2=A0=C2=A0 3.695385]=C2=A0 drm_fb_helper_initial_config+0x4c/0=
x68
>>> [=C2=A0=C2=A0=C2=A0 3.700264]=C2=A0 drm_fbdev_dma_client_hotplug+0x8c/0=
xe0
>>> [=C2=A0=C2=A0=C2=A0 3.705161]=C2=A0 drm_client_register+0x60/0xb0
>>> [=C2=A0=C2=A0=C2=A0 3.709269]=C2=A0 drm_fbdev_dma_setup+0x94/0x148
>>>
>>> So add a check 'is_vmalloc_addr'.
>>>
>>> Fixes: b79fe9abd58b ("drm/fbdev-dma: Implement fbdev emulation for=20
>>> GEM DMA helpers")
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> I'm taking back my r-b. The memory is expected to by be physically=20
> contiguous and vmalloc() won't guarantee that.
>

Agreed.

> Best regards
> Thomas
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


