Return-Path: <linux-kernel+bounces-536325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D37A47E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D2A3A4041
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AB11DFFC;
	Thu, 27 Feb 2025 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANaK0pc+"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42CA48
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660433; cv=none; b=sOQEslV3zVvkOYj4113ukY5kYHIJR+BsEOio7Xmsix8CdFCmjGVTv9XAo7cnN3Bbv1CJO+OgFHGVw5gqumB7YmZt76C82c6cROTxsS8zY6RChEY1fwMZwcNMsXwCI9DFzxJdyaJa71zdJNeOlbVGrhB+B+k/rOnuID8/7RcAGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660433; c=relaxed/simple;
	bh=27TEdDkNVWz2XKb1y1K0Mm6R7JBGLRCjeyYTzkaZGT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dF5aLq7DkcZWKDBuce5eLwW4eqANZOSKC+g7WjIu5mN9u2A9aLB72xKWlgJJHxMoLbBTSdtQ/S8FkcJEjwBbmQzOny9++HRWPRzw79TnqnAl3T7x9CLIbrBJXmy5zuAyKe+WJN6L/X+RVaGw4+6QkC/oX2UoJci3eEeOofgBMPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANaK0pc+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e4bed34bccso1184220a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740660430; x=1741265230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvqGa2htjWCzP2pH+g/TGswl5kcWxTHqgNmoSeJM+0U=;
        b=ANaK0pc+ZLcN6j+KqDGQSOGwr7r5gi4wyfbBSftax8BsTdPOR1+mAe/8BjQ8t2o6HA
         FZZeu8GymLuyi+EwIPw2LTfkiV6DUthbf9H8C4DxznkAZJBA/5rJMrkCCyJAqwlenM/1
         S1uOb0saq1gI36jXe/A4x0Ec9UpOMGiTkrBhWT4Nx5AoPt2eyyhSX9Wwp8BOttjVI98P
         Nu9W9chPxrvKCJWs5egHapqjxmtgjV9BU3YQsMyj3+Ahcv1tufKsFSDtuxeKTLWNoJW8
         pwg56JKyLUYMaVwREd1E0J2ljh3d5ozTnUugWdPYQSA+5vw8+dazKju2ChAtJKMIqAtj
         n5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740660430; x=1741265230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvqGa2htjWCzP2pH+g/TGswl5kcWxTHqgNmoSeJM+0U=;
        b=tTDRnzu73wLG0whmXKxskX6jOYtxaabWOeT6peWOmH/n5bnP7qek/6hRnEK9fvssZ7
         sZyNRVk5plF8jWTcrKtttfMWY1gxQvbLo3W+90x7G0tJLvQd1Jenxs+WGlQoagiuuORi
         HNh0JIRNa9qI3V2Zx37B9yAPy8To2I/xT/VB+lMacBb+sLd9W6tzc/Js5GytvNzBxpZV
         7asvQkT8paRMoW16kZEft9dNturNIn/6hTROeWZhCyscK+fOe8/9VvFmZsjLBMN9Z4IZ
         3XNRJP0EYEYCKMhSEVhyVzu0rjTlblc77t9MKVTQgo7VJcnsvMOTs/kVYcm1TI1061Mv
         RzDA==
X-Forwarded-Encrypted: i=1; AJvYcCX2UWnqLv2y9tSgDgA92GlybqIJMeRU/fSMV2LkK8NNoaMwd2vjdK3JUUyMVIN+bDSEcNAu/mupiXSTQW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz800uQeWIfnSVUuz6scU+lKqKbi+WvGitMZrtYbs8Q246mu/3z
	KJeC9mcFCbybqLRyLChvPNAfg13Gurd6G7g935/Ce6tgFEtptz2p+LpenSn4djtlqeJaBMMXJo1
	S6RL1rX31TtiwECDUySdONaMfF7k=
