Return-Path: <linux-kernel+bounces-285240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EC7950B15
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E4F1C24478
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D591A257A;
	Tue, 13 Aug 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S8ZUxRmB"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD46519EEAB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568670; cv=none; b=m7GZPmrf3sj4GfDPYilUgE3G4iiSSCFpowdqlT7Oy0Wrs6eaVuAneBqxnOyIHymMINXNsMvabaxcAxlm+4Z0fvBwIJegVClxweM6NlToLAB9KLk+kE1JT3he//ReO05mu6BOBaHQYU3tvse2/eu/tjaFLezeNcIzJ9WYw7NmNLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568670; c=relaxed/simple;
	bh=xrsSftCVhZOtu3KXEIZqEaoX5GuKzU/oyvGNRAnSz6I=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=U1DLQ6yGXnV6m4Sdjq+Ams+pfYE7wnIbVCYAj/w4p7lzlUN4jyl7vsZS2vgTuhuCYRMEUZRBT46e7kBecUI3phx/KImJoDUCevc3Gahi3xzZv1/PtHqksmHeJO1vc0ZSteaN9YwXurJwoz++c1wQvhDHgUMnwFipRVXXycUa0F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S8ZUxRmB; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso63095241fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723568667; x=1724173467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmfVHiTAghiA5/icoM+TOI1VecjW2wcU/5Ch8OWg9QQ=;
        b=S8ZUxRmB3QVtjbh236oJVFK+07wp3nGNLXG8YRXnEE0xoK8NtteZUKR0uxfzDOF9/u
         KM3rOCDA4eDSrYnXRCXdjAnX6yxp7AfvL85rzuI1ng8KbCclPAiMphXQ6Yuphqb1AIYQ
         n7SE1aR95WtsmgjnHFLT/O4pX5B+uQ3u78/v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568667; x=1724173467;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmfVHiTAghiA5/icoM+TOI1VecjW2wcU/5Ch8OWg9QQ=;
        b=ijrexagOMTJyO1CG/k0YJISP6wgGEVChitXsRQpVs4ypSEO9GWQh13jDZVQ1sATRi3
         lurtxzP5E6E7uTRloDYbo/gLXiCTf6mep74THQ0iI8/enYlesrOX7iF5Wk4k3PstYfQV
         XkyT1AHeCjUHah0cMsjdzw15OVbwgbPARCKUKL2iaAHCMWRsgswShtnagtF4bhIzhvgc
         WVCC7trCBrHQXvniVDcSHip++ywzpX2jiRgiuHzUm1Wfwa+T7WJR/M1yvztsHnCE/yqH
         +IMnF9nPGwu/igJpITxhgmeW3soRkj7XTbeAPvgfFM9oHTMMvdSbPts/Tql1Ial7i+pF
         rcsA==
X-Forwarded-Encrypted: i=1; AJvYcCWa64TrqoOMHLxWQxh6Ud+RjtGdKaMQX/y+P2aMvzB35rfLp5v//Kf16vh8049lUJkIhg4pJOFnGUFn7nqTCDW8NhejKA/erIkHGFVL
X-Gm-Message-State: AOJu0Yzu904y+gtNWqN+wQUYbupzSG6toZLJd90GZYbfr6mWmUnI7Pn3
	M5ZIB0SKpbOlrbammw6zLxfNr5jhGwHyZ1bcZGwXt+UXWPJ77B5V+XA6bwUi6g==
X-Google-Smtp-Source: AGHT+IGMS+LrGaCj1Lg+QZmrrlMH0Ixfn/L59zuCwNIRqWw0O7FBQUZWwFW5fNKu3n2lX5Yg9gyCBQ==
X-Received: by 2002:a2e:f19:0:b0:2ee:80b2:1e99 with SMTP id 38308e7fff4ca-2f3aa1f9dcamr96771fa.44.1723568666421;
        Tue, 13 Aug 2024 10:04:26 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190ad1d3sm3081547a12.28.2024.08.13.10.04.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2024 10:04:25 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, <robh@kernel.org>, <krzk+dt@kernel.org>, <heiko@sntech.de>, <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <conor+dt@kernel.org>
CC: <efectn@protonmail.com>, <dsimic@manjaro.org>, <jagan@edgeble.ai>, <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <arend@broadcom.com>, <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <megi@xff.cz>, <duoming@zju.edu.cn>, <bhelgaas@google.com>, <minipli@grsecurity.net>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 13 Aug 2024 19:04:25 +0200
Message-ID: <1914cb2b1a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240813082007.2625841-2-jacobe.zang@wesion.com>
References: <20240813082007.2625841-1-jacobe.zang@wesion.com>
 <20240813082007.2625841-2-jacobe.zang@wesion.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH v10 1/5] dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 13, 2024 10:20:24 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:

> It's the device id used by AP6275P which is the Wi-Fi module
> used by Rockchip's RK3588 evaluation board and also used in
> some other RK3588 boards.

Hi Kalle,

There probably will be a v11, but wanted to know how this series will be 
handled as it involves device tree bindings, arm arch device tree spec, and 
brcmfmac driver code. Can it all go through wireless-next?

Regards,
Arend

> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml      | 1 +
> 1 file changed, 1 insertion(+)



