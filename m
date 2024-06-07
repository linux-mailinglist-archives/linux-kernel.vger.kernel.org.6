Return-Path: <linux-kernel+bounces-205957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B0F90029C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D061C230B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324A418FC8E;
	Fri,  7 Jun 2024 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIfOgY4O"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEFC18C328
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717761034; cv=none; b=RncqHI04t92N0amyTwpmWELscbzQJX8EGY3ItENL96rfA3aaKAT1eY9BWqXCuPf01UWjemUDy8RNYfSVjbjogLaACvK8T1EfYWI33dpCEdzT6OvChsCZr0DU50D8q0fFJEiQ9gpud9IENtvfjdsFrP5L8Len194uimmGzyRFCDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717761034; c=relaxed/simple;
	bh=wwGWvexxsp5XY5L70dQnxGHTPS4bWU8DrXd4gNmOcAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVjbiQ5U7bNSFe82eS1iR0HFYtQgexk4dF0d6ek5gIGpMB5p+zJa6+KFdJMLYBkB9I5SDWBTduWSbtUBIpFd65yelDrrRuM1xBzfUyijjnR4cmW2KlyVExRrzYtVbvlPJdFd+6nB+CDrQqZsyoG9PHpjAa9AD0D5bzXKenyNlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UIfOgY4O; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52bc335e49aso76529e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717761031; x=1718365831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8YSZ1xf3JS020wtDYuRSc4/MIriNLZ3fkqQQXeB5h0=;
        b=UIfOgY4OwsUBgYVsw0Cpe7LtJy9xXiLoTy9ULEH1KtPYaIsj1KSp2uJhimHGhLV98E
         PLRjZS1/oP9nQDvFLSkJj4oGvgtaIj6/t6QmWnU1he7xnf9KFLm79o5Gv2jY+eBYIAfW
         inVEcWoSdGurppGEvVD/4p8S5UUI6ixJbHXNfZCHoWBFSii6mUG7/SNwk8/BYS4vGtQL
         1bcThBCbo+tXFLkxIxTLaPOm6nkEhd8zO4uJOHGrn8OGJo05rUvMZCfzZrGhHoVlJhZN
         b0FkhbB1DwGdPYweIrgg7UBTJSGFj9+lqAYbBJ4vsfK9uDamd6UgXr37WhfUctjgxVDV
         lxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717761031; x=1718365831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8YSZ1xf3JS020wtDYuRSc4/MIriNLZ3fkqQQXeB5h0=;
        b=aMcMl3t/ylgJ0TO/yngN0Z6RtbBmuiY63rrbEI0K0bRB9Lg7pZol22zV1buYEnM0PK
         zn1qVW3y4zzxaGPJxiEmeELA+m7tQgxiL4Uo/XSJVGrG16DGiJVzb6OfFARvUlz/yTX2
         1tvkI+SM+1sGkhGxAbvLDdfWWF5O5DH3R31NG21xL4liP/0dbUMx6Vy1ZM5E8Ecjhst1
         lDwENnk45oxj2h+40P+/Mbg2qIC79Zcpfpj0WBgDc8L6baRqKxAED1TjrAtHmZ/T+j1G
         e9tNEZlKbM+U0ntwMoDptAtcYaEYrgByuGsJjh0HFkD7mEIP9QFVL3ARrsXn4zsIqGbG
         yLhA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ93OV3N5omxinPvdbf4ZEic6VA/RhinWDOyU5n2ooesbYbpTY8wfq8AWK9hFpf3/A81vsYOawpEb58nZqJfGXesZFbXyFAKTjg+iU
X-Gm-Message-State: AOJu0YzC8VMOBka4JAzn31brUlDzthSITfl7W3lNmJ7rSUSgHXD60ydF
	kaPgmBhEkpG87VQgv4QzZs4j4lfr7DZwzTeto8mZ2BndN9HAMdzkaMpH7cyYGws=
X-Google-Smtp-Source: AGHT+IH1fnzWJzSRWiOc9TKw1sMxf6+hh+r01uOIlWbPCeTM2eFUdTm3MFGz4e2qPlT0qozxajJK/g==
X-Received: by 2002:a05:6512:3e07:b0:52b:8435:8f22 with SMTP id 2adb3069b0e04-52bb9f84ca9mr1871221e87.36.1717761031014;
        Fri, 07 Jun 2024 04:50:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb433c4fdsm505724e87.264.2024.06.07.04.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:50:30 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:50:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com
Subject: Re: [PATCH v4 00/11] Add missing features to FastRPC driver
Message-ID: <fc3q4tp6sbmwgfpvi3eqavxnw74mc7czhf473dkbkvl2nzf4qe@i2lrfulyfaz4>
References: <20240606165939.12950-1-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606165939.12950-1-quic_ekangupt@quicinc.com>

On Thu, Jun 06, 2024 at 10:29:20PM +0530, Ekansh Gupta wrote:
> This patch series adds the listed features that have been missing
> in upstream fastRPC driver.
> - Add missing bug fixes.
> - Add static PD restart support for audio and sensors PD using
>   PDR framework.
> - Redesign and improve remote heap management.
> - Add fixes for unsigned PD. Unsigned PD can be enabled
>   using userspace API:
>   https://git.codelinaro.org/linaro/qcomlt/fastrpc/-/blob/master/src/fastrpc_apps_user.c?ref_type=heads#L1173
> 
> Changes in v2:
> - Added separate patch to add newlines in dev_err.
> - Added a bug fix in fastrpc capability function.
> - Added a new patch to save and restore interrupted context.
> - Fixed config dependency for PDR support.
> 
> Changes in v3:
> - Dropped interrupted context patch.
> - Splitted few of the bug fix patches.
> - Added Fixes tag wherever applicable.
> - Updated proper commit message for few of the patches.
> 
> Changes in v4:
> - Dropped untrusted process and system unsigned PD patches.
> - Updated proper commit message for few of the patches.
> - Splitted patches in more meaningful way.
> - Added helped functions for fastrpc_req_mmap.
> 

I'd suggest to land patches 1-4, they seem to be fine.

The rest of the series needs more rework. Please start by reordering the
patches, so that fixes come first. Think about the people who will
backport them to earlier kernels.

-- 
With best wishes
Dmitry

