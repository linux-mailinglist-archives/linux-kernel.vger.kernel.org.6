Return-Path: <linux-kernel+bounces-441974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4B49ED639
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D746283DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416C5259492;
	Wed, 11 Dec 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BGSsnD+m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oprURwF9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897B259488;
	Wed, 11 Dec 2024 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944461; cv=none; b=gSGOqm8mtIXqzICuv8QBqGRXbBSXiQj8h/EszAJcwnwCd3BsvK8OtnlIBwfo0N1hD1zzP7A5dJRHqzo3M3GYwABQqmaR0zpqhk9PHahlY/PJigW8Otd7sl7aCs6wRkl9RBJAErL8l4lDpejjtefCy2+NG8UT3L9YLzjZhxIdUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944461; c=relaxed/simple;
	bh=cyVq8j7h/3A1zexB73GVxbSrsjwHkY39WMXImBQjX2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HsBbcEJEI5hVkn2k0uNaB9douaQwvf02tzEAE/VBgg6mMoN30oEqonyEoZOSBhWHn1WJvweHY/EPHz2DiE/1xfZZSQhuaBxCyFZMpTWOzuxXgiUdAveaNE7OH8ATQdHAGRgD5w5yFaEen6dYH1wcnERz5/GwgRP5hQ0OqlyUchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BGSsnD+m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oprURwF9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733944458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mOVBcCbLQsYa1QXqE1cZk/HrSWrycdtTJ6dVrRK+9jE=;
	b=BGSsnD+mdsbd1dlbCif6vi/QHDOe0b+Cout4iF0e+fm8qGjgpBeHfjP5OMCpKsYS9berOp
	sUIiOG7ZBPOzNHycI/m0jq1DlEoopg0x80GPLVaNNX4JSa2jtgd+5tHY6m1Ti9SwW6fEN/
	4CJUJlvi61yIhcGy7Vt4sercH48ztM7n2KJKwGnxZYrpoWvCW2Bbk0YrpAw46z+Onx8sVD
	Zv5Aa5yWMaGC682qtaxm3IHlOULsqAbfSxTegc3S9iSFf6DJKSHy1fSGp+fAVZKwUiQg96
	5TAbkxz+DFMUPfflZpLDtCByWikiAA2xk6DrqGz7inQVCeESr9lgLT9J8lJzvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733944458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mOVBcCbLQsYa1QXqE1cZk/HrSWrycdtTJ6dVrRK+9jE=;
	b=oprURwF9A/R6MJhmrsbgaOj6AWUtGm8wdLShH8uZRpMZ8bwnV+4aSFADrH3xPuvQKP04mN
	VHwfEw4BGgaMYYCg==
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: David Wang <00107082@163.com>, Huacai Chen <chenhuacai@loongson.cn>,
 Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
 maobibo@loongson.cn, wangliupu@loongson.cn, lvjianmin@loongson.cn,
 zhangtianyang@loongson.cn, loongarch@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.12 18/36] LoongArch/irq: Use
 seq_put_decimal_ull_width() for decimal values
In-Reply-To: <20241211185028.3841047-18-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
 <20241211185028.3841047-18-sashal@kernel.org>
Date: Wed, 11 Dec 2024 20:14:18 +0100
Message-ID: <87zfl29gmt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 11 2024 at 13:49, Sasha Levin wrote:
> From: David Wang <00107082@163.com>
>
> [ Upstream commit ad2a05a6d287aef7e069c06e329f1355756415c2 ]
>
> Performance improvement for reading /proc/interrupts on LoongArch.
>
> On a system with n CPUs and m interrupts, there will be n*m decimal
> values yielded via seq_printf(.."%10u "..) which is less efficient than
> seq_put_decimal_ull_width(), stress reading /proc/interrupts indicates
> ~30% performance improvement with this patch (and its friends).

Why is this stable material?

Thanks,

        tglx

