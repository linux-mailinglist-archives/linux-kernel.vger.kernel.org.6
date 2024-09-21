Return-Path: <linux-kernel+bounces-334748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1817597DBA2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 06:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D514B282D73
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 04:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65B179BD;
	Sat, 21 Sep 2024 04:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke/bRvS4"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC72CA2
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 04:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726892767; cv=none; b=C3/LRoP843ZI2647g1r/VZiPiG5w52XQKxYLyXZZi3BEvK6uSM7aUUKpJqcUADczOn4p6+OaMllr2IX5m6QaU4gFyIQ5jP/F91zF3TkdhgASfQUFdk6BnnsHwv0olStHhvSRUHZKdB62W84W5xtlXuflGEjxqYDTx8gMftq25EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726892767; c=relaxed/simple;
	bh=Bk+b72hWqsDyIvzJohRfFqhnQFZWW28CKjQpZ31TP0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAGhutmN+DKNag5Q47j9yRkJCU1fma+f8HCiBjWq9CHim4D7Dm60Td5qQykCa45hslkIdanTbCwCYfRcbuwi1HVyTebZ/QHbEIhGWoshYjB9z2EIytzbPYR8bqWgmVamRWM/OXxGBwzfv12dWmOaH6QdXigRA6Z4A9jOUk53jwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ke/bRvS4; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5011af33774so879193e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 21:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726892765; x=1727497565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dB6Zo0YpdRHWofuC2qdabJVVvwBxgLbN85YWc73d7aY=;
        b=Ke/bRvS4fQqGf6KwFZEPBbNZjW7eCqcpOY8sDcC5tR+Zjkun99NbyMWdBvIf52dTL7
         UkzDLe60c7sz/WMFgeZRlki2tce0E3HfZfaNkZHPdvBFhFVjJVBt7pZ9v2U1iA7jbsvR
         jsM8gLlCabU3XkJfDD7TDCfryO6PU1jMXE73QQar60OUJM+qtOVexvFft1Wy9nDrB+Gq
         jTrpBj0Kg1+291QeV9RMYKKr+AjwKZxlDh+YDtvlnxtiEjpXlcBQCQTQjn30wmMDG/uQ
         QAc8biFlbNvcNs9hg/WX9kgf5WgfUrqGWZRFAomR4CSsGQSrJ1IDWIRFoI6y0abpToeM
         5NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726892765; x=1727497565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dB6Zo0YpdRHWofuC2qdabJVVvwBxgLbN85YWc73d7aY=;
        b=N9v7t+oo/j8hMNtubhchnQn/fgNwH1CTEFMNI94n8vvJQg5Um1iRxiUtKpIqfHFYOm
         JJsjghUUE4cL47kONJ+afHnC6Ihypfg7jeg5hkdxzHkTDXrXvisrCi2g2UPGkEZozG33
         NyCMhUPkaQoV05Qh5sd9yX1/0njKb8D4dHTWp1rYm5DGKm74zwO5wbNbnw/BkyhnXMd4
         i2lgELfr2yUAucHyuVwQU8HGdbx0EaKCAcqXtbrw6Ga4aovg8yXBKdyr8G8QGZBBZFrf
         UDp2rAT2jTpEdYzyBra6DwXhUAc/YXNylTZ9qKXUTIbuI3mR6isE7wm7sqpkuKLECE3c
         S4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUvzeX3SgWSccUNc30Eu9tRFqJREIw/ZbXCdJgTUuvcSpRfdUkvRj499rsTzn7sY4Ah3DunwxKhH4mZ/XI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Ica7W116weUrkbA23N0CAZsscf0dJFHCCxE/mKI2+JX0MFgg
	OcWdOxArXvEnox4ik5wtE+4qmn54ux8bSaF3nMea+04xfKvYR+biqPA7j9/QJ26pygJMp0XX04g
	ZhTxq0CM3VsLA1hlcGTRhk8kl919PxztbqY0=
