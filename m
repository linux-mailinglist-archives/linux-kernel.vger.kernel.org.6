Return-Path: <linux-kernel+bounces-573476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5726FA6D7E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89FC16CAC3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13A25DAE9;
	Mon, 24 Mar 2025 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gZjgEk17"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1305925D91A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742810365; cv=none; b=HyfqUhuo1r0pGK83N1eU5LFykT3A+tVvfS4HnXLON7EqtEZ5fyKQaaBBaB+BKAp2SOY6mIH0AgL+tUXNSsN3c0sNgXFcEbQ4s25y2YdW9JphjJ6kjRbj/IJ2LkIPFmXcMdL+fSXa4D05m5FTrSRBC/+eDZ4oPEHfFICyeI/vkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742810365; c=relaxed/simple;
	bh=vWTVDvcU0o4L768ZMZZd6FAcvB7K627DBPFsUxxwneQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMmp1yobUqqkWaYB5MmxRntJ3zbl80rc6j6fCGtCqW+mjTBjxJuOTE4pMsx6a32052DjJWFhD+IkIyWdtisuhSnrjqi4Bqiqkxtyxhjg7SesAfRDEI1gB7GlVLU2Ddzy0oSH3SYHhZQakVkClJmX+TcIWj2CvGIfKKI/7r1ZOBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gZjgEk17; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so3495704f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 02:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742810361; x=1743415161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0x1szqNluXRdFHlnkhxeTJTRaNEPeNMvCPbIRkxMkzc=;
        b=gZjgEk17zuKGNj1ecdCFISzpLge3bWXTcR+ynZohf/uW+i9gVHkRy/NolHDGZX+AuD
         UytVwnGnK0Qd366VF+DCmGq0E8FZTpGn0mMVgN5+AGLsXKoj2v87iUWHTGwwd51vmtYu
         +142gCJt2p8EEOZ20qzPj8rRPVdTbE/bHdY1JX+oZhle/Pn6peTac855ZBhCpmlFsXEF
         gIscXiyun5qvPQf/kXsGH47B+/pR5qLOoDe+N0JK7/Xs0YfDB5Cws/ipuQm/bgp/x/z6
         BEIdmnMflBzGtWQ8p4WbIgwGk3InJkcWH4LfBXgBh2szaqfBG8aXcl7HNadxYef0tEZn
         ysvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742810361; x=1743415161;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0x1szqNluXRdFHlnkhxeTJTRaNEPeNMvCPbIRkxMkzc=;
        b=vDbNzQHvHSbPzI5nto+MW1Rl8ScWbDHAf+6ctMnSz5Ujll4QWctTlO5eW8x714PGLw
         5Boqx+taNktwHoUPO9uK0FJjZpvVMbzmP1eU56kGpAFlTrO5peq9jE+9YWqN1w0Tw51e
         JqoNinDTyarWPIWV6/ynfalMdLM7VS+CEzkgWk8wCNjaPYJqnt8PGIDFmO6a57zTkuci
         fY+In+2PwDER85gDxKYoRFDs5oUDhGU46Dl4mkYtZX0RZApQ6NQSVQyS/jifYfpx6bym
         dPAZeYY0jkjwaNAuIVifWC4TULE9NDqZXWvJHzVBk4Qc4OJyeznae/OvN0Fijtk26UbJ
         ROgw==
X-Forwarded-Encrypted: i=1; AJvYcCWiSN11G9OvtyQnv7qi9CD0JXaYXtYq+X9E1RiwshB7/NRQv3POxJhksSLN1k8RQrQglLY1q6m3XZ+cVjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt/e0ctav2Z0nfHIdaj7nh0m8XDtkmGXM+ejShy4DScmERkY4d
	Knvk59Zdej623hyyBW2Y/l4+k3Qt4Qm4QU1v7mE5XF1086Z6qSt623MEG9LYY38=
