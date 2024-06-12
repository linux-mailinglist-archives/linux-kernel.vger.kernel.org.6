Return-Path: <linux-kernel+bounces-211859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA15905825
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96199B2A67A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC081822F3;
	Wed, 12 Jun 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mFzgbPps"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B01822CE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208050; cv=none; b=Ta946SCvWmfz/0BevVuViWUE95c0Ohh6sL/YV3qHRvJU5ltdz6LMk9dgmmAe2pSanA79qwa/cdd30a0Nr4oJg1qZdhAhcUaibr3xA8dQw0hTXnup2j5xibruaOvgO2T5OXF9r/DDmIsIS3d69ok5+FZ42A5lpjAwC+YE5W88NFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208050; c=relaxed/simple;
	bh=uZINL17H+hC2HjFcR8qtul7lujxSNFTkCsIl7pDQAU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhKW6mNSavHw3HTpJf2koiOsRJnC7klFcPTXnSIA+MVrDO77zufW487xamXcaFoWLe32Rsq7CS9VOaovb2gQvlv0KUUF+j46581/1vChcillm6tulQRWxHqHeOavuw8luRWAaFU5XUFF3Cq9cdLJHGogFFKhT40jkJU0WjAZ6Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mFzgbPps; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-440530cadc7so14046511cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718208046; x=1718812846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZINL17H+hC2HjFcR8qtul7lujxSNFTkCsIl7pDQAU0=;
        b=mFzgbPpsX7z4PsmJGgaIQNgF9ljioAnqrrp8jPH/LsoDvB9TfIIr0MVw4YHKB+86rH
         4jf5BIVqM+JZG6pGYOzE5ukHKPvMW6OgLTqmCuL0lqiOD84+SOc6X9ymSRbDku6VIv5E
         a7br/yF9+ec30m+aiUv3OfuqzxnyohJLdyN2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208046; x=1718812846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZINL17H+hC2HjFcR8qtul7lujxSNFTkCsIl7pDQAU0=;
        b=eceqdvppYriqPAhFDZtSPWSgEvjPdFPvDrutIZ/REDCX8IfQw3QCUBIV2zNgEqBKMo
         RvI7/fwNEnxetf8GTJVXGOEu4guJaCume0QMk8YPFxSyKLvxmRYZBSo24wip/SFTuEYW
         wtDgXUTorS+jkrtt5g4Qm24CvlMT8Ia0dJB04blnDhZ6/Dchi4FyAU2nu9BD2Qv5it4Z
         gbe01L3OXFN402luvWiXVeUI5AoeASrqBciNxSnh9N9ByfNg2GStRYOsS1t4BEnBAeBL
         3le8NQhJCLZY9q/UY24XJ2s0N0mT7e6CmK54n+/NoFp2T9UCGFe2fcPdbsYS4+4susAT
         6lfg==
X-Forwarded-Encrypted: i=1; AJvYcCWGXiH8ltPTEnV+S4s2Tr6IpEMpX/DzHDbSXsrEicCL6urnfB3YSdzPCpr/xk8npCkph472rkPyt66EjVibI3yYVosFcnovsr6ShuTP
X-Gm-Message-State: AOJu0Yxy3dSjfRdqwRXYmRjNooEi7ZfO6sQlQar3e7DdJ3Tb7aARW8C6
	FjWtboXpvjciAU/jGY3syvHbRi13VNuApWo2ZP14JnEV/GDAcQKfCTv/JwDdXBw6aVOu2ddTe8k
	=
X-Google-Smtp-Source: AGHT+IGsWnzQsti0Ko5BpsqQPRCodxNDUt4VOY5Qb/ma3/9J0AlE1aQRsBQYO10f1QG87NkZQ9PpCg==
X-Received: by 2002:a05:6214:2b8d:b0:6b0:9250:1ced with SMTP id 6a1803df08f44-6b1a6587a59mr23012386d6.34.1718208046262;
        Wed, 12 Jun 2024 09:00:46 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b07ab2b936sm34894146d6.36.2024.06.12.09.00.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:00:44 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4405dffca81so190741cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:00:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUP51VaV4cACUGshSjgPDWS1BM2lkaCyDFZ8pqIVc/QXSPuMts2dQiriTFwbzIVCix+7PP0BWUkuYy7RAnkTnZwCo6AwaNVv+X9KFd2
