Return-Path: <linux-kernel+bounces-416243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9791E9D4272
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 131B7B2430A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B419C543;
	Wed, 20 Nov 2024 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="H8DipLzv"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431A155C9E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130223; cv=none; b=FbkXATqk9jJ1XfxkHYrzjHM5vTJIgngPSMFZfAUAvVD0D8Isy9Gr8QCskpqrO+ikSYxl7InVcLPvcLVsbbBuONp56xI+QXsnYxBrNm4E7sbA3zsSXP1mdO83sygN99QkxkAd5VqLftg+sWFz4z4h3doPRmkoHZTCEmGJlSXVv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130223; c=relaxed/simple;
	bh=DKMyPBuGWKFCERsUw5+gNwFeye1j8dqRzAwdYRi9AtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJKQO7rofOYQFz/FxMAIOYsuBoONOvIHr5WxIJFK6ry+PnUb8Bfp7Xr5ctwR8Vi628OQ6OEhoKWH+h61J4iIV0ZggO+YWnftRR4yxyrq4VccYWQxVNyvkE02N02ymT6pjT5dUpcSVFH/CRYvTujUFB13g9OmrLTtbvEj0b6OCCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=H8DipLzv; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L7t+8dV1vLK9wmgSqZN4gnE8Nl6CKzOAb9OKd3yMqq8=; b=H8DipLzvFn+SAsWaLidOGwu5mD
	ZxlGZ45Sr70v4nAjVJ5tQvF5RfXQ6qRYWFWojFr3yWn/0TSGuY4eFJYlij0ec4X+Qi3Mf22paH1nV
	D9NAW4lpIWmc3Kz9oXIaG5iCuuVy6/y3jlGP1jQLBj+1cBAQHPMyYUkaUO+nT7aaJIR2rdd/d7Wzu
	6bU7SrlzWfHPXKjtllHjU+2ZXl/Q0yeJ7NX4fl6x1+G1Ssazzu1asLkhpcfT4AqVjZYb3ndFNGq1c
	hsHUWU9nxheyhajjP+l8xYZKZ6u1S961lRUy5pt0FOoenqnjjhXkavehgkrV1/1mMlmmeEmHXtCg+
	8VNnNUDQ==;
Received: from [189.79.117.216] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tDqC7-009yMk-4X; Wed, 20 Nov 2024 20:16:55 +0100
Message-ID: <afccb8f2-a376-266f-5477-493bbc5fb7d3@igalia.com>
Date: Wed, 20 Nov 2024 16:16:47 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RESEND v3] x86/split_lock: fix delayed detection enabling
Content-Language: en-US
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: den-plotnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
 x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de
References: <20241113142301.704057-1-davydov-max@yandex-team.ru>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20241113142301.704057-1-davydov-max@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2024 11:23, Maksim Davydov wrote:
> If the warn mode with disabled mitigation mode is used, then on each
> CPU where the split lock occurred detection will be disabled in order to
> make progress and delayed work will be scheduled, which then will enable
> detection back. Now it turns out that all CPUs use one global delayed
> work structure. This leads to the fact that if a split lock occurs on
> several CPUs at the same time (within 2 jiffies), only one CPU will
> schedule delayed work, but the rest will not. The return value of
> schedule_delayed_work_on() would have shown this, but it is not checked
> in the code.
> 
> A diagram that can help to understand the bug reproduction:
> https://lore.kernel.org/all/2cd54041-253b-4e78-b8ea-dbe9b884ff9b@yandex-team.ru/
> 
> In order to fix the warn mode with disabled mitigation mode, delayed work
> has to be a per-CPU.
> 
> v3 -> v2:
> * place and time of the per-CPU structure initialization were changed.
>   initcall doesn't seem to be a good place for it, so deferred
>   initialization is used.
> 
> Fixes: 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> ---
>  arch/x86/kernel/cpu/intel.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)


Hi Maksim, thanks for resubmitting again. I think that is indeed a valid
fix, but what I've also noticed is that recently (as in this week) the
code changed from the intel.c file to a more generic one, since AMD is
enabling split lock detection in their CPUs apparently [0].

So, I'd suggest you to rebase against 6.13-rc, that would likely
increase the chances of a merge. Once you do that, I can try to test it
as well, though I don't personally have an Intel CPU with that feature
(but some friends have it).

Cheers,


Guilherme


[0] https://lore.kernel.org/r/ZzuBNj4JImJGUNJc@gmail.com/

