Return-Path: <linux-kernel+bounces-291362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DA3956136
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55046281967
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ADE28685;
	Mon, 19 Aug 2024 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhFuY5LF"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B2C125
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724035481; cv=none; b=WNq7xBGTytPmYTtTeeygdZ4QEkE6XeCZT7ZmNr0n50I7KHWRa4jNqeqyCkAPiIBzoc2mYvpBcChqTLHjMOV5LaaYYegBLJj8d5lAxj0q5sdNxLQN4vij9n1MtmvrA1nft6X+mlDq5sW596o/9fQTArYrdzeNx3iaTCdE3NiB6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724035481; c=relaxed/simple;
	bh=YJrZ0IDQKjCu7V8/ERawPSH4e4b+lsUjQgfgqD4oi88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPsZ98Q6yGQyA3VvEsI+lWWNj6G9gZhN8wFiIrhDhYYnwqAKV4LF09+22PNoLFtI5WAKQ92/InP6k2AS/r+vCf2ON9P54SfTvtESjQjwhctr7ZRy5XT3RaGrDo/GX6WvPGWkWP8lYQK59b/B8Q4uyjbPle44jsNtXcvHUUxSH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhFuY5LF; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d42da3f7so252266685a.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 19:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724035478; x=1724640278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORx5BUxu/+FDFjLsVVE4OExfm8WUeRCdS/jMVKSkjBw=;
        b=FhFuY5LFIcrkwo7OzLomnC6LK0LMvY3WRgnF3NGQ4tv9mNfkhJwBjIei2b9oGa6kNi
         Noc06CsxX2/9fc2R5zNRPVeqC9ECugg3in/mDHljclLWKRjLUPdX/6byhjjGjPx0Mn6q
         SDwFUUHWCCvlcMJqKsPXct8Dbb7P+rgc8SrJ3CsJ2WqjhNNfcHB/0rcsj/mPs+ZpBZFR
         H9H/xuPvI4nNEBfKT0tw4xocOw3o5I9kGdv1SZXc3k7G3RUqr+sQEzR4VGhsHfKnP5k1
         IO+AWHO3/+a/lZv+JpiWg4kiyLDR36oX4qfmtKZ1UgiAKUIf0FySykWHLkSPvZ4AqiQX
         +Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724035478; x=1724640278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORx5BUxu/+FDFjLsVVE4OExfm8WUeRCdS/jMVKSkjBw=;
        b=AYqcxttF//RmFhtTo+Z9FTdeJiF04woAERrD5QsLhjBvCa78sSHhMRdDXieo4VGSvu
         9QdinGl6IJKpvY6y4lQXX5i40vH6HjEUzaE6Y/VL3+jsDXX2VnlOZ9+SqjauHXcMLQbp
         dSzLEyd+0gz+XszcqC9d3YO8ja9t7F6JlOmXwxEcoKqLZNmlgZVZ299v5HNADCxB9N1y
         xH9NHvOAbHFUHpSVVKnuT3llHKBO/11l4NR9UTnrS9mykiYluK0LBIWkUfMoITsTVzVp
         zGIgvuyev3qm4z2ieMD4S0O2vjef9wPMrmDXDn2jzDx3U0nEGsbxc0WKpc1AzEwOGyPl
         1Q0g==
X-Forwarded-Encrypted: i=1; AJvYcCWGLqhEHItJVh/8hqUIyHyue2zxYoiGIQC3QxrsvC4x3yZbJrkToSOJMf5fmKaEkV+LFCnfYBA6hyDCnPo2yNyDhgAKCj9dSWrXQxV6
X-Gm-Message-State: AOJu0YwnLgKeS85f0HX6Gsp7uCjEnD77coy4AViFWvK3WfSP3N7I+NC3
	vpRuV7F4nzhfg3foNJ6wo48r7GXVLu/3BzXl9aWxlkdih0bj19Sv
X-Google-Smtp-Source: AGHT+IFnsuzKan0CgOxva7eNV4HMYIn8YHJwwMlxM4hKZYPvKYrNY9bkIf5uLx5ewyRTF/yByrx+og==
X-Received: by 2002:a05:620a:f11:b0:79d:7442:feb2 with SMTP id af79cd13be357-7a5069c19e7mr1121798185a.55.1724035478195;
        Sun, 18 Aug 2024 19:44:38 -0700 (PDT)
Received: from [172.20.6.203] ([64.20.177.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff06c517sm393732485a.58.2024.08.18.19.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 19:44:37 -0700 (PDT)
Message-ID: <dd9b55c5-701c-426a-9ccc-88f0cc67cca6@gmail.com>
Date: Sun, 18 Aug 2024 22:44:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] mm: collect the number of anon mTHP
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hanchuanhua@oppo.com, ioworker0@gmail.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
 v-songbaohua@oppo.com, ziy@nvidia.com, yuanshuai@oppo.com
References: <20240811224940.39876-1-21cnbao@gmail.com>
 <CAGsJ_4yMu=aaQZEXtcwCdMgrxUuqQ-9P1AiqyyVLfehD_-my9A@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4yMu=aaQZEXtcwCdMgrxUuqQ-9P1AiqyyVLfehD_-my9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/08/2024 08:58, Barry Song wrote:
> Hi Andrew, David, Usama,
> 
> I'm attempting to rebase this series on top of Usama's
> [PATCH v3 0/6] mm: split underutilized THPs[1]
> 
> However, I feel it is impossible and we might be tackling things
> in the wrong order.
> 
> This series should probably come before Usama's one, as the new
> partially_mapped should be ok to handle both nr_split_deferred
> and split_deferred. That said, the new partially_mapped still has
> several unresolved issues blocking my rebase.

Hi,

I have sent a v4 [1] that resolves all outstanding issues/comments raised in v3. It has been running a production workload for 12 hours, showing good performance and 0 crashes. Hopefully it helps to solve the existing merge conflicts between my series, yours and Yu Zhaos.

[1] https://lore.kernel.org/all/20240819023145.2415299-1-usamaarif642@gmail.com/

Thanks

> 
> [1]https://lore.kernel.org/linux-mm/20240813120328.1275952-1-usamaarif642@gmail.com
> 
> What do you think about this?
> 
> Thanks
> Barry

