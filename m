Return-Path: <linux-kernel+bounces-218877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E16F290C74A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ACE41F2257B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AF11ABCBE;
	Tue, 18 Jun 2024 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="vktNN5k5"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AA314EC7A;
	Tue, 18 Jun 2024 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700272; cv=none; b=Z8G8/J+LzltSqlJa0+ju6DTODCBgaUvoBYVMqz8IJMvcxhQuCYSdReo/H051OVrfJ3FzFb+s5pqjg8MJB3RnBCOvsE9JG5mwEmeDGdvfK5N1DFS5Cb6C36MYY5RW4NbLD9xFdPB9vJW2hgrdFPpbwNHJ0PDfoH+lnpZyb4lFMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700272; c=relaxed/simple;
	bh=jMR0gFv9hBm3u/vA/bGzR+PkXpS7rjMgSQgoCQ0LJbM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4Ak7GtdAuEG0tf3027PD2dA9zqmHVHP+qOR8vBI0Ypcj1PxieW1aVprF6dFOIQJasplk6rNbvLLSOq55cLC16olLVi3p1zKplKGnR/260pg0vN1oYtY7IFFCJyUCoVphyyUe5L4H9w7lfIjUWJvaTP+GgPYzM0h3LefFa98LPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=vktNN5k5; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1718700259;
	bh=/Y5G1BXz2YebgSdUldA8kxYpuyKsbcP7FFNglutT/SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vktNN5k5JA5A3yXlM2LxgM2YWFRpnlxW+X1VShQAr4ZF0Xa8dTaoBMjnROdrNMHzC
	 m+8ZT3m6Af9rL4aLCf2zXs6mIFa9tIizG1i7PEgVrcvMeMHpxNFE+hj++v/SBlylC8
	 2DUWK+w1laRPshApkWwHjL02azvFbKrRF/20U3u4=
Received: from localhost.localdomain ([203.119.160.30])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id B113928D; Tue, 18 Jun 2024 16:44:17 +0800
X-QQ-mid: xmsmtpt1718700257tn1efp5vg
Message-ID: <tencent_262FCAE8F01C8D0582A45600851988585806@qq.com>
X-QQ-XMAILINFO: MMwjR1C73eIsR+PAilWFYH7hJbQDs/WJHnebf9M/mVdVaQZhW/Gnh+yWa00w1T
	 pV2lUxkvS5iK+8I+eEKtoR9kcX3fNXyYUoLKmBltXkyA1G6E6muezr9KYkyUKzL9O58w6z9Dhtxp
	 c1jcyiCkSgNX4LYOdblqzEzRs7AL6PndvEkYQpOqFu+JqoVaga3Bj67jI1DK9T5VCP4l42C4mPTF
	 lf9A+jQeBOUtM3vWR5EeZJbC9IYOmKvgqFnAWAZZj7m52KquNxJTutfnkHRv0KKsmO/CDaVXTKLM
	 etMEA2CZzVp93lBlpy/hNgfwT9CG0WXeD0kfpLNoqvUxwPjvsLnlYMSZo6k6t7GG33W08xxAuvOb
	 KdwrNKqAz+K99oAl1PX7FbFc/iM98ClJvbriBBU13QTUxYH/He87KUqyeUbPG08NT7xH7x/KeCKs
	 1i4T5Dvk/dRJe8uh+vmOMbr8kNcSt10RWX+Rg8vETKjpra/VWuUE+7smrgKGJKZblCkhJTLJdrqR
	 Ms/7IkhgE6ijchRehWfdCUE8P1fDUSoOezGS9NgERA/jnKGaNakRhETJIU4FcYdmIOUW7KPhJjm9
	 QZOk/munHlHOOI/8A8McQVxzE51isNyDFTsOUGBHh7AvJb86oX4F9wsPb2yBx0CxvSkMNAez6mWX
	 YvSekEjfEcrCsYl1KwWw3qkR35rvbaWrDYFavf98pxt5hpaZ+UXI6IrqK3Uub3VT9H5qbACMHVdr
	 bMq75c5eJEx+lF4I5QEtf8HZeuaEZP/lo0x43yoJF0MthcFOoGYl9ZBZ8SyfNPlF1mwj6wRC1z7/
	 qLAB8F5saD/vMoHHpKkOK670vm6i3/hzH6V1PAMEYAW8BLg2gAlWFQfCOSDBKBVE3hiUu1IUkZJp
	 yCIrwxxyBnU0G08LLBbJgYkiRnxxFXnQ8XYisa3sNWHjaDhG49G/6EQDDjuA3gYVXFW6X3NQiaa4
	 xECtoDUK1WmrOU4hq4r+eWkHv49qs2F7n0ORSFQJ2vNSLwZLBXK2p+6XPva3gX0+h/bYEsIuQUMC
	 1MdHr+dRRKzVQGwM5hU2R/kzXl1/89/+7fZcNGhOGpcukT6GbB4JtGX78hsftSqaThbDFwIuU9ho
	 D6RvB/YvNwubmGVB6Skcx0VtEyrPpclLPmampB
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Tao Zou <wodemia@foxmail.com>
To: siyanteng@loongson.cn
Cc: alexs@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wodemia@foxmail.com,
	wodemia@linux.alibaba.com
