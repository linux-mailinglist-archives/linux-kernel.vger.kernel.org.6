Return-Path: <linux-kernel+bounces-184481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA6A8CA740
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3391F218DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D0923777;
	Tue, 21 May 2024 04:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TCJteCuG"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4314F62
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716264763; cv=none; b=I6X+gtjH3nBKLm8yyriC6eH243Tm9hEfn5H7o4+Jjy5LvaXAu0OfwQ5o90nIOLb5ZuZLv2qsKtAceLgceVmAgSTwJxoMDipc8KOK9Rv89akTbWZdmL72AoptRCggf2cayw6LnUzH9qkYvs81Y6M2oPUTazhiGbBQpvm5N4yrdK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716264763; c=relaxed/simple;
	bh=O92KeYUkA1edHwlwkgSl2dByMiiKmyF/6D5jrMUsaIQ=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRwaVKyJYEovB05PdDKQL76A0cjOMMacsV4fC6QoubXAknBtFR+fJdXJaBMRZTzTgY9sWBdEoQDqcBblkD9TiYu8rNmzdK9DbKopOwQP3OKNZBfE8vREcGkRpPLxcTlnc2QRCgWQVRKFRoxP+G2+9rfBVE6mTsRIInn2YUDJRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TCJteCuG; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-792b934de39so269649585a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716264760; x=1716869560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDK8WDfUBYYirSWO06T0TVOheARrNR/0B8M0BZ3uAqU=;
        b=TCJteCuGSX2EXaKRCsBoBMOb5dK/dicBSL/0kUkHsR5XHVrmHiW4JVmw6yw6n/CBUV
         fCjAnIeV/ERNQw6Vt5mn1GKy55xVI5VxFbyPfmMJK/SMRciX+IPrbIeyMZlZOMlrRsAu
         1ASGpxwwtPo5n8+cPwJ+EGutcFouHcM+wSIL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716264760; x=1716869560;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDK8WDfUBYYirSWO06T0TVOheARrNR/0B8M0BZ3uAqU=;
        b=UX0mnpLUwfIA2Gdxs3y6l76rhA8qChj9zqJPsLiFSlKNUKW7RPUNX2xOmohF4zmnB/
         fSEU7nmDhmo4iBpVsk9Db1ze/qlHT1OO+ttjBaoHqWA33meWmN0B5+E0D/HodID93koy
         bdt+Ojf0b+cJhpJ88FrrAVnu5l6cOD9+91pIshv8OWLQvDRwZGJCw4/a7Lk7QKVGP5n5
         udKVXjV2/hocalqH9MiVf1V+XGPBwtu2VQUedAJpZ8XaNYUzG+09b+yhV1LcNP0ejNP4
         shc3otBvLuHBjhMlAnLA0sLVHQ2pmHzA+F7RPWCs8qsAC2SBqhBE/rvdwNaEzSn7eS0R
         gppA==
X-Forwarded-Encrypted: i=1; AJvYcCVDAjn5ZXaOFi0ODdDo6pEOfAeOavx8dTS98hZIsIecFRNID3i07l/4b1EPeVq0uV63qhBk70PCekF+p55NRdSL69O/HX0lK/bNRjE/
X-Gm-Message-State: AOJu0Yw62YZgvHmD/pBoLF7JD61azW9K3+8DT1j0kUIyTPL+htoNjUUJ
	+w7RaxbImQXbwzV083YxSlNDOK7+Bp1fdLgz0Xj6kJPvqJEVqhgvl34FMrd41hcE+5SOTqhQW+a
	Zq1i16vMetnkG18USySWNipVKEXJLoi2thYkY
X-Google-Smtp-Source: AGHT+IH+wekBZ0lrLtGQB1o7O9rCbCkIv21Dk0Sq8vPde6mos/k0ulEy29KCnMHFyBn7FO/k9cX+aqOaPP9RXBhho0Q=
X-Received: by 2002:a05:620a:280e:b0:793:b91:2dbe with SMTP id
 af79cd13be357-7930b912e08mr1615135785a.40.1716264760099; Mon, 20 May 2024
 21:12:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 May 2024 00:12:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240517233801.4071868-2-quic_abhinavk@quicinc.com>
References: <20240517233801.4071868-1-quic_abhinavk@quicinc.com> <20240517233801.4071868-2-quic_abhinavk@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 21 May 2024 00:12:39 -0400
Message-ID: <CAE-0n517DSbNim+K3=N2J2R0iZn44MS3siLKkhdLq05GTfaHtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] drm/msm: register a fault handler for display mmu faults
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, freedreno@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, seanpaul@chromium.org, 
	dianders@chromium.org, quic_jesszhan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Abhinav Kumar (2024-05-17 16:37:56)
> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index af6a6fcb1173..62c8e6163e81 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
> @@ -200,6 +200,28 @@ struct msm_gem_address_space *msm_kms_init_aspace(struct drm_device *dev)
>         return aspace;
>  }
>
> +static int msm_kms_fault_handler(void *arg, unsigned long iova, int flags, void *data)
> +{
> +       struct msm_kms *kms = arg;
> +       struct msm_disp_state *state;
> +       int ret;
> +
> +       ret = mutex_lock_interruptible(&kms->dump_mutex);

From past experience I've seen the smmu fault handler called in hardirq
context, so it can't sleep. Is there some way to grab the register
contents without sleeping? Otherwise this will have to fork off
somewhere else that can take locks, runtime PM resume, etc.

> +       if (ret)
> +               return ret;
> +
> +       state = msm_disp_snapshot_state_sync(kms);
> +
> +       mutex_unlock(&kms->dump_mutex);
> +