X-Received: by 2002:a05:622a:1dca:b0:43e:3833:c5e3 with SMTP id
 d75a77b69052e-44159e10eabmr2381201cf.11.1718208042474; Wed, 12 Jun 2024
 09:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <ZmljNHteJ9L5EdE9@phenom.ffwll.local> <CAD=FV=V4C1AYVqG4gig+SiQr4n_mAPVASxneDDZT1a=7AY3Hzw@mail.gmail.com>
 <Zmm6i6iQOdP613w3@phenom.ffwll.local>
In-Reply-To: <Zmm6i6iQOdP613w3@phenom.ffwll.local>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Jun 2024 09:00:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WBVfBZrgGay=XY2Usq3FA3m9i6y0cU4=b=w7qO6gRBFQ@mail.gmail.com>
Message-ID: <CAD=FV=WBVfBZrgGay=XY2Usq3FA3m9i6y0cU4=b=w7qO6gRBFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at shutdown
To: Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Chris Morgan <macromorgan@hotmail.com>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org
Cc: Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2024 at 8:11=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wro=
te:
>
> > The problem is that the ordering is wrong, I think. Even if the OS was
> > calling driver shutdown functions in the perfect order (which I'm not
> > convinced about since panels aren't always child "struct device"s of
> > the DRM device), the OS should be calling panel shutdown _before_
> > shutting down the DRM device. That means that with your suggestion:
> >
> > 1. Shutdown starts and panel is on.
> >
> > 2. OS calls panel shutdown call, which prints warnings because panel
> > is still on.
> >
> > 3. OS calls DRM driver shutdown call, which prints warnings because
> > someone else turned the panel off.
>
> Uh, that's a _much_ more fundamental issue.
>
> The fix for that is telling the driver core about this dependency with
> device_link_add. Unfortuantely, despite years of me trying to push for
> this, drm_bridge and drm_panel still don't automatically add these,
> because the situation is a really complex mess.
>
> Probably need to read dri-devel archives for all the past attempts around
> device_link_add.
>
> But the solution is definitely not to have a manually tracked list, what'=
s
> very architectural unsound way to tackle this problem.
>
> > Certainly if I goofed and the above is wrong then let me know--I did
> > my experiments on this many months ago and didn't try repeating them
> > again now.
>
> Oh the issue is very real and known since years. It also wreaks module
> unload and driver unbinding, since currently nothing makes sure your
> drm_panel lives longer than your drm_device.

In this case I'm mostly worried about the device "shutdown" call, so
it's not quite a lifetime issue but it is definitely related.

As per my reply to Maxime, though, I'd expect that if all ordering
issues were fixed and things were perfect then we'd still have a
problem. Specifically it would seem pretty wrong to me to say that the
panel is the "parent" of the DRM device, right? So if the panel is the
"child" of the DRM device that means it'll get shutdown first and that
means that the panel's shutdown call cannot be used to tell whether
the DRM device's shutdown call behaved properly.


> > In any case, the only way I could figure out around this was some sort
> > of list. As mentioned in the commit message, it's super ugly and
> > intended to be temporary. Once we solve all the current in-tree
> > drivers, I'd imagine that long term for new DRM drivers this kind of
> > thing would be discovered during bringup of new boards. Usually during
> > bringup of new boards EEs measure timing signals and complain if
> > they're not right. If some EE cared and said we weren't disabling the
> > panel correctly at shutdown time then we'd know there was a problem.
>
> You've stepped into an entire hornets nest with this device dependency
> issue unfortunately, I'm afraid :-/

As you've said, you've been working on this problem for years. Solving
the device link problem doesn't help me, but even if it did it's
really not fundamental to the problem here. The only need is to get a
warning printed out so we know for sure which DRM drivers need to be
updated before deleting the old crufty code. Blocking that on a
difficult / years-long struggle might not be the best.

That all being said, I'm also totally OK with any of the following:

1. Dropping my patch and just accepting that we will have warnings
printed out for all DRM drivers that do things correctly and have no
warnings for broken DRM drivers.

2. Someone else posting / landing a patch to remove the hacky "disable
/ unprepare" for panel-simple and panel-edp and asserting that they
don't care if they break any DRM drivers that are still broken. I
don't want to be involved in authoring or landing this patch, but I
won't scream loudly if others want to do it.

3. Someone else taking over trying to solve this problem.

...mostly this work is janitorial and I'm trying to help move the DRM
framework forward and get rid of cruft, so if it's going to cause too
much conflict I'm fine just stepping back.

-Doug

