Return-Path: <linux-kernel+bounces-272575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A26945E33
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8001F2401B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA251E3CDD;
	Fri,  2 Aug 2024 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dup5ih/c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EubcF067"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB11DC47C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722603462; cv=none; b=S/cWJzcG/3TKF/kfkMHx2+ZQ69i7M0QZfZ9p6PjY8y2Qk2r8KluIDG78JJDmzNFbRqvCttM8GPOtPcyneUnOVonYkaxALrfD9qQhPRH00OICd5mNAhv20h25KBrVbXoA7HFxzo31dVFPWO1ZNMQs6K9tbXAlyOMhjw2MmOkBWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722603462; c=relaxed/simple;
	bh=O5e/6G+UM25BxlQUWxbyryv4bOzCBkl7nWu90dDPr9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SdSbFXdsUVIGBq6lzRkzAWQy4v9Hb+56dxvAsZASWX59nV7SwkDQ0bLh3zmJmPrJ9Xi5mmjFUNetr/Vb8fEsuubrOOdoJjYpRUTvgl1w+VH4hgLFo197au/ME1Tn+vOU4ADgGcqcXIK0OGn4sVYrJjmdQENzcJUNKev8MPKOFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dup5ih/c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EubcF067; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722603459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O5e/6G+UM25BxlQUWxbyryv4bOzCBkl7nWu90dDPr9o=;
	b=Dup5ih/c9Ll7xhiCpSGh6zVCY45x1W4PsqPA+PCB2DM3mpo1gNzQsSzdGifc36R5UOEEze
	ZBf+q+DoMqnSL3mH7Z3U9AYqpEE2HTPJ5mEQ+w3MpLBalmERpW8IHVyYlTI6tZwnyqmDGk
	grL+8QKBU0YhDQEo10R4xMukgMgisptf2ry2Lj0mg9VVdDgHK5Ehd9UtfgPaWfHk0dEofp
	uUugO96lR/VPSIbBdV8M5v6s+snNRFloDqJwNg46jkP7iekI51Da/tMj19GJLXlys6cOTf
	n/Q6aBK67Le/w2zLg8JrQtoV2R5E52HHF89/tHif4Mt6QqgtK+ZUanD/ew8ZNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722603459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O5e/6G+UM25BxlQUWxbyryv4bOzCBkl7nWu90dDPr9o=;
	b=EubcF067iHPxmtEKaSAyakWHQcL1X08DPzdAbR8Q5dHoQQix8euEBg5kr2mEjOPGylVXfE
	Q5JLjuPUIADNINDA==
To: Alexey Dobriyan <adobriyan@gmail.com>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] xen, pvh: fix unbootable VMs by inlining memset in
 xen_prepare_pvh
In-Reply-To: <3fe4502f-020e-46de-976a-b32a76de478a@p183>
References: <a9f505a6-fd31-4cfa-a193-d21638bb14f1@p183>
 <3fe4502f-020e-46de-976a-b32a76de478a@p183>
Date: Fri, 02 Aug 2024 14:57:38 +0200
Message-ID: <87cymr13r1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 02 2024 at 11:53, Alexey Dobriyan wrote:
> If this memset() is not inlined than PVH early boot code can call
> into KASAN-instrumented memset() which results in unbootable VMs.
>
> Ubuntu's 22.04.4 LTS gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
> doesn't inline this memset but inlines __builtin_memset.

memset() ......