X-Google-Smtp-Source: AGHT+IE+M0wXVkx1o8/hbYFnA8ugAtdyDuWOvZYYM4vokGOVWCl0bNvvui3kLaZxw7PDt1aUj47fV6hcH4VEztV2rgI=
X-Received: by 2002:a05:6122:891:b0:4f6:b094:80aa with SMTP id
 71dfb90a1353d-503e418c86dmr3592219e0c.9.1726892765089; Fri, 20 Sep 2024
 21:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920090959.30755-1-kdipendra88@gmail.com> <ac13994c-b77b-48f2-b2cf-20299f02c2e8@amd.com>
 <CAEKBCKMg0c5AW7YggDMR+Kg7OGq3dXApLK-=RTR71H0KHO73+g@mail.gmail.com> <ae062c07-dc09-4975-ad31-2f9d9ea435f9@amd.com>
In-Reply-To: <ae062c07-dc09-4975-ad31-2f9d9ea435f9@amd.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Sat, 21 Sep 2024 10:10:54 +0545
Message-ID: <CAEKBCKMNZOof8KP5upY45djTC9Bk9+AFHZyZVoid2eevTtjykA@mail.gmail.com>
Subject: Re: [PATCH] Staging: drivers/gpu/drm/amd/amdgpu: Fix null pointer
 deference in amdkfd_fence_get_timeline_name
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Sept 2024 at 00:43, Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 20.09.24 um 18:31 schrieb Dipendra Khadka:
> > On Fri, 20 Sept 2024 at 16:01, Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
> >> Am 20.09.24 um 11:09 schrieb Dipendra Khadka:
> >>> '''
> >>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:108:9: error: Null p=
ointer dereference: fence [nullPointer]
> >>>    return fence->timeline_name;
> >>>           ^
> >>> '''
> >>>
> >>> The method to_amdgpu_amdkfd_fence can return NULL incase of empty f
> >>> or f->ops !=3D &amdkfd_fence_ops.Hence, check has been added .
> >>> If fence is null , then null is returned.
> >> Well NAK, completely nonsense. Calling the function with a NULL fence =
is
> >> illegal.
> > Thanks for enlightening me .
>
> Well sorry to be so direct, but what the heck did you tried to do here?
>

Hi Christian,

cppcheck reported null pointer dereference in the line  " return
fence->timeline_name;" in the function "static const char
*amdkfd_fence_get_timeline_name(struct dma_fence *f)".
In the function , we are getting the value of fence like this :
"struct amdgpu_amdkfd_fence *fence =3D to_amdgpu_amdkfd_fence(f);"

When I went through the function " to_amdgpu_amdkfd_fence" whose definition=
 is :
'''
struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
{
struct amdgpu_amdkfd_fence *fence;

if (!f)
return NULL;

fence =3D container_of(f, struct amdgpu_amdkfd_fence, base);
if (f->ops =3D=3D &amdkfd_fence_ops)
return fence;

return NULL;
}
'''

Here, the function to_amdgpu_amdkfd_fence can return NULL when f is
empty or f->ops !=3D &amdkfd_fence_ops .So the fence in function
"amdkfd_fence_get_timeline_name" can be NULL.
Hence , I thought dereferencing NULL fence like "return
fence->timeline_name" may result in the runtime crashing. So, I
proposed this fix. Sorry, I was not aware about the behaviour of the
fence.
I am interested in the development and tried to fix this .

> I mean that is broken on so many different levels that I can't
> understand why somebody is suggesting something like that.
>
> Regards,
> Christian.
>
> >
> >> Regards,
> >> Christian.
> >>
> >>> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> >>> index 1ef758ac5076..2313babcc944 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> >>> @@ -105,6 +105,9 @@ static const char *amdkfd_fence_get_timeline_name=
(struct dma_fence *f)
> >>>    {
> >>>        struct amdgpu_amdkfd_fence *fence =3D to_amdgpu_amdkfd_fence(f=
);
> >>>
> >>> +     if (!fence)
> >>> +             return NULL;
> >>> +
> >>>        return fence->timeline_name;
> >>>    }
> >>>
> > Regards,
> > Dipendra Khadka
>

Regards,
Dipendra Khadka

