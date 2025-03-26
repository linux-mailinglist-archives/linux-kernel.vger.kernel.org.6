Return-Path: <linux-kernel+bounces-576737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A6A713C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FB4188A926
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A501A5B87;
	Wed, 26 Mar 2025 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uNVAsDJc"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16692F42
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981671; cv=none; b=AiFaujwhRk6L1C+Q9SR1KDOBf7QoqTbXfivmw86Z3koAXY5fd+7fX45WcD9tL47jR9I+h0vF5RTuaw1vG5ktzm8vxav6ElCn35pFimSZ8kh4+6S0jV4jNPYq692UBvo+yVQAa3XjcsfIu1SFWW1O/vQzzU++VHaC482byxrnpao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981671; c=relaxed/simple;
	bh=D1el1+woypl9ybF4Ctc0EtHo/9YYhsdoHElH429jTeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oh+s0E/JNLs4knx5+VGAgFqiLZHW3yG7gYgMWs9DazUd5NZEpHwBG1VSgxS00eqfBoZFkSnAq/gI7+AtG9e+U96G2MOv1LHpzNUEsv0Z2ANyZwU5RprEZjLkH6ISqZgfor5W2tIZH6+rGNRSA8RGKg7abP0DQHA65T47fazIyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uNVAsDJc; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7c278ba6-c1a2-4ef7-a4ac-48c233dce7a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742981657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wr6tnvD8lFLw5Hhe4KOCwyG97x90AeveFDRL5dwX+XA=;
	b=uNVAsDJcZaCcBUTgirGJJBspvcP0Ni2j7Gv7hYYGAKHK6/RwHtH74SFnnjE0+1DDVZwY++
	JcKlTG0lvs+lKK6f2fkCFrJ/CX7g0ODceEkrCXO84B2H+ELP0nlbXINTcTc/zqUi5Z2JHB
	9TO7g8yp+a+kwyVWDLmnOkLBq8G2DQE=
Date: Wed, 26 Mar 2025 17:34:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] mm/page_alloc: Consolidate unlikely handling in
 page_expected_state
To: Markus Elfring <Markus.Elfring@web.de>, Ye Liu <liuye@kylinos.cn>,
 linux-mm@kvack.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>
References: <20250326011752.917564-1-ye.liu@linux.dev>
 <0ceb4ab8-adb5-46bf-98e4-61a1bd908e20@web.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <0ceb4ab8-adb5-46bf-98e4-61a1bd908e20@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/3/26 16:48, Markus Elfring 写道:
>> Consolidates the handling of
> …
>> This change simplifies
> …
>> ---
>> V3: Delete 'This patch'.
> How good does such information fit to the wording requirement “imperative mood”?
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14#n94

How about this?

Consolidate the handling of unlikely conditions in the page_expected_state
function to reduce code duplication and improve readability.

Move the logic for handling __PG_HWPOISON flags from the check_new_page_bad
function to the page_expected_state function, and remove check_new_page_bad.

Call bad_page directly from the check_new_page function if the page has
unexpected flags.
                                                                            
Simplify the code by reducing the number of functions and centralizing the
handling of unlikely conditions.

> …
>> ---
>> ---
>>  mm/page_alloc.c | 24 ++++++++----------------
> How do you think about to omit redundant marker lines?

---  delete this one？
---
 mm/page_alloc.c | 24 ++++++++----------------


like this ?

V2: return true instead of false in the PageHWPoison branch.
---
 mm/page_alloc.c | 24 ++++++++----------------


Thanks for pointing out the formatting issue.
I would like to get your approval on the above changes before I send patch v4.


> Regards,
> Markus

