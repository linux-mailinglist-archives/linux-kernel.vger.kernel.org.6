Return-Path: <linux-kernel+bounces-446398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CC79F23DB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC5D18857EB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDF01865FA;
	Sun, 15 Dec 2024 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BnvyI0/7"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380C1FDD
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734266519; cv=none; b=TQD+Q938PRfiXYvvBMPJahScRKuGKbeXHdgMKqoXbeR1KS4objU4j/zDqeHJQmJlCzNItrfUSgBcQoQd9OaS/5PJ54UcZQrfhYGr3C5ft4x87EaZeHe4TNOYiVJ1i6ByMLEEdcFxn2EGC2nzEiwKdCu3XIv/Dl3TL1uM7T9Teqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734266519; c=relaxed/simple;
	bh=XMgd+0SviFVvGOF1hJpaA/pslD7kLv6N2aBXBwHt0Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2AxO47fwvSdrcqgu1EsVVviKQdKS6fdLvBxdAJ7KTLfhJdAZ97jaYIerDI2BW08iqBYJh7l4BpNZiJTAFvaXsu0fv+sp4LMVWp78mQU3ETkNTk3G5afhNfvQoDvnzLGw4biF1HSK2XvDoTjirwOIuT+7kFKnPIUK8DDoNW7Xwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BnvyI0/7; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C32DD3F370
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1734266506;
	bh=O8gwc23Rba0ok9YyJcuiOZa8A+poL49m/lgY/i9LXGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=BnvyI0/7UXCz2YCXnd23IYTI0UuSVZ7DUqEE5ybUlbctv7IGYu8OR+0rE9ja6dKTW
	 6LiVsNp5qhKCyggaNVJ1GiMfA3BgUb2Pn+p1nJKu9FxD7g/HVN0jIitMTgqrR05DxF
	 fRJyi8z6tHlC/3/GHXpf6mXmt8RHujxpAkecNOm8gQs4vZ/bZBw/w510pu3DWySqyZ
	 Ei11pI06u+WxJzPq9ycW/xX1RTtICmIZtAPUeZ2zxTZU8Y4DOyHgp1Ovhus2dlTOjQ
	 yttYj+vlGrxyGcn3PU4gqF95lrnsITPuRiLTvmQohWFR0WxUOiu0lx2J1D+4H+6Hcz
	 os8DjhG5jhllg==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361d4e8359so7066045e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:41:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734266506; x=1734871306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8gwc23Rba0ok9YyJcuiOZa8A+poL49m/lgY/i9LXGo=;
        b=Q0pf/WiVRDF8ymaOpStaTw3R12yFRVnpyHI/cYc43mEvvC1zMGNt3rhE4sGvvCdM85
         7ecGZ6LVguslYEbyd7kWc6n8v5fzs8HG5dLNCG+leT3/ygLdqNZw9+hs+EhcstHj8JnL
         iNNXBjwbRcHiOTta/4MevAzepNupJjCJb1GXH2IdE8ZDJoKkgfXqeQSMqx5sbvS0cubd
         U8wlI52pFe5Kt9NptR0fK+Yqr/oApzSftM3ejoicNmq/0kFASHFlcHYDzB/HAK48FxM5
         xe5jLqrzUEMIthcplfHmp3gW7Z/SnZUAdvWLZqvhBLzKmhuSWSFXT+lhqeExB2pT9tLi
         XSVA==
X-Forwarded-Encrypted: i=1; AJvYcCWI6J+MkBEByRjc6qRruBAbacQLA0E05B1b8Mg+lvvsN0ZCyL46954WlUw9vpnWa5oinqcpn7ABZCUYu0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSlOZD3tbZYTdqKgjxLKtyU6q1v7mEljAlPb1jRWVwTjvrqu9C
	wUkcU3Vzy/iYkLjg+3Qfk5BloLyxce9z6ekUnqDPzUjiil08dceEEBhtcLpLnyxGhB243pVGDmb
	R0NkZGtdM1iUH6HP3ZqRnMeZJuuEh5kbi1l1980EG6Gk8qWIeBTxMxJTpoqqpCKYM2hgFHkZr7a
	tipQ==
