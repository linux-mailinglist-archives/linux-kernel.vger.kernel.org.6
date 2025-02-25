Return-Path: <linux-kernel+bounces-531600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E644EA44284
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D6F3AC854
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A3B269CEB;
	Tue, 25 Feb 2025 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="EsNU/CKb"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177C5126C18
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493173; cv=none; b=SJJv4R8LGEQAbku9PyGc8B59HqDwBoGUR/nAJxkL9k2nQ77spKXRgo7CXcKAJSlupXMSUhWwxtFRGLVZZgpxhDMePdbqc2RjCVMV1CeCu3/1+azl3ZGt48eglmsd0qOjO5r/V8g2thv9eaMY8Uk6cMSBgY+UseqsW4EJ6qGg4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493173; c=relaxed/simple;
	bh=YfaowTrjdM+Bd8R3YzDrhq7lbCbVr2H6FlNDkDda0Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grxFrzbKUJBvX45/xuB4XpHlSxt9uHiL7jupFz/Jjc8Nlq3E+4ncq7gbIInfzwm+IewoySZ4n2wAqvMGVNhlLqa+W7GMuvVmN0uSjsNmBnmOvfPi0JH8zr1ev/IOkzcUgIuj3hXP201qf0RBnEoyC+tkjitRKhxsxFTxKYrlghA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=EsNU/CKb; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e587cca1e47so5251190276.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1740493170; x=1741097970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G3qJd2sc6L4K5ZD860Vogae0xgCZ9+DNu5FmGC60GsY=;
        b=EsNU/CKb5oyJt9xAs0uaXVTY6MiyWQQDF6jV763+vIQeAw47hAAkKOPhfhk+e2X9Ol
         moGl60vTRG9ZmEbXbQBRldAgvppP9b9hQ7U0HP/k2yfvwOBnRSX+8atlMmEkTUZwytTC
         d3jLeG8hb+tYjm7TzqcWHwVQPM0+OIXnIa8wOYEaiQMfOKulQGXYOueZufwm+Ur3EY8v
         lJc79ODu1tidw7/C21gvFdBxPvdzrW38ufEqS/IPT359RModCa1fc5RZpHtiXqmE7B7J
         Twjh7mxRgTruDvDZD5MTg6tbTUnd44nMqmioVk8OAC9Od8TD3BlLtYqYVpqHNpcfIvdb
         0Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493170; x=1741097970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3qJd2sc6L4K5ZD860Vogae0xgCZ9+DNu5FmGC60GsY=;
        b=D78Qz5bKCGf++5HQkWo/ONIBxxrlqWO05Lb0r88c6SmWWn/zuLczfOx7peciynVfab
         RRgK03u8FltC/qXeOEsJOhd8yg5LNXeTMc58U5dmxdtvKDr8sUOR9Pm9rmTL85OmDa1b
         sAmgb6otcbpQGoDMveVdJTIIS3VyzuLVr88THvEAVvmiZLBBYHCloyvBuFsx+VrwtcYb
         4d6g4bvEpuMIyQvfrFNViE7epL96vT2oErjv0/tGXGH3Fy7kPsjcuad4xv/Z38bjFKDQ
         FqgzZzh8XiV5gQ0so+HDGIxoKugSGW0FlLbcRl9197J+O49NSU2FPVjIIgDNawJ5vBJG
         imJw==
X-Forwarded-Encrypted: i=1; AJvYcCWsmqMuTYSsqEAwfXDxFos0iVqQNQgTcIFhUnPXmH1E4XbHx8nMxZ2FytqUx4JGTxAdT/Ga5KOIYOgySCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23tmTpzSrBjDLRUul825wLSaRoSi3bBigfB1MEfz2GPTpdhhU
	/sfi2zNfgjzveBjK/OFu+qzyuwLZp1IKDlT58R7Y0NHO5+jfal/djsxjqKaBmtOCHmx5MtMiC45
	Nbbb5ULO5mcBFoh4B6qEXMipw6XDd28Z9WIcUYQ==
