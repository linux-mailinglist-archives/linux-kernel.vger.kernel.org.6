Return-Path: <linux-kernel+bounces-566903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BF4A67E27
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4CDE7AA223
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209151DC19F;
	Tue, 18 Mar 2025 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="wkvtZraY"
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6972135C4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330714; cv=none; b=Nj69KN1cHswd0pPYCYK8hO1Ur/eDlTf5Pzqa87b5OBfqv4CXQeKZPVP8ROst2JhvP6UDapyCzTQgq1vDobRRbglZSLvuMwQCNyzKMCIJDiebBBdDf/hzVtE+5o9wxejfVv6EPxFk9217P+C4lxrfDbsmMOERMmWbdN/xiaV2f/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330714; c=relaxed/simple;
	bh=zWnqtV0uUGDewKFBIv6HFisqymeXJgxbJrsO2LsJCqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFwtr0uHRFI6xK0BDZ+TyUY4E0XHJf4SDo3iesc+Hx2dAjtc6h+mB9AeX0cJwREMHKIUxANUQ/D5FXoGzFRiQg0TtWNPIIKMKlFkiyUbLDZ9tU3jTI77ddSN6HGJIh646sz9pUYMFJFlRmXpz0G3tQEfYHbz5XMvmNBHEg47TMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=wkvtZraY; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:1224:0:640:a676:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E05AF60FAA;
	Tue, 18 Mar 2025 23:43:37 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b407::1:6] (unknown [2a02:6b8:b081:b407::1:6])
	by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id ahPDQJ5FWqM0-GnL29IbP;
	Tue, 18 Mar 2025 23:43:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1742330617;
	bh=15+1ZUeLiLGsxrt3pZKY8hu3pzx1UPJv+d6q1GbaVT4=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=wkvtZraYmc/4nUsfmazZQ66hvQXqNejusXK4d3EI7XW/J34jtA0e3TMN33tKti3n+
	 nTnWx4Hbv1pbuSnGYbXqJyJEI0DvHT8m/HWcZIH6eD9qkkFCAyWybiExR7BWAq4zkS
	 2WlVqwrm3C/iDhFsoBVsNsSAZcO1CzIltsiuyKpA=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <8aa58cf6-646a-4676-add5-63f5b41f9842@yandex-team.ru>
Date: Tue, 18 Mar 2025 23:43:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] x86/split_lock: fix delayed detection enabling
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 den-plotnikov@yandex-team.ru, gpiccoli@igalia.com, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, tglx@linutronix.de, hpa@zytor.com
References: <20250318144911.10455-1-davydov-max@yandex-team.ru>
 <Z9nWjlIYHXWYJ0eV@gmail.com>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <Z9nWjlIYHXWYJ0eV@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/18/25 23:24, Ingo Molnar wrote:
> 
> * Maksim Davydov <davydov-max@yandex-team.ru> wrote:
> 
>> If the warn mode with disabled mitigation mode is used, then on each
>> CPU where the split lock occurred detection will be disabled in order to
>> make progress and delayed work will be scheduled, which then will enable
>> detection back. Now it turns out that all CPUs use one global delayed
>> work structure. This leads to the fact that if a split lock occurs on
>> several CPUs at the same time (within 2 jiffies), only one CPU will
>> schedule delayed work, but the rest will not. The return value of
>> schedule_delayed_work_on() would have shown this, but it is not checked
>> in the code.
> 
> So we already merged the previous version into the locking tree ~10
> days ago and it's all in -next already:
> 
>    c929d08df8be ("x86/split_lock: Fix the delayed detection logic")
> 
>    https://web.git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=c929d08df8bee855528b9d15b853c892c54e1eee
> 
> Is there anything new in your -v5 patch, other than undoing all the
> changelog cleanups I did for the previous version? ;-)
> 

Oh, sorry, I missed it.
Yes, in v5 initcall is used instead of deferred initialization.
Either v4 or v5 are good for me. Please be free to choose the more 
convenient variant for you. :-)

> Thanks,
> 
> 	Ingo

-- 
Best regards,
Maksim Davydov

