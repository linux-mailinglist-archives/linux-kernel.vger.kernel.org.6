Return-Path: <linux-kernel+bounces-554511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9705EA598FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0B07A2885
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8940222A7FA;
	Mon, 10 Mar 2025 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B819Ue5c"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E32189B80;
	Mon, 10 Mar 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619031; cv=none; b=ImvPeEa1p5STlcCUm8L3oemYahuiIp/HdMn508esyVDEalCLPbCssVcafrQYnt86raW0OeKV8pF/J1StKxzgEz3Kiy5pXn19POosBBx/IzPgG+XMYHhI7fotmSiUmDbNvz2m5IyOUunq8oxp0KbFctHBMGUD1E5G9ZA0IYha8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619031; c=relaxed/simple;
	bh=4kBNkTbR5FLLbTabbHHu6HAsSSZd056FRwt9Fndw7O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kg6q+2OlCJFYOZ8uYFxWWKwvUw5N8/PfObkPqOQNKVxiug24B3ZFjxretMasdphOqGkioTLT9yb9HG9tyEWePossn+yDhtgOvBgZvToOKVawcTjvniSudwCwlfszFFYH4vuHKr8W2b10RoqM8WBQeOJ1QOKZiRT4fESV2py8WLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B819Ue5c; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f9b8ef4261so1175794a91.1;
        Mon, 10 Mar 2025 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741619030; x=1742223830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCZ7+q9PYpMdvI9LsnDStpXywHOjjRsLA5+sW6O9TXk=;
        b=B819Ue5cEe87zZcaJv+aim1P9CcxUlyNtoDZ+i8FZTb/p79Mq5qPzDxZzfhhaHcE/J
         XyXisRHNlqlf1QaGthVaEljASdaYtdzMzBoV1MQpyqxeIKngXbpwXmiV7kptjNMZ6quq
         L9FMieKxlhqEDtQgmd47Kteas6dKJA0oAwBLFBvmUIOKMU0/ScYznnI4/aTlZnP0uGwm
         GNyzGG8HqJtPQEGk2A2gy+z+8fJRNLi33zASiqWaQb1N3hi4/ujBPX4b7eGyfwsMpZVg
         Ta9XCn+GR/LEXJcHmGBP3Q1lpsDBiz9D/CwIM080PXMM11g5za/E3AO4xz/ZSNCQAls9
         q0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619030; x=1742223830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCZ7+q9PYpMdvI9LsnDStpXywHOjjRsLA5+sW6O9TXk=;
        b=MyY4IgH86J9rjRnaKd8WhD9TU/MH5iUOc59U5doqBtzwLpBUQGyzrQ8+L1C9XetJ2h
         YJ37eU6qFfZd+NFNIqnagcOhXPKRnDsxzlb9JEyhxmK9AfBQIdsZHJaX1PB7GRSXHseq
         j6DBrO0oyWpRqnOw1fgMT1dlqOTBdRbWn2WtG3yvI0FuCX96GmNXQ6PPmQ4O2/xrqMtd
         hm9a/ijWgn6f3ZrAG1XyA8oPkLe538R6SEK3QQah8w8NdsC368GWB02Ua+w41S8DbktO
         m1AsuiMaALSmFx4YdcfVo/RAfyaOE+Fv/XFNhHhgxynR6pjdXazQTT+Tp2j3IGIGhbdo
         hSRg==
X-Forwarded-Encrypted: i=1; AJvYcCUcSUlnyTfqFLu5IrfSGfWFVL2NsLAVziBR0Zednf7ODkamiVmGsr2esBsAkixwP5SY1zJ4OTFDchSvbx0b@vger.kernel.org, AJvYcCXyj+Qpy6dEhssXlDfRtj+sqMl0k67aYlE9slucJAABrMTw2UWg4yfpj5BoNjbClrU/e/yknWIWVjKd8Fu4ySk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxau1j/C9VtR6M2o3e8a+zcf1HcgTrxn5E6YbkyYMZ5K0E/GfqN
	8Fn38BnZ8wnsssRmQT2QJYJDg3sutcfQuqdGfORhGO2FvbZhEciAro/RCXaa4dSUOGNcLjyn8i6
	TM9WAWPgoFKBwNm49CpFVvnuarGs=
X-Gm-Gg: ASbGncuZ5b2oqX3bIPiHS+ApQ5LWDNCk6RODiSe7oJ/cYDnjVeV9KqZpL7rh25LvKIm
	hPIERDsahuSK+V7D5SywZ87fMm8gluRPzjZBXJNBtDUH5w0VtwH6BEcXdkjg/3lsH+QthfRqtM1
	PpH8knxpSN5EfGtNyohf34raWglg==
X-Google-Smtp-Source: AGHT+IFMUfkkxyv4DFg5N8sru2ilACJrDgnRxjOU1nRv0P7Z1KHYBcYqmTsNdwlU/vhI/3zGhCpvcSCgAR6M0BtdUvY=
X-Received: by 2002:a17:90b:4a4f:b0:2fe:b2ea:30f0 with SMTP id
 98e67ed59e1d1-300a575a10cmr5731794a91.4.1741619029744; Mon, 10 Mar 2025
 08:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2503b45f-751e-4b50-96fd-8dad33821c40@stanley.mountain>
In-Reply-To: <2503b45f-751e-4b50-96fd-8dad33821c40@stanley.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Mar 2025 11:03:38 -0400
X-Gm-Features: AQ5f1JpmwP1VV7tLkk-a9qxkXnTTzKMtdLoBQrX-kuLocNBhJ8LElGmugPOqQio
Message-ID: <CADnq5_NJnn0QxmsKMXnimRLDAkN7LD4u7sJOZq7OzSL54yrjUQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use tabs for indenting in amdgpu_sdma_reset_engine()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Hawking Zhang <Hawking.Zhang@amd.com>, Tim Huang <tim.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Likun Gao <Likun.Gao@amd.com>, Le Ma <le.ma@amd.com>, 
	Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the patch, but someone already fixed this.  Thanks!

Alex

On Mon, Mar 10, 2025 at 6:47=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> This line has a seven space indent instead of a tab.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 39669f8788a7..3a4cef896018 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -621,5 +621,5 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *ad=
ev, uint32_t instance_id, b
>         if (suspend_user_queues)
>                 amdgpu_amdkfd_resume(adev, false);
>
> -       return ret;
> +       return ret;
>  }
> --
> 2.47.2
>

