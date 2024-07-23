Return-Path: <linux-kernel+bounces-259795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01574939D51
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE8C2833FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BC814D2A6;
	Tue, 23 Jul 2024 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EiwR8UAs"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3327513B2AF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726014; cv=none; b=SvZKz2rf0G5M0i0ydvEwMS9FXKhB7jC0mdHhq3PV87uknwXuDj2un28Hhk5j6t0XxxIprvLtK3StnDZURxgzDOE5478mxMBkkkRmr6zucN/4lDHPs3M0+1H5ItHKgCaKghdA+7EOL93b0Qz8kMxQ/NcH3NdBfM3oNnUaza6bRtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726014; c=relaxed/simple;
	bh=Umeiko+xkVHu2QDUnciYaVArEIkORregeZg9sT2rV+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3gsk71eQ/02Cn6JNXRr1CyWKsWV62Kat02IcbDkroJ+SLtZRyO3vCnKEzsv9LfJJ8WJ4bCoQxwlBJ8MkGDUbs7J2Qpy5eN0xi6Ixbd6MyTyiXPUf4BKd7XEweLQPE288dasIiQe4l6t/RivmblQCnOYHWpz1ksjyEMK9Wo6Yzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EiwR8UAs; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6694b50a937so44248547b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721726010; x=1722330810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G2TkTpA3pGGEMQVrSmpubkD3J5dcZcnfjtaZ+X4Iz5w=;
        b=EiwR8UAsyEEYuF3Mu2Sn90WzEECq6+vOmmUgBciWujsbcaU2v5onJUEBCb6EYY4E0a
         ldRvlG4esW8566b9ovKXoyzmVrxXJz7mFU1713LjhpVi2kuiy7qTPifo0cvshQhuitSP
         05d3PcscwiHMyVJYGV7kr8Y/AtlJbZw/BGwkzzwnGD5ewj36nfmOYVTe19gU6XGAanig
         +T8gTh4c1uqRA2MM12VsIIfy4L4P/Wo2vxowlb9M59ch/NdPI8Pfy/1vvnCqU0e4Je1L
         PV2B34NFgS8HI15wXF6sjvJs36Kq2w7bFE/daN3dTbjPTGuNLATLwv+0CR2WEXeL2/Kp
         0q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721726010; x=1722330810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2TkTpA3pGGEMQVrSmpubkD3J5dcZcnfjtaZ+X4Iz5w=;
        b=J9qjEg152m1cd9VLAq/50iO3oAEeIgI1G6BGBKNwxjfQ70SPhE1g+WsYRRb6hP1IcZ
         6P0TssjCp9LESIietcQiyP6WT4Gq0tZYbK6Ji684DU+KL6Ru1steBaX1SznqG80Ctbb7
         9Jkl61tFFDJsKuhWMl753AQh6T7BpDMpLwv52Zb6iOvP1Q3AxlIatw/m81ivKG9l6Gy7
         64dPjZLp4tpYBwvLRRGAjKWYSmKLVhLgaAzUfPFfvoc36psKd7Z/I2P9NIpRHghVpmVQ
         nZ3JcGHed5O/PCMlC8srzQKXh/2aDxgAf36f1v+N/r+OOhF7pxXvAz8b8qR7PkNf0AOI
         gUvA==
X-Forwarded-Encrypted: i=1; AJvYcCUF2rANeM9RTrXwLeYa///xI1IUCIKX4NAMelZG4+3l8khFiLbGhb5sbyuXj8DswF2dFiB68dRu6/ylCiJq3H0Vjf7Vqsosp8PSluTr
X-Gm-Message-State: AOJu0Yw5O0U4rZihm0PLAKcO/eQpbbuqwS81JX/+tGluYGbTgttpQVhp
	3ZkkakrNK96Zuazral9QNmMkm8jJnDbvYYRMK2frIZGuE7rmSRCYyLUcUinaRgo774FUVGsZYmJ
	DdUATvo8uYU2sAkdNgiYArN1Azp6P9zkOcyvrdw==
