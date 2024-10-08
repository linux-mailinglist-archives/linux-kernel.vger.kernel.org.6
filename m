Return-Path: <linux-kernel+bounces-354448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38451993D92
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE6C283D3F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF0842AB7;
	Tue,  8 Oct 2024 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMmDekQh"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911BD208B8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 03:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358705; cv=none; b=KNW0aO80YuHOeCQbCo39EtCnySYBFxUYOXqG5PB4l/lv+sRfSUHj++zeBK38hdIx0cBk9dm0BdQ8qcHsduFbY8nu93oEJZfVD6HMDLDzK+AjcxHchFr26m//4RczMKdCBDqMD8N8AbuIJEou/Dc1AB/IABw7SQx2fGehpbDsCCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358705; c=relaxed/simple;
	bh=QVVPRAf9XxE+kZRsSs08SpHtx4ei68iRUGJIOF/Vxjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPe3i5tbt66jdceo0h9oug2lgZvJBKnzN5uM91pnDNgYPRnYIdFjOirw95NqTAxfSmVguBtA8JuhQ13Poe8C6lyZx55heos1gN6CrfFQcLKON8CfUdtOdOdONOe55PUBOG5eogcq5ETAVlN700dJrpsUg4yu7BV53XqZ7lyBg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMmDekQh; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398e53ca28so5677110e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 20:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728358701; x=1728963501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjQV5PG9znaGBrtaMHn3b/2H4No4n9NWv2MWFM/8u1s=;
        b=LMmDekQhFqh1o+qZ54o7SqFdiCgP2fpaw2XFV8MG0ywocJg6dm3seorhzpVL0aneWu
         QuJpBx6ZaccYIrCN69Qxp54gjcJGpi3+9aaHxM4Wi7cCdsDSyriTI7O6gCot+zoyqWJl
         DiG9PLIOXI6HmboCRon4YhfHd5GWzasT4LkfZ0wSZZOMCUJW/WsrZ1j5eXd3e5qlqnzy
         T+9v4bHSpMN2dbssv28ozkL6sVfmfUbwHdefyfHJ/U6jo7em/iVNM9AX+ZMdsgjvFJPB
         JAjBsQmgPZRQS0sCCPssMxSbe3rdZdRCrS4z4tfz4KG4Y7ax5agAdalipKQsJvVgg2Pn
         hP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728358701; x=1728963501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjQV5PG9znaGBrtaMHn3b/2H4No4n9NWv2MWFM/8u1s=;
        b=VweySJhpYI/lTBQYpk+TL5Y+XMbPPMFN5+gacXLkVi+04tmVM5R9ZKAOz1e6dGVZoH
         7HFC1y9w2qp6SBRelSljDLJnlPBM1OVXuqfPlpQ+3QgZy4nRsGFG+AmDoskKzt6tzd3M
         XbqLpVy2NqNXaIYb5kL5d0MrES6XDx6ibzunvQvwkkhGzIzLhMVx66PnLoXY0b7LWLT7
         IZUKwYe0h8JWtwUfvXaFlP7nbRVKB3pWgU8wyXEA2JcsaKnNu5ZB6IykeVXxaX1wbZq5
         RHYJuQPhEMrP1JYEkbaZ7aQzhr5WnxeerQW7e5bH8sATM2ZKVvLpiDUlTtMk/91YWMww
         Elyw==
X-Forwarded-Encrypted: i=1; AJvYcCXIGg76yJwRdTCo7wmkiNAAt4c1elAMnErCjYX1vGSGeC6Xi4oryxTM5A1VimTyla9UM1DgLY+dyvLe18M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsyl36H5UvS7+bwttjg7xWsDalGdRnxa8ct4xmznCX0y7TqRMk
	5AvzV2Rn0h10vK+HkQNGGEtQPY4Em2OIj+VSFmMgyfENMTTMbUytbsUD6iZxxospZeQA/OEguLP
	U5S88PDTd+P7kRCQV7FZUoBZvD8s=
X-Google-Smtp-Source: AGHT+IFsZc1EpKPyldw9Pj60xnYfN/hd9IMOfZUali0NPVvTUoiF3RRl1v9EkanLhvx67ubudnp/8MkDuZJuHGTtcME=
X-Received: by 2002:a05:6512:3b13:b0:536:550e:7804 with SMTP id
 2adb3069b0e04-539ab876df9mr7312477e87.18.1728358701155; Mon, 07 Oct 2024
 20:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004081618.27599-1-advaitdhamorikar@gmail.com>
 <00761132-75f3-41fd-b571-30b0cbe5565d@amd.com> <CADnq5_OKww1YZ1R_OytEMLcNVwdq=-ckc2gqQ+WMyOv6AZ9kqg@mail.gmail.com>
 <007679b9-b7b6-4385-9a2e-2be392cb5f58@amd.com> <CAJ7bepLv3Z9RwuxoBS3SfkMjeBkN1LRTjLEjT8Lv4Jdu-CXb6Q@mail.gmail.com>
 <82c60f1b-a52a-4bc7-a635-06198dba0e13@gmail.com>
