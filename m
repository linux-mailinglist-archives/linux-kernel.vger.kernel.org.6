Return-Path: <linux-kernel+bounces-365543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5D699E409
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FB01C22655
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA771F8F19;
	Tue, 15 Oct 2024 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwVuyQwY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ABA1F706A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988242; cv=none; b=kmbnQNZpDuMJM6cTNl+gsgj3H2ON4Ou6X+rX7GGw/TA3Hisa6rZK4eWwb862Yx/Cl7naTjJ6Bp8O3ZM7wDzmDNIdvUdS5xCHi9xE7KcpE4OPvTObBkBvuWwUe7vGEMfAfYRGhmmUuCNkYeIU/fuJZW8U359TBt6sOw9pH77GaIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988242; c=relaxed/simple;
	bh=zlX9IF6L6uFRuAeMs99rcSZv8S3tAxccHbjKjKLs2PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gC71NtqkGm/F5XBf/m8ZqPVnaLb7v90QDRUmHgSUapvr+03xoeAEoRAiQwI7CkKgKkWNc8QBxNPLmPm0NgS8IJjH27PVQSVmHIT1DoJK9V4ikXBFvwuq6VHPwqEYh8kq6IrDw/PsHTgGiir2BHoFJQO8kv4z2lxSAw9nZg89e0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwVuyQwY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728988239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNlwq45QHItRtmcpJA7GMv4hEQyNZyml809eS3mqYWU=;
	b=VwVuyQwYW5/3fo06V/4cd4InDK6sCYcRb2GwqPxXbZvMC8WWEFgZ4Po0aTCPZNwE6UYwml
	A79XQecOaK+1tUNFTXmTjuUvpbj1ObDN2T4a3eg4Si4Lww8+WQnr0WD4iEZJeViNqlu8eN
	xqQCEUwCbkVPEL4vewGz0nur7m6lcSs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-M9NZETECPyieDs0aNJifCg-1; Tue, 15 Oct 2024 06:30:38 -0400
X-MC-Unique: M9NZETECPyieDs0aNJifCg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d47fdbbd6so2432542f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728988237; x=1729593037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNlwq45QHItRtmcpJA7GMv4hEQyNZyml809eS3mqYWU=;
        b=DXoL2SY0tzlN8VGjWvyFt5znQQWdLXFgjiMB6LdEpeA7+xERkrA0Ft5jQ6W+PKLsga
         h9vuaGIKhG6KJJn8kyYId3anUEvYmVLYlpiBUZtakuY8MG/x4ZXIQFGsa4raRxs4kjjb
         +EDHco4WGYuUEYQYCtjcuNABvmI1V8+RckILFKwcJV2CLdxGKMkDlOYtcNIDbVZKaN/e
         pcCdC2J5zkYeMmZ2jH+1GmPKvv9J1cdXMKe9zCkAJP7CsW9ImiUA+rXYeubtm3k+8GmU
         5da5oQVvqIrLNm+HOxIAKJuusQxuTUQ97Gtyf63p2qJVkJiTO4Th8ve3dAOrq7fo9e4F
         zjjw==
X-Forwarded-Encrypted: i=1; AJvYcCWpFoEajMKf4g5P5D/b7cInIcY00Fmxj/SlkWl87sM0QApAq48UkJOF54yLIVO6yXDjp8I5cRly2dEAX1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrxOulJP2sGTMsWqqylu80+1QJ9xvhmEwZX5I6nnMyHE+crT3u
	OHO42Cy+piBNGxlHwI7+X6HBSNOv1bJbr9CGRBhNAIRS6L00MIJDLulUBfK6w5mH5SiV9Z+o0+m
	C8BlEUPNU7a86COjiGnUIy0aTzbuA6k/0NRaFn9HPPyjS/8WPFlPkdcrr0QB30Q==
X-Received: by 2002:a5d:4244:0:b0:37d:30e7:3865 with SMTP id ffacd0b85a97d-37d5521ac3fmr9786758f8f.34.1728988236824;
        Tue, 15 Oct 2024 03:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1NYcYcwJtR7C3+O7QSeW8T1HfZYIUv3EZPiHq8phl1R9SlWw8hdyuGmoJKNXwPyUa5+ozFg==
X-Received: by 2002:a5d:4244:0:b0:37d:30e7:3865 with SMTP id ffacd0b85a97d-37d5521ac3fmr9786724f8f.34.1728988236420;
        Tue, 15 Oct 2024 03:30:36 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431487c194asm2704135e9.21.2024.10.15.03.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 03:30:35 -0700 (PDT)
Message-ID: <d1ead515-8ecb-4b43-8077-92229618aa43@redhat.com>
Date: Tue, 15 Oct 2024 12:30:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 net-next 10/10] net: hibmcge: Add maintainer for
 hibmcge
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
 jdamato@fastly.com, horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 christophe.jaillet@wanadoo.fr, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241010142139.3805375-1-shaojijie@huawei.com>
 <20241010142139.3805375-11-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241010142139.3805375-11-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 16:21, Jijie Shao wrote:
> Add myself as the maintainer for the hibmcge ethernet driver.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> ChangeLog:
> v11 -> v12:
>    - remove the W entry of hibmcge driver from MAINTAINERS, suggested by Jakub.
>    v11: https://lore.kernel.org/all/20241008022358.863393-1-shaojijie@huawei.com/
> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1389704c7d8d..371d4dc4aafb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10275,6 +10275,12 @@ S:	Maintained
>   W:	http://www.hisilicon.com
>   F:	drivers/net/ethernet/hisilicon/hns3/
>   
> +HISILICON NETWORK HIBMCGE DRIVER
> +M:	Jijie Shao <shaojijie@huawei.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	drivers/net/ethernet/hisilicon/hibmcge/
> +
>   HISILICON NETWORK SUBSYSTEM DRIVER
>   M:	Yisen Zhuang <yisen.zhuang@huawei.com>
>   M:	Salil Mehta <salil.mehta@huawei.com>

Unfortunately does not apply anymore. Please rebase, thanks.

Paolo


