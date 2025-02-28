Return-Path: <linux-kernel+bounces-537855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30787A491D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E373B378E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6D01C4A13;
	Fri, 28 Feb 2025 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oaqnh9/x"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736121C3BE3
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740725939; cv=none; b=mQKfokHL1FxSr8PNXz8v7sHHe6c4OHNtpPfXyOI9gY9AQ9+nx+UcqITDR8heaoiHhZ6xg7V6JcJ6UgtsGEiLN5gjr/PsxiUkWzDSQZMIsgZLVUQyyfisM4JI7vjhHGmUU2a+GnAv00d24Dxxq/OZYhXLf2Vvg1EFInhNPcxdFhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740725939; c=relaxed/simple;
	bh=XS1SOw+xZskedWAzYcovczJoNViBPFG0jER6+blu4Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4Y0+EufiwY7sQMBKEOPAuNLS0w6OOfTmiWQFuUJ8loAtg/m7ZMkHq2NErA5vOduSYaTWOtu1ZdFqqxANQxfUeH210xrMMT8Mjgls3mOz7qGTpC6aHUazW/Me3Eooqwtl3vHCJjZBlOpNREKIzidRApB2AnLmwBM5zlSZZQfoVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oaqnh9/x; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a3092a9ebso19137221fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740725935; x=1741330735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQkBn9pZaZLQM8Ql4ItONo7JwUM9lavMBRm7WilNhdQ=;
        b=oaqnh9/xwq6pEMo0SDSGRaar718z/g3eqvbG/HmKuU2onAlX5rj1ModzPVCZntHTnP
         KbuEXgCnbhMKkWf1CF6lYrwdbO+jBfbO7znvq7FIxL7aBJIEqSVdgYwj1AjfXCXCbvXO
         TL4Wfb8o4kJLb/1sejf28SceUGDYAxJlOXoP6bmQaKj261jGJHlS9NL3BKUIR8ll5YCh
         JblHc3c6PJ8mJDJ+hAyuOHs3F1UQc+nTLs2IRmO138WrEsVAuKBhmXYwR+EErPmPKxUN
         xalBsy1CMCx6gyUsxr9X6sAGRDMq0ykULoa6dKqOC0QGWjM4i8wMw7iZxeBaTplSNsFZ
         qg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740725935; x=1741330735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQkBn9pZaZLQM8Ql4ItONo7JwUM9lavMBRm7WilNhdQ=;
        b=jRvTSqeqqN1ERer3oy16h8jVGDXgA0mGipgRpR2e8HTSM3sQL5I49vRmDzw/y4lzHG
         W7qgwUT7dr5As1VQ2TE0QiZ00upNQMl9ZKMg1CPCuejWxvB0bb34LTbiQOUB04PINJV/
         omG/A3nmywuFgLmBduqRa9ig06Sf40jvC/liVec6iL3egrXMSKdO9LQ9TE9vC7jY9Lb4
         dvsy8JKFQP5M6EfS5xyChRQ98kpcrIrjKAVdJM4e7rKrrvt3S7uqLDrvoSmxh4834rbN
         M3sRe0SlUBJtPkY1/mUqWDlUsTPsADwL15YvD/BuLLdfk9mnTJGmHZwQ6+AhP45WFDcp
         SLig==
X-Forwarded-Encrypted: i=1; AJvYcCWFNjPWQvsHIH01uXBGP9yUBjSzUHPpkImbzHxM0NHx/VXBoEeHZb/TdGvxUVWEu8eQh4SCyeeRXgGfJY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNfp8VK/q7fl7bp6H4Ts9ATUHSFxWc5MxG7tiLjVn0Ojv0z4Hn
	cpT7KCc3pM/zKEXEwdtPA+Y4AnrDdkO+q8uy0lMxoKKVyN9XTXd4LohO2lFwmb4=
X-Gm-Gg: ASbGncvIH9jF7UaH5q4lwuIjNgoJtvUAsf2puAq41h9/T8zjDO8Zs+M4xDNiCjqpzhf
	FOwEpTN0w0LK75ccONzZk5wLVoex914dvFp/pUJPMti8fAvAd/DdsrIi0Oh5Aytf+PHNLthGiwX
	JorcosJmsESJD8PJFf25392a2lWcH/KCI9VGZBDtH8kzOSbNfu+H5Wn4TETzuneq+sNWEPa1Z2s
	l5Lp/bqIJqrK/vT4MJjyLf97w9d6mtxt0uy2Ux7zAupwLo6s2VqBNCt4nvFKin8c5U1GGcSAgvX
	vCc5P4sEeZUwBnmVL5HpatpBgBApGS1mE2Hm697T2f726Uskcl2bnW1bIWE5tIMowwXPxgdRc9X
	YmGjm/A==
