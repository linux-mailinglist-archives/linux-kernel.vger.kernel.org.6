Return-Path: <linux-kernel+bounces-570892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2FFA6B5E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CF9189C563
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD1B1EFF93;
	Fri, 21 Mar 2025 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="w0rYLhRJ"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774671E991D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544930; cv=none; b=iKNiu6yp0eX4ZmhXfbKNnZlAI0pFAkzwN2pspl4kAYVAJ6Ph1dGSMnJz3gJ12uyJ6sX87iOlvAMMcz0Wvsc4lUhGWFA361aOF76kVUc0P82PIWO61uiBZbqTSNRT8+bzGlVKZP+fK4u7M1yLPvuruGZN2EaFO6kZ0ggtc0pzUYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544930; c=relaxed/simple;
	bh=d6ILCZZssy97zc5fURHqUsCaBvkhMm0Qn33u5P5AIrY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JssQ/e9pFD92DbN/hqX79eFxmTODXKDMn0PD6+/OI0XlAWwXlPRS1JfW/HkSjweQjBNtOczvfabm74xWPkRx5zw84KzK/akq549ra4NsVixq9Wy4Il2CBlgZc/TuIvyQfFMzzlXRym9X/DDfm23+jY4k6UsZDHn8OPS/gvk0MsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=w0rYLhRJ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52L8Euuv2541398
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 21 Mar 2025 01:14:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52L8Euuv2541398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742544897;
	bh=NxSlo284Cm1ijdBKAZxqPOJ6SDvYvA0rTpktQYQy2nM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=w0rYLhRJJJAGoia7Puqd8EzAX3UTgYCjWBki+1Du1iiixdfHWO7X8gszn+H5fn/Yg
	 Cx+p1IlPTw+1e0MzLgpE+chc6YH7E3/PeRYqBrp6yMdbqTsOKkGWDmAxBlfqiaa/Xs
	 oIua98g7L7JJZRrToqEHLRz2CPXjqkZgmHzlb0fml/Epby/VQjil+zdx+UbNJDDNMy
	 JtErZNdYi97XaQaCkAnBTxx0m5JI/fsI9VsPXuuuouSst/B16X4C2374dcZNngktmo
	 k6JTxCiBiuQ4AVdWrT+voHkeQuo2q7xZN2BOA5BPQTV2kPYyLBal9WnaDU8uzX1DTe
	 I1iY2asmUAHSA==
Date: Fri, 21 Mar 2025 01:14:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, Brian Gerst <brgerst@gmail.com>
CC: linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, peterz@infradead.org
Subject: Re: [PATCH v3 3/3] x86: Zap TOP_OF_KERNEL_STACK_PADDING on x86_64
User-Agent: K-9 Mail for Android
In-Reply-To: <8b920da6-0c9a-43b4-bd50-79c057a01932@zytor.com>
References: <20250319071009.1390984-1-xin@zytor.com> <20250319071009.1390984-4-xin@zytor.com> <CAMzpN2jFv8KE97ymEWAX1setxdgXy0jZGn_7JVp9fFEBfZ2ynA@mail.gmail.com> <8b920da6-0c9a-43b4-bd50-79c057a01932@zytor.com>
Message-ID: <1106B557-4AA2-410F-A990-C0C3BB7E675B@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 20, 2025 10:47:25 PM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 3/19/2025 12:17 PM, Brian Gerst wrote:
>> I'm not sure it's worth fully removing TOP_OF_KERNEL_STACK_PADDING for
>> 64-bit if it results in needing separate definitions of
>> task_top_of_stack()=2E  Leaving it at zero is fine=2E  The other change=
s
>> are fine though=2E
>
>Let's leave it to x86 maintainers ;-)
>
>But to me, TOP_OF_KERNEL_STACK_PADDING no longer makes sense on 64-bit,
>and it makes it simpler to remove it=2E  On the other side, 32-bit is to
>be zapped=2E=2E=2E
>
>Thanks!
>    Xin
>

For what it's worth, it was there as 0 before the FRED changes, so =2E=2E=
=2E

