Return-Path: <linux-kernel+bounces-435589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611CA9E79D6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6998E188312F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0261F204578;
	Fri,  6 Dec 2024 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S1h+AfyO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4B1F3D20
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515617; cv=none; b=XpNVOpzwtCmtf4b8BILuhE79DPhqbUpUmYn0CCoG95zprlfuT3ERlmOL0NFW112wLcZaOA8gN4GT7oVb5xxxTEmsogFtJ17XYJ1JN715s8GJor3e6Zau4KvqFkqO28SfY2KHtNRuXP1oAFaJXjqyS8uPAG9ptPCYYGeLLrwqJsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515617; c=relaxed/simple;
	bh=jeulAPGQM9UxEUcb4xuGL0GiG+vLrh0W2fMLyPffguk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kC0jMUwdLPxaj6lAgiI3Ht7UHF6IQKUL5cxqDCEVYnq7qSTfXcLSrculqO6qyUk5tDgJTKcySfPcuGUFSQIcVYPphIJwdg8KqIxMNukLYqEnd4NsWC1iL57Txj9bE57fUkH22YQ4ZfWnA54LoYfS8bR0dgwCnjrCyBj6VB0w58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S1h+AfyO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6GMnPe026142
	for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2024 20:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KKHquatXccdUE/8FhYJaY/jFJDVvrfnYD3Ug+2HTmy8=; b=S1h+AfyOjqMTTgJ/
	gr+qYBj2xjNG5oh1e2IfKszOwlRWkENgmKr+99r/VoWXnHVMnuzfx7ZDkiw8BdFg
	ydB21ySmgyf0NnVpz9ZCNCFphUNiLBoKRzUvx7h4pfJSqdxyENO8NFgqf/g9wsCj
	4BqVfo8+9ChWx8sDwx7Fa/ItophUj+N6hy9DyEBLvbAermapTb5b4ZEh6p9TS212
	j3ysGxPMUn25LE+ZSC3m0/8+rudAZR89N5z6cfasdgNtMhcVZVhcexN1WhgpCnFZ
	ptcwNvGic89qIDMGo4srVuKOwO9hIv7t8ignhA13kKZcj1lqnZzbFaOd1S7oQobU
	srWnKQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43c4r4ggf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 20:06:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7fb966ee0cdso1782765a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 12:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515613; x=1734120413;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKHquatXccdUE/8FhYJaY/jFJDVvrfnYD3Ug+2HTmy8=;
        b=MND7UsBlV2dZzytfy4D9PxpA0r+DeVsgeAVcwi9OiyIKkL42ewHGj/BFUYERWHuzmf
         SiyWEEvlM8Hl++ncvROBBIdIFnLlh9/Yrf10eJw3dnw8RkqZh20sUrZs4iJlnhEg4fEn
         APAPb8buM7bcBM2agtE/aXiqk894XeWoFwYg7siVtGYy3oj3LnlJNc2JDU3I0c2eURrm
         KX26Bd+sfRc9ZSnklWx/k9TQ1QnION6GYBPC9AW+Fs9ZdFrqSy7SAeWhA7r3nFD/v+l1
         DZt2f4mh3CeWeYkAe2gR4adqt4ORLDNhYgmOel9UI/mLhfjedtpozH3W89Fec62h1Wd2
         oC/w==
X-Forwarded-Encrypted: i=1; AJvYcCXgY2wzx4QBjJUgoX/Q+r+rQFJvUgyMrYd+9Q3c6hvOB3J1gLSb8Ce/nfye7iQEvuRQR1C8rEwNkKO8HSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ67D9tBG/JISF3OMbchsWwFVtoXb8fJJX0zJc5TNYlUdMbJId
	xXx9ZECWMCOaeaHu0gx4zWjrLXjQExR3DiHN+j7A60OQedFQ2oHT2ZzagLgns4cZypNS41ZWcKD
	Ya7zRcMj5kBvZ7wkexbYqvu14z90Cb40c4G33FQFx7rZZOAmGWZfM1a0w8rEoIo6ohJkPLpY=
