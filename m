Return-Path: <linux-kernel+bounces-251467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2E7930538
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 12:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E6D0B218DC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 10:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D166EB5C;
	Sat, 13 Jul 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FGAZR++f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D96QLQRM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B3B17591;
	Sat, 13 Jul 2024 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720867338; cv=none; b=HLcsw17H31LiEz5rKOE5LRtG2VGEBSd4+++q5fEOjEGVWuWfFe0ojiJUdsV6Cdd6jJKONl6tC8kgyEl1wo5CRvzYb3f6iH8pLMBXz4EDo7Xu1YW09LtvJfEgQe+a20ahoI2RxFtHVqnFl9Ge5xeyXDZSjUG7tUMThxbnm+QIaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720867338; c=relaxed/simple;
	bh=y7jqFO0gZzs0YILOCFCo+p42NdYxiutzM7qKJ4bJR9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=APplIHhLkugexBrAJODHG3brP2w0bN3En7UneCPhTq+i91fOL3yck5Ai0FstPD/PX1G5rb8RVkg7B6uINv9ZAcfH11Go7SJawpQ3LRGowdvNwzcECoMOSsWufEYxB+yz2ONyYaYO/EN3h7zPW4iurUyKPk6RJJByX19dvlWZZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FGAZR++f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D96QLQRM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720867335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nf78z+ot0DcB12FLGp27PqqquDVnJlnIDmODNL4yRjQ=;
	b=FGAZR++fLXkA41w42NmRuvHcAvq5zX3sjoB7pvVXp3YcXdOD13trrThDA0NA0dZUaoqhhF
	2oirRpWxDwwYP8iZzcMyoEsPu2T7BXe6lKaI3EqrZElS/+UlvmJV6l1F2+xFu8HrKy0D4m
	awmft0VxgEahAedrmUlfUGkiaH//WMMO5rjE46G8njvMheGpY5ASaPR3RaVWLIQN5T61R4
	vEnA5SY5PgAhPk77lVDqASPzP8gwS3QAdXX+B9DsJwM1J1Mkg3mAPa+Z4TMnh5OYsrffst
	506bJAT2icEKq5urMl+HuQqnwrVqot52KyxULJpqWJoJ9H3CyqNdj37dn/kKtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720867335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nf78z+ot0DcB12FLGp27PqqquDVnJlnIDmODNL4yRjQ=;
	b=D96QLQRMmwhgfBHjBjxFizYhXkYoDi0RIMdgG2S9uhHQQowec0c4Yt4SfdC6iMvVcwyn1Q
	uLviHfVJmbGjC9CQ==
To: Vignesh Balasubramanian <vigbalas@amd.com>,
 linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
 ebiederm@xmission.com, keescook@chromium.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, bpetkov@amd.com,
 jinisusan.george@amd.com, matz@suse.de, binutils@sourceware.org,
 jhb@FreeBSD.org, felix.willgerodt@intel.com, Vignesh Balasubramanian
 <vigbalas@amd.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 1/1] x86/elf: Add a new .note section containing
 xfeatures buffer layout info to x86 core files
In-Reply-To: <20240712094630.29757-2-vigbalas@amd.com>
References: <20240712094630.29757-1-vigbalas@amd.com>
 <20240712094630.29757-2-vigbalas@amd.com>
Date: Sat, 13 Jul 2024 12:42:14 +0200
Message-ID: <87plrhshdl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 12 2024 at 15:16, Vignesh Balasubramanian wrote:
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 1fb83d477..cad37090b 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -13,6 +13,15 @@
>  #include <asm/auxvec.h>
>  #include <asm/fsgsbase.h>
>  
> +struct xfeat_component {
> +	u32 type;
> +	u32 size;
> +	u32 offset;
> +	u32 flags;
> +} __packed;
> +
> +_Static_assert(sizeof(struct xfeat_component)%4 == 0, "xfeat_component is not aligned");

This struct is only used in xstate.c and asm/elf.h is not a UAPI
header. So what's the point of declaring it in the header instead of
xtsate.c?

If this needs to provided for user space consumption, then it want's to
be in a UAPI header, no?

Thanks,

        tglx

