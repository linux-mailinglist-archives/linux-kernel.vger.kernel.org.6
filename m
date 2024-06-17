Return-Path: <linux-kernel+bounces-218204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4544B90BAC4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4A51F2221A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F271990C6;
	Mon, 17 Jun 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IjTY0vEo"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430D18A934
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652088; cv=none; b=Vk39LCqhjwfQaUFZZJvEsz6aAUi00dmpp/v+PlHSHEgpNIuR10HAb1W1LdoISfYL+em69+Wa+1feRr5BWY8QAgPGf7/P2yxqkfCTpoz4PWtPr5b67oq7JyZmaPMzTQejvShdwLLgXgT/LuMW4X4fFUmCng8nWfknjKGFGw/5tWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652088; c=relaxed/simple;
	bh=aRUhmvylMTPbq3pdJ1I005LXAnQQi9aW4RrMkcI2JEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JY7S1Wf9k2woBSPlWh1x/7SikFIJEI2AcRcVs/eyu5ZjqZArJ/y9hKnpLz4hNFpUt+omNu/ArmwcugQMUlQM6n9ucfR4ZXvNsELsAXgXBkHcSNpfiw6w3uL6X3EaMTVSeIvwq3ZnXyvtgoMCDu2i+bm4B4K5+RhDMiyWH424kaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IjTY0vEo; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7eb721a19c9so20533539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718652086; x=1719256886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hnc9BmvHqZ1cO9VRkPww5l6SCS+m+GCA5Xpa62eIsmw=;
        b=IjTY0vEoCC9+fkQn0V2ZT2a+rqLyYkfA75sPJ9in1Y5uViwokEBQF+sAXbDnHZ8h1S
         +NMQYZTQ1xSTx+seoPViXCbfrwNKOzS4IwIF5BQGKGq+sAHebzL9nLkEF3yBpy5WEXYo
         2oSoFoqo1MeSNhUL7ATZ9ZcQQYr6TWebjuOLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718652086; x=1719256886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hnc9BmvHqZ1cO9VRkPww5l6SCS+m+GCA5Xpa62eIsmw=;
        b=gLwC3E52hFIK8083AnhCDvWNh8uBgfYrFKtxGL6mCqvwGjwsIckahfjYtAnTfNjML/
         3Ew58+hODmCxZfYk2LQK01II4KdWqtYrB0SRDkhGUYxUF/+1qv34zUqinLukDqB8daVA
         AFB4eE8n/AYfP7YLcxqBE5FQ5RB5Zb7Xy64QuL5QO5QZ0U6siDyPSsgSkN4Ec4nTiXr4
         psFatLzIRwFfwFVZlqni/dwCCI2dRSvzw808ANzmgALWnecrRx8U9PzU9TxJre+Haycb
         etg6ZfNr3EnlRkJFxmSFtJTLcBxnsf5CzQb9A2IC3yHPY2QkBEAbyeCV1oVwBsQdOuvx
         qVnA==
X-Forwarded-Encrypted: i=1; AJvYcCWu8TLaosRuBmR68VRHoiY2EWS4OQdKwYlb6ScIRIo4EAg+/lPI1HhrKt942QaOel/JaTe6G+5vilRn/6mwmHfMXqx0KRPWifGNjVz6
X-Gm-Message-State: AOJu0Yx9ruMNg8HKpB32eM4GJS0Y8xM4NHlYkmdkRm3gy/r17NiOXDi1
	KtbOlQftw74UjX7H54PPLPTd7bCZ8JVkEFfeUZXyYhwyssLCqn/3OeiL+wWsKMA=
X-Google-Smtp-Source: AGHT+IEJNYqO2H4hy+J+bElCMNOnzT6uvzuzSkCtBsp6G3WPl5E0ldk+xvk3pq7azhpQfHCk+09VOQ==
X-Received: by 2002:a5d:83c3:0:b0:7eb:69ec:43f2 with SMTP id ca18e2360f4ac-7ebeb524819mr1040417839f.1.1718652086007;
        Mon, 17 Jun 2024 12:21:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9569169bfsm2846018173.45.2024.06.17.12.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 12:21:25 -0700 (PDT)
Message-ID: <46645216-dcb7-45d6-83c5-fdd9451362ff@linuxfoundation.org>
Date: Mon, 17 Jun 2024 13:21:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patch in the kunit-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Brendan Higgins <brendanhiggins@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240611152225.7264e9df@canb.auug.org.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240611152225.7264e9df@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 6/10/24 23:22, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the mm tree as a different commit (but
> the same patch):
> 
>    425ae3ab5a1f ("list: test: add the missing MODULE_DESCRIPTION() macro")
> > This is commit
> 
>    245e5db4adaf ("lib/list_test: add the missing MODULE_DESCRIPTION() macro")
> 
> in the mm-nonmm-unstable branch of the mm tree.
> 

Can you drop the patch from mm tree? It will help avoid merge conflicts
in case there are other KUnit patches that depend on this end up in
kunit-next.

thanks,
-- Shuah

