Return-Path: <linux-kernel+bounces-293874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3716295860D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DB51C244A9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFCE189F5D;
	Tue, 20 Aug 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWbWmDGR"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5218E740
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154620; cv=none; b=vD1Qju6QPz1Rvk7sjGePfTHYSHrMSKMxY+sYC4ciDTcQobIQuiZPmfv1ZzOvjY33tZ3g36kyb9K8pLj1biIn5uiDBIhZfeRCUj7smjbp6f5X9SsdzdMlQqXVLdLpAR0rszRPX5UqGw0dlOE/z2vfacXa5E3ZNRuwN0tilO/bRgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154620; c=relaxed/simple;
	bh=02MO6O+/8O/HpCDXRwF2fJUABFYAMT1yrG11O6DC+nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQWsFXY4FCp3jaxqwvS0EjaA+FY5ju+zZNVMV0eL7zhtAF3DgU4byeQfuIwKqq0ZDDV5OynMz/y74UtiHPpcKmcrzs7C/gRtdiIrdGvQGJ4hzClyld7+Zrv8Kg35cfLtCEUPRcVbMp1KwFYEMFnHJPxv5KuTtWFqgQGsvR6XMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KWbWmDGR; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso5703470276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724154617; x=1724759417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pRSlm9qQOknEuQv0nGHCbr6Vtei0tCHogVBnyLHAIdY=;
        b=KWbWmDGRG5nfQ/8XSp4taU56trMgY1bYs2HvDr8wqWf6grc67+L5I7rUZjEREgjAoN
         lqggLx3ggKM6u94rDgBAQZw1d14CYIkRq6/HgISKhZPo8rb4T1vR9PeNudQdhRFHgEFJ
         4GzMu5U3Lpz5GTXdO/NKjFTjgARIP2lVE4+XBj+X35gXjfsQssbH+u4v1H+LMNv52QmF
         ja8I565Opa2AYz29yrXfLX2evmdYbLgoQVoHUY0NGnF5yYCvuOfEiHzFekCqbVnCGAmc
         E4oiv+TDK+aP2DNqI5OrkQl7abp3xipbUCd6fse+Dea8QxhV5RuyNaf++VnU+H6p77bQ
         DnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724154617; x=1724759417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRSlm9qQOknEuQv0nGHCbr6Vtei0tCHogVBnyLHAIdY=;
        b=NA+pNoMYpeuDQjE+aHbkEQwooFrwpD1mt6CssdLfa+jW9s5kQVTHmCycZjbvPdsKsN
         06OVDzMVLY0ikujx0aaatcs9+tWcxOFBB5OmUgcTg2wKLb9OvPTRqeU3um503rhAqJZt
         FVqYxcPrRef3WtTyo/HviVpTiNQN2/tJ1HN2uE3asiFw7nLQrxSp+CBelNkAit1TKTMR
         dEM7hCgYZGYjPP187I30eA25UljA2oZyqfDuQecU7Zn9+7qt/Kp1bUFnL7yVbK4NskSd
         +JqMdMocqnu2hP9s6Q+YzGmrgHzE+z4n+EEill9+1e9cm0iVc//HDmtew/z/VyWh3y6y
         kxcg==
X-Forwarded-Encrypted: i=1; AJvYcCU9/nHxtBGJEZpgTiXOia0kQVZvCreXKqPlpCLbHxC/9ywnPptj4ounzCCFWqm8yFL/ZK6ooNjZ9bZjc2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXVIf42tNG/PGZZgHDSSheTaWeXqU83FSbioIsAgkzRDR0saK4
	cmWhwxU97Zlag65J66soOi3qvrH42Fw2gAnPl5AkZCHoOekVdAIOk8xnKx1nFABMeOiuIuIxVmR
	Wmpd9ShtBb/tQpkPwIMhGaQ7qd+CY/P49+nPxyA==
X-Google-Smtp-Source: AGHT+IG1yqC54I7oa3M5j2AOrh0P76AlYO5oE0hU3etb8Dtrle6m44vkqVuSm1KJj7xzuFntbTl9xYb+/IGGk1CL6jY=
X-Received: by 2002:a05:6902:1027:b0:e11:6f62:2290 with SMTP id
 3f1490d57ef6-e1180ef44b0mr17580897276.24.1724154617395; Tue, 20 Aug 2024
 04:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722847198.git.unicorn_wang@outlook.com>
In-Reply-To: <cover.1722847198.git.unicorn_wang@outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 13:49:41 +0200
Message-ID: <CAPDyKFqGGAzgLFJOKmOpLVT8ai4ymHXUbva85U6JtEd=M9kb4Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] mmc: sdhci-of-dwcmshc: Add Sophgo SG2042 support
To: Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org, 
	guoren@kernel.org, inochiama@outlook.com, jszhang@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, robh@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com, haijiao.liu@sophgo.com, 
	xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com, 
	Chen Wang <unicorn_wang@outlook.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 11:15, Chen Wang <unicornxw@gmail.com> wrote:
>
> From: Chen Wang <unicorn_wang@outlook.com>
>
> This patchset is composed of two parts:
> - one is the improvement of the sdhci-of-dwcmshc framework,
> - the other is the support for sg2042 based on the improvement of the
>   framework.
> The reason for merging the two parts into one patchset is mainly to
> facilitate review, especially to facilitate viewing why we need to
> improve the framework and what benefits it will bring to us.
>
> When I tried to add a new soc(SG2042) to sdhci-of-dwcmshc, I found
> that the existing driver code could be optimized to facilitate expansion
> for the new soc. Patch 1 ~ Patch 5 is for this.
>
> Patch 6 ~ 7 are adding support for the mmc controller for Sophgo SG2042.
> Adding corresponding new compatible strings, and implement
> custom callbacks for SG2042 based on new framework.
>
> Patch 8 is the change for DTS.
>
> By the way, although I believe this patch only optimizes the framework
> of the code and does not change the specific logic, simple verification
> is certainly better. Since I don't have rk35xx/th1520 related hardware,
> it would be greatly appreciated if someone could help verify it.
>
> ---
>
> Changes in v6:
>
>   The patch series is based on latest 'next' branch of [mmc-git].
>
>   - Some minor improvements based on Adrian's review suggestions.
>   - Added Reviewed-by and Tested-by signatures from Conor/Drew/Inochi.
>

Patch 1 -> 7 applied for next, thanks!

Kind regards
Uffe

