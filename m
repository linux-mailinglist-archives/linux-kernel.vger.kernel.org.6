Return-Path: <linux-kernel+bounces-262531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDDE93C858
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320B71C2179E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ED739AD5;
	Thu, 25 Jul 2024 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VmQeB8g/"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953921E4B2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721932150; cv=none; b=DNnMctifwDOApMe2+Qi9PBZeHxqLB5L3mPzj5fDCtD6ZtItwIcsBvMTzpfoA+LtjcLBJKlwmoKabguDMIlyli/f831hWVDGGAyTVtHjGWcWfljx5qmo0ea0ZvX61aj7yrXyZTK8wfkmSOLRV+7DpHY8D5F6ye+rN5Vr7Wi+xR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721932150; c=relaxed/simple;
	bh=7H82UX58ZrrZtRiHAVe/+LcpHIvYYzG0b2RLD43YNbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+4IQAjW0hUi9kBlsO+pzpHqRJnSEjI9m06GZ59EMj/To1YGy4VGZY/Gr5VdsJHl2SIejJFLgsyOgeBbtNZYAOowQ9G/R3dpdzB/D3Z+f9wfmCZXl/KlVuvT4iJv7lASBqd6RNJNTtOErmjrQ2BWKu+YwNG7A6NeItmgh+JLmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VmQeB8g/; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e0365588ab8so1177303276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721932147; x=1722536947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7H82UX58ZrrZtRiHAVe/+LcpHIvYYzG0b2RLD43YNbY=;
        b=VmQeB8g/x3E0nkQO/HdRzbatH1eeKLuSxGdW0AJxDeLRNpaRo4gBsaTxan8z+Wu4Bh
         LhfzH+KKQYExKrtnSttNiRznTCr6yIZdtD9o1TsUmW3GlAotbY1l5vKyjUHuqVYKH63n
         aOrQtvohxmxkAHmPblmnG28vd5RnZ8Bpo8L5h8xJWNhzfeLjeDAFCLE+SU6biQCxK+sJ
         cHchKGET02g3iZzjXVAiEGWS+oMenpNAadygUtk7WSnMLB0zVlYEvD7tFux1dZcGsOXz
         Fkb/H4Cuk3reDuEBBVtoJL6kB7KFMeLpYy4gDyiCFJU/Kg1ydOmsH7oBO9glN/D5FuN4
         EYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721932147; x=1722536947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7H82UX58ZrrZtRiHAVe/+LcpHIvYYzG0b2RLD43YNbY=;
        b=xOPdCYY/XYhUm+4wrGEmeBw7fgzVwMcwM++seMrbB+L5TeqvPUxuJe/YGI87FS73gL
         3h5D6ucsvxLzf2yrGTYc3trSMU52O5ziJ0AsqwtxjxFrzDSf5ZrS6mwRNrlvQvA9W9j1
         zPgVnxOm2vuyZBugjRQ+tbCQOtzcOuhO1HyUKPlhL9Ly1nKmlIjOkOU5HVqV4bUMm+Zz
         z8lgGx+mfWpxXHUQs5e+n2OFuGdtMFnnbYOsipdtNsrGE0RKdB03jlnYjO9pPhm/826b
         bT0qYAzgAvXV5QDwYJJuYog7KpGPGfTVwux4A4fYdAxutpgm01J/yMZlzmHXIQhdwxQ2
         HOig==
X-Forwarded-Encrypted: i=1; AJvYcCUf2XOiWaobYiR8+N5WhENxpmYkWE1EZgl/5XcYzkb4Xj2Vx8AEyr2e0L5aU8/qTCfIzqSdQl26FDU6pBfOk6W3CSTTmsdwhvN2zfw9
X-Gm-Message-State: AOJu0Yxj5Xcl2umTICFmwRY8ZZLdioDo39YXzxHcrI5WPtnpeC0AtoiX
	H9xzndluiIPydoBxnH78ZMba/CufSrJG5WfVdFJ8sdP2/lYQ/TaJ5TegyDwRToLSvL/D2OgLhIB
	XeGhfi5IYr58bkfPcxA+YHp7YGXaSVliZ7pvZ
X-Google-Smtp-Source: AGHT+IGItijrenPjAmbxU5/Nvgn7ovQBfsTeRuhZp2oL9F1LlVeqZKuRyX0WfNygkWhlg9mziIYn9ttT+ix/HaljKmM=
X-Received: by 2002:a05:6902:c0b:b0:e0b:1519:e0da with SMTP id
 3f1490d57ef6-e0b23230e16mr4766336276.52.1721932147352; Thu, 25 Jul 2024
 11:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720071606.27930-1-yunfei.dong@mediatek.com>
 <20240720071606.27930-5-yunfei.dong@mediatek.com> <8b143d1c-edf9-4b2c-a382-75328156a7b0@amd.com>
In-Reply-To: <8b143d1c-edf9-4b2c-a382-75328156a7b0@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 25 Jul 2024 11:28:55 -0700
Message-ID: <CABdmKX2SqrUE1dnZWFnzMYLYqScoCrM0JDxc3YuzQyyV43wDHg@mail.gmail.com>
Subject: Re: [PATCH v7 04/28] dma-buf: heaps: Deduplicate docs and adopt
 common format
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Yunfei Dong <yunfei.dong@mediatek.com>, Jeffrey Kardatzke <jkardatzke@google.com>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Nathan Hebert <nhebert@chromium.org>, Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Sebastian Fricke <sebastian.fricke@collabora.com>, Tomasz Figa <tfiga@chromium.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Yong Wu <yong.wu@mediatek.com>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 4:52=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 20.07.24 um 09:15 schrieb Yunfei Dong:
> > From: "T.J. Mercier" <tjmercier@google.com>
> >
> > The docs for dma_heap_get_name were incorrect, and since they were
> > duplicated in the header they were wrong there too.
> >
> > The docs formatting was inconsistent so I tried to make it more
> > consistent across functions since I'm already in here doing cleanup.
> >
> > Remove multiple unused includes and alphabetize.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > [Yong: Just add a comment for "priv" to mute build warning]
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>
> Since this is essentially a complete independent documentation fix I've
> gone ahead and pushed it to drm-misc-next.
>
> Regards,
> Christian.

Thanks!

