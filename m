Return-Path: <linux-kernel+bounces-391962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA389B8DE6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99AF1F2252B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4038157476;
	Fri,  1 Nov 2024 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sTh0cz9j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8PKH97nE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35ED155CBF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730453510; cv=none; b=LWNh2zA7BW7plyO9yLyj3pwdwYOWK384lnbRLWihj7di9w2S0sosmqi6iIHp8pSGy/AKnns97vTmjx8AzcsSADTa+WoAnUx9ar2rnXB20LPaCR2EBi+Ef0eNgYnUaUA8AnRfgUbKVC0cTyM0QkbOQgNerHQQRMHxUbbs3JAu0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730453510; c=relaxed/simple;
	bh=Ba3BInQZn1PGQMCv/ZFULXKYg0kJX07kkOjSP4Zgpxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FzMSZMtZ2TWSiTkHkBGqDtONGhTaIoAWGSPU1O2DOG52csCt2wqjvuQnIN2WDokDXlZiVPSCHqREF6W2wGEoIudY4VeGxwy+RwOqmoyjdlFzGSpvDwfubNbHUbj3kbRsk6uBQyJJAg+xBJ1+8r2zXMvmza5QP6VsywR9mWGBC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sTh0cz9j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8PKH97nE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730453498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bRtXYp9uSZhyFJ6aIO9ndrZ8PxfKsSbAu5n2VyXKSrA=;
	b=sTh0cz9jeEjl/nHRPDp3Zy7VsXBFyCthyomq9SR6Dzx2W6EgBML4YQlaeqZgLmPQiIIbsn
	JNroU4CRQVUCEitpVuFWa4MtnOyy5s+26iOJtCMfn3yawgWCIOFVJ6h0A/3Kfr4wo68LAb
	AghTIjIV/r/0WQfwMhtFHNSgjJ7iJvMlal8B80tQ4qMnRgn8DuEM/aIZORmwyxAwKh9LFM
	N8tsHk3R7eSWg8OsWMT+BACj99/tBemsSdWJdvKs/CGpidaFkUY6LZhFDTGnjjo2tFkraa
	TRsYu/K2GjVXy/7LinOfr5bH3qzv67Npjix2UyEo5buI+z5GotGdR5MkZsGwPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730453498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bRtXYp9uSZhyFJ6aIO9ndrZ8PxfKsSbAu5n2VyXKSrA=;
	b=8PKH97nEM3rOHURhaR6S+L7+WYJKlqoAcKnJbk65kf3FjXuNkqnFRRWnpIDWO60iGL1eT3
	mmO7IsCy+ZyufBBQ==
To: Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, sudeep.holla@arm.com, peterz@infradead.org,
 mpe@ellerman.id.au, linux-arm-kernel@lists.infradead.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 pierre.gondois@arm.com, dietmar.eggemann@arm.com
Cc: yangyicong@hisilicon.com, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, morten.rasmussen@arm.com, msuchanek@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org,
 jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
 linuxarm@huawei.com, xuwei5@huawei.com, guohanjun@huawei.com
Subject: Re: [PATCH v7 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
In-Reply-To: <5617934d-45ac-509a-510e-d96d52a2ebf9@huawei.com>
References: <20241030125415.18994-1-yangyicong@huawei.com>
 <20241030125415.18994-2-yangyicong@huawei.com> <87ttcty71m.ffs@tglx>
 <488d8289-b538-01cb-5de7-d691f49c0d7b@huawei.com> <87frocwg64.ffs@tglx>
 <5617934d-45ac-509a-510e-d96d52a2ebf9@huawei.com>
Date: Fri, 01 Nov 2024 10:31:37 +0100
Message-ID: <87h68ruwp2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 01 2024 at 11:18, Yicong Yang wrote:
> On 2024/10/31 21:33, Thomas Gleixner wrote:
>> cpu_smt_control is not guaranteed to have CPU_SMT_ENABLED state, so this
>> argument is bogus.
>> 
> sorry for didn't explain all the cases here.
>
> For cpu_sm_control == {CPU_SMT_ENABLED, CPU_SMT_NOT_SUPPORTED, CPU_SMT_NOT_IMPLEMENTED},
> all the cpu's bootable and we won't check topology_is_primary_thread().

You don't have to copy the code to me. I'm familiar with it.

All I need is a proper explanation why your topology_is_primary_thread()
implementation is correct under all circumstances.

Thanks,

        tglx

