Return-Path: <linux-kernel+bounces-575209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3255EA6F44E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4174188E2BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975EF255E4E;
	Tue, 25 Mar 2025 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="J02vy1Xg"
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF6533EC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902469; cv=none; b=BaIfQYo62qwFZrZeab80+4j3tAqpcJQzh5MRLcnjcGY3AW870sXF2xl/PQ3q1f5OyZrGk3JAJ2b3zVy4FouzjHfpDY3aH8F9IfZ0x3BWIWW10aw/wDKtv42/74gGcRdxzprf5zC4oeXFjxYCkBZXb9Gj6mAIv+jBaR+YufhcH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902469; c=relaxed/simple;
	bh=Yi0B0sF+r/AuvcVYJs1obciOzUBlJcKKEICGR8m8w2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMRTG7Zck2/KW4DBEBcldw0RKkMDTbN9s2Cy+F0ylqbRRwr6NkN3dQCY0QiKu4ZC0Kddw6b8esimfp/aP5CyoH2gTodRgofrcbPJhK1R9HoyBPqNydjzwQLjyFxH27q9sNVj2ReWB/TUDL4QDbqNfdnzbQliQkyGFQ2G2n4el+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=J02vy1Xg; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:921:0:640:f23d:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id EE21E60D1F;
	Tue, 25 Mar 2025 14:34:15 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8011:f00:afdb:5d23:7134:f815] (unknown [2a02:6bf:8011:f00:afdb:5d23:7134:f815])
	by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 3YNdvv2FUiE0-JvUePvNB;
	Tue, 25 Mar 2025 14:34:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1742902455;
	bh=W3AKgrqGovGglDW8iVPyPNzvPb/KRUuV8EfjIyr+jgU=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=J02vy1XgcWAKKBa4dwDQB9FtfcNj7UD9/3PlnR3hY23rAuj+BmpGZpX6ArVGT86xF
	 4rztSvN0ZbAY+dpPyuQFTzk7oqEXsv3qzVjm7KfKZGJqU4+xHE46nXh+HcpmdL2iX2
	 Cez/5qlVAY8MmvVn3a4Dih/zUl22C2w8hBmgDL20=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <a87acfaf-52b5-4234-b928-1b596dd61f31@yandex-team.ru>
Date: Tue, 25 Mar 2025 14:34:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/split_lock: simplify reenabling
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 den-plotnikov@yandex-team.ru, gpiccoli@igalia.com, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, tglx@linutronix.de, hpa@zytor.com
References: <20250325085807.171885-1-davydov-max@yandex-team.ru>
 <Z-J2jnHK6_ltAdfR@gmail.com>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <Z-J2jnHK6_ltAdfR@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/25/25 12:25, Ingo Molnar wrote:
> 
> * Maksim Davydov <davydov-max@yandex-team.ru> wrote:
> 
>> sld_setup() is called before setup_per_cpu_areas(), thus it can't be
>> used for this purpose. Another way is to implement independent
>> initcall for the initialization, that's what has been done.
> 
>> + * Per-CPU delayed_work can't be statically initialized properly because
>> + * the struct address is unknown. Thus per-CPU delayed_work structures
>> + * have to be initialized during kernel initialization and after calling
>> + * setup_per_cpu_areas().
>> + */
>> +static int __init setup_split_lock_delayed_work(void)
>> +{
>> +	unsigned int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		struct delayed_work *work = per_cpu_ptr(&sl_reenable, cpu);
>> +
>> +		INIT_DELAYED_WORK(work, __split_lock_reenable);
>> +	}
>> +
>> +	return 0;
>> +}
>> +pure_initcall(setup_split_lock_delayed_work);
> 
> Oh, I didn't realize sld_setup() couldn't be used for this - thx for
> the followup!
> 
> 	Ingo

Thanks for reviewing :-)

-- 
Best regards,
Maksim Davydov

