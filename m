Return-Path: <linux-kernel+bounces-230919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0519183C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E21C1C217EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FF6185E7F;
	Wed, 26 Jun 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="J22XXaVo"
Received: from smtpdh17-1.aruba.it (smtpdh17-1.aruba.it [62.149.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414D41849DB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411573; cv=none; b=iN9dLjIQjWa5AFvriImLYgV6RCq7Ar2TMIz3UU7E6cYzbOIzceOPnQpIjZRwJY320VmygGENGMRYKDcLwDDr6sSWzno1ePEI5DuM/v/0RKeC+W/4XodGj/MUuTocRJD9YhuYcqvTpzYhkXAu86RLWfYPbm6xfH8wvHrOaqwoP6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411573; c=relaxed/simple;
	bh=Hs7Dp0ctIDOdnOUPFqDg6ULHT7hHurXwWeHACeB/32Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPkKnFrIUK3rsLKEBYVOTGYrOP+NHfuVIXV8N/zwef2k+ipk+8RaomGydKMch4rVSolMfltTEBkf+NaBXMb+djn7+gDlQqF/w4zZvJMYEC2jrr2Gs4FzkofKoD02V153HLeX0gf54okG3Zi2clmFs9y+2KCNQ4yNDWkHo7THWrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=J22XXaVo; arc=none smtp.client-ip=62.149.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.57] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id MTRZsZSe7JLbHMTRas2WX0; Wed, 26 Jun 2024 16:16:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1719411379; bh=Hs7Dp0ctIDOdnOUPFqDg6ULHT7hHurXwWeHACeB/32Q=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=J22XXaVoleMNo6F340IMMVKpfKYdmuS0PQPYGLAzlk87Zy9cu28btS4V7bOB0C1NM
	 jDWNX8iFIezKIKX7FXRjn2azoLLzuO0yNZnwYKVHVecKrKZMi5bObBaakTWMvQ7tEf
	 D3vKVDLRJSjTcNdCmLumeIhqHC/PYOpGUAaIXyNycVZ7oZI/ewovECHJl/c9LTJMFP
	 hlhRf7KyIbffiKMFtYV8d6m+4x1PfiYEqOmufMRMnji35jXSMt0tht6TuLUzEHp+gE
	 m/FjfrvT4GnjhpOLqWCLzaXoH701gk2cL6Oh6uQNt14t3ugMG8G8/AnP99wmJZMkkg
	 Q341igZeBTrSw==
Message-ID: <956e2244-a95e-4c5e-a4a3-fb694c124739@enneenne.com>
Date: Wed, 26 Jun 2024 16:16:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] pps: clients: gpio: Bypass edge's direction check
 when not needed
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240425122853.29544-1-bastien.curutchet@bootlin.com>
 <3612b36e-3350-4a5c-827e-482434753e95@enneenne.com>
 <973aa216-4932-4e21-b9a1-184ce809d483@bootlin.com>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US, it, it-IT
In-Reply-To: <973aa216-4932-4e21-b9a1-184ce809d483@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDXK4FpfAiwub8FhGWD2GEDJezOjSXlfrqQGyI8JNZzx+QZGhTyoSSKC7TM4a94N7mqRw19r7xd6vVA8O5KWqgN/iBkGPItlDJAFf5saXHl84EC91IMn
 Fdj9ZBq2Q+PCmLm0SoS7kw/iRmlKaR2DZK30i2/QPV3ZG7I1+t9QTukCOnY6wCDZXcZbtGDJrxjc0KxIneDlsVYS8/QVfm8/ONrFQ982V/GTxDsf18A9bFIS
 nhBWQ7P3pC66yT6KapgSMEPFGjG+5NWInVFnwM7Aa/u0rPGeciZhpzrCeERfSeXygkt9nC8Z6qmdvoxIIG9wzl0jScXlxp9E2GT90yt+/CoGHoJ9gSWudZt7
 iObQD4fNkgKajX4KNkaswEQgi5xefNz0gULX95BA+/cgUCj+yAB3N8UoaMquONVlVoXP7vR3JFX9BjR9AaZFmd3JV3wDnz3RYb2xzG2pPho3Tkw+Gtw=

On 26/06/24 14:55, Bastien Curutchet wrote:
> Hi Rodolfo
> 
> On 4/25/24 14:42, Rodolfo Giometti wrote:
>> On 25/04/24 14:28, Bastien Curutchet wrote:
>>> In the IRQ handler, the GPIO's state is read to verify the direction of
>>> the edge that triggered the interruption before generating the PPS event.
>>> If a pulse is too short, the GPIO line can reach back its original state
>>> before this verification and the PPS event is lost.
>>>
>>> This check is needed when info->capture_clear is set because it needs
>>> interruptions on both rising and falling edges. When info->capture_clear
>>> is not set, interruption is triggered by one edge only so this check can
>>> be omitted.
>>>
>>> Add a warning if irq_handler is left without triggering any PPS event.
>>> Bypass the edge's direction verification when info->capture_clear is not
>>> set.
>>>
>>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>>
>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
>>
> 
> I don't think I've received any updates since you acked this. Is there something 
> missing before the patch can be applied?

No updates. It can be applied.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


