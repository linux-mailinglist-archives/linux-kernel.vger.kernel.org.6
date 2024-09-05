Return-Path: <linux-kernel+bounces-316794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0536196D591
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2C71F29FC9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE4D1991CD;
	Thu,  5 Sep 2024 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alFW4iyX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F41991BB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531134; cv=none; b=t2ia6P+5F7VpvfuUXBKY9GZlL+FlGCeflXySZAMZLo42GqXq2HumA7tNh+YgyqBmYPqO7OQH+f+Y2WHtZdiZOdjAAJ/AL3sIHAK9u21GEaSVoaqUuaSyVuB00AsF4Szo9f7Vh7PGx/VIisnGToNLNeAp6S7wkvr2S1uReX4E6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531134; c=relaxed/simple;
	bh=7O87r2xMseHIGhzfoVzmUdZJllmHu+tBeIofr+G8mzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFOoGCU96eHmQGuh1t+JcjaT68fq1MaUStzQjYH+84FSGOgiVSO4TFmkXJU3LZwvzyJrfL1/trg5qZzxzpm+far97/7TA87X/8mhI+vadE+PLLF8LZxXETQpO32xJtH8gArYeM0dnG5FcaB10k1nbHhdaetUwfZfITECO47MPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alFW4iyX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725531131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YS4mx7hdPez9NNqAo+k0RYNNkOOS0sGEzzyoKK9JWk0=;
	b=alFW4iyXoY2k5ddKlVehC6A4IBrHuGgIVFcZdvYGaMH+Vsrh8nwonJIOyKC4yUrndKLgz0
	m8M0203lNWg6/MpwfpbKlLpsDzfIdHi607LMRR6HWYzrEYekHQMf5V+a1R/POAfAlg1GVt
	JSBcJG2s/nArwlbmnZtI9I5rSzwial0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-xIxJSGDZPmW99dCLMn4UHw-1; Thu, 05 Sep 2024 06:12:10 -0400
X-MC-Unique: xIxJSGDZPmW99dCLMn4UHw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bb68e16b0so6061875e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531129; x=1726135929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YS4mx7hdPez9NNqAo+k0RYNNkOOS0sGEzzyoKK9JWk0=;
        b=UadHoX9H/MlEY44YHok30oMA8dL6NcJHSm1tMqVpot45Rda9tuhj9G5FJgZD0U3w/w
         mAI5wiDBRcugTxyK5bcvdrjQkC55hTIcX7VItXI+p9MIDWA88uf7OG4YHcawyUuaom0X
         T6ZnIkBP3GKpXThw2J4uhNA6vxP1vjawFc0COEkEkM7CWjof0vn6nDns3TSVXSxb+A/t
         9Oxf7rkSnygVef37Lq2Ge90Sw9FirHi/sy54Mq9Q4xgnkQBHfUD9kFynreWNH/JZhXyz
         omO7NJo3kkQBGbTn3j7IM+bPusvP7rI5s6UP88pgaHIHQoCuiRp6P3QcNsR9LLUDx8vH
         dnJA==
X-Forwarded-Encrypted: i=1; AJvYcCVCoR7b2MiBPLGMSLipSaKMSO83W6OfYcob0EsSudTvZQ7tfHmG7f8bzZu/Zh+ny8NScc6jAuu+tgXSXPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2kv9oVyC7Uq2KPEJRDb2jVcqnR6XvmuUpgr1T4uK6n9w6frGa
	g2e312YQQAxmkeL3w1NNtImoHoL3QtwHiKzoKA5r1zx8p2mp18EvFLyVnEi7rxi/9/tX2KwdoZU
	6ahpCgD7qe20mHgeeWFSCne/B8RgdzYI7T1FbafPBnvWrlSjILoyCZXzdZzP04Q==
X-Received: by 2002:a5d:668a:0:b0:374:c11c:c5ca with SMTP id ffacd0b85a97d-374c11cc70cmr12421490f8f.46.1725531129232;
        Thu, 05 Sep 2024 03:12:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6NTbwAh/E1BRBZJNBYvljuncF0WzhSvs7OV8kHiq8uftKn+7VbZFSaT7QMvQPBxaQ/UkiBA==
X-Received: by 2002:a5d:668a:0:b0:374:c11c:c5ca with SMTP id ffacd0b85a97d-374c11cc70cmr12421448f8f.46.1725531128703;
        Thu, 05 Sep 2024 03:12:08 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c0f6f4c4sm13588410f8f.44.2024.09.05.03.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 03:12:08 -0700 (PDT)
Message-ID: <2a44050f-89f8-446f-aa5f-3101ae46f314@redhat.com>
Date: Thu, 5 Sep 2024 12:12:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 4/8] net: ibm: emac: remove mii_bus with devm
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, jacob.e.keller@intel.com, horms@kernel.org,
 sd@queasysnail.net, chunkeey@gmail.com
References: <20240903194312.12718-1-rosenp@gmail.com>
 <20240903194312.12718-5-rosenp@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240903194312.12718-5-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 21:42, Rosen Penev wrote:
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index 459f893a0a56..4cf8af9052bf 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -2580,6 +2580,7 @@ static const struct mii_phy_ops emac_dt_mdio_phy_ops = {
>   
>   static int emac_dt_mdio_probe(struct emac_instance *dev)
>   {
> +	struct mii_bus *bus;
>   	struct device_node *mii_np;
>   	int res;

Minor nit: please respect the reverse xmas tree above.

Thanks,

Paolo