X-Gm-Gg: ASbGnctRdHkg859fmonZnkILQ+5ihNaJbnoB1lvc+72LcT2SIV6AI+A/haVFt1av4lN
	lw3uLM8P8N6hjKCnhX7oxcz2v7Cc3nJYtovVVGra2M5GqdiAcUAIfHAeFU359gDzyFzhHaMvssf
	F3XvAgND805Hei0VUBcntlQ0QFiBQLimIJs/7uuQ==
X-Google-Smtp-Source: AGHT+IF5pHJNn+tt/WfllGhbNqS4qLd4mb6/LfonGkNV4Oa8GE6ZIsw0d+OoyLIIjPpLDYr6fDaJJccyenyFvF2Bjw4=
X-Received: by 2002:a05:6402:350e:b0:5dc:c9ce:b029 with SMTP id
 4fb4d7f45d1cf-5e4a0d45cd5mr9264486a12.5.1740660429726; Thu, 27 Feb 2025
 04:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227042058.409003-1-vignesh.raman@collabora.com>
In-Reply-To: <20250227042058.409003-1-vignesh.raman@collabora.com>
From: Helen Mae Koike Fornazier <helen.fornazier@gmail.com>
Date: Thu, 27 Feb 2025 09:46:58 -0300
X-Gm-Features: AQ5f1Jq7lUOKGmVudQItPekhexMxviW5zGUOt-yAkW-BhET87g_wogjP2LmxMqI
Message-ID: <CAPW4XYagd1TPQ6j6uEzOrcPpyA_+Ldpx86-MTzpb5iV+b+zRaQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/ci: fix merge request rules
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, airlied@gmail.com, 
	simona.vetter@ffwll.ch, robdclark@gmail.com, dmitry.baryshkov@linaro.org, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	valentine.burley@collabora.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em qui., 27 de fev. de 2025 =C3=A0s 01:21, Vignesh Raman
<vignesh.raman@collabora.com> escreveu:
>
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

Acked-by: Helen Koike <helen.fornazier@gmail.com>

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
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab=
-ci.yml
> index f04aabe8327c..f4e324e156db 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -143,11 +143,11 @@ stages:
>      # Pre-merge pipeline
>      - if: &is-pre-merge $CI_PIPELINE_SOURCE =3D=3D "merge_request_event"
>      # Push to a branch on a fork
> -    - if: &is-fork-push $CI_PROJECT_NAMESPACE !=3D "mesa" && $CI_PIPELIN=
E_SOURCE =3D=3D "push"
> +    - if: &is-fork-push $CI_PIPELINE_SOURCE =3D=3D "push"
>      # nightly pipeline
>      - if: &is-scheduled-pipeline $CI_PIPELINE_SOURCE =3D=3D "schedule"
>      # pipeline for direct pushes that bypassed the CI
> -    - if: &is-direct-push $CI_PROJECT_NAMESPACE =3D=3D "mesa" && $CI_PIP=
ELINE_SOURCE =3D=3D "push" && $GITLAB_USER_LOGIN !=3D "marge-bot"
> +    - if: &is-direct-push $CI_PIPELINE_SOURCE =3D=3D "push" && $GITLAB_U=
SER_LOGIN !=3D "marge-bot"
>
>
>  # Rules applied to every job in the pipeline
> @@ -170,26 +170,15 @@ stages:
>      - !reference [.disable-farm-mr-rules, rules]
>      # Never run immediately after merging, as we just ran everything
>      - !reference [.never-post-merge-rules, rules]
> -    # Build everything in merge pipelines, if any files affecting the pi=
peline
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
> -    # Skip everything for pre-merge and merge pipelines which don't chan=
ge
> -    # anything in the build
> -    - if: *is-merge-attempt
> -      when: never
> -    - if: *is-pre-merge
> -      when: never
> +    - when: manual
>      # Build everything after someone bypassed the CI
>      - if: *is-direct-push
> -      when: on_success
> +    - when: manual
>      # Build everything in scheduled pipelines
>      - if: *is-scheduled-pipeline
>        when: on_success
> --
> 2.47.2
>


--=20
Helen Koike