X-Google-Smtp-Source: AGHT+IFDMeoDRWEnz1lfwT4TgHJX3JoksLPN52Cp1f9xNEKdtsShVpbuBeVPqD0tmnmNbGvoSmxnyg==
X-Received: by 2002:a2e:bc17:0:b0:308:f01f:183b with SMTP id 38308e7fff4ca-30b932004e7mr5943981fa.2.1740725935453;
        Thu, 27 Feb 2025 22:58:55 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b86875f3csm4094371fa.93.2025.02.27.22.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 22:58:53 -0800 (PST)
Date: Fri, 28 Feb 2025 08:58:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, robdclark@gmail.com, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/ci: fix merge request rules
Message-ID: <ondpwjsgujhk7wo3gaajoeamcf4gkp424cxmyslwsybrlkzo5f@xh3yx2r2mp6k>
References: <20250227042058.409003-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227042058.409003-1-vignesh.raman@collabora.com>

On Thu, Feb 27, 2025 at 09:50:50AM +0530, Vignesh Raman wrote:
> Merge request pipelines were only created when changes
> were made to drivers/gpu/drm/ci/, causing MRs that
> didn't touch this path to break. Fix MR pipeline rules
> to trigger jobs for all changes.
> 
> Run jobs automatically for marge-bot and scheduled
> pipelines, but in all other cases run manually. Also
> remove CI_PROJECT_NAMESPACE checks specific to mesa.
> 
> Fixes: df54f04f2020 ("drm/ci: update gitlab rules")
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Run jobs automatically for marge-bot and scheduled
>     pipelines, but in all other cases run manually. Also
>     remove CI_PROJECT_NAMESPACE checks specific to mesa.
> 
> ---
>  drivers/gpu/drm/ci/gitlab-ci.yml | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
> index f04aabe8327c..f4e324e156db 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -143,11 +143,11 @@ stages:
>      # Pre-merge pipeline
>      - if: &is-pre-merge $CI_PIPELINE_SOURCE == "merge_request_event"
>      # Push to a branch on a fork
> -    - if: &is-fork-push $CI_PROJECT_NAMESPACE != "mesa" && $CI_PIPELINE_SOURCE == "push"
> +    - if: &is-fork-push $CI_PIPELINE_SOURCE == "push"
>      # nightly pipeline
>      - if: &is-scheduled-pipeline $CI_PIPELINE_SOURCE == "schedule"
>      # pipeline for direct pushes that bypassed the CI
> -    - if: &is-direct-push $CI_PROJECT_NAMESPACE == "mesa" && $CI_PIPELINE_SOURCE == "push" && $GITLAB_USER_LOGIN != "marge-bot"
> +    - if: &is-direct-push $CI_PIPELINE_SOURCE == "push" && $GITLAB_USER_LOGIN != "marge-bot"
>  
>  
>  # Rules applied to every job in the pipeline
> @@ -170,26 +170,15 @@ stages:
>      - !reference [.disable-farm-mr-rules, rules]
>      # Never run immediately after merging, as we just ran everything
>      - !reference [.never-post-merge-rules, rules]
> -    # Build everything in merge pipelines, if any files affecting the pipeline
> -    # were changed
> +    # Build everything in merge pipelines
>      - if: *is-merge-attempt
> -      changes: &all_paths
> -      - drivers/gpu/drm/ci/**/*
>        when: on_success
>      # Same as above, but for pre-merge pipelines
>      - if: *is-pre-merge
> -      changes:
> -        *all_paths
> -      when: manual
> -    # Skip everything for pre-merge and merge pipelines which don't change
> -    # anything in the build
> -    - if: *is-merge-attempt
> -      when: never
> -    - if: *is-pre-merge
> -      when: never
> +    - when: manual

I believe there should be no dash on this line

>      # Build everything after someone bypassed the CI
>      - if: *is-direct-push
> -      when: on_success
> +    - when: manual

And on this line too.

>      # Build everything in scheduled pipelines
>      - if: *is-scheduled-pipeline
>        when: on_success
> -- 
> 2.47.2
> 

-- 
With best wishes
Dmitry

