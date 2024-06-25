Return-Path: <linux-kernel+bounces-229592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B39917125
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5F61F23D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A5217C9F1;
	Tue, 25 Jun 2024 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tc2OxMbA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gzRdVNQT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F71870
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719344072; cv=none; b=MuintYLJrdiwljdE31tWc8L8mPDh5q3YBAx7/RfXuL+WSYKRuBU3pOJYvcok/FsBoxuqNm0mlyS4Ntcy0tl0vn0v7sf2Jzw6fUxArB7IkysnUKMnHihtKm1oawLDQ08mof8HJjrd8EZ7SsmLKQxj2tsnsdImrOr+nDRIYbt+QW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719344072; c=relaxed/simple;
	bh=ZcoTTTX0fiB+t6BStoNHMeuVaBvr14k4F/lbYM8FwE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MTQF7KjDMahJMyEx0J6c694SmxEvUeYu9ZL8oELXoFfDWRnUsQhJ0sfigzhnCtSZvKKjgDkbXMePt28hRZE605UKexCSeXfXUGDzOnwUVbQwUVJd93MrFyU96thEQ0Me2+a+cimpmFKwd8QqIm/c2oKH3WtO6/60yg74x9oXHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tc2OxMbA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gzRdVNQT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719344069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t3e3JMxWEYJ1oT/GC+oSHzDoxxF7noWaN148DrIahZc=;
	b=tc2OxMbAuGPMb9qoBCihvP4jVOFNv+wDtIvGLm4513aTNxG2AgBmBVOy6HVo2jBUuVuGo9
	pBakcE/j9DA6Pr+H6jcPY1EOzX82JxLPD4VW18CI/B4/HgexPXaoWfO1cOM/DCRzRv0HiD
	Jn8CU+0jFJc/MHxDM6Es7IiLM9QCL5NUiUlplkdHYnfEeai7mFmcSwLX9t3ARrzx92pddb
	IX3Iz+5ShmivtWi5Sjpum02TWR1aHs+VZqqdqqWskkU/Y1HzkHxzTokX0raWOaU+NsdlPn
	nTjBYlvD1PqtsqtPYxB5pr34hVoTJaPMCqU2onkV0gRFGEGH8+CmCnbBsLSijA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719344069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t3e3JMxWEYJ1oT/GC+oSHzDoxxF7noWaN148DrIahZc=;
	b=gzRdVNQTS04wyiDoJgHZVAggcENbZHMJ4LRkCj8u1SZ85k+vzvxXGiU+A94BK4fyuMgS8U
	fWqi7JH2O5M0hxDA==
To: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>
Cc: linux-kernel@vger.kernel.org, jiaxun.yang@flygoat.com, maobibo@loongson.cn
Subject: Re: [PATCH v3] irqchip/loongson-eiointc: Add extioi virt extension
 support
In-Reply-To: <CAAhV-H4KcovRtPqXQfn0TJ1gpM6Hs5=D0Q3KmYi_YYC0BATfEA@mail.gmail.com>
References: <20240624084410.1026648-1-gaosong@loongson.cn>
 <CAAhV-H4KcovRtPqXQfn0TJ1gpM6Hs5=D0Q3KmYi_YYC0BATfEA@mail.gmail.com>
Date: Tue, 25 Jun 2024 21:34:27 +0200
Message-ID: <87pls44y0s.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 25 2024 at 22:19, Huacai Chen wrote:
>>  static int cpu_to_eio_node(int cpu)
>>  {
>> -       return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
>> +       int cores = cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PER_EIO_NODE;
> I think the correct condition is not cpu_has_hypervisor, but something
> read from the virtual registers?

I dropped the commit for now until this is sorted out.

Thanks,

        tglx

