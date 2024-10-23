Return-Path: <linux-kernel+bounces-378360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EBF9ACEE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CF3285FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486DC1C68A6;
	Wed, 23 Oct 2024 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xrphja/X"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A91BFE06
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697738; cv=none; b=ri3p647oCcfKIVEFza4PI0pz3qMRwdthaHrSVtiv7PHsJTlYmcWzq+LX+NcsHB3+vBvDgSHc26r7tYm5jHGvKk3DFx69XzDb2lc2/9GuvUj+b3xvm5mUT7AIyol6RtU5aaU6indkdsjUk1XsZ+3x6rHQYVfQEpZK0A/5ornLloM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697738; c=relaxed/simple;
	bh=JEiFqaiHbJ5O9qpGbnATSfozpf1WVA+k3B8AGzEoILs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qL8jjWLa0kTzQExtD+eTKkw8mmm7VeGZKvW61FzAyUvedSUjRaDYzsudjgrVmum/hHwUgi5NDl9uaAQEf4FVGCNlgaJ2PCOcWSHkNclYQiobdtR2scVdUjvpZycFM+BWT1VU2gfuCff0/3kntB1yQRcG6xrEDOSpIgwVwVOaygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xrphja/X; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1143219a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729697735; x=1730302535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p28uc21fWFodaB6on+PruEO3BbZIAcbTdzEIX0nHYoE=;
        b=Xrphja/XXX6pZHmWTcyk8WMkgghBOwvUeQrPKdKBLgFQqpkOcIRkwOzKCVvG+dpnqC
         0RusUJ+ufScL+S0G2y667I0dxU7efVBOmXlSMxhmBWX7jsNqFLRmzLoUglyA9YgXc0Fq
         Z5H4+NfZafiP6jiWG76OKkPO7XnaOoH4XsXaXdhaAe0KbiqLNOv4/hxBxi9JP4IJMrt7
         xmFq90G7cXWDW0PYH9l3MYrzhrR2qn0hVogTteD5PfcnbBUAXPdX2/K2Un8eF+4ee8uc
         iV2NVEpMe3D9B6nCrlS3d4O3cuKUbPI9Hm1cAvv1z5kw44TJYJEyx1qmVkgdvMulcBOE
         QacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697735; x=1730302535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p28uc21fWFodaB6on+PruEO3BbZIAcbTdzEIX0nHYoE=;
        b=EQIuurWvxlMghcGcwftvYQ49U6YOhEdJBxlCL8tzlSyKpJD2gDD7ZsuLa+jc64YCX7
         obWkuOnTMQMsVQ+ejaRdOI3Cbu8ZG1dKz3g/+BDX/g7HoiBd9Ztx5ZRtEk6pKRgJ0D1v
         Os4a8um+zs4JrUz60hG8bpeNkaovRtXIiNuyDSDYYjOHDXkey1x60/jgKIhMDnI4WYY7
         8Q22Jf/DScbMU8qgYb2ArBVMaypYBd/Otj5dLKENPlcTqN5bopIA1cN9oLovnCeSFzqc
         jBs5r9wLYlitR33+Pv2/nhvZKKjo6f2hG4u14ognFa7+m2m/vqVtnu/TDDd4+IOle6QI
         nIqw==
X-Forwarded-Encrypted: i=1; AJvYcCUV81z8qOxwY+TZibsfSiziFedQdgNG27NB1royMnMKPLd05TR5S112Vi+IWSUq4VKritO2HYIsdgVf2Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywffo3z64p7axAS3gfgWZ32RAj1nBzuth1fVH4JegXOMTRLzkwA
	Ps0LIPwtDcbdX2E+zRejCVwBwLtd9MCLBCmQjOI1+tBDVqdYiUZqs2duYMTIY6EfBelziAYa8iF
	YvpnghxebRkd+b/MfY49vhOLydatdUY1BOdf0Cg==
X-Google-Smtp-Source: AGHT+IFDu/ofejso4Js1LrscXtrQ2iS21X03+5ghxi5THGUm+IhbV0H9o95IMf+2KcTs/9Akb+ABfU9jyXps9vBix+Y=
X-Received: by 2002:a05:6402:270c:b0:5c9:813a:b1c1 with SMTP id
 4fb4d7f45d1cf-5cb7944cd65mr8062677a12.1.1729697735452; Wed, 23 Oct 2024
 08:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023053357.5261-1-yesanishhere@gmail.com> <87a5evncxf.fsf@trenco.lwn.net>
In-Reply-To: <87a5evncxf.fsf@trenco.lwn.net>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 23 Oct 2024 09:35:24 -0600
Message-ID: <CANLsYkyq7wJHa77ahJBD5kXhhZB74XazU78aDHtUzgRgFdTrNQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] remoteproc documentation changes
To: Jonathan Corbet <corbet@lwn.net>
Cc: anish kumar <yesanishhere@gmail.com>, ohad@wizery.com, bjorn.andersson@linaro.org, 
	linux-remoteproc@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 07:53, Jonathan Corbet <corbet@lwn.net> wrote:
>
> anish kumar <yesanishhere@gmail.com> writes:
>
> > This patch series transitions the documentation
> > for remoteproc from the staging directory to the
> > mainline kernel. It introduces both kernel and
> > user-space APIs, enhancing the overall documentation
> > quality.
> >
> > V4:
> > Fixed compilation errors and moved documentation to
> > driver-api directory.
> >
> > V3:
> > Seperated out the patches further to make the intention
> > clear for each patch.
> >
> > V2:
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202410161444.jOKMsoGS-lkp@intel.com/
>
> So I think you could make better use of kerneldoc comments for a number
> of your APIs and structures - a project for the future.  I can't judge
> the remoteproc aspects of this, but from a documentation mechanics point
> of view, this looks about ready to me.  In the absence of objections
> I'll apply it in the near future.
>

Please hold off before applying, I will review the content in the coming days.

Thanks,
Mathieu

