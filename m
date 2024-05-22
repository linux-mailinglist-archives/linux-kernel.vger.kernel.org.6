Return-Path: <linux-kernel+bounces-186162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546098CC080
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09DE2284105
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC796131745;
	Wed, 22 May 2024 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o85Bd9E1"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE421311AC
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378315; cv=none; b=nRUP+nFGarGTujIcm/S99TV+AkZM1KY2x5HgJb8JqC/yLoXCLIMI9u+lfCxD9+OLipREIY0BRvLhgg+JsWdUfZXYGnd7q+2Gso2bnMEE7+mBAgzooW9VxFNSkxqzAngQUCAAK2mQk0B1jnEFiCHPT8rNJhGsp+U4Mt2poDXhkGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378315; c=relaxed/simple;
	bh=bWV87wMk7QdIGZvVs81+bOCYybeSvXXrPWxfPseAq+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhhT5hBhl+1O44fte6xXqRdxY4JAaP3+EavqNQfrl5n8VNJqVqFZBRUlCqVzTUHdQ1G1UYQ0H80A02E+mhqZxaHneAg6zyS5i1COR1jmt4D6YQPbozpmxftB2ZESyJWL58LJIZnn0fGBP93IM5u4hx+9zt/X/L6Td9iMEkFkHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o85Bd9E1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59c0a6415fso1029475966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716378312; x=1716983112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gwpn4M8wXMzmskdGYqi7pa6LBArie4dJBdNS67in5c=;
        b=o85Bd9E1Lp3cRXL3yBNd8oLWHU7g/6b+VOFUNi1ajib6aHBoVchB4fFd1QcAijw1Pk
         +5Xo4PP1lVWlUogXRydi1OEBmpedjPTXO0VtbgA4rzVGKbC/VXKQy37S75w6zNtCrRd1
         GZ7+OZnlyEIBxwQ8LTxWkGAULjIxxUXcOiA9wJvkK3C0E619pxCLa1D13kkQ6RDKLTJU
         Y8J8bJ/dmyulVzcxcDQiB3lDN7EPuGehm0+7q+pWZtwKJFH4kLV5VBjqy01BffnTCl/N
         24jMTATRnNBKkb6WgX5HmfNJ6crJvwknawF1cVW7MRZJRkvIZlkU6NgD5wDp6coLSa+z
         CJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716378312; x=1716983112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gwpn4M8wXMzmskdGYqi7pa6LBArie4dJBdNS67in5c=;
        b=xF7uG+oLZUX9xz+SYVa5p0JNe4eQ65bJJ9rkBPJfgaeiYVhHfNchd8+cxRDYTdRUaj
         4DffThVQZuxGV12mVkuwwf9B62zsTXsWQUiI8nYH2payYT7SZAQ+SLKXwsAhaKf7Gl54
         OnU150Fflgg8McCZk2n58Ehp+O1BrnUeGDVO32EGJHZUNAM3Gk+a9fbXH9grVTxneRsc
         8lQprlHxZBjvrGtpLPW6sQj7pZHNZDoDLK2E9lgkx0jGtBHkW6QUnAkZ2Oi3BWijBvex
         0I3Fyn5oeCGpR/Bn26Cmzc0muUS51k/8FSUomMEiEqUfmYpQaBwEASbPOIRTeDETQCBY
         QcWg==
X-Forwarded-Encrypted: i=1; AJvYcCXr6EAwJVMfQfX8ahBOqk3aLnXJK061/X6bgXcrrOwuL4OJlBHhjTk5I7zD7Nlkc1kEN/bK9XuOkSm5OblvxH9R+kddXduptZ/RDfFt
X-Gm-Message-State: AOJu0Yya0O/TIMMnykjmVPxW8ScHcAm8vdVGq92Gb3XO51tddyUDbrjZ
	VopK93DlkA/1jahOZ1N4jNUroeTGXMEGkrUNW38fpZ+FOdNX1zQJYWEA0ViSz0E=
X-Google-Smtp-Source: AGHT+IFQNIzb2AoT9f60jCs/82jhSKBFn6InR2KN5sUhggcetPzvmsftnNxuPl1455O7olwZfrLu6A==
X-Received: by 2002:a17:906:6845:b0:a5a:3a6c:8b56 with SMTP id a640c23a62f3a-a622806b807mr128434866b.11.1716378311997;
        Wed, 22 May 2024 04:45:11 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c55:53ae:3b6a:7bb9:3183:8e19? ([2a00:f41:c55:53ae:3b6a:7bb9:3183:8e19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5d10b3ef82sm700019566b.158.2024.05.22.04.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 04:45:11 -0700 (PDT)
Message-ID: <1ae84136-ab00-479d-98a1-5aab3de87a71@linaro.org>
Date: Wed, 22 May 2024 13:45:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spmi: pmic-arb: Pass the correct of_node to
 irq_domain_add_tree
To: Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>, linux-kernel@vger.kernel.org
References: <20240522-topic-spmi_multi_master_irqfix-v1-1-f7098b9c8804@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240522-topic-spmi_multi_master_irqfix-v1-1-f7098b9c8804@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/22/24 13:38, Konrad Dybcio wrote:
> Currently, irqchips for all of the subnodes (which represent a given
> bus master) point to the parent wrapper node. This is no bueno, as
> no interrupts arrive, ever (because nothing references that node).
> 
> Fix that by passing a reference to the respective master's of_node.
> 
> Worth noting, this is a NOP for devices with only a single master
> described.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Fixes: 979987371739 ("spmi: pmic-arb: Add multi bus support")

Konrad

