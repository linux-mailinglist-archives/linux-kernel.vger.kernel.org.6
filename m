Return-Path: <linux-kernel+bounces-370560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0999A2E86
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60D31F23902
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB6A227B83;
	Thu, 17 Oct 2024 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S3AzDsum";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLjcOdra"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59F17BEC8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197189; cv=none; b=cx040hJLRI0/TlBITAfnDK9/MnKBuWaF9euFHwsH72YR91DVHqk+WvjTsVM7MMbJpgVb3RDAoO5A03/HTKz1FSBi74F7N49uFcvkVzZmaLU6CnPTd2fqe5TnSvklzQSlF3UhBgTDlm4jBOKa7IC9Tk7xa3Duj2v+Vl1LQcv92/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197189; c=relaxed/simple;
	bh=JDCz4V69DXTr+Md5nBN360MplX4h1sd8ZElhnRZzVIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PR6ziW8S7HYNEE838VbSaJW8Dl1dzyCjNhwXl67ga73cNMoWcbsL5mzAGo0w/edFLwLEsPoDDtBNSFOfW4J74tiVhcEVQh5hFmeCZaQWbpXO+234JsTcnvwwXSJZzFCK10o95AX0YE2bZ+iN4GVJnN98A5IynSqpwKOEyXp/w+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S3AzDsum; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NLjcOdra; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729197182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0fzNHxfo5C+op4LlDhECvnWdn7IDtTi4f0FYMN7PP2E=;
	b=S3AzDsumvE0ST9d1k/dn1gg6LT+YHN/tv8zlpNvf620Mj8M71rRNKMZch1UJpR8I2yivko
	B0e/BIqeyAQ9sMFxG2QIoqfsMI1tzTR/HKOCGijdiykZ+Lxq4URkrEu5xz8bHKpW1jclx+
	3wmVAQBozZGrruqVnJ/aG3bTtoYkm1aIrhXTfyOUjQ65qx+d62tW8r+Ykw/mIP9xukU5Sz
	FnXyN//ggzPl8kOqytnExm3mHF99sFMeC1TYKi3aHdD6bqkJcd9iFOjIhbgvuuH2kb7gVj
	yZ7T4a65AKL2aaW72Mku24IkCnSMzX4hk37173OcoBicw8rYFvrU8nZkvqtzpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729197182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0fzNHxfo5C+op4LlDhECvnWdn7IDtTi4f0FYMN7PP2E=;
	b=NLjcOdraZkdwWae8G2SnkKfXT6hfZr9W9XImhuvGWoTe+28XhKnQ0i7P+Z+h6nSYxU9SJs
	8aekMa4faPQcj+CA==
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, Zijun Hu
 <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] genirq/devres: Simplify API devm_free_irq() implementation
In-Reply-To: <20241017-devres_kernel_fix-v1-1-4aa0d7c4fee4@quicinc.com>
References: <20241017-devres_kernel_fix-v1-1-4aa0d7c4fee4@quicinc.com>
Date: Thu, 17 Oct 2024 22:33:01 +0200
Message-ID: <87y12m8o76.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 17 2024 at 23:16, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> Simplify devm_free_irq() implementation by dedicated API devres_release()
> which have below advantages than current devres_destroy() + free_irq().
>
> It is simpler if devm_free_irq() is undoing what any devm_request_irq()
> variant did, otherwise, it can avoid wrong and undesired free_irq().

This is confusing at best. What's the wrong an undesired free_irq()?

Thanks,

        tglx

