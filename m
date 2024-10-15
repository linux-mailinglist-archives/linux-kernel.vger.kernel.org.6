Return-Path: <linux-kernel+bounces-365550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AD699E42B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82BD1F21B25
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237BA1E4110;
	Tue, 15 Oct 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="e4NJuH31"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9544683
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988686; cv=none; b=tMWJT++Piq25ccwHrZ0B7yp2XrkESVm6QQxT0dQmaY1y0l6QxhJxOP+71fGszTZFYC6QNKDJdjG0LrZaTL21MzVZucREIUSgii8e2EJ866ZZsQ0CaGVPhRt2BaUBp1zlBK/55++brFhmsZ5U7iswOKw0b6w7dSXlInRW+TXNI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988686; c=relaxed/simple;
	bh=sbYVBsMOuZ8OSgZN3VIKTxLph2t2IWWOMM0i//0E840=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SBuQ3rdQFf+Sv/fawOtAR/rxBeX5jwh6tjzra1zf9vc3254Sbc5lVIUmHU/+bxtCjKF/Oeq5qo7FepC/XspPYKR/QwDopKbd75p1OoMJT1oLyh96Qyhyv9lAyuYP5prqEaAwDK6WjmfUo49wStamnoLgmQCG+dC6cOFmWCAInow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=e4NJuH31; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8KQH4007049;
	Tue, 15 Oct 2024 12:37:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	o4wujNjsyAr/oziHHMv1TomMdx6alK8Rc8OFlafH9JQ=; b=e4NJuH315dwJ8n7/
	YGY11mL7yVPKLmIsSb1pdwnVtQYZbco3vyV9t5GZt+Ye9hBMeI/v2/NnbkMfFCk1
	RCjfV7ZRYN1wx7Goysl/rR7xQPBYLfYFbM7dQNSYDf87iwrOi+k2FypEUwOTgEDe
	+RIETaAP5z3fNXT0JCo2/+LJtLGXysFema7ZlE2snL8WHlnjleYsqaSjC8V4nqWo
	qLZtslBjxn89R4lXznW/SU4Bun+XYcJgamlgjmfyZzsEI9I7pTQ+RG3toJ2i6nqL
	iRUhKn6l1VxSGdxhSVwaRIvTzyxztHGtI1VO2/3TU3aWxZPqy+K3DdCG5/eH/dQR
	tw2MUA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4282p12871-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 12:37:26 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C303340051;
	Tue, 15 Oct 2024 12:36:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A489D21A689;
	Tue, 15 Oct 2024 12:35:21 +0200 (CEST)
Received: from [10.48.86.107] (10.48.86.107) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 15 Oct
 2024 12:35:18 +0200
Message-ID: <324d6a90-8f9a-4916-981b-ac1253f5057b@foss.st.com>
Date: Tue, 15 Oct 2024 12:35:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Crash on armv7-a using KASAN
To: Linus Walleij <linus.walleij@linaro.org>
CC: Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>,
        Kees Cook <kees@kernel.org>,
        AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>,
        Mark Brown
	<broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Antonio Borneo
	<antonio.borneo@foss.st.com>
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
 <CACRpkdaMMsHXkgcOtw0aC=SPfJJURCyCgzDq-rEXrBGaM44Sdg@mail.gmail.com>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <CACRpkdaMMsHXkgcOtw0aC=SPfJJURCyCgzDq-rEXrBGaM44Sdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 10/15/24 09:55, Linus Walleij wrote:> On Mon, Oct 14, 2024 at 3:21 PM 
Clement LE GOFFIC
> <clement.legoffic@foss.st.com> wrote:
> 
>> I have detected a kernel crash in latest kernel on armv7-a when Kasan is
>> enabled.
> (...)
>> Crash log with recent kernel (v6.12-rc3) :
>>
>> ~ # Insufficient stack space to handle exception!
> 
> The crash looks pretty "expected", as you say you start a lot of
> parallel processes
> and whoops, you run out of memory on the stack. No software can add more
> memory to the machine.
> 
> KASAN uses a lot of extra memory for intercepting all memory accesses,
> nominally one
> extra byte per 8 bytes. This is further restricted by the complex
> nature of the virtual
> memory space on ARM32.
> 
> That said, we increase the size of per-thread storage when using KASAN,
> THREAD_SIZE_ORDER is 2 instead of 1. Maybe the interrupt stacks need
> to be scaled similarly to manage the increased load?

Hi Linus,

Thanks for your reply.

Once I found the issue in latest kernel, with Antonio we firstly tried 
to increase the stack size, but it kept crashing.

Then we identified the offending commit and we noticed that it does not 
change at all the stack layout.
In fact Ard patch only modifies the way to unwind frames for backtrace.

As far as we understand, KASAN enabled causes the generation of several 
backtraces (hashed) on alloc and free to track all the allocation.
The offending commit seams responsible of the crash due to incorrect unwind.

Best regards,

Clément

