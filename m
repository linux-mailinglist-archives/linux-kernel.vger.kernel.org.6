Return-Path: <linux-kernel+bounces-531960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB364A44713
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2838E162FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FD7206F05;
	Tue, 25 Feb 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZfWkPO2t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B48194091
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502079; cv=none; b=Z6oLHkLePuYlhiBhNQKAK91RUUiDuLeCPjyXg5sa2mBzg+x8L7lMG/dze5VC3nBPDhJUv4PwbL2NjYcRG4YmxhujHPk6/87Hs+I/7F5vbONYItsTlAAESLsLeBLuETEjU5UybTP476MtucpeZGiVFyrxQTUPzpd6vHLBBDplwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502079; c=relaxed/simple;
	bh=9ZDVrOfhGJwI3TSbSIuZAzkP2eTAltfjgpAh9EQGfog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6scJUq+Ez4x8MLIV4M/mbnf80f1b3t4CekN6l8GOJVDBOqCY/WQZ2anxQWNeHyYR6KGw712bftqapvx23hEr1s0si6C//jab5OZsCBXOUYlBub+4aPWorV8Ky1akmGsi+tbIFGKwo9oHn/w6MPmjNJKsiwO3HNChml/qa6J4eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZfWkPO2t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8aCHX010037
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9ZDVrOfhGJwI3TSbSIuZAzkP2eTAltfjgpAh9EQGfog=; b=ZfWkPO2te79Al0Cq
	Gs1OU6yTBTQU5uA7j3wIsU90Kk2jGp6AZ7IzjJApkcIqnbN5SiRyC5qvu4OYr8aC
	lJFBPhX1iwt95jgOhxkUARQGua9ofW1i/NltO9BLxUvOLflUGGHhG0XR1m6wEM0b
	p43ovatiNfszES1CMRavudjkHgYi5SOL2+qTZEFOUgPmBAx+/ryNDGWcavTsxexe
	Ez8Nj4VOaroLWQZLhQfiwjuxLbVowtqe8hwqmYm5bCHEusWhtMocUvow/AzBJ++y
	5GTDImaA1YybpbJfVJI89mIUe7DQABX6SurWTDoixYpeCv/YwQypoXsDHRVo9Yd5
	rAQyVw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y3xnhrhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:47:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso19251268a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502075; x=1741106875;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZDVrOfhGJwI3TSbSIuZAzkP2eTAltfjgpAh9EQGfog=;
        b=ejJUyuS6z4YhPg1mcy1UesKjGxKwC+C/SQi/lP5amjQNA8GLnCdpcxv5GODqKo2PAL
         QMFtHtimeM5jYi5NSChoI5OIAYoZsg7bMiACCAlr33YxQV0wAv3IelUCI7k0bwCBBmGy
         0PTAKzmFFZvPg5EJNDr9bL37nilcJYy5zglILy+UejR6P5qmmLIPT+A9Nh5qNu8Tx7eY
         GT2ngVeYQ1wMH4cQOghjJv7K9MB1OWHmhmeH5TpvzHt+rWaI7L6trrZoJsh9Fv2eRWrs
         YY51Fnr/tW82QOncMIEEhqa3sws+aF938+0mAQz/gkDB/RFnH30BiWfOPr4N9HGb5yWg
         UZ+A==
X-Forwarded-Encrypted: i=1; AJvYcCXbVlMgVl0xvRG8hRBkYF8ccPHhutn2x2sYbSu0zseOO1ysgZ4iM8Htf+pgKNWNrNcMCj7vWz37HlR5vD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDU01Xre9Vw5aFqnY4rY1EKx7ZYPNSY6+dAJIITSD/7hPWsskf
	uDbx6zCsmd1CiejQBSCmbJifdRVHxdcImBvMGzFE33r7jeaX7J5jb89VOaM/w/zxIU+9xUsVXBt
	Jbw1lnNWWIYVd7aVUnYUIuPCjROMU8B0hibAsn4g8wkxRKhdMA1L4RIRRTV5y8yQ=
X-Gm-Gg: ASbGncvke1fNatlQ2wkr6xNQMFoWpYkpcPXEfn/pO9tl4XSmODE4g4MjgsfnpON66D5
	uXY4wYqYSgiQARkS8laPxC6smGT9Pez3lSd2vZTHkWYe5yfGE4TRSKpCnOGW0/9rUibHj455hd7
	aFAwsRS3B5OjeFR+61ybr9hiaKMCp2EQg+k0X2crcFiY9G9Iq2/jHJNx0OsTl3QPKsBD07Y+57T
	OyVEX0yjOnhu3QrpoD0JG6Wy1veer++PtD7uqtg8mM/g4EjtQKQtDdhrE9zjdZHus5cpPL6FUgy
	3fxFtnPXx5VVYUI4hXpau5vBCvdXx0N+kRMmmu4VQJ0XLYO+FV28X8cRVjWqFBqp/O92inI=
X-Received: by 2002:a05:6a20:840d:b0:1f0:e547:2a95 with SMTP id adf61e73a8af0-1f0fc77fbc4mr7690921637.31.1740502075597;
        Tue, 25 Feb 2025 08:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdPfLWKKNqt+lqaJWqGpH+fK0ZqBAaMQEednaibGK9nTCW7SkhcF0zLldZAyJp0Yf7PYgmjA==
X-Received: by 2002:a05:6a20:840d:b0:1f0:e547:2a95 with SMTP id adf61e73a8af0-1f0fc77fbc4mr7690858637.31.1740502075031;
        Tue, 25 Feb 2025 08:47:55 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aeda79a23dfsm1367185a12.21.2025.02.25.08.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:47:54 -0800 (PST)
Message-ID: <c2b540d6-a30d-44e2-b928-4e95a78d9d6c@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 08:47:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] wifi: ath11k: Clear affinity hint before calling
 ath11k_pcic_free_irq() in error path
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
References: <20250225053447.16824-1-manivannan.sadhasivam@linaro.org>
 <20250225053447.16824-2-manivannan.sadhasivam@linaro.org>
 <4dc9e860-7417-480f-ba89-439498138d3f@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4dc9e860-7417-480f-ba89-439498138d3f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2V84YFCkdH3xEKkpyvBtbMBbg5IawtnY
X-Proofpoint-GUID: 2V84YFCkdH3xEKkpyvBtbMBbg5IawtnY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_05,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=765 bulkscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502250107

On 2/24/2025 11:23 PM, Baochen Qiang wrote:
> LGTM

Suggest you reply with an official Reviewed-by: tag
This helps build your reputation.



