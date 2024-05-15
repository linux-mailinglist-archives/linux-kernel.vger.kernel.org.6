Return-Path: <linux-kernel+bounces-180306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF4B8C6CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250691F22BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213CF15ADA0;
	Wed, 15 May 2024 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DwXOaEWw"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33282159562
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800577; cv=none; b=nb8qirXsPoRYyyordbrCjgH+WW5ffs/e5EU5AoCHLmnLhf/V0BisXbv6+Vfj30i2vuObB2C3mkzWNbrejyIorJwPHjZFYfz95hr2jUne2mxbaKg4AUlX2k2AyK8ZfQM1wLP9GksHmiu9ltqAVk0DuPRWWpL9QzMiH6WYPAa7jus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800577; c=relaxed/simple;
	bh=FP5LyQsEGquqKItcS87RpeQ08Gmx+s5LG2B/J1Ts8Iw=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyUvTmGowTDcnzhLdHLQLzLpPqkwMy+KS67YICOXLZfBLcdtO29QmggtWipSOAX/OZ2sIuukuaj4de6jRMpoFoDphwhQzYDEPOWVLGdFsWrsRtTJzOytzAXX6LaIpoh/UCM+lMGW1Df2FDLfCC4rEhqymfXZqRzqKU3qEsW1954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DwXOaEWw; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61bed5ce32fso77961727b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715800574; x=1716405374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FP5LyQsEGquqKItcS87RpeQ08Gmx+s5LG2B/J1Ts8Iw=;
        b=DwXOaEWwek0SnPySO1ARVc0A/4OgrkGiKRT5mcLRlWNxBKGu93kvckwdGoev7VXqes
         8oP0wLbVNorcM7UTp5kFPZa+XHNMpTbKO8gCHBsFl1m9nbc0iln2Gz4tJdmEwV1i7nK/
         1YYuF5S2eQ7VOUG9MD8cQooIgx5qll6LjsBPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715800574; x=1716405374;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP5LyQsEGquqKItcS87RpeQ08Gmx+s5LG2B/J1Ts8Iw=;
        b=R/I8vHkP8mUIPconWpfofBWbQfV1K4tysJ425Rxj9Pr3QWGsgudlOWb0jNTF571K6d
         fgQ3jpUeIqfcMsVMFV+bT4NgdcDbgHA3LHmZIQLwHNXpiEQbgcM2j3rUQVfVUP+0qvVT
         qhcOnSVzjRj4n2U7gKEI4bg2mW5c4oq5KWPalKjaFCQX341BBdyuFgV3KR1OEwKxMOqg
         4su0yCCsB+hiP6aEgjbdgYAloT3s1zLLbxJxibDRRcjpoAqOtmR/QxxJ/hQC/m0Xr/Kw
         5CPpSlD+NAWly5aF+XJMQJqIDGgGVMFR/bVTfkvzZ7BDEyz+IrhiKlr9Is5eg81KQ/R/
         AmqA==
X-Forwarded-Encrypted: i=1; AJvYcCUY13R+QLngcipbMXwavFBgJ1LoA2BxgA9z33fdT7p/Q51UVALu3U+IdXFlQVJCmp20RwMQaEvfMRMfS0tpGnaBI3UdQMQb9xFXGsOm
X-Gm-Message-State: AOJu0Yy7ht1l8+4lwq7GK1do9hF2XPBpI7Kjo5+CfZLem/xze5CMAHrw
	MHPQBe1gqYgFDPP7TY8kN1Gqvc445UUQ/yjkKKVflK2exY82wFphIyaOybl9MF0b27ANmtPoadi
	YZn4CajwvMaiIvICo6IzH57+I/BpEQjEsu2js
X-Google-Smtp-Source: AGHT+IEZFVp0/9J3vEYY3DeetifpNlyI7Reu7bida3ovANfhBvDsm0gF8xGPrJXaQaXknjiNqesUsWMhYeDWThoRIkM=
X-Received: by 2002:a25:6b41:0:b0:de5:568a:9a9 with SMTP id
 3f1490d57ef6-dee4f2f7f74mr14602381276.38.1715800572793; Wed, 15 May 2024
 12:16:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 May 2024 12:16:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org>
References: <20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 15 May 2024 12:16:11 -0700
Message-ID: <CAE-0n52ptoRRQEL1G9vTZ7ExemrUSmV2Km=uts_E7wBeoz_GcA@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath10k: fix QCOM_RPROC_COMMON dependency
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Rakesh Pillai <quic_pillair@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-05-11 03:49:59)
> If ath10k_snoc is built-in, while Qualcomm remoteprocs are built as
> modules, compilation fails with:
>
> /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_init':
> drivers/net/wireless/ath/ath10k/snoc.c:1534: undefined reference to `qcom_register_ssr_notifier'
> /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_deinit':
> drivers/net/wireless/ath/ath10k/snoc.c:1551: undefined reference to `qcom_unregister_ssr_notifier'
>
> Add corresponding dependency to ATH10K_SNOC Kconfig entry so that it's
> built as module if QCOM_RPROC_COMMON is built as module too.
>
> Fixes: 747ff7d3d742 ("ath10k: Don't always treat modem stop events as crashes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

