Return-Path: <linux-kernel+bounces-187227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C698CCED2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF541C20AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7AB13D277;
	Thu, 23 May 2024 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CszefRik"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1729E13CF93;
	Thu, 23 May 2024 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455571; cv=none; b=KrfhIgr8A9JLd/qx3pdQeMdkV/VZhLMc9RQObEh+1xQYapoEW2eahtUx/k0OIOKZcUN2qCpTNiI19vb8f+XEJ/a5lzPbizNAw1qMYaHaY1f0PNaTldPHdz1kCSLR7lOIMjePKZ+D4o8lqyTvIVpA/Hi9lNi3Wgw9ucv8YtUZcGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455571; c=relaxed/simple;
	bh=CmM379iT6QmJIK52Alxpvhf750M/onC2w2pw28yidDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKpQKG/DMq+4YeheAumdAv/AqwEyYfVmAGoeorqEnUwthX3O/C2Qv/6NU2l5ybf0/42AjjDmqN1a959t5StymArRWCAEbu1yMw/y+Vrf6o0oBXcHYFQevlHcgvslKaInU57EDnd0ywMS1KrD2ASt98fGcl1IwgzRJRuIjAQqs6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CszefRik; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8030e16bb10so635323241.1;
        Thu, 23 May 2024 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716455569; x=1717060369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTaMDQBBtugLbt3IOXjZ4RX64GEhtWIXoKX3TZUNq7g=;
        b=CszefRikETnkMSkV2do8Y9vSP3bSsIAvjVAiVl9duM5No50Bye9ZGu+sSPN/ac6flo
         f7KC1ezJYE9glOMFPSvb4THb8oQULdyc8r4X/d+mgVK0WFStQ7CCm0FlpcRMLCMkeICF
         BqjfxqCofihyF+AU4iXhk4w1OdNRC1pomTbe7C49mvql2dKFd8W8Qtqbq2eIWXal9+BG
         3Z8YQWGrQlk0+Q4BZBBzTsbWgdnXbqoXZ9J9FbYLvY5CqGwWC29oU2TgM9o7vYTojkCa
         cOWOvl17j8jny0DQWPM6AM+J6Fa9v3edfv/lXvbbtbAqlYg2FFWsDQ8JnEiDddAutUtG
         p6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716455569; x=1717060369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTaMDQBBtugLbt3IOXjZ4RX64GEhtWIXoKX3TZUNq7g=;
        b=sA3nvphmZNvdtFXVi0gLxOfvlvqMJo8GfFrqAEyI5CFbeNqm3cyovv54kSTKp9MnZf
         zhriE48wC2n/BeO6MTp33nhBk5jW19gXTmqOFdiQJ6+JVtYkKcdc8KiC5aKQXFHE3PHt
         B146eq0C7YsY7rKKVy7RaMxkq5qvML3+sRMIv+GFparzUMOA21NvUylm/F+LkMXHCY5f
         aZObrrGhI2CJ6IUWr1QVbNIal8YddBRBoZKt0/AI6uPM1ADPM+qEbhi9+3heSBjYcHUl
         fODgIwmrbZuftTDxwT2sEvLj8ZsIhr0yW8mupc7ofBAH6oiPo3dVII4epSECfR5mlAtM
         H/0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9bbU/qlgA3/bL0BQwdE4h3an/k6RNKzrhibYbPxGqcAggM5waYA5/aOvXDMuMgyERJdd61AO83swp3MiTbDza2JO90rok1G/NfQ3V
X-Gm-Message-State: AOJu0Yy/G/sd9ZNigrx8Vxfzjmeaw75VMzihR6OYLSoOBvfkw71Wqkwz
	rWf/uF0clCWRmbwL0++FY4QBDLE+r8Z9lTqWAnUfKw/irhNSEyB+TourpB19JoNNEYopdBIYPDs
	MW6ZigUCWwJUlaLHdirkNr3QjkQ8=
X-Google-Smtp-Source: AGHT+IE3ivSd13B0hkeFuHZR7TYjUowEAjXA0nUEzps5FCZwqLNqY9+FsH3MUv+jtFz2YQrc7Fys876K5Zxrn14LeXs=
X-Received: by 2002:a05:6102:c01:b0:47e:f147:ca71 with SMTP id
 ada2fe7eead31-4890a2c6a3cmr4831374137.19.1716455567392; Thu, 23 May 2024
 02:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523072242.787164-1-shichaorai@gmail.com> <a218cac3-9d9d-4ac9-8ea3-0ea9822b2261@suse.com>
In-Reply-To: <a218cac3-9d9d-4ac9-8ea3-0ea9822b2261@suse.com>
From: shichao lai <shichaorai@gmail.com>
Date: Thu, 23 May 2024 17:12:36 +0800
Message-ID: <CACjpba7yh5Soe_Pr7D3SeTjjqzQB9q=nThaYRGAZu+EvaLfxfw@mail.gmail.com>
Subject: Re: [PATCH] Check whether divisor is non-zero before division
To: Oliver Neukum <oneukum@suse.com>, stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>, 
	yue sun <samsun1006219@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 4:18=E2=80=AFPM Oliver Neukum <oneukum@suse.com> wr=
ote:
>
> On 23.05.24 09:22, Shichao Lai wrote:
>
> Hi,
>
> > Since uzonesize may be zero, so a judgement for non-zero is nessesary.
> >
> > Reported-by: xingwei lee <xrivendell7@gmail.com>
> > Reported-by: yue sun <samsun1006219@gmail.com>
> > Signed-off-by: Shichao Lai <shichaorai@gmail.com>
> > ---
> >   drivers/usb/storage/alauda.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.=
c
> > index 115f05a6201a..db075a8c03cb 100644
> > --- a/drivers/usb/storage/alauda.c
> > +++ b/drivers/usb/storage/alauda.c
> > @@ -947,6 +947,8 @@ static int alauda_read_data(struct us_data *us, uns=
igned long address,
> >       sg =3D NULL;
> >
> >       while (sectors > 0) {
> > +             if (!uzonesize)
> > +                     return USB_STOR_TRANSPORT_ERROR;
>
> May I point out that uzonesize does not change in this function?
> There is no need to retest within the loop.
>
> >               unsigned int zone =3D lba / uzonesize; /* integer divisio=
n */
> >               unsigned int lba_offset =3D lba - (zone * uzonesize);
> >               unsigned int pages;
>
> Secondly, alauda_write_lba() has the same issue.
> You also need to check in alauda_write_data().
>
>         Regards
>                 Oliver


Thanks for the helpful tip!
I reviewed the code. Your suggestions can actually avoid repeated checks.
And there is also such a problem in alauda_write_lba().
I am a beginner at making patches. May I commit a patch again which
fixes both issues you mentioned?

