Return-Path: <linux-kernel+bounces-337918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1BA98510B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF5E1C23450
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136F81494A9;
	Wed, 25 Sep 2024 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MtAgPLJ/"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B3A3770C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727232266; cv=none; b=tsYixOj9izt9/5sI3z5Vd23O+RGV9U3ZM7wqbwNoamgeg7m9zWI702B8Aei/lZG366t9rgnHjojPelDkvK4NaUphiah4asqjgoTfVBR4LClUWke9dWPk47WjtBo2IZgMzTFnkz5lPOkdKCvmDhexxmVtLJEHf77II3x5BMD64E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727232266; c=relaxed/simple;
	bh=n4vzVMJk/wnTZoLjPI6/94113lyUB4lEeWRcZRd99M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BaP678S9P5lIGmIVjlnQMBpM52CD8vaoTtYPyXdKR3oYx7ldv8JVfVYpkU0XDnJLgmZpcwAf5F4CKkdItxMg5W/9a/WIc1jWCH9qI6kqkcMKgN2PewgwH06su/ylzrDXhPiVN6SqA9mtKU/av4uiTndp8yf5NBcgxr9hgyUfqXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MtAgPLJ/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-206b9455460so3661995ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727232264; x=1727837064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5u9fJUNtEJazJzPyTQOtG1FO6Z7cS1MgX+7pZ8RK+ts=;
        b=MtAgPLJ/8BNj+j2n9NpzgVXS/nyxj2z1pFBVCFeRJUWGOoZBxWjaO66AKIce/xlX3k
         L2jF2mNAmIvH9XI9h6/Djskf461Zxa+me8ksgNS5cb0Kgd16NsljUIen50E+ReCWhtUK
         YOaR9rZzKUHbEOKCRbXA9NIBQcmO1vomUxxNXqPBTzYocYdWrQhndHZsPX7S9fiYIYja
         shjcrrC56nlpOT/7hk0hbtKB10SUcxUizR3rpDrmHpSX6ua5IojtY6K3iNW8jd5y5YkW
         7B+Jtr1SpOVS/HcDI+tUZyPNP2QrHBSb3JiXqIgzaW+5mGnhDek9V9IGhOgmMvOV/o3G
         DBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727232264; x=1727837064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5u9fJUNtEJazJzPyTQOtG1FO6Z7cS1MgX+7pZ8RK+ts=;
        b=tjrCeTFZm9cGiGbk2WZ0Ll6pUZoB72TLCrd225BPRcKRyYYraJNgj2Np4IILkxBMYq
         HWJ5GVUlTrSV/EwK0UUSOJFIBkJyR1leQaDGEU/9+swUtfHhc7lOMQ3dLNriGVRJaMMR
         v60lFnAB//qwNlEw3jh5zLWPOy/v82TUkyqqvlRBMqqZeXY4r2t2HeyyBCAruChVXEIN
         PiVTyWwOeyPbjWMK87qoO1s/Nft5am26wiIcM1l79WWAaCWc7AdnhwKG6SFsR3B2kzD8
         5tNubz2L/t5mvZS+8rXSJpPeeAHwiKjn2FXcl4yVjv0dXjFH5lveHS+i/ffTMl5hBT8a
         tbsg==
X-Forwarded-Encrypted: i=1; AJvYcCUPkGF+CzRalvwJDjY02S0mTpR0cSs5MO6jX60luhG58xq1KAFUgW4FjLRvPCAULt4w01fGI2Av0VE6okY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDp9LOr4iF2MGRjLxBWa32o+LEiv+WGZrqF8OjVU6Vs4bRzuk4
	qNQ+/HEdKWBxDI5rWhTMoBhofxei6qm5DNdGxpHSbPMIfUkfvAS7kwOFhCnwoA==
X-Google-Smtp-Source: AGHT+IFOu3sATw4O+ghyS7x5azvPQ4AJoo6YIcBuz/3H73r9HL0ro3DSjKBapUQ9ynom5wab2GLyuQ==
X-Received: by 2002:a17:902:f644:b0:207:3a4c:8c6f with SMTP id d9443c01a7336-20afc436639mr16594225ad.29.1727232264093;
        Tue, 24 Sep 2024 19:44:24 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:8:32ad:6c37:2d1:220a? ([2a00:79e0:2e14:8:32ad:6c37:2d1:220a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1859c00sm15796035ad.286.2024.09.24.19.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 19:44:23 -0700 (PDT)
Message-ID: <d72cc89a-7f73-4294-927e-48e647e37310@google.com>
Date: Tue, 24 Sep 2024 19:44:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 2/2] usb: typec: tcpm: Add support for parsing time dt
 properties
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, dmitry.baryshkov@linaro.org,
 badhri@google.com, kyletso@google.com, rdbabiera@google.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240923224059.3674414-1-amitsd@google.com>
 <20240923224059.3674414-3-amitsd@google.com>
 <ZvK2slBHR8PhzaMt@kuha.fi.intel.com>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <ZvK2slBHR8PhzaMt@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Heikki,

On 9/24/24 5:55 AM, Heikki Krogerus wrote:
> Hi,
>
>> @@ -7611,10 +7650,13 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>>   	err = tcpm_fw_get_caps(port, tcpc->fwnode);
>>   	if (err < 0)
>>   		goto out_destroy_wq;
>> +
>
> This extra newline is not relevant or necessary. Otherwise this LGTM:

Thanks for reviewing! Please let me know if I should upload a new set or 
this is alright at this time?

--

Amit

>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
>>   	err = tcpm_fw_get_snk_vdos(port, tcpc->fwnode);
>>   	if (err < 0)
>>   		goto out_destroy_wq;
>>   
>> +	tcpm_fw_get_timings(port, tcpc->fwnode);
>> +
>>   	port->try_role = port->typec_caps.prefer_role;
>>   
>>   	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */
> thanks,
>

