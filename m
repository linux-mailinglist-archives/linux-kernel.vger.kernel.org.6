Return-Path: <linux-kernel+bounces-228860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 173F89167DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04921F277B5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F401814A4C7;
	Tue, 25 Jun 2024 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UBFeK08P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kxXP1j8e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D713B2A9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318673; cv=none; b=oEy42pMXZDr86aRflB4Hnaim51xsaZ5Wi0aQWYEWm/KgxUpb/6ekYUZbxgaruesP6NGhHWnHgpbokiIjhidcdc6xPItiu565UhfYJbgboH4zx3Mf+IfvK866THyKedGeHXN1xpTPkt8uIcfmt1qS8+LVMsCW9oqnY6h2tQogXXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318673; c=relaxed/simple;
	bh=PeHagsxKzjxwLdWOV4lkwGNCbtPK2Ze0OFmXyLu4q34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QeFP+LLNVSrwtMTiwBu2Ci2XWbHqdiS0CSunSI7aV8xDrAqrm3U12yIuZZXYwO5PQB489/rQesZVf0SWY3kdsIvfaewPkKoQtnEs+lxSvcsXl8lw3zvwFZjy/yu3gjPXq/00McCeaRAXS3FPuoimVGaSEcSWnlTnbU+NJOnjNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UBFeK08P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kxXP1j8e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719318668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Akgk/QsPgStwF9UJyy8HLB4YhLw0hiLKSouqo01a4jo=;
	b=UBFeK08PiEF5Mqm5uuXyIm2TyAKUQMESNTCPPkjk4kxDe4fYP3NLBJkHyDKaJoN6fs9Fid
	nGUPHpa63lZjFzyj7O5BZsz1umvB+oiohjyQjcJqPVCOZLyCBZoinWV8vfo854YRANFLkq
	p/l7e9n1QCFatu+ZSeO+fHs6CoSa1B3trB49fp8NBhsSxO056QZCb69UeNUk15xDcvtmWc
	+8PJOkS2W7rjLt76QZAYtd78AknEjTpEqb5fteCH3zPBYh0vc8Pe2UxEYGv/I5GEhInqlS
	DXbrP1HJzbBGqqbuLqL9aKe4NMuWTKaPSq5GsP0TpJh8ZXE3LFA481gv25U6jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719318668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Akgk/QsPgStwF9UJyy8HLB4YhLw0hiLKSouqo01a4jo=;
	b=kxXP1j8eZNTyr+NgvS7TSgDqTV2e/j4sQNBDtiCkDbKdtZGscX8n7shIFjb7bH3ctRqbyA
	OXw+mZgbJy4GvaBA==
To: Xin Li <xin@zytor.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>,
 linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Xin Li <xin3.li@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] x86/fred: Always install system interrupt handler
 into IDT
In-Reply-To: <dca1635b-1e08-4dbb-9dbb-335cbdcf9b9d@zytor.com>
References: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
 <2f632ef59c8c9cc27c3702bc2d286496ed298d65.1718972598.git.houwenlong.hwl@antgroup.com>
 <dca1635b-1e08-4dbb-9dbb-335cbdcf9b9d@zytor.com>
Date: Tue, 25 Jun 2024 14:31:08 +0200
Message-ID: <87jzid5hmb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 25 2024 at 02:19, Xin Li wrote:
> On 6/21/2024 6:12 AM, Hou Wenlong wrote:
>> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
>> index d4f24499b256..daee9f7765bc 100644
>> --- a/arch/x86/include/asm/idtentry.h
>> +++ b/arch/x86/include/asm/idtentry.h
>> @@ -470,8 +470,7 @@ static inline void fred_install_sysvec(unsigned int vector, const idtentry_t fun
>>   #define sysvec_install(vector, function) {				\
>>   	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
>>   		fred_install_sysvec(vector, function);			\
>> -	else								\
>> -		idt_install_sysvec(vector, asm_##function);		\
>
> empty line, it improves readability.
>
> And please put a comment here to explain why this is unconditionally
> done for IDT.

Wait. If we need this during early boot, then why don't we enable FRED
earlier?

Thanks,

        tglx

