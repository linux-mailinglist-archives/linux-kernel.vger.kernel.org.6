Return-Path: <linux-kernel+bounces-281882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2AE94DC79
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 13:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE351C20DD6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 11:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F47157E88;
	Sat, 10 Aug 2024 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YzXRcGfa"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C5157495
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723289028; cv=none; b=LTnZZ0uix69QOS8JtqpH38RrtbWELbZzqLCb7zpw0stjqm8cBLZV1mc8mpPzFIidUcUCakMER6ZiJBhsYmFmxKgqTp2+xVpPG4oB+PTWcQBnjKXW8EuxCrR9UDV/q2AS61VZdubth6nl1asURy4KfYxooBfiX1iAibSAaHAGnV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723289028; c=relaxed/simple;
	bh=/11QHOe4lP1IRUIYesxzlPXVFs/uUVXBt4XVSCD6Wd4=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Lc2rTtZPxFiqL7Ilvz5fMyWyl+cTLDq2Nq3cTnoPU07uUltw/8l5x5uM9EnPgwARwn2QTlytCyuJUdUkAPN/vKDWGPvb6ninENaVTFSmxX6Ll9I422PBIRp2yyJXawYiPs3dpYh90notMiRrpviIl1evnJCcxB0B9jI0NE2r2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YzXRcGfa; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso3565561a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723289025; x=1723893825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDh1fCmWj10iQxhI7WVQeAn05256/EGfVYp4b/9uFoQ=;
        b=YzXRcGfatQ6oD94lXqlNceEuqV+zVFPxrwNJ521zB+xaXBRg+7Oyg/HSdtAd7ZtKzU
         eNiIwrv7+8K0oHpz1kJP7TV3Ia7vbXuhE6Jdp573+yliRwZxWNqsEyWDrgC6ixyE1Nq4
         FmskW0IDqnWl1fScXwc2zG5SpWlx7SV8GQFfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723289025; x=1723893825;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDh1fCmWj10iQxhI7WVQeAn05256/EGfVYp4b/9uFoQ=;
        b=h82ITAJcKUJNVqy8MErpkEuPpwLRSDNQdFz0cY9VRs3h7lQYZHmFyVTZJykIzVpRlU
         kl84QRDlMxO1tvW58p5laW7GsTlCg5zApAfQj92WfaaOwNpqB8IFQ3l2x6mQI2/Vd41a
         +7mIFMGheW67Qz9Q0uaPCIC5QJVJJd1vlSt6fmphbOafSos+aOGYl09vBUeRZlqV4Siu
         9J0++Meecs7hdsermZlu64TA7DJdpJQH4lzu8/XQlLEQtf/l5EPTZ/PW+FaKqtSV8WKE
         4HbzYDhTMZjTh49iQ6U9Xi0gR1AwMl+34ZTuhgtVRKE12NuxpbEnSji69l4ffM0bpDi6
         dUSA==
X-Forwarded-Encrypted: i=1; AJvYcCVdzXX0sS4ADQG/1JLwlXRDC+akwZBpHd9ZS4U/bf1ksyPEscKs7Cdu5qrU3dkVLmd2g2QHNKROwqi3i74ynv1oGAvtjpbzt6v9Xoqy
X-Gm-Message-State: AOJu0Yyv1BvxbfbzNgPFooulZl7dPgwkdI7HgoeiyS31MBOw72jfA1SP
	f6ZpAC2UScywgliQOrgQXwO5xgCfvclSiMsJm/9t4agecvQgwkPiXObTSTGiUA==
X-Google-Smtp-Source: AGHT+IGFm1oTOum+km6q9IW7OvihX00b13brOsvRjwSLEedERSI+44X5FqA6T/GsmR2C4k72tHaIfw==
X-Received: by 2002:a05:6402:2791:b0:5a2:763e:b8bf with SMTP id 4fb4d7f45d1cf-5bd0a61181fmr3652216a12.25.1723289024565;
        Sat, 10 Aug 2024 04:23:44 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a60181csm530489a12.81.2024.08.10.04.23.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2024 04:23:44 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, <robh@kernel.org>, <krzk+dt@kernel.org>, <heiko@sntech.de>, <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <conor+dt@kernel.org>
CC: <efectn@protonmail.com>, <dsimic@manjaro.org>, <jagan@edgeble.ai>, <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <arend@broadcom.com>, <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <megi@xff.cz>, <duoming@zju.edu.cn>, <bhelgaas@google.com>, <minipli@grsecurity.net>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>
Date: Sat, 10 Aug 2024 13:23:43 +0200
Message-ID: <1913c07b218.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240810035141.439024-5-jacobe.zang@wesion.com>
References: <20240810035141.439024-1-jacobe.zang@wesion.com>
 <20240810035141.439024-5-jacobe.zang@wesion.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH v9 4/5] wifi: brcmfmac: Add optional lpo clock enable support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 10, 2024 5:52:11 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:

> WiFi modules often require 32kHz clock to function. Add support to
> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
> to the top of brcmf_of_probe. Change function prototypes from void
> to int and add appropriate errno's for return values that will be
> send to bus when error occurred.
>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +-
> .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
> .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53 +++++++++++--------
> .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 ++--
> .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
> .../broadcom/brcm80211/brcmfmac/sdio.c        | 24 ++++++---
> .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
> 7 files changed, 63 insertions(+), 36 deletions(-)

[...]

> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 6b38d9de71af6..461b7ff3be24b 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c

[...]

> @@ -4474,8 +4480,10 @@ struct brcmf_sdio *brcmf_sdio_probe(struct 
> brcmf_sdio_dev *sdiodev)
>  bus->brcmf_wq = wq;
>
>  /* attempt to attach to the dongle */
> - if (!(brcmf_sdio_probe_attach(bus))) {
> + probe_attach_result = brcmf_sdio_probe_attach(bus);

There is no need for probe_attach_result anymore. Just use ret variable 
instead.

> + if (probe_attach_result < 0) {
>  brcmf_err("brcmf_sdio_probe_attach failed\n");
> + ret = probe_attach_result;
>  goto fail;
>  }



