Return-Path: <linux-kernel+bounces-336131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67AA97EF89
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88205281A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B5119F104;
	Mon, 23 Sep 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beekrT/J"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EFE19F433
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110144; cv=none; b=P8PksAWSPhcZFQk02EaZGUOHhFAgw5E4GWyK8A7raJUxIwcAd30uNnBHPcOIP7bhkM4DHIxVsbWzVv4cE5cRy+YOS73F/rGYf3FmuLVHhh0rs4kNYGxHXDtq6fa4vzrmJ0mO5iBWpiXv+guMT0pxDLWvnfs2MzvKYgtU2vtc6Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110144; c=relaxed/simple;
	bh=3VEm3Eer4Ph2M52dUj1qiifOVDkqdCwNItOxo8C3J0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8mNINTiL6rJTVNDEiIKmsw44Zl5VetQNeHGBr2K5WU9SGdsQmZLfn0r4g1Wwhjq/jPmCqn2OJned6soUeFnuBxOPHM26CHbZmxaBH8oRCMkrdr8FOh7Iu4ty5ETsvF0lgyjJzqaNmS1oRatTf8LBu2YNBjoIt4SD5M2O9AewGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beekrT/J; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-502b144f31bso1489786e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727110141; x=1727714941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP6mNa85r1fBTtVt4nmY2vTm3vDUYC2Hz0xY4IpddhM=;
        b=beekrT/JlpKsmD+RbrSeVE/rS/hwN5XP5hu5jF6dQX+1G8zLNUAh7PAcdVIyiCflTN
         r8B9vceoiiSSl8ct1OScQSsc288XoRSAYMcteOEoMNj3RykV2hkUQN51hVv/lyZM5vjV
         4Tv7xSPXxLEXb8yh+5N04hh6D6NMFaeJ7YgpkcHR1w7gB7IRut7D/+pSboGIRXDNr1Hy
         zyej6WWS571SojxA5U9qAZxUubGF6abyzJawSgQWqoDxHBi8xh2kq4UNocjig0OWsPee
         uyqRwE1INOHH0MBFOLt4RjZaAGNX9qdYMp91teGyTTG3bdUeYCxXcmd01Xco0f4Sa6kK
         o3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727110141; x=1727714941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bP6mNa85r1fBTtVt4nmY2vTm3vDUYC2Hz0xY4IpddhM=;
        b=bRmtcT5aKWENfv0ZRQt9MGVFNclaKpjGisDsD5DlxRpGYXbFL7gkU/xgMvvdkPHrmN
         I/GgrKa/fhrXDZWKtC3a6zKE5CuKioi5wVTk20DOORtv5g2L6FIh+bQyYlaWX34AC/M5
         f0uZILBxmuhES68mhgO3Km6mmyzWYuZalLcLQxnE5UK3N8Uv5ZGrw1/PrRIgt+mW6aNM
         5Z1gOAcM4Tuiv63uFIYOqBzdQj6vH95HTXWnCgz8IAhHP6BUvQafPkditaP5Z2Myodc1
         /nB/6lPi/EgkXXOqKYb/ZuCQXvFyt9Ow01QfH/mksOou+SWsQiMj4l+xRr5P4cctHlhH
         g2eA==
X-Forwarded-Encrypted: i=1; AJvYcCWj5cPOU6owphp1sQ2QDIGKkMDoVVwjZ0Vz5ZtTaoDljkCwCWZzUGt2zNGb8B8ay2zNWuPm7UgpJPtevCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq16m6S11Ua+rEvqfDT7RAF0eu+DZD0lUwncjymT7OH6mlruuX
	qhTWLlxqw+0+C09bGRStJ1/qRpQRG9JutErimHNfmYaM7VzaUj3s1DDC3XmN7IZkSUXNp+7pTPE
	YVcvTBqiFn0PqrsZzbkn2M7U9GwRU71Uv
X-Google-Smtp-Source: AGHT+IFNbT1NF2ZQcW+60PCG7onE1QaUl53pcxG7e0IIKdZvJGsmqe0pqk5Ntqlfn++uEdKuwK2FU8cMfzHHbzHmNkg=
X-Received: by 2002:a05:6122:891:b0:4f6:b094:80aa with SMTP id
 71dfb90a1353d-503e418c86dmr7471693e0c.9.1727110141412; Mon, 23 Sep 2024
 09:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920090959.30755-1-kdipendra88@gmail.com> <ac13994c-b77b-48f2-b2cf-20299f02c2e8@amd.com>
 <CAEKBCKMg0c5AW7YggDMR+Kg7OGq3dXApLK-=RTR71H0KHO73+g@mail.gmail.com>
 <ae062c07-dc09-4975-ad31-2f9d9ea435f9@amd.com> <CAEKBCKMNZOof8KP5upY45djTC9Bk9+AFHZyZVoid2eevTtjykA@mail.gmail.com>
 <17eb00ef-f3db-4d42-a3fd-cbe6813075e5@amd.com>
