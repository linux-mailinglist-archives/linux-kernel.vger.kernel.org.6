Return-Path: <linux-kernel+bounces-371549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E269A3C89
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68851C23FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70832040A3;
	Fri, 18 Oct 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xVP+zijF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="32jQipiu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04ED203715
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249126; cv=none; b=BYQSkQzgpGXdeCWsLZ/mWXL+oEGbeLL80A1RqrpYiyM7TNBdvZY4erBPjiniVjGprPJwpBPb3lF2ZZXKFUNgl6U1VbNHN+L9K5J6dFRVU+Ystc+H8xMIfseaGlXhHZ2W/ed2dFDBuPzs49FyRTAZLKb/dfouoECwlKzV4fY1VRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249126; c=relaxed/simple;
	bh=Zci9NhizznmDP8zOHvL1ljcQifyuO53qkNj1YToqwrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ftbP3BmQC7xWfSZ7UyPkgPExltQS+zZ8VjmOwcb5ppqAFqRhSKpxJjhpQZY0hLLCOp39YNA4z1bl5vyfDpLmjKjgFvaocjY+/1MNkf0U8eM5RK51ZIcPcsPuXjE6758/GH8VQITuLBtBoV3FHj3sd70Dt6O/n0C8oADiBnprTDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xVP+zijF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=32jQipiu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729249122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cY7Z2ILlY45KvRvGjUJZg5hnmtu8rYMrlgrR+X6O5Xs=;
	b=xVP+zijFjFzBa05H9cKKBL7AR2C0oOJ3bXN/GfP+cLxOsWx+4QwNjR7mXgzmyS5ZLSlZQF
	FR4mcUQbtZQPgegSz3eGQ0aPdanf4M2M1fB+MxgtIxBT0Kmh4vpu7V3dYvrkNKrhrN7JxQ
	Cm4YMB29H2IKGhoLV7pMmCtWTxq/MEK0EsImmIxJAhMeCc3TCuUD3Vg5is1GNFCFce2GO3
	6rXrbOXqnmhyvoPAUVgpxfp7Of/fkj5l2G9dV/yM4ejowdhx80VNUqGzt0UEy6BrXth5Sf
	RSqpx/abHiLr+V8M1s0w1DpFA4pGKwg9ouEuNVno86qHM9YFxX3dU7uxYIzsgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729249122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cY7Z2ILlY45KvRvGjUJZg5hnmtu8rYMrlgrR+X6O5Xs=;
	b=32jQipiuFOPTF5JaIbtQQw/Vr0KAcLD6ejjY2RPGuaYSvsmQtCOG3y/pcIpEX/o2X17ENn
	ehQn1kD751XmVRDA==
To: quic_zijuhu <quic_zijuhu@quicinc.com>, Zijun Hu <zijun_hu@icloud.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/devres: Simplify API devm_free_irq() implementation
In-Reply-To: <fa7268e4-24a9-4ddb-8477-e4959a6105ad@quicinc.com>
References: <20241017-devres_kernel_fix-v1-1-4aa0d7c4fee4@quicinc.com>
 <87y12m8o76.ffs@tglx> <07f223e0-9a42-4637-a081-a057025e216f@icloud.com>
 <87sest94ag.ffs@tglx> <fa7268e4-24a9-4ddb-8477-e4959a6105ad@quicinc.com>
Date: Fri, 18 Oct 2024 12:58:42 +0200
Message-ID: <87plnx8yot.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 18 2024 at 17:28, quic zijuhu wrote:
> On 10/18/2024 4:57 PM, Thomas Gleixner wrote:
> if irq to free was ever requested by devm_request_irq()
> then both logic is exactly same.
>
> otherwise, actually change devres_free_irq()'s logic from
>
> if (irq is not requested by devm_request_irq() {
> 	warn;
> }
> free_irq()
>
> To
>
> if (irq is not requested by devm_request_irq() {
> 	warn;
> 	return;
> }
>

Ah, you are right. I thought there is a return there.

So you want to explain it maybe this way:

   If devres_destroy() does not find a matching devres entry, then
   devm_free_irq() emits a warning and tries to free the interrupt.

   That's wrong as devm_free_irq() should only undo what
   devm_request_irq() set up.

   Replace devres_destroy() with a call to devres_release() which only
   invokes the release function (free_irq()) in case that a matching
   devres entry was found.

Or something like that.

Thanks,

        tglx

