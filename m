Return-Path: <linux-kernel+bounces-294914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E0C95943F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CAD284E81
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492B416B750;
	Wed, 21 Aug 2024 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TqWuK6zk"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2B15689B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724219313; cv=none; b=bMQT3P2uIoqj2JiC54CctLdVAEH2UmKcdTcH00dVJkQDfJo8tXh2YHCLdPZx3C1aW5QMPCMah+1rCrsg/oO0dR5jkynHJfSckfdhYKWU2O65YVQ1UkyDPdmEkrQ5kzQgkxzlTOBzpSRNW0vMmKKls1xWl20BFO+o+M4QT2CTj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724219313; c=relaxed/simple;
	bh=J8x2jVHv24gpsGk/rvne1vdojygWNGLZKnDuhBA0KeQ=;
	h=From:To:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sDotlfQuUXMUMCypiApa2xHs1pTmMnj/UkFiD8oS9dj3Xf9Sm46T4JERRnPSS/imonyaKVzQuqBDxQqUAP7BTohJlbLnZ7P1IbJD5ayR7uqdBM9G6hmB7hp/2L2m9CY0f4TCUJsWKIosRq5zkN7zHsyHkNPNriyJ8aEenhegQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TqWuK6zk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-371ba7e46easo1695428f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724219309; x=1724824109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nP3ueLvKs0/bHziLfGaK4Ey7cdFOtLdT2RqpBOJBVJE=;
        b=TqWuK6zkqVvFGC1BHMq+zP0OjQc7E3mEtmSLCNnMRRPRhXyIavkEFQPmf2JJRV6FC/
         iNbbUPEofsD0CF6MaNToMNtMjTgKLo/UP+0igZ+Jjvzm0yJxzJXttKPyn9g8+5JqkLO+
         Ge+dJdP8GFoCTrutT53wNBdXh7va1JCg+3n+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724219309; x=1724824109;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nP3ueLvKs0/bHziLfGaK4Ey7cdFOtLdT2RqpBOJBVJE=;
        b=mozxx7a/H45PJm0kyRHGxKLDAQUg9GT8SJJMx6X7T0rIjSWvSOxV/G/yPdnRFGU5+O
         BMYpPNtt5ABZ6mdGaAoL6+K4sM33La1rREkChJVV7JKyzvSZmfWXlWBXzyOoxMeypLig
         eHjpJvvasfx8HUFX0gZV/pzBJ2nKJp3DEJ7BffCTvcwezkTl1CqHBUxoqcvagbGfkUZ2
         DEGJn4wJdLXCvy+/k4HXOZqB7lDQQs8uUgLYurDJlA7TvwFgSMKdddcZ9YifMH75eijd
         yAvwEstw0ElUSsC4mU0gjpfuLPzThwWDc6Dg5xP56TiFgHSMUKP2NarqEpQhacBJ/77P
         iu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0ocrNAl9iRx+LVvUwRUnlTvu1ULXUztQw9k4igMrjFF9j52TaVgagL2povwImHlnDH5wQJGMWzlci83k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuyLGHMM40R8UmbekahBmHQ7Yj8m9aDIcprQlYPIvIwZe2SelO
	x1JAvasxEDtIM0Kgm/gHpV6O06HVcIvW7Ds50z44Vf1pAWxtvfI/LsmEiLcSqQ==
X-Google-Smtp-Source: AGHT+IF9gb11komyzhf6yHRSBm6Bx0StIFXfTyJUrS6do+skd7QbjRTWFyt+VW82Aiajp3akvAAfJw==
X-Received: by 2002:a05:6000:4593:b0:368:7583:54c7 with SMTP id ffacd0b85a97d-372fd576901mr551215f8f.8.1724219308299;
        Tue, 20 Aug 2024 22:48:28 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383947187sm847323366b.166.2024.08.20.22.48.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2024 22:48:27 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, <kvalo@kernel.org>, <johannes.berg@intel.com>, <emmanuel.grumbach@intel.com>, <erick.archer@outlook.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Wed, 21 Aug 2024 07:48:27 +0200
Message-ID: <191737a8900.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240821023325.2077399-1-ruanjinjie@huawei.com>
References: <20240821023325.2077399-1-ruanjinjie@huawei.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH -next] wifi: mac80211: Use kvmemdup to simplify the code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 21, 2024 4:26:17 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Use kvmemdup instead of kvmalloc() + memcpy() to simplify the code.
>
> No functional change.

Comment below...

> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
> index d86f28b8bc60..7717d7764d2d 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
> @@ -1611,10 +1611,9 @@ int brcms_ucode_init_buf(struct brcms_info *wl, void 
> **pbuf, u32 idx)
>  if (le32_to_cpu(hdr->idx) == idx) {
>  pdata = wl->fw.fw_bin[i]->data +
>  le32_to_cpu(hdr->offset);
> - *pbuf = kvmalloc(len, GFP_KERNEL);
> + *pbuf = kvmemdup(pdata, len, GFP_KERNEL);
>  if (*pbuf == NULL)
>  goto fail;

This is the only jump to fail: so instead simply return here with -ENOMEM 
and remove the fail: label.

Regards,
Arend

> - memcpy(*pbuf, pdata, len);
>  return 0;
>  }
>  }
> --
> 2.34.1




