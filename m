Return-Path: <linux-kernel+bounces-264140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB5A93DF65
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 14:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BDDFB21D39
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAAD6A8D2;
	Sat, 27 Jul 2024 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDjY1s8a"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB215466B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722084449; cv=none; b=sBkTNfoDNGtUiLNPLKpgvsl1DfC2QHaedOhwSgxdF0C+ffoF/vVr/qypM9tRHyXeAqlrLnal9WqklFU47OR071pnNNuLJGbOxrceXnt9BSdSV5wQKmagtYO/2ANIkRB3MUA6Hv7YwOyPxrXCNp1R5GZ0LnCaihjdZqvXNpfW/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722084449; c=relaxed/simple;
	bh=WQQxembIJiKDWsjxGLvRHdzwR/bxTM2A5Tb1W7NhPwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfFjB/sRcHZZUsf0WnoxojEnsgLveQq2JHU00ifcJ/jiBOjrGDymstro1xZTm3d4sWJSAldIUTdP0FUrsnfn99DmV09LAlPnHXml9lvrcc9K5LmHUV/hAvzSD4O22JDCuf5WoREXmo2aiANNiLyf6OMbbqyv74+/4x/ykBuMyp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nDjY1s8a; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-65f880c56b1so5320907b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 05:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722084446; x=1722689246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qm0K2iiwCjE6zO/ZiafleFRuipXYf73kca2DfX3AnMA=;
        b=nDjY1s8au6D3cAqGlGdDpiftO1OI19/XUWUKpcCHjuDdQM89h52lIKa0oxnIGAM8JA
         Unp7+DsNhpMYcQnG32vvJSNOZFCw6WoMs+t5bxT7r6eN0RsfQdriHhhe8xT4gCv4YyDs
         /AucZ+nrxo7fJA/sohqPec62YbqT76OkUqCuQP5n7N1+lP+5J1YQjiTsvF8j2aWcGqOT
         vpox5lzYWIi64QO20EDOW7MVNIqjzWo9Mz9D4mMW5pqbiakTQsVLcXMBMXEm2kHVDTm+
         Xg0LCKWoy/QJu+t000i9GycvRbbKYYjRCGWQpmc8WJVZ4YcoEuar+1VzjtvpAGs9EFzI
         /Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722084446; x=1722689246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qm0K2iiwCjE6zO/ZiafleFRuipXYf73kca2DfX3AnMA=;
        b=TnWJj+9gTdoLvnKUMXf6+cfYwQxH7IFQ4gekNGx5LxHnEhGa0NqUKv82XSYXg2RHRJ
         K/1baViv/9iEl5wxJ6N8TtVO5rmadaUq5Is8nSVRxKYa/+W2xn9IVcXdMBF3KRSdLMUD
         lZAc0jpypehahWVSHxC2eDt0intk15aTJD3XIhg8xvWdYYRgExYnh1WCTWP/RtydrXp5
         ucjkdAKcchzZLOPxP6HCfaueJkiTxnZfmM8PsVlgUCM1qY8CjyBVZ77sf4ZokEJePyzp
         TAc1DdG7CiqzFDoQ1RP2AhNrp/H/262sYbcxbdkKMO+GWFD35/EOdwigc8VxPx4gOcK0
         Nkww==
X-Forwarded-Encrypted: i=1; AJvYcCUpzX3ZY0niMMxg9BLlM9m7O11Ax+ffBbjUxuwaw0xQmY0ZGwBrPkXRwsOvL6SQAQXvtIrFicN47fo9Tb6zg/2ktjVxvtueWvpiXXwT
X-Gm-Message-State: AOJu0YzR1i/VdMtqrLDNZV5eeHjKCW5fBNX4cVtVFumLdSf2NUMDnm28
	ov7y+HL8E8iNiPYnBdgsRin523uFp9uRjI51MLGO7HaNCz94WIeRZCiMHYPqADrQjYfW7Q7wdQ2
	T2fXFFft+yuTq5jlXY2OMrAggODKHR8wvN9x6Yw==
X-Google-Smtp-Source: AGHT+IEqbcAV41X4ysEtg0m1TQxIoMPD89y9he1KPVTcI6Tf0/ta8VQ8uK6NG3kpYoMoSd/HctShnal6IEhL9nfMghI=
X-Received: by 2002:a81:5c87:0:b0:650:a1cb:b122 with SMTP id
 00721157ae682-67a07f4ca6fmr27053727b3.27.1722084446649; Sat, 27 Jul 2024
 05:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725220608.131426-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20240725220608.131426-1-quic_abhinavk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 27 Jul 2024 15:47:16 +0300
Message-ID: <CAA8EJprYPq4gj3ZWexWW9jNc2806Q8VHEx-aJA4R-jFd76W=AQ@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom: com-qmp-combo: fix swing and pre-emphasis
 table for sm8350
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 01:06, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Fix the voltage swing and pre-emphasis tables for sm8350 as the current
> one do not match the hardware docs.
>
> Fixes: ef14aff107bd ("phy: qcom: com-qmp-combo: add SM8350 & SM8450 support")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8350-HDK


-- 
With best wishes
Dmitry

