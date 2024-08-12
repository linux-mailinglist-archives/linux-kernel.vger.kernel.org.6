Return-Path: <linux-kernel+bounces-283614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D078E94F6C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8A7283CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE718C330;
	Mon, 12 Aug 2024 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L3X6mVdf"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DF917A584
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487787; cv=none; b=lPZKYHl5VeEMJfu/F9/ep2tIQjxTZVeT+dKZv5OwytqJEg2VBLuQ8CWJzGo3NoPlKZOCVBEiIP1lX6kWul9ibBkVgSvwQw4eWsMaocIEBpVpAtYcJoT2WuHmjdzGRMW/YyQIzJmgrze/yLsod47vSz4u12c1zM6GxZsf/wuo3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487787; c=relaxed/simple;
	bh=XVEY3EOQ7EfM3BETXw06qP0pD8+sQ+yqKMA+bsLb1lY=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wge95h9IXPNI+w1Mk9EWP5CjV2qveDopTgw0Y71dTDBNAFCidjuRmgl7XNUf7ZhzioNVlIPyo1Mvhgjsnf0+zB2boBsdlAACnC9acVkoFnaP326MnkO/svkYpBpDrMBOe5Qg23QdK6+2KxuFJpzOFvCUV3c64KFjdoLdRn4U6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L3X6mVdf; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d0dc869bso285507985a.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723487784; x=1724092584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVEY3EOQ7EfM3BETXw06qP0pD8+sQ+yqKMA+bsLb1lY=;
        b=L3X6mVdfA/P5O1lyzBKTcZlu9FeGgdHassW5cydz5DRgnebugUHsUHihGMdvOCFaK5
         KfkbtzAs2asNlv+7REaIoG6idjtHj6GqLxEs9fLOBB+AaltjQAZIONZAEnIOOQRjdITA
         ai8z/hMw2uQRANgtgf08N5LoFQpBOOb1PKzjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723487784; x=1724092584;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVEY3EOQ7EfM3BETXw06qP0pD8+sQ+yqKMA+bsLb1lY=;
        b=kxXQ8RyEWUbtFQnjTON+p/0fBX2iqcOlzN2AKvo7ECg+C9AuqQcZlTaRNxcMPFjvbN
         PToccXX7QGAX5eQI0w72+bz43em4w49jlGe2D8miKRIK4sH85V3+fwIEM07IEOj3z9hM
         OWtNVpTF/mtl8kMhp55gaIx6PWnX+1gU9vFJzn6DCkD3pvKq5WLhuPTW49TK/LiQGwZJ
         N8I2Ii/vwsWb6r5Xty0aeoRhrHtEqynWl+sjc9P6MfUo9d1+njyfOchVPVEKRNNRvYU/
         gqjnts6V9o6v1mqGUypCStU/fOOlmXsJ2Z68luzQKLJ+Vs1Y40BVplMLIC0YXqXhRbfX
         mo7w==
X-Forwarded-Encrypted: i=1; AJvYcCUzqgUEBVNdJVB9HRTu2JV/Bj4KGU7bDZF4p4CfEgKndH89PxQvGqh7NjtlQNelQQ/lt0ZYB9TNmEW8w8yjDN+ETkzomhLIRQ0nqCsY
X-Gm-Message-State: AOJu0Yxb1Ad3laiD4c41rj3XMJDwd9tlh5DlJQdoecM/E6TNxUfFCzPY
	VtQlCyZDNGg6mvf0RsRRLVbqAL2u1130y0yJPNOAsnxQoZa0RSC6n4w6RqTkX+cDmD/HgWakwb9
	0+VGHEXqd8pqWbl6j8I1doEYZNDiuoJiTDPOp
X-Google-Smtp-Source: AGHT+IHmoofWaFYJnBjW3Mad9MwbSlnA+Lmn21+JRVXHiDX9eb3lBTF/fIYOBI/SdgNYe7IAkY5SEsY8XTjEOJNFGZk=
X-Received: by 2002:a05:620a:4010:b0:7a1:d73f:53d2 with SMTP id
 af79cd13be357-7a4e151bd49mr129101485a.20.1723487784514; Mon, 12 Aug 2024
 11:36:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Aug 2024 11:36:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240808235227.2701479-1-quic_abhinavk@quicinc.com>
References: <20240808235227.2701479-1-quic_abhinavk@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 12 Aug 2024 11:36:23 -0700
Message-ID: <CAE-0n523aJOogAidORYJNGUG4aW9Eq0wzoD3U72i8CFF=BqsaA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix the highest_bank_bit for sc7180
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, freedreno@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com, 
	dianders@chromium.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Abhinav Kumar (2024-08-08 16:52:27)
> sc7180 programs the ubwc settings as 0x1e as that would mean a
> highest bank bit of 14 which matches what the GPU sets as well.
>
> However, the highest_bank_bit field of the msm_mdss_data which is
> being used to program the SSPP's fetch configuration is programmed
> to a highest bank bit of 16 as 0x3 translates to 16 and not 14.
>
> Fix the highest bank bit field used for the SSPP to match the mdss
> and gpu settings.
>
> Fixes: 6f410b246209 ("drm/msm/mdss: populate missing data")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---

Tested-by: Stephen Boyd <swboyd@chromium.org> # Trogdor.Lazor

