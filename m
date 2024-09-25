Return-Path: <linux-kernel+bounces-339206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB42986162
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CCDA1C268DD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990681922EB;
	Wed, 25 Sep 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vbzz3VYh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VLTgCShX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vbzz3VYh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VLTgCShX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605371B5EB9
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273416; cv=none; b=KOx91gkRGNQ9MXbRWuAvxt2Z9iHoIFSE/8MFQg4j58gjjORljXn8iTZOKGikjFjaHuQkF7/x0kp4z+BDXP2C6miZyz+M6FTHD4SxAKKylHI1gVkACZYz+3JUu7Up9b2P3XdRcEJbFPIjJL864Mfw4l+GEmQ4bvj3ebged3nyhVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273416; c=relaxed/simple;
	bh=wFxl3khxI/dkkwJaFNojbJobUEHJlEFvJc44KTjwbU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F3r5XCEHyfssOwWNHZdqL4bwBJiAGc/h720QtEW1LFyNzj98r+QhpXkVq3Ch/y5Dx71UY6r9/F1mH4MPFvUpQ08Wc8QRhglI2iOyfyxOpy0GdMGF2Uzuf3bnX8sOyfs2k1z5Iegu7lHHp/QSVz5+5v3jaU0UaNv1yWr7o2/zM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vbzz3VYh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VLTgCShX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vbzz3VYh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VLTgCShX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out2.suse.de (Postfix) with ESMTP id 057681FD56;
	Wed, 25 Sep 2024 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727273409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQXEWldAB6xaGZH6C2X1lgYW1//ghAx2k+LKF41iwao=;
	b=vbzz3VYhrbDtytL1wqCyg0vtAyAd2YeMTT762AnBwGngo1nKeskqfyEGqSPvzOwMCyxave
	uxXbEqY5RnR/MkA8ILTwNTxd9/JI/z3/EzLGFwsbR15Mo7s4hQrtyaTygwPd6OdmCZE9at
	zBWtnSUxSCbvTpD59wuNDqbHSQuzt78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727273409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQXEWldAB6xaGZH6C2X1lgYW1//ghAx2k+LKF41iwao=;
	b=VLTgCShXNnNi+/2XV9kM0DA0tXN4A2hL5ic2JLqdf8lAITaNWcoMMcM1v9oAw8ulzz1TC4
	2Rkv3RZQ8FIuvJAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727273409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQXEWldAB6xaGZH6C2X1lgYW1//ghAx2k+LKF41iwao=;
	b=vbzz3VYhrbDtytL1wqCyg0vtAyAd2YeMTT762AnBwGngo1nKeskqfyEGqSPvzOwMCyxave
	uxXbEqY5RnR/MkA8ILTwNTxd9/JI/z3/EzLGFwsbR15Mo7s4hQrtyaTygwPd6OdmCZE9at
	zBWtnSUxSCbvTpD59wuNDqbHSQuzt78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727273409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQXEWldAB6xaGZH6C2X1lgYW1//ghAx2k+LKF41iwao=;
	b=VLTgCShXNnNi+/2XV9kM0DA0tXN4A2hL5ic2JLqdf8lAITaNWcoMMcM1v9oAw8ulzz1TC4
	2Rkv3RZQ8FIuvJAQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 905914A04E6; Wed, 25 Sep 2024 16:10:08 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Xu Lu <luxu.kernel@bytedance.com>,  paul.walmsley@sifive.com,
  palmer@dabbelt.com,  aou@eecs.berkeley.edu,  andy.chiu@sifive.com,
  guoren@kernel.org,  christoph.muellner@vrull.eu,
  linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org,
  lihangjing@bytedance.com,  dengliang.1214@bytedance.com,
  xieyongji@bytedance.com,  chaiwen.cc@bytedance.com
Subject: Re: [PATCH v3 1/2] riscv: process: Introduce idle thread using
 Zawrs extension
In-Reply-To: <20240925-2acd8d9743cf40b999172b40@orel> (Andrew Jones's message
	of "Wed, 25 Sep 2024 15:54:28 +0200")
References: <20240925131547.42396-1-luxu.kernel@bytedance.com>
	<20240925131547.42396-2-luxu.kernel@bytedance.com>
	<20240925-2acd8d9743cf40b999172b40@orel>
X-Yow: On the road, ZIPPY is a pinhead without a purpose, but never
 without a POINT.
Date: Wed, 25 Sep 2024 16:10:08 +0200
Message-ID: <mvmbk0b7rjz.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.20
X-Spamd-Result: default: False [-4.20 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	RCVD_NO_TLS_LAST(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[from(RLajr16mudzow8bnf6sy)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sep 25 2024, Andrew Jones wrote:

> On Wed, Sep 25, 2024 at 09:15:46PM GMT, Xu Lu wrote:
>> @@ -148,6 +149,21 @@ static inline void wait_for_interrupt(void)
>>  	__asm__ __volatile__ ("wfi");
>>  }
>>  
>> +static inline void wrs_nto(unsigned long *addr)
>> +{
>> +	int val;
>> +
>> +	__asm__ __volatile__(
>> +#ifdef CONFIG_64BIT
>> +			"lr.d %[p], %[v]\n\t"
>> +#else
>> +			"lr.w %[p], %[v]\n\t"
>> +#endif
>
> val is always 32-bit since it's an int. We should always use lr.w.

Shouldn't val be unsigned long like the pointer that is being read?

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

