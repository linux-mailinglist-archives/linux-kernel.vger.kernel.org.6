Return-Path: <linux-kernel+bounces-190019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D918CF86E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 075BFB209F4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B6EBE68;
	Mon, 27 May 2024 04:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmW1tzN2"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748FEC152
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716784598; cv=none; b=tMq0oWKdCTbAmgdINukXZjMlhc5fxTubV5YIattOEoJXzGl7+PUI/VvvGZbbsX0s19mR2Z4HcOiNt03QmYVBYV8SGL9qSuxUEe4VlgfozlcFe8emeEc93UfAamhZ8/e2fPTwftxNLzXdGCzpAAD5ed2904OVVTkkcpBqfcnmitE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716784598; c=relaxed/simple;
	bh=JFCKn4eHAN81Du/zcCpOBwqgtwNTwkK5vphe6gnA6k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTG0j0obe9z79kkfB42wD6mioCjq9IbMlUSD5spo9ftzj+JYeLT899Q1obUNR2yh2/ymIEy6uuWT9SRArlc2wKc1SjSrrAMWEDHaenFvJR26BoVZMjMpHCzLfza7oAzJMFCN5FwyBXvhmThqnb/JcaKDkc5lrdQQ+gam3/N/PKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmW1tzN2; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-529b22aabc1so230412e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 21:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716784594; x=1717389394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/OfPFNzm2s0MgFj+RxiHO7NnoypMwcCoRKdYIhchcI=;
        b=jmW1tzN2qqfFQRtY637BmHiAQbTQ8VPjeRlOswJ6P8B40xK9i/JAz1msavbqYlme5o
         rH6lfUN/eoNYAO18E0Wb6V8PiXL2v/NAQ28AFCA1fVWq3DlhR9fpdv4t1goQyvSiUH5r
         DxWyXLeP3m9i67bp1TRngQx/ycAhD8cfqqoyCAZlTQHYFgOPlG2OLn1kp83Ub3erED8X
         Yhpv0CF+HuO9d4p0pTubj3kq5HcSPAl0kosIViAaXkVQPOnMVfPO2GLlpQnLQZxs2gpz
         FIpAaDhzITtbgczLTUM101Xq3DmvIl4MACOp5zywasKsTbA+b1UHBzjXRP/aUdALLHMN
         g1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716784594; x=1717389394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/OfPFNzm2s0MgFj+RxiHO7NnoypMwcCoRKdYIhchcI=;
        b=D6QaVCnN95rGxUuc9w1YJ6ZLum6UYPg2+KlCNFIguRfBuO+z+Y3jCL7H2NM+i1en02
         zhRtptWJ68G/qF/hGaEhF4baSgHQ8ZH8WFBtujpa0KnWge2ya9/hX+g/GiLbBR3qs+rr
         8rEouo6/P1r/hYiF3+vbgBUsieFproa2AnFpQRmxTCKNUMffslf4GiYMPud1evxluxnQ
         yl4XVVT83E9CL9mU15PUg3vEcPONIY/HS1bqZ1/P+XRQO5q3bNa5xMwuQ11Nu185TwlX
         bFFqP+tivwf3YvimvQVv/T0pOH3OW/4NnkPFsZzwTmGkQwgTvP3kaozQYu1PMYADpoGi
         NAhg==
X-Forwarded-Encrypted: i=1; AJvYcCUtKtxdZR71PkcwUSuqqanCi/244DErooLMT0+BhMnPZUw05HE1jzTZN9QeaKNHvf5yl51GwvtBUoII8gRARd4i6f02k8vT/V2toY9c
X-Gm-Message-State: AOJu0YzdxIs130wwcFxl4xdlJoUESjB7juCmmUIaz5On3eKRwzdKOM6j
	fH3NCZan3old/aBAEiEP+sY/v/7r7hsWLUeTsm2nfI5t4ITXLBgw
X-Google-Smtp-Source: AGHT+IGNNEzeiuNtYUmKybjpiz+SU+s2iEZDKnWWI4132MZxeQu7nL3i0x1AHYAGEe03MyxfQoisIw==
X-Received: by 2002:a19:5e0e:0:b0:522:80d:5dc6 with SMTP id 2adb3069b0e04-52964fac61amr4578196e87.41.1716784594308;
        Sun, 26 May 2024 21:36:34 -0700 (PDT)
Received: from [192.168.0.101] (ip-77-25-34-87.web.vodafone.de. [77.25.34.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c97a029sm450130466b.93.2024.05.26.21.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 21:36:34 -0700 (PDT)
Message-ID: <e25831a9-9913-43da-831b-d37bdc4d9dd3@gmail.com>
Date: Mon, 27 May 2024 06:36:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] staging: rtl8192e: remove dead code
To: Nam Cao <namcao@linutronix.de>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240526111928.14574-1-straube.linux@gmail.com>
 <20240526111928.14574-4-straube.linux@gmail.com>
 <20240526143100.FmVupNWq@linutronix.de>
Content-Language: en-US
From: Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20240526143100.FmVupNWq@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 26.05.24 um 16:31 schrieb Nam Cao:
> On Sun, May 26, 2024 at 01:19:28PM +0200, Michael Straube wrote:
>> Remove two else-if arms that do nothing.
>>
>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>> ---
>>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
>> index 5392d2daf870..4e03eb100175 100644
>> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
>> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
>> @@ -1370,9 +1370,6 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
>>   					tmp_sec_rssi = cur_rf_rssi;
>>   					sec_rssi_index = i;
>>   				}
>> -			} else if ((cur_rf_rssi < tmp_sec_rssi) &&
>> -					(cur_rf_rssi > tmp_min_rssi)) {
>> -				;
>>   			} else if (cur_rf_rssi == tmp_min_rssi) {
>>   				if (tmp_sec_rssi == tmp_min_rssi) {
>>   					tmp_min_rssi = cur_rf_rssi;
>> @@ -1426,9 +1423,6 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
>>   						tmp_cck_sec_pwdb = cur_cck_pwdb;
>>   						cck_rx_ver2_sec_index = i;
>>   					}
>> -				} else if ((cur_cck_pwdb < tmp_cck_sec_pwdb) &&
>> -						(cur_cck_pwdb > tmp_cck_min_pwdb)) {
>> -					;
>>   				} else if (cur_cck_pwdb == tmp_cck_min_pwdb) {
>>   					if (tmp_cck_sec_pwdb == tmp_cck_min_pwdb)
>>   						tmp_cck_min_pwdb = cur_cck_pwdb;
> 
> I would be careful with these changes. These else-if do prevent the
> execution of the other else-if, so the code do not behave the same anymore.
> 
> The only case this patch doesn't change anything functionally is when the
> condition of the removed if-else is mutually exclusive with the conditions
> of the following if-else. Are you sure this is the case?

Ah yes, I had not thought about that. Thanks for pointing out.
I'll have a closer look and resend the series. Either without this patch
or, if it's safe to remove, state it in the commit message.

Thanks,
Michael

