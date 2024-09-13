Return-Path: <linux-kernel+bounces-328558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604229785BF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20669288952
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC89977F2F;
	Fri, 13 Sep 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AGr7V/92"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935906F077
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244889; cv=none; b=jf1B+6ULQQDYiHI7E8Z3dWQfc7uEEDYNCIvnw/AhkIYgi2xq4SCCVMfYT3kHnPHVUCNkjEoLbIDDebhxkVCNxlYNkrhOIkHoqgqQPJ2xz+cYYw+qOagz3yYPFgndZVMTXvFvsAPBp20dcVlC1oldJfD6hmF3aQWORRrCfJ+IqeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244889; c=relaxed/simple;
	bh=l6fQQfIJrCnieXnJtgF3yWwkk1JOKa/ssQuU9USSh54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZS0nnvbtTxM03UujlRXXLyuq6aHZJUeNc8ZSdbdNjrseDuUgQUbGCb711gPWx/QLrxbJHtBfp18M7aF6yPiMFgdCRSaXnQpoOqGfqHfRu4YdFXteUTLxIUq9oH1RrRnQqBEhlllHkGayNIwuS6o3gosZcce8D+KsByMh3XZriQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AGr7V/92; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-846c4ec2694so617333241.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726244884; x=1726849684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MySfAV1H+y1ji7wrdPmDhE9q7agfjXhZS+w1J3QnDfE=;
        b=AGr7V/92Ccvh2ei+H3/gjhiw71ZoSCNCUhMriUQ4BlAbHantF65uBfx7vg+eEefmXE
         Cs+qy4mjox/EiuRlPGTc6loAydW4F1JELiQ3+Ia2E4XTf5jvNP14CmOCyMcg8Zd7X+n1
         kUdYnMPHcw2XrkeK7lkMvA0aHpAemdplbGITY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726244884; x=1726849684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MySfAV1H+y1ji7wrdPmDhE9q7agfjXhZS+w1J3QnDfE=;
        b=D7HnwQgngae3EUf8YyYkmI2jXQF7J3bWCyrxN2xxHyuEN7kSTbXp9lrroylomN3/0/
         JOn2IQQ6vBfw4UNcdGdY4vmB082J3AfGX71FWn8k6N6T3UNz0ylNAFAOYYeGAVXhQdp/
         jlIe9XqRjyJVw9RHe1xYp6KNzhFnBpEDENxS0gqDnMCJ5FMg1gSJjy/FwMPeYZi46Gkq
         xm9Dzra4+O5sx42mMCGex14X97Lrf2VmQgzG9P2DvhfykwRrKJvQEt+NzSJxagj6gOjr
         H1kN7dNu24VI+T8chCkf9Dz9ovmVUUACs04cnHmEcfmW0E4Esw5S4Y/f6YT7X9CocI1x
         ypLg==
X-Forwarded-Encrypted: i=1; AJvYcCXVZ53wF4T3Ph1ms1ZXffbOOjp/j3/NncuJRbCseUZhSkqXeeisoUOXuxq/IQPoIuh+4EIGIrD0NRlHBfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg3cc8VfxpMZRWD5FkpTniqDe1EE4QyNYCp4JJQBlAhjFHcCkk
	1OKel0HyAd/UfAR5hQ0zF+F2qhEJtwVCjqsj2P2tyMHWTBCaozlA6sRaAbX9ZJh9/2jQZEjKbck
	=
X-Google-Smtp-Source: AGHT+IHGFiJ8cxtgDB9E2ElFXZbDZrE8EZoj+HKkj+HzxCvE6vpM5BcNuDTK34ogbLzAT8roT52a8Q==
X-Received: by 2002:a05:6102:e0b:b0:48f:461b:c9ac with SMTP id ada2fe7eead31-49d414b32f9mr6314274137.14.1726244884601;
        Fri, 13 Sep 2024 09:28:04 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84906ececa5sm576872241.35.2024.09.13.09.28.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 09:28:04 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a99e8c32c0so222220285a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:28:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/zpLxvkSUtHtblXErOpOJmNXoLiKT1Euns6AU+pOunBbkcbRFtToODlBKG2MFk5yKYnaPlQ+1HK9E9m0=@vger.kernel.org
X-Received: by 2002:a05:6214:3a86:b0:6c5:297c:da5f with SMTP id
 6a1803df08f44-6c573570b58mr118095856d6.33.1726244882965; Fri, 13 Sep 2024
 09:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909132810.1296786-1-ruanjinjie@huawei.com>
 <20240909132810.1296786-4-ruanjinjie@huawei.com> <CAD=FV=XQ7uf_Y_WTv_6-DX1Mo=+RycKSyxf=E-f3TOKiuE5RMA@mail.gmail.com>
 <c662f0b9-31dc-8b97-ef3f-ea33f9fc62af@huawei.com> <CAD=FV=U+kc1rKSDDo-Zx+CiuapoJ8izrCW0Wh-PfR7ivY_4bXw@mail.gmail.com>
 <10e77c5a-a188-698b-0c82-86c4bcdf114d@huawei.com>
In-Reply-To: <10e77c5a-a188-698b-0c82-86c4bcdf114d@huawei.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Sep 2024 09:27:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XGKph6t9S-r9-D+LkYcGNgRbEAC-qc4OQZjZXmxrjozw@mail.gmail.com>
Message-ID: <CAD=FV=XGKph6t9S-r9-D+LkYcGNgRbEAC-qc4OQZjZXmxrjozw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] spi: geni-qcom: Use devm functions to simplify code
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, akashast@codeaurora.org, vkoul@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 12, 2024 at 11:44=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com=
> wrote:
>
> On 2024/9/12 21:38, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Sep 11, 2024 at 8:53=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.=
com> wrote:
> >>
> >>>> @@ -1132,6 +1134,12 @@ static int spi_geni_probe(struct platform_dev=
ice *pdev)
> >>>>         if (ret)
> >>>>                 return ret;
> >>>>
> >>>> +       ret =3D devm_add_action_or_reset(dev, spi_geni_release_dma_c=
han, mas);
> >>>> +       if (ret) {
> >>>> +               dev_err(dev, "Unable to add action.\n");
> >>>> +               return ret;
> >>>> +       }
> >>>
> >>> Use dev_err_probe() to simplify.
> >>>
> >>> ret =3D devm_add_action_or_reset(dev, spi_geni_release_dma_chan, mas)=
;
> >>> if (ret)
> >>>   return dev_err_probe(dev, ret, "Unable to add action.\n");
> >>
> >> It seems that if it only return -ENOMEM or 0, using dev_err_probe() ha=
s
> >> not not much value for many community maintainers.
> >
> > While I won't insist, it still has some value to use dev_err_probe()
> > as I talked about in commit 7065f92255bb ("driver core: Clarify that
> > dev_err_probe() is OK even w/out -EPROBE_DEFER")
> The main difference is that when use dev_err_probe()=EF=BC=8Cthere will p=
rint
> anything on -ENOMEM now.

Oh, I see. You're saying that we should just get rid of the print
altogether because the only error case is -ENOMEM and the kernel
already splats there? Yeah, that sounds right to me. That doesn't
match what you did in v5, though...

-Doug

