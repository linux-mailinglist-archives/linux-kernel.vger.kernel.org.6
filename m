Return-Path: <linux-kernel+bounces-209141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7698902DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02EB1C21A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2CA63CB;
	Tue, 11 Jun 2024 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyXFvBPA"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801D1C06
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718067687; cv=none; b=KIgFO3Efe+JbXoRsmXMT9PhNa/vcJQ2opZ+zpPeTen17LSn6v09lHZRRN0NwwKfdrCzWFXoumZMDkTnft80lmEee0eEBHvsUOghFYFFORqLMS9U+NwkzL90ReJql3iHcYBJYAcx+aVB1YDQaCDuCiHZi2cft6+rjFnI8pVCca7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718067687; c=relaxed/simple;
	bh=DGas9z7MXThnadiXv3ugauth7mz+wM97HrLiYPv1e5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZB3TPeeQnUilwyETXqEMRaYEhJWziS+sgWKora4TVnqV5BvCMxD/L3GmiHku2HCNPQPi62d7oBSCiSwBl7dFJCvffD0v/NZBJ6E40/oYcd7EuB1OiCPPMUXq9YqSy98Y174yAP+n4S0bZwKhUfSu4LX48cC/RmXroVrQ0DmRngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyXFvBPA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6ef46d25efso384267566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718067683; x=1718672483; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSNTtz/at1WTiMqb7i86cg24k7jE9tp+NSVg083Ut9k=;
        b=YyXFvBPA442Gn4inrTkFrzERB3/IjhngZL+nwGkXDlQy6ffmJO3qm8BOvKq4cJirnt
         RjBuqdsQrt3r9uoCqMev0aq9Sanog/2LtTfn1y0KVxE3kOKArrFoEauNFsrv5aMdQ2+V
         8pROfu/1r7fQXb9qzMKESvzhyrbhOISomNR3Q0EWQjgBMGMmvn4PxDncgMOEH8oztpjn
         w2iY6oi/XXyCfGpaDsZ9OilxL3VsrxKYFduVkKikWF1dkTrrMmuUGrhjLsXVGCh+S9lq
         LvJDfXM7l5XIwz4QZvrkwBBWVmPEevffbvTBGFNGwV6xydaJKzX0TJndjeETo3pwYY9t
         CndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718067683; x=1718672483;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FSNTtz/at1WTiMqb7i86cg24k7jE9tp+NSVg083Ut9k=;
        b=pdzLNP/y9shT8YHESDlkIk5FxX5QC+n+7hpfeuKNRsJlBlbEEKdnH6OMekdenNYfxG
         JqjrryFVMmRx2P97bJi7LiDSl6BGxt5rbOKxHFiSlVU5kM2y/rhpG5wZG/CZbItyZlOQ
         DP0+wr2Biu5YGJ1M2KLUXA3EAeaIGjwXv/8LF8hXhKT/lkmI2B3CvGFH/XFo69cXUO4K
         +o3VqQNGVl/mAKDFv/fW2YHQl53EOPK9Tm/uBh12L59Rr9zaVbMxdlm8dZ2czDJn58lA
         BG8BrLbTiFRnLLeWmAMC8cOspKJ3d2lVLP/qu9UdbMWhRgFVqX4XXbTZj+m3kA6B0LrU
         D/cA==
X-Forwarded-Encrypted: i=1; AJvYcCV0IVIQJg+T7mZToOrdF97xnVcJbxeK/o7ThuOjMQ3Ty/Mmp0DVlOuyDSb2Rz/AjndPREqkcQNZbEeEY2LpC2d97DQuRDO6jdkpRfcM
X-Gm-Message-State: AOJu0Yz5sJqvB2LaYmC0ScMRArqKghHOocMTodcAg1VfMyBH3lkzltJ5
	imjozqZOr7VisGYz2TtwZAl0AfsHeYUjWA74xIMmciwMZE7zQS5R
X-Google-Smtp-Source: AGHT+IFFffUltp37Z9nK2ZtPZUEWCPN0/mAsYCmDoJHL7XHqn9Fst112PCLQTkS03m497XXLVWx7eg==
X-Received: by 2002:a17:906:7741:b0:a6f:efb:b347 with SMTP id a640c23a62f3a-a6f0efbce1cmr405382766b.70.1718067682617;
        Mon, 10 Jun 2024 18:01:22 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f335878cbsm54218366b.214.2024.06.10.18.01.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2024 18:01:22 -0700 (PDT)
Date: Tue, 11 Jun 2024 01:01:21 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Steve Wahl <steve.wahl@hpe.com>
Subject: Re: [Patch v3] x86/head/64: remove redundant check on
 level2_kernel_pgt's _PAGE_PRESENT bit
Message-ID: <20240611010121.cvi3w62stj6g25si@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240523123539.14260-1-richard.weiyang@gmail.com>
 <9e9669a6-de37-4140-bdc5-7d660b8427c3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e9669a6-de37-4140-bdc5-7d660b8427c3@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Jun 03, 2024 at 11:50:06AM -0700, Dave Hansen wrote:
>On 5/23/24 05:35, Wei Yang wrote:
>> --- a/arch/x86/kernel/head64.c
>> +++ b/arch/x86/kernel/head64.c
>> @@ -260,8 +260,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>>  
>>  	/* fixup pages that are part of the kernel image */
>>  	for (; i <= pmd_index((unsigned long)_end); i++)
>> -		if (pmd[i] & _PAGE_PRESENT)
>> -			pmd[i] += load_delta;
>> +		pmd[i] += load_delta;
>
>So, I think this is correct.  But, man, I wish folks would go through
>the git history and make it clear that they understand _how_ the code
>got the way it is.
>
>I suspect that the original _PAGE_PRESENT check wasn't even necessary if
>cleanup_highmap() really did fix things up.  But this commit:
>
>	2aa85f246c18 ("x86/boot/64: Make level2_kernel_pgt pages invalid
>		       outside kernel area")
>
>tweaked things to actively clear out PMDs that weren't populated in
>Kirill's original loop.  It didn't touch the _PAGE_PRESENT check.  But
>it certainly did imply that the PMD doesn't have any holes in it and
>there's nothing int he middle that needs _PAGE_PRESENT cleared.
>
>> level2_kernel_pgt compiled with _PAGE_PRESENT set. The check is
>> redundant
>
>This isn't super reassuring.  It also depends on nothing having munged
>the page tables up to this point.  The code is also a bit cruel in that
>it manipulates two different sets of PMDs with the same 'pmd' variable.
>
>Also, is this comment still accurate after '2aa85f246c18'?
>
>>          * Fixup the kernel text+data virtual addresses. Note that
>>          * we might write invalid pmds, when the kernel is relocated
>>          * cleanup_highmap() fixes this up along with the mappings
>>          * beyond _end.

Hi, Dave

Do you have other suggestions? What do I expect to do next?

-- 
Wei Yang
Help you, Help me

