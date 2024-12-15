Return-Path: <linux-kernel+bounces-446372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E149F238E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA751885EBA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E151161302;
	Sun, 15 Dec 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eA+2/hjk"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D79481CD
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734264232; cv=none; b=NgKMO1wQzheEMqQUksnfsQWImWQoo5/vcLI0MKYkBSNXb6593BaNMsIBwcdjtjxupQyic5kFexaE+12NSl/rHqrcXD79FGtmpJXaQemeGh8ppMZFs/c9Ik3F0PxSrthC7leqGvqEefjIjEelvo1j7OxY/Tc+JkpdZlCgfuBrSms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734264232; c=relaxed/simple;
	bh=aGpiOGREIUcShpcp8ShVC5e2TvYuN9RPLMTv9UtamMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6NwXD4xeKWU3E19+LJEq1tETegyEyDUOJtf4nHJM1kZYVc3ZaBa0rlafT79raGftM52ou3IMwLdkNlVSzcJfe1w6qT6pwDBXf0dglo2Mz+A4ewh29zMMtnIgsEUHrrv0DAfoYroT8Xzrb7nMjGhbkrCgEGoQMpDKYkpuckqmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eA+2/hjk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385deda28b3so2515054f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734264229; x=1734869029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MS0JrlD/MIP9EaVqJjdQNvfB2tn7DETWLm6kEprczwQ=;
        b=eA+2/hjkzWvPwpHMu1ip6KzFEc70WIAPC5jR73P4uzT9MLBQq47MPZqIQlw1QEL1b/
         ptrRAMOPK0ZBl/rG15iro7vHULH24jmoA+7yqqH7XrCCWc774GUKoHEeauCnwTlx0xBh
         PbsKn9+x1LH17YbDeIaUZ+nIjlAumI3CnDwQaAG+FrwOhMYRCzEAuqqZjtgGjI1/liW9
         McFkCMFxCMVHEw83Sk0T672fl10vUynG/ABPJ629M8VcPKfj7ORb4d1cH7c5tVWPYMaz
         Ifj5IoaNIXvbwYx0h7P5MLWOnqjXeV0SGbF2xapKngPs3XdW3KJjuci0ZRMKN1Ck460a
         W2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734264229; x=1734869029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MS0JrlD/MIP9EaVqJjdQNvfB2tn7DETWLm6kEprczwQ=;
        b=e3iD4h0pobm4+DrrI+SDTRWqxikmZP7cj9ifv+GBItbqwKZ2wem+Wb7uM4d1ABix7N
         ndnpC4gTGQIPygfdahHRFXX4RZl0tloNWhZ6ddBJeI3pu5NzM6JZgpDBirsxBUNwINK/
         6TUIl4QK3S+XeNG7gl/oKho6r5iEfiz7fAMIeqTirSmhHTujx9OmCaJ8yN/9HLcnOkqn
         6hsp1nt2kYBWt1IDCZGFauzZ7RmjQaq4KtiPzSySdhSkMytiYnYt8GC3R4ecBAuoGAxq
         2CcbhbZ/BK16iBaJs7tcCAkkW+fl9TpdP8sytVpEKwS0qNY77/rJxnqy7QpAu81rT1Jc
         iyZw==
X-Forwarded-Encrypted: i=1; AJvYcCXzbWlGGbgunkFh9Mw+JpGgDlqQac+EwX16YMhMvxLH2G1CZ0ETV70H+jBg2eq8Q1mUoy7acupyJUbOlNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztfCM6YM1irp+WsEFFB9jt4/XPB5T0bSJu0/7+IcJOiYPlRQUF
	7M+vRktoLbpuzTptNcnrvl4a7mT2zeqw2+SjovBd52VlalCInOZIonar2/XN9no=
X-Gm-Gg: ASbGnct0Qua/7STN7Aa6NpVG1sxI9hwVm0ZU3k49f2k8iJ1eKeadvG381LLzLwSfKWy
	oqFwQBlDHS4Jrc+sGlZD1oQx0TMqLaAkf5PGjYfRPUcKzOdBC/+d3yVbzJUejk9KIhZOE+zt92T
	Gv+mrjStEz2/McsbwdT0Vh7dhFteBEC6WYXYCqly7JNaFc9D3S+oYMShX9iM7Am/8moEAuuxJU1
	lK+So2vxkdwqyi9B4YAXOQ94wc6vwKR19Svu4KhiZHm1Wg7XEoWGep7WQQa15uoZ6niiA==
X-Google-Smtp-Source: AGHT+IHdf+axtUaBvNo+jZg5gVqNEZh7fpsNxrZqvb0qpatqR6zQGoIT4kFiRZ3VvH03TdccPTyjiA==
X-Received: by 2002:a5d:47ae:0:b0:382:3754:38fa with SMTP id ffacd0b85a97d-3888e0ba9a7mr7465978f8f.51.1734264229096;
        Sun, 15 Dec 2024 04:03:49 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80120dcsm5216297f8f.8.2024.12.15.04.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 04:03:48 -0800 (PST)
Message-ID: <ee6bbbb3-f91b-4568-aeec-11d773ae4df3@linaro.org>
Date: Sun, 15 Dec 2024 12:03:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "media: qcom: camss: Restructure
 camss_link_entities"
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Suresh Vankadara <quic_svankada@quicinc.com>,
 Vikram Sharma <quic_vikramsa@quicinc.com>,
 Trishansh Bhardwaj <quic_tbhardwa@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241215-b4-linux-next-revert-link-freq-v2-1-62d5660004ea@linaro.org>
 <60bfe389-cea9-4aea-9175-fc80f1e9f594@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <60bfe389-cea9-4aea-9175-fc80f1e9f594@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/12/2024 11:58, Vladimir Zapolskiy wrote:
> On 12/15/24 02:33, Bryan O'Donoghue wrote:
>> This reverts commit cc1ecabe67d92a2da0b0402f715598e8dbdc3b9e.
>>
>> This commit has a basic flaw in that it relies on camss->res->csid_num 
>> as a
>> control to index the array camss->vfe[i].
>>
>> Testing on a platform where csid_num > vfe_num showed this bug up.
>>
>> camss->vfe should only be indexed by camss->res->vfe_num. Since this 
>> commit
>> is meant to make the code be more readable reverting will simply restore
>> the previous correct bounds checking.
>>
>> We can make another pass at making camss_link_entities look prettier but,
>> for now we should zap the bug introduced.
>>
>> Fixes: cc1ecabe67d9 ("media: qcom: camss: Restructure 
>> camss_link_entities")
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> This change is very welcome.
> 
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> 
> -- 
> Best wishes,
> Vladimir

Mauro.

Hans would normally merge for us in CAMSS but, he's on Xmas holidays.

Could I impose upon you to pick this one up directly ?

---
bod

