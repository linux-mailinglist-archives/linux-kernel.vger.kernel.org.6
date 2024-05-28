Return-Path: <linux-kernel+bounces-193013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8268D2595
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F0C282980
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA21B4436E;
	Tue, 28 May 2024 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mS71ZKlz"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC50179202
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927309; cv=none; b=uc8f4Qc9oNTOmsqFiTZdbWZ/waYh2g+bQ7qcsvw4TfitJefxomNPwgKF5AkXKBwv8AXV1cFVFpLkNahv6SK0JsizyEwoC9A3m19nY3IPsjEfXCJSkTib1qGVFhZCeDcDEjRPChHi5JG/WR3+F+nl9XiNrS9ygU2qB9CrlQVeuRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927309; c=relaxed/simple;
	bh=en2TGRjkuW3PBRpbSQahu96oV+wObSIdrbE7VcLSSN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fW/Ovj+jt2tZH1141jEL45zwII6h8ymE6iLu67HhPCLtGKynuHTUJsw4GlsGLXaebgKjVbeFIoMzWxZS1ILhByVUgRlqBFyFthSliTpR9iUyqAOyuSNomTPpxXlNiCiEYa4dluc3JLEwmYrUSmy5n9iYC7mubrQ0Ly6dihZCFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mS71ZKlz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f8eba8f25eso1071943b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716927306; x=1717532106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qSEByr0cVqm4o+EKl2XQRiChKteOLXLt82vx/Q7ni4=;
        b=mS71ZKlzkWqlq9IGZrt0QCLTul+8diwSr19T3kR9NEK2ctSClN3nWYEmsOutvnyqdb
         1kUr7KAEt+9wOcGImFAsZ3b0TMI+6WD/Mb/6kfkM/AcFrTZ1ZKxPwgP+8yhvm4JSRHDw
         owjuxPY2/4ONZ5IMOrAE7gzM2Dg7qM6Ozysck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716927306; x=1717532106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qSEByr0cVqm4o+EKl2XQRiChKteOLXLt82vx/Q7ni4=;
        b=LzdfsAr7CBWmKyp/prtXYQtKyT45WFO4w1WFoBbDI2XKQshdRe9tjgbohxouTudivM
         kGR28XhFL6BjT+rbrbtgJPZWRdm2VmygJh1ZdW+/vX5chmCpWydRrFaDn4Mz6B9qgJCp
         k3q/kj93g+bdVm0iSmdofEoLe4plbI6KdxtPOXqQEiupVGwHhuQrPjBUY5nWZiCUl7rH
         cfR3Pprfg04cBTSmWMd1CwNC/Iw4iy/GBQ7OSveoGH6h6MVBE/vKxZ7xYS7eZiBxDieV
         1BV5A9+C/IoHjcGqeikumqdZ8AdEo4lU+G8RQAnoZ4I2z8wxhVqCwHy5oIgArszNhDf1
         0wBg==
X-Forwarded-Encrypted: i=1; AJvYcCWquCa1pKy+i2iZmq4Ps7DNWoArv4IVHT5e1krL5r25O7doq8wSaOKf2W6+nu4pIHm0jaI0nIa3voiM1TyWYhBkEkimrJ2/8EofGQx4
X-Gm-Message-State: AOJu0Yym27thNtRYpifWd/R2Z0i6gfMmh20QXvMaYDm4AwsY4F08LjQO
	kEjHaHndnQPseic4Nf63CXibfVPp5DPVdKxcPIKu8yg/Y64dbhSG+DJgJo/KTovyHNcIIIc1JlM
	=
