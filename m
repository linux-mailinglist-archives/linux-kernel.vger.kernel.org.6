Return-Path: <linux-kernel+bounces-199404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152A38D86DA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469AD1C22274
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11D7135A6C;
	Mon,  3 Jun 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5eETr/E"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17D134409
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430528; cv=none; b=arcdp+gDMsgrtqBGDXqFA6/cYmRNozQZxJB0zEcpPs34sPp8kdKW4eYyihy9e1isU7CXbyhR8O75MAP3/4M1/xZd36Al16vJ6ZgHglfD4lr9zgC6kof1AyyuAAD8LRQXEDi8Xrb411r8kiBYsfm7ObdwEfk2L2ZLQo40GcEbLLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430528; c=relaxed/simple;
	bh=3pPvxS6gC0j0wLGI+tY2V3qvQ3+8OtijuhMmjKJ6yQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RabJ3kDAqyjVNugjMnIWuM9VzAKNM1ASyOCpkte+Tbt63HCN6yuRiINNAKEMsBBs4Kk9aR6Fwao7VRB7UmkrjgGmt1g29idjgs++Dlg75Sl8z7XaXBmcfGKCBZCwIuyHLR3jgaecJBfKh1OBF+W9RjoTR4+felf6zNxsxsgX7gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5eETr/E; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso23965a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717430525; x=1718035325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pPvxS6gC0j0wLGI+tY2V3qvQ3+8OtijuhMmjKJ6yQo=;
        b=p5eETr/E07844d7vd35bqJhYdG0vUZVgUqAIwededZOWY6Vmm9gOs7PsYdk8hFYphP
         6r8I+BNvRqo1Y7tMPa+PTld0bupt1nkxTh/Gi+eLh01ZeFgbh8bLw3c0WDcBLW8NB+EQ
         J68I0YieIvQRUw5T7GjO2CEz0D3kGAKGaIYhIjRdQo0R8V6JSX59XZjT5ORD3XvOk4D2
         ZKvsLrnzcvssY8mC/Gh6h9p7K7gfogOzIXPbr1Ed8WI7RYjMoVFnyKpKhSqc0vUjUgBV
         AzI/21WCYBkGKUN43lmug5QJXB949K3WNDxyxybU0keTgs/zVW8JTofEV23cZyLvpmFG
         z/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717430525; x=1718035325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pPvxS6gC0j0wLGI+tY2V3qvQ3+8OtijuhMmjKJ6yQo=;
        b=TSDkfOF8LmOSmS9eY3MGTvxUrfg/lGaEZmMf0eH8/nvaGIadxBTp4gjNBUpYuDG5lS
         BkylwfIbTB8W261WBOTSVdrSHoeKmUrIeYmXKuerHiM8IF3579oIna8jE4Ft7BIdQdI8
         2g2jp4lj5GmvGISl5K8q5lsfIZgEUANZzc8k8FIOTSNbBGmSsmMGUC+kvU2EM7m35iQd
         pmTY3YnmCa1aFTFRey5HTxlBtkuQdRvnkedwub8KZ0fZ097EVak2bB+osf9FDzlV930P
         t/w9q2EccH55Oq0lGCvSCrJZYC18hyfjagYHLodq2bHF1+DBDTpw0CwEc2fhHBMZ30pg
         etsA==
X-Forwarded-Encrypted: i=1; AJvYcCV4zx+Ez4HACpqb0HClapxi3KUGKgAWg0ZCILdOgi4+fR3XsjjqjMYab47wI0rt3voF+ngfQ7zO+lUT3ToJKJdWEcTAxFzArTB4VCkF
X-Gm-Message-State: AOJu0YxsYHZCKvzibGPQrWwfDucE2MZy68Ih5JFYzlU+q54U6jjznLC5
	uvLYb0kbZSIBGznjSxhSRnPc3DIAZBvb3G/+ml+dAiYSfxud4tLjc8tQA9AsiRHgR0GAQ75yejP
	MFQcvYmYfzGA73JNlD2g9b0vDg1L9alfl/C0=
X-Google-Smtp-Source: AGHT+IE2ygUL2gxko1zx9nZ3F9o7d4GPZHrXPzUVa/BVxhglHJFXHF4Y/LFsOuSgzTNV+PzRLjHurcbX0Q3lsDSwxtg=
X-Received: by 2002:a05:6402:1803:b0:572:e6fb:ab07 with SMTP id
 4fb4d7f45d1cf-57a49645b32mr266898a12.7.1717430524539; Mon, 03 Jun 2024
 09:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603114008.16235-1-hailong.liu@oppo.com>
In-Reply-To: <20240603114008.16235-1-hailong.liu@oppo.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 3 Jun 2024 09:01:52 -0700
Message-ID: <CANDhNCq50zPB+TS+_Oo0HY0aUuBAdik2KrC8eJRTygbis293sw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] dma-buf: heaps: move the verification of
 heap_flags to the corresponding heap
To: hailong.liu@oppo.com
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	"T.J. Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	21cnbao@gmail.com, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 4:40=E2=80=AFAM <hailong.liu@oppo.com> wrote:
>
> From: "Hailong.Liu" <hailong.liu@oppo.com>
>
> This help module use heap_flags to determine the type of dma-buf,
> so that some mechanisms can be used to speed up allocation, such as
> memory_pool, to optimize the allocation time of dma-buf.

This feels like it's trying to introduce heap specific flags, but
doesn't introduce any details about what those flags might be?

This seems like it would re-allow the old opaque vendor specific heap
flags that we saw in the ION days, which was problematic as different
userspaces would use the same interface with potentially colliding
heap flags with different meanings. Resulting in no way to properly
move to an upstream solution.

With the dma-heaps interface, we're trying to make sure it is well
defined. One can register a number of heaps with different behaviors,
and the heap name is used to differentiate the behavior. Any flags
introduced will need to be well defined and behaviorally consistent
between heaps. That way when an upstream solution lands, if necessary
we can provide backwards compatibility via symlinks.

So I don't think this is a good direction to go for dma-heaps.

It would be better if you were able to clarify what flag requirements
you need, so we can better understand how they might apply to other
heaps, and see if it was something we would want to define as a flag
(see the discussion here for similar thoughts:
https://lore.kernel.org/lkml/CANDhNCoOKwtpstFE2VDcUvzdXUWkZ-Zx+fz6xrdPWTyci=
VXMXQ@mail.gmail.com/
)

But if your vendor heap really needs some sort of flags argument that
you can't generalize, you can always implement your own dmabuf
exporter driver with whatever ioctl interface you'd prefer.

thanks
-john

