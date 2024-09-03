Return-Path: <linux-kernel+bounces-311989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E67E969096
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014551F23651
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C03F80B;
	Tue,  3 Sep 2024 00:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b1ExJwoF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F/v3yxow"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7A36C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 00:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725322106; cv=none; b=loaJlA29Ki9SFuUEEMjzKyacsUxnSuUUhZ61Wa13IWOWomC38u+5XQmJBrjQKry02ZGFPC5SOSotMW3WoqVv+0EjcQF1VNEuIWAZCwEea76GdqHTZ1DjEXFYxkrf10a5kfc7sYWsNEPhJcl2yc2wgcIpjOnN6CcQeeC0wR73Bd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725322106; c=relaxed/simple;
	bh=NfCF71FKe8h+6Xth+pd1JuJyHJKbDW7WXOzjaiLQIMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OV/pIOdDY3JS/MwyqaycIoos1nKAe7pg7xOWPguOWZYGn5N4vaGRgXP5w4ATZidF6miYT+87Be8/iGW9UaJV38o7Dj9V62FcwRdx5iSEu817+3fVx+i6TOy0zxLAZd9Z4AyyGV1NiS0ZZV9pCSrLRT5qNWQqEySBXgi5du+kcAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b1ExJwoF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F/v3yxow; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725322103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJkykpUZAqUsD58LPujeeMtQSEPxCbs+sQlcnUFgRq0=;
	b=b1ExJwoFpHeDp87w586qBxFEsBjEarOnkpC4ba7V05YIfL/sMsk9z/DI1I1F5emi4G1z88
	EgKbrDktgNgs0GrqYyBCUcK2/qpx3GanofRpwhyq+ruL6IWsmc1kLMNqi44y1IdyiKTcTI
	k2ozqujjlilZG5RALKjNX+htksFBOZADClDqgLNxrbRHYZ3g/RUOFc/NQl7wm5XFlhVtI8
	dnbI/c1t2oZrSCQ0uu2EjI2pITNEXV/3nRDqq3kyIeGAiaZ/07D57iV4Ls+UbusQ6MBwrg
	8Y2gU0pYW12oigPBWOHrJpSLPw+ExWjBBg6JezLTpOJiY4fqOyneipCOsadECg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725322103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJkykpUZAqUsD58LPujeeMtQSEPxCbs+sQlcnUFgRq0=;
	b=F/v3yxowxd0Jf3o8owdp/7RnEV7mG4np34GFsGtvsKeSRHOAJwF7RL95YGsimPzV4z1AzS
	M4nnPrbyNtHp1uAw==
To: Xingyu Li <xli399@ucr.edu>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Yu Hao
 <yhao016@ucr.edu>
Subject: Re: BUG: general protection fault in __free_object
In-Reply-To: <draft-87y1494nw8.ffs@tglx>
References: <draft-87y1494nw8.ffs@tglx>
Date: Tue, 03 Sep 2024 02:08:22 +0200
Message-ID: <87y1498uq1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 03 2024 at 01:49, Thomas Gleixner wrote:

> On Mon, Sep 02 2024 at 16:28, Xingyu Li wrote:
>
>> Please see here: https://github.com/TomAPU/Linux610BugReort/tree/master
>
> Can't you have the courtesy to provide me a consice anwser to my
> questions without making me chase a gazillion of http links?

And you still did not answer my question whether this is still relevant
to Linux mainline or to the latest linux-v6.10.y stable tree.

Thanks,

        tglx

