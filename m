Return-Path: <linux-kernel+bounces-511847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D95A33074
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CCD1886FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE791201023;
	Wed, 12 Feb 2025 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="D0ZZJaVx"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534301FFC66
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390841; cv=none; b=gbxOD33b/Bx2vpmwKih3Zfe9CK95opWFDtggUA+d6UyLjktEOotCZRh9xSufqSm6WHkbkuIxg8xkq4NjImysadSHPjD0ArmLPmWMiyN+cfB846tfHiNWJ3tfw2j+XBOkpwAbZ3aGTLfX00Ri5f7t85YSB9E5Y+/6WUPmrGdJRBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390841; c=relaxed/simple;
	bh=cGC1rqqEGlY113Qnsbpy/9xYPW8DwQek7iDwMOerZxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eapSbqQGeYz27SjHG6ESM4xkIkeaHw7VswIhnLBuQRdr5A9ed6lgWPnGNBq2RR0XtGUAzwUeXrZAvKxQd3dcGJ4kGHRJqqonqg9SXJJAGwx/oe+4pVvOrYp+LVC8TMvRZGzrXDTudqvm0W1U+n7u+WCs3t/Y69Ps/rZJIwsC/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=D0ZZJaVx; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f3a6cb98a5so65695b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739390838; x=1739995638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxGXdtfxhIi93S3Cb2J8z+v+OBi6ejm654vjeGIotlI=;
        b=D0ZZJaVx5K8Nq9vb/gaPqnOutwSmmv8zs6aO/QfqMulq+LwdATGtoSYHAgeh+ETXJF
         QYWHBCUNGbF6j7I+O7voRuN2g84kFsTS7DISKHOPmJ9fHdH/FgIZSoHr8DjPxxd16v8V
         0AXkGGZZR2/fJrKMQRh3//00blc9WjGlRIP5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739390838; x=1739995638;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxGXdtfxhIi93S3Cb2J8z+v+OBi6ejm654vjeGIotlI=;
        b=Ph0fDR5bQ8Q/4r4s5no/2fuXqYFGsHNy7DwXQqlqJLESqHiERO70IezWdivFI+rrLg
         G/pcrZ77EQtgFHAj7J0t5zMILuJESgzKrOU9LsfHkhyYgT+CDEngPX3yU2/dGBY7Xhkl
         wki5t6TQR6SxwVz9qqwcnxwaPEF7nEN672YEZw56ivh7XpQjDykMR8v4v1n1jCLxmbL7
         TlT6zSMk/elQrBrHl3v+yraPnbrNifWx9CwOme1Ke0a85OHRAebDo/y6liMOfBUdpRsr
         KWJz2jF8wMuCaoyfPq+pWda7kb2XbEtBhKYkN8wGdNOJnlHkdzkkc2Qlp8RR6B9y/wf7
         Unyg==
X-Forwarded-Encrypted: i=1; AJvYcCVgbdrU2MaIzqkB8jhyRRU9t2eUCnrjg7PK8yWup1svI+CGO+O337O/n9S+GtosNhZObg09cpAIWUpxid4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIhNlMLA49nSn/xvIYMhZ1prGzY8Su3h521Fh6s+iCv9rYfmt1
	am8gBjUsUPm/EDtzLwMOh6UMIyns04DWjhI9pv6noMKZVCG8CvRtjVXzRfNj8w==
X-Gm-Gg: ASbGncvKcCFLACBUl4MEG5wQ5VoaUJzZpS9dFucqeOpTpeco4SVrZkMO8aXW1k7DkPD
	QowgstH7pBslfupShPlMEnDMa0DB1E+pv5SXZ45UWoTttvsgKtCELDmmRvNqgHNmVK3KcouslIZ
	BF6+DSGCN5kfTpcy6+VfVUuYTN7rd07sIOIgIpPnPzLQ92zyT+pm756w3H0M45OJIj9bo9n+bYp
	Es5yagxN6jXuZKUrDWXuREO0g7W39MosoiiCqXDlqMv2rFzttE3K+5dvk9n6ODOlFGPFpchybfV
	Xe+Xx0E7YkzJU21uli7KVyrPF8vTgs59P7I19okVQyZ7o3+4tpdh3895sMCXTYjGWd0=
X-Google-Smtp-Source: AGHT+IGYzk9T0MFCslT3GehXKMN1D4HHliXmrU5o4/Eiadc4Md49P45SLWZSibKaECMiJpTO58q0fA==
X-Received: by 2002:a05:6870:1690:b0:29e:48d6:2e62 with SMTP id 586e51a60fabf-2b8d64fda20mr2929878fac.9.1739390838301;
        Wed, 12 Feb 2025 12:07:18 -0800 (PST)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b8abc164b7sm2784158fac.4.2025.02.12.12.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 12:07:16 -0800 (PST)
Message-ID: <8d5ae153-24fb-44bf-89a9-e366e0f205f3@broadcom.com>
Date: Wed, 12 Feb 2025 21:07:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: keep power during suspend if board
 requires it
To: Matthias Proske <email@matthias-proske.de>, Kalle Valo
 <kvalo@kernel.org>, Norbert van Bolhuis <nvbolhuis@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Ondrej Jirman <megi@xff.cz>, Erick Archer <erick.archer@outlook.com>,
 Jacobe Zang <jacobe.zang@wesion.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
References: <20250212185941.146958-2-email@matthias-proske.de>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250212185941.146958-2-email@matthias-proske.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/2025 7:59 PM, Matthias Proske wrote:
> After commit 92cadedd9d5f ("brcmfmac: Avoid keeping power to SDIO card
> unless WOWL is used"), the wifi adapter by default is turned off on
> suspend and then re-probed on resume.
> 
> This conflicts with some embedded boards that require to remain powered.
> They will fail on resume with:
> 
> brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
> ieee80211 phy1: brcmf_bus_started: failed: -110
> ieee80211 phy1: brcmf_attach: dongle is not responding: err=-110
> brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
> 
> This commit checks for the Device Tree property 'cap-power-off-cards'.
> If this property is not set, it means that we do not have the capability
> to power off and should therefore remain powered.

Thanks! Looks good to me.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Matthias Proske <email@matthias-proske.de>
> ---
>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 20 ++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)

