Return-Path: <linux-kernel+bounces-300443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2304D95E3BA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 15:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79361B21C0F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A56314F9FD;
	Sun, 25 Aug 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ks/zLrtd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OY+9Nh4K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E01E495
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724594154; cv=none; b=mePWdfOUEp39XJ6XioofhNIhVCmABGmUp7i1YxhzPjeZ5HpgNk3sWiK62xEGayE7hwwz8TK95E+QJ4GO6NQQAkCDbQH7KrbkIdxdo1zwCWaE2X+bGQAcfcrNzUnL5gzCWYhYNsKQNDBDiAQ+bxDvw9onXBfs+T9rK2BApa6Zv6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724594154; c=relaxed/simple;
	bh=1agy8P/zMTErnTNUY+1rwsgiHnDQmlP2mJmOI9BEcBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kLX5zPjMDFc2oGq4Bxx3dYJpGsel9KyKCU49GKHGdq8L5cmvp6e9PJFhmd6iKvBFCr7BDmkMcd3i8w54HCE51ZVubbTVnFF0P/YjfDaoNkYEptZ1NaiCdGq95DshHTDaLMNLZs8rIr0wKygyMaFlhW7RlE3UZ8A8zq4LfVqzGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ks/zLrtd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OY+9Nh4K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724594145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yjBx63r2ztvXKNeBFIK4cieuNNi73074BFOGKrjsH9I=;
	b=ks/zLrtd4S23UI4adtvuqC1aRc9o0KmlHP+yDbyFQ4nhC/RmE95DUj0Xb+mWJSepMNLu2K
	tVrtjV29V1KSDxFnbiewLGV2trv7ZJ6zxMBS+wxd7amzOM48g+7eb/2v+kA1uHar41ZLag
	kTKp3eNEp8oeBV1yd4bhGUeEcXhAi8EdRwN5shqRNQHpqc1X/mN8Gst2FFnDAegCIi9fhF
	xonDL1kpkOcVYvXZFFone28wXgNHOiRPXkJjuHG+0T66JeljMRjDhdx4DsMQh4R1K5OIBf
	jqLeW4GAFwfVrYxjq2vJ7CiNeHwIJsiWxcmeypqxhNp2am1mVIT2WUX3bHrLnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724594145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yjBx63r2ztvXKNeBFIK4cieuNNi73074BFOGKrjsH9I=;
	b=OY+9Nh4KcjaQ0GdTNF4G8/jhj53ygC0vGkVZ7yI4DSm7kq9aShh5T3xLX/SC2Dzprrxl93
	jO5OX8sToglkRECQ==
To: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>, Ingo
 Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip] x86/boot/64: Strip percpu address space from gdt
 kernel load
In-Reply-To: <20240819083334.148536-1-ubizjak@gmail.com>
References: <20240819083334.148536-1-ubizjak@gmail.com>
Date: Sun, 25 Aug 2024 15:55:44 +0200
Message-ID: <87v7zoemfz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 19 2024 at 10:33, Uros Bizjak wrote:
>
> Found by GCC's named address space checks.

Which GCC version?

Thanks

        tglx

