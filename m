Return-Path: <linux-kernel+bounces-535582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC9A474C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CF7188D479
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438841EB5EB;
	Thu, 27 Feb 2025 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ybQgXjgz"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEDA1D4356
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631073; cv=none; b=a4kDIib5VGQjuH9iLeBL2Xqn5I2wXUzj3chjYD0d7Ydl2escPAm1B6le49S1y4PmBFTeY5Hd0A5xV5raYjr/GNIXoK3vNiQUNs6eFqtSeV9/Zfp8TFaSLeje0nKH5xcIBDoddX6HlHgtkMoQqA3/+cgOga7sJYfNglxV7JsJezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631073; c=relaxed/simple;
	bh=3jBk0MgEeBJiMl0PisR+0OksYxGp0Jvkm/YSGldYGlg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdwQNVRFelQwAegxvXrKwFQ2nBWazD4iwKrG2TLPek2+6M71clSjMHnYSW+r+VGkolYW5hHavuTr91u3Jl4VYY3xmz7+iolOnUHIAdQ6sP5SvfT10DhLncWESA+jCOiS93E04RDVtfs+EyYUgjyaMOlMjwUGCLofBP1agcK1nlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ybQgXjgz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54298ec925bso738465e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740631070; x=1741235870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6LdIc9yizVRu7YYWVAkfBn83oMhAPA8mxliRfutysA=;
        b=ybQgXjgzfKWFRPmzvAkBz0Ba++ft5yR8ckN3xb2oL2UDZMgv4nL+PLdZZ2KirfFQe6
         tKLOSvog8Z3fc5PkIxsTKb4IcDknacjZCpRiNILC4hFAdnOpjp1DcxY23DZDxrYA1gpb
         baCJJclES8HNpVkvEObXjBdaZIj68BPJOONGbxpJP8wFTc5/XJlPSNom3DYg6f2cJbHu
         VdsHRqv2rjYKdemkdUF45zxCMNqEWkEj+rG0IwYr1BkR4pNrHI9Fpj61FK5Kmtho/iaZ
         aRrZY/ZcPcvDWVC2XxMsSBcqToDlh9B9e9n0GegNadeJ8zCYnTYnY7FR6759DfbzGQsM
         Bv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631070; x=1741235870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6LdIc9yizVRu7YYWVAkfBn83oMhAPA8mxliRfutysA=;
        b=DO0P/XoI8Y7TBO/hDVNtD8v9bGrkKdX8efQv6WEvoI4eZeU4xaZkT7G2IgIK5qtVQv
         12MFsmBM4jZ+vAlSaNMY/9yusmxh30I4EDjQcU1Vg7ZgqnVbi3Z9ElvCdLChoJigzM37
         vE8Oc8EmTkOmko9FicGs+yN97cctCk72hH9CRKjzYxAYseAIRpbhFFFm9LqRsl7kS/6O
         skziPHPyd8H9lSsuvJgRmDRQYRUE1UDM3GXx5DLUsheI6fDCJSkSE6x/E9GzmLo7CSQw
         ee0HcipjY3jBqrWJ+VZtHEd9e9fqPx+56rxhDtVJoR6nrXqE6AlwDarayhU+NmwN5wGK
         x0rA==
X-Forwarded-Encrypted: i=1; AJvYcCUCEB9Lye+DG02UNx7hg5A/oKPDW6FrpGU8CmwK1A62X2vSMaiYYZoGdbO/O956fCBDOz3dt3mgSRDqhlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcgJyIPO4rrKM6NX0nTiK3Q2a6Vv4L69T+Hsl0y1A6FZWjbjMU
	F9L+RTchWIAEF2y1nlrq638u9YZwmfbkzx0Y9xNEOr4V36z0TD/o1wNpgrMJkPg=
X-Gm-Gg: ASbGncuzZDZ6/NOVeL/SSMVH7r0FP/V1CG0YzBa248A7S2F6I5FympT+zgjYTus1KwD
	CGY4HGNT9mKXUlDuSJktayDTSckboLZOAwQg634jXPo66MFq0IUeEU/N9fMdoY2sYSJ4X47BKaU
	ewgyAiup9H5z6TeATt1iD8iKIJRTgKGufNkGl9txFjMWN2WropiRE4/Drss91bXOfheohN+FjVm
	yvjCgsLUYq3Qd+VaynQ8h7l+78GFyYIAcjfoB5eiCmZqFH4b5bX8kINMIb7lvaB9+zrbzYosUmH
	nHih4ovkmDuD7kmsjpi4kEe0Z+lz6EbgYXd0ECwqQA==
X-Google-Smtp-Source: AGHT+IFVfY7P3tdpU/L92xnHX/l/Kg0ZrZYS+uJyaV20SbfgsFQttCuFyDGhgqjNFTbnxyxtm9a5Og==
X-Received: by 2002:a05:6512:1389:b0:549:38eb:d68b with SMTP id 2adb3069b0e04-5493c5adc66mr4548301e87.33.1740631070243;
        Wed, 26 Feb 2025 20:37:50 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccf45sm63485e87.229.2025.02.26.20.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:37:48 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] drm/msm: Use str_enable_disable-like helpers
Date: Thu, 27 Feb 2025 06:37:27 +0200
Message-Id: <174063096235.3733075.4349530732188818370.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114191724.861601-1-krzysztof.kozlowski@linaro.org>
References: <20250114191724.861601-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 14 Jan 2025 20:17:24 +0100, Krzysztof Kozlowski wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> [...]

Applied, thanks!

[1/1] drm/msm: Use str_enable_disable-like helpers
      https://gitlab.freedesktop.org/lumag/msm/-/commit/25dc6948a06f

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

