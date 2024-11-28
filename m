Return-Path: <linux-kernel+bounces-424677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16749DB7F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF2E163DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6C419F135;
	Thu, 28 Nov 2024 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vG/FNAVb"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C119CC1F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798461; cv=none; b=miYqJsVeKMftxUqCIBu5M1CpCG5GJ9VLv5PQ4eN2hYO4mqUi9HfQN1ta2gWZsvWLWUp+kk8C9QpO/c9kqgQ2H09NJkOhAW53Xj13N/OtJNlOvY4mhVPzx+lWpq1QOYgbyJe83LqxrmT6MDBpWwu939Fx6GF9MR1lPqjtSWoXzAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798461; c=relaxed/simple;
	bh=JbK666IvR99GAgHTs8lLb3xdOQ6oiiw7jTESJQOpgg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Czqi1sub+8RdS9IKY+E8u/QNjWzV/jERmyh7nCb45YAnjA/X+5RilhGWnzJ2cr7kgPJtKekDbPKH0JSRCEAIu5hI0l+eeAbJnZ+PwmsMLz0jmTdfv2sIVk9MRasPr+3qzEerfh4DTNtDvkK3RMVHPe1uesBecJ7rbPjvaxvaKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vG/FNAVb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38230ed9baeso578065f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732798458; x=1733403258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNkrh/sDtdbdwO6uUAVnsS4BZrJy5eiLU2ygKncvgJ8=;
        b=vG/FNAVbw8Sniz0ttdG9eZGHe17NTX7BHRDX+yVLt+HOoff2WBEvdPDWmqab2Kh6Qo
         lESqtmTeimJbtQn7tqnUD7W7iDd7WtV1s/xWOltqW9Wi8rdsM8+5pwHK+o41AxpCQ1Bb
         tzN9ez6B70laESS64J7/PqkLX3Qi5MUaKQCIFdH89Wo3g4oQTzD55lkauW4netO1ahv4
         e8imtW6g3TwRX9AWq2POOkeVarBi6lAsZ6OmquRtXIjvLsV+as/uX+BAjwVr3ixWJoe8
         LiHBk1EVS0sD88QTzHuiUbVk3DnSbcHXwDYN6uTlBAPVvc83ccRjcif2RizxShn+TpmA
         xUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732798458; x=1733403258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNkrh/sDtdbdwO6uUAVnsS4BZrJy5eiLU2ygKncvgJ8=;
        b=P++CVmjsLSE9QCohf0U7hlcqmOHsMMKz0lumztFMvbOolvVkVTbCK+IIanEr6v96Ed
         PS2mYKXvG7hV9jAzkRMDKvw7hrr352Cvflu/uvG1di4sxD86xH9NAMylAt85cDs2Lb+E
         0NY1/96kRy64+jDcPmTKBZCBX2YVnwRpeECtG4l/4jp9gWpUXFA/WbBXzXoL9CTFp7YH
         TomMl6FTc2YUZddg3C1DCVeFshxtmzcvv16zGbGFKqTasenjvnwAm+l5YhbhkLk3AvHq
         Mu3seYWiZyK8RXO2cfmwmVn7UUyfkQrFrGhD3NTgPvVErnQUd+eOLqAyqziuknGhLdGy
         IylQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7wubUi7LjXPWS1xlgH1Efyopb568ObY4mzQJ/InOmkV5IQukgf7WM0T1o10bYodJqh1VEDK3jthHPo0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRigIk2V9KE5VO1xMHAy0wcn2d+LWFUVlEORev2v8iwIfV+e1
	ErNjTDls8aUVx95yG1+xIcAkhRzpqLy56HzsVhvU4q+qm1DaxEqo0bgjwhlBeiY=
X-Gm-Gg: ASbGncvL51lkBv9kMxnMe72b1FKYYGeBGaX3a/1kzeLN2bG2LAad55eXRRl7G3f3O5f
	0smb6p3Dwj8hnF+sgw1BYILYN/E6ZI7j67g+fkfcWEza5Vosb7Mynz49ADYaNSO0dKyY+C/fVkp
	m1pfMqv/ngqG11DdM0UkucSKH4+8WwzbcS5SckOyd7N775T2svKXlkWUZ1D4t+qaW8VvL2gHrI9
	A3xksxkZIEYUmBEaKYBVCNEBCSxi9AIr5qkeDbGJiw5kckY3m09nymRwWYkrtw=
X-Google-Smtp-Source: AGHT+IH/SWChFnFdYH46d0Zm8lHs8Z6HYuLx9vKVGjOt42Hf8xNwi4grsDUVNndAg0+gl115y3EyBw==
X-Received: by 2002:a05:6000:1867:b0:382:50a7:beef with SMTP id ffacd0b85a97d-385c6ebda1emr6295771f8f.24.1732798457708;
        Thu, 28 Nov 2024 04:54:17 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74ea95sm53021065e9.5.2024.11.28.04.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 04:54:17 -0800 (PST)
Message-ID: <71dd9aec-e2b4-4323-aeb6-53f2491005b3@linaro.org>
Date: Thu, 28 Nov 2024 12:54:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] media: venus: Add support for static video
 encoder/decoder declarations
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: quic_renjiang@quicinc.com, quic_vnagar@quicinc.com,
 quic_dikshita@quicinc.com, konradybcio@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, devicetree@vger.kernel.org
References: <20241127-media-staging-24-11-25-rb3-hw-compat-string-v2-0-c010fd45f7ff@linaro.org>
 <20241127-media-staging-24-11-25-rb3-hw-compat-string-v2-1-c010fd45f7ff@linaro.org>
 <ad906baa-a93f-42c4-bbe5-968fa939c653@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ad906baa-a93f-42c4-bbe5-968fa939c653@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/11/2024 09:02, Vladimir Zapolskiy wrote:
>> +    np = of_changeset_create_node(ocs, dev->of_node, node_name);
>> +    if (!np) {
>> +        dev_err(dev, "Unable to create new node\n");
>> +        return -ENODEV;
> 
> Leaked reference to np.

I don't believe that's a leak, because you only release np when it is 
non-NULL.

>> +    }
>> +
>> +    ret = of_changeset_add_prop_string(ocs, np, "compatible", compat);
>> +    if (ret)
>> +        dev_err(dev, "unable to add %s\n", compat);
>> +
>> +    of_node_put(np); 

Which we do here.

However, I think I have missed a of_changeset_destroy(ocs); on the error 
path.

@ref drivers/pci/of.c::of_pci_make_dev_node()

---
bod


