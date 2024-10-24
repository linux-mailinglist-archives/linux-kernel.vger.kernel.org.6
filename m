Return-Path: <linux-kernel+bounces-380679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB959AF473
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576A91F21ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5B5218313;
	Thu, 24 Oct 2024 21:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bIpaRoNW"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E833E2178EF;
	Thu, 24 Oct 2024 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804159; cv=none; b=pxEdn7QOH/qkxvDRbrXTmrwB0BGSYDpj0wd7+3EYeoWS84+VsNgMcKzky8vAJy8S+tVMfYD+5L0kMKh+4pXRUaSb8LZm08pS/XxLqWm0iOjji56LW0cQZHNXTe5kbCby7HIuNy2FZqR6+JCDIP5tff3Js9H72yJHm+unE6+STS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804159; c=relaxed/simple;
	bh=E1k+OYFRxEGzTKutfTAaZoS1gBw8S7mKx8X/6YriDGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sh0aziDgrBgGVYpX7HC8QJJShW+Wxgf4vol5uv5cQ6LJXK9pFVBt9uoOBlboprwp6MbNJFvp0lwzuN/g9hkJlKxlruoEOErWE0AHYFDTjZC/yhIknDktzaQKU8KUjIz/JfaQcHYH5tTZ4gxmgMQ6PFPhpcXATTd8LpdCF14teqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bIpaRoNW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 197EF42C0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729804157; bh=N2hLec15zsgFvOqirzafzwOABFgkFT3/q5DEGpdFCMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bIpaRoNWGyg7uUJrdxCzNKnCUbmf1eRpGxZOUP85zp5l1Mc59i0FJxzWOBbtNeTgI
	 2rXnjKjVW8sCZY439qzgNvsgRqW6/AR/KLNIeknRDvhVPIhsX8TcqLiL3gbkE5QBdW
	 1GcmlsDewU/NBuTBYX0auHF0EtAWyjyc727bjs8O/E+QAw4lz+NXiDfsEjdrdaPwUy
	 wXPTqIKnwZXuFjsYE+Enka1OoOZZ19ysrNS5l9Y5TUqwUR2ifPmcYlag1j8dKBt4lm
	 OwxQ0FmfYech3ZFnehjglyA7SYamH2eu/O4IxhlzhYMlnJtsuITxPnaSt92A8nGhh2
	 CMlP589Bxh0QA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 197EF42C0D;
	Thu, 24 Oct 2024 21:09:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: xu.xin16@zte.com.cn, alexs@kernel.org, si.yanteng@linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mudongliangabcd@gmail.com, seakeel@gmail.com
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn
Subject: Re: [PATCH llinux-next v7] Docs/zh_CN: Translate
 physical_memory.rst to Simplified Chinese
In-Reply-To: <871q05465w.fsf@trenco.lwn.net>
References: <20241022095925304e1j2evmIRbZsiE0RDUFrA@zte.com.cn>
 <871q05465w.fsf@trenco.lwn.net>
Date: Thu, 24 Oct 2024 15:09:15 -0600
Message-ID: <87sesl2op0.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

> <xu.xin16@zte.com.cn> writes:
>
>> From: Yaxin Wang <wang.yaxin@zte.com.cn>
>>
>> This patch translates the "physical_memory.rst" document into
>> Simplified Chinese to improve accessibility for Chinese-speaking
>> developers and users.
>>
>> The translation was done with attention to technical accuracy
>> and readability, ensuring that the document remains informative
>> and useful in its translated form.
>>
>> Update to commit 7332f9e45d2e("docs/mm: Physical Memory: Fix grammar")
>>
>> Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>
>> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
>> Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
>> ---
>> v6->v7:
>> Thanks,  Some fixes according to:
>> https://lore.kernel.org/all/c95075bc-187b-4d38-b9bc-2f19f29a2231@gmail.com/
>> 1.retry 'git format-patch' to ensure the patches can be successfully applied by 'git am'
>>
>>  Documentation/translations/zh_CN/mm/index.rst |   1 +
>>  .../translations/zh_CN/mm/physical_memory.rst | 354 ++++++++++++++++++
>>  2 files changed, 355 insertions(+)
>>  create mode 100644 Documentation/translations/zh_CN/mm/physical_memory.rst
>
> Applied (after a bit of work since it didn't apply directly to
> docs-next), thanks,

I ended up taking this one out again, due to the following warnings?

Documentation/translations/zh_CN/mm/physical_memory.rst:131: WARNING: duplicate label nodes, other
instance in /home/corbet/kernel/Documentation/mm/physical_memory.rst
Documentation/translations/zh_CN/mm/physical_memory.rst:325: WARNING: duplicate label zones, other
instance in /home/corbet/kernel/Documentation/mm/physical_memory.rst
Documentation/translations/zh_CN/mm/physical_memory.rst:334: WARNING: duplicate label pages, other
instance in /home/corbet/kernel/Documentation/mm/physical_memory.rst
Documentation/translations/zh_CN/mm/physical_memory.rst:350: WARNING: duplicate label
initialization, other instance in /home/corbet/kernel/Documentation/mm/physical_memory.rst

Please ensure that your changes do not introduce build warnings before
posting them.

jon

