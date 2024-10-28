Return-Path: <linux-kernel+bounces-384566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7B49B2BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7771C21ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9AA1D043D;
	Mon, 28 Oct 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zRMt8avn"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CCF1B4C23
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108717; cv=none; b=bweyyxc7sYVbCQ1HhKBS+0v9tL+l52Mv2VsE4yyDbIRJdaX4WiEIdEPvR3OOXY7f+0aZc4wvedRaBCDYL8uXjSMcYw98/9aDF/YZNRmugEK4aYBsLuWxwoIca5D6Y2Vdhd5bDqbRik/ECc0thnT9XfsIW3dNnpyGz5MDaXBKUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108717; c=relaxed/simple;
	bh=3MJitMTYQvzBLNF9sMRy5XkzlRGBVvd92VB0tZf9Aw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQg2jYQdFbbtRUmtsp9939B4mRiuDPayLBD5XZG3RQ3m3TqdVJvStIXPTG7+dhFp2Q043zSMzPSEJsFDaN0M1z0hAPJ2tpOTYoh8+PTT5xxuaw3QS11kEr/FG9QhOY1KSbIzReXzXFn1XyW5qKJERPmgNSw0yi3sBBjpSco6gAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zRMt8avn; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e2e41bd08bso47426807b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 02:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730108714; x=1730713514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g4purl6VOxzkEsnc4oRLBmu6SBR+DzFv4k58o2DEGGI=;
        b=zRMt8avnb3pPMZhOuT5RY4Ap367apS++2d2UVA7sFbqOv7DD4QYPwV67zV0z7+WVGB
         Qv3yOuwUWWWTXxHjvo05ro0i4JCOSt4QItW3t7zYg6cHZeDQtJYlu+EGa90Uus0SwZ0l
         Ek40bCkHVj1JqywsNXj9JcQmPTC3bVSV5DhS9A/rjdmeQXutd8M8UzPfW9xnhRX9u++Q
         DPvpCnm+kv7Yx6O5verteaA4LaUl4zI68gleBPBXhYYZgW+nYBFwSzKKmjTu4uvBm5Nt
         vWHo/KxMO5DHCQBmr5Bj72vochCEbp1XPY3bhluzZs80dnkw1pr0z1HG6JkOmUlwINGd
         9Ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730108714; x=1730713514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4purl6VOxzkEsnc4oRLBmu6SBR+DzFv4k58o2DEGGI=;
        b=pyqT4sy8yOQYLCk0bwUV4y9Zyc/6UMh8mkUsqEx4kmuBnvGm7LkOA/Lrt5GMW3/itX
         x7nDhwvaFC/X6cnybG+/utR0WW2VGmq9it0wp8whfQl09EngaxD+LyCwfj9OW1JIk1+N
         3gQmHZj79u+dsQSmI66n/ZBE0WqlIv98G0LHUHjtl3tCd0QXYidyQ54VfZdTjkAIX9Hq
         7Nr6YHFl9E50kFRJws/MV/inwsKRKSLdE6fFWQ2ZbBZ8UStMGJS0QX7zVtF8MsfLmSy0
         PEd49bUGhxMD0KBgIV1Bo7VkaY8c+gJXvEn/I80pYt0ZOo4U3RGObNzaQfZj/FioiipK
         x84Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvXoTwTWfU45+iqmcuRC9enuY0imAlk21iyxy9YeWK/F3zf5ZWvUx6V/3cSrdFu+21yJCyzAnNJg8vdy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUnuHB5+nuNROk6ctSP2qBoJqC0U9IzFkJSnwS8xRPdELz2FAo
	EOFL1iAhfWaNiaokWVtHE9Frn+v94dwhQpUTyi5t3ehxSlAi/xDs3GPKgnUfQ7Z8a6bua/ciB9y
	A21lOPxHyMB0o6KtDeNF4ObCVQb86xO8mfTmXdQ==
X-Google-Smtp-Source: AGHT+IEupfDCefy6TjFI+paigzl6D9rWDxC4Jk80B80GSsgHE9+Lq4uZCFPuhfxvwFw1FlZEne+hFMVgPQDcMc6ZhUk=
X-Received: by 2002:a05:690c:45c4:b0:6b1:735c:a2fc with SMTP id
 00721157ae682-6e9d8aa93a3mr66763297b3.27.1730108714055; Mon, 28 Oct 2024
 02:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008112516.17702-1-quic_mukhopad@quicinc.com>
 <20241008112516.17702-3-quic_mukhopad@quicinc.com> <zluuezrywecffsh3f7yzrtvd2sa3nyzl52sk6bluvjch5icvuu@noecozosseko>
 <e7543055-316e-447e-ab0e-15d2fdd19dca@quicinc.com>
In-Reply-To: <e7543055-316e-447e-ab0e-15d2fdd19dca@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 28 Oct 2024 11:45:03 +0200
Message-ID: <CAA8EJpqcnxbZAUJm0fdbQNjZ3Dw189oDMkC+0pMLz1XGO7HhnQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sa8775p-ride: Enable Display Port
To: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_riteshk@quicinc.com, quic_vproddut@quicinc.com, 
	quic_abhinavk@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 10:49, Soutrik Mukhopadhyay
<quic_mukhopad@quicinc.com> wrote:
>
>
> On 10/8/2024 5:46 PM, Dmitry Baryshkov wrote:
> > On Tue, Oct 08, 2024 at 04:55:16PM GMT, Soutrik Mukhopadhyay wrote:
> >> Enable DPTX0 and DPTX1 along with their corresponding PHYs for
> >> sa8775p-ride platform.
> > What is connected to those DP lanes? If they are routed directly to the
> > DisplayPort connectors, please add corresponding devices (see
> > dp-connector).
>
>
> We are defining the functionality of gpio101 and gpio102 as "edp0_hot"
> and "edp1_hot"
>
> respectively. This ensures that the hot plug will be directly routed via
> the display interrupt
>
> line "mdss0" to the display port driver and no external dependencies on
> dp-connector is
>
> necessary.

Please describe the hardware, not the driver necessities.
If the board has a DP connector, please add the node. E.g. it allows
one to specify the label and the type used by the connector.

Also could you please fix your email client so that you don't have
strange/unnecessary line wraps and empty lines?

-- 
With best wishes
Dmitry

