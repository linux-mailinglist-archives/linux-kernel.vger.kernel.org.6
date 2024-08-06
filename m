Return-Path: <linux-kernel+bounces-276828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3550F9498E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579871C2113B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265ED14EC44;
	Tue,  6 Aug 2024 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyigb9dV"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B238C4AEE5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975330; cv=none; b=GVn9i0XSdEORS8gqwkTnZwWoj0IPArJ4XkbT7a5lhp2gbfcY75iK7tDuwJAsII38PW3ZtheQnFYW5v1oAvDjB+85YBOo7vt9IkdCc5YrR7dr5vE7W9Ro7N47uo4bYU0ay6mgsE+qPeqNuG9HRrIiZaDhC0lw9+IXtzoQttfachs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975330; c=relaxed/simple;
	bh=VxB/cGylhChdxmwTFCI5s1BrAh/xNUENUOMwnFLA+fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lm4Ty+FdnTwGIuRMJCSKQGF1gSLyEyl9nEw1w7bPVGnDgVq8X3NhdlyrWFOrrCZMwubYyezmiRKlk/H8qP3H+J6RULsCYAKU0uTJ+jSpRxrxtDyMQ2PMIorP1qmMN9USk50ii4OeD6bo5l77fBSXt5hlKyIjulIjfeI9+zD6F3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uyigb9dV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so1781066e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 13:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722975327; x=1723580127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dcr4nYm/ORNQ3/y4PL408hIFoTg8Yy+y6wFiPltrL7k=;
        b=Uyigb9dVJ1QVtSd6Lb+SB747wcKVLzJCjCDOqCsKQQYTP6wAWp8sdOZMeweq2QaXfE
         t0bJyai+CsHEtsBnOIo34jdtmErZ3jfJSRgZDZ2B9Lq9mH46SaGfj5CllOzYe/y/sYgJ
         JEp8b1mRb7pEDF6SBkRsRpjwxRFOaVifuI0cBph/fM9ZXlQRR6DO9gcNcc/t7q8FI9ZO
         ZdZa2jKtnlUY8ni5ExL+OMXgRDW3jgaz3xDZWQF9UWuz3vJI7k+TrqI4pE9qxL6D1QmC
         beyOjtaY14VFyZJQhpI1vfCn3tGM5fSzs5IjZMMIrZBed3o5XVoXCJsUCa43xlm2bCQo
         +6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722975327; x=1723580127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dcr4nYm/ORNQ3/y4PL408hIFoTg8Yy+y6wFiPltrL7k=;
        b=ICH0P47tcvnVFpsKQwcmpL/2rsjl1TIl6zvstycHHtrqWTcDsIqYhnsNJSZ1tv24Xk
         qY7UemG7IjecuHLPPyxXdTy0NmBDYe2tGLaETNadu7juXBD5+6GBJPG/e6+YsvCp5Gjr
         jYHnUF+TMXEL10RAHaahBgU8bgzIbUHFKU6MEpH7iG7LRZ0gPsEPJg2o/bYg6CqQer1b
         cMUY6gjyz+otWFn3F2GfcgGJAQL5sKjvGfe/EWJ71ArG5erwFXOFaXoio6ibpRe7XqDT
         svQL/M/Sb0SxuMTIu2LTxGCLiUVbRCEsExNLazAGbK6Nh72gzBzesTz70qGfpm6xqcMy
         /LMw==
X-Forwarded-Encrypted: i=1; AJvYcCWUs9PWzVL4VTuFBx2a6VkUmaSQKFzcPxBPiHuIXc3XeNwe6bDre2t89o5yy2r9SSdrrCbRewFRZ2o/Z564ksS3GffTQCWoeH2ByEzn
X-Gm-Message-State: AOJu0YwJ3Ii6ZknJjdBlzgU3Po3/kXs6EjgKv3mz797dRS55UgN1C9Tg
	Z8ri+JE9WWu2BSVyHYlHCNqX0vRURmPd+kHm8yFdbOvMJ4+jKWRbeIANjSZcPIt8f7r55dyNTkX
	Z4WOp5bWGkf2hmygQdMqSjB9pSNM=
