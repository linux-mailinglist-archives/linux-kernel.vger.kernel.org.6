Return-Path: <linux-kernel+bounces-532297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F166A44B28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB357AC300
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA81898FB;
	Tue, 25 Feb 2025 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D5/fZUrr"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1BBEC2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511071; cv=none; b=S/vdZLRY4LdeEX7L8uQoCSikEyRDRIGNJZA8gqSFekSNvQmkP5ofXh6MAtfaY4cfk1NtpFsnadu5nBw/HE0AS6/Fg8xTGxFCBXnAqJR1Dk9zBAtxtsPyfLgn/8QIL5bUFWogirBhQCCwoINYzX+SubEdzkq7ymgrU6QHUcS8SII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511071; c=relaxed/simple;
	bh=rw6fkj7krREUaEJ9aGI8DkpSNHoX2Fsurw/g06u/GUM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bEjN0IJuGmspHAA+6tCr2/+iEuhCva0SNQUkfa0qlXuFS1cKA5VD4qUZKBz+4HpxvmZtEh9+lClO7cOPFRUBseg8QlWhInj17Ait7Xa+fIevfe95IIBhcNdQCg+rAmBK9KXyYtW6cNNf3sD6M9tou4CqKaRfXs38bHxcq8Rs0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D5/fZUrr; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740511066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eaNj3Zkdf3VSuIU89F1enXWb/g7fusbmfwskhEWAK4E=;
	b=D5/fZUrrw72tG9O7pSfZ/vFQRn1i4JuCmu0rDWFzsrPpTGKlRzkSsOkdSaw4u1PvWRHZG3
	Ecsg/yzQd9WjBZSmrv0E4ZC0aWrq68o8hr918totalx0j2rMlRN0zQZqw1gji/6RaOQ8Zp
	UMcHtmYgNIIp4DEtVs/9Qq3+8D7Gd/c=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] x86/mtrr: Remove unnecessary strlen() in mtrr_write()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <Z73HDk9p2P_Zigu2@gmail.com>
Date: Tue, 25 Feb 2025 20:17:33 +0100
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <35EF1145-7214-4B51-8168-4D54028BE0E5@linux.dev>
References: <20250225131621.329699-2-thorsten.blum@linux.dev>
 <Z73HDk9p2P_Zigu2@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 25. Feb 2025, at 14:35, Ingo Molnar wrote:
> * Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
>> The local variable length already holds the string length after calling
>> strncpy_from_user(). Using another local variable linlen and calling
>> strlen() is therefore unnecessary and can be removed. Remove linlen
>> and strlen() and use length instead.
>> 
>> Compile-tested only.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
> 
> I see no corner-case analysis in the changelog about what may happen if 
> the copy fails partially.

Hi Ingo,

I'm not sure what you mean. Why would I describe something I didn't
change? This patch only removes an unnecessary string (line) length
calculation and shouldn't affect the logic in any way.

If strncpy_from_user() fails, we immediately return length from
mtrr_write(), but my patch doesn't change this - unless I'm missing
something?

Thanks,
Thorsten


