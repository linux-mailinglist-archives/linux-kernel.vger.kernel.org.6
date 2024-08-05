Return-Path: <linux-kernel+bounces-274992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD778947F47
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF0B281F9E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A7915D5D9;
	Mon,  5 Aug 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBeDqn5b"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148F11547E7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875060; cv=none; b=ooBrrummmuOmvPIHAP27NCZH3uYcGTro7aU1is6jxteRh6j6Ikhzd7Pz3qXmylycNK1xxeu0wy51O0kJtZ0qec0QmgNyhxxvNl5yU1zH591UATewZ2zkiNbYaBvzb6y9Jr/QIIstJ3xZMp26Z+QqNkQnqTlY1/djx1rLQCWIBRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875060; c=relaxed/simple;
	bh=a8C99+OTElpTmOTtUSQ4jS9OW9GVLl/7moJ7+wx1Mb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOVic030l42rugEXKn0jwtS6uLexl5zgLGwDRIBmgxLrxlc6ztJksyodVA+C/PmloGEB+l+VAVK9ymemk/KEXEKoUelHC9j99AL44GShD3WI/35uXBBizWuhjLAW1X/bR7j11Zzy/Fv3R6x0B4JrQ6NynmOQ0OnXmBDdiuTOJIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBeDqn5b; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6117aso1669315a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722875057; x=1723479857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8C99+OTElpTmOTtUSQ4jS9OW9GVLl/7moJ7+wx1Mb4=;
        b=WBeDqn5bdPmxyOt408D5RKpTv/LdDah/tYfjC9yVTg09Xi/cXRG2t6GRAPMVTJgT/R
         ENjQxOCrNXbVut/4S40OHoMVX0WeA90GEjJGJ6x7wzh3mPMV2KqbsIOS42C+3tJd5f+T
         dywTsF63i5EsesHxmU2lAjKjPOQvSFZMaMI5riBDX9ZStEjJtbET1tCFgiYQzIpkrtjR
         smtXlemzNGsiphF/cotOp1wMPdNqHzl2yPDlGr3qxz59Ce1iP/xtaLHe/yNKV8uUc97M
         w18Mlla1hrWuqvB3bFqk0HcvkDgmXa0BfI3Yt6yeteuc3ynfKpUScB7vux9qSKBWbiu/
         F+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722875057; x=1723479857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8C99+OTElpTmOTtUSQ4jS9OW9GVLl/7moJ7+wx1Mb4=;
        b=g1rTxlE79O0kmoqyRWfinJ7H8LOO6yVMx8X3nPQukVt8UknC0W8k3ZQS8eTSCKideg
         +uLxzu06DXJG/aCDKuKsok5/bzrg5YlJROhA0hjyPFTxfCZKzmC7CJA60UIu0C9/YRxZ
         ePszP8GHcBHMieH7dvnBh/tEbrSNXWIAPM5qNg8To14yGmxGbi0QiZxXcNopJtt80mVC
         apn/GYz1PIgmcaLDl532rNx9SnBLRRG53TgaB+63v0TBbe0+//pbCSPXHtJamQNZoPfF
         0qQsjA2FaZVjJ9L9MklIZ1ovBdSh0dhMrCe9rNoDJsCouy5iK1yGhJkj49NUAou7zTO3
         8IdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4O7JJ5BL2QNmt9Z98bffVOPEnvOI+vV3V1fhebt4rmVj6rK1GB/YvBVHSCyfwjdkOfl5cJ7EihhS33PPURikyl96gELagSweobd+T
X-Gm-Message-State: AOJu0Ywza4sHXjdIA2dlw3uRAtAQnJdPIDRVXrCUdUBEa0xduV29hiPD
	kpljMHi7UMLoyM3ifjwpoDR8pyGnZwhRkAz78ytxs4tk75nvHn50lnjIEqYCikOwqeF4zM4A4vG
	fFw8IYcwjWwzIssQSWtszCHu039M=
X-Google-Smtp-Source: AGHT+IHvyHbFZJE4p8C4OL9f2eMAtF/7nSyBc86q0iTr2swDTqSonp+1rkVReAaAYjc0C810FGILIP+l2ZHt9zaqOEo=
X-Received: by 2002:a50:e613:0:b0:5a1:a08a:e08 with SMTP id
 4fb4d7f45d1cf-5b7f39e07b7mr10209743a12.11.1722875057029; Mon, 05 Aug 2024
 09:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723114914.53677-1-slp@redhat.com> <942afa37-a24c-48ed-ae10-c811849165bf@collabora.com>
In-Reply-To: <942afa37-a24c-48ed-ae10-c811849165bf@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 5 Aug 2024 09:24:04 -0700
Message-ID: <CAF6AEGvwrYiN6nMSsRAdc3qq+qQGWEvdW_3+xJh6y2iAyW6rkw@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Sergio Lopez <slp@redhat.com>, gurchetansingh@chromium.org, tzimmermann@suse.de, 
	mripard@kernel.org, olvaffe@gmail.com, kraxel@redhat.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, airlied@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 12:00=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 7/23/24 14:49, Sergio Lopez wrote:
> > There's an incresing number of machines supporting multiple page sizes
> > and on these machines the host and a guest can be running, each one,
> > with a different page size.
> >
> > For what pertains to virtio-gpu, this is not a problem if the page size
> > of the guest happens to be bigger or equal than the host, but will
> > potentially lead to failures in memory allocations and/or mappings
> > otherwise.
>
> Please describe concrete problem you're trying to solve. Guest memory
> allocation consists of guest pages, I don't see how knowledge of host
> page size helps anything in userspace.
>
> I suspect you want this for host blobs, but then it should be
> virtio_gpu_vram_create() that should use max(host_page_sz,
> guest_page_size), AFAICT. It's kernel who is responsible for memory
> management, userspace can't be trusted for doing that.

fwiw virtgpu native context would require this as well, mesa would
need to know the host page size to correctly align GPU VA allocations
(which must be a multiple of the host page size).

So a-b for adding this and exposing it to userspace.

BR,
-R

> --
> Best regards,
> Dmitry
>

