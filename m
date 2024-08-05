Return-Path: <linux-kernel+bounces-274371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80532947772
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C724B21D2E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312A714EC46;
	Mon,  5 Aug 2024 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVtSiWzN"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA1D13D628
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722847142; cv=none; b=UYO0NHu/PbD13qYNu1YOgDr8vxniug8jox1nEqNQX5cjs7CjdAvqECibb/s+lLwekr5Y9y3SEHNw9I6R+N8Y0WI2fUbtl+VhP4wRlpyqeOLR+obt3upJGTS9haLXyNZebqSqTGlb1sQM226O7QxCu7S/hWnT758ikLC/a1xCeNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722847142; c=relaxed/simple;
	bh=wOhxfz1JNmSt/eZ/1sbWUyu5lgXOjSHbRL//jMuHCBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6svfQxNAKU/l/sCAWpdF/gzV9TeYX+KcFGZy5aLJtUSZUp33+Xq6Y/glJzL9LDsm9sSD53bGhF2P/fxhmRFeaYmusWFj8KZ4IxEqsbw92uzuKIdVjGAmiKqtRsu35fZtg3sHCWEyJ9yHPW7oc7fJ1oGGVe+F0UobLUy3OOsX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVtSiWzN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70eb73a9f14so7707183b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722847140; x=1723451940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0Y2ytu0XLQLfIUYDV++0ifJhskUaeinJE9VBipEVKc=;
        b=IVtSiWzNU+NuYbPjBlDgNrQ1JKWZbt3mdSQZu/gOuHY2p5TIHYmtbJ5RKEj89fw6A2
         OH7paJcN9Zu9Czppt+dtJ2x6a24jprGWMbQXxfmlHNtZnp9cERVz4VyboTv6VOAeyEfl
         55daQ0fugFlEu9vCt7jkOpkPGwSRVJ0G8G+1U8MPZDFe420xO3lpWAWcSp33wvnqDZLZ
         ZKaI7aUwyH1fMyY4/sbQd0ZSyJ88lwtbOnCot9IRdMudTZVn1py71nFypZGyIpELCY8D
         w23SK5f6Io+R2wOZRJS9yJzjHhlnBN3tZw0wn9aFRRLkeSMlJXQfGj+OcsN6h0UDymK+
         5zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722847140; x=1723451940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0Y2ytu0XLQLfIUYDV++0ifJhskUaeinJE9VBipEVKc=;
        b=iu98KCNwORYFmwVYsCugHvtS8XwrT4yFakSDytD3M5e82dyC4zFqUMbxUlZtPPy7X+
         AbQDSiqDCmYVki+QYVbH1D2TCOY406o0S2py795vuVDsMd3mu/JfcSXwtaEu2Bb5HP9E
         3t0LnvfH5217fBjx8e10y5wtMeqOk/ORKCZHM0ZR1p9QDRCyVi41rkKenssg0m0aZ4ek
         3DSv4GSEahFLvFXVT9lW2lNNSgO8JPUMxxdBkxD/EBXckp3fhyaEBvE0yfYsLQjvARuL
         IRMEzMclTYAXTHe0cOQfb++zEhKQ1l/lqLZY8T4ePTHf6CF4C4doKxOuAeI5CfNWlu0n
         k+8g==
X-Forwarded-Encrypted: i=1; AJvYcCXoqZymAUZPuRIpjN6KBSjGu2+XUG2dZSafyi+h4pMOBoRVqBGUhPJTTY7BKeBAS72ghMZub295t7BonpEy8bNviIuCTkjN2JYkBGBR
X-Gm-Message-State: AOJu0YzFqxqoOdkr83ZnJapGYPLBtZK80P+Sc+Q0Sok3RtVObQhqUOvY
	YakQkACq+1wcvtF96HwQStsN0/29DCxtOSwKoqFO0rq6EYK6uK39
X-Google-Smtp-Source: AGHT+IGdZ3Yz9ZyYhRZst19AskkCxAwrghUJxWqpDQH4Z3L1XD7Aef8jmWtFlq05YhJi+1ZduMbjeQ==
X-Received: by 2002:a05:6a20:7490:b0:1c4:88ce:c996 with SMTP id adf61e73a8af0-1c6996b933amr17598363637.46.1722847140518;
        Mon, 05 Aug 2024 01:39:00 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed12b59sm5119369b3a.177.2024.08.05.01.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 01:39:00 -0700 (PDT)
Message-ID: <65c81ca6-f4a9-4b2f-8e58-58bbf59c5793@gmail.com>
Date: Mon, 5 Aug 2024 16:38:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/22] mm/zsmalloc: fix build warning from lkp testing
To: Vishal Moola <vishal.moola@gmail.com>, alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 willy@infradead.org, senozhatsky@chromium.org, david@redhat.com,
 42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com,
 kernel test robot <lkp@intel.com>
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-22-alexs@kernel.org>
 <66ad2fd3.a70a0220.226e03.5a9d@mx.google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <66ad2fd3.a70a0220.226e03.5a9d@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/3/24 3:13 AM, Vishal Moola wrote:
> On Mon, Jul 29, 2024 at 07:25:33PM +0800, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
>>
>> LKP reported the following warning w/o CONFIG_DEBUG_VM:
>> 	mm/zsmalloc.c:471:12: warning: function 'is_first_zpdesc' is not
>> 	needed and will not be emitted [-Wunneeded-internal-declaration]
>> To remove this warning, better to incline the function is_first_zpdesc
> 
> In future iterations of the series, just fold this into the patch its
> fixing. It makes reviewing easier.
> 

Yes, thanks for comments!