X-Google-Smtp-Source: AGHT+IEFyj21m/TdpHs/KSfSoW7V5VWMJIuVXvJvfA82UQX0au9dQs51sRr+TRBEGm0LSSW1B/6NWPvZ1qRsBhjfG/0=
X-Received: by 2002:a05:690c:428e:b0:630:f7c9:80d6 with SMTP id
 00721157ae682-66a69837c4cmr96640487b3.27.1721726010101; Tue, 23 Jul 2024
 02:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722080200.3530850-1-quic_ekangupt@quicinc.com>
 <20240722080200.3530850-2-quic_ekangupt@quicinc.com> <ydp5ntlresenovs6qaqt7wdaleuruubem5hajbfadkratfsiam@wjn33ymp4gyc>
 <63c52fd2-9f31-418b-8c6c-4c91f7c69fd3@quicinc.com>
In-Reply-To: <63c52fd2-9f31-418b-8c6c-4c91f7c69fd3@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jul 2024 12:13:18 +0300
Message-ID: <CAA8EJpqZ5pgA3D2PB57nAQkK+w7PdbQe1dgSTbFmTJbutu6N7Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] misc: fastrpc: Define a new initmem size for user PD
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, 
	linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, 
	dri-devel@lists.freedesktop.org, arnd@arndb.de, stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 07:35, Ekansh Gupta <quic_ekangupt@quicinc.com> wrote:
>
>
>
> On 7/22/2024 2:02 PM, Dmitry Baryshkov wrote:
> > On Mon, Jul 22, 2024 at 01:31:59PM GMT, Ekansh Gupta wrote:
> >> For user PD initialization, initmem is allocated and sent to DSP for
> >> initial memory requirements like shell loading. The size of this memory
> >> is decided based on the shell size that is passed by the user space.
> >> With the current implementation, a minimum of 2MB is always allocated
> >> for initmem even if the size passed by user is less than that. For this
> >> a MACRO is being used which is intended for shell size bound check.
> >> This minimum size of 2MB is not recommended as the PD will have very
> >> less memory for heap and will have to request HLOS again for memory.
> >> Define a new macro for initmem minimum length of 3MB.
> >>
> >> Fixes: d73f71c7c6ee ("misc: fastrpc: Add support for create remote init process")
> >> Cc: stable <stable@kernel.org>
> >> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> >> ---
> >>  drivers/misc/fastrpc.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> >> index a7a2bcedb37e..a3a5b745936e 100644
> >> --- a/drivers/misc/fastrpc.c
> >> +++ b/drivers/misc/fastrpc.c
> >> @@ -39,6 +39,7 @@
> >>  #define FASTRPC_DSP_UTILITIES_HANDLE        2
> >>  #define FASTRPC_CTXID_MASK (0xFF0)
> >>  #define INIT_FILELEN_MAX (2 * 1024 * 1024)
> >> +#define FASTRPC_INITLEN_MIN (3 * 1024 * 1024)
> > So, what is the difference between INIT_FILELEN_MAX and
> > FASTRPC_INITLEN_MIN?
>
> INIT_FILELEN_MAX is the maximum shell size that can be passed by user.
> FASTRPC_INITLEN_MIN is the minimum initmem length for PD.

At least this should be commented on in the source.

>
> >
> >>  #define INIT_FILE_NAMELEN_MAX (128)
> >>  #define FASTRPC_DEVICE_NAME "fastrpc"
> >>
> >> @@ -1410,7 +1411,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
> >>                      goto err;
> >>      }
> >>
> >> -    memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
> >> +    memlen = ALIGN(max(FASTRPC_INITLEN_MIN, (int)init.filelen * 4),
> > BTW: why is the code multiplying filelen by 4? Nothing in the source
> > code suggests that filelen is in u32 words, so I'd assume it's measured
> > in bytes.
>
> The passed filelen is actually the size of fastrpc shell. This size is not sufficient for the user
> PD initialization. The 4x of filelen gives the approx. needed memory for signed PD initialization.
> Yes, filelen is measured in bytes.

Ugh. Shouldn't it be sum(elf.ph[i].memsz) + some margin? I know this
is a separate topic, but since you were touching these lines it has
come to my attention.

>
> >
> >>                     1024 * 1024);
> >>      err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
> >>                              &imem);
> >> --
> >> 2.34.1
> >>
>


-- 
With best wishes
Dmitry

