Return-Path: <linux-kernel+bounces-443852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70689EFCB4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C78188A1B2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA9B18A6A3;
	Thu, 12 Dec 2024 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I7GeMFOG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599EB25948B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032896; cv=none; b=A52COY+1j7amEAFe9TSAilBwtnXNlYbfhaY3mXgLgB3PO+uTieyYU3AQMeOc+hDFHC8gTshA+qa8D1hA/D7+tsPYDxuWr9xZ82lNm+i/TNNSUW1RF4ZE4p4v9Au8Zvlr0zrwVZZLuuzHmHImeFwUj+HFP+SkpJE4hQ5fWwWSZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032896; c=relaxed/simple;
	bh=bYsLNdcqBg/vwZZnexXr5kKzafhxtKcuV7Lf4QGjAhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTkCG83BU7Ga9bIRq4k59dLOIHHWIT8WK9RVn8bJevtFjKbAQkblsw455DZ1FHi9YJprzDFcfbD3oJuTeT/q4N/l60CNWL77QwMEulecacGcVLNyN5x/ysYkWuEnZj3f/tIoDFeS85IYtnmLIixwFhL8svJ3OTOx2KsjSZyJ88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I7GeMFOG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCCwgOK001149
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hAbBNuC5dKh80ZLRB6uAixzC/AiHGtZB/P/yo4TxffE=; b=I7GeMFOGG5bo4FP8
	r/FO0HCn12rmY9Zi4VPW2ny4sD0uVgVTogCAP0U8zeV+TjlAFwDBUMfQXntrliNR
	bDU4u4zYEcbyVGiYei7i0x9RMDaLyvfr35JCD+1G2DmYrQTyOloFAKx085UbH/ZZ
	8/MCUz/CjY0VYQ5X+1LYI18K0RCzw6mRsuVs1+fUbu5cBj6FM5+j7DASr0uM1UJo
	DCpcIfIclYtwigaTJ8SVuy9ipEHofCtbNqM/alWnbBTE47esX2zKhuOoix1sqb6X
	9UQEc/m6iaHkqOgBoRijo1vXKn4ZcqeFqQlxrCMlXlK41kNhU5Bx8rgw2eXSJgYu
	ubJEPA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fqes2k02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:48:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2166464e236so13598775ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032892; x=1734637692;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hAbBNuC5dKh80ZLRB6uAixzC/AiHGtZB/P/yo4TxffE=;
        b=kfCQgCSD2/9Yb6T4dU9HB4J+/VIUj0Qs73H9+S4bdGOQ3Ffl5au9kiPpsRPmcNgOQa
         2psqYw8ky1oUjyxk5TbleX9+gNOcxBwjJahQBCPa8/rc/uwn2BGu8Yi3rEHnZeUcFJJg
         g8jzB6EJSqphOg5IHlZFgf6qQJm8r5c0qWydlGWBIAhXVPyrobPuEuq1Ee5+osSvLjLz
         XhdL34WwuccPRL2HkYjtFpTFY/ZkYlC7SejirZ2yeU8NmSt7Bn2OZ9mP/ZB3uG27JQkX
         ID6YS+E53EcxRt7li+vGF3HNjs6jFEoIAwS6UgjkWZ/j196tfi9Rk8YM88iZQu7a8yj5
         p/5w==
X-Forwarded-Encrypted: i=1; AJvYcCVU/9k8wAf0QoAa1VdsGHJGJq7HkUESgRFk+fBrHPgBHn0AxUBF+yKNXGjivlFpOSBLtOJBBijsuah8TzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+at8aPKaQ0iZEkLMgfFyjxZyY7Yg8cz6cIVWIxRm/XXTLeHh6
	koeBQTk1lBCjSaP7vWWZunSsHHUwBHYcfAK8GrkV0n6/t1Ob58Sp74Amjl+UmisOccqC91Jwo36
	EWIXGC2VuO/IKgXX9iaGial0ytYIOzCaCeKDlugw2/fo9ZGjeSRefISVE5Kbdw7g=
X-Gm-Gg: ASbGncv0BwK9NCkunOeqZ6Lyw51G6CfQ679nwPl+KyxnNJVbYafR3g0NCyzdTwk6Q93
	9b48NwxvbTFdjtUJLd2jr5ukRcoYMjEkwFsvNEl9BRZTudukS5UCtn86D11yGtSY/lnse5tphHh
	ssLaqoaLzsRRyGXdihjeGLOWFb0/HX1Th3nzxJO8A8hsF3zgicQfrdNMr4JVz8zKlijpHGszVJJ
	7q8qt3VtxHL+c4tAKUUCdTNFM8K4c1D1Mh2yw5udKPGgyWLAEmcfcFnacsqCzOeArTf1smyuO/G
	UvHMWM2Z2bbeduhY0mzHcZh3L+JV1rB73+lBP5PWIgTXkADALg==
X-Received: by 2002:a17:902:db10:b0:216:7ee9:21ff with SMTP id d9443c01a7336-2177899ae0fmr127146705ad.49.1734032891661;
        Thu, 12 Dec 2024 11:48:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFW7XSKqM3jKKacWwzOG+wYPFLfO7PtBM0UQJQ8AnQ2TaamTTp6q0bSOdwqN4uudfYhURTrQ==
X-Received: by 2002:a17:902:db10:b0:216:7ee9:21ff with SMTP id d9443c01a7336-2177899ae0fmr127146385ad.49.1734032891302;
        Thu, 12 Dec 2024 11:48:11 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2166ef8b8d7sm53340285ad.67.2024.12.12.11.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 11:48:10 -0800 (PST)
Message-ID: <a6d2bfba-c3a8-4cf4-9276-7f7e39671a15@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 11:48:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] wifi: ath11k: Convert timeouts to
 secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com>
 <20241212-netdev-converge-secs-to-jiffies-v4-2-6dac97a6d6ab@linux.microsoft.com>
 <27cc63e7-1a63-4ba5-8c7a-12a78ad6d9fa@oss.qualcomm.com>
 <cc1d5e08-92e0-46d8-badb-2a61482200cf@linux.microsoft.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cc1d5e08-92e0-46d8-badb-2a61482200cf@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hS-9WfdkaixZrOkYFSgJaEtclCiQBBIx
X-Proofpoint-ORIG-GUID: hS-9WfdkaixZrOkYFSgJaEtclCiQBBIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=966 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120143

On 12/12/2024 11:17 AM, Easwar Hariharan wrote:
> On 12/12/2024 9:51 AM, Jeff Johnson wrote:
>> On 12/12/2024 9:33 AM, Easwar Hariharan wrote:
>>> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
>>>
>>> secs_to_jiffies(). As the value here is a multiple of 1000, use
>>>
>>> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
>>>
>>>
>>>
>>
>> something is wrong with your patch since it introduces a blank line after each
>> line.
>>
> 
> This is some sort of weird interaction between b4 and git send-email. I
> used git send-email to send the patches after writing them out with b4
> send so as to edit "net-next" into the subject line. It's good to know
> to not mix the tools in the future.
> 
> I can resend from the branch with git send-email directly to avoid this
> if preferred.
> 
>> Also if you want the ath11k patch to be taken separately, it goes through the
>> ath tree, not the net tree.
>>
>> /jeff
>>
> 
> I don't have a preference on being taken separately, whatever approach
> works best is good with me.

Andrew has this in his mm tree, so let's just have it come from there:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything&id=b3b550379dd1f0b65fac207c9c4d0eb5ed84775e


