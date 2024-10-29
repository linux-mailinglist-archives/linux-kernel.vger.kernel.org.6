Return-Path: <linux-kernel+bounces-387380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60179B502B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F7E1C2281C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF909194C77;
	Tue, 29 Oct 2024 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUi7h7BJ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DD017D355
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221998; cv=none; b=uBTWfUonK0oZu+QqT8HpUdI042+oi26S2HeDIMZI26e5tNaT1YCs6pEZyoRvEFKIX41DvwASiMMm8E18citz6jEgHa9O3amq7k71J+aJi5BXcx7a51konacLETInsAb6z5Dp2RKALjxna/o85IrE7rFwplbb1Bm1MOkpYRhcDsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221998; c=relaxed/simple;
	bh=bcXdPtKi+t/YaupsEypUpSRygRNXwNzOBnt4Mf8dUpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieEQotL7vtDpe4T2zZYjTtBhud7y9vs+CkZEGfF5gqpwfOPV6OvQC4T0GlzzacoNmYLsSA2WWcQQT9z/oGhn+o2QOZ/3gr530k9YQNM1KTzOZtYVzryaKPB3x2ku6iPJwDwIukrazSygcBcrBOtnyS6adbVHYAMHlToet2Fqf+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUi7h7BJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e52582d28so459938b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730221996; x=1730826796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ISkj2Ba2iXJsNtvKhhww/fpbPtoqWwWm4yhMQ09Pkc=;
        b=FUi7h7BJjtbDnmnOOIdRc4IN/xOy21HaFN2SrPsRVhGMTb/Sw4AmjHXZJm/JTKaQzt
         18iklvJG5yj83JI/J5IEOKfIcQBPioD9h5iwlKWiOHGlsRyhmCLTcmfeX7LDARLQpzcQ
         8uJaEt2naFeXPbpOUC7rh3zI8U+nLMXct0zPrgyWGiI+97gwcbM+Ab04VaqrYFM1BcHv
         AoTknUI7YFcKwOtP+4fTS0OCdKKkr5wQvco9PA+17YeZNTgBIxKgjin3v9tLKjgqH2LF
         1Aj72YBIlgMZUDzvoWSvAmuQQcjoEOj+FLpEoJAKLC2nxr+fAktGCyO+T9J7P+JYqCFJ
         B6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730221996; x=1730826796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ISkj2Ba2iXJsNtvKhhww/fpbPtoqWwWm4yhMQ09Pkc=;
        b=vstznXNCbhNBSdNbxBH8pkIogNn+mDldtYFtgKCu9jR75YjNgslzetg6b+DL54CrBQ
         XnRftTh2NEdeV6vV5t2NOtAWzHc1+E/RKDCoRbh/mCIW+hTT/d8glcqOPbVH1UJ+I+lY
         jxrg5Ggv7BSQVlU/C+1KJckbqCBP3IYpyh0nnajP6M3vEgCpTs8TMxm6nqnsy5I1nXqW
         IJiQRShWYD7MB6ZB+BTIGjooBPUJ8HYpSGwxQCRcbWfv4d29J+4J5IwQOKrhy+TCewzR
         3XY0XWfFkHsPtv+dtuBl3/KMzJBIQc2PnB4mEMaRd1mvzr1bHWs9hhdQBQ8af1jYQPoa
         1VIA==
X-Forwarded-Encrypted: i=1; AJvYcCV+lSEl/3zR+bXkrVJTbRIVCOUly1pTwtCE8T2EQ7CcxrMdQz7ZSeocinhaxNx9j2NBdhcggYK/Pp5bq2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaDbqsfjb8as9VbnUexJGLAELshietM+nbrT214JGcBuOZLwj0
	zrUE4yYxAEllDR+spl5bPWwGyEsIvEqfgMR5BU8oYB9Pxcu4ieuWBN3HKqnFwOzwumTABl+682P
	e1na8+8RhtLCbTfv6PO0dvPXXBjo=
X-Google-Smtp-Source: AGHT+IFlYMr8oYy4eG6HH7R9vBgmgqNRSfIBoEQANg/2xkCVcwl67p0jEeFJ3FRp7rqggl/4qMNXfDF2TBQ5uT1l0j4=
X-Received: by 2002:a05:6a00:1ace:b0:71e:4842:55fe with SMTP id
 d2e1a72fcca58-720630065d6mr7821756b3a.4.1730221995539; Tue, 29 Oct 2024
 10:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027140537.503264-1-prosunofficial@gmail.com>
 <CADnq5_M4QwRfROybHrQfNuiXNhHH7VFAUVZMWkriwZs7K4KLUQ@mail.gmail.com> <3d38112f-9235-4643-ae2c-ffb9fae7a5d2@gmail.com>
In-Reply-To: <3d38112f-9235-4643-ae2c-ffb9fae7a5d2@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Oct 2024 13:13:04 -0400
Message-ID: <CADnq5_N5ZpWSR5OGAqUu2HnySAhouUqWa36fATcv+oy7oHxdkA@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/amdgpu: use string choice helpers
To: R Sundar <prosunofficial@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, tao.zhou1@amd.com, kevinyang.wang@amd.com, 
	Hawking.Zhang@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	luben.tuikov@amd.com, kernel test robot <lkp@intel.com>, Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 1:05=E2=80=AFPM R Sundar <prosunofficial@gmail.com>=
 wrote:
>
> On 29/10/24 19:11, Alex Deucher wrote:
> > On Sun, Oct 27, 2024 at 10:18=E2=80=AFAM R Sundar <prosunofficial@gmail=
.com> wrote:
> >>
> >> Use string choice helpers for better readability.
> >
> > I personally find this less readable, but if this is the preferred
> > method going forward, I'm fine to take the patch.
> >
> > Alex
> >
>
> Hi,
>
> Thanks for the comments.
>
> I came across this comments in string_choices.h files, where
> str_read_write() helpers are present.
>
> Using these helpers offers the following benefits:
>
>   1) Reducing the hardcoding of strings, which makes the code more
> elegant through these simple literal-meaning helpers.
>
>   2) Unifying the output, which prevents the same string from being
> printed in various forms, such as enable/disable, enabled/disabled,
> en/dis.
>   3) Deduping by the linker, which results in a smaller binary file.
>

Thanks.  I've applied it.

Alex

> Kindly, I'm leaving the decision to maintainers.
>
> Thanks,
> Sundar
>
> >>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> >> Closes: https://lore.kernel.org/r/202410161814.I6p2Nnux-lkp@intel.com/
> >> Signed-off-by: R Sundar <prosunofficial@gmail.com>
> >> ---
> >>
> >> reported in linux repository.
> >>
> >> tree:  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> >>
> >> cocci warnings: (new ones prefixed by >>)
> >>>> drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c:145:8-12: opportunity for=
 str_read_write(read)
> >>
> >> vim +145 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> >>
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_eeprom.c
> >> index 35fee3e8cde2..8cd69836dd99 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> >> @@ -200,7 +200,7 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter *=
i2c_adap, u32 eeprom_addr,
> >>                  dev_err_ratelimited(&i2c_adap->dev,
> >>                                      "maddr:0x%04X size:0x%02X:quirk m=
ax_%s_len must be > %d",
> >>                                      eeprom_addr, buf_size,
> >> -                                   read ? "read" : "write", EEPROM_OF=
FSET_SIZE);
> >> +                                   str_read_write(read), EEPROM_OFFSE=
T_SIZE);
> >>                  return -EINVAL;
> >>          }
> >>
> >> --
> >> 2.34.1
> >>
>

