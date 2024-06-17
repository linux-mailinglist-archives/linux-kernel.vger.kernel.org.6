Return-Path: <linux-kernel+bounces-217727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C9490B372
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C70281ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8100D14F9E6;
	Mon, 17 Jun 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PVgAqCC8"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369C14F9D8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634148; cv=none; b=IU4CgOFbDM6/KqRT7VpEf7n950O1NVaMEwy8yBUmqsCVmyzudtKeIa3cLBV2YjBvia0aSq/GFGIrC5rTTrrgQe6saV9OPc5sk/xiR1y4nCpdGHiRUxLQsviX55cBuIvmeNojApoVC+aOs26Lo3fylxLyjjRw+V3O11HZuEnc3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634148; c=relaxed/simple;
	bh=b/oQTmu4HJ+1FTo118VzRg4xrW4tbnarl3In2JZbc6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCyiIdvL4N3lD3ok4XPSNQZU2JbaYO9xBYCSTf7ybWx/8iZeq+vaNH+r7/bks1O4KWP74j0OVQnc17rz1275U5EEnLDiWn6p9ynhFfIfbnTNg0wPJGpcPkWHrR6ljfLcHdjtCmJedScArN3gNJxap8+9NsBofaUhIFKKdXuATaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PVgAqCC8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so475680a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718634145; x=1719238945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RDYlK32PcEbzjDkBUw1Lslht69kdYDtkHTsgamegvR4=;
        b=PVgAqCC857zxRlL+2LOZQKG+WpUimQ51jAB6gb9beovivWarDXbjr4hHWA8CX9oPf0
         0zQATX1ecTIbG4T4E7n6sBzrYauUZKCmwrPPb409jWh5jqTSJBAI5b73Sgekl991n9gn
         fs7D5YI8h8VLrBhg8s0mBIuDIKFhJoXiYQZi0atKWmeXGfYNLYTWhVD0ebQxiylFhsaO
         XpIKzCIpQmfrbJFpJw+kIsz9mzm9xkuUvl9EOJgOIK846JL9U/FCuu2bN6pMXEwW37/p
         AvYhEodHst3qwyRDhQKyfuxE2Reaa/BNXLWOwEAbI5WXq5nSQaYbmkV6j7fO7o1/JS21
         RRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718634145; x=1719238945;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDYlK32PcEbzjDkBUw1Lslht69kdYDtkHTsgamegvR4=;
        b=FPaONlUBZmEP5ewfor3iAfeWV4YFLL0Ajhu7eokhPpZDLnLHc6eg5Tqo5wnccWna18
         kk/EJ4hGUcQKIVef6BBwqWrfZpJ7hZAdI/YJLUiba3Aye9FknNpIpm+PAw1/ruFAA6Tk
         cJ+vuopyFn7W50QAcehet7CHClPt2H6eDeKQwIGP2G/UQyMvbbQtXsTz783jjPKCnOEK
         h54hgjLj3AZDf998YOr4P97TOoiCAVnQ/GwtR98rwDBf/KiagiSi5uNGsd169pLpp21k
         o+v4KuwrH8/+W9b+5hc1mKYL8V+yS5VErytjdbNI2L+wRxS+fz4ST22FOxO0Krj1Y5ii
         gYOw==
X-Forwarded-Encrypted: i=1; AJvYcCUE8Q/pETJ5dn98gB/whrwWyY3t0mZ6tZ+eJnwrnVkB9yrvvAXdmSLN1kxhVoVIeNWJzysRvIew18cRYgk1m4De0LjpmMx9SR4xr6mZ
X-Gm-Message-State: AOJu0YwGhBhViGw/Syp9dpAjMiX5MplsKGRCdj2J9dWHZTYpvk+qGLme
	bzq5QPbENTWL96fveY8ad7i6vdxFtbWBP+v6eYfkIhGsy953e+WtjfPGpC7dHw==
X-Google-Smtp-Source: AGHT+IGTdnNmx/lrvgSy2nQrknFrK5oVSLM37bT6s12vjnAcrOUwqPbxH/dj19ONIPn97Cv2O4Ww2A==
X-Received: by 2002:aa7:cb87:0:b0:57c:a796:ed6e with SMTP id 4fb4d7f45d1cf-57cb4bb0d49mr9430677a12.6.1718634144499;
        Mon, 17 Jun 2024 07:22:24 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cf709b49dsm76051a12.49.2024.06.17.07.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 07:22:24 -0700 (PDT)
Message-ID: <2fe6ef97-84f2-4bf4-870b-b0bb580fa38f@suse.com>
Date: Mon, 17 Jun 2024 16:22:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/xen/time: Reduce Xen timer tick
To: Frediano Ziglio <frediano.ziglio@cloud.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross
 <jgross@suse.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
References: <20240617141303.53857-1-frediano.ziglio@cloud.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20240617141303.53857-1-frediano.ziglio@cloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.06.2024 16:13, Frediano Ziglio wrote:
> Current timer tick is causing some deadline to fail.
> The current high value constant was probably due to an old
> bug in the Xen timer implementation causing errors if the
> deadline was in the future.
> This was fixed in Xen commit:
> 19c6cbd90965 xen/vcpu: ignore VCPU_SSHOTTMR_future

And then newer kernels are no longer reliably usable on Xen older than
this?

> --- a/arch/x86/xen/time.c
> +++ b/arch/x86/xen/time.c
> @@ -30,7 +30,7 @@
>  #include "xen-ops.h"
>  
>  /* Minimum amount of time until next clock event fires */
> -#define TIMER_SLOP	100000
> +#define TIMER_SLOP	1000

It may be just the lack of knowledge of mine towards noadays's Linux'es
time handling, but the change of a value with this name and thus
commented doesn't directly relate to "timer tick" rate. Could you maybe
help me see the connection?

Jan

