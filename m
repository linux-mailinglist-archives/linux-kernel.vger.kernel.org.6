Return-Path: <linux-kernel+bounces-316942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A95F96D755
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DCD1F240D0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CB2199E94;
	Thu,  5 Sep 2024 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l88QK/a3"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92BC19342A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536346; cv=none; b=H1lfoicD54+662nJgpXtjoLTtmjjJKiUjW9b2RRDJRmHVL8CqhJbWCOT1+6avp5ggu92UwT7l1IhUZqgZyZoyNUDz8ikBrRkNXnBGOE2XJunNiX89//dopPswJ/DI/RnmkzMomiWRtnnHtpOrl/LnXOS2e+8U14Sc9GkCJYzXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536346; c=relaxed/simple;
	bh=7dThSnBD4jy2w+lNK4sQoHqZorzmpN8yffl06pPHXfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOQrTarB6nEr+6SuPnWceF+bAjnjG/niaT5CmRf1sX/mb8mUiN+qnIlMpw/UWYT+HgrdSj6mdiq69T7KWfXr2MbaoQL/HcKLS3YKaaaHTOdcneX/mdsZOpHEJzT/FYx72WafO43nrj241bxJE9HIypYQihF/ePKmZ0GMXPkcaFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l88QK/a3; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1a7e54b898so766160276.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725536344; x=1726141144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jLrIko9Z9MxBDc0IDBCABFFMewp6y0UOpPNBPOn2Xow=;
        b=l88QK/a3fjAjpOG6VwKD1oPLrRaiyGRA7dUiVdGCXGQWF71DhFj68YBAfZ6HKcXbkQ
         ygIuyhdvImkdKzCjGZUw0kDRiUxh09i7TlfhTGHVqMzx33B4OxlfkYEH0hbMi9cQzeCJ
         wNAyF8LS4MAigFDB4RFVbUYeb6FyjZn31M1Kn241mv9w3avzKR+nA3/Z94fEUs4I5Vo6
         Es13IMNYPd5bDWdIbrkB8fiJ7YQccKW2C2tRgC23H8VZYOoQq69sbREiJUFK8MkQPzEM
         egXilzak+nTL0u3D9+ZzazX28Zzg7G6+MI+0cCBN8kfO0UjTb3gV8/0jQtZIgfQiEZXN
         q8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725536344; x=1726141144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLrIko9Z9MxBDc0IDBCABFFMewp6y0UOpPNBPOn2Xow=;
        b=Nfi+6mesFFWTji3kDgAxXS7tRHednMYZ7Xy1nQ6L4E3Tz4jtiyY27qDVnK4xop8RJx
         J1RxmDZ/Z7ajfbiCpA3s/kbE7mIqSrh0YYqKSbuwsu6bBT5KJq2+zkxbRqvQqLGhznlY
         0ilvtDVtJR1YLFUiEuxp6aNwmz4Z1lp1o3L1LJX1DIWB2BFUNHCHbcQQfgAGgtdmZz5v
         0ep5CYA3PSxszz4VFiumpnSq7eHr/o+DtNQtYB8U8c6cCJ7D0u59faq2ugXVnHVz4EAW
         pfIKTxdkuEu73dLC0OzSaswstWXcl8uZkoF2ouyaVmkJMKQ3YCaNb/6XF6EFWjPXD+g6
         EulQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBNxMGjk1Jj5T7y26KYi15awlJ/2GF5eaEd184m/FmUHl+OwJPdtCosH8dLROULZ6oaYWYWgp6tudW3Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUbnrjQbD80g2OjuQQEdD/1YWYr2NeQ1M2MemHak8xlByqbud
	TXjz48w5sn2eE0wXNTj5yXGpCh9+Of+HD84w6r85o6fElaZXfAFK+6ntBwVjRHnk2sNMA8gI0Su
	ifjDGIKiECHxTk1a6oXIX8KzsFo4sNKg8GbLn0A==
X-Google-Smtp-Source: AGHT+IG2scPjtVAXf9nEKI3l/EN+JmBquZI8G7Ofzyty/BbMRzaMcLv0Q0Cuw4yoEG/OI+Q41jbqYX6lsRoODakwg1Q=
X-Received: by 2002:a05:6902:2601:b0:e1a:b168:8053 with SMTP id
 3f1490d57ef6-e1ab16881a3mr15652183276.17.1725536343783; Thu, 05 Sep 2024
 04:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
In-Reply-To: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Sep 2024 13:38:27 +0200
Message-ID: <CAPDyKFrFX_UeYWuZtQPoxHbZb0CwpLRA=QcMFsALwuiFTY3T5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pmdomain: ti_sci: collect and send low-power mode constraints
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 02:00, Kevin Hilman <khilman@baylibre.com> wrote:
>
> The latest (10.x) version of the firmware for the PM co-processor (aka
> device manager, or DM) adds support for a "managed" mode, where the DM
> firmware will select the specific low power state which is entered
> when Linux requests a system-wide suspend.
>
> In this mode, the DM will always attempt the deepest low-power state
> available for the SoC.
>
> However, Linux (or OSes running on other cores) may want to constrain
> the DM for certain use cases.  For example, the deepest state may have
> a wakeup/resume latency that is too long for certain use cases.  Or,
> some wakeup-capable devices may potentially be powered off in deep
> low-power states, but if one of those devices is enabled as a wakeup
> source, it should not be powered off.
>
> These kinds of constraints are are already known in Linux by the use
> of existing APIs such as per-device PM QoS and device wakeup APIs, but
> now we need to communicate these constraints to the DM.
>
> For TI SoCs with TI SCI support, all DM-managed devices will be
> connected to a TI SCI PM domain.  So the goal of this series is to use
> the PM domain driver for TI SCI devices to collect constraints, and
> communicate them to the DM via the new TI SCI APIs.
>
> This is all managed by TI SCI PM domain code.  No new APIs are needed
> by Linux drivers.  Any device that is managed by TI SCI will be
> checked for QoS constraints or wakeup capability and the constraints
> will be collected and sent to the DM.
>
> This series depends on the support for the new TI SCI APIs (v10) and
> was also tested with this series to update 8250_omap serial support
> for AM62x[2].
>
> [1] https://lore.kernel.org/all/20240801195422.2296347-1-msp@baylibre.com
> [2] https://lore.kernel.org/all/20240807141227.1093006-1-msp@baylibre.com/
>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
> Changes in v2:
>
> - To simplify this version a bit, drop the pmdomain ->power_off()
>   changes.  Constraints only sent during ->suspend() path.  The pmdomain
>   path was an optimization that may be added back later.
> - With the above simplification, drop the extra state variables that
>   had been added to keep track of constraint status.
> - Link to v1: https://lore.kernel.org/r/20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com
>
> ---
> Kevin Hilman (3):
>       pmdomain: ti_sci: add per-device latency constraint management
>       pmdomain: ti_sci: add wakeup constraint management
>       pmdomain: ti_sci: handle wake IRQs for IO daisy chain wakeups
>
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> ---
> base-commit: ad7eb1b6b92ee0c959a0a6ae846ddadd7a79ea64
> change-id: 20240802-lpm-v6-10-constraints-pmdomain-f33df5aef449
>
> Best regards,
> --
> Kevin Hilman <khilman@baylibre.com>

Besides a couple of minor things that I have commented on for each
patch, this looks okay to me!

Taking into account the other series that this depends on, what is the
best merging strategy? Is it safe for me to take it through my
pmdomain tree?

Kind regards
Uffe

