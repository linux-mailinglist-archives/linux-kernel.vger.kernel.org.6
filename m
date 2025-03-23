Return-Path: <linux-kernel+bounces-572972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C543EA6D0FE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 20:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5390C16ED40
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DD119C55E;
	Sun, 23 Mar 2025 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Jjz0PJ8B"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A513B7A8
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742759979; cv=none; b=KoDdh+Odllh/A0i2DySdgF++0BvC/cQgDxkBQoL2f14nsY4bXtDAQyUiq8Ql+khaxm6r3a56lQZjnu/E96CZG7Sj+Vz+XLdjixlL28hCEzjUQixJHrvwvuFr8mWP0F3tUp+skgdM7IkSr1Pb/tV/6UqIA4NtOR3w44T3NS7qKcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742759979; c=relaxed/simple;
	bh=aPfRB9VTOGJ3yvmNj0GIs5velCtgRYlJWqYRwdKQ8lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUOmsBo42Jwr4tvAZ8eD9BMtjYE/uEfwTpBRj+0qAzOoKEpQuHvaFjovp4KdJ8bL9KYwmf654m5PlkXkP93Tiv432B0Ck5jAeeFmMZd24GaIEUSahalVVMQjdR0gPeKg4cU6oXfOKrJGmVPAK1uJBYa1VDkAeAxAXAqEneqmtp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Jjz0PJ8B; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pHGf6EDuTNpKnrAWnOuYszPosBN1CQ5PnIFL16Ufv3Y=; b=Jjz0PJ8BgZ6Wfg6nFuW8EOwJHO
	O8gjwSf2hp0+LvqAi3RBwlkGcKvUrG3cUg+frhszbn4KbgKKtwrxEPdS0VU86whcvFHjBobX0CXSB
	owVlNxo6B3+4Jbzl3rAc/g6uTIDpzpDeAuF/RfSCS9PiTbc2rNO01IQxghS0kg+Qi9eHatEUHXmGs
	AuGRjVPkxlV0QaEM+xAJAdRpPLWK2CBsw0atUdf7PPRPZIlyLW5dIJliyk2q4ss2w/ZU4BEjIqaTu
	pb/JD7OmbAbPANVZjYatvU6wsLzH2z38Fmt3PXZyQyIY3LgPh0dXvl4R31C1CJ95GSjHNPL01CAl1
	14e6lejQ==;
Received: from [187.90.172.172] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1twRTc-005OD2-Gn; Sun, 23 Mar 2025 20:59:20 +0100
Message-ID: <d43653c5-6e54-0c59-17c4-acd09d61e9b2@igalia.com>
Date: Sun, 23 Mar 2025 16:59:14 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/tsc: Add debugfs entry to mark TSC as unstable after
 boot
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 dave.hansen@linux.intel.com, kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20250226132733.58327-1-gpiccoli@igalia.com>
 <1238b1d0-275c-9117-a2e3-5e7684404980@igalia.com>
 <EA2BAF2F-3F8E-4F81-B71C-7B97677216C9@zytor.com>
 <b43e2353-41ff-f2de-881c-c9a3348552b7@igalia.com> <87iko213qo.ffs@tglx>
 <c9ce2eb1-bf90-3ce4-0adf-3f4e43f4a5bd@igalia.com>
 <20250323181444.GCZ-BPlCAhtO7AIsS7@fat_crate.local>
 <8247f64e-316d-0eca-9e5d-0c63c7dfc862@igalia.com>
 <20250323195102.GDZ-BmJgDWLieuUaJs@fat_crate.local>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20250323195102.GDZ-BmJgDWLieuUaJs@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/03/2025 16:51, Borislav Petkov wrote:
> On Sun, Mar 23, 2025 at 04:21:44PM -0300, Guilherme G. Piccoli wrote:
>> This is great to hear - is there any starting point model that you know
>> AMD introduced/is introducing TSC_ADJUST?
> 
> Zen5.
>

Thanks! Nice improvement from AMD =)


> [...]
> Zen1 should not have TSC problems either. If it does, whack BIOS people.
> 

Heheh
OK, thanks for confirming!

