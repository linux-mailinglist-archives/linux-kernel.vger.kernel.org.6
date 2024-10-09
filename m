Return-Path: <linux-kernel+bounces-357473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374E59971A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688231C22C44
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482F1E1044;
	Wed,  9 Oct 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YJCkUtZ1"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A51CEEA0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491329; cv=none; b=jaCVw+ah9AnlYN6WSXXehP/UUnqQG1N++ziVqqvjb0VVulI2MYLiNf49L4HV0PwHj7syqagO1ZM9dlhIPftjqZ+VWAQxTrqE3hcFTAakSdSghypxEv9ly+o2Y1cfjVd9USKgHGXI7AV9GcrSHkP3Ms/aZ4Ajh3gG7NoEQmyMdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491329; c=relaxed/simple;
	bh=HytH0a+TvKdghziQH301cLAcvE7eKXxs5D5r18dSmCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ba69QlKbqYcV4YBSfd7UHKFac2XPLkeEWxC4278tbSOlN5Tf+AWjXP7Cp7+9UemC4TqtwqR1iS24AGpG8IohTCDDolzvndOj8ObIY1ATLo+l7GvNCoDm4hd6+EqvhHlmR9k6ycVIYW9zgVSyBh+WpJWgUNaO8/0cnqsAf704cjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YJCkUtZ1; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-835453714ecso20083539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728491327; x=1729096127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNftbaEiQh9mE7mlmkhwkRTz4TXqRx66rcdG98vrs5o=;
        b=YJCkUtZ1A2rIiK6UoSOQVj/HibNUUwpky9YwYuAJFUqQsI32SEm46tbsCfEEmq42Zg
         K519jHAUMcGhJt4OBziL02o7kvARpth1a4AlRd3a6sGTHO+4wQBEtvn94JXtF/x4+lOR
         U8o5gXDTcXaJvSuviLNrzd8eV6jcOXnj5NRhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728491327; x=1729096127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNftbaEiQh9mE7mlmkhwkRTz4TXqRx66rcdG98vrs5o=;
        b=YjMalWAqgWhw1KoRvr6bYNv+2YDiYnWzfZ87H5q9gKbbIRarZKWybix2gnjweC3+lJ
         uZI+TMU0XbOX8q85xLHTyWeibcMkMvtpEEgsxO3T5+YQZ5hjMvawHesp8VD5mXcknnBy
         YjC8nkJwYkNks6ZAXr3jQxSQl85J15Rk5XAG9gbq2FRvNSVanitljTiD4DokW0GtTkqK
         F68BfrwyPyYxa8LxfDFCQXEBsS0KjG1GmJKZDsRSoyJqynWHZ23sXOYbK02+efVgKTNI
         4sUnVaHXtFH9YpHW9jcqGAaeEBTkEmJruJ/3raDb+nAxEeroSnCT2WxG5NAu47O2Ftqe
         nICQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIGym6jlFKomZwbo9B242RFOuhcPcCu3TI/1AeWq6dn622ITIE7y8ihgTPRHFjfrne/w5BTwLcCkwhnKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQcwzXaxWNWqFV0VqGsqf//+JZT1pnz4xBQZkkmp8oZoPRNzP
	8aT8xIJavEfL3xJ5N9zuhSeNM192TRFFE+yWrlxu4Ah2zkcakZin/j2AXHRaJwk=
X-Google-Smtp-Source: AGHT+IF4qaTbAUXvCWOH6J2ilLA5tAude2CmsDNaCsJCv5yRbmKh0OIK/2bHki8dSyRC/sQA3W8P8w==
X-Received: by 2002:a05:6602:29d1:b0:835:2ef4:3aa4 with SMTP id ca18e2360f4ac-8353d4ad3b6mr351227739f.8.1728491326617;
        Wed, 09 Oct 2024 09:28:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6ebf0da0sm2079336173.110.2024.10.09.09.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 09:28:46 -0700 (PDT)
Message-ID: <b005d39f-2b75-4a26-a78c-5cd8f7076399@linuxfoundation.org>
Date: Wed, 9 Oct 2024 10:28:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the kunit-next tree with the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Brendan Higgins <brendanhiggins@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, David Gow <davidgow@google.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241009162719.0adaea37@canb.auug.org.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241009162719.0adaea37@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 23:27, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kunit-next tree got a conflict in:
> 
>    lib/Kconfig.debug
> 
> between commit:
> 
>    0f2016a962f0 ("lib/Kconfig.debug: move int_pow test option to runtime testing section")
> 
> from the mm-nonmm-unstable branch of the mm tree and commit:
> 
>    f099bda563dd ("lib: math: Move kunit tests into tests/ subdir")
> 
> from the kunit-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Andrew,
Another one related to move from lib/ lib/tests/

If you would like to take these patches - it is perfectly
fine with me. If not I can handle these.

Adding David as well for feedback on this

thanks,
-- Shuah

