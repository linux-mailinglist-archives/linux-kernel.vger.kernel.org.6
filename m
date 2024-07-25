Return-Path: <linux-kernel+bounces-262548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674F793C87A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6C1282108
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF433CF5E;
	Thu, 25 Jul 2024 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYRT/r/S"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3EE1F934
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721933193; cv=none; b=YlaVTORYyK1GmkP1wh0az9EiVHlrKpDqY/nazubvDYOlmkMOD7UYTk3r74GjrlfIyAT/4+VJ268Jh1xStTvZ3KD0kKjB3/buBYo0DGWgE6cqb8iCaOvV7yy9BTR1m0i9+YHCCBVmKPtO+3C0r5TDwYQdCsAsxOCpA8ifyjIFc8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721933193; c=relaxed/simple;
	bh=iVYvz306jhm68GI6uH8IKCctyzxr4dSS7LI30FfUfGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zfj1Cf4R51jo0FyXGEmQ1RAX76oZA8a8wiVLKeHbezFxPdR9CHR8HP8aM6tpct/htayYJX9hfVSOjjhwOgGvS/DeBJsDKEVUSvLYGA3as3Qgxp8oNQK++5ePKSoETIthDO2eiHAmIMnoqPnmG9UCuq2Nx7b3ssM44dytobFzMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PYRT/r/S; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e08a538bf7bso1945402276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721933190; x=1722537990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9oVqVsgLXU3PJAcdu8B6wfpcBpX+w94BlKsn9cDXaww=;
        b=PYRT/r/S1LGQNzgC3IMPyUAhEsKitAOSSaw20rzJEZzMu9N62TAFhXixZk6K/Q0NMf
         JzKcH1nt5quykABGGoGx3Z0ajpVf+wHrEEyccuihkctGmBKdPYBENi0O7xaQEIVRmi4W
         X18xn2wqE7MYgjtr9IQYuI6zMVExOvT4exaz2YYjCKO3gQB4Y7BMoU4QiK3gsjpZW6fF
         l25DiZRnMtEmaWiIqeC2L6Eh5/4cNE/ejTTrVJGvZ5czYUwM48QWpTdfxEEFzUqDujQC
         9vXlrBYSOjdAqY8OHktA0BhEYxa9skIJFEafd/LQTTfrOwivKzmvPJDcBLPSVrBPlhBt
         Ax3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721933190; x=1722537990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9oVqVsgLXU3PJAcdu8B6wfpcBpX+w94BlKsn9cDXaww=;
        b=C7/iby9KNYviR8UX8Z2LxnQWmo5l7KjyFcL7BVzlWKYCJ/0lHOlJAXcGH7U4WEKROJ
         h0EHb6vUcADBvGDUGWgmRufx1vPtQjyC4zEplnFxFUI23T9R4xVHdPL0fhMzaYV4RbVQ
         dJAcxyauRkyVwL63ZotWJy6xPFrrq1NB3/FVvQ7D3eNCwIpxvZER7unK5sME5yL5e4vR
         zlTQC6uTR20BHehOFiYqWhMsJZ4Y7QK6EtzHYH0NMtocPrS1Ea4DjJibTrrqEbwWiXVi
         8c4iSAuh4Vzh6ravZ6Q8rD1MBh5h2bIrxTsskKWWE1YzwVCryPBrH6/k7pOFgKy4XPcF
         qTNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlu+I9DT5xNVCWxNpv4tBPP2r10MWFGaYje5g03ruPh3hw1pyOBJIWdtn7TEwrg+CwCISb0tA5IkzzQqQQilMIC5oCliOK2/bPquIy
X-Gm-Message-State: AOJu0Yz1GIVqNLLhjKZpHHd/jrIjYYbih+o7pxZK/ZBV2gn7XpegPMRB
	DCdxZ9gF8HTAVuD9gvlCNwm7vddqzK3VeCMa3daodU1sByvja0k6uS3IZMumLrPDdb9PcLf7wfY
	mtw/QP5ljGsKNgC1zEIJ3QcnHrrPa88mLhjcu9g==
X-Google-Smtp-Source: AGHT+IGjqG3RXK8KO7zBanMmlkuKVI99KuS4nDbgcbt2brjtyXOXoWTAiiDXQMyuPo6A/9Zn3Yg+9/Fc0YYHl4H9QWU=
X-Received: by 2002:a0d:f306:0:b0:627:7592:ced7 with SMTP id
 00721157ae682-674e00553b4mr30995497b3.10.1721933190628; Thu, 25 Jul 2024
 11:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-pd-mapper-config-v1-1-f26e513608c6@redhat.com>
In-Reply-To: <20240725-pd-mapper-config-v1-1-f26e513608c6@redhat.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Jul 2024 21:46:19 +0300
Message-ID: <CAA8EJppv+SKVjAf8HdNdBo1e6XuhBBGuGTiVzDEW7kqPwOvXwQ@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: pd-mapper: Depend on ARCH_QCOM || COMPILE_TEST
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Chris Lew <quic_clew@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 19:23, Andrew Halaney <ahalaney@redhat.com> wrote:
>
> The pd-mapper driver doesn't make sense on non Qualcomm systems. Let's
> follow suit with the rest of the Qualcomm SoC Kconfigs and depend on
> ARCH_QCOM || COMPILE_TEST to avoid asking users about a config they will
> not use.
>
> Fixes: 1ebcde047c54 ("soc: qcom: add pd-mapper implementation")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> I *think* this makes sense, but please let me know if you think I'm
> wrong. I was dealing with sorting out new configs for fedora and noticed
> this was being asked for x86, etc, which didn't seem right to me.
> ---
>  drivers/soc/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think this makes sense.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

