Return-Path: <linux-kernel+bounces-305616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A33EF963139
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465401F26109
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B5C1ABED7;
	Wed, 28 Aug 2024 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCusYVUw"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7E125BA
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874564; cv=none; b=qAEcb4hfo/kkRHj+n49t3fdT4rLIg6/0Lru7AwmrQPBMmmmwi9IekciNr8iDyJwSoVvoY48qjqLup8DAh1MWs5iTSon0W65q2/r0RlN10hmbrKVSy7jKYDvwggW0QxHMEOdyoXkSBAZ/dix9FkpPP2pvOEe2wgoyNalXyWaGwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874564; c=relaxed/simple;
	bh=iCpcqPThAPmZLodK+uZfdz3ZGn7+GEtpWdlwHYhSoSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCu/PQcKKQyZvauBEA0oUejrkGvPD65LEHZHRXYoxtoFgpRjSimljJiOR1UL3mL7gsGcQ1Ed42AM022BZvrIZedP+B9XuT2SEL+52kj/oollfFkNoh/DKBsdrGcRm4O1qvqHGhap5/A332kH731JNpjUQkmBdzQNDpJCh9LD2ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mCusYVUw; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5334fdabefbso880836e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724874561; x=1725479361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WfREJfZgElEweHVwJvSVEk/D+r54zJQcIccfYEdIZSM=;
        b=mCusYVUwhkOoWoZ7j3rRMP0aB6XymUwG3Nm3ngxRb5Kf+WyEQ7vQT2kxWYj7ejOKGQ
         mXisgKT1Q3Q/tVY6bq7qla00l86iqNZPDbsYpv4eGkRtxDabeALMxyuvSAt/cg9O4gXm
         CGBG/JWAT9d1Jx27KwioaHCgqdQXBjTsTGsurBwSiqAjGHd4wVJjn/+1UTe4ObDjfnaR
         xmWHe0l1QYpDt0uUlk5c6Ak65AN4297l4FMZxgBYkYVGKgXHcsG/aEb+7JRs5xoxI+pw
         Zaa8/9NsRdzr+Xvym1ITN/eLqnvac3QHRysQmZQ2hDmflO9onPZ3OJyEfcV6zHF1vczm
         Qmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724874561; x=1725479361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfREJfZgElEweHVwJvSVEk/D+r54zJQcIccfYEdIZSM=;
        b=EHBEvy3+b026bGYY0sCoC8lyfQ78MrGqfi7IkmrZSZFtmb09tT9qjDPh7jWTE19Brm
         BUYxxvJoFmToKd/Ab/11UWNIc5HC2TSJAmz8kMge6yYJ7XeCA8UrF/B+bBWdIgWzxmTc
         u6gUjfcB83FE5UffHtO0jQY1sx566gpBGgOp3BNeJi69MKFk8sfxhv7gGSsHwwBDFXS/
         dRQNfDxJFONmb/G5B9X3VbXDIO8TfNS4ProiKoNtPlkF9KCb0Ix4VYXItXJfgBcdKbAZ
         YVNv9RKHdgIwuc6tMbpmAbyy6/fKVgC1zv204o+iFE4cXPqRYnZyDhAHfy3j+a6trrZU
         mfFw==
X-Forwarded-Encrypted: i=1; AJvYcCUhG5jdWNzHbF5Vj4vsyEDZGz0aWeeJGBhjggWurVJcQwSX1HQOGd2Tt6L8InmcOztw6AY6YV+FXWlo/+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPe5XiRbsO2zq/gn0JE+IEDH6FOacqoMEMFU6qk7B9b87L+6f
	rZUyyLrs/t4n++Rs1q1HBsjBv3JtOjRBr15pGfN5TI+NoajH/rZVAJsMu5LAJmE=
X-Google-Smtp-Source: AGHT+IFR6avFKpr2wHph931hDBC2z+rTIPVUVlBNS/Uou013Y8gMhOrlNprLkZ/3P1WLSkHYPJBA7Q==
X-Received: by 2002:a05:6512:3b97:b0:52f:228:cf91 with SMTP id 2adb3069b0e04-5353eba3ee1mr78077e87.1.1724874560042;
        Wed, 28 Aug 2024 12:49:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea99933sm2248052e87.309.2024.08.28.12.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 12:49:19 -0700 (PDT)
Date: Wed, 28 Aug 2024 22:49:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Amol Maheshwari <amahesh@qti.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Tengfei Fan <quic_tengfan@quicinc.com>, 
	Ling Xu <quic_lxu5@quicinc.com>
Subject: Re: [PATCH v4 4/6] misc: fastrpc: Add support for cdsp1 remoteproc
Message-ID: <vuviyau3vbmf4l4mfb47lyh2n2t65fy3j2lxrg5jtyuz34kil2@q5ytlfdcmf7x>
References: <20240805-topic-sa8775p-iot-remoteproc-v4-0-86affdc72c04@linaro.org>
 <20240805-topic-sa8775p-iot-remoteproc-v4-4-86affdc72c04@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805-topic-sa8775p-iot-remoteproc-v4-4-86affdc72c04@linaro.org>

On Mon, Aug 05, 2024 at 07:08:05PM GMT, Bartosz Golaszewski wrote:
> From: Ling Xu <quic_lxu5@quicinc.com>
> 
> The fastrpc supports 4 remoteproc. There are some products which
> support cdsp1 remoteproc. Add changes to support cdsp1 remoteproc.

I'd very much prefer to see this abstracted somehow, but it seems
impossible with the current driver code.

> 
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> [Bartosz: ported to mainline]
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/misc/fastrpc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

