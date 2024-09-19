Return-Path: <linux-kernel+bounces-333241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7239297C5CC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DB41F24A60
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03261991B3;
	Thu, 19 Sep 2024 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmSiIDCP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80B1990C3
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734414; cv=none; b=Ywa8atB15mRf44HEGsNnk9JPcVK6RHcTnR5Jbcgn/ogWeBgrJHwVauTMG/cRjtxARmwHgDsxUPDOnYlxJiV4BpZKYw1K21qWo3iypWxdRVOZl+9SWbm9niSc5GAT4x2HSAA1zKSP+X6WYR9RECQZDI0I/XlDFPPvoHYWjpXfcQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734414; c=relaxed/simple;
	bh=dYRXd6FDREmGuCeNlhWySa0+zkeJcyv2/+5FEfbhIZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6l74oqUCKUttm7W/TsrR95/R31YisrefvW0oW6R96/jlv9KyGmDeIZ63cHT8B9ZVXCukaClztoH9IWDT90qHGd3bmioadVbejRsthSTStBFIXlm6uJDOsMKUTXQLdy150DuOw6QVsr5wvsqX++mxJv/4p75fvxvldqOS0o6gBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmSiIDCP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726734411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqhC0wpBsYX5sC0cLoRKsp0VJjTCpEKkewewenMyOfg=;
	b=VmSiIDCPCML8m5FFH80clsyINatyu7My3L1N7Ej/+zCVrpam1TEFEdoksSlXmBKtzfWykP
	4LNHm4u2F9/nODnhACOezLJIJ1v/QV0i8N+NZMPPmY8MNxiuW1VydSpoox763N9tL3Zb2f
	pUQEDLG2T/8aIYAU4kNWFVwDSxU+MbM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-oFneGIb0OxyZZBiMQ2989w-1; Thu, 19 Sep 2024 04:26:49 -0400
X-MC-Unique: oFneGIb0OxyZZBiMQ2989w-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f7564ed914so3516691fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726734407; x=1727339207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqhC0wpBsYX5sC0cLoRKsp0VJjTCpEKkewewenMyOfg=;
        b=h+wQiI7Ky4XPrYvPKYVYgsWCsByF7wuqJ1shYCC2niuGj30c97SpZOmPIQbbkhN3de
         jZcbslKhfgvnYzDedV5TfmIYUlvAk9W0yGrbePSI2B3RiRQdXe2+q/dClVgwaufoqw57
         PCjYZK/0fsO+URhJ2LrSw6ciHcT+Ehrvn2eeyMbK5tl7Nk7L2630gYRMeezL2FKsmsRB
         K1tHN+GXCDAtACfhZqfF/HX7OE0vNsRukyFe2GaQ1EP9vNItmkVACYoTclZaEfgvhSDQ
         23Ahp54HaxEBpwsMWEjcT4r5hXlPArUKqBRA1/xbZfnLLLUYeL+SJ45+oPMeVEFmUORn
         zTVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiZ79Own9AzhYAkb9cD7X03XmxpdTzDgKdS7raM/wwwp8U2o9fDb9bEWeJOjci7q/s9ULZwtHQta1+Sl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYbj1y/yCV7Q5fKWwhBWqkVqVAvwk4XXncQxKWhdDY+5d4NA0R
	pXN4YHzzfAKPRJ72Xt1iFcbsBk0b0T4CHdouB43i+NS/ysx6I30NBlVBlwzzYChOBPIMuaRkeQ3
	4nc/l8Lg1NkSCDq3Ez/MYQ+jN+wcRVs9B20bl1TIj8GbrbXkb1ecKVe9oB+Vw7g==
X-Received: by 2002:a05:651c:1544:b0:2f7:4c9d:7a83 with SMTP id 38308e7fff4ca-2f787f432a5mr134483151fa.40.1726734407180;
        Thu, 19 Sep 2024 01:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtcmy7e84CThTJr6C7Y2pMRiyMOC3s+a/wSmAi31apvwn8jqB0EzCmgZOZqgYWmVjBKgQqTw==
X-Received: by 2002:a05:651c:1544:b0:2f7:4c9d:7a83 with SMTP id 38308e7fff4ca-2f787f432a5mr134482971fa.40.1726734406714;
        Thu, 19 Sep 2024 01:26:46 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f0600sm14565562f8f.9.2024.09.19.01.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:26:46 -0700 (PDT)
Message-ID: <9b668881-b933-4bae-a0da-a107d2b531e9@redhat.com>
Date: Thu, 19 Sep 2024 10:26:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: qcom/emac: Find sgmii_ops by
 device_for_each_child()
To: Zijun Hu <zijun_hu@icloud.com>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240917-qcom_emac_fix-v5-1-526bb2aa0034@quicinc.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240917-qcom_emac_fix-v5-1-526bb2aa0034@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/24 03:57, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> To prepare for constifying the following old driver core API:
> 
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> to new:
> struct device *device_find_child(struct device *dev, const void *data,
> 		int (*match)(struct device *dev, const void *data));
> 
> The new API does not allow its match function (*match)() to modify
> caller's match data @*data, but emac_sgmii_acpi_match(), as the old
> API's match function, indeed modifies relevant match data, so it is
> not suitable for the new API any more, solved by implementing the same
> finding sgmii_ops function by correcting the function and using it
> as parameter of device_for_each_child() instead of device_find_child().
> 
> By the way, this commit does not change any existing logic.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>


## Form letter - net-next-closed

The merge window for v6.12 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Sept 30th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