X-Google-Smtp-Source: AGHT+IFW3ROIopbHp4FmwDjcXwLPL8ji7h5EmnLD6C5bTtiuJq1rdjG5bfZSSd8bZPyyZwxXle1n4A==
X-Received: by 2002:a05:6a00:2c94:b0:6e8:f57d:f1ec with SMTP id d2e1a72fcca58-6f8f34ca8b9mr16497014b3a.17.1716927305818;
        Tue, 28 May 2024 13:15:05 -0700 (PDT)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com. [209.85.214.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3eaeesm6801773b3a.43.2024.05.28.13.15.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 13:15:05 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f339d61e78so42015ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:15:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURdZq0A+FD8t/KiNOFVeuoZCDfijky7MG7yVNWHMFQZG7peC22yJiFz3NxTjW8PYgpvjZkfQUsXxSiTPC271O1U44OA1NQsKsFUqI9
X-Received: by 2002:a05:622a:1e17:b0:43f:e034:724f with SMTP id
 d75a77b69052e-43fe1103588mr257971cf.15.1716927283572; Tue, 28 May 2024
 13:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503213441.177109-1-dianders@chromium.org>
 <CACRpkdYbtfE9RLsDewV2UwnJknCp_sFEgc+cq=OF+Qd3tkTcwA@mail.gmail.com> <CAD=FV=WoYm43SzrdrSZ1Np58iQ4nMwF0u6uamOAnZc4pqmBpsg@mail.gmail.com>
In-Reply-To: <CAD=FV=WoYm43SzrdrSZ1Np58iQ4nMwF0u6uamOAnZc4pqmBpsg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 28 May 2024 13:14:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V-4CnU7k0W3zwPAf_aeddykmHPN6=wMnjKAzQcbwHeNA@mail.gmail.com>
Message-ID: <CAD=FV=V-4CnU7k0W3zwPAf_aeddykmHPN6=wMnjKAzQcbwHeNA@mail.gmail.com>
Subject: Re: [RFT PATCH v2 00/48] drm/panel: Remove most store/double-check of
 prepared/enabled state
To: Linus Walleij <linus.walleij@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Jonathan Corbet <corbet@lwn.net>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Ondrej Jirman <megi@xff.cz>, 
	Purism Kernel Team <kernel@puri.sm>, Robert Chiras <robert.chiras@nxp.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 8, 2024 at 2:14=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> > This is the right thing to do, thanks for looking into this!
> >
> > As for the behaviour of .remove() I doubt whether in many cases
> > the original driver authors have even tested this themselves.
>
> Yeah, I'd tend to agree.
>
>
> > I would say we should just apply the series as soon as it's non-RFC
>
> It's not actually RFC now, but "RFT" (request for testing). I don't
> _think_ there's any need to send a version without the RFT tag before
> landing unless someone really feels strongly about it.
>
>
> > after the next merge window
>
> With drm-misc there's not really any specific reason to wait for the
> merge window to open/close as we can land in drm-misc-next at any time
> regardless of the merge window. drm-misc-next will simply stop feeding
> linuxnext for a while.
>
> That all being said, I'm happy to delay landing this until after the
> next -rc1 comes out if people would prefer that. If I don't hear
> anything, I guess I'll just wait until -rc1 before landing any of
> these.
>
>
> > and see what happens. I doubt it
> > will cause much trouble.
>
> I can land the whole series if that's what everyone agrees on. As I
> mentioned above, I'm at least slightly worried that I did something
> stupid _somewhere_ in this series since no automation was possible and
> with repetitive tasks like this it's super easy to flub something up.
> It's _probably_ fine, but I guess I still have the worry in the back
> of my mind.
>
> If folks think I should just apply the whole series then I'm happy to
> do that. If folks think I should just land parts of the series as they
> are reviewed/tested I can do that as well. Let me know. If I don't
> hear anything I'd tend to just land patches that are reviewed/tested.
> Then after a month or so (hopefully) I'd send out a v2 with anything
> left.

Nobody said anything, so I did what I indicated above:

1. I've applied all patches that someone responded to with Linus +
Maxime's Acks + any given tags. This includes the st7703 panels which
Ond=C5=99ej replied to the cover letter about but didn't officially get any
tags.

2. I also applied patches for panels that I was personally involved
with. This includes panel-edp, panel-simple, samsung-atna33xc20,
boe-tv101wum-nl6.

Anything totally unresponded to I've left unapplied. I'll wait a
little while (at least a week) and then plan to send a v2 with
anything still outstanding. If someone sends Tested-by/Reviewed-by for
some panels in the meantime I'll apply them.

Here are the 25 patches applied to drm-misc-next:

[01/48] drm/panel: raydium-rm692e5: Stop tracking prepared
        commit: 598dc42f25cc3060fd350db0f52af1075af3f500

[04/48] drm/panel: boe-tv101wum-nl6: Stop tracking prepared
        commit: 3c24e31c908eb12e99420ff33b74c01f045253fe
[05/48] drm/panel: boe-tv101wum-nl6: Don't call unprepare+disable at
shutdown/remove
        commit: 1985e3512b5a3777f6a18c36e40f3926037120bb
[06/48] drm/panel: edp: Stop tracking prepared/enabled
        commit: 3904f317fd977533f6d7d3c4bfd75e0ac6169bb7
[07/48] drm/panel: edp: Add a comment about unprepare+disable at shutdown/r=
emove
        commit: ec7629859331fb67dbfb6bcd47f887a402e390ff
[08/48] drm/panel: innolux-p079zca: Stop tracking prepared/enabled
        commit: f9055051292442d52092f17e191cf0a58d23d4ed
[09/48] drm/panel: innolux-p079zca: Don't call unprepare+disable at
shutdown/remove
        commit: eeb133ff78476eb1e6e88154dfb75a741e8a034a

[12/48] drm/panel: kingdisplay-kd097d04: Stop tracking prepared/enabled
        commit: 157c1381780a453e06430f8b35bb8c5d439eb8c6
[13/48] drm/panel: kingdisplay-kd097d04: Don't call unprepare+disable
at shutdown/remove
        commit: 68c205ef3c39edce4a3346b8a53fd2b700394a0c
[14/48] drm/panel: ltk050h3146w: Stop tracking prepared
        commit: f124478dd18c519544489caddce78e7c5796a758
[15/48] drm/panel: ltk050h3146w: Don't call unprepare+disable at shutdown/r=
emove
        commit: b7ca446ecb53205944968617b158f073bcacaedc
[16/48] drm/panel: ltk500hd1829: Stop tracking prepared
        commit: 2b8c19b9d7bc9d03e8c44bd391d21e95c07a2c83
[17/48] drm/panel: ltk500hd1829: Don't call unprepare+disable at shutdown/r=
emove
        commit: 3357f6f465e62c0bc5e906365063734740c9f6d4
[18/48] drm/panel: novatek-nt36672a: Stop tracking prepared
        commit: b605f257f386b7f4b6fc9c0f82b86b75d0579287
[19/48] drm/panel: novatek-nt36672a: Don't call unprepare+disable at
shutdown/remove
        commit: 2a9487b5aa55753993fde80e4841128c8da4df71

[24/48] drm/panel: samsung-atna33xc20: Stop tracking prepared/enabled
        commit: 5a847750aac8454a1604070ab99d689c0a6e4290
[25/48] drm/panel: samsung-atna33xc20: Don't call unprepare+disable at
shutdown/remove
        commit: 49869668ff0e3f380858b4c20b8d0cb02b933f48
[26/48] drm/panel: simple: Stop tracking prepared/enabled
        commit: 2a1c99d7159b798288bfb20a76c1e665e2344126
[27/48] drm/panel: simple: Add a comment about unprepare+disable at
shutdown/remove
        commit: bc62654df3c888dec735343f5db9907ac93aea60

[30/48] drm/panel: xinpeng-xpp055c272: Stop tracking prepared
        commit: 4e5e6fa77a9d40cdf85ade7f86d07dc8929941c9
[31/48] drm/panel: xinpeng-xpp055c272: Don't call unprepare+disable at
shutdown/remove
        commit: ac9e1786271f771ff1f774742602330be2d57a12

[42/48] drm/panel: sitronix-st7703: Stop tracking prepared
        commit: 3004d2e9cca5d59d25dff670a03a005d40601ded
[43/48] drm/panel: sitronix-st7703: Don't call disable at shutdown/remove
        commit: 718bd8a1a5ee873778a72523c06da054a89108b4

[46/48] drm/panel: sony-acx565akm: Don't double-check enabled state in disa=
ble
        commit: e28df86aeeff0b84c13e676f641ea879abbdb809
[47/48] drm/panel: sony-acx565akm: Don't call disable at remove
        commit: 6afebd850d1ab5518c273b32532f0b2086cc633a


-Doug