Subject: Re: [PATCH V1 RESEND 1/1] zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst translation document
Date: Tue, 18 Jun 2024 16:44:16 +0800
X-OQ-MSGID: <20240618084416.5077-1-wodemia@foxmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <d9ee8cc2-8fd9-4a99-9673-b3a56187df95@loongson.cn>
References: <d9ee8cc2-8fd9-4a99-9673-b3a56187df95@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Yanteng Si. Thanks for your suggestion.

On Tue, 18 Jun 2024 12:01:33 +0800 Yanteng Si wrote:
>在 2024/6/18 10:47, wodemia@foxmail.com 写道:
>> From: Tao Zou <wodemia@linux.alibaba.com>
>>
>> Add translation zh_CN/admin-guide/numastat.rst and link it to
>> zh_CN/admin-guide/index.rst while clean its todo entry.
>>
>> Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
>> ---
>>
>> I apologize, the previous PATCH had an incorrect email address for linux-doc when it was sent, so I need to resend it.
>>   
>>   .../translations/zh_CN/admin-guide/index.rst  |  2 +-
>>   .../zh_CN/admin-guide/numastat.rst            | 50 +++++++++++++++++++
>>   2 files changed, 51 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/translations/zh_CN/admin-guide/numastat.rst
>>
>> diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
>> index ac2960da33e6..0db80ab830a0 100644
>> --- a/Documentation/translations/zh_CN/admin-guide/index.rst
>> +++ b/Documentation/translations/zh_CN/admin-guide/index.rst
>> @@ -68,6 +68,7 @@ Todolist:
>>      cpu-load
>>      cputopology
>>      lockup-watchdogs
>> +   numastat
>>      unicode
>>      sysrq
>>      mm/index
>> @@ -109,7 +110,6 @@ Todolist:
>>   *   module-signing
>>   *   mono
>>   *   namespaces/index
>> -*   numastat
>>   *   parport
>>   *   perf-security
>>   *   pm/index
>> diff --git a/Documentation/translations/zh_CN/admin-guide/numastat.rst b/Documentation/translations/zh_CN/admin-guide/numastat.rst
>> new file mode 100644
>> index 000000000000..4f7fee557cb5
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/admin-guide/numastat.rst
>> @@ -0,0 +1,50 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. include:: ../disclaimer-zh_CN.rst
>> +
>> +:Original: Documentation/admin-guide/numastat.rst
>> +:Translator: Tao Zou <wodemia@linux.alibaba.com>
>> +
>> +.. _cn_numastat:
>Drop it, because it introduces a warning.
I'm not quite sure which lines should be dropped, as you've mentioned several. Could you give me more details of the warning?
>> +
>> +
>> +===============================
>> +Numa策略命中/未命中统计
>> +===============================
>  Drop unnecessary "=".
>
>one English char,  one "="
>
>one Chinese char, two "="
Get it. I will fix it in PATCH v2.