In-Reply-To: <82c60f1b-a52a-4bc7-a635-06198dba0e13@gmail.com>
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Date: Tue, 8 Oct 2024 09:08:09 +0530
Message-ID: <CAJ7bepJrm9tJJMSZXz0B_94y8817X4oFpwnrTmUHeagOFgVL7g@mail.gmail.com>
Subject: Re: [PATCH-next] Fix unintentional integer overflow
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: "Sundararaju, Sathishkumar" <sasundar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, alexander.deucher@amd.com, 
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, leo.liu@amd.com, sathishkumar.sundararaju@amd.com, 
	saleemkhan.jamadar@amd.com, Veerabadhran.Gopalakrishnan@amd.com, 
	sonny.jiang@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com, 
	"Lazar, Lijo" <lijo.lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

I am not sure if I correctly understood what you meant,  just to clarify

When you say this
>No, all of this are numerical problems where not taken into account the
>size of the destination type.

>Saying that all of that are basically just style cleanups which doesn't
>need to be back-ported in any way, so please drop the Fixes: tag.

>And you should probably change the subject line to something like
>"drm/amdgpu: cleanup shift coding style".

Are you just talking about this message?
>> There are a few instances where we can use 1U instead of int as
>> harvest_config uses unsigned int
>>(adev->jpeg.harvest_config & (1 << i)
>> However I think they should be fixed in a separate patch?

Or is it intended for the complete previous "Fix unintentional
overflow" patch as well?
And I should just send a v3 with the two changes?

Thanks and regards,
Advait

On Mon, 7 Oct 2024 at 19:26, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 05.10.24 um 09:05 schrieb Advait Dhamorikar:
> > Hi Sathish,
> >
> >> Please collate the changes together with Lijo's suggestion as well,
> >> "1ULL <<" instead of typecast, there are 3 occurrences of the error in
> >> f0b19b84d391.
> > I could only observe two instances of this error in f0b19b84d391 at:
> > 'mask =3D (1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings))=
 - 1;`
> > and `mask |=3D 1 << ((i * adev->jpeg.num_jpeg_rings) + j);`
> >
> > There are a few instances where we can use 1U instead of int as
> > harvest_config uses unsigned int
> > (adev->jpeg.harvest_config & (1 << i)
> > However I think they should be fixed in a separate patch?
>
> No, all of this are numerical problems where not taken into account the
> size of the destination type.
>
> Saying that all of that are basically just style cleanups which doesn't
> need to be back-ported in any way, so please drop the Fixes: tag.
>
> And you should probably change the subject line to something like
> "drm/amdgpu: cleanup shift coding style".
>
> Regards,
> Christian.
>
> >
> > Thanks and regards,
> > Advait
> >
> > On Sat, 5 Oct 2024 at 09:05, Sundararaju, Sathishkumar <sasundar@amd.co=
m> wrote:
> >>
> >>
> >> On 10/4/2024 11:30 PM, Alex Deucher wrote:
> >>> On Fri, Oct 4, 2024 at 5:15=E2=80=AFAM Sundararaju, Sathishkumar
> >>> <sasundar@amd.com> wrote:
> >>>> All occurrences of this error fix should have been together in a sin=
gle patch both in _get and _set callbacks corresponding to f0b19b84d391, pl=
ease avoid separate patch for each occurrence.
> >>>>
> >>>> Sorry Alex, I missed to note this yesterday.
> >>> I've dropped the patch.  Please pick it up once it's fixed up appropr=
iately.
> >> Thanks Alex.
> >>
> >> Hi Advait,
> >> Please collate the changes together with Lijo's suggestion as well,
> >> "1ULL <<" instead of typecast, there are 3 occurrences of the error in
> >> f0b19b84d391.
> >>
> >> Regards,
> >> Sathish
> >>> Thanks,
> >>>
> >>> Alex
> >>>
> >>>> Regards,
> >>>> Sathish
> >>>>
> >>>>
> >>>> On 10/4/2024 1:46 PM, Advait Dhamorikar wrote:
> >>>>
> >>>> Fix shift-count-overflow when creating mask.
> >>>> The expression's value may not be what the
> >>>> programmer intended, because the expression is
> >>>> evaluated using a narrower integer type.
> >>>>
> >>>> Fixes: f0b19b84d391 ("drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs=
")
> >>>> Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_jpeg.c
> >>>> index 95e2796919fc..7df402c45f40 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> >>>> @@ -388,7 +388,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_get(vo=
id *data, u64 *val)
> >>>>     for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> >>>>     ring =3D &adev->jpeg.inst[i].ring_dec[j];
> >>>>     if (ring->sched.ready)
> >>>> - mask |=3D 1 << ((i * adev->jpeg.num_jpeg_rings) + j);
> >>>> + mask |=3D (u64)1 << ((i * adev->jpeg.num_jpeg_rings) + j);
> >>>>     }
> >>>>     }
> >>>>     *val =3D mask;
>

