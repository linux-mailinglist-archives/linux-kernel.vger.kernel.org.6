Return-Path: <linux-kernel+bounces-387040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4D29B4B16
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424521F23916
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDD9206063;
	Tue, 29 Oct 2024 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs7q+996"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661279F5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209314; cv=none; b=l7TZmgByfqMzurVejXGWfTYGh7M3fAmud4ArY/JdllYECxWMILV/Rfb4kqsLLd/Crgbo4JUQhdsoA6irBr3GlF4NJiToGeBhGoYp1zQb8hxmoepLoaLGTkpRpLLmtkG9cLmhh3ZN5d5sETJm9CzgbpmqNLHrWpvEKoEGGjnjn/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209314; c=relaxed/simple;
	bh=LcE/wbU7qL77CbsHODGlW+qV7Txs4BhdjHYdIpTougA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CR0dCc096N5xE6uQCiZ7Oh3PF1rw/TD7FC3iPNauXCnUxjfjMKvBh4UbuQuDhkT7md9ajOa6jb3Xh1R87N0K2dNG04CDB3xlvN0Yzlrj9O2klhS9z/8Fk5LcClRIZzUOb7KwSa1EOl/jRWjUuRFC+MiothpN7tTpAkZxivrjZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs7q+996; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72088a79f57so149346b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730209312; x=1730814112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4568fy1CyLu7ue9QZlYfB1BmFVst9PUnOLzhnVMfc4=;
        b=fs7q+996Wqtq5GlUIdewxosIdLAwIomRnrbZMNMF/lxCS5GY9lf/l6JdoFP1UF25sK
         SDUeQN/ZRmwWfn0NMI6yhmUhoQDxxPHPVEe1M9mJxOGzNTTI2/BQyQltNUhbZg3BnjIL
         CNBqJ4q5+8MfBzmObPi+zV+10OKUu++JBUoAZ6MR+BDsS6GJii/dmxXbBeq5dYU8SH/o
         NtlnRLJDPxwOG/HWDtOGWGqgB2EmMfJPDb6VHSvkWjXnlXllDp2SQq0ggU5iwg7prjgu
         JdWRk//TJLJoy88DTxy77sQYt5FXsVDxhel8nk6CUftUlP3qIwpzcCIboQZ6Qt/j3c85
         DUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730209312; x=1730814112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4568fy1CyLu7ue9QZlYfB1BmFVst9PUnOLzhnVMfc4=;
        b=U7wERm2LLwz4tBbjhMBrOlY2RhnzxyaEvGSJVUy0Tgao/woI5sWe7dmu6goAtwdIlX
         tMjXEu32PamsnL9yIwyJC+U1ruESV92t5R5nTegZOHyk+AmKoGVNBt5f7HKPPkGOKX9R
         LDMpz7KTJDYjTTA0MA1KHxyc9Z5m2uS8lIhAXZmzwReQ4ISojmn6OpLDTKqMPJVnsx4X
         zZQuSSE5C/djlM/UTKIfhiCnrfwVK/n3JLgZu/rST+9Rkkeaa+MuXFMXS54Pd0kNSbXy
         vfcdS8NWsxWwd11FH+Gu4c0qOp60OtZqyVdO7FxVmxBvF1hjmOnmOO5aFyr40GLpsOYI
         HnJA==
X-Forwarded-Encrypted: i=1; AJvYcCWNL/TdPyWqWWEOXQEFPbDpfjAjOmX+z/AFkLZfvHBbOJT9WezWceKJ1W9z8Uxi/hBOxkJQRj2XvBR1Eic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbG8R/RouZ7NhxnB/HC0Jh1fS2KfR0V6ydMyQlu2/BtMnpRCuv
	LOa7YK29UERooZO0O/H9jtguJbZf7Jg2n3EDLU7+oh5wdbTUkinAGl2T9cBRL6aOq33lQ93x14N
	2cFPm7LR4Rm7PdFSDn81wUEYPSXQ=
X-Google-Smtp-Source: AGHT+IFUBsAPh3iVaLPACK1QaY6fyD7GQy1DyI+2ph/A/x3BuCmAIUM7Q46z+qAua5Rfh34UsSxy0OmVdBsf5SeHV7U=
X-Received: by 2002:a05:6a00:2d25:b0:71e:658f:c43d with SMTP id
 d2e1a72fcca58-72062ed3c37mr7171390b3a.2.1730209312110; Tue, 29 Oct 2024
 06:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027140537.503264-1-prosunofficial@gmail.com>
In-Reply-To: <20241027140537.503264-1-prosunofficial@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Oct 2024 09:41:40 -0400
Message-ID: <CADnq5_M4QwRfROybHrQfNuiXNhHH7VFAUVZMWkriwZs7K4KLUQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/amdgpu: use string choice helpers
To: R Sundar <prosunofficial@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, tao.zhou1@amd.com, kevinyang.wang@amd.com, 
	Hawking.Zhang@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	luben.tuikov@amd.com, kernel test robot <lkp@intel.com>, Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 10:18=E2=80=AFAM R Sundar <prosunofficial@gmail.com=
> wrote:
>
> Use string choice helpers for better readability.

I personally find this less readable, but if this is the preferred
method going forward, I'm fine to take the patch.

Alex

>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/r/202410161814.I6p2Nnux-lkp@intel.com/
> Signed-off-by: R Sundar <prosunofficial@gmail.com>
> ---
>
> reported in linux repository.
>
> tree:  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master
>
> cocci warnings: (new ones prefixed by >>)
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c:145:8-12: opportunity for s=
tr_read_write(read)
>
> vim +145 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_eeprom.c
> index 35fee3e8cde2..8cd69836dd99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> @@ -200,7 +200,7 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c=
_adap, u32 eeprom_addr,
>                 dev_err_ratelimited(&i2c_adap->dev,
>                                     "maddr:0x%04X size:0x%02X:quirk max_%=
s_len must be > %d",
>                                     eeprom_addr, buf_size,
> -                                   read ? "read" : "write", EEPROM_OFFSE=
T_SIZE);
> +                                   str_read_write(read), EEPROM_OFFSET_S=
IZE);
>                 return -EINVAL;
>         }
>
> --
> 2.34.1
>

