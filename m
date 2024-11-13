Return-Path: <linux-kernel+bounces-407546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D19339C6EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F1E283106
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4244B2010FC;
	Wed, 13 Nov 2024 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQ5B9VbY"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F242010F9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499687; cv=none; b=Zz+gJKMR7in5Kvy6bV23wI3rNXpxcIK8NpZncj6c6UKh8r6MgvckOBpsi6tOR6lJV21F6xYwvNy0hwRTvHwT6DOYcGFBLlk5rRqYUGEeJKZwoT9RGk3b9S1uSmWJL6fYEMJyeDJdBwTRftKvAqivQDNkeK16cprhZBWcEqQY2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499687; c=relaxed/simple;
	bh=+SQAYrBZEZritmGVvyh7dsWuqy5crTgzuGtLDSf+ZQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5doaS/bGg3d0N/h1PM7w23f57W6lmVX3D0aRtsd+gYERZevYf6Lq4iE/havO6EaDan00DQDlOdADld7YjTdg4CLDPZ1Ash+ORMkB7SwnSCe4aBJem5RMvS4B/UpZGmgVxtiaquvlBoQzVrRfuTgpHNXMOOCaRQO6wSCtW+noaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tQ5B9VbY; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e3cdbc25a0so68445087b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731499685; x=1732104485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UGtyXwzMBHOXtnkZD1IDl7RIyBTD4iUeJ455sdaUv4M=;
        b=tQ5B9VbYSy/+lKDTj6hJcjXRFxw1V5Vx6+c9555+2gHN7KaobXWkXJZy5MCXustSo0
         p43uOasU2nFAufh9uQ+PY5MaGQLgaXnD4SvRhKBbjs5RviEeSGrctV6VQRIEADlyLVaY
         PIzg6Per8l1UKet1x9AKvWHQwMI/R6UKTBKFOMbMoN5ojvFVfMI7XZFlBL5whOoSIsv6
         ufXBIu2ptJ/MDp/X1srzfDfnlXW+yoMvj0H/FBRNjHvlfUsbgcBP+jbhYcvTd1POmiIT
         kqCbE4jW/LqfPQ8qia1jEBLS6FMqqDgsooVDic5kCrvAFB8LZ7Cw5mC1EepC6PVfFsG1
         NAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731499685; x=1732104485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGtyXwzMBHOXtnkZD1IDl7RIyBTD4iUeJ455sdaUv4M=;
        b=jp6WpCKp3gHUb0M4BmLBZvtzjkBr4dfyvtACCNm1n/9a2phNVSqPtYpVriMCh6UzGA
         qXIWqcDANzERpt9qMViM3RcxKxdV9ZBBWEU7scRe9ppNeFj9+Q7PgCQT0bNQi7t04n6R
         yu5afd4rYUYEbNj3Ewep4qCW/vL/fcz9BZ2Eu9Xpx9cKQwgMWc1kj4dJ/IOFvHuB2Dqw
         z1yzQYMi45HeOVvT9awzQrn5Ru23h4SPrsNOvH/A2QQXfXB9y+Y0FNNkrcbzft+RB1+Q
         Zc+epirCyrFau5PvOXL7dm7A8QRJEuLabfVq4wuMYh2DotlaN4jcxjf+26jxVjivHlRq
         DiRg==
X-Forwarded-Encrypted: i=1; AJvYcCXBG5BpUYhm0J0Jjt+HyGzVoRvLLlFBRFKqCQAQUXHUGaKYyDLdA753piPbT4N0YjeJsaIQmdkT8sZ+Ld0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzfVS5DztTurey0edQDjvYf6t4d2b29tdT9TWZ5gZ/QLTrXwCF
	lVWD1xd3mAmvLNxHzRNExBc2Jm5XbigYTXoA9xJkjuGy+3XxZgC6e+IvDdF1HkMZ5ECJzY0ElSq
	V1Cgd8DoKcm4QYpVpNTudlYKeSmd0f1844/yxqA==
X-Google-Smtp-Source: AGHT+IGfdj17ZRR0vuBfO1QBwX6EXMq129/94BCmEcrTpxI9KLT5gLVvRTesocXnNuXdBrs2dgVgRPYFjcVuJRn6J6s=
X-Received: by 2002:a05:690c:7485:b0:6e2:2c72:3aaf with SMTP id
 00721157ae682-6eaddf81805mr207193107b3.31.1731499684980; Wed, 13 Nov 2024
 04:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-add-display-support-for-qcs615-platform-v2-0-2873eb6fb869@quicinc.com>
 <20241113-add-display-support-for-qcs615-platform-v2-1-2873eb6fb869@quicinc.com>
In-Reply-To: <20241113-add-display-support-for-qcs615-platform-v2-1-2873eb6fb869@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 13 Nov 2024 14:07:53 +0200
Message-ID: <CAA8EJpqQA3zDBRpm9FY5X-vS0aDgoGNFfDoTh9p1A2MqVa7KNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: display/msm: Add QCS615 DSI phy
To: Fange Zhang <quic_fangez@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Li Liu <quic_lliu6@quicinc.com>, 
	Xiangxu Yin <quic_xiangxuy@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 13:53, Fange Zhang <quic_fangez@quicinc.com> wrote:
>
> From: Li Liu <quic_lliu6@quicinc.com>
>
> QCS615 platform uses the 14nm DSI PHY driver.
>
> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> Signed-off-by: Fange Zhang <quic_fangez@quicinc.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
> index 52bbe132e6dae57246200757767edcd1c8ec2d77..babd73cdc44f6d12fdc59c6bef27c544d91f1afa 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - qcom,dsi-phy-14nm
>        - qcom,dsi-phy-14nm-2290
> +      - qcom,dsi-phy-14nm-615

As stated in the comment to v1, no, this is not acceptable.


>        - qcom,dsi-phy-14nm-660
>        - qcom,dsi-phy-14nm-8953
>        - qcom,sm6125-dsi-phy-14nm
>
> --
> 2.34.1
>


--
With best wishes
Dmitry

