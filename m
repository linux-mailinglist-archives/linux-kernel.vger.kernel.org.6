Return-Path: <linux-kernel+bounces-329715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FF89794E6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C579284132
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DE4225D6;
	Sun, 15 Sep 2024 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CwUs/K4F"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF68217BCE
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726383166; cv=none; b=Oo7VrkzDM6wylkkczVgIrHw2by2KrnnwVkDEEkCqMcwGQGCfCFBtDRwGYEDcYAuH4Bbt0OXURWkBfwdk6dNDXPaLaH9fx3Tt0Jm1jYxx8N3/d8RxikbAVTvYIZm46sQ+8hCGX7EcGvorZ0wv4i1DrEO2vmOk55sniEIXO7rHiLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726383166; c=relaxed/simple;
	bh=Q5sEALuHPv1QRAJzo37KKiB5cC7Nv0mXzbDU/st89ls=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hO3OeJYeZAk6iRg8/opXDMHPHPQqSwiE/Vyb50eCfh0iKprVK7fAWlV39U8hlm5fzD6dYw+p47+JFQVeafLPIJ7Iz64DGCNP/mWsWpiPHSiWjudnneDmOfMeVnVvoEPmYEZEAu5V0IyN28sBl5qv1DMAB2GJJe4saF21a0+UkpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CwUs/K4F; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374c1120a32so2359111f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726383163; x=1726987963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISzocak7CfzsdizmFWg8QfL+4cD9AW1fcVI3tqhKr/E=;
        b=CwUs/K4FVrT6mA3mUNHM6skMZBl/bUckQXR9YQqnP8dU/s44i0E4eULRknGqj/c8B5
         OXAqqRgNeR6Ob+hM7RWcPdfEYfzgxfEmE/vncL4pjnMbDE8uzysYuyRF5/MNE50Kt+ft
         5IVsJ8Vmc/leepsJIWL1nmBVcd2utSGPkJgBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726383163; x=1726987963;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISzocak7CfzsdizmFWg8QfL+4cD9AW1fcVI3tqhKr/E=;
        b=lm9RzhPeoKuGWTHegmHK21Hkhqn0maaDZ/peMdyrbN8yYlI+Zx2RBOdHLEOPPCXt6w
         +hmhF/zEBUK27sKhpwf1sDualXQC01ci4yXx2csuoFEKKUJOH6SU5Zfcw3DeQvpQvFcL
         pOIT3ZiQFvXzQqrUVoyGjfWzKhYQ87xGHbUkFyKjz4LHfSRclgM+QEP0sLQ4cdLhAkfo
         1vG3ggMZAdxJL1rI2GlSSw85saT8EpuJFkLhM2cjSYyrZl4iLtGaUwNizFlsuxwg2BRS
         BpG9HdFvm4ncTYSwlGHncMfdTWKGxywWifJz7oE3n3Tplej5vRgzvMaSj6W0kk/we9ja
         3xxg==
X-Forwarded-Encrypted: i=1; AJvYcCV8M7C7sPUjUAkhPG7Vgr4uPCYUs1Hx0NhWx9KkBgb76Q4TChamZy8YCVgs7GVQKVFwTI8hC5irl+SbmtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynrIwujdZLdUxQbEmLRPenbur+XewT/9e4GxlrJw0fONThQLOP
	Inm9Ly7/DNqUJNY+DtD01LcdR6CfirPF12cEwCoAqX/+9I8Ct+K7Nfim+Fc0Kg==
X-Google-Smtp-Source: AGHT+IH88sEKQpcRpCxC3Pmitv3AYGQkPFoJMjKBtTDy2NU+mjIXebpVIEbFql2nmHL7yxkWVb65LA==
X-Received: by 2002:a5d:6743:0:b0:371:6fba:d555 with SMTP id ffacd0b85a97d-378c2cf40bamr6205944f8f.18.1726383162728;
        Sat, 14 Sep 2024 23:52:42 -0700 (PDT)
Received: from [10.229.42.193] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm3920343f8f.30.2024.09.14.23.52.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2024 23:52:42 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>, Ondrej Jirman <megi@xff.cz>
Date: Sun, 15 Sep 2024 08:52:40 +0200
Message-ID: <191f47476d8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240910-wireless-mainline-v14-4-9d80fea5326d@wesion.com>
References: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
 <20240910-wireless-mainline-v14-4-9d80fea5326d@wesion.com>
User-Agent: AquaMail/1.52.0 (build: 105200518)
Subject: Re: [PATCH v14 4/4] wifi: brcmfmac: add flag for random seed during firmware download
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On September 10, 2024 5:05:50 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:

> Providing the random seed to firmware was tied to the fact that the
> device has a valid OTP, which worked for some Apple chips. However,
> it turns out the BCM43752 device also needs the random seed in order
> to get firmware running. Suspect it is simply tied to the firmware
> branch used for the device. Introducing a mechanism to allow setting
> it for a device through the device table.
>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 52 ++++++++++++++++++----
> .../broadcom/brcm80211/include/brcm_hw_ids.h       |  2 +
> 2 files changed, 46 insertions(+), 8 deletions(-)



