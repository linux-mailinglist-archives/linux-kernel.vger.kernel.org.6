Return-Path: <linux-kernel+bounces-439903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3951C9EB5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9055161AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBF01C5F15;
	Tue, 10 Dec 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FraOQ7la"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842211BD9D2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847019; cv=none; b=cOKGbJ1ed2IBfMvD2Kk1R6lfW/5wZvmyWqvAoz0USLwLL9Fp964FAiiYdNGzwv48bhGraANe/VHMqbJj/Osxmo+I5WuD/CBYeHXd09RiYs01UDuvu+JUE4xgUxdoQt6/8aj5R8ORKBzppgG778O0MtKjxtW8K8/vUUe3gdEmr4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847019; c=relaxed/simple;
	bh=BbxjbBE9EY/vTzfnxGy/h8oVMvXpnYp8R9PBrp8qVko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDqQo7h9va3sXVIvNKKycYoorRYpCKCBDcjdQg+KBbt9Ia7fyT2Xx0iHa85k5BqE+ZjJFJCtfjCwmpN9vjwJr+rOGOGyXiT9xGhDjTlvRAy0ldvJKnjSZbMmY+mpqX7nzIZEW9Wc0ngdKH88079U67Z/8QoPLJPE+vcnXMHTh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FraOQ7la; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3983426f80so4497976276.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733847016; x=1734451816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cxEsjJZdgUz/mL0/yG8G0yeVvzImsKQynZFt9bIQYPM=;
        b=FraOQ7laT/TqYRDWq59VNLs0tldsdbBMXjb7Z0zqiBAggjFavwBgbc+Z/pPAqIsi7A
         RaQGZN49rIqoqAW53pcuW07d9R1Z5+xRKzDWIXWU54d39l0a2quJu8gqbTbzIpNM9hD3
         HGabXji93PLhoIlkSTBq26L/rFchiAMQ2KvGqYcef1+oT2ULi0fbaTyTS0Q2AeRIuU+e
         +bSyPv4KvY5yhxXhlG0TQy01W/VpKqnSl1DRUWr3DOjBdU8yK4UaLXIb7H/IGdpuTCnz
         Xhzc0sAja/VmZPPYVaZHScD58LUTAonLFJ91GbwKtTPBcq8KzK2up9rMoW3pAsrXjXPx
         Rz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847016; x=1734451816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxEsjJZdgUz/mL0/yG8G0yeVvzImsKQynZFt9bIQYPM=;
        b=FTpn/w06AL/We/b+j/igb4BaG2kBwMjx5S0AkV0VQjuXaXf2yShsT0eQC7ZZK5AvEk
         i2tS+UHFGEgTAuWzWTyR/MIoS1Uqw3uEU86z6dKBCaXvTLfII5XLYUaqX1IYi4E5IN7W
         lEIcv1C7orS6GIBDiN7d95MCl7GOspD7IfLOWeKB2VU827PU2OAuiCthW7ap9u6rQfSv
         +wCKkfxd0BU/fPyqm0L7t9BMCvnzS1NbI3E977qlbufEPdl0o+e0FU35rJBEBRKPN35o
         k57pjQObR6LSro9MQWw87YLNdgi82LpAZCqESe1bPnuJ2KFmhs2HQ3+zJEgXx31rfeI5
         wCwg==
X-Forwarded-Encrypted: i=1; AJvYcCVYHuGtchTxljJd+snK1lwDMOaSluG3BLDL9YRHEvgdTR4Mx3RWTsiN/Of7geIeR5i+yMgAgBw6r4k4ZxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNEa/Mipb1/5QCpmYbePyQnGCQGRWCJWTN874SyxVbNK/HspzV
	SFZANOS76SkZFyvM8QqcNRI1+ezYcp3NLKbCME4pLPG96p+n/UUz34JwLuJW3JX/ePb9IaFwbGo
	WXjJ41MefO1pPPqQlfd6V9UbS5/k2BMcuguQmOw==
X-Gm-Gg: ASbGncvjWZINUaSiP/dllBowIQ+Alk6B3BR7xgf4/GS7hZ41PruLFT6W0mzTpTUf3P6
	kdQGqzRxtKo6oDyGQdtFkMcysMwpvVN6ok6J8
X-Google-Smtp-Source: AGHT+IFNDYQwgGxPY21TM51+IaEJVIKNukjD//zZqKizVHjoXfP5g2KINmrq5zBjn12o/Cd1twqkaondPOWReLN4iBs=
X-Received: by 2002:a05:6902:240b:b0:e39:9b9f:7f87 with SMTP id
 3f1490d57ef6-e3a59b27141mr4893458276.29.1733847016550; Tue, 10 Dec 2024
 08:10:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209101009.22710-1-pshete@nvidia.com>
In-Reply-To: <20241209101009.22710-1-pshete@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Dec 2024 17:09:40 +0100
Message-ID: <CAPDyKFpmTs7ZqK0ZCDB6tuaUi6gXdTxOkidVpAz8JpgWO4SK3Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-tegra: Remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC
 quirk
To: Prathamesh Shete <pshete@nvidia.com>
Cc: adrian.hunter@intel.com, thierry.reding@gmail.com, jonathanh@nvidia.com, 
	linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, anrao@nvidia.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Dec 2024 at 11:10, Prathamesh Shete <pshete@nvidia.com> wrote:
>
> Value 0 in ADMA length decsriptor is interpretated as 65536 on new Tegra
> chips, remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk to make sure
> max ADMA2 length is 65536
>
> Fixes: 4346b7c7941d ("mmc: tegra: Add Tegra186 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-tegra.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 1ad0a6b3a2eb..7b6b82bec855 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1525,7 +1525,6 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
>         .quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
>                   SDHCI_QUIRK_SINGLE_POWER_WRITE |
>                   SDHCI_QUIRK_NO_HISPD_BIT |
> -                 SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>                   SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>         .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>                    SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
> --
> 2.17.1
>

