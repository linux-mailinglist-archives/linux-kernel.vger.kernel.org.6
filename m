Return-Path: <linux-kernel+bounces-339466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D725B986591
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D69C1F21E03
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6770157880;
	Wed, 25 Sep 2024 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DEp+GMnE"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE3282FD
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285183; cv=none; b=gxLLvB07DqBkPLYR/ChC6lcuP/5ygwUuUvenXe+BbXep8BdTAIqjfAOcmsLNxbgeIO9ayoVBKWfyH+ebC+npRPJwRHEdJlaw+KI4PpvHSLWqZhNrkch0NdrW5bFvULALffN323AcXfJB/sHYKzA5O5Mkr8rEn19Ezfnrot/8Oh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285183; c=relaxed/simple;
	bh=S/MhFgcRKcARF4C/WkE2tB9txWJI/GeERMG8nD/tZck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XO9sfiKK/+TunMzgybu8zlTL7bfDQqOTNvuFl14gaDPEmdR6IuyiY+0QjBH5JDMU9Z3CrdLBSU2+bxYDoieget/OK3mknnRs+y6CT6r4On2l9xsOv3r/RPglw3u2zRjegC79wYGc7svIa972LuKjpAzAIUWDSKvdh3pSXepJcnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DEp+GMnE; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82aab679b7bso3275239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727285181; x=1727889981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nsw+zRp/Ze7eW9+6epMJhd53fkKQRkg9ETNvRz5Ml1s=;
        b=DEp+GMnEaQdkwIxuRnR/Q4BUn+p0hZvjX3hJYuW7J2OaX0HuYCylpUGmbDDkH76DeO
         lDDKTb/cVv/+A0wttuGZI2VuytfETI6dYFA2FEzgEF+bqFaCUtvCQ1p+jnj+BvF30zKz
         4N94GA9MNoH63l871adHrqMDocKdPGecr+0Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285181; x=1727889981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsw+zRp/Ze7eW9+6epMJhd53fkKQRkg9ETNvRz5Ml1s=;
        b=XnT8lR+Y2tLYlPDKmHoElyUtc6D/VGO88tyu84GFNZrJd2f5fKu6ckSSV/L7dmP9rv
         +/3Cg+yCOP/tyrho/xSLkO0l9epBWH/Stxb2hQX7at2uDMf7XMQEJKPwLXxDJSB9iyFp
         ja0yT7LXmRMtRmpp0HifHkAF4Rzw7Ofo+7JDk+PIF5fEAh9dF5R4xe5X+ocGbW9gDLSl
         MySM89OLzqRQMxKld1o78TIduqQGo3ZEQqU8icg8M8hZXuwWPGQJU9h7xV+YG3QKxc7G
         kc7lh6c9ccEFlqHAjcvFppEZxvY9bhY+H052sKdUUO1cvfNVf98vTU7DuFqs21rLPscr
         bBZA==
X-Forwarded-Encrypted: i=1; AJvYcCU79eQlWDiLIUqGdcuu/rKy51eN9EKbRkasgFWSI+++YYZQ7mD9RnU8f/MoNYhHJOU2LZNrhP57VNK3FPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoOden1eA8iY3qcDrVsAIkyj0BBAG27diBItWLYouqiEPAZH1N
	1L/BapRXwrRJdp5RbdAdCcuYsXGP3C795GXJC4BUSbvDUKmNryLldkZ32gsUCmw=
X-Google-Smtp-Source: AGHT+IGmRIDkJ5EYcMz5zDv+p0A3MLFtNlRBHwMyJenq92Hsd1XC41WvVZMfEbFtv+gq53kcE8kOfQ==
X-Received: by 2002:a05:6602:2c01:b0:82a:7181:200f with SMTP id ca18e2360f4ac-83247d26137mr450776739f.9.1727285181091;
        Wed, 25 Sep 2024 10:26:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f1bcd9asm1181347173.95.2024.09.25.10.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 10:26:20 -0700 (PDT)
Message-ID: <3f0d12ba-0e52-41f9-9cbd-34bc1225121e@linuxfoundation.org>
Date: Wed, 25 Sep 2024 11:26:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Makefile: create OUTPUT dir
To: Jakub Kicinski <kuba@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
Cc: shuah@kernel.org, willemb@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240916075655.4117151-1-anders.roxell@linaro.org>
 <952aeec9-c21f-46ce-bf68-e6ffce51630c@linuxfoundation.org>
 <20240920123827.715ff109@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240920123827.715ff109@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/24 04:38, Jakub Kicinski wrote:
> On Thu, 19 Sep 2024 09:51:47 -0600 Shuah Khan wrote:
>>> @@ -261,6 +261,7 @@ ifdef INSTALL_PATH
>>>    	@ret=1;	\
>>>    	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
>>>    		BUILD_TARGET=$$BUILD/$$TARGET;	\
>>> +		mkdir -p $$BUILD_TARGET;	\
>>>    		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
>>>    				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
>>>    				SRC_PATH=$(shell readlink -e $$(pwd)) \
>>
>> Doesn't the "all" target mkdir work for this case? Why do we need another mkdir here?
> 
> I was wondering about that, too. Looks like the code from the all
> target is copy/pasted in the install target except the mkdir line.
> Best fix would be to make the dependency work, I don't understand
> why it doesn't already, tho.

I think this could be the issue:

net main Makefile doesn't have handling for subdirs. It looks
like the way this is handled is by adding an entry to the main
Makefile:

TARGETS += net/af_unix
TARGETS += net/forwarding
TARGETS += net/hsr
TARGETS += net/mptcp
TARGETS += net/openvswitch
TARGETS += net/tcp_ao
TARGETS += net/netfilter

So the solution would be similar adding net/lib to the main
Makefile.

Anders, can you try the above and see if it works.

Another issue - lib/Makefile
TEST_GEN_FILES += csum needs to be TEST_GEN_FILES = csum

thanks,
-- Shuah


