Return-Path: <linux-kernel+bounces-575516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAACEA70390
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9C81899E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3129325A2B2;
	Tue, 25 Mar 2025 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y09QKFn/"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80D2571A7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912413; cv=none; b=KagWONeje69z5D+0vUJo1gHjjaH1iVM7d2540X0eK0O17OmylfYCd+m3eAoYWlGYTkD6wwONEKagehaQfEwGu1vm8mLolAq1gIhmED13sDmbq5CCiYffP6yG5TGKkNbQ7O79L15RV6J21LI2HTsSFcjw2hP39k5900+lm047z2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912413; c=relaxed/simple;
	bh=TOpjA7jpbG6If//PTh5k3PFBfbMxxOiOsJHPkDgO9lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXs9n0HxEMa+AeTOjjQjC0clF/5+nhiRSpUABdkT8PzyCvO+kmicEK+/ztSPQV+Ank6qHPR8dMvXt8VVaf4f04jjFiefLUJ7jqcY+dU9xaqbS8JAI98wwpfIn9iSORVVPvyBQg5NLp/08QqwpQIcP+qLpIcgDWLOxinFKgMx28o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y09QKFn/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff62f9b6e4so1729801a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742912411; x=1743517211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4L7vtbekxau+N8vnTb0gwa/BBAesYIKpvGqtJoUimg=;
        b=Y09QKFn//HzLsdYQJ6wxVZ3+XCVCF2zabvB9eRBVbO0a+RX/Pd70il96Sb+tsSfOUD
         uDBquokHr7qYLE3HSNSrjyXk4o2zJUUzDQd6UhXZ6Y/naEm9JMeJwOjF9PE1/YWErI0k
         b67q5RJFBWrj1Vxkl+2vrL6mak1QEMt6JlY0FUqndxHGhIKj4OClBL242zy6bAc45roP
         Gq7watuZQ16pn3/x8JwFrC4gKjknOSOHE/eI7+amrHVZJJqLdcjrQDpVdx2kfe4XBK5F
         rjF7H2p58B6lEeWH8X9z1pWC1yDDhAMGjbPxGHtJMVWhIqMQSxtRAE9TdXzdZgih7Q4h
         gufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742912411; x=1743517211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4L7vtbekxau+N8vnTb0gwa/BBAesYIKpvGqtJoUimg=;
        b=nI+VWULKuyW/jGoNIDJwGoDsrCxa8RJXreizcmTC1TbQjMZSdM8apyw5E4TXTMTMxT
         +M/Vr13+Zxv/N6E33V3511Dn6uYKDobVORO07yycmIDbg5Sqn/0xVEedwxcA1OF8y++y
         qfGuVaZTVP3AyFBLLZICqtwltz9jQDtKLP0teSOTA+mdFNNXOtK6iEr7q7GWFuI22isI
         kYwuhpAqw++0OtH5iuNnXQN1+PtvAkmfTqliwZFFcM4Z+7aH7N1332//dYTRMrYlOw67
         +s7MZrI6GrzoHMDqjV3gddCgrKSH0a30J6X+I6Kx6vlxMPePCxJPAVJiBb5dZoADyoEM
         FCDg==
X-Forwarded-Encrypted: i=1; AJvYcCVgosix97EKfFU+FLfIdAJ9I77AWWSpk1RalLdn/SxQJ49k4a5gnZqd+K4Q7r0odOqVrzT2hJVb1TD3rq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpryKHtyvW6dF/39FAIwI45rgo5FqvGN6MoMbR6COjH6e5t+9O
	WeK+dV6je0wykda+1qtB+YbxZ5OUjCmJbMKZ99GH1aXSUbqyjx///XOCcV/Eqscq0ZF3Gr9lMKn
	2nVFw1dBHD31xeJOOmNtg8vFS++w=
X-Gm-Gg: ASbGncsudIB0JOONhpQKHTxVvZyzEQrcG/QHwgoM8RRsZnXmxXW4b7zSrKp++NDPr5X
	3HnNhbeXu6gaSmCUFEMdgv/gFGjn224bM/x1T9qaqjaAgGj/0aDxCIEs4GsvxiZ1HN1bw4ENrZb
	rKWbAeDro1Rh7TP+bHPeQL7Hp7xw==
X-Google-Smtp-Source: AGHT+IHAolY+Get/kJBAAF50KlItDOfMAbpeBYkYfFsflb7rqe6tkJSn71jeSSxBNSv3ybme1lRgYtjxQaXjP5DQFqs=
X-Received: by 2002:a17:90b:17c5:b0:2ff:4a6d:b359 with SMTP id
 98e67ed59e1d1-3030ff14660mr8976662a91.7.1742912411258; Tue, 25 Mar 2025
 07:20:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325014912.23911-1-srikarananta01@gmail.com>
In-Reply-To: <20250325014912.23911-1-srikarananta01@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Mar 2025 10:19:59 -0400
X-Gm-Features: AQ5f1Jpvm1BjO8DicOpLFH6O-0g58f9oKH-Qp-1OSpOcFPScESTJDPRJR3nUcy8
Message-ID: <CADnq5_N9skrjQHEq5QP9c=7dad7HeSP7FaoTQFEg92dGdnJLtg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix typo
To: AnantaSrikar <srikarananta01@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, Jack.Xiao@amd.com, sunil.khatri@amd.com, 
	Hawking.Zhang@amd.com, shaoyun.liu@amd.com, Jiadong.Zhu@amd.com, 
	chongli2@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Tue, Mar 25, 2025 at 4:14=E2=80=AFAM AnantaSrikar <srikarananta01@gmail.=
com> wrote:
>
> From: Ananta Srikar <srikarananta01@gmail.com>
>
> Fixes a typo in the word "version" in an error message.
>
> Signed-off-by: Ananta Srikar <srikarananta01@gmail.com>
>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index f9a4d08eef92..fccf6e255b82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -646,7 +646,7 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>                 break;
>         case MES_MISC_OP_CHANGE_CONFIG:
>                 if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MA=
SK) < 0x63) {
> -                       dev_err(mes->adev->dev, "MES FW versoin must be l=
arger than 0x63 to support limit single process feature.\n");
> +                       dev_err(mes->adev->dev, "MES FW version must be l=
arger than 0x63 to support limit single process feature.\n");
>                         return -EINVAL;
>                 }
>                 misc_pkt.opcode =3D MESAPI_MISC__CHANGE_CONFIG;
> --
> 2.49.0
>

