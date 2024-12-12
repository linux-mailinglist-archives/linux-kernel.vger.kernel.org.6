Return-Path: <linux-kernel+bounces-442865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F39EE31C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25350162B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A001820E316;
	Thu, 12 Dec 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTY6OTxm"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F195187870
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996078; cv=none; b=TtyfAta7N+s/wYMx7PCjIasDoj9asrKF9dtutEU9rIDaeXhAMBOnnaafBWd0RRZIqzIVPcEA9tXNvaQiEkpkRTTHCEku90lhg4qxnXqpDBA2kQVZFZFR6FML2mM0uvmwScgw3L+W4vFsxGxymsrsqIM+Cif17jgGQX9tI7KlTKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996078; c=relaxed/simple;
	bh=Cl1dVQUEOOw8H/t4qkZKsUz6oeF3SVgXlEu66YfTU2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4nbZlAWYPbsY3YDnBXdLOJ2YzEUQklcszQLqtka9rwnqDb1M2NAaf5bLEKWN7koCoJ0vB47pEG7iw+xqDWI+LBYVmQHL0hFGK1tcS/ap6zHBLiTbNVmqHsVxsZ2s2yy88fb8CSQSzD3kQgcE3v2dWp8FOwLlIwFdYt8NqjmAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTY6OTxm; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-51873e55d27so215076e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733996075; x=1734600875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vIiyY1DojuqYwP8kOfCtRvyI9XPWag4T5+yXbCexAAc=;
        b=NTY6OTxmLniUIUjjQEzPETgFX0DYJMXBX2b9eMx96hs7jLKAWpShR/1/Xm+2KnZsNn
         WgNCtea7KrCVGUqUGHljeeaPLIzh8omPKHb4rylZQJP+WuJasuHxxgeW82BxWq8GRZfd
         oJEZE4gdUa1atDd8fyeIZ8tju/g10XBIkmKll9/gQ2JWX1QgmvPCny2vKlwOfmaddpI4
         QSlh7TQUkBYj4/mnNfkjrmCc+cNeu7/e68cfIwYLegZvb9m4BUEJQ2s685MR8rhKPGGI
         fs6BQL2vnkHi8C2L5KP56z8ys8DCws1UMYYLvP1JeDKyiWAmgqy4V8YAzY8sL3BJ++3w
         Hlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996075; x=1734600875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIiyY1DojuqYwP8kOfCtRvyI9XPWag4T5+yXbCexAAc=;
        b=bRiukNQW22v3qNZp923S8PQWKtIkOkMEqhWQqfR28O4Fwrbj+wLsBF2D9ihWBAnfa+
         piVDLkAepgCg/RkcTf8R/wjkRVRU+q3xPmAk+8dEOAnZthaFhWHUZDRW1YaC4d2bTJaI
         N5suLlCNJVq0iUsXreU2OS+QdnvtlXu8wyaTRrRO7Yd6BKMSksaXHGBYp/ctA3inOUrl
         QAih8uJakszWpLcUxMpez5fhAsm3/WHow1jtSym2pu3ytwWXNZRWzGj88Whh7kL9ls/5
         CgAunvh+W5BBQVnstznKvfg/+O1SSHcmMoVMpMNeGziUuJwaFp6ep5smYcIA2LPaCRGm
         7B8w==
X-Forwarded-Encrypted: i=1; AJvYcCUtuhlhdhjNXzjO3Kw1v08Nb3ZhnHIPE4oT9D1BbgAuXkQuyWKw5Fd+uBYN3W+FuWJtVQKLL/XxeCgeDwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0h2ywjmIEmu1i06Kuj0Wh8y5TMKzscpxNcCCDEtkiqF9KMW4X
	hFcJGVv+OtZfLkNXjRtW0FbORGj5co9eGx2IJV4b/+BKiJ71mPv/m6Yvq7AhTYKSX5pxz9fEL7y
	AdqvaEZhgaZoPaY8No3ddz5vD/3w=
X-Gm-Gg: ASbGncsRNvVIA1FpEW/pLFaxoye/bg/ohFyM0sf7H5Xrzwd2teHkUonPklBJWd9EYTN
	x8YNKuy2TJf/5kZcFtC4R9V1lOgRsXllDfT2n1g==
X-Google-Smtp-Source: AGHT+IEZdVuZkfUgdpPT2XxtE4NxJsWzqM3d6A/dsmpnRJSb9HoGfRwCAOhclvChuS+G2XD7aJsNnWUsWJSD7eWoaug=
X-Received: by 2002:a05:6122:914:b0:518:7d3a:dd13 with SMTP id
 71dfb90a1353d-518b5d0e582mr1947522e0c.7.1733996075319; Thu, 12 Dec 2024
 01:34:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211122026.797511-1-karprzy7@gmail.com> <20241211125936.GA23711@pendragon.ideasonboard.com>
In-Reply-To: <20241211125936.GA23711@pendragon.ideasonboard.com>
From: Karol P <karprzy7@gmail.com>
Date: Thu, 12 Dec 2024 10:34:24 +0100
Message-ID: <CAKwoAfqFbZ0rWzYwX+WTJzMUE1K1Es_UtZj6YXwDKqs=HR6f5g@mail.gmail.com>
Subject: Re: [PATCH] drm: zynqmp_dp: Fix integer overflow in zynqmp_dp_rate_get()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	michal.simek@amd.com, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 13:59, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Karol,
>
> Thank you for the patch.
>
> On Wed, Dec 11, 2024 at 01:20:26PM +0100, Karol Przybylski wrote:
> > This patch fixes a potential integer overflow in the zynqmp_dp_rate_get() function.
> >
> > The issue comes up when the expression drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000 is evaluated using 32-bit arithmetic.
>
> Please wrap your commit message text to 82 columns.
>
> >
> > Now the constant is casted to compatible u64 type.
> >
> > Resolves CID 1636340 and CID 1635811
> >
>
> Does this need a Fixes: tag ? How about 'Cc: stable@vger.kernel.org' to
> get it backported to stable kernels ?

Thanks for the feedback, I'll add it.

>
> > Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
> > ---
> >  drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > index 25c5dc61e..55e92344b 100644
> > --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > @@ -2190,7 +2190,7 @@ static int zynqmp_dp_rate_get(void *data, u64 *val)
> >       struct zynqmp_dp *dp = data;
> >
> >       mutex_lock(&dp->lock);
> > -     *val = drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000;
> > +     *val = drm_dp_bw_code_to_link_rate(dp->test.bw_code) * (u64)10000;
>
> You can also make the integer a 64-bit constant with
>
>         *val = drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000ULL;
>
> >       mutex_unlock(&dp->lock);
> >       return 0;
> >  }

It does look better. I will send v2 of this patch.

>
> --
> Regards,
>
> Laurent Pinchart