X-Google-Smtp-Source: AGHT+IH3Tp44NrqMDhvMRbQhQ0+Eoa5hP8pm5fmmlYU+SDu3IykCst1EwAebrsLtDb/dcR3chM8jUFPBcOJNtaDvxNA=
X-Received: by 2002:a05:6512:a8a:b0:52f:ccb0:9ea7 with SMTP id
 2adb3069b0e04-530bb3e0ba6mr9551626e87.60.1722975326329; Tue, 06 Aug 2024
 13:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723114914.53677-1-slp@redhat.com> <942afa37-a24c-48ed-ae10-c811849165bf@collabora.com>
 <CAAiTLFV6mAgrMj=itcxoBCibvYRyrAk02wYp-gYJ8kxhF0EPmw@mail.gmail.com> <CAAfnVBkWKn3+YEhNz0CTmw-T_jjL72axkWqYgkzkSa72t_Gf0A@mail.gmail.com>
In-Reply-To: <CAAfnVBkWKn3+YEhNz0CTmw-T_jjL72axkWqYgkzkSa72t_Gf0A@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 6 Aug 2024 13:15:14 -0700
Message-ID: <CAF6AEGsnpEYFsCfZUAPopWzY=wv_GWn0P5f5D6U9y-JrWGQVnw@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Sergio Lopez Pascual <slp@redhat.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, tzimmermann@suse.de, 
	mripard@kernel.org, olvaffe@gmail.com, kraxel@redhat.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, airlied@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 9:15=E2=80=AFAM Gurchetan Singh
<gurchetansingh@chromium.org> wrote:
>
>
>
> On Mon, Aug 5, 2024 at 2:14=E2=80=AFAM Sergio Lopez Pascual <slp@redhat.c=
om> wrote:
>>
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>
>> > On 7/23/24 14:49, Sergio Lopez wrote:
>> >> There's an incresing number of machines supporting multiple page size=
s
>> >> and on these machines the host and a guest can be running, each one,
>> >> with a different page size.
>> >>
>> >> For what pertains to virtio-gpu, this is not a problem if the page si=
ze
>> >> of the guest happens to be bigger or equal than the host, but will
>> >> potentially lead to failures in memory allocations and/or mappings
>> >> otherwise.
>> >
>> > Please describe concrete problem you're trying to solve. Guest memory
>> > allocation consists of guest pages, I don't see how knowledge of host
>> > page size helps anything in userspace.
>> >
>> > I suspect you want this for host blobs, but then it should be
>> > virtio_gpu_vram_create() that should use max(host_page_sz,
>> > guest_page_size), AFAICT. It's kernel who is responsible for memory
>> > management, userspace can't be trusted for doing that.
>>
>> Mesa's Vulkan/Venus uses CREATE_BLOB to request the host the creation
>> and mapping into the guest of device-backed memory and shmem regions.
>> The CREATE_BLOB ioctl doesn't update drm_virtgpu_resource_create->size,
>> so the guest kernel (and, as a consequence, the host kernel) can't
>> override the user's request.
>>
>> I'd like Mesa's Vulkan/Venus in the guest to be able to obtain the host
>> page size to align the size of the CREATE_BLOB requests as required.
>
>
> gfxstream solves this problem by putting the relevant information in the =
capabilities obtained from the host:
>
> https://android.googlesource.com/platform/hardware/google/gfxstream/+/ref=
s/heads/main/host/virtio-gpu-gfxstream-renderer.cpp#1691
>
> If you want to be paranoid, you can also validate the ResourceCreateBlob:=
:size is properly host-page aligned when that request reaches the host.
>
> So you can probably solve this problem using current interfaces.  Whether=
 it's cleaner for all context types to use the capabilities, or have all VM=
Ms to expose VIRTIO_GPU_F_HOST_PAGE_SIZE, would be the cost/benefit tradeof=
f.
>

I guess solving it in a context-type specific way is possible.  But I
think it is a relatively universal constraint.  And maybe it makes
sense for virtgpu guest kernel to enforce alignment (at least it can
return an error synchronously) in addition to the host.

BR,
-R

>>
>>
>> Thanks,
>> Sergio.
>>

