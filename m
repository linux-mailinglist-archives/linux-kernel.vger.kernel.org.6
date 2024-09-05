Return-Path: <linux-kernel+bounces-317450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF7596DE72
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F811F22DB8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531F149630;
	Thu,  5 Sep 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cXVEWqqK"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50710D529
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550445; cv=none; b=PheN/q9UscRsRPuayVTUGJJnal5Wcgq1VOku4DbWfXs0bv/T40nyL9TGWMuVWok0IzypgIK6Fw4aDieAnFhIDvFCu2/gwccUvMSkHu2uRF1QhYDTIF3MdiYCU/5z74Z94p1ArmpOwZTshzCbVMMh6teFz4Yovj/KINSkfdHQojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550445; c=relaxed/simple;
	bh=IeMQc/NA07QTxAhW9piOaNj0VRRHGkBl0JFRR9yZ550=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFvIgIWEMPvvJWPSmQ8w/ciqalqE87dsnQC9rUwtKDmwQVv2J7nlKs/Oe876dSrlkM/l1e6VQURqmwU8cPNMJ2Cu4VggqeSFEbbu1au6fJRRUV97VId5MdTlg7dTYsd3/Jo4xyIFwIkqzGSKeLasg6wvMUUrQZ6Yku3/aDLVx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cXVEWqqK; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-824ee14f7bfso34128439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725550443; x=1726155243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mu6Syr7UylfMAePsBTQAk/L33nZeZwpeBC+wH1wO5RQ=;
        b=cXVEWqqKFK6GgEonv0qeMP4QtFvDozjdI6YyrPO279Xk/QlzJZTMEgA37ICO+xVYTg
         O5qdrhusK5wMdwUWzoZ1CSdZd7+ukRLq5aE1JF628hxJ74OfDL4GJKckEgXpxVFFnQI3
         PnSZ4nW6P4bLBKrtnfISIs7CH50ofxrPfoXzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725550443; x=1726155243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mu6Syr7UylfMAePsBTQAk/L33nZeZwpeBC+wH1wO5RQ=;
        b=ZPIwD5k0pHKjGQnHoXqbUNqX4NCCYutEgQ9RGa1PIUtD6tj7VBPm/b/GCeCgSn72fA
         dYs09NBPHOZffGq+BWKAXcerGsYtRgnpfj2VORwUWmRISAFWxusefTLEMTKhlp6LyrZu
         6RWY9Re1BFqzcr6nBoHr64S7AM8yQQoWr5SokuKCbelS6nby3pRpD9nRVvgehnrSpNK3
         Kmn7hQoP5AC92FZ6+uF29mHXSKeqR8z/BiVbZHIMKEUHCzK669oG80E1AUII0swpcyLj
         l9oRcT8EfdjB2IuRgxCyvpHzsMjE9K+M9MwO/Tta4cf3HSZW8pFlVTjp9Y8EPt00fASZ
         diQg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Djw/rG0OHE0R6jq+RqKS9cGXw5AxiudLAQViCCoVlNLqru5tt0SeQPOXtQV0jYmzmK0Axmgv77mhkkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG4jv1Goz03fwns5wsnOlSeKnEUfpcTb78KnOzpWwmwpNlQUOA
	qn1zQzN+h5RU7FVzHw0BZotI7p8yfZllkln5xQ1n5aVI0T2YnnhBCFIyMwvFIKg=
X-Google-Smtp-Source: AGHT+IHdU6ZWq41PoVk+gXjhsLpsY2M1qJRNcZ2YjAJsyPVO66d8zMCFxVglKvdHFsVR/9MfrAk1Dg==
X-Received: by 2002:a05:6602:29ca:b0:827:87c4:363a with SMTP id ca18e2360f4ac-82a11027161mr3311395839f.7.1725550443227;
        Thu, 05 Sep 2024 08:34:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2ead1fbsm3675024173.143.2024.09.05.08.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 08:34:02 -0700 (PDT)
Message-ID: <c141b34b-78fe-48a7-b963-a784ceffba70@linuxfoundation.org>
Date: Thu, 5 Sep 2024 09:34:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the kunit-fixes tree
To: David Gow <davidgow@google.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Brendan Higgins <brendanhiggins@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240827160631.67e121ed@canb.auug.org.au>
 <0a197b29-f0f4-429e-82c0-f54469f31b12@linuxfoundation.org>
 <CABVgOSndJLkmeDDXhSSdGt3vaJ+_2p+RRhAK9gH8TP_zv9=gyQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSndJLkmeDDXhSSdGt3vaJ+_2p+RRhAK9gH8TP_zv9=gyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 00:06, David Gow wrote:
> Hi all,
> 
> Sorry for the delay: I've been away.
> 
> Fix should be here:
> https://lore.kernel.org/linux-kselftest/20240905024757.3600609-1-davidgow@google.com/T/#u
> 
> Thanks,
> -- David
> 

Thank you David. As mentioned on the patch thread, I will
apply it as soon as the pr clears for the critical fix:

f2c6dbd22017 ("kunit: Device wrappers should also manage driver name")

I will get this in for Linux 6.12-rc1.

thanks,
-- Shuah

