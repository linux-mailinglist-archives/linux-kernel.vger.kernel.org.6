Return-Path: <linux-kernel+bounces-557812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB504A5DE20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A4F167C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E8E24501B;
	Wed, 12 Mar 2025 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b="Vx7qBigk"
Received: from mail.mixaill.net (mail.mixaill.net [144.76.234.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746CB5474C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.234.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786580; cv=none; b=bTqJX6ms4keTeGjDFS+cvBptJCW0N/zbnCgym6pvGB1TjpeUKHJzrZSydz8rkS8GU+8WxMuux8CgHC1FaXHcN0zoL+D9rgbmKVsNaqfV3STvYPIcS48tedZjCI1++f4mA/yQP3cMUNP+efO7xrXQzJw2TEfbQUbunBnoegqvhG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786580; c=relaxed/simple;
	bh=cP9TOort8UDbRdFcMVU/1z8wOgpvIIaKCmiC9n52nto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxwuTbRrj9GOycv+qDRACk4dEhda672wrwLdxVzYfhV+rg9SAGW+Aps93E2pbBgSaYe+T0NqLogQfw5YE13x/Xawoovbb+rYN1L9Zrel3HB6QZ2DfNTifXWlZRn+e4n3hd9ob4WjhkkIXbx3X7VbQHV3RGIpfYgsuQVEW2Vt8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net; spf=pass smtp.mailfrom=mixaill.net; dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b=Vx7qBigk; arc=none smtp.client-ip=144.76.234.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mixaill.net
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A89D661BAD;
	Wed, 12 Mar 2025 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mixaill.net; s=dkim;
	t=1741786576; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1kJWyf2G03T60ssCrbVlJjK2wYFQEcclWEmwastU/so=;
	b=Vx7qBigkIRMstljmFMtGAPjgc32inVOFbaOnDfTOAuLv/HVi7uoTwWA/hyYtaDjO9mHNQe
	5xHIKOA+7+ujOPAkMmE2q0fSg8Fy6azEZpGjlZNOStr8gRZDn83bms0ze3FAM7X0gqK43E
	WhIOXeGN0b/LviVWekrvi2b7A+Px8eUm21n5JLbXYwP18ds5B59fQrEcr7hWp1xZCi+gsY
	ixP71y3WICBg0UMp5Gz5TjTsmmhJMXngLnMpnt/T15HDtta3XCTaEg6ni9ZI8HEhPLEiTw
	3GZ7KST6UyAcaizREIr+J+qdNn1TWiWWMRGiAeOyRNG5xPFIjzZ5mG8pb2kv3g==
Message-ID: <2916bccf-a252-4a57-bb4b-efb8703fd909@mixaill.net>
Date: Wed, 12 Mar 2025 16:36:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/rdrand: hide RDRAND and RDSEED from CPUID in case
 of a malfunction
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250312123130.8290-1-me@mixaill.net>
 <20250312123130.8290-3-me@mixaill.net>
 <20250312124530.GDZ9GB6vscPTpDv8Aq@fat_crate.local>
Content-Language: en-US
From: Mikhail Paulyshka <me@mixaill.net>
In-Reply-To: <20250312124530.GDZ9GB6vscPTpDv8Aq@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 3/12/25 3:45 PM, Borislav Petkov wrote:
> On Wed, Mar 12, 2025 at 03:31:30PM +0300, Mikhail Paulyshka wrote:
>> @@ -46,6 +47,8 @@ void x86_init_rdrand(struct cpuinfo_x86 *c)
>>   
>>   	if (failure) {
>>   		clear_cpu_cap(c, X86_FEATURE_RDRAND);
>> +		if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON)
> Hygon is family 0x18. Have you tested it there?

My bad, I thought Hygon is backwards compatible with AMD Zen1/2. Then it 
can be removed in case Hygon's MSRs are different.



