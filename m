Return-Path: <linux-kernel+bounces-524593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD6CA3E4F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DDF420271
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1401B2641F5;
	Thu, 20 Feb 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VGkh7s/H"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06EA2641DB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079221; cv=none; b=sggwPeyayWgl9tJaWkkvZOkvB/YdMismCFbEkAR926ZnUCXlfOV4YrJrDW5LA2tUISQVnKstBp57a2VqES4nn6+VRyLO+0fVfQ8oqIDz1kYh1sPEQWNgBBth4lqT1wjmGaV4MmDViotxUmsL3Q1oBO6VB0Z6IyCD6gELVLv7nGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079221; c=relaxed/simple;
	bh=BF/qm35P4uKsbrKBn/gLwoY0GozMrLl3uevc+2xL6YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cr2/nuJWK7+eJiF1wCmB+EtBZWgecgRq6oa9bS+iS+g593RhsIHSnv/88/vp16T9OP6Ubfo3diJ/Q4C5yZKQPotRwVJ2S7TBqSGNlOnB1dyjmF9n2931bGOlDOfFiioEKiLTiawSpc6mD+xnGceoKxgKyzXh8NQTK3038wL+ayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VGkh7s/H; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2217875d103so2939065ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740079219; x=1740684019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpS2FnqN2TDBERxg5I5MCZqVN24rvf9DEtZLCeAzcmo=;
        b=VGkh7s/Hqx7a+052nW0gD2UVZ02YnIKSuosVjV4ZZs/Mu0+9eHlVQWAwtxxP5Rnffi
         ve8F10WMwL5mQTFEefYFxjlhnAz5NpRyBImvji2j7E4e1Ou6GoZNPpzdbeRvsdhZFkJW
         64Ou5UvdBCaNIs7KPhh70rXivjwfxNm40uW+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740079219; x=1740684019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpS2FnqN2TDBERxg5I5MCZqVN24rvf9DEtZLCeAzcmo=;
        b=mPPFNADTyFqo6sExJ9hZ3a/Wtvs4Bxj8Hvz1VZ+wjjoypfb0zHGtIqC/58hf3zHOOp
         g2SmK4OkeT6w1Jdv8mHIaQjrLvY+ItIsZBJOy+/mQkNqk2WW5uQNWfqvxxetOazWVcgU
         JCRHd4AuUQwPJfDPW/q/cQOWo6Q1nd83MoDE+XQ7tIUtE7nH/j9i5zbBa4vihVwRLOdk
         wnnhepmz4LjDLTNeflXrFOf+zlhy8eCM/RbGN0QJUVWdmpcmhsQ1QpAq0hNkK5R7OUy3
         thf3hlchmP/Hzb85LCvfd/bRgjT0Xsre0XK2pgztnjo3IdUfr9A8p1HZAQIi4aSBeAbN
         Mc5A==
X-Forwarded-Encrypted: i=1; AJvYcCWoOKIZR4QCDwBfawUpTzmDkxfJulHgfxNsolkxaGScK83yVFDEOUZM5PNiTJ6PcKEiFhWFzdNUpiVKFtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8LN0icqKerBtiwMMvDH0Lh7wShJA5do2TQAq3hDN5jMlbSGMq
	Q+5Y+a9hIang1Rr6CfeD1C5SOaDs8nK6l4JnKksQlXj6ERqvRClS12bgkZifBFo4RB535Ml5uZf
	Dzg==
X-Gm-Gg: ASbGncviejfRgXGbl0qlWS/BxNoq7ktjyvm8iMeBi7LN1XLvXXOQLpxOq9snpe63+K8
	KKiwQBjKuRGBeG6gek2v8FJCI6qpzUbC5hbPrpP+NNOAyiJ6cIIWlSYW3P2HImY3IAAiwE0u2s/
	rDBZIhuH30m4W5la0Mn03rQbsozH1ni0bAX+TMSsvYOatmIZ23TuJCYcYI+AI+Ga1cIvWmcnwQC
	i799jWNbLE8grqJEEXZdQzPJ49NK42zkcVNtiLVujLGbmPM0Xs4POzB46mAG9LsHGXr1opYb5Sp
	xYzygnV28PO6SvFzo/6kovxOMmE8/Mrug6k6dNYH7oSQ+hDuzTlGvbo=
X-Google-Smtp-Source: AGHT+IG0Y0I5fPL9fPvLkpkMjjXiiYEpK2HEHGiBmLzrdPdiVZ6wQpOpotEJlIpKRFajhYScZYXDiQ==
X-Received: by 2002:a17:902:cec6:b0:220:d71d:4666 with SMTP id d9443c01a7336-2219fff855emr1604355ad.13.1740079217625;
        Thu, 20 Feb 2025 11:20:17 -0800 (PST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com. [209.85.216.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d473sm124614095ad.166.2025.02.20.11.20.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 11:20:16 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso2720418a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:20:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7CcmTcC01t2l64eK0u7fR/WiLKQNGZJMXd6lBlWBZraNG+4xMgujRuWQOtpW6AakYiTlpVRYvnOAKcvM=@vger.kernel.org
X-Received: by 2002:a17:90b:3946:b0:2f4:434d:c7ed with SMTP id
 98e67ed59e1d1-2fce78c7fd8mr609023a91.16.1740079215301; Thu, 20 Feb 2025
 11:20:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-virtio-shm-page-size-v3-0-874fff6f3979@redhat.com> <20250220-virtio-shm-page-size-v3-2-874fff6f3979@redhat.com>
In-Reply-To: <20250220-virtio-shm-page-size-v3-2-874fff6f3979@redhat.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Thu, 20 Feb 2025 11:19:47 -0800
X-Gmail-Original-Message-ID: <CABVzXA=_S2in+OzfwK6vGQR3VK3YhGRu4B+tp5oCZKHt0Qz=gw@mail.gmail.com>
X-Gm-Features: AWEUYZlJc2Ri_gGb-xTYNfHBI9nY3KXtKqjPGrNSl2kv5ni8-vqVm6Z_S9XKcC4
Message-ID: <CABVzXA=_S2in+OzfwK6vGQR3VK3YhGRu4B+tp5oCZKHt0Qz=gw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/4] virtio-pci: extend virtio_pci_cap with page_shift
To: Sergio Lopez <slp@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, fnkl.kernel@gmail.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 6:30=E2=80=AFAM Sergio Lopez <slp@redhat.com> wrote=
:
[...]
> @@ -829,6 +839,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *de=
v, u8 required_id,
>                 *bar =3D res_bar;
>                 *offset =3D res_offset;
>                 *len =3D res_length;
> +               *page_size =3D 1 << (page_shift + 12);

Maybe this should validate that page_shift is in range to avoid any
funny business from the device; since page_size is u32, this needs
page_shift + 12 < 32. (If it's out of range, I am not sure what this
should do; maybe just warn and set it to the default 4096?)

Also shifting into the sign bit is technically undefined (or
implementation-defined? I don't recall) behavior, so perhaps make the
constant unsigned, e.g. `1U << (page_shift + 12)`.

Other than that, looks reasonable to me:
Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>

Thanks,
-- Daniel

