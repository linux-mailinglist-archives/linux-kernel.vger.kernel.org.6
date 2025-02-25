Return-Path: <linux-kernel+bounces-531739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F88BA4444F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570D017418E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D367226E62F;
	Tue, 25 Feb 2025 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="i6CM1f7C"
Received: from ci74p00im-qukt09082501.me.com (ci74p00im-qukt09082501.me.com [17.57.156.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2C26E624
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497160; cv=none; b=FYwWAAQ185AgZ26h4hyB8aZlVN//Z6lum0NDAgoHO0GbtDqTyvb9AzguaH5FQC91P3uzaxE5HHyM250VpaO7KlaOe2PIIvvvE/gogjMOZQ7QNNS0XwG2BOlzOadPjoSwzxmURw9XbeEkcaDNpdZ0FwGKETYrqoPx22tZQDV6R4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497160; c=relaxed/simple;
	bh=KLXVLS/xU4hxsPlFm59a4PAwo4LYu7uFun0ESUdBPz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kcsdqc5g1VGd1ef/l2sEhRU/N/Cqxz/QZxKu5T+F9c+69kFZJyBRuiaWASvJ1Y4LlGNi+gbSjR9oCRueyvCLvGDD26m/GD2WQsNguL6Gj9ipMq4Hm/z8q6NBrSI0gwfg2SJUn2t6DrzBPi54JO5VOdzhwBJ3GeEUhfX2jnAL2uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=i6CM1f7C; arc=none smtp.client-ip=17.57.156.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=KLXVLS/xU4hxsPlFm59a4PAwo4LYu7uFun0ESUdBPz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=i6CM1f7CdRYAS2msIKYrMwj1Jw4MFdOt4XXiwIr/I+U4fjVBdF5Rdjr3JpymHhV31
	 oimzmLYFU/uX06Dzsf67TyGefd0gmbncfwuK2xDqlGxa5fFPm5naaEP6m1oDyPM8zU
	 VcZbgeHpmmhBV5zRFi9KAmzgbHZyumAjNzHmeyhsVKmUy9tyvOC4ryGFUnwOZ554P3
	 TNuWdvgcYdgnzh3htg+61LLNuEB1yA3U/UQspeIcDSedRUkhcbY2XFF5p+vpvy7z6C
	 VnsRcbxivhH5UP4fdqKGV15mR05FAoH/mNJIMnB981JEdJNc2MNcKUhFp7mplpREjv
	 gMSb0aDAf/YJQ==
Received: from [192.168.1.26] (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09082501.me.com (Postfix) with ESMTPSA id D486C4AA01E3;
	Tue, 25 Feb 2025 15:25:54 +0000 (UTC)
Message-ID: <8c51e02c-c262-4db8-b0fe-30462005f1c5@icloud.com>
Date: Tue, 25 Feb 2025 23:25:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] of: Do not change property state under
 __of_add_property() failure
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
 <20250224-of_bugfix-v1-4-03640ae8c3a6@quicinc.com>
 <20250225144108.GB2279028-robh@kernel.org>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250225144108.GB2279028-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LYKRc1L5sPXYhq8OytkK3Uyp_dVSRYSG
X-Proofpoint-ORIG-GUID: LYKRc1L5sPXYhq8OytkK3Uyp_dVSRYSG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=698 clxscore=1015
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502250102

On 2025/2/25 22:41, Rob Herring wrote:
> On Mon, Feb 24, 2025 at 10:28:00PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Do not remove the property from list @np->deadprops if
>> __of_add_property() encounters -EEXIST failure.
> A property can never be on both np->deadprops and np->props.

i made this patch based on convention that

partial task which has been done successfully needs to be undid if fails
to do the remaining task.

It is okay to drop this patch based on condition you mentioned.
thank you. (^^)(^^)

