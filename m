Return-Path: <linux-kernel+bounces-518279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4847A38CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497D23A88FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A4A237194;
	Mon, 17 Feb 2025 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1VlwnEC"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A510372
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821920; cv=none; b=pCRSX8iYwpbz85//+t4jufzxLpNDVteTahxsDgvZU9cC98tlDRx0RARk9qUUVffN5UXKR8TFuaj9iDKmA1GLhHMHPifyqi+EwdWbxczAxIZHLlR7aOOSxh0qDjLlxxW0JP3WDQDQFFQ4AQ6RSEyw5y4/ffFsg6uiQ06C8Uk+qI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821920; c=relaxed/simple;
	bh=Z1UnWnZLxSNI4+SbOFhsVv3Rm88k1kFKTLG4c6e3yk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWjALyJjoSF1Pk0S5HMkl+qZEi96SFXnkvRONj54jtNymdrBzk06dYcScD+MgJzivYFaPm/pOW6RTybLymW7KBRpmm/BEbjHli6rTGp9nkzjcy8t4geecpoDot9SBY8s7h9NNRzqFP+Rz52DVQy+HpVz61E3vqWYFnlqIeEn5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R1VlwnEC; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30761be8fa8so51283161fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739821916; x=1740426716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=du441ZCOQupNPXiNMHUbWNZp53UAbJ7rrRkJ3qKot/U=;
        b=R1VlwnECBrhCRuXmeyHvFwN46B0J/+4gGVtdIXkWKvCZX8cPK9T5OmPEtOouLOC0oh
         80K41066YSt/0HPIAvvHDQgOFERDmiIqhkEgkCVCPv7Z3s33OOJLf7SrZ7um0L1kVlRY
         kPMvrLc8BuwaCFeEZowfi8Qn3KYnhS7ymfMmG4+Bk310Rs2M+ZNACjABz/6IL3DrGE/+
         Rcg4umSrjYQjPaYw0LxAv5shPxlDusCYIwNQ2R4m+ekLfHRNXJO+ITAOdvgy7AUr7n/Q
         i6gEw0vnGuP4lN9xPXbNchwktMPjFdAxcGNTsPWpvdz327ORCF6gBu8k1cGQYk55Fg8P
         mURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739821916; x=1740426716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du441ZCOQupNPXiNMHUbWNZp53UAbJ7rrRkJ3qKot/U=;
        b=gSzbFNNBa5nHG1nnLRwj0MMUWJc0k5L7T5c5ybnig5IMfEjpGpDImgCwv4msI9Dxrv
         xXna+f+yti8hNyY3Frsw3juSaRAtp2GXqxdX1507JQKfGJT1HbCdHG9CtVRFAwCNdgFG
         k65nH+QyxVC7sj8iffLNI9EOYuYAUoD2tmNb8D68nEm4N7aUGNLwFWjcXP9Ll3aYTpGl
         dRk0sA60Kqj1k5UxqW7knR3eZbOtdqUy8/oisvAA/7ssIIKzyy7u8hdE04QGgwS6+iez
         bV9gCokl0DP/vw8PmBLWLu0EG7h0+esIfhG98mWNVY1SAx3KbNsfJVsy0JYwLbCvTc79
         Cckg==
X-Forwarded-Encrypted: i=1; AJvYcCVXDmrs8bAFvzwmFIt5kwUumxKY7YraVrdPNti208KCbY1KmKzLs6nD6vjaih85fz7/BY/1GVT1rsXcdAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA1zGV2BuLwpvRgnal3tGzxxUTvLM9bIR+yB1eItKzggw1g6l7
	s+O+q8Pn1i6R6RTuytmCjDzeU2u+uitBFwCR7FTTZSUQOogrldHJO5TxFnuX+Go=
X-Gm-Gg: ASbGncvazbVt3GkIwkixHLvyYID70kSZsWxtjeBcbxFMSawprs7GI/THwgPjFB8w5CT
	rQvbCpaYTT/qd4GRt+O73n+Xc7O5Mdj1FyTqHZXIPr2EuNer6Md/6AEHXKPvIzTArNY7XszUjC5
	bDY0luQglAplxCyOCIBZpzeR1i3N5VppdkUVTxpmZhVRcrDViw2OfqvG3HV/+A6sVvIPU3Faedj
	QU0FRJZ8xIRfu9qx9F15wzXAyME6DJORCPev3yrKnoSj9nI4zKT0mfR0axSGrvHl1XRBGMyezoo
	b16FSojyE/fqVMhoxy2xsbcqTqW3f+DNTvGRpLZQ9m5PfFwGgzLoRc1rSFbv8UgLa59pJjU=
X-Google-Smtp-Source: AGHT+IH1cgaF5tU76THnhAXO4GxVx1EqnJgKWJ8zkZhai7T85xKUgyK77lVetaexQtb3yZ7M3uAvow==
X-Received: by 2002:a2e:8657:0:b0:2ff:df01:2b43 with SMTP id 38308e7fff4ca-30927a6f5bfmr35430101fa.18.1739821916381;
        Mon, 17 Feb 2025 11:51:56 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a3a6d3dcesm1478471fa.67.2025.02.17.11.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:51:55 -0800 (PST)
Date: Mon, 17 Feb 2025 21:51:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/15] drm/msm/dpu: fix mixer number counter on
 allocation
Message-ID: <2gpvg22nvrmcm5ln3ft4oovt3xy5uedvw5oehb3odf74mvvhkn@hz7wwy7jf6cn>
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
 <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-6-c11402574367@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-6-c11402574367@linaro.org>

On Mon, Feb 17, 2025 at 10:15:55PM +0800, Jun Nie wrote:
> Current code only supports usage cases with one pair of mixers at
> most. To support quad-pipe usage case, two pairs of mixers need to
> be reserved. The lm_count for all pairs is cleared if a peer
> allocation fails in current implementation. Reset the current lm_count
> to an even number instead of completely clearing it. This prevents all
> pairs from being cleared in cases where multiple LM pairs are needed.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

