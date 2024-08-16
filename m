Return-Path: <linux-kernel+bounces-290276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D259551AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E037E1F22C86
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E2E1C4609;
	Fri, 16 Aug 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eZ3KXRc2"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4241BE861
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723838150; cv=none; b=fe9YSUWIxoPLyIXqmZjopSTZ7S3hT8KQ9g0riJIe0q+VETXl710blnnLFGJ3baRmECLyaxQP/InT8oYeEmIPKdWr+Ta+cVBEiYlJ0Fpq3n2Q7Naguj48LmO454mWTVBr2N2Dnzlf5CwWD27QfvDDUzf3mH7a10inXwiFz7oaNa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723838150; c=relaxed/simple;
	bh=MGWxg1wOx8lJ4g1VL18IcZyVgXvmEtS03cqmIV5LuWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edea6sOigPM3sLJNLYTSTG5VbYf3eli/Oo4510lhzXu4gDnLjojDZWQ+vYhTwO6AjppaMA/2o6L3p2HEJaDxQ0NInbIbUKbFcryVcywK7oIy1knLllkz6dgTRIBWxi/f74JrjRxzvjNww7oadFLWFCjX22ZK43qpxKhHDs+ND2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=eZ3KXRc2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201d5af11a4so23252355ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1723838148; x=1724442948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGWxg1wOx8lJ4g1VL18IcZyVgXvmEtS03cqmIV5LuWw=;
        b=eZ3KXRc2R8vF+xvrudG7BJ0xUbYUxmjbre6ZCaVvMvxZZrulwxZVqNYInQoeSL/qvG
         soaAjNoSlMqv+zv/ljDE61XWZB73Flvo8zJDvgBUp0G8ssVvupODi4/vmqxLqYr9tI1X
         SE9T+N1RWaWyxYNosAsoBawxMM29Mwte5Kyh8VIa2SrGiCyFObWOMdFbbKQaq/rcsHap
         MoD7TR/O3Z1L5O2OnBEkUb0/q0sNFSI9kVBIbFI23kcYwkejSOh3EGpC6muhXkNW9ls4
         6NoLpI+vNoB1oBVMe+wtF4SpV1G+Q1RdCGRb9FmnygOluCDWImu+pi7IKyz3d/AyZ4Hy
         Wa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723838148; x=1724442948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGWxg1wOx8lJ4g1VL18IcZyVgXvmEtS03cqmIV5LuWw=;
        b=CWo6P4Lol1+ufYXUWOk2MBV63s4PnPTfFD4VfgCU3Ut/4XlI30oLg6mVSaHCetSpWc
         vdVQFnx1wP3cQ5umbaMGl+6SFItXEI0CQnJnndkXuOKUh9VGnP9EUPWbV0UBMJXG1Xu5
         Y9bQqUACEfjDMR96HvXYsJmSJ0p/IfMlx9g5k3GtBINePSLQoI2eoUjtJU9dA8HFLQiB
         yLsCCHQlRdi8G8ef76HwK5wzynLDZw2RwHIbI5ipiT5NaXyVI9HmkbxhwyGAeMtK0VG9
         HSYiwrsddINOYfhAM8gv3OT5RseH1sypSRj1Kw6xw6TEZU0Ikg0wek95B5ndB73gYWyb
         7rlw==
X-Forwarded-Encrypted: i=1; AJvYcCWca4+mY+pxPBsFUuSKkC6+Mu+KagHAyCnH6gYvykPWWv0G/KWXuyuRywxqDl5U2Gnyq0rkqiboL4VJwpffd71dDx/j+3lOUlYt8Ayp
X-Gm-Message-State: AOJu0Yzjv7L0JzL96ISJdUEs7jqwHeAzzMyTd8PKFxIt4FWt7KZLyrKX
	AfYdrD8a+ALJ0KBrku/YM2kUETv26047+onHX/ELXfJ7L1/Z+Qwe8gKyTgUc4rJzJ0gveiSTpgk
	6A+VIUEJ3/v9BL7Aoq5Njm1TAh54=
X-Google-Smtp-Source: AGHT+IGH6vqIACm8gz7WSIiK1hLIMfs+2kbloGFsHHYX1GswdRuWB0AyXiwovzGrueJUPrhdZoQKawfIyTwS/JlzZ5M=
X-Received: by 2002:a17:902:ce91:b0:1fd:9e6e:7c1f with SMTP id
 d9443c01a7336-20203f514a7mr51522695ad.56.1723838147914; Fri, 16 Aug 2024
 12:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809124725.17956-1-abelova@astralinux.ru> <CAFBinCATiUnR=P9VRBxWeQhf49k6PVxK+nU95G7w94f-mR2HWQ@mail.gmail.com>
 <bb45ed80-7871-47ba-a1fd-ee71dc21a409@astralinux.ru>
In-Reply-To: <bb45ed80-7871-47ba-a1fd-ee71dc21a409@astralinux.ru>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 16 Aug 2024 21:55:37 +0200
Message-ID: <CAFBinCCW6E46+cMUC0M+n_4d7A6AhoJkQT=EHBxOD5wjn9O1hw@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: add check to prevent dereference of NULL
To: Anastasia Belova <abelova@astralinux.ru>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Anastasia,

On Mon, Aug 12, 2024 at 11:32=E2=80=AFAM Anastasia Belova <abelova@astralin=
ux.ru> wrote:
[...]
> > As an alternative to your suggested approach: could you please look
> > into whether devm_drm_dev_alloc() is a suitable replacement (if not:
> > just explain why - then this patch is good to be merged)?
>
> If I understood correctly, devm_drm_dev_alloc allows to delete drm_dev_pu=
t
> from error path in meson_drv_bind_master and in meson_drv_unbind.
Correct, that's the idea.

> Then the proposed check may be ommited and function may just return
> instead of jumping to free_drm.
That's right

> And would it be better to rename free_drm to remove_encoders?
That free_drm label is very confusing anyways.
The short answer is: yes
The longer answer is: we'll need to work on the removal order again:
- encoders are probed *after* afbcd
- removal should happen in opposite order of probe, so encoders should
be freed *before* afbcd
- however, this order is not implemented

There's no harm for you to rename the label now. It just means that we
need to do some more cleanups.

Looking forward to v2 of the patch!


Best regards,
Martin

