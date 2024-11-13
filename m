Return-Path: <linux-kernel+bounces-407154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7558D9C6976
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFDCEB248E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4764F17BEA4;
	Wed, 13 Nov 2024 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ZsovUEn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ba9jOIpj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B36175D5D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480505; cv=none; b=PGU4ojTPUSKXF0ohKaA/7rKOsmLiNqAelqrOKQB1nFmQl2YmUl9xF9CDEj5S2Xi7VvSoHsJW05UFbCZ5RnW6tOcpz8+W8xJ/N/pINHAF+0PRkRjm9BT3/AmVXWNhPihkMlr8MttgW8RIFcjPO4F5LpuP52L9ic2guD23NwwRDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480505; c=relaxed/simple;
	bh=FCL6iQSIGT8dr0ybeEkV2LtLpsYp1zT2k0cEasxOuE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pr/0Nt0bHfLEjcH+1hsmZMRbq616ff2vsJFzUjP4wFgZ7RunvldX12SUd8g1gpRyYVofm7AFdj6VDaGrm2f7cqkRNISw0X0AFp8y9nMGUxQ6whh5qATIUnQ1EQIegxgrqphFEH3tFxU4jZRm99+KcAaaq4YJ7KV+5xDOV2gnQJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ZsovUEn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ba9jOIpj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731480502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UR7iHX45jbd3zRVPmJ4qHkxT+yZlpGkin9tX25AvgR0=;
	b=3ZsovUEn7U16XXODrRWvxNWP2Mgzs/aXaJj1/eAlbViEspVwXOBG+W6vn1RY9ptwtFU312
	zK8FrIbQBaNPBD9jw71eQ9jXXlOv8TcaEID3LE12iHO0DOZ0PJssOUWiFNZTVSc4TvD8xp
	UMiBYwuzcx0jqOvaQdBKSQAMwFh2XfK1NWZvkKrrmIElipF5LHDIcSNhE6uEwfYBvVJPCk
	3607pwdXWYX5pWw2sF/maxJ2x8pAwWW2G4G7+38H9Qds7QiWTZw7v75QxTMUsBrXRwRmv+
	NpS1Kf1rSDX6pMI65yuPvm7/uhimYjEhFKaG2whfkI+/PpBpPEDf5yfQfCLLLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731480502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UR7iHX45jbd3zRVPmJ4qHkxT+yZlpGkin9tX25AvgR0=;
	b=ba9jOIpj4HnkGH2jX2YjXl87zvrewCJ07aMGMo/cWthoagyG2h2Fo2HQ4s0kJJJbANLLlT
	zKEShp2MRIZfW6Dw==
To: Luming Yu <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: Re: [PATCH v2 3/8] powerpc/debug: implement HAVE_USER_RETURN_NOTIFIER
In-Reply-To: <027637B09D70E22F+20241111031934.1579-6-luming.yu@shingroup.cn>
References: <20241111031934.1579-2-luming.yu@shingroup.cn>
 <027637B09D70E22F+20241111031934.1579-6-luming.yu@shingroup.cn>
Date: Wed, 13 Nov 2024 07:48:37 +0100
Message-ID: <874j4bmxx6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 11 2024 at 11:19, Luming Yu wrote:
> enable the common entry of user return notifier for powerpc as
> a debug feature.

What's the debug feature?

There are ZERO user return notifiers registered in PowerPC, so your
"debug feature" is just a waste of CPU cycles.

Thanks,

        tglx

