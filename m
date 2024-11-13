Return-Path: <linux-kernel+bounces-408031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2BC9C7929
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22A11F2637B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CF8201011;
	Wed, 13 Nov 2024 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHRx9Sa4"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14701E1037
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516295; cv=none; b=VU2bfs8YQQlTMkm9rA2jCO54VuAwAY1XytmkZNzaltmOZ8xi3dBtSBHZxIOArvnmKEpZrH/vq4fAcOpsjSZbsDFxMNhZT4By+PxCkOqxujg1OYVR2lo9R9WJspwghjdOwlq2trculW7CQe7L754ioC3sRJOGakDBJnpNgvioNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516295; c=relaxed/simple;
	bh=UvwFjfT3wQMT9BCmlcPNb5S9Zfy6pXcyTNoqT8oUtuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bk8R2RKiDbIjmg+6IEsWYiWQ6Y0RMbyeuxEX/JBpM0GHSbYs31dwwcBGVKyWkN9qU5luQy/phBZgZNVE6Q/Zqn5UUHZrm50LMO9UlOwZkgut1eIqDIbwKQeeXwYOdaprn5y+2P+iJ/dWsFbiwEVG5en8OrHLVWBx6oaRJt2Emds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iHRx9Sa4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so63356405e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731516291; x=1732121091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yhsnzqZOh4R3FRkvGfICJ35wcM+QS/kWjouazfYLcDY=;
        b=iHRx9Sa42bPdRt8a1JE/ddTxQR1LAqhjhp6JyNiLSzjl0r9nwjMf7oBEneU7Inz8A3
         vrZ6T/cmPqfSdsvAjpxlf7F0Y86TqIEz32k5P33rhIZgkbeU+RhXhj6/aILd2Qa1qL7j
         24ia1vTgKO+3w3V0NRaZbiUoqWzCrx0yE+Mp8q2ds0QmQ4JYG1hUuhLQlmc6ei2kmKIx
         4cPcqyKsW083c+0uzvdnRtx/mX/WG3HVkGnuuHQM2EFGTj9+rvJ07nA93W7GOHzuvo86
         MmTTF53BY9r+4sJqGiucv/s4Mxvqc9817d5C8ONewu1vD2+Eyt+qXUrloNdsjWtK+cqP
         fWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516291; x=1732121091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhsnzqZOh4R3FRkvGfICJ35wcM+QS/kWjouazfYLcDY=;
        b=Yc+eXAd+FoYH/iuSxWESRZ7apQtnQ4wU4iOXbpHJs9mr7f0StzOH7VEt7IuiPQzeLq
         mJFe7w7nHekf9g3zE8mXUm/Gv06HNiexOZKxMs2lR7UU1AQgLSrk1G/vR5zGIOmZ2Ayn
         SlQcWku2t/xDf1r+lu5C042xbmrdtFfG1i7QA1gDB6gGnPb9mN8xJI3uNjCTxchsq/mn
         eC4THhvxikFzIxyPI9y2T0FQ3Y8WdVMeu+eQoWaNSYWGzL67KadoFrDvkNgSYnlxyed+
         A/8AMi2gd6qIOfd4vaYXV4B313S07w2+/EHRNwq/O5lwBKdQi47gyq9GY8i1gsLhi/mF
         nZcg==
X-Forwarded-Encrypted: i=1; AJvYcCVbP/GNAx5TPTzHaPdHSiyiL1N9h9O4JyuA4e9cQTiZjGn9atrPAyFNqhBrrsPRv+fBuCjbjphpM1db/pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5yNeUSOMrRnKSrHiWEltmeewNMgUTMmfS1FCK04NZesUbskEE
	syu/630SwRMLgQE/fcMOYwGaERDUANpS5pGSf1fw4Bw4GnFFvW2hrFOUJ+FpP0U=
X-Google-Smtp-Source: AGHT+IHYQMbMGHB9Ebm5O/a/ONHbsXpJvb/DnR63WL1sEun0Ham/hbt1RhODuXY+11bavUk2I6AAtA==
X-Received: by 2002:a05:600c:1e89:b0:431:54f3:11af with SMTP id 5b1f17b1804b1-432b751d984mr185015515e9.31.1731516291209;
        Wed, 13 Nov 2024 08:44:51 -0800 (PST)
Received: from [192.168.0.48] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d552e6f0sm31103175e9.43.2024.11.13.08.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:44:50 -0800 (PST)
Message-ID: <1fd1bcc2-9d64-4676-8f41-73f7dfef2d39@linaro.org>
Date: Wed, 13 Nov 2024 16:44:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] media: venus: core: add qcs615 platform data
To: Renjiang Han <quic_renjiang@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241112-add-venus-for-qcs615-v2-0-e67947f957af@quicinc.com>
 <20241112-add-venus-for-qcs615-v2-2-e67947f957af@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241112-add-venus-for-qcs615-v2-2-e67947f957af@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2024 11:47, Renjiang Han wrote:
> Initialize the platform data and enable venus driver probe of QCS615
> SoC.
> 
> Signed-off-by: Renjiang Han <quic_renjiang@quicinc.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

