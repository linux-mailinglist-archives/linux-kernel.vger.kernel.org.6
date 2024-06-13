Return-Path: <linux-kernel+bounces-213885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6769E907C05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7541C24219
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDB3137905;
	Thu, 13 Jun 2024 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj9mr7HR"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DBA199BC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305529; cv=none; b=jJ2K+EwFkrwdTU7eOJ59Oti9aQdIsO3Na0exdmQ4W0n4geKsmPqXHedIrhWMP6XhPyYJp9DisLdDeReHT05nIbGBO65VkkpBeQX9NhRodpP27QvJAzknxrttD19h3q+rQlY2jUN+FLlbsF5dRRW4ntwXOCJ0qA47cdg7Z4uQYtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305529; c=relaxed/simple;
	bh=fUn8fj2+aOx1qt24UXCgWzuYqLTzLzRTdcyQBNixoKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E/QsRllaAsgf748qzvOCfgAd6SCUmdTt/2lHsegs2ughERgibeR8eFh2SS+XXENYGq8HmLk2EqDAKQqAPPz8SSA/6YoSzqYh/MJ7vltEIhV9JYqSBdRy2W71kBy2IWf83N/PAu26Ij16kVt3EAQFH8UWKJa70p3IQ/jjA1A6sug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zj9mr7HR; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52bc0236f04so213852e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718305525; x=1718910325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4IyJ8+sKrBscC136/+WcAKqMMnfDSQvhb/s79SNUCQw=;
        b=Zj9mr7HROpbBCOVtdsDwvlf+RejDTUdniAfIA4lp/W8WVlhjBksR4iOUUDQbqRerFP
         wqV/31TxZPyZpdujydzgssdvxdfH76wnJlxahlbqh0J3Q+K5bfAahr5XSZER+XEowL+g
         /4PkHGRvUSW1jj71h7W6bg63xA5JoqEFLJlKq/rWHKK0xQNmQ2FWs1KlhyFGpt1in3we
         NeKqkdCnkWTwAfODB+3vsRFz3MqwXKGmb+fb9qde4zPfXB4A+P6jKS4L5Sh/gD69w7ze
         QZySD2X96rsgwAGohr4D3OiCABHTjaw/lJq3EpPsXQSiHAqdWKhfL+2fdbxzSjktj8PT
         QBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718305525; x=1718910325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4IyJ8+sKrBscC136/+WcAKqMMnfDSQvhb/s79SNUCQw=;
        b=mwot+oQP8g2bRv52+pMRWjKon9sfifjNnWjbNGaRvij+fiVj3Q+inlMla4Mbg7BSWo
         wMADl+nx3VKOu0J6b2dgl/qlFhPf2dZoIjYXBAHXOPMs5cU68BhbZfCq6pQmEs2knqSK
         ZV8/VKvr2O8AQnQfOG5g0F/cC/9nrbeV43PIl81WsnjtoQ8I+PjzVCYYAs4+k4Bu/4V9
         KKMqdWHtDtAbJ9Q1NcsDUy/yAoUIob/HXtLLqbUU6RRMAkX5QOxrSprvxgI+dRVlvvoW
         3v/MGkeivEhIg3lfdGfKJitIKCIP3Yah6ttGoBZuln5MU9B/L1G4lyL9QNek2s5qDhxk
         ZS+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOSHKw6UNNXHjblYbKtZS3s5qPpnLS1D51UUKkTlqQfbC5NMc65qx7NPeIw3F+d0n+R+4m4xRXPXmu1Fibp++dBfDsVT2Qr9iDH1FM
X-Gm-Message-State: AOJu0YxPbMtGz5mbLlFlaZRY6RYKPsXcd2g0mvM9Y6qseo6/nYee9lro
	YsxcfIagJqaodgpXWkMgD7O87ByOpC+D0gb33MytY6P+EtT+Mr/DLj6JRQ==
X-Google-Smtp-Source: AGHT+IFJssBhPmQQSAePWwpx5PwYFKiBgNSfksm9N1SHI2GdSKJ2rjRpFkyU3G6RIyrOjtZm8PA7WQ==
X-Received: by 2002:a17:906:134b:b0:a6f:5815:f5e2 with SMTP id a640c23a62f3a-a6f60dcb41emr41895766b.4.1718305505006;
        Thu, 13 Jun 2024 12:05:05 -0700 (PDT)
Received: from [192.168.0.103] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdd63sm99012766b.124.2024.06.13.12.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 12:05:04 -0700 (PDT)
Message-ID: <ee01dbd2-fe83-46cf-9ceb-279a06ce9aad@gmail.com>
Date: Thu, 13 Jun 2024 21:05:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] staging: rtl8192e: Cleanup multiple issues
To: Teddy Engel <engel.teddy@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1718291024.git.engel.teddy@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1718291024.git.engel.teddy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 17:16, Teddy Engel wrote:
> Remove some unused constants, macros, and structs.
> Capitalize a constant.
> 
> No specific patch order required.
> 
> Teddy Engel (6):
>    staging: rtl8192e: Remove unused constant IC_VersionCut_E
>    staging: rtl8192e: Remove unused struct phy_ofdm_rx_status_rxsc
>    staging: rtl8192e: Remove unused constant WA_IOT_TH_VAL
>    staging: rtl8192e: Capitalize constant RegC38_TH
>    staging: rtl8192e: Remove unused macro dm_tx_bb_gain_idx_to_amplify
>    staging: rtl8192e: Remove unnecessary pre-declaration of struct
>      net_device
> 
>   drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 8 --------
>   drivers/staging/rtl8192e/rtl8192e/rtl_cam.h    | 1 -
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 4 ++--
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.h     | 6 +-----
>   drivers/staging/rtl8192e/rtl8192e/rtl_pci.h    | 1 -
>   5 files changed, 3 insertions(+), 17 deletions(-)
> 


Hi Teddy,

please combine patch 1 and 3 (Remove unused constant ...) . You can 
change more than one item in a patch. But it has to be of the same kind.

Thanks for your support.

Bye Philipp