X-Gm-Gg: ASbGncsxEb268H7Ni9J6Rhd8KVQId8oe/j6EZkurpRxutZXxO3Pw0Uks6kJooZ12mrQ
	FszWCa8C7no81IXspq44yNuKd6AxaXqGoGL2XI7SmCauMB9puZdg52zf9xqL9Jp8P+MCcwtr7g3
	8yPqk0uByrowOkGq23X/ndmjqJERbQ+01ny1ueBcE=
X-Google-Smtp-Source: AGHT+IEC4qfF8/eiKYWC6b87/URt2aZmRGTvr02EO+vykpkfp0nILc5ac/dlwepmQfxWmjI9CHtInw3sHU4Kc94JtHc=
X-Received: by 2002:a05:6902:2085:b0:e5b:34cb:ebb2 with SMTP id
 3f1490d57ef6-e5e245efd0bmr13195185276.19.1740493170016; Tue, 25 Feb 2025
 06:19:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225-b4-ov9282-gain-v1-0-a24af2820dde@linux.dev> <20250225-b4-ov9282-gain-v1-1-a24af2820dde@linux.dev>
In-Reply-To: <20250225-b4-ov9282-gain-v1-1-a24af2820dde@linux.dev>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 25 Feb 2025 14:19:14 +0000
X-Gm-Features: AQ5f1Jro6d8OWU49F-6F1vKdHETRh6QOCZRuMfdR_PmC7PcRjIrOpwo4uPciv6I
Message-ID: <CAPY8ntDYYPs90JVCLiZGqQAak=WOga90hgCns_TRWTxdrROPiw@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: i2c: ov9282: use register definitions
To: Richard Leitner <richard.leitner@linux.dev>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Richard

Thanks for the patch

On Tue, 25 Feb 2025 at 13:09, Richard Leitner <richard.leitner@linux.dev> wrote:
>
> For better readability use already available register definitions in
> hard-coded common and mode register structs.
>
> Signed-off-by: Richard Leitner <richard.leitner@linux.dev>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/media/i2c/ov9282.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
> index 87e5d7ce5a47ee23a721ea39c0ab314c6fca6007..c926842257893c4da3319b847fab9908b5bdaec6 100644
> --- a/drivers/media/i2c/ov9282.c
> +++ b/drivers/media/i2c/ov9282.c
> @@ -296,8 +296,8 @@ static const struct ov9282_reg mode_1280x800_regs[] = {
>         {0x3813, 0x08},
>         {0x3814, 0x11},
>         {0x3815, 0x11},
> -       {0x3820, 0x40},
> -       {0x3821, 0x00},
> +       {OV9282_REG_TIMING_FORMAT_1, 0x40},
> +       {OV9282_REG_TIMING_FORMAT_2, 0x00},
>         {0x4003, 0x40},
>         {0x4008, 0x04},
>         {0x4009, 0x0b},
> @@ -327,8 +327,8 @@ static const struct ov9282_reg mode_1280x720_regs[] = {
>         {0x3813, 0x08},
>         {0x3814, 0x11},
>         {0x3815, 0x11},
> -       {0x3820, 0x3c},
> -       {0x3821, 0x84},
> +       {OV9282_REG_TIMING_FORMAT_1, 0x3c},
> +       {OV9282_REG_TIMING_FORMAT_2, 0x84},
>         {0x4003, 0x40},
>         {0x4008, 0x02},
>         {0x4009, 0x05},
> @@ -358,8 +358,8 @@ static const struct ov9282_reg mode_640x400_regs[] = {
>         {0x3813, 0x04},
>         {0x3814, 0x31},
>         {0x3815, 0x22},
> -       {0x3820, 0x60},
> -       {0x3821, 0x01},
> +       {OV9282_REG_TIMING_FORMAT_1, 0x60},
> +       {OV9282_REG_TIMING_FORMAT_2, 0x01},
>         {0x4008, 0x02},
>         {0x4009, 0x05},
>         {0x400c, 0x00},
>
> --
> 2.47.2
>
>

