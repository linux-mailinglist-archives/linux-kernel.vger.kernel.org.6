Return-Path: <linux-kernel+bounces-398819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8C9BF66E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2535D281684
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C6520968D;
	Wed,  6 Nov 2024 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EV0mPs2H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B224F18FC70
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921263; cv=none; b=hINusbZ/WXLDAoe/mK6apN+T/zqcbOFvq5hVHhYbxRFoDE1uptgXyDomHx9cosy2VVH8MqMHenOGOwZUpR5Kj42DGyx3ZqAaaPQEmL9t1jNKci9TCTosUhuK3qZZFAj03mBm65gH7jLAFLOlMswA1fB+juq/gl56VafhcfDAukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921263; c=relaxed/simple;
	bh=964f0vnBn0U7l025wWv8wsqiBVb5YCxcf+9jmpibXUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OV49O/wO2bqyvW8i3/t+GIc+p2qXvxhex5HhwseKN3HUGJhLZasnFA79DWBfK6WZ8Z2XBWz5AH9gw+jkyUGhToG84QDwwGUb60W56R44qzJkAA7qcOF8ZbbzXh3oit7Q4Cey6GsjD/+rGQ6j1Ul0wmJUaP86OaJie12QIfG1Y7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EV0mPs2H; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730921262; x=1762457262;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=964f0vnBn0U7l025wWv8wsqiBVb5YCxcf+9jmpibXUo=;
  b=EV0mPs2HZGHxm6CcMj3+bjI24DqzshSG/6k8d7k9b3aM0uZV9hLbT8o+
   mYaCiQiFBhD83wzqMFpzBC2jCK7T7G0IkWnm1vpe/vc34y7ieyDK6NbkX
   +1T3LLWgYGWSs8duWF1Xj9HMOnkZBflIeyHCVTM7WwQuhg/gVlomhuKB6
   FS6NRj4anDKOZ/IxJ2ROLgg8+oK8oKxJtM3A0h3EBRzynKxlNalXxDasT
   c9c1mgHPGLf7NLQLmksSKbRMsj09uUrA1p+LTutgpVCfQ3roXphQz6nQ+
   QVSxr4uwux24opCGNReHRSc6u2WnmgMgeJlM22ePIyhAjq3AKIDwLi4ma
   g==;
X-CSE-ConnectionGUID: dGKVwU2FSD+XXn3/hs/25w==
X-CSE-MsgGUID: 6FUp94DwT72584KIZ3b/WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34439472"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34439472"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 11:27:41 -0800
X-CSE-ConnectionGUID: S4pI/gyBTzmhITrBj8l6/g==
X-CSE-MsgGUID: inBs60rVTM6qJTNvLiEdEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89305776"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.124.222.69]) ([10.124.222.69])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 11:27:06 -0800
Message-ID: <4d484280-3bed-453f-b2f6-0619df4e9914@intel.com>
Date: Wed, 6 Nov 2024 11:27:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Restore PKRU to user-defined value after signal handling
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Rudi Horn <rudi.horn@oracle.com>, Joe Jin <joe.jin@oracle.com>,
 Jeff Xu <jeffxu@chromium.org>
References: <4225E088-6D34-421A-91AA-E3C4A6517EB7@oracle.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <4225E088-6D34-421A-91AA-E3C4A6517EB7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 10:33, Aruna Ramakrishna wrote:
>  static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u32 pkru)
>  {
> +       int err = 0;
> +
>         if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
>                 return 0;
> -       return __put_user(pkru, (unsigned int __user *)get_xsave_addr_user(buf, XFEATURE_PKRU));

Let me try to summarize that whole email:

The existing code updates the PKRU value in the XSAVE buffer.  But it
does not update ->xfeatures[PKRU].  If ->xfeatures[PKRU]==0, then XRSTOR
will ignore the data that __put_user() put in place.

How does ->xfeatures[PKRU] end up set to 0?  On AMD, a WRPKRU(0) sets
PKRU=0 *and* XINUSE[PKRU]=0.  Intel doesn't do that.  Either behavior is
architecturally permitted.

Did I miss anything?

But the suggested fix is just beyond hideous.  Can't we just use the
mask that xsave_to_user_sigframe() generated instead of reading it back
out of userspace three seconds after it is written?

static inline int update_pkru_in_sigframe(..., u32 mask)
{
	u32 xinuse;
	int err;

        if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
                return 0;

	/* Ensure XRSTOR picks up the new PKRU value from the buffer: */
	xinuse = (mask & xfeatures_in_use()) | XFEATURE_MASK_PKRU;

	err =  __put_user(xinuse, &buf->header.xfeatures);
	if (err)
		return err;

        return ... existing code here;
}

This probably means moving update_pkru_in_sigframe() to the end of
xsave_to_user_sigframe() instead of calling it after, though.

But either way, this is all horrific.  It's yet another reason that the
XSAVE architecture complexity hurts more than it helps.  We want PKRU
written out here, dammit.  We shouldn't have to ask the hardware to
write it out, and _then_ go back and do it ourselves.

