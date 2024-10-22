Return-Path: <linux-kernel+bounces-376698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCC19AB4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97ED1C227D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D651BD4FD;
	Tue, 22 Oct 2024 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPJZO/ov"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319FA1AFB35
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617893; cv=none; b=n6ty8vShsxdy52w0rpznBlDoj97oyQrP4ziEmLMmGT83Bx/WJZZtylWejaA9MQqwKWUx7CJdpKCwOJ7Dmt5UvZe6kxLBotfrgF8axa2mfkji+1gut2V13OJsAIffORh6CwSl4+qAQ/E1yPln3SPa0e1L7IuqkcZgj3giHHnHQo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617893; c=relaxed/simple;
	bh=es6+Mw9dzLvYA2a1vu7aghdYe6SeO3SrhDCgHNS4XrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmgfwRlztj9Vkkv9v2Ue24N4tYm5Cs7R1kC0FxlfUvk6CP3F7N77ShTOGJ5qm58KdhFEhEXUO76UXpoEt5KyyAGZlcDWGjMdxKAMSkYWqZlVlX+cuXd9bPik5T32lMFqbOxm5mK6F55dISyr5fKrex6BgRL48FRMFGtkuY4ef1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPJZO/ov; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso5543019276.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729617891; x=1730222691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sap7+NfOWYfTW34mb/wmOM5teAkuDL1mr85EUNsA8J0=;
        b=BPJZO/ovekQNxM1iQP2++55ZTTrQ9HKZ2zNtFbMC0EEaUK9w8epJAz0jNRqGsYFZ1P
         MzPHMod2Tqlu+dlE5AggUjhyfqfqW7t3b2NHqIsafpzp3iH8RAJbTC2NUFfGvMkM0Ti4
         Y92SHzvOqYbpt3ZI8BZJ5oXR5EFOGkzX+VYGfv7HnjxE8xRZLfwoPOvccA9FZptaT8Qb
         DAB+7TpHA8LuubFjizRg4+BAkN+AySpj5jRTmcAOo5bvRZkcs95LEFSD3eQ5JU89y+of
         8dkwuon13iNpBb01gh6lVWqmh4O9OnQq3i/qZMNZJIMJXc+A+VhJez4sUsJX4R4YBcvn
         knrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617891; x=1730222691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sap7+NfOWYfTW34mb/wmOM5teAkuDL1mr85EUNsA8J0=;
        b=O6GqLrEcGTdohYmn9u0/CMLYcFLpCqMI8+GFMgcTGZHCJ8FraS5zZDBR7sCK9Lb0X8
         FKBOGb4R+T854VPMnSQGADYfABlWcl0F33SAtnHYKXC/zzx2DidBI/4pHz4l/xeJBYbD
         PLsVNTw7wSDFJh+NDgBrj4PsYejJVpLZmbjyzSmzpJTKl50gUWAqIPMgvwsyd6HISFou
         4c4+y/ZDvrSAnnB2/nFpsqxN8dDbPFkBABY0FqmEWnkPFu78BatAVlXeIS2e3SgyUQbw
         53ziQTjDPdqmjPgZgtB6QsXZVKNHsCy62N4ikVV0bRV4ksk8NODLb9OOXKcsLX5jfQws
         AGzg==
X-Forwarded-Encrypted: i=1; AJvYcCUmEzntoMqYms8ZETINOwzNRwrWszJTgULMHDhNt/+XC0+ZAQ989pc7ETDZoYRjKSNVnSYjiW9P4dh/YdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqcyeTPHIpE0aDbjIURNHdKFBUKCmf949LWFGQiXKSMv1bV9Rv
	wBM5xPV0VOmfJqRXLmCJV6tqEY5yUEv1UjkLn9pt5LYEoNW0tt6gpj1lP7YJ9e/ccExNTiz+57C
	G9GbxqNSxIEnZsi5lAV0n/VToe6c=
X-Google-Smtp-Source: AGHT+IEnujnh/bO34CUA1vqx/l8qOyNVwHqJXA15oXi/PevKi+2nXwfi+/snC6zklUQSyWiVhgRqss8U/d/aORznvE0=
X-Received: by 2002:a05:690c:360c:b0:6db:d7c9:c97b with SMTP id
 00721157ae682-6e7d82d4463mr37816737b3.40.1729617891094; Tue, 22 Oct 2024
 10:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022161825.228278-1-olvaffe@gmail.com> <900f8658-726c-4034-90ff-398e6c57ec47@amd.com>
In-Reply-To: <900f8658-726c-4034-90ff-398e6c57ec47@amd.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 22 Oct 2024 10:24:40 -0700
Message-ID: <CAPaKu7QwSq7a-ipSOdETFEBGMu4J4ud1SqxDfPp8bNMjCMM5RQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/syncobj: ensure progress for syncobj queries
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: boris.brezillon@collabora.com, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Chunming Zhou <david1.zhou@amd.com>, Lionel Landwerlin <lionel.g.landwerlin@intel.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	faith.ekstrand@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:53=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 22.10.24 um 18:18 schrieb Chia-I Wu:
> > Userspace might poll a syncobj with the query ioctl.  Call
> > dma_fence_enable_sw_signaling to ensure dma_fence_is_signaled returns
> > true in finite time.
>
> Wait a second, just querying the fence status is absolutely not
> guaranteed to return true in finite time. That is well documented on the
> dma_fence() object.
>
> When you want to poll on signaling from userspace you really need to
> call poll or the wait IOCTL with a zero timeout. That will also return
> immediately but should enable signaling while doing that.
>
> So just querying the status should absolutely *not* enable signaling.
> That's an intentional separation.
I think it depends on what semantics DRM_IOCTL_SYNCOBJ_QUERY should have.

If DRM_IOCTL_SYNCOBJ_QUERY is mainly for vulkan timeline semaphores,
it is a bit heavy if userspace has to do a
DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT before a query.


>
> Regards,
> Christian.
>
> >
> > Fixes: 27b575a9aa2f ("drm/syncobj: add timeline payload query ioctl v6"=
)
> > Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> >
> > ---
> >
> > v2: add Signed-off-by and Fixes tags
> > ---
> >   drivers/gpu/drm/drm_syncobj.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncob=
j.c
> > index 4fcfc0b9b386c..58c5593c897a2 100644
> > --- a/drivers/gpu/drm/drm_syncobj.c
> > +++ b/drivers/gpu/drm/drm_syncobj.c
> > @@ -1689,6 +1689,9 @@ int drm_syncobj_query_ioctl(struct drm_device *de=
v, void *data,
> >                           DRM_SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED) {
> >                               point =3D fence->seqno;
> >                       } else {
> > +                             /* ensure forward progress */
> > +                             dma_fence_enable_sw_signaling(fence);
> > +
> >                               dma_fence_chain_for_each(iter, fence) {
> >                                       if (iter->context !=3D fence->con=
text) {
> >                                               dma_fence_put(iter);
>