X-Gm-Gg: ASbGncsh+c/jobsAJsGI1DvemtAIGrWoEm9FK0wpVPhWGlp4lTVrlkGQziLwO+E9ani
	ochSsaf8ei8G5xI7s07RIX/4c8892IBITfGm3xp26k9tcUdHAUsMbMJHFZ0EoHY4ndeSCRdxd4Y
	obvGAlrh+qw7+j6Qh8q5RG07ISGogo5n8MeDCKdoBO3I3gngIDRsht/u0b615pb23oZ3Z7v6RZC
	N2oGunEpGEpZK7YIz7jOMw8fU9xWvfy+R+sgwrrwkrt0YHlYbEVgifXCpYrhzlBRUXTy6IJI0LY
	O36Rj+DTMqCOxfPoqFi7GDeV1Tnbk873MAIsHodBZE0BDVR3o2l5oOjPXEd/dFmRCj4ls8/BeTw
	4MZcRxmI=
X-Google-Smtp-Source: AGHT+IEZBXb8In+hm/mlMuQwYUbtYes821tRtjpaqkfz/8npTdiwCyS93ktKfkIKoFtyGe+iN/UeKQ==
X-Received: by 2002:a05:6000:1867:b0:399:728f:4673 with SMTP id ffacd0b85a97d-3997f91bc81mr12810206f8f.33.1742810361176;
        Mon, 24 Mar 2025 02:59:21 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.139.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fcea6ecsm116116715e9.5.2025.03.24.02.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 02:59:20 -0700 (PDT)
Message-ID: <327a23d5-d5c4-4227-aafb-9d4ddd90289e@suse.com>
Date: Mon, 24 Mar 2025 11:59:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] /dev/mem: Disable /dev/mem under TDX guest
To: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com
Cc: kirill.shutemov@linux.intel.com, linux-coco@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org, vannapurve@google.com
References: <20250318113604.297726-1-nik.borisov@suse.com>
 <67d9c447ddcfd_11987294c6@dwillia2-xfh.jf.intel.com.notmuch>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <67d9c447ddcfd_11987294c6@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18.03.25 г. 21:06 ч., Dan Williams wrote:
> Nikolay Borisov wrote:
>> If a piece of memory is read from /dev/mem that falls outside of the
>> System Ram region i.e bios data region the kernel creates a shared
>> mapping via xlate_dev_mem_ptr() (this behavior was introduced by
>> 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()"). This results
>> in a region having both a shared and a private mapping.
>>
>> Subsequent accesses to this region via the private mapping induce a
>> SEPT violation and a crash of the VMM. In this particular case the
>> scenario was a userspace process reading something from the bios data
>> area at address 0x497 which creates a shared mapping, and a followup
>> reboot accessing __va(0x472) which access pfn 0 via the private mapping
>> causing mayhem.
>>
>> Fix this by simply forbidding access to /dev/mem when running as an TDX
>> guest.
>>
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>>
>> Sending this now to hopefully spur up discussion as to how to handle the described
>> scenario. This was hit on the GCP cloud and was causing their hypervisor to crash.
>>
>> I guess the most pressing question is what will be the most sensible approach to
>> eliminate such situations happening in the future:
>>
>> 1. Should we forbid getting a descriptor to /dev/mem (this patch)
>> 2. Skip creating /dev/mem altogether3
>> 3. Possibly tinker with internals of ioremap to ensure that no memory which is
>> backed by kvm memslots is remapped as shared.
> 
> It seems unfortunate that the kernel is allowing conflicting mappings of
> the same pfn. Is this not just a track_pfn_remap() bug report? In other
> words, whatever established the conflicting private mapping failed to do
> a memtype_reserve() with the encryption setting such that
> track_pfn_remap() could find it and enforce a consistent mapping.

I'm not an expert into this, but looking at the code it seems 
memtype_reserve deals with the memory type w.r.t PAT/MTRR i.e the 
cacheability of the memory, not whether the mapping is consistent w.r.t 
to other, arbitrary attributes.

> 
> Otherwise, kernel_lockdown also disables useful mechanisms like debugfs,
> and feels like it does not solve the underlying problem. Not all
> ioremap() callers in the kernel are aware of a potential
> ioremap_encrypted() dependendency.
> 
>> 4. Eliminate the access to 0x472 from the x86 reboot path, after all we don't
>> really have a proper bios at that address.
>> 5. Something else ?


