Return-Path: <linux-kernel+bounces-283324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343894F049
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F46CB267B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49FB183CC1;
	Mon, 12 Aug 2024 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WpQflbtO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+8xUFdCS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF0183084
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474090; cv=none; b=j3AIRStKALpPz1cFBLgmUSCy6vv3/JnXQprrksySmqNoCCNd6ICt2vOG0Ies2aaGe7eRcNj5V6COPYpTRreDsjN1QinCr/bNkjDA+FBgefUBZXcAfhPG5271s3mQ3py47uD73UyAfWIK98eg42loI9DlqCa8nysX58pawYvPnl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474090; c=relaxed/simple;
	bh=sjRWkMFtgOrI6DSoimkWFAC6VMdD00qV51LWcbTpxi4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DgW5HXNyPxvPiyGSRJknTRKDKWqFwVQQlUowTnOXbiErU+z/pemV/o6/VTHm4tFGxxGMl73z1dIChJUWQS5DVXwJDlrymbSj8m4u0d1eiovSC5tbbX7mMDVeq+WhIqBbJcNIe5j/lnftNHnH4PPAWPLIPNfinP8HaAbkiTJssSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WpQflbtO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+8xUFdCS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723474085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IgPz1/lnN9hiYM4TGQkGzZ9lzKLBrzylrC1Cvn5YOWA=;
	b=WpQflbtOqd9VUZZsa8Lgtfka4Mt1N7YX+w37vjkxJcNStqodCiZl/6+jpS9JzpINS7tfpx
	jwGBUeBrHUn1nbfmO5/aCVCLspRsHJTCTq0qfiejKdhjodqvijYPcjNPXl63rlds0JMlU2
	rMDtR+9ehLuz+saMlwucc5eFFyuZ6XBH2LE6sFXeHOHTkPqBCBYbTLDRvYut4zc0ypLXNU
	krBbQis1/z1NUT9jtLpTo7V2RG6VdRJZQc/J9g/DJdloyKHP+iT/4UQq2HR7tPSMgYIxzP
	hXXKOsz/61ogLEpEHaDa4+OCLsswOntVV925WN2PIZb3+QS/f54mkiKSjheAsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723474085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IgPz1/lnN9hiYM4TGQkGzZ9lzKLBrzylrC1Cvn5YOWA=;
	b=+8xUFdCS9dfKQfIRB8Xdxgcae6+TmHWphRtVe/6M+XL6eHW2mEqjv0YAQWiDf9/zK/cfuV
	qjl5yMkRCJ4MmnAA==
To: Yuntao Wang <yuntao.wang@linux.dev>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Thorsten Blum
 <thorsten.blum@toblux.com>, Tony Luck <tony.luck@intel.com>, Daniel
 Sneddon <daniel.sneddon@linux.intel.com>, Yuntao Wang
 <yuntao.wang@linux.dev>
Subject: Re: [PATCH] x86/apic: Fix the issues in x2apic_disable()
In-Reply-To: <20240812100819.870513-1-yuntao.wang@linux.dev>
References: <20240812100819.870513-1-yuntao.wang@linux.dev>
Date: Mon, 12 Aug 2024 16:48:05 +0200
Message-ID: <87a5hhsspm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 12 2024 at 18:08, Yuntao Wang wrote:
>  static __init void x2apic_disable(void)
>  {
> -	u32 x2apic_id, state = x2apic_state;
> +	u32 x2apic_id;
>  
> -	x2apic_mode = 0;
> -	x2apic_state = X2APIC_DISABLED;
> -
> -	if (state != X2APIC_ON)
> -		return;
> +	if (x2apic_state < X2APIC_ON)
> +		goto out;

There is no point in overwriting the state in case it is < ON, no?
  
Thanks,

        tglx