X-Gm-Gg: ASbGncuLTLQvDQry9gx56Gvi0lA6JMuuVr6W8H5hQOn34RenBXiKvAf5ajK5QRu9kfb
	7DDwcxjBUFZkHjXAzyX8ETiqD5GifS6s0u2q8BhN7p/j0OZNqrniOXOWQv/OYwjRt6J74bsExaC
	Q8wB98FbuaYV82DJpAJkogqzR/LPP8yG8+rlwXLDF5GsBhPiGHelAq5JxdnNuMV0g3MGQEHLVs6
	0dFf0Qmx0LL55bbgRyiSMKa+YTVk8It2dIDXVO2tNND4MrzUTWho0a8zEzb5IlIsjFFBdKiDO17
	8n0DWiLpLhV/sezL6o76/uC0+KtnUqD+69G9h9zosSJlhZTQraEbvg==
X-Received: by 2002:a05:6000:1a8b:b0:385:e5d8:2bea with SMTP id ffacd0b85a97d-3888dcd4a0emr7332077f8f.20.1734266506174;
        Sun, 15 Dec 2024 04:41:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPfOmhvJY7mwJvWXysLiYHswpVMECmy8rDdV2wJ9R3j03ilLd/nj7ngTDD8Up4EIzUXPkMMg==
X-Received: by 2002:a05:6000:1a8b:b0:385:e5d8:2bea with SMTP id ffacd0b85a97d-3888dcd4a0emr7332062f8f.20.1734266505657;
        Sun, 15 Dec 2024 04:41:45 -0800 (PST)
Received: from [192.168.123.161] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c806b84esm5127161f8f.108.2024.12.15.04.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 04:41:44 -0800 (PST)
Message-ID: <59832da1-34a6-42be-ba85-e86d05b9d29b@canonical.com>
Date: Sun, 15 Dec 2024 13:41:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] scripts/spelling.txt: add GPL-2.0+
To: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Colin Ian King <colin.i.king@gmail.com>, Yu Jiaoliang
 <yujiaoliang@vivo.com>, WangYuli <wangyuli@uniontech.com>,
 linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>
References: <20241215025104.70096-1-heinrich.schuchardt@canonical.com>
 <031e2929d88843c2fa913ed7f3ee2abbe041a68a.camel@perches.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <031e2929d88843c2fa913ed7f3ee2abbe041a68a.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/24 11:51, Joe Perches wrote:
> On Sun, 2024-12-15 at 03:51 +0100, Heinrich Schuchardt wrote:
>> The correct SPDX identifier for the 'GNU General Public License v2.0 or
>> later' is GPL-2.0-or-later.
> 
> I think this unnecessary as there's a separate script
> to check the appropriate SPDX uses treewide and there
> isn't a single existing use of "gpl-2.0+' in the tree.

Hello Joe,

In next-20241213 I find 5143 occurrences with

git grep -ni 'gpl-2\.0+' | wc -l

e.g.

Documentation/bpf/prog_lsm.rst:1:.. SPDX-License-Identifier: GPL-2.0+
drivers/ata/sata_rcar.c:1:// SPDX-License-Identifier: GPL-2.0+

Some additions are quite recent:

$ git diff HEAD~100 | grep -i 'gpl-2\.0+' | wc -l
63

Best regards

Heinrich

> 
> 
>>
>> Checkpatch.pl uses the misspelled words from spelling.txt both as keys of a
>> hash and as part of a regular expression. For usage in the regular
>> expression special characters like the plus sign need to be escaped.
>>
>> Heinrich Schuchardt (2):
>>    checkpatch: allow special characters in spelling.txt
>>    scripts/spelling.txt: add GPL-2.0+
>>
>>   scripts/checkpatch.pl | 2 +-
>>   scripts/spelling.txt  | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
> 


