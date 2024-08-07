Return-Path: <linux-kernel+bounces-278630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B64194B2AB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE0F282542
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32BF14EC5D;
	Wed,  7 Aug 2024 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="18AbZMxk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tplhZKE4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1A14830F;
	Wed,  7 Aug 2024 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723068293; cv=none; b=mSYSxTAZEI2zmJIweoVT86inkY6RgMrPM5nxzLTHh5M7DqVrpzbvt16d83HQCnvRfZsYtcG5Osf8f4/minEnYqN87SbjeDuUePGrggeAuumDnNeU7hi7qj9/aCoMOBA16feIQCJXpRtNBYyaWVQhksUn3fm4+Qx6UgZLqpT5kbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723068293; c=relaxed/simple;
	bh=Gjkxy5f6gJVy6vNpMxHuQURheufrPQs99qjqz/bpXZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Udc4slGtl2HMAN51RM69IoZ0hXmNl8h8rFeDwRZt1TgHZePz1yYq7izCtoSFLgLunvml3Or0BZTeEuLUze0XlNZ73Zp6skZqA/mzn+3b99U+7mZKPl0wqGxHW+Zrh2ZdkKVvcIcx16EN+CjGjItzpNKDRLFg2jov96+9q4kexnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=18AbZMxk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tplhZKE4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723068289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgk3Fst2WMnEhsUwWJQ7yJneI6QzoUuA5p9aHlKtEE4=;
	b=18AbZMxk7jboDeOnt25Ydoj1drhf6mSXl8Nbg0WjY63dh/YqPrlWNbopyB2jWlWT9H+9Br
	RhAE7GpUxxJeiGOGX4HHz4scWX+YPsa8Y0oa8OfZXJHvqXXVc0zaJ680FLj53fqS4Sl5xr
	urGzCzKcN8BUCaI5G1Vmq7ok3Hm73vSrb3alfwCtrbmLTBDbI9hOefTOjoNWb/2DD6K3y5
	7/uDKb/LUfSCoypBKf3c5myHZtrdz/+K7Vkge5IRBc/Db5lvDS193L/sjL4JIKJobQ23Tr
	vM/dQNdKD7fg05TEWuEdIqkij657KYOIivYnQotnM4/TfU4l8i0S2hSXWI2pxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723068289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgk3Fst2WMnEhsUwWJQ7yJneI6QzoUuA5p9aHlKtEE4=;
	b=tplhZKE4F/TO3X8SqiY9s5lRMpFLShtTKxy+suRMFjdxSuxzDWPPHOQx88Fkbg/N6V2keI
	65DDIoE7kDefoIAQ==
To: Tianyang Zhang <zhangtianyang@loongson.cn>, corbet@lwn.net,
 alexs@kernel.org, siyanteng@loongson.cn, chenhuacai@kernel.org,
 kernel@xen0n.name, jiaxun.yang@flygoat.com, gaoliang@loongson.cn,
 wangliupu@loongson.cn, lvjianmin@loongson.cn, zhangtianyang@loongson.cn,
 yijun@loongson.cn, mhocko@suse.com, akpm@linux-foundation.org,
 dianders@chromium.org, maobibo@loongson.cn, xry111@xry111.site,
 zhaotianrui@loongson.cn, nathan@kernel.org, yangtiezhu@loongson.cn,
 zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V8 2/2] irqchip/loongarch-avec: Add AVEC irqchip support
In-Reply-To: <87le180z8b.ffs@tglx>
References: <20240806115557.4750-1-zhangtianyang@loongson.cn>
 <87le180z8b.ffs@tglx>
Date: Thu, 08 Aug 2024 00:04:49 +0200
Message-ID: <87ed700z26.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tianyang!

On Thu, Aug 08 2024 at 00:01, Thomas Gleixner wrote:
> On Tue, Aug 06 2024 at 19:55, Tianyang Zhang wrote:

Please make sure next time that the two related patches are threaded and
have a cover letter ...

Thanks,

        tglx

