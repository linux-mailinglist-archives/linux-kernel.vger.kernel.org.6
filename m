Return-Path: <linux-kernel+bounces-513595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B932DA34C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B927A3142
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A102C2080CE;
	Thu, 13 Feb 2025 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="Eyh1K3WK"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD9202C4C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468372; cv=none; b=UGM8EpQYwJ5NPnfGtTSI/TiNkb3fTDXc+7eWqkl2UsvLbtMjPgnQYiml9jdKLkopoCDLDKbwl9P84+kuSt0ZeqEK44Fx2R9qTb6iWtwLvAC5Q2KBt7Lk0AxcuT1fcNMgmFW2Mv2M/kqjrr8V3wAZqb77O7ctFd2kMK98QSlydWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468372; c=relaxed/simple;
	bh=KO5CjaRrsMmSyUYYfavhvo6x6sn7CHl2RDcCF2tZcE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYhkFlf2cXga9wb0Knen8nptWTxL8IGq8H7hluyfdMe4cF4s4+tUtBuRV9EO4xPa6jc7q6DjofL6edFUK3KSofsfJN59mIbQskV4yQHPPD3vFnnPnPSnKdqMazzBRup+qWp9dRTVdIsjmq9FSMGDnMMJkwEppwmgOufdNPB0mCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=Eyh1K3WK; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cKiGkcsixPn4QQtTKc7Lsw9RVigZQY9fPXwk3glZ0vE=; b=Eyh1K3WK+bt6eeYNEDl6HFh6MG
	Pu53wMhcj8neZh7w/pUF5gbJCETid3gJAMO5ZWdY2aWMZe4tqMloacovCGkLmhbzaYKm3m+lB+RHd
	Vx47vQWHi5WJ4W3znn72Ta73MlQCRb2Rm+oDHOahy1KH6rvvU5khKRlUSMBMGJQggF56VmmZXai3q
	xz3az8d2FmgVyCykADzIPUgKnuo7Ewmd1gA4qKj88Fe201qa3w+8xNWlGxLoD/pqLStfaZXEt9lB9
	8bbt7RwbdRdOlV0+RiEEi1pHq1D83YRmAMGO/kR1Bqe2hQ/SsuX9IWBK59m5w10TFAUoF9a3tZ2XF
	oLlaihcQ==;
Received: from [167.98.27.226] (helo=[10.35.6.157])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1ticoo-0081al-LJ; Thu, 13 Feb 2025 17:16:06 +0000
Message-ID: <a994e94c-3211-4bb4-ab41-71a2c1abebd4@codethink.co.uk>
Date: Thu, 13 Feb 2025 17:16:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] riscv: implement user_access_begin and families
To: Cyril Bur <cyrilbur@tenstorrent.com>,
 Charlie Jenkins <charlie@rivosinc.com>
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jisheng Zhang <jszhang@kernel.org>
References: <20241118230112.2872978-1-cyrilbur@tenstorrent.com>
 <20241118230112.2872978-2-cyrilbur@tenstorrent.com> <Z4rl8BgoV8tygCn9@ghost>
 <b45aab1e-6d37-4027-9a15-4fa917d806b9@codethink.co.uk>
 <e4a4c688-b78c-468b-8196-68d2df980167@tenstorrent.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <e4a4c688-b78c-468b-8196-68d2df980167@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 13/02/2025 17:07, Cyril Bur wrote:
> 
> 
> On 6/2/2025 1:08 am, Ben Dooks wrote:
>> On 17/01/2025 23:21, Charlie Jenkins wrote:
>>> On Mon, Nov 18, 2024 at 11:01:09PM +0000, Cyril Bur wrote:
>>>> From: Jisheng Zhang <jszhang@kernel.org>
>>>>
>>>> Currently, when a function like strncpy_from_user() is called,
>>>> the userspace access protection is disabled and enabled
>>>> for every word read.
>>>>
>>>> By implementing user_access_begin and families, the protection
>>>> is disabled at the beginning of the copy and enabled at the end.
>>>>
>>>> The __inttype macro is borrowed from x86 implementation.
>>>>
>>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>>> Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
>>
>> If we're doing this, then saving the STATUS.SUM flag is going to
>> be more important than before. We had this discussion when the
>> initial user-access with syzbot stress testing turned up.
>>
>> We partially fixed this by rewriting the ordering in the __put_user
>> function to stop the 'x' argument being evaluated inside the area
>> where SUM is enabled, but this is going to make the window of
>> opportunity of a thread switch much bigger and the bug will just
>> come back and bite harder.
>>
>> If you want I can look at re-doing my original patch and resubmitting.
> 
> Oh! Could you please link the patch? I haven't seen it and can't seem to 
> find it now.

https://lore.kernel.org/linux-riscv/20210318151010.100966-1-ben.dooks@codethink.co.uk/

> Thanks.
> 
>>
>>
> 
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

