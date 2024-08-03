Return-Path: <linux-kernel+bounces-273403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD189468D6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 11:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA881C20C84
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E1E14E2DE;
	Sat,  3 Aug 2024 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v7l7kYgt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ie/9UT6o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2DB4501F;
	Sat,  3 Aug 2024 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722677502; cv=none; b=l6nweY0relEu12ASRe0/hSJieMToWavqhb9F3fTiDxgVcGFr+D3bIA6PsW/IiDil9qsK13zJZlA/6qUVANGSCUep7IsvUkoEK06eWQJi57H1odS19Ydtn6zclkKxSFYdZsvTLhxGfiK6neBlp7QQ3ygi9to6nj5Q5nNVqZqGYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722677502; c=relaxed/simple;
	bh=d0zAjNeqaha+YbJMDwUW6gXG9oCEVMb1OCbg6tXI8f4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cHIInqd1+arxY1X/9BKI/1XU5YqI0CjhUZrAFS2uCUo7YWwL8pTNrfu3ZmAe6S7uEj/6G8DZKcWfxRHMBPuKBC0+Eha5XajyUYoymoKVeeSquRpbL3jcnsjzLKBpohPI/Fesc3j4D1+1S+mQtCsvLXotfi3Czulm1dqNN5cjCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v7l7kYgt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ie/9UT6o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722677499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5TFyYIxKz4zQbJIoyLbgX275aswQpsPObVD95bqB+M=;
	b=v7l7kYgtYTZsPIqTeQ6yRqzdZrAGYuSrYt+ShKpXl9GzUg3/bN4QJ5HiynXEHVBfFJusaS
	iXc709Df5LprJGxEWdZcAGjJ0aLX8ptw45X6M+nvQJ77sEfyhAk6lrvDGKZJwe7SBzebw3
	OI4I8lAXsFCaREhCgC++X62G1B4E+EBdjSVu5THVpT8duiBr55IyhR/iK+EzG2ty3IkeI2
	Ji4lfVpbx5RF6QO/SCrHfDvnus3qpd21aJAMwhUT5cWm6mpQwM8lj5Is7Zc5EYwxK3uv4W
	wYxaen0T1VJTaj17kbexOikiifcW4Au6dJ5bzXnuncaWUAXlXmEBO1Y5n+cMXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722677499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5TFyYIxKz4zQbJIoyLbgX275aswQpsPObVD95bqB+M=;
	b=Ie/9UT6o6vwgPtfWx82uctrc3yhHBzoUN4njHyI8Q7iX6a5YmvkE/JaqWBJAwB1NLdfMqJ
	LLl7CwimcDNxBzBw==
To: Tianyang Zhang <zhangtianyang@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>
Cc: corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
 kernel@xen0n.name, jiaxun.yang@flygoat.com, gaoliang@loongson.cn,
 wangliupu@loongson.cn, lvjianmin@loongson.cn, yijun@loongson.cn,
 mhocko@suse.com, akpm@linux-foundation.org, dianders@chromium.org,
 maobibo@loongson.cn, xry111@xry111.site, zhaotianrui@loongson.cn,
 nathan@kernel.org, yangtiezhu@loongson.cn, zhoubinbin@loongson.cn,
 loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V7] LoongArch: Add AVEC irqchip support
In-Reply-To: <cff37371-0692-0db5-cb14-74c519eb1c56@loongson.cn>
References: <20240726102443.12471-1-zhangtianyang@loongson.cn>
 <87o76kuqza.ffs@tglx>
 <CAAhV-H7c0Gtjf-6iS-E4nviMqmPWpJMNwvhWf0fLBx75pDXtrQ@mail.gmail.com>
 <87r0bb6ru1.ffs@tglx> <cff37371-0692-0db5-cb14-74c519eb1c56@loongson.cn>
Date: Sat, 03 Aug 2024 11:31:37 +0200
Message-ID: <87msluymti.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tianyang!

On Sat, Aug 03 2024 at 14:40, Tianyang Zhang wrote:
>
> We consider that since the original extioi-msi is still using the 
> legacy-MSI interrupt model at irq-loongson-pch-msi.c, if per-device-MSI 
> is directly supported in the AVEC support patch, it will result in the 
> simultaneous use of two MSI-interrupt-mode in irq-loongson-pch-msi.c, 
> which may seem a bit strange. So we decided to split it into two 
> patches, the first one using tlegace-MSI to support AVEC interrupt 
> controllers, and the second one will be uniformly modified to use 
> per-device-MSI

Adding new code with old functionality to convert it five minutes later
to the modern interface is just backwards.

Convert the existing code over first and then add the new one, no?

Thanks,

        tglx



