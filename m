Return-Path: <linux-kernel+bounces-325790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FE2975E43
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED35B231FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68291A288;
	Thu, 12 Sep 2024 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g2bRTFP7"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AD383
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102725; cv=none; b=BPYS08Q2NFq1QpUZ0KskVkd/UaiznVPPauiboOoe5pmHjV8Rg+DgYzzK33ZWHGP6A9v6atTczgcjNbN8ehsouioAiYU9GD6UtHF9W1qAYPUJotzZz5E9dP/N0qe1IdqdLYG32ywYG1l8gNkzvc9Bj8qgiGJEGGlUf8YI2Z0r4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102725; c=relaxed/simple;
	bh=klwPv1UTi+SDROiwwsvUDDMZtUJFLtKIKP3X59lI96M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Im+p6wkL9CD8Bd5OpGFGuOeNevrcxYkgKGK1PY5M8I/StSdUgXRAVeglBGJKwm+IRWpT1ajtI5JO2DgHaNoExY6+UykJ1R7Av/Y71adr5XrLJq7hMCpuj2RfBSBq8ratWLR7MjZYlKJl7DXRAsAzPK6Zoz0onIjPze0N74AQqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g2bRTFP7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718e2855479so250921b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726102723; x=1726707523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=shqVvtwfqisC68tkusOFx9PToUyx7bNEpQ7SFFdAoTo=;
        b=g2bRTFP7y5OzzDzNCe92Rv9bxubSINT/5Mha8tuRSJYcSTjrzX6v+M/Wm4IGE6yq0K
         tDoxvELKtjR0Tj5oAipaNsN7vvMRyjd/P7Zk+45HZEUJcnO1hsB9IQomIx+Q8E9ZDz3j
         Ck2ayLUJWIdaC06DBWA9CEBakqKvvrK2WkZQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726102723; x=1726707523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shqVvtwfqisC68tkusOFx9PToUyx7bNEpQ7SFFdAoTo=;
        b=LKCmJS85QDRSyOcSNXo9l+u3+D07t58uIrjg9Nj+Om2SN+7Xyn4EPpCKdTgaTu91FZ
         Pqy4yQ1qYJrvzZ6WkrKiuA6m5QwHzBpDSkmPOveKRSfpl9MRQXsjHRYyTiI1w5I1Ojfx
         ab3biz28BaHHY0Z79Rfs/Nf6QYUJxy12+NHCSrWig8NH59TAh2Wj1do+V4e3HgkQAsJQ
         x83OlrX9zqUac4A7iNTiP+3Sq+D68GbfRl16UFKaQq7YPfChIXRfzXZlS4XopkCEJS5d
         +vW4ok+NDPhXAVS5u6sGC9++L+AM7t/vlHZm4VMuT1ANrxQQ9f0rFifI4fbNBiY4/lpc
         InuA==
X-Forwarded-Encrypted: i=1; AJvYcCU16RRKHer641za6eVwtMpNp4kRDas9OtnpEA/lgpqgWGp0/i6E/GGr/r9rvkRql6y5zMjLXqIMjmlaAOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdC+W6nCROQ9RidSImTX7WttPosCIGtPN80jMRfCtSSk+HbEoT
	WTuYJUIJGMFcDjPrYMJ8FdTdvy6AHi+xIDDbLbfnVwFEDTeTBDT7vuAkhxupmTf9Uojql4IcUUN
	N3Ic3+W3ypJeyc8xdd/6yzYp1H5F4Na6pQdT6
X-Google-Smtp-Source: AGHT+IE4yMAHQ+WKH6adYr+d5AnUxg5ZR8/xOpaN6yJ6rzW/xqXyDvP5dPDveGIj2XJwUMVXjSq1euVEcsqTEnxQGG4=
X-Received: by 2002:a05:6a00:9a0:b0:710:6f54:bc9c with SMTP id
 d2e1a72fcca58-7192606564cmr1762809b3a.2.1726102722863; Wed, 11 Sep 2024
 17:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com> <20240911062511.494855-21-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-21-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:21 -0600
Message-ID: <CAFLszTgYrEk=UBd6zgesphC+rLPtkOG4fjBOYaGRQXYLNUomyA@mail.gmail.com>
Subject: Re: [PATCH v3 20/30] drivers/arm: Implement acpi_fill_madt
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Fill the MADT table in the GIC driver and armv8 CPU driver to
> drop SoC specific code. While the GIC only needs devicetree
> data, the CPU driver needs additional information stored in
> the cpu_plat struct.
>
> While on it update the only board making use of the existing
> drivers and writing ACPI MADT in mainboard code.
>
> TEST: Booted on QEMU sbsa using driver model generated MADT.
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  arch/arm/lib/acpi_table.c |  1 +
>  arch/arm/lib/gic-v3-its.c | 89 ++++++++++++++++++++++++++++++++++++++-
>  drivers/cpu/armv8_cpu.c   | 27 ++++++++++++
>  include/cpu.h             | 27 +++++++++++-
>  4 files changed, 141 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Are the GIC values available by probing, or are they just 'known', and
dependent on the compatible string?

Regards,
Simon