In-Reply-To: <17eb00ef-f3db-4d42-a3fd-cbe6813075e5@amd.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Mon, 23 Sep 2024 22:33:49 +0545
Message-ID: <CAEKBCKNesZRZx-PafM5+dfuLSgOQb7_0h5DvTT+YcfBmvj1ovQ@mail.gmail.com>
Subject: Re: [PATCH] Staging: drivers/gpu/drm/amd/amdgpu: Fix null pointer
 deference in amdkfd_fence_get_timeline_name
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Mon, 23 Sept 2024 at 18:57, Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 21.09.24 um 06:25 schrieb Dipendra Khadka:
> > On Sat, 21 Sept 2024 at 00:43, Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
> >> Am 20.09.24 um 18:31 schrieb Dipendra Khadka:
> >>> On Fri, 20 Sept 2024 at 16:01, Christian K=C3=B6nig <christian.koenig=
@amd.com> wrote:
> >>>> Am 20.09.24 um 11:09 schrieb Dipendra Khadka:
> >>>>> '''
> >>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:108:9: error: Null=
 pointer dereference: fence [nullPointer]
> >>>>>     return fence->timeline_name;
> >>>>>            ^
> >>>>> '''
> >>>>>
> >>>>> The method to_amdgpu_amdkfd_fence can return NULL incase of empty f
> >>>>> or f->ops !=3D &amdkfd_fence_ops.Hence, check has been added .
> >>>>> If fence is null , then null is returned.
> >>>> Well NAK, completely nonsense. Calling the function with a NULL fenc=
e is
> >>>> illegal.
> >>> Thanks for enlightening me .
> >> Well sorry to be so direct, but what the heck did you tried to do here=
?
> >>
> > Hi Christian,
> >
> > cppcheck reported null pointer dereference in the line  " return
> > fence->timeline_name;" in the function "static const char
> > *amdkfd_fence_get_timeline_name(struct dma_fence *f)".
> > In the function , we are getting the value of fence like this :
> > "struct amdgpu_amdkfd_fence *fence =3D to_amdgpu_amdkfd_fence(f);"
> >
> > When I went through the function " to_amdgpu_amdkfd_fence" whose defini=
tion is :
> > '''
> > struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
> > {
> > struct amdgpu_amdkfd_fence *fence;
> >
> > if (!f)
> > return NULL;
> >
> > fence =3D container_of(f, struct amdgpu_amdkfd_fence, base);
> > if (f->ops =3D=3D &amdkfd_fence_ops)
> > return fence;
> >
> > return NULL;
> > }
> > '''
> >
> > Here, the function to_amdgpu_amdkfd_fence can return NULL when f is
> > empty or f->ops !=3D &amdkfd_fence_ops .So the fence in function
> > "amdkfd_fence_get_timeline_name" can be NULL.
> > Hence , I thought dereferencing NULL fence like "return
> > fence->timeline_name" may result in the runtime crashing. So, I
> > proposed this fix. Sorry, I was not aware about the behaviour of the
> > fence.
> > I am interested in the development and tried to fix this .
>
> Well it's in general a good idea that you looked into this, but you
> should have put more thoughts into it.
>
> That the fence can't be NULL is just implicit when you take a closer
> look at the code.
>
> amdkfd_fence_get_timeline_name() is only called through the pointer in
> amdkfd_fence_ops. This makes the condition "f->ops =3D=3D &amdkfd_fence_o=
ps"
> always true inside the function.
>

I am learning driver development and was not sure how it works. Now, I got =
it.

> The only other possibility is that the f parameter is NULL, but that in
> turn is impossible because the function is called like
> f->ops->get_timeline_name(f) and so the caller would have crashed even
> before entering the function.
>
> And finally you didn't looked at the documentation. The kerneldoc for
> get_timeline_name clearly states that the callback is mandatory and
> therefore can't return NULL.
>
> So to sum it up you suggested something which is not only unnecessary,
> but results in documented illegal behavior.
>
> The C language unfortunately doesn't have the necessary annotation
> possibilities that a function can't return a NULL string (at least as
> far as I know). So cppcheck can't know any of this.
>
> Please don't trust the automated tool to much and put a bit more time
> into patches like this.
>

Thank you so much for the insight and your time. I will make sure to
see the kernel doc as well as try to think more.

Best Regards,
Dipendra

> Regards,
> Christian.
>
> >
> >> I mean that is broken on so many different levels that I can't
> >> understand why somebody is suggesting something like that.
> >>
> >> Regards,
> >> Christian.
> >>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> >>>>> ---
> >>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 3 +++
> >>>>>     1 file changed, 3 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> >>>>> index 1ef758ac5076..2313babcc944 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> >>>>> @@ -105,6 +105,9 @@ static const char *amdkfd_fence_get_timeline_na=
me(struct dma_fence *f)
> >>>>>     {
> >>>>>         struct amdgpu_amdkfd_fence *fence =3D to_amdgpu_amdkfd_fenc=
e(f);
> >>>>>
> >>>>> +     if (!fence)
> >>>>> +             return NULL;
> >>>>> +
> >>>>>         return fence->timeline_name;
> >>>>>     }
> >>>>>
> >>> Regards,
> >>> Dipendra Khadka
> > Regards,
> > Dipendra Khadka
>

