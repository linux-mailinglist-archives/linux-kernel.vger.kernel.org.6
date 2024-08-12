Return-Path: <linux-kernel+bounces-283582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A434B94F695
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8C11F25299
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9418C32A;
	Mon, 12 Aug 2024 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1J2BRAA"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3F3189B88
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486946; cv=none; b=K1FoyhUzqEHMSX2MVu2ysSZ4eUOwDgABzQla6qRyZcEnUTV8k/4zM4TXSJKQ0j5h0ioqGKeWuyXMB0Hh/nwbcSWZxW9R+PqtdV3XR/oKIE9xhBJ40pIJKha378vfo23+ji3e6Nxp97Nm8FzIXnvxZg4BBKAnL+tPBRmd/g4CcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486946; c=relaxed/simple;
	bh=MN6EVSg50cIdsGQkQdCredezsAWU82dFVedyLLRBeYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G69jsTsSM+FF9MsUxnQcbtlntM1QM4/N76etSW2oBj7qaXCLwta3hu0oXW8J/9szMNNf7oHyZV6RTO9QVQ+seWftyWKT/sJPb0gA3wZ1iZ9OqJt7r7GWEaR3yU7VY4g4ZsS3ACk8ZUPJybTochywrSzjxGmqkcbddRo5nZ2P8wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1J2BRAA; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so61471681fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723486943; x=1724091743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coUi0/ohCVhoxzgHSkTjcFNIQKRPd60M4TbuFg/3kwI=;
        b=P1J2BRAAdGTTSt8VzCsiuSo4qvnWgJ7F/y+I7uyGPVcDiEbJgPiYsahu+IUyQwlaLJ
         6EbZaQuWS/2kuQsWgfQINKsCcgBju4vzPL6VW9sw/uizvLRauPeGqsWjQZNwUF9WBOP7
         eG/ruOP2YipuVWNLGS9vQHLD0wqnJjqM5j9+fKjW1PWdBdEP+r0S4aNutQeEqOsB5em3
         antWRHefZP/ug04XKr9zFLJxvi9WOPOxLNHkDJmg2d+thddQpUKT8/rYwQv5wkUPdUkZ
         4HpUP12GbhjhtHjH2OC61DJrnbwVxNLO59IZqp8lQHeaakoPdiqyxDfgY1jhDnqOv6/I
         +sgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486943; x=1724091743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coUi0/ohCVhoxzgHSkTjcFNIQKRPd60M4TbuFg/3kwI=;
        b=jj+IJwZAYquwa++mTp+6BFPaWREg6UOCLuw2vZhOav8fc41ReJAY/1vCp+Epc0MtdG
         qhwQtBQYOzwsQdcTbW5WVtDKuAiyFMhMw3Ooumi0ijOYbn7YFaGsCuuFhdyKSlyu5cCE
         nXdNXh+ckGqp5uSe3sdkgmUcI/ODg8R0D+tUHsQrDpHMBxoFT702/jWHYLj9tHfPi/LJ
         /UGq6xbtvI8OwIo+zlBq/BYdGtE3aLa9K18VU07QmrHO76Mqmzjt/1Xvt/td9oR3+HMr
         S5AFlboEd27X7G/FBEor0G3EGPc4UkJNwCLMQOlv3eVsiSXw4XRNnEntDtkdSMfEngwB
         9OaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsbdw32WI/gbChknzJBJsdIjrSFhF4+LcSyicnpIFa8cTyCITAyLJmoCfe7EwF3BuH/7szcYSoB8N4GRzrOipu+vr78uE2xvLadTMO
X-Gm-Message-State: AOJu0Yy0EeuEdj4sJbm/bjhbV26LkLjJuJyLNXZXZFzScqvVi1xgGhYl
	9AfXiFwpA8pA7qAmqfzNM2Mj6jzwkwKEoQJuF5G2rXS9FFODFw5tgisYEW5SM6Ay8Giij35hcP6
	HEU+O+BkPiRCQaIestTSPT4HgbY8=
X-Google-Smtp-Source: AGHT+IGsw5wOKenJ4/S6cK3uyE7tsHyzF1jzrmqdqVsPGZnCBKOLdTZr3nAw3POmcblOWHUs99+JFc65/My6jbBmV4M=
X-Received: by 2002:a2e:98c3:0:b0:2ef:2eb9:5e55 with SMTP id
 38308e7fff4ca-2f2b7150337mr7651301fa.13.1723486942050; Mon, 12 Aug 2024
 11:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723114914.53677-1-slp@redhat.com> <942afa37-a24c-48ed-ae10-c811849165bf@collabora.com>
 <CAF6AEGvwrYiN6nMSsRAdc3qq+qQGWEvdW_3+xJh6y2iAyW6rkw@mail.gmail.com> <46a5ec89-be9b-4342-820d-019b595fa379@collabora.com>
In-Reply-To: <46a5ec89-be9b-4342-820d-019b595fa379@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 12 Aug 2024 11:22:10 -0700
Message-ID: <CAF6AEGseD2=+vZG=ZfigLhDXt4WJ=XkP=NeT3ERTiiPifpbd+Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Sergio Lopez <slp@redhat.com>, gurchetansingh@chromium.org, tzimmermann@suse.de, 
	mripard@kernel.org, olvaffe@gmail.com, kraxel@redhat.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, airlied@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 4:16=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 8/5/24 19:24, Rob Clark wrote:
> > On Wed, Jul 24, 2024 at 12:00=E2=80=AFPM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> On 7/23/24 14:49, Sergio Lopez wrote:
> >>> There's an incresing number of machines supporting multiple page size=
s
> >>> and on these machines the host and a guest can be running, each one,
> >>> with a different page size.
> >>>
> >>> For what pertains to virtio-gpu, this is not a problem if the page si=
ze
> >>> of the guest happens to be bigger or equal than the host, but will
> >>> potentially lead to failures in memory allocations and/or mappings
> >>> otherwise.
> >>
> >> Please describe concrete problem you're trying to solve. Guest memory
> >> allocation consists of guest pages, I don't see how knowledge of host
> >> page size helps anything in userspace.
> >>
> >> I suspect you want this for host blobs, but then it should be
> >> virtio_gpu_vram_create() that should use max(host_page_sz,
> >> guest_page_size), AFAICT. It's kernel who is responsible for memory
> >> management, userspace can't be trusted for doing that.
> >
> > fwiw virtgpu native context would require this as well, mesa would
> > need to know the host page size to correctly align GPU VA allocations
> > (which must be a multiple of the host page size).
> >
> > So a-b for adding this and exposing it to userspace.
>
> In general, GPU page size has no connection to the CPU page size. It
> happens that MSM driver uses same page size for both GPU and CPU. Likely
> you could configure a different GPU page size if you wanted. dGPUs would
> often use 64k pages.

The smmu actually supports various different page sizes (4k, 64k,
etc.. I think up to 2g), and will try to map larger contiguous sets of
pages using larger page sizes to reduce TLB pressure.  This
restriction about aligning to host page size is because the kernel
expects allocations and therefore (currently, pre-sparse) gpu mappings
to be a multiple of the host page size.

As far as whether this should be something outside of virtio-gpu, this
does feel a bit specific to how GEM buffer allocations work and how
host blob resources work.  Maybe other subsystems like media end up
with similar constraints for similar reasons, idk.  But it at least
feels like something applicable to all/most virtgpu context types.

BR,
-R

