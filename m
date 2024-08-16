Return-Path: <linux-kernel+bounces-290037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D84954EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA641F20EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B8F1BF324;
	Fri, 16 Aug 2024 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AP6aOQih"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461271BD4F9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825118; cv=none; b=PDZp2VmuQiVV+I4xUP1Jnq9xe30R268g9JY4WylCRrAJYupowr9o76gyx9EyE9TFeQtekWXh/7hzDT996o6bQW9tzPVtyAS/cgkXIX29f0cjHJNohoy7T7iyO8YF261lpzzF7ma89oLTFPvrv3KtimUkJtVigjvbDuXcwxrI14g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825118; c=relaxed/simple;
	bh=kNMwi6/vL9VQa4GWyVCWAlH1b/iiCl6DKS6u4IVuWZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4SWTSMtNb4EVTtZeMlNLA2EJ6luCVziLxxQJ6PFrklpxDgwSJgDng2pZTszglBvbpSyLrYbmx1Px8JGO+VxlykpbvVCI8PKLu13nHrQTf5AoneRGDb/ZLH3xpdIYSxt1OPlfxShZip6EMXTzZhODC0gdHJ3qhjwK8UPOoZipZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AP6aOQih; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7093b53f315so771896a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723825116; x=1724429916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pYrK2RhkUPrRPBfldhyUexgVa7GT5fKFpTAHXDEQoBs=;
        b=AP6aOQihjCPUX9hcJp2rdq03oJJ+s/6znmKutjpOn0YQqPguKKWbRtzjA7y3LXN2Ep
         0dNjEBOUZ1zS9eZtDazBxjKFLHIF2eEFdwIxBzVDTXLltN5uPsc//17l1Xv3yZJ+WvMC
         8Yjo+9sGJPfF0TzLic7qr8LTCg1mx1fDI6aCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723825116; x=1724429916;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYrK2RhkUPrRPBfldhyUexgVa7GT5fKFpTAHXDEQoBs=;
        b=WRzhfflR8rp93B/5TmfSLDlDOu2UdwvEAIbb3QU7RZ3Rkq6/cFOVnbfbwcY8z7+CQ7
         gVbKhij3YVs8Y6XcqA64t3iT7X81AHd13Di8WarskaNIXLmMCxv5aoYVS/zFsIzj6cz3
         yWJobE05Jo8ntV45CPSWhbRtk4vbjX+sAJr2C8qnpGenDGYNyKWr97Tn/usnlZygXRuy
         yNEqE0IY0Z9v0kUyQtwq8AsFtr42KFpCJ7KyJBE2NWnRaEL55cl0MqVAKb3Go8LCbW9Q
         9taIu48OEjSIqzEgKB/xwzZoaCuxqO0SvzZH/M8Znm4vPRppeubsOtSkLhKs7x7qjEcs
         8cmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7PY+yRlN/LvpZmefyVloLx95Z465UYmgCtCAf564rmmUu9gicV6RqAeOEYXA2sW0llLTXikkYOjpvonUsJ5dva6bcaq/2Dt2RfT/o
X-Gm-Message-State: AOJu0YwCawzMROY79T634tDxGJEaj6OltNiDYlMko7F4HohbHRv72mMk
	csbeFHdLSQ0mUbbwyBRp5RuF44lYP2gBe0BmlhrT5isJTGfDa5nb2MUCvc8zQg==
X-Google-Smtp-Source: AGHT+IFGFy80SN39TstUeIUHyNJmrcQez1h79V5ry5FfelR/TvE1aZAi7zD+BNDCMws483yF0eJxHw==
X-Received: by 2002:a05:6830:6d0c:b0:708:b46d:5c76 with SMTP id 46e09a7af769-70cac8619a0mr4254105a34.17.1723825116108;
        Fri, 16 Aug 2024 09:18:36 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6ff0a5a6sm19004846d6.138.2024.08.16.09.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 09:18:35 -0700 (PDT)
Message-ID: <e9b229f5-b796-4bec-87c6-a7b64df51e44@broadcom.com>
Date: Fri, 16 Aug 2024 18:18:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] wifi: brcmfmac: Add optional lpo clock enable
 support
To: Jacobe Zang <jacobe.zang@wesion.com>, kvalo@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 saikrishnag@marvell.com, megi@xff.cz, bhelgaas@google.com,
 duoming@zju.edu.cn, minipli@grsecurity.net, yajun.deng@linux.dev,
 stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
 christophe.jaillet@wanadoo.fr, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com
References: <20240816020635.1273911-1-jacobe.zang@wesion.com>
 <20240816020635.1273911-4-jacobe.zang@wesion.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20240816020635.1273911-4-jacobe.zang@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/2024 4:06 AM, Jacobe Zang wrote:
> WiFi modules often require 32kHz clock to function. Add support to
> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
> to the top of brcmf_of_probe. Change function prototypes from void
> to int and add appropriate errno's for return values that will be
> send to bus when error occurred.

Looks good to me. Not sure if I should Ack this as my SoB is there as 
well. If that is not a problem than here it is:

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +--
>   .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
>   .../wireless/broadcom/brcm80211/brcmfmac/of.c | 29 +++++++++++++------
>   .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 +++---
>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
>   .../broadcom/brcm80211/brcmfmac/sdio.c        | 22 +++++++++-----
>   .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
>   7 files changed, 49 insertions(+), 24 deletions(-)

