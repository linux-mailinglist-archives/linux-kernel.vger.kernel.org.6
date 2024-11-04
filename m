Return-Path: <linux-kernel+bounces-395587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4609BC027
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B23B21445
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30171FCC78;
	Mon,  4 Nov 2024 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPBVoXHL"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1481FCF45
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755981; cv=none; b=puvbLnzeN/t/M0sDyizlN5M43reMSdUl2tzFaTzQgevuQwxo1RQ1e55xhWG1TD3h1kdQ7qKI/0UJAoDwmiCuIuH+OZ5ZfF8e33+FNEewIzlPYW2VhtNi5FLsXtNKOT+SOjYGcjsDw4xiTE6+EKwYNqzwalYGleC8O8vQaOKRw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755981; c=relaxed/simple;
	bh=G51JSCuKD4PKRHu8gJvmOUZMwqgmChWv2m2dUspnSH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dn85JJF1p7HT+191NqB/YM14SMQYABz5V5cZv1i+ZxA19JINgLY4blCNXTk0gOPLSN9ujT6cFNk9rpJJ4wU6fclSlFMPMR+bTzDmJ/PJe+xWBcdYlyFBtxVuvZ2CJ+qh1UiQyCAc0bPWy9KuSwTAYkT5ZwSiwDdjAgC3WlGViTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPBVoXHL; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-290ff24354dso2175279fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 13:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730755979; x=1731360779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1UdXh3QGrojvYn/PvZkSJCGhffD6yP8+nq2lAoMAY4=;
        b=FPBVoXHLJh1tD0gj/r3yqwZSl8cMmYs5b8wN7bFmCiKrV724GNesKgPatM8wgqAG2J
         jCcMnKiWSXcLb39jGBs9sa9x7/EswSiCzM6XfEaj3aqfXNIcSMARPhWKlkYEuJwWEyyu
         5nUCBiFbqNABMpB45t+F9YYDv9855k8bVE+j2C4n2gi/aStNPsfndutZOeeG3PQhqhYX
         N9MebshVLoLIL1s094dQ4ECaGZcbbE/Zx6XgsHFTk7aWOgDXXzaIKbtsy/W7Ifvujryz
         ZDvFIMOU5TEmIRDOAUIDl1PbxX/fFZ4u9edtvbOpFH3GolpdnEcpuekgtp17fUDQwReR
         NvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755979; x=1731360779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1UdXh3QGrojvYn/PvZkSJCGhffD6yP8+nq2lAoMAY4=;
        b=dLzeg97hAO2MQuQ0kd3SqwSEV1pW9wK1BGQpBUvUtwg23aZ8eTRKGT6S2JFLqvjx9j
         DQgxV2fZMaI6NNant2GSi2f7YWrJwkwyCAnA4p22bNRayBcnXHY1rHjca5UHb93wF3IR
         TdK8zy2+TDLfCuxJl642JZ0VOc1cGKIbpDntm/TI4q5J40+pQPD4kBPrLVxaSFSTNtz8
         umv91K38CjusBGsuVosFA3ACXLg7PbG2bLA+3r+/0Xgu2PeZsS42YOYi8Fb+O5ZjIuqL
         wFmEIUjt142NMslXo7EeKEBY9Zy35AUEeRRS+9NYc+c1mWxbw0KW7v9v1VAza4wZ7Yx4
         THCg==
X-Forwarded-Encrypted: i=1; AJvYcCVS3/sewmd3QOUPcZB6Bn1fmd8GiFa3XrW33Bxu9EpRtb4+YnhDnWTBqkRI5gDn5SKmjkSCOCCtWZBRyXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpRPHidkO0HZRCUJXR3KTnsQCfEifGhpzq0yk33YU91LXpldQs
	LMOLIc1aeLOlTlRBxUz6CmKraBspaU7PucdjuvJIi5O8IlTCdG35+cjKNv299qj5RR4URX6zQhC
	vgMVtX1DeflP8YcN4P6sRufRIbeg=
X-Google-Smtp-Source: AGHT+IFK3CeAWVIObRVA9l5d+IhjTKCdC4i+suueNNsZrr3AEAGUzBUGQaXAmz9pLenBA2PkfLrnM6NH5LAkwESnAgA=
X-Received: by 2002:a05:6871:50c2:b0:27b:4f51:d73a with SMTP id
 586e51a60fabf-2949ee2f1d0mr11760913fac.21.1730755978600; Mon, 04 Nov 2024
 13:32:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022161825.228278-1-olvaffe@gmail.com> <900f8658-726c-4034-90ff-398e6c57ec47@amd.com>
 <CAPaKu7QwSq7a-ipSOdETFEBGMu4J4ud1SqxDfPp8bNMjCMM5RQ@mail.gmail.com>
In-Reply-To: <CAPaKu7QwSq7a-ipSOdETFEBGMu4J4ud1SqxDfPp8bNMjCMM5RQ@mail.gmail.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Mon, 4 Nov 2024 13:32:47 -0800
Message-ID: <CAPaKu7TB30wvDvMW2FcYNcxjfDkOje358JNnRr2jJf=99-h-rg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/syncobj: ensure progress for syncobj queries
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: boris.brezillon@collabora.com, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Chunming Zhou <david1.zhou@amd.com>, Lionel Landwerlin <lionel.g.landwerlin@intel.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	faith.ekstrand@collabora.com, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:24=E2=80=AFAM Chia-I Wu <olvaffe@gmail.com> wrot=
e:
>
> On Tue, Oct 22, 2024 at 9:53=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > Am 22.10.24 um 18:18 schrieb Chia-I Wu:
> > > Userspace might poll a syncobj with the query ioctl.  Call
> > > dma_fence_enable_sw_signaling to ensure dma_fence_is_signaled returns
> > > true in finite time.
> >
> > Wait a second, just querying the fence status is absolutely not
> > guaranteed to return true in finite time. That is well documented on th=
e
> > dma_fence() object.
> >
> > When you want to poll on signaling from userspace you really need to
> > call poll or the wait IOCTL with a zero timeout. That will also return
> > immediately but should enable signaling while doing that.
> >
> > So just querying the status should absolutely *not* enable signaling.
> > That's an intentional separation.
> I think it depends on what semantics DRM_IOCTL_SYNCOBJ_QUERY should have.
>
> If DRM_IOCTL_SYNCOBJ_QUERY is mainly for vulkan timeline semaphores,
> it is a bit heavy if userspace has to do a
> DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT before a query.

I filed a Mesa issue,
https://gitlab.freedesktop.org/mesa/mesa/-/issues/12094, and Faith
suggested a kernel-side fix as well.  Should we reconsider this?

