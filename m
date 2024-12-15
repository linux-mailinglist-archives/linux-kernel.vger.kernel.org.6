Return-Path: <linux-kernel+bounces-446370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B89F238B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EB91885EB8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 11:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E317B418;
	Sun, 15 Dec 2024 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w+loVucR"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C040156871
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734263918; cv=none; b=p8M1r/o5A5LSQt+cBqnvhRsM2l2V1Btk2v+qkSoiAh1lJPeVMOf9SLwnvQW2mlsxoooNR45yEXStHh7c9mvUkYGdgnMVM4yMGjQdddwrheDqCi93S5TX97/coINrHIEg8d/D4/Vk4ZMGOL/d6mtXeRZ+TMaEirjoyaP1PvrsDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734263918; c=relaxed/simple;
	bh=d+pfu1XROrpeafS1eYKpAbT78e7jb/FH6/Nsca/bRPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqZXGyKalAng/ljYdTnGc5TtiJHdHli3emu1urnZ+i3LZGPnE4gagf0nB+UdbPf3Qq4A89ghiWGhORzY/SrXigGh/ycsoYgn7gtH8kEDPwUjwboVScL0PuXcRHgr33T1CiZFs0rz4qMePzUJ/4ljzjUkLvWfTtJrGNni67Ke0DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w+loVucR; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3022a92f7f0so1744441fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 03:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734263914; x=1734868714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/kPa7EZggbMZnJnKi8Z8wUeoKFvdbp7AEN/NzD7/uM=;
        b=w+loVucRhsmWiDbf82U+klvnYYUpP0/qVvu+HehD3bfOy0Q+273ILHDXzUePgZCOw0
         Jx0FB0E0ZISQesSqMQxhGM+a53/0VAIyZfIt98Tz9p+hTjigbBNnj7X9dH+AC/LTYXwj
         OQiyFgsp2mSoE8SN+Jkdf7aJRT1V/GEwG+1oiTQxNNRQwxZxzE9DVnNXoWOlM4R3DwLq
         t1C4SyPLBQDL5ZPRFgdu1WvaulBCDtzWqFIzLV329gMIu8exyasAI/N9Zva2ko/bxTvf
         twKRHr3MBml0vlOsQlyslRz7QOasBRr+/ihV1/AzBggkNs7WcVjeMBUZBlA3JqXVKmdl
         cKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734263914; x=1734868714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/kPa7EZggbMZnJnKi8Z8wUeoKFvdbp7AEN/NzD7/uM=;
        b=XUlS+n+XYFYmmTZAL/Al2m5HzbzOlWgtoGDRHpMg09LYGjD0zw2MMY3X16L9/ta4Iw
         C6+yOmKS7e/j77CpC4Mnb5S02YKjz3YzlF9OOl1nYmsA8Lz67A7DwnnU15KlJiISEEBB
         pLMwEC/2a3k/cN1UEt3wC/6uaSz6WbwitoZi20I5WUh6dcckYlkSQ8t+DYWBwsHkh6Jp
         8BKJGIGDBEdtygMNk9UTYW6A/twWfW+fFzdqWtGrKmkhT0NgRsJLcpAtR2opo9ockq94
         BdGYfcLRX+dMn9Yhbt0iNQt8LBugZv27B/BdMDhG/S1pnGAiGUAygfPTecxdfVTA2ICR
         I7sg==
X-Forwarded-Encrypted: i=1; AJvYcCX8jfMNAt+G7T7zSL2sjpnQI3Gp+9HDHB1bNLyFpqf9keP4cxZqPL8hVvsc+yB9ANw9wbcQ4rXrFthY/h8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38Qh9XqBAalnaQRc3YFVGTFEey3J00Q4cOQwn57PjMThLBqLR
	xIqzIQ5FjQnppGliIsdCLioEQF5s9ji8Nfo/aeG2xSXHxSwk24Q/7lkOF/JooY0=
X-Gm-Gg: ASbGnctVwiz163NoGO9uWVMK9LhyKBq4jT8H8JVDAtyMPOJolzarzpEE4JDIhA1CZcW
	RJ4fbL1S2YLu0PQ2YrobpH6obz8RkqE6SsjckZfmZgJkpYt8croXFkLp8MRslXFPukGJ3bgd5qB
	Y8In+oXvaJpbM9M+FIfdmRGogrp/KWnNIrYAvdTEiGBc+h9lyD+2g/i1rE8/cX9OZPNtSZitoF0
	mgl3b0zd7kDwjduDTEacgu25N4jlJ9pJp4mo48GrE7AwN0E8u040+HTOCtwidr4u9ETImKSEo2M
	D8Jv0erTgTINzZjHPZMoE9HGeWfkJia/e0U=
X-Google-Smtp-Source: AGHT+IFTUZ3GMs7Nz8u9GUpy5ovc0Jqqr01QOzyL8po2NQJCJYBql7UOXcPOqTrAeb9lNKlyvbQa2g==
X-Received: by 2002:a2e:be9e:0:b0:302:3d74:a18b with SMTP id 38308e7fff4ca-3025450026fmr10348671fa.9.1734263914271;
        Sun, 15 Dec 2024 03:58:34 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344045358sm5491911fa.35.2024.12.15.03.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 03:58:32 -0800 (PST)
Message-ID: <60bfe389-cea9-4aea-9175-fc80f1e9f594@linaro.org>
Date: Sun, 15 Dec 2024 13:58:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "media: qcom: camss: Restructure
 camss_link_entities"
Content-Language: ru-RU
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Suresh Vankadara <quic_svankada@quicinc.com>,
 Vikram Sharma <quic_vikramsa@quicinc.com>,
 Trishansh Bhardwaj <quic_tbhardwa@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241215-b4-linux-next-revert-link-freq-v2-1-62d5660004ea@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241215-b4-linux-next-revert-link-freq-v2-1-62d5660004ea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/24 02:33, Bryan O'Donoghue wrote:
> This reverts commit cc1ecabe67d92a2da0b0402f715598e8dbdc3b9e.
> 
> This commit has a basic flaw in that it relies on camss->res->csid_num as a
> control to index the array camss->vfe[i].
> 
> Testing on a platform where csid_num > vfe_num showed this bug up.
> 
> camss->vfe should only be indexed by camss->res->vfe_num. Since this commit
> is meant to make the code be more readable reverting will simply restore
> the previous correct bounds checking.
> 
> We can make another pass at making camss_link_entities look prettier but,
> for now we should zap the bug introduced.
> 
> Fixes: cc1ecabe67d9 ("media: qcom: camss: Restructure camss_link_entities")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

This change is very welcome.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

