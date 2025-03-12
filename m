Return-Path: <linux-kernel+bounces-557595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A90A5DB58
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB40E189AEFA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6A23F28B;
	Wed, 12 Mar 2025 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tY4m9qUC"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E923F381
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778696; cv=none; b=uP6H+CRkK3dRbTYZ0WL+Xzffn4OhdPVLAQCu/RP4C8l1Q0/EQB0rd2I0L9RrC0/Phe74QdqtTh2N3yhlsg3Bf3HrhKeBnHj+N5kKCfsKHuuTJqnnngQgE+2uRpWJARqMSx/ZCSSpoGLYoLlX1mpkJXw024cwSuGhFV1/1jL1h8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778696; c=relaxed/simple;
	bh=UcXaR+GDawWoQaNRuFtyapQxtDjf/bEMrcOSC2FkQ1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKbaovwxViMc5DmBt0n3ZH9KEWVSVJ84CbtP5wcPCxDYvNr7DgrNuXPMV0Pezwdt0K0ZRqbuId/U1OX/iH69DG2YlbU7VB0i9NY8f+ukQWxd8LTq+ayAAp6zmWxiNcKf+zf5EeRAeQ3jLyQaeoqe4BxjoyV+y312EgPblait2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tY4m9qUC; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f6c90b51c3so64435187b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778692; x=1742383492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7OnDqzR6YtSLwONQoTdDT31SC3+7fyj7xPsRU2pi+G4=;
        b=tY4m9qUC71QAzCkvtu+FlH3ht9gu/SOiEZ3r+On8JHrv6xL+cPGeBd0HEpK2nbM4Al
         A4bAIBRyHsRzBWf41VdzD0IH8KsP9RyUNlmz0jLe9dK2QTNHcvniOQFmMZQsexYGsYOn
         pPPj0gVZTgM5BQvM4HgpNkrSfF6Z+iOISHwWNpZb2BwxF3Xm0P+gnTsimpUYNgjg9pAV
         RNZqPejxRdlNhPwK4Z9vNgMg/1DbC5uqwHjBrN7oCzVFoBCZT8/5SR6oTk9u0FSTPEQk
         9r1vDJeb2se0lcbh2yo42KYBXPchoTxqECASTWBNK6gZVjUsWl2YNtWHCyPoSxXRI8Ql
         /BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778693; x=1742383493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OnDqzR6YtSLwONQoTdDT31SC3+7fyj7xPsRU2pi+G4=;
        b=Ra7Q2eaF7ST3fPoqwjRWnZVyqhjGTEr9fQlLWHZSiULwFnKJ/VJQPIHql+PSCQm4Um
         NHBC5qWQovh23W0kyFb9IDUNFDBQDl9VHNdTqeeb2pwCQCFyiWCl66zXTSjuzNteJ4np
         R2IzmE6+gZ6sofnW1NuDAcAWA/h9DCgtA38sRPnfwR13YRpQt/O1tKvZbPmE8sxaAyFz
         aFALnMTTl1HmV5DgI+5gtppDR5u9q27rpvF9Y2mfnNAMSAHkF304oK8CqLwjjOIDByHF
         v42iPaRSXH3Ze/IPalyW08+4As7j80+egz0/zQGG5gJ08vJlex7xFUFOeJCkfmlrbU5l
         NLlA==
X-Forwarded-Encrypted: i=1; AJvYcCXzw1BlVPas31U3clnlKI/HTU7BCqgtJI3U855f2ZkojBEcjvmKsy407lCpHlZlgFysZXK4JGtO6APe5lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1y17HCMfry6SSTxX2MGR15KCyXWmA2DM5V5R7rTqR1gyjSvd8
	UwGb71/atk1CoGV1PzNzrB7k3lqKKSKEW0T6hWR5OwX0W2w5H8+METGtot7IWq4chkFhj3rBBpm
	KZyKO7w23GaAC0Nws4ttK4ht0DjkgGsLzSBMtKw==
X-Gm-Gg: ASbGncs9FutPT7Ev5IxOs3/l2UJlZIWtU6BMWCUwyTon1NFAwJ3Z//Ma+3eOwkUyK/2
	1Eoa3KX9wqE0QVP2D+yV2ZZZA9ANrtTFG/tyev/hadiO9PVjujyuZb6rcZh1RFVbDivoO9iUzTp
	EG1hcbvmk0UhmVsLTwb+R1cM4P6Rc=
X-Google-Smtp-Source: AGHT+IHIrYfmo2j3yVIIaYFZE5oDvK+hQZ8/RGWocwnTto9a3k4qtBGozDsAeCNABMZLWFLC8+SYFjOJXfUQHYTuZMU=
X-Received: by 2002:a05:690c:3612:b0:6ee:8363:96d3 with SMTP id
 00721157ae682-6febf3ade28mr290798997b3.27.1741778692704; Wed, 12 Mar 2025
 04:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-exynos7870-mmc-v2-0-b4255a3e39ed@disroot.org>
In-Reply-To: <20250219-exynos7870-mmc-v2-0-b4255a3e39ed@disroot.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:16 +0100
X-Gm-Features: AQ5f1JruelnoNSp1FLqFV_ATP8uAM2_7A2P1q-OWLObav93kN6mUQJG3IRna_fc
Message-ID: <CAPDyKFrmn21xksS6Co9AjLQbtq_EWC8WF=r3RSAc6nfWTT9-zA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Introduce DW MMC support for Exynos7870
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 19:48, Kaustabh Chakraborty
<kauschluss@disroot.org> wrote:
>
> This series adds support for SMU and non-SMU variants of Exynos7870 DW
> MMC controllers.
>
> Some DW MMC controllers require two 32-bit r/w from a 64-bit FIFO,
> the series implements that feature as well.
>
> This patch series is a part of Exynos7870 upstreaming.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

The series applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - Take over ownership of patches by the co-author, upon their request.
> - Link to v1: https://lore.kernel.org/r/20250204-exynos7870-mmc-v1-0-c87cfc72be4a@disroot.org
>
> ---
> Kaustabh Chakraborty (3):
>       dt-bindings: mmc: samsung,exynos-dw-mshc: add exynos7870 support
>       mmc: dw_mmc: add a quirk for accessing 64-bit FIFOs in two halves
>       mmc: dw_mmc: add exynos7870 DW MMC support
>
>  .../bindings/mmc/samsung,exynos-dw-mshc.yaml       |  2 +
>  drivers/mmc/host/dw_mmc-exynos.c                   | 41 +++++++++-
>  drivers/mmc/host/dw_mmc.c                          | 94 +++++++++++++++++++++-
>  drivers/mmc/host/dw_mmc.h                          | 27 +++++++
>  4 files changed, 161 insertions(+), 3 deletions(-)
> ---
> base-commit: e5d3fd687aac5eceb1721fa92b9f49afcf4c3717
> change-id: 20250203-exynos7870-mmc-75bac583c864
>
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss@disroot.org>
>

