Return-Path: <linux-kernel+bounces-174753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9268C1487
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790C7282225
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9C1770FC;
	Thu,  9 May 2024 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="K1Nw+mtv"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E576EB62
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278198; cv=none; b=dyg9kkWFT2aQ/i+kUf0iNG6++rjOHN2uM9iFbgJhSrof3n9Sx6XP/4MNfZccdSSMZxdLz5Y3FhemdksSCqChchnqK7NpJJ3HIHtza63KCDbD0s4xjXxjc1N+qeeDTOnLTqt4OqcWSCL7FG7hGT0Se77bg7m/q3WylcbKHiSmyTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278198; c=relaxed/simple;
	bh=mVAlrsqmGe3vk35le2tnYkIvTR7PVyC+QldNcM5L7OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEjsvrQ7Sw8q1EKaBqsn3HUudvdpH6UECShSRe1D1nccYMi32ygJQTD7b09L0IyWiGmnSsyGgw/10w+x9bzIYQ1wRmLID94gdLrhFfr/IW3+vplmag90CrMpObY+BpFLzNW7vInOFWWfPzaEDIA9X4EJvAGGzFYBMbmPGtizMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=K1Nw+mtv; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f467fb2e66so1094591b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1715278196; x=1715882996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cAFQ1pXnscaNYourVZhjgkuHX4JeH6ZyCE9xtGGuVew=;
        b=K1Nw+mtvhTt9hUg4iHOEr7RFWGifly79q7A3HkYygXKeVu9k3fE8YAi/hCiE9PmveY
         KZ0giZ77yVXLyqw7+wK9cgXxtcRuzA4I6pyns6cl71hpxPYpPfcPbw4jcK3Ez0LcOYSg
         1+3wdmCdyjFHrrLXJlhyn6dyJ9fvccSH2BXHYe+j+cXyId9QInTn3euYLK8yOKt1JDho
         Le7Xkxgk0BT7pO7/zukIAJscipk/ARc2Vnkh4WIR6eNjhqOEd/awQCwYehoZJfWrcJGa
         /YHLgrzRSjuT3Wp6lS11XpdSmd66jiPi8lWIiG4+HjRku5smupmP3XEd3jy9Zfnk1Hbg
         QqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715278196; x=1715882996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAFQ1pXnscaNYourVZhjgkuHX4JeH6ZyCE9xtGGuVew=;
        b=Yj4NTRFokh/KUzpl2aa62Me2L8gXICkOYX/2VEiztiXjPHrLNxIxPFZk6WRaKWUUfE
         GqFzx2k6CI4GP4j4gkcXQjwuvzLOksei5IkAyad8d7V2T53rYYDVHmgPt9x0tFQkCHA3
         y7pDIEDe3bm5m+Qb54sDEs4TQJd74XVXM+wj41uXZw6XsvQXa3e9KSJcV9zfp5JpYhzA
         iEZJuhCEG6bp5vRhNCvgdHHp0e8ZS2716Q+ozO0k9VArszZcPykZEGkDKbFFDb/4olcq
         rca0KtxBf9g58zVpEf39MM09afjRIYIZwK5QmKTgOYJ2inSfbfe3/E7AbdcG8g8jfE/N
         vrAw==
X-Forwarded-Encrypted: i=1; AJvYcCX1WcuUgMMG4Yin4qi4aC5zuLip6e75aXVUALB/nwHBgbhWdrFtPpH5OFmvgAaL0Qy4H5jkJizj9SqzO7RwRHR0JYEP2AofANlvBVIJ
X-Gm-Message-State: AOJu0YwF2mCQqaP0X4d5KZVtmZaxH7PLKg3h416EDyBy6JEDSsRjhwkU
	0t/8Bm/5dQLYtBCA8uHKSUnwwrjPq3QnPibTvBIrVzjPHKpPR/C3yy7uXiszr+c=
X-Google-Smtp-Source: AGHT+IFxmYJaEZMycBwCktGS2JRoQMzjPs2ACXgv7iXVhtolq9hdV25hRc+e4jTDZ9ebNKJLLNmWig==
X-Received: by 2002:a05:6a20:565b:b0:1af:d44c:cfc3 with SMTP id adf61e73a8af0-1afde104374mr528069637.32.1715278196152;
        Thu, 09 May 2024 11:09:56 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::5:c55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634024a3eb4sm1651671a12.0.2024.05.09.11.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 11:09:55 -0700 (PDT)
Message-ID: <9aafe0de-7e46-4255-915e-2cf2969377d0@davidwei.uk>
Date: Thu, 9 May 2024 11:09:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH 1/2] tcp: fix get_tcp4_sock() output error
 info
Content-Language: en-GB
To: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
 Yuan Fang <yf768672249@gmail.com>, "edumazet@google.com"
 <edumazet@google.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240509044323.247606-1-yf768672249@gmail.com>
 <DS0PR10MB6056248B2DFFC393E31B4A1B8FE62@DS0PR10MB6056.namprd10.prod.outlook.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <DS0PR10MB6056248B2DFFC393E31B4A1B8FE62@DS0PR10MB6056.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-09 10:29, Mohith Kumar Thummaluru wrote:
> Good catch! Thanks for this fix. 

If this is a fix, can you please add a Fixes tag? And in general some
surrounding context in a cover letter? Thanks.

> 
> LGTM.
> 
> Reviewed-by : Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>
> Tested-by: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>
> 
> Regards,
> Mohith
> 

