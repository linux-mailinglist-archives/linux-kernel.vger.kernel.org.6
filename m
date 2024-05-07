Return-Path: <linux-kernel+bounces-171682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D68B8BE743
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4A31C23F2E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA57168B08;
	Tue,  7 May 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBs9kHyG"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B1C14EC79
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095172; cv=none; b=QnyxvPve9pn6z/h9qs27IY+NykB2fyHmGfrYfczqXqggCX4M3Gj63Ywe2yxB6Sb17pzKnweNdzXnJd0bLY2mGR4gnrWXc+E3s+ExShAR8JpOT8yIIOVIk9HYY0rD4wgkuFSe1s+Eed+/uCR4N254Ba1jvM1+MDxnlRDGLxOAuaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095172; c=relaxed/simple;
	bh=/wEyjI5m2O8HKuKdgtP+XsFBKrfzCPrB269/6Nd2+YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpkcHPAnaoiNTqBwW6+L/5+pWNsuOJDgLAOt1U5h5P/k2ew+ABCMLMcXLvBu9EIjhJefGRBsZdM6I2UcDC8HZgDbvM/FxZvA5CqhKpqKv81YUpjRwqm3nIuz59zDvxGxQSw4fRtvgzCWhDRPKN38e2n2aExC/ELlcj51bB6cwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NBs9kHyG; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de46b113a5dso3318784276.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715095170; x=1715699970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ysPCrT6aDiInuFk99HtusnAXRwhdESoITC61IbLRas=;
        b=NBs9kHyGPLxxXrDFj1qW08YcW8p+bdkBM/KlzVlb5f3MAHLqlIECJj/LN+xOPeHO5Y
         5e7gIKrTKfyuttAIw47A8EESpV/EWuTANdN0/Kzgu2teN+CB/uk8FXunzGKSgy6tj6if
         JAhoKcle40muA964rUqWwy89x2WY6sVEUcZiNb2u3Nr0eVzSlJGMMe+SAC8KFK1JXLXC
         nTPMah/fGWR92pj80GIykY2caaW+Vv57YrFYWb0LeZ+DfChS4jNnsGtuHPygmY7LGctH
         avKAZ1GbXrr87ENVIEnylKzeiujtodMysob+sXG/z1LV05VI/3jAa2M7vFHLlDpzCwVe
         dXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715095170; x=1715699970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ysPCrT6aDiInuFk99HtusnAXRwhdESoITC61IbLRas=;
        b=qckOiIOvUv5R5tw3cJ8C9/Bz/2COglWxq51Qnqq75AZdhpck/0eb+5ICU5nIMneiEB
         QDCZADU3RR/WiDRsjb7Vb7zrlPj38zyVTNb+PLp8hYBJ6Q6HMviZQl0UG59FnEDkAZmO
         6K60JE77SoiI3XZJpadGoUpz8xjcQ0469mGf2clyYCgU1cMhdR2klwKqASwKvjEZrzNH
         QWG80b4QvBguKBVI+EUm4RCli9qpgiPyHcKFN9stXJtoK2hcMlLvTDpvBAy7kKksu6VO
         +85di50yefh5VkeDj636lYXtcfGrzSTLS3MP3wOkcIXD2dGrd+cYb2Q2I9cwu1Kv/wG/
         KQXA==
X-Forwarded-Encrypted: i=1; AJvYcCVHZxkJS3659LLzj/iNPok9U5OUFVdmxq06gpENXTQyw+M4SdhA7b/gx7j7rbXG16S+HDIds8m/99N0xRz/j0ddfOge4oCaIa1zPVrX
X-Gm-Message-State: AOJu0YxEY1z3wnHsnNUrI6Q+KipfLWyFaZ84BccWxzhICgyKm52b9v3r
	tPb3JKNd/f1gEO+IxgYnUtSCzZxOr7hdYS53Bc8cAB5hxvz0OnUeoHpOhDviEJ/X1gUw0lAxT/5
	Y5ZUhdLPJfVufn25qxPmQY0cvOu/aJ+n+mnXjXA==
X-Google-Smtp-Source: AGHT+IEML+Kw1JVUOv0nN6ekdfHok6Y4DPu4GGX6sExCN5x0nEZTwSwW2OQ/aCjdgj8HeWcGREcPXHHI22erdbPufQA=
X-Received: by 2002:a05:6902:2187:b0:de6:327:fa2 with SMTP id
 dl7-20020a056902218700b00de603270fa2mr15626519ybb.8.1715095170220; Tue, 07
 May 2024 08:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>
 <ojduxo54lpcbfg2wfuhqhy7k3phncamtklh65z7gvttcwztmhk@zkifewcy4ovi>
 <3c0c7e7e-1530-411b-b7a4-9f13e0ff1f9e@redhat.com> <e7ilwp3vc32xze3iu2ejgqlgz44codsktnvyiufjhuf2zxcnnf@tnwzgzoxvbg2>
 <d2a512b2-e6b1-4675-b406-478074bbbe95@linaro.org>
In-Reply-To: <d2a512b2-e6b1-4675-b406-478074bbbe95@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 7 May 2024 18:19:18 +0300
Message-ID: <CAA8EJpr4bJUQt2T63_FZ=KHGEm4vixfpk3pMV9naABEONJfMmQ@mail.gmail.com>
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users
 (udev uaccess tag) ?
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Robert Mader <robert.mader@collabora.com>, 
	Sebastien Bacher <sebastien.bacher@canonical.com>, 
	Linux Media Mailing List <linux-media@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Milan Zamazal <mzamazal@redhat.com>, 
	Maxime Ripard <mripard@redhat.com>, Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 18:15, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 07/05/2024 16:09, Dmitry Baryshkov wrote:
> > Ah, I see. Then why do you require the DMA-ble buffer at all? If you are
> > providing data to VPU or DRM, then you should be able to get the buffer
> > from the data-consuming device.
>
> Because we don't necessarily know what the consuming device is, if any.
>
> Could be VPU, could be Zoom/Hangouts via pipewire, could for argument
> sake be GPU or DSP.
>
> Also if we introduce a dependency on another device to allocate the
> output buffers - say always taking the output buffer from the GPU, then
> we've added another dependency which is more difficult to guarantee
> across different arches.

Yes. And it should be expected. It's a consumer who knows the
restrictions on the buffer. As I wrote, Zoom/Hangouts should not
require a DMA buffer at all. Applications should be able to allocate
the buffer out of the generic memory. GPUs might also have different
requirements. Consider GPUs with VRAM. It might be beneficial to
allocate a buffer out of VRAM rather than generic DMA mem.

-- 
With best wishes
Dmitry

