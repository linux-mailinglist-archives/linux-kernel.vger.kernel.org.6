Return-Path: <linux-kernel+bounces-174826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3F08C157D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E732B22600
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC87FBB0;
	Thu,  9 May 2024 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="njMxRWO2"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695547F7EF
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715283321; cv=none; b=NGBqJVI9oOHAt9EM68R2oXtrx+5JYKVTKLATRg0pK3+0NOgBsLD3OKlWC+2zBVnq0mg7QDrPTq9+YGJm4WgX3PxDkfw3v2Xgqks1F0EWkT0ExSElHmBcPEhSXQFn1M5I1rCyobGGzwxek/ze47rFEeUz8YkOridYD8v37rzhmBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715283321; c=relaxed/simple;
	bh=EaYjQrX+/02VwYCtKZW3vScrvUW670G05eaMa5VkSl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prQQtJrXCNtEwLljxIFWHSpCysZeV269h8qdMbKbgHlJqMcmeIGFDDilq6B1nuOWL414VIFGhmGhMQF+TDCXstp4jETxn4YpzAtEKg5G0A3kXUF/9OAxW9/aAMHWnPqnA0cLvnwlt8TsN6oW7njleasrgUjzrcNekHgv65iSY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=njMxRWO2; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-792b934de39so99282885a.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715283317; x=1715888117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw1OkgMZ/krnn9QK21TBDDqRd4Ysk40xlaOCf58rQec=;
        b=njMxRWO218VOr9i4CwliCfguyyPAJOD0LTGrOz+F2sjEDkdwEXGyx27PO5rp13gvnt
         2WNCPzckhZFz6G7qiH6J9/z1qgBJXc127CnbTSBSHPckFqrCH9kMeZtfPS/UybVTS6Bz
         RPWsnqDxkw8uNXcJfM0k9PW80kjPyLQFSpSIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715283317; x=1715888117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xw1OkgMZ/krnn9QK21TBDDqRd4Ysk40xlaOCf58rQec=;
        b=FsYM3547m/AQi1K/LynzvVtJt8i2iZpRK0TtjBoj+81VRdzI0Cs+5+cj47BwnENpzj
         jjgeNzupVZH1PlcE12LroRJhXo/Fn4nAdxrPluS46bMPI6oSN1LTMp+hgAzvBwyaPPl2
         kavIMNsccCo3RO0GIGswEWmaA0MwMX97MLRTowFZip7A8uCOpPlFPg1NcFQK3Z49jmfW
         /JExu0YJF0qw4SGuYIwmE0LboIyp7A1mFH+TdGL9L53P2b2AwCPAutA1OSDkZpTrzEGM
         kCGK3umCQzOZVg71azrxVqZ1uyty+k2wc05cM9Dkyq++ZKW9kYIrsyigOPVFu+BY5ydb
         eFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO+7T5oy9vCiqgG/FX2o8Qeb/mwHjgqBoIlm1+Zul44WqhkywEkqIQVTMp1Fktj3Hsucq1NFgILL4/EiPW/NjrHP9ZGDmlIRQsMZS+
X-Gm-Message-State: AOJu0Yyev68LKsFz1alEysKgq380Atwe8SwJuqSopsryvi7Zy76H2mbx
	r7WTF5WRtCLA2OgVcJ5yYFusvAmcE85kUJQjvqe/nEL3OMiNi1mCpW/Kvgfs2T6XsmYZ2d8UYp6
	Zp5mN
X-Google-Smtp-Source: AGHT+IEAxU/vvfljdc2R4lNItw0AGhwdQkLrGTifCEPIE5dYovoUqZ0FcMO4wKT5CMNuU8GGSsV2nA==
X-Received: by 2002:a05:620a:70e8:b0:792:a4e0:1404 with SMTP id af79cd13be357-792c75abf3dmr44405585a.38.1715283317622;
        Thu, 09 May 2024 12:35:17 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf276dd6sm99795285a.13.2024.05.09.12.35.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 12:35:16 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-439b1c72676so3291cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 12:35:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSVU4O17AFS4Q9xBAuJjuRdBmOhoKjqF+txUgs9tLAU2NsicnUdk66WqX2DMNu1Jnc4iONtgEo0B2A8ui/Lq7wtTL7D8OUYoYEXUFW
X-Received: by 2002:a05:622a:429b:b0:43a:b977:d611 with SMTP id
 d75a77b69052e-43dfdcde1cfmr333451cf.24.1715283315822; Thu, 09 May 2024
 12:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509184129.3924422-1-swboyd@chromium.org>
In-Reply-To: <20240509184129.3924422-1-swboyd@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 9 May 2024 12:34:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VP+DDQbdb-pD2JJKrZ+MrkgcuyzBj4H-4oTDVvBpTOtQ@mail.gmail.com>
Message-ID: <CAD=FV=VP+DDQbdb-pD2JJKrZ+MrkgcuyzBj4H-4oTDVvBpTOtQ@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Ensure irqs aren't disabled by
 rpmh_rsc_send_data() callers
To: Stephen Boyd <swboyd@chromium.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 9, 2024 at 11:41=E2=80=AFAM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> Dan pointed out that Smatch is concerned about this code because it uses
> spin_lock_irqsave() and then calls wait_event_lock_irq() which enables
> irqs before going to sleep. The comment above the function says it
> should be called with interrupts enabled, but we simply hope that's true
> without really confirming that. Let's add a might_sleep() here to
> confirm that interrupts and preemption aren't disabled. Once we do that,
> we can change the lock to be non-saving, spin_lock_irq(), to clarify
> that we don't expect irqs to be disabled. If irqs are disabled by
> callers they're going to be enabled anyway in the wait_event_lock_irq()
> call which would be bad.
>
> This should make Smatch happier and find bad callers faster with the
> might_sleep(). We can drop the WARN_ON() in the caller because we have
> the might_sleep() now, simplifying the code.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/911181ed-c430-4592-ad26-4dc948834e08@mo=
roto.mountain
> Fixes: 2bc20f3c8487 ("soc: qcom: rpmh-rsc: Sleep waiting for tcs slots to=
 be free")
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 7 ++++---
>  drivers/soc/qcom/rpmh.c     | 1 -
>  2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

