Return-Path: <linux-kernel+bounces-274361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7253694774D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0371F21B75
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0AB14D433;
	Mon,  5 Aug 2024 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGHNPGlQ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB2149C45
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846508; cv=none; b=dZnvR6XkxgtlN/SzH7+j9czQFkQbZvM7vOiUdMKwMpsOdhFrJ0tWEU85f3O2ZB002WIghACAZDGGCOM4Gfdz+x+xfQn8rm7TQz3O2RJittdsyE5cI9lPNIUfsvIU6mdIIuXBz3FI0tAnQ5n+JEbwMMMFcINwkhgDo0DVMv6N/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846508; c=relaxed/simple;
	bh=okeFp1aV2YD332YyjDfh/IWOpJfTDYaWr8x4In0Ywmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lt8EEtGwyN6h31lztObujZ7aGK+J7QkX2oGAXMqcH1cK95Uybb/+0pi/VEww12NldPRzobXHj1hVwO+vZM5P6BY76FWuoH6N0pSjchU1egB9O+bdph1Ba1MgsS37deWRXIop9MoPyWwRI5d96izZ/hyzINvsUGfuC7SVFBOfpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGHNPGlQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7107b16be12so1431013b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722846507; x=1723451307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=838har4Y5THs7pjI2cfOULSCm/8TjV2cXUtWhXCGyYA=;
        b=BGHNPGlQbDEJix6aCxDqTWZTctLOeojPFP1WVX/rAONgu7/61Rm9BvNCG0tUL9hSxE
         V2ik4BM7xJwWVsrpxgGbWCMTyxSryssZDhZduV5N+K42zPhIDz0Q8aXzNHlQS1eY09Ft
         UOl2J481db2eyPkcvwpA63SprBn5uQ1YXp03GmgzTqnpLLwBHj6S/GwN7DCmf7g8m6ab
         xvCtFqdhMcJt319zU+snhUQrpO2qrIJdTRnLcTdreyXRvnknVWGRGcUYHBYCUDoVUsV9
         7xndoqE3tvmBbTHysQG/zwQOXmkaZBqYzAVX6P93ZS+7LD78CG67G7l14wgiMmvIpZnc
         J/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722846507; x=1723451307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=838har4Y5THs7pjI2cfOULSCm/8TjV2cXUtWhXCGyYA=;
        b=GHgszujZbz4X/snEfQXTD4l/Z91nSbLJEC90jqfhvWE2DvnNo+nDZLEtr2AY0fQhb3
         VWMMB6qmhXq0exC66CemByViCVk62Q4MzfnGWI1GbTiBdeu/bJYKxRgCgpqUBzQa2v/T
         7lufigL7XoCjXdnU9Z4k+L4NgrEOhZknjimoLTOPGqloEHysKFanGyLj9HJ+AY9L3ifn
         z+QsPDgFapW8BYxMxIQ5a8VkxPp83z+sfxuDmL4sIiwtuDW+eWv40mtXYzvJPrIn6lxq
         lE5wEtGa0YvevU59Z2On4gt1TLcXEzd78ZUoCZ38Ca4Mu395+HUzYlMnfCt4Fa7Fvxw2
         pu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1kWO3j2wVFlM5LAsHpdY18L4wA5cG+rg5SYeJEQeWaInDg+A32g8MdDRKG6kCdhosb+z5wAOOKL7omKs65JxoLhbyZHFtPE7vQVsW
X-Gm-Message-State: AOJu0YzY/5FYv+3iqpKUxZiLFpuY7D0ICuLt+Ne674ksmqlinFQIDNqw
	ORuznGEEhbXlpzozQ3Shnhy03ETyx0mN2Lb27jzz/8NEC1PtXMnW
X-Google-Smtp-Source: AGHT+IGjyAoIRz0sh6TDB9OszHuRGX56H5+fYC3wAMEjTJjQAcJei7SCO+m4/su+r6cG/qYHH2Uy7A==
X-Received: by 2002:a05:6a20:2591:b0:1c4:9ce8:e6ca with SMTP id adf61e73a8af0-1c6996a039cmr10354806637.54.1722846506563;
        Mon, 05 Aug 2024 01:28:26 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f219f5sm62023205ad.29.2024.08.05.01.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 01:28:26 -0700 (PDT)
Message-ID: <f369b1d9-bb64-49fe-bbd8-e48df26fd00c@gmail.com>
Date: Mon, 5 Aug 2024 16:28:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/22] mm/zsmalloc: introduce __zpdesc_set_zsmalloc()
To: Vishal Moola <vishal.moola@gmail.com>, alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 willy@infradead.org, senozhatsky@chromium.org, david@redhat.com,
 42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-21-alexs@kernel.org>
 <66ad2f7f.170a0220.2d3b0e.763f@mx.google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <66ad2f7f.170a0220.2d3b0e.763f@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/3/24 3:11 AM, Vishal Moola wrote:
> On Mon, Jul 29, 2024 at 07:25:32PM +0800, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
>>
>> Add a helper __zpdesc_set_zsmalloc() for __SetPageZsmalloc(), and use
>> it in callers to make code clear.
> 
> Definitely just fold this into the prior patch. It effectively does the
> same thing.

will merge them into one.

Thanks for comments!