X-Gm-Gg: ASbGncvxPQSzqIlGWwqVbMIHsH3ye8t/83EuiTtxBBZqB+JAkbsJo8WMoke9QFZp7Mo
	Xwi9nGqR5U5EP/ZjXNmN1y5FAMd6RwOo9xFTZ/LS11WCl2ubGUsdHBjXe920jy8nvWxPv/gtSnR
	HfbweQx4ods5xKmqE8opj9al0SszcvWN78BRuS6gjMQtfpaUQbAVDTxnjPNUVPigzCntrxTq3t1
	8hdt8SjhCidioD8F1VbOd6XDPjRurpsWpxhk/esbipyDeDtcrT2Q1TvXFT4zzqpZJ2VsaqtxU/N
	eAMUXPd54DCXKz01hagRTSmz0f6v88I428Juxwsap9c=
X-Received: by 2002:a17:902:ea11:b0:216:282d:c69e with SMTP id d9443c01a7336-216282dd891mr11067645ad.23.1733515613486;
        Fri, 06 Dec 2024 12:06:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH09o+jP8XVNXDbXOcJarG/czPCA5tRwQQW5YRkwI50Z0sDJXkcLgUikTDd6q1KEnYVPVQ8cg==
X-Received: by 2002:a17:902:ea11:b0:216:282d:c69e with SMTP id d9443c01a7336-216282dd891mr11067315ad.23.1733515613088;
        Fri, 06 Dec 2024 12:06:53 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3f0b5sm32531665ad.20.2024.12.06.12.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 12:06:52 -0800 (PST)
Message-ID: <8c019176-6bb5-467c-bcea-10517675de7d@oss.qualcomm.com>
Date: Fri, 6 Dec 2024 12:06:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: ath12k: Fix out-of-bounds read
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>, kvalo@kernel.org,
        ath12k@lists.infradead.org
Cc: jjohnson@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241206073542.315095-1-dheeraj.linuxdev@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241206073542.315095-1-dheeraj.linuxdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vlTEbXxt7M-L5t0oGvIbLPCBNxYm58Xo
X-Proofpoint-ORIG-GUID: vlTEbXxt7M-L5t0oGvIbLPCBNxYm58Xo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060151

On 12/5/2024 11:35 PM, Dheeraj Reddy Jonnalagadda wrote:

The subject should be as specific as possible while still fitting on one line.
Ideally the subject should be unique. So at a minimum I'd add "in
ath12k_mac_vdev_create()"

> This patch addresses the Out-of-bounds read issue detected by
> Coverity (CID 1602214). The function ath12k_mac_vdev_create() accesses
> the vif->link_conf array using link_id, which is derived from
> arvif->link_id. In cases where arvif->link_id equals 15, the index

How can arvif->link_id equal 15? Does Coverity actually identify a code path
where this can occur?

> exceeds the bounds of the array, which contains only 15 elements.This

nit: space after .

> results in an out-of-bounds read.
> 
> This issue occurs in the following branch of the code:
> 
>     if (arvif->link_id == ATH12K_DEFAULT_SCAN_LINK && vif->valid_links)
>         link_id = ffs(vif->valid_links) - 1;
>     else
>         link_id = arvif->link_id;
> 
> When arvif->link_id equals 15 and the else branch is taken, link_id is
> set to 15.
> 
> This patch adds a bounds check to ensure that link_id does not exceed

See
<https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes>
and specifically:
<quote>
Describe your changes in imperative mood, e.g. “make xyzzy do frotz” instead
of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to do frotz”, as
if you are giving orders to the codebase to change its behaviour.
</quote>

So this should start: "Add a bounds check...

> the valid range of the vif->link_conf array. If the check fails, a
> warning is logged, and the function returns an error code (-EINVAL).

again use imperative mood (log a warning, return an error)

> 

Prior to the SOB you should at least have two other tags:
Fixes: <refer to the patch that introduced the bug>
Closes: <the public url of the coverity report>

> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 129607ac6c1a..c19b10e66f4a 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -7725,6 +7725,12 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
>  	else
>  		link_id = arvif->link_id;
>  
> +	if (link_id >= ARRAY_SIZE(vif->link_conf)) {
> +		ath12k_warn(ar->ab, "link_id %u exceeds max valid links for vif %pM\n",
> +			    link_id, vif->addr);
> +		return -EINVAL;
> +	}
> +
>  	link_conf = wiphy_dereference(hw->wiphy, vif->link_conf[link_id]);
>  	if (!link_conf) {
>  		ath12k_warn(ar->ab, "unable to access bss link conf in vdev create for vif %pM link %u\n",


