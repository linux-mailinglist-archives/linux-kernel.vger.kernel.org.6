Return-Path: <linux-kernel+bounces-178424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78D08C4D71
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154B41C20F61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB0F1B7FD;
	Tue, 14 May 2024 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RG06WhbQ"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFF1125A9
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715673870; cv=none; b=XfCw5xyKiRZJ+TanNHLST5mOLXJx1Rvc8xKS4qkDvr39rLQ1sGEnB5dk213OOK1NwFFlb4LecmXKAwQPy5IujrJ4UX2juTkg+Ifgv5K11cj8RmIA8PWeepaDbpilZJxmTks0me9JrQWAPTG6OvCz23awN2eaeR3aghw2VXByhHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715673870; c=relaxed/simple;
	bh=wLm0Vj2eXCxBqcyOp4WaiFBvPsGqeQBJRznZMy7avE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DHt9hKMsi6qJS9XnefW5RYR9PdZydaPqiS5rUcthPpXQK/E5fpw1yPjgC8D5bIuNN9j3g9VS8t7k4CpszW0nba1DyjLt9l+Q+mEy/lOiuOpDHPLy+m7N9cgMm17wwrNSxkckfOK+kljOpyc5ClqxBTDstkP990R/WxrpS1ODnF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RG06WhbQ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LcoPi
	PQ2cDUD3ccUoUxr3vfIIU5y5RPZcbdajwyHnz0=; b=RG06WhbQC0xG44q2ERcuC
	kLGOl2gXC1yqM69A9+g8+n2ej7v/Qr1Utb5Nd4M99JL864bVd9aPT9/FTLLYFkH6
	sAbzLcJURcIahfkRARXHhhDmjOlIQPHjdNrjzruAzM32eOFYkf/CDOKv3bxHUDXo
	xPFSZGDS4jwVyHo0hlScEw=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wDnbyXAGkNmjzzvEQ--.15827S4;
	Tue, 14 May 2024 16:03:13 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: shy828301@gmail.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	xu.xin16@zte.com.cn,
	ziy@nvidia.com
Subject: Re:  [PATCH linux-next] mm/huge_memory: mark racy access on huge_anon_orders_always
Date: Tue, 14 May 2024 08:03:12 +0000
Message-Id: <20240514080312.661480-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHbLzkqg=+Dq40-He5ZBCnzrXEJaBUfXtb2jjBoDKERpM-C07w@mail.gmail.com>
References: <CAHbLzkqg=+Dq40-He5ZBCnzrXEJaBUfXtb2jjBoDKERpM-C07w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnbyXAGkNmjzzvEQ--.15827S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1kWr4DKr1xZF17tFykGrg_yoW8XF13pF
	97GF1xCa48Zr9IkrW2ya17AryrXrZxGa4Uur1Sg3ZFyasxtr1vvr18Z34ak3Z8Zr9Fya1S
	9Fy7Was5Can8XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3-BiUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbB0gTeTGWXxu8VaAAAsi

>>
>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>
>> huge_anon_orders_always and huge_anon_orders_always are accessed
>> lockless, it is better to use the READ_ONCE() wrapper.
>> This is not fixing any visible bug, hopefully this can cease some
>> KCSAN complains in the future.
>
> A little bit confused here. Did you see complaints from KCSAN?

Not yet.
The only written access to huge_anon_orders_always is when
changing the mTHP sysfs "enabled" knob, I think peple do not
change the mTHP settings frequently.
But the possibility is not zero, please refer to the cgroup related knobs,
I think  wde'd better do the same and this annotation wont lead to any performance issue, right?

>> Also do that for huge_anon_orders_madvise.
>>
>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> ---
>>  include/linux/huge_mm.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index de0c89105076..6573430ea600 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -122,8 +122,8 @@ static inline bool hugepage_flags_enabled(void)
>>          * So we don't need to look at huge_anon_orders_inherit.
>>          */
>>         return hugepage_global_enabled() ||
>> -              huge_anon_orders_always ||
>> -              huge_anon_orders_madvise;
>> +                       READ_ONCE(huge_anon_orders_always) ||
>> +                       READ_ONCE(huge_anon_orders_madvise);
>>  }
>>
>>  static inline int highest_order(unsigned long orders)


