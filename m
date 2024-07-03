Return-Path: <linux-kernel+bounces-239453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBFF92602F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109D41F23EF6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0904175560;
	Wed,  3 Jul 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QXkAxWXB"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5DF85298
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009363; cv=none; b=Noh5DOzCt/EYz39ySPZfjv9k33PeH7CX6ibNO8bTyK72vCtR4r/+nOXGLd5TZw26VwqZkA9EszVOJOt2MSQuTK6oQ0tBu2plLrfboZqYMQc2iyf6EVmp4HOe1X07X/Vgspb8e5EpSu/3DrqaHCr9boNGkzoMlVm7cEAqfNkYSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009363; c=relaxed/simple;
	bh=TX2gvgdit2no2Bm4JOYvYuXVgfwUmwr1dfS1rQTimbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inK16ndukrw4axHruTKcz4uGJEOkNhUU+/3NOE8NDMhSyCL63Avv5PUhDVOIyB+ywCVslBt+bx2k+aBl5lCCuvtld8wEiLJ5N2c4eUw3xG2J9KEARkUQPs9CACUrIe2dtGCuVwLT+o1prBVz7qUmvJL8GJcRbQ5J2dRrfLkedaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QXkAxWXB; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec4eefbaf1so56690341fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720009358; x=1720614158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYo5IBsgfXZoFfV/jrH0cWY+s6dZqG1CrWcT7nsdClQ=;
        b=QXkAxWXBHNwL167XOVQY5fWzRVOXxoEm2BmBn6sxC+LcqcFSbJohvP8kh3jrOcXevG
         TfNZQqv5GC6NvzJBzBD7Iv0i5s26+QRtwI6uJgIy183ciDlwcTmNKPz4w/4+d7KulSXT
         b+8V2C4n3ZTDkNd4qe8VAuOZN6sALW7zkbQQPmqHIFmv0YB+NRQFS/7ybc+fBXL49yv7
         OPlYo9hBiA1t9Z7E+7nYYyUTGZ+nDAoB24tVhXr7lm38ctyNct8h5PNpYfZXNBVnDBI3
         EyRu3MXoOL0wW3O6118tjF4tQDA4DNYfLUDFHSU/FxiqzL+eHiOSTI0gKQrHI3iFUwdV
         2JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720009358; x=1720614158;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYo5IBsgfXZoFfV/jrH0cWY+s6dZqG1CrWcT7nsdClQ=;
        b=YvWzmBx0uG4cmqauvQRGbswNQEkEj0fwPB6G3vvydWUgz70xszBrrzZd5WnGYE0me1
         xB7gVdwkVo7zJeWvbWo+g/culaeS1vh/WXzRTUKkoTe+uSYy/nFbbemm6JtmXZPoUhlK
         j5YC6s9l9bHun/kNmEEVb0PJQFVUVKyt3y5yqmIvmwZGNGSSSt/5+ClqTGd2WSrR4j2m
         GMcGPV5g128NCYV73F7esQN8EXY/wNvQI18Pcyau2lYV4TKiP0P0ZGy4tE1qbvB9xEi3
         FDFROjd8bp1S6NpJ2AibxkQonBfj56YrwZtji4mB47VCCxMpIgCAUIdcf2N4lvy189xa
         yovw==
X-Forwarded-Encrypted: i=1; AJvYcCV56MV+JAqVw22GdD8uQxQbv9Nr6vold02EewXAXTla6zZGFMFOhKbcmyKb59O/gJ4kQqEjM7HGz6jEDocgnLoyyq3iFOwvYLhflV+d
X-Gm-Message-State: AOJu0YyC9SwqkureR1DfnQoRKCVpyp63efB9r/keyAr2wXlcCMjD29vo
	Qwf59tbG0LT6VTGsUAEy5gTTti2q8BhQlv5epw2fjqb+XrPH48tHnszbJUPPJpk=
X-Google-Smtp-Source: AGHT+IHZ4VR/Z2EA5bNROzM44bBxwS+VTMY4KF41urbY5op+dc5ajamiSRVwX7gtAx+LOXib0By3RA==
X-Received: by 2002:a2e:a902:0:b0:2ee:6062:b559 with SMTP id 38308e7fff4ca-2ee6062b816mr81975241fa.8.1720009358326;
        Wed, 03 Jul 2024 05:22:38 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:757f:69b1:bdb0:82db:8b8b? ([2a10:bac0:b000:757f:69b1:bdb0:82db:8b8b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b064f16sm236821285e9.27.2024.07.03.05.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 05:22:37 -0700 (PDT)
Message-ID: <d405c84e-2b8c-4139-b4ea-d716fe53dfca@suse.com>
Date: Wed, 3 Jul 2024 15:22:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 3/4] x86/tdx: Dynamically disable SEPT violations from
 causing #VEs
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240624114149.377492-1-kirill.shutemov@linux.intel.com>
 <20240624114149.377492-4-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240624114149.377492-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24.06.24 г. 14:41 ч., Kirill A. Shutemov wrote:

<snip>



> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -19,9 +19,17 @@
>   #define TDG_VM_RD			7
>   #define TDG_VM_WR			8
>   
> -/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
> +/* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
> +#define TDCS_CONFIG_FLAGS		0x1110000300000016
> +#define TDCS_TD_CTLS			0x1110000300000017
>   #define TDCS_NOTIFY_ENABLES		0x9100000000000010
>   
> +/* TDCS_CONFIG_FLAGS bits */
> +#define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)


So where is this bit documented, because in td_scope_metadata.json 
CONFIG_FLAGS' individual bits aren't documented. All other TDX docs 
refer to the ABI .json file.

Landing code for undocumented bits unfortunately precludes any quality 
review on behalf of independent parties.

> +
> +/* TDCS_TD_CTLS bits */
> +#define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)

In contrast the TD_CTLS bits are documented in the same .json file.

> +
>   /* TDX hypercall Leaf IDs */
>   #define TDVMCALL_MAP_GPA		0x10001
>   #define TDVMCALL_GET_QUOTE		0x10002

