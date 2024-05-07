Return-Path: <linux-kernel+bounces-171362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0D98BE346
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CEA1C235E6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6315B15E803;
	Tue,  7 May 2024 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lPlAe63m"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD8A15E5DD
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087618; cv=none; b=sy/oAcSc9JdXGBizk2ZnuHnlXEWwO9uMCTuVs0rBtG2twml7NGq3QnilZelq7vneC5Wlxh27L3EV3QpTPOfHtzTNk9F0KtGyZmzFljXBMRCAKbYtJlqi2W+A/a0i9FuW+Oa6TplZU7WGtouEpuX755xG4SLEsONT3LvMiPvPBBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087618; c=relaxed/simple;
	bh=huwwMObImLXDwxdd4IcsxdgbEdaC9GS1MwLk6DCr8ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7EK5SCzmuwa0V02njvCv6zUBuq8ZSJ69O/B31A6j3bgtZDpfojACh6j8L4bXCIy6w5FCrxe2tdoCHyPTyRQiiKJBO4L8zwDAh5pf+VUPK3sjmWVE5R3GxEpQGPEsZbEhvkrErMRpV9outGmUyAb8qfA4KujxbUwCUYwRGuIOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lPlAe63m; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b20318a866so1557471eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715087616; x=1715692416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc5VKVV3Tbfknc2vkHblG1DVZBApSAaUebZ/kDgTpwA=;
        b=lPlAe63m8X93+m9K4ES9bqPbiyyJ92jOPrSZgPsR/rCkIifW4OAGyv6BIYQRhM+UkI
         ojQ2DcRP1km8tLJwKWqxxtHAZkGbLcOhgRLveagfNu7stHzvfvHsOdFT/xwoWqoJQAMX
         CZfaoiv5lyJ8vHem6gGp7kyhwAIJvbM2rmwWW3bk4JuqC42J8hLXDSxpTLKpAK1Ngyus
         3hhGM14RcqRrdRpkcAJEz29ac4MM3VyC3qI6Pgxay6XJE/Br64iy3ooAI9MHAei8Nwvu
         ZIKXoRmvO5Ov9+SMDiMUh3q6Q3MyQQizObTxbRiyVUiOz+tnPkZcA7d9QkBBTa1ag8Sr
         UBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715087616; x=1715692416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tc5VKVV3Tbfknc2vkHblG1DVZBApSAaUebZ/kDgTpwA=;
        b=wYcK+VptMqtUuI/VY7XT+C9SHyj0D8KRgrpdteJK5cRoL/PdUnVR0GWuhznxSfo59J
         i0in1wn41Ypfb5DF5nvBJ9aD7Gjkf2i0dXIpH4oV4IHCW5hIHeyyKn/fN3UL2LrpwOAt
         yiyxdAy06lCeHLMOu5kfMAnwHOgwT19zHIF5qHZy7C670UJst+AqABOxf90czdalI+F2
         LgG80nxoXOqGlqDkzL5/zG1ViPCqtfUrpdHxlF2KsUGY/icDccSoBGHbXrcS0qd/5XfF
         ZkphsuA0N9IsDnb33fJqT2WLX6h4qs8vzllQDa7SakIdRGwS51sxYzYPCWYj9tVNXIFj
         0/ew==
X-Forwarded-Encrypted: i=1; AJvYcCV4kl5aDuMN7h/jLnJjLDYQ/46OguU/MY/9sxug9ZQI6zSnkP28B51KjTshQzfkbN5At1HWuNGflz28j9Rz6zowp8zpRBDjUEUp6OgF
X-Gm-Message-State: AOJu0Yy2uJWkCik9wYsGEIyDgtUtUpFyjovyxshfNfDzV+xNyyI0tyqL
	e0DNxh26BX684rB0v+6Qk0PchmG0m/vTl+fmv1xKz+s5RHnsnf2q1t725Zh6mkFvyyeCw/ACF/D
	4sCAVh/WCMhVVYH6nhqK5F+Y31wgBQWWpFYQKo3zDolRTFriy8iY=
X-Google-Smtp-Source: AGHT+IHTKy6B/89JXbfSR1BZ94upeOlonaImhSTIT71Dm6wb5ue8e6UMi4QnV8cZJ9qWIAVQ5HT4NXCNagT+Zs8HTqc=
X-Received: by 2002:a05:6808:182a:b0:3c6:5da:1635 with SMTP id
 bh42-20020a056808182a00b003c605da1635mr16926292oib.3.1715087616309; Tue, 07
 May 2024 06:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs1ZN2K=UHOjrwRR2JNE-M0nf9iW_Q-YPzVgmW+9daU4Q@mail.gmail.com>
In-Reply-To: <CA+G9fYs1ZN2K=UHOjrwRR2JNE-M0nf9iW_Q-YPzVgmW+9daU4Q@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 7 May 2024 18:43:24 +0530
Message-ID: <CA+G9fYs1F=kO11-+DtAOsNwZGEd8mmojXEfXfg431JG=Spubcg@mail.gmail.com>
Subject: Re: arm64: defconfig: gcc-8: failed: AttributeError: module
 'argparse' has no attribute 'BooleanOptionalAction'
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, lkft-triage@lists.linaro.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 17:13, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The arm and arm64 with gcc-8 builds failed on Linux next-20240507 tag
> with gcc-8 due to following warnings / errors.
>
> arm64 and arm:
>   defconfig - gcc-8 - failed

Anders bisected this build problem and found the first bad commit:

07a2f8716c41 drm/msm/gen_header: allow skipping the validation

Steps to reproduce:
-----
# tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

