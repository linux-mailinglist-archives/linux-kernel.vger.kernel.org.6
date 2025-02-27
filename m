Return-Path: <linux-kernel+bounces-537309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3D7A48A50
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF5C16133F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E874426E976;
	Thu, 27 Feb 2025 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="VB1WuXHK"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2DE225A50
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740690624; cv=none; b=n15hrCpVd8bNCspXDjNme0D1hlbCEhNCryoCRNGe3ENdKIgZX1oPnWkUVuqTZbbW71ySrNrYdfj8krvOK1O1NrRJ/78xiAE1ni7z558ZUQwSForXRVElyGeO730ENCAqub6uBqvTdthoQwrf9IsugaM5PwoAE3jIqEF1BrPZfas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740690624; c=relaxed/simple;
	bh=0EcUyBKZhTLQR3BYkYQDdRQDQ7f2tsUeTeRa4PvAtV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fea6F9HcTXXpXmEmPAaHgvYwf/8ffcIlyFK7d4K1mnhTEMgNyy9hoplt1SJc4wnldxjk0A0Gs8Gpir0j9aaE3hs9Uhl5xrE0+/8bI+hlhAyS4EJrkmcdmdN/jmdTZKoMSpXKcNv8gvvuQaXWiltPQZyaGX5t4tZjXn4MppLOYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=VB1WuXHK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f504f087eso1021693f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740690621; x=1741295421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=McVDA02T8ChyltXMoGQz21UDmm2WB9bHt1FmktyqO9g=;
        b=VB1WuXHKBRFvNWav7ZbGBLkSPGATk50qjSOBIqx5EGGsKGsSgFe6FG5jKXev51DA7p
         kRzl0jlbMg8C+WarGL7wFavg4oPoZE/LMCGsSywryS0ObkLCpFgu+VniNfkZ9ilxAE52
         Uzi7iXqzuEkx704jpSFyTkbaSbkAh7gzzdPGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740690621; x=1741295421;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McVDA02T8ChyltXMoGQz21UDmm2WB9bHt1FmktyqO9g=;
        b=ork89SeRQLg7KXSnkt1JeudZUX2PAFkETNSKIau62HqsPgj6fcyfynFxzSDgoyGev3
         WjzPRpK+Xr7SKsmqmbxqt8HY1kq8jTLCT3CcB0uBhsxFdw1c+ALXLHXmcSFSGzsK93Lm
         W49FD9exCJFukkf+e5shm6u+gv/pEwU+PAijao+DXk7gEwK4SdWV9y7v9IWenlEuSRP7
         gZVINAAvvhBSC6xIwIcRQuYYJNuFjddkGXG2vAIX+3W7H5htWucliNk4vA0/aaiGBOWp
         H+RTtomDWyyF8XuL5petjcJMwbLo+3OLJlhCfqqP9fewpt5BS94yWK7GW2Ub0ggm90ak
         aW/w==
X-Forwarded-Encrypted: i=1; AJvYcCVcpigMWC69OsFJ+uwtVwSAWrv3OQbu/uK5KsQwlW1qu7+30CCR6MuAlvj0TsFWv3OVFsc5FuG/s5zYloE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/x7LT/8XMYumeBbPeP42pfMO7DLWT03rykJup2ep/sNgKOSHU
	cmuOmLDIhPRdI7ILkPmTgszIzYD6Gj92+NtIB1jkd+Obumvku4pB2IxT++A/iFM=
X-Gm-Gg: ASbGncvAdVJI7zqvUCbtdaq97hM/bSrYIXK6Xo2Pm/fTW6/agyGO+LWfYQhhgiWA6BC
	z5tKmu1P5og6VQX8qHOF/up8B6mAsaq+VmhLFOD1TUcQ4skduFO++K1sycu7Sh3wl+Z29zRGtCG
	kq08gyA/an/QCdkdPBlHxs81D6RECNUcBmaWMjXGCPxodfWv95Q+jK5XiqAMCnkjcPmVTyqiGll
	+BBGE/i4fU64h7TMnB6V1qTkYyrj5MWoI2OzApnKX56m7tq0+YIMFNAMLnPHQmGfg6Nv6XyFmXu
	JROFg/3fQN4kM1+6xbngDS0jRKjQSUUrvN09Gpmf461l+G3qdwpFQQbO3pGLk5/X/w==
X-Google-Smtp-Source: AGHT+IFgQt1PVzqZnm4g8KGhIwZcUHnnyirC4gn2Ce/wzGC6Yq6y2mLyVO1IOZ3rKalzE2d9OwQfoQ==
X-Received: by 2002:a5d:47cd:0:b0:38d:e481:c680 with SMTP id ffacd0b85a97d-390ec9bb569mr584403f8f.18.1740690620844;
        Thu, 27 Feb 2025 13:10:20 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d69sm3196795f8f.60.2025.02.27.13.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 13:10:20 -0800 (PST)
Message-ID: <ea20d47e-88b9-46ab-9893-26bcf262d8b0@citrix.com>
Date: Thu, 27 Feb 2025 21:10:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order table
 and accessor macro
To: Ingo Molnar <mingo@kernel.org>
Cc: bp@alien8.de, chang.seok.bae@intel.com, dave.hansen@intel.com,
 dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
 tglx@linutronix.de, x86@kernel.org
References: <Z8C-xa7WB1kWoxqx@gmail.com>
 <94083f1c-dab1-4b57-bd45-a4d4f8ac262e@citrix.com>
 <Z8DFusMiUYPZ3ffd@gmail.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <Z8DFusMiUYPZ3ffd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/02/2025 8:06 pm, Ingo Molnar wrote:
> * Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>> What options #1 and #4 will cause is the virt people to come after 
>> you with sharp implements for creating incompatibilities in an ABI.  
>> The XFEATUREs are the tag(ish) of the union that is the xsave buffer.
> There's no incompatibility for a default-disabled feature that gets 
> enabled by an AVX-aware host kernel and by AVX-aware guest kernels. 
> What ABI would be broken?

I don't understand your question.

XSAVE, and details about in CPUID, are a stated ABI (given in the SDM
and APM), and available in userspace, including for userpace to write
into a file/socket and interpret later (this is literally how we migrate
VMs between different hosts).

You simply redefine what %xcr0.bnd_* (a.k.a. XFEATURES 3 and 4) mean,
irrespective of what a guest kernel thinks it can get away with.

~Andrew

