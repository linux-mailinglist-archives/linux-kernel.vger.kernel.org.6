Return-Path: <linux-kernel+bounces-437535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275E49E9481
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972511884575
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CF122371C;
	Mon,  9 Dec 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exostellar.io header.i=@exostellar.io header.b="G/1wIZll"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F4622489B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747975; cv=none; b=tcGy+yVl/N11XZ7gClUghXNccdJura8/SnOfZAqUogY2jAh8M/07SXYORAJ6Jyq4ybRz/ieLkOsbQDdT1dbmmyEXl8fPYN17awwYMgtIrr7dM/u1dDelM2U2mPABhdCvKNIoHnwu2cUx6rnpzjnJz+X8ILjVKFrOjeTYqcMEGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747975; c=relaxed/simple;
	bh=0AMw/7Ktf9nFktuDL3d6RVqnGeuif0ZLwPUPdOsc8F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLDqVsJdFFO3+6frisXzuEhS0+kaEN5G2LKMr/7UB+0F6pEQV6C5KLCNgLRUHtDdQfdD/j2SNYaqhyms7X0b/1CIYk7iZHcJIFYlbIYZt1X3gJCn3NWg2Ca05JCD87QoWURDIkYpG97URglgBp9uByMO4u3+LydfwvwWsnCuc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exostellar.io; spf=pass smtp.mailfrom=exostellar.io; dkim=pass (2048-bit key) header.d=exostellar.io header.i=@exostellar.io header.b=G/1wIZll; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exostellar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exostellar.io
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6cb98626eso100944685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exostellar.io; s=google; t=1733747973; x=1734352773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRUTaSdtSTWDNx2ubmJEe+KjO9kK07Vwb4Eyr3Ojt1w=;
        b=G/1wIZllz/LhTiKXFiDsBiCLA9utJVct3hJVPAFdqBWPrdZTHcRB3uily/SNxP6Ggj
         cNUYy04/Ru6AsCL1Nbo7aVRhwAloNrvZlTkhzHq3CflABF96+GLjKfbjSMK1dIF/bXq5
         iocXn0ZdUw/svUWbc2xwPBkuZKJUxPnvxJAPSWUwdD+1bBpV63ED7rVOrqx+44eze40A
         C1lgkvuH1ovBSWGtdUsigrvH5BTCLgGZ07mPxL/QaUqldg7t9m2rqcCEkOmvp2uuI6YW
         aJFMcNW6reG4R11oSqgVwHynZ/QnegyeJHGnOsSmEfTU02/jBCx01x6Ctfme/poxDQVp
         8hOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747973; x=1734352773;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRUTaSdtSTWDNx2ubmJEe+KjO9kK07Vwb4Eyr3Ojt1w=;
        b=mwuKfXZHPtLlRPsk8ft2aAP/caBqfLrMaif/iQlSmHKP8S/KljWXKM+gLFfC94F3w+
         oyQXsu3FAEVGjLoj6YDY64hJYIKtdNWjTjLWn+Qz4SjGFIupEEKzMYXtIN+hXEaqaiVi
         0tRTISFQ7iHijMmYPbkp6oMyvrlGScHhoz7FpaMM1dVEGA1Gvvo5KkOhVfbB7aszGdnj
         FcHJGHMFh7EmtPR5sqajJ5idLvxTZkLKfi+EiI73N6eQQwWLs7n9W+ilFh1lz8q70gct
         yba04nJEZPQjAs5jE0QhfkwPJC1xU00LjryeCuYDNkZqBV2iP3uzNmPKrXEPQ5MgceMg
         gVGA==
X-Forwarded-Encrypted: i=1; AJvYcCUmg2jxQ8e0YuWONXEQ7eTrNJZfPPNgXA1LzL0nQoMzdtfq5kCAIAcDaZk7OAzzauqm64HOG4NdE0vPE5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIfaMuO90PcfpqR0ZrEHt1XvdzorXREjkFOecbB35scuXiU3qs
	FsJXY9HP/QfQ2cwLo9qhJYFfY+/1thoZjTy25Fk/phMwllOjpAxhGqStyVfr0JY=
X-Gm-Gg: ASbGncvWaVz93vwGFZmbTvcMMVIsaSc4LWZpqrcYFqE6KWbdTbur/iJQcwh4Pt2fGuA
	DpIHNImB+Io7thlEWoT+0r8S/I6j63CZ+31UcnFS0r0kySDoNkE+jPrcjOBj6r2dQzqWKqIg8iq
	u8zlAQsFYDp39nu9pAXlvPerCvRU4ui8+UzQicccBO1phSRT7c4zK+2vjP7epP53ESFU6/dqJ8b
	iEXuylTR8MSFRztaczYqwMpSJV/ewQQ/i187MQTVgup8C3MX5r5b1o=
X-Google-Smtp-Source: AGHT+IGUN0y5tavLjGg8nctS+87f9zbgPbgkotfQ+C/sUG31IJkgL5wL2zKycZaYTebhyfsU6ab9rw==
X-Received: by 2002:a05:620a:2b8d:b0:7b6:cedf:1b4b with SMTP id af79cd13be357-7b6dcdd0b6bmr28812585a.7.1733747972695;
        Mon, 09 Dec 2024 04:39:32 -0800 (PST)
Received: from [192.168.1.76] ([188.91.253.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6696acc74sm329635666b.134.2024.12.09.04.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 04:39:32 -0800 (PST)
Message-ID: <813d9908-48e4-46ce-87c9-7414170e6a6e@exostellar.io>
Date: Mon, 9 Dec 2024 13:39:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Grab mm lock before grabbing pt lock
To: Dave Hansen <dave.hansen@intel.com>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20241204103516.3309112-1-maksym@exostellar.io>
 <24b8d4a0-36c3-4404-98aa-7d8e2c67ac95@intel.com>
From: Maksym Planeta <maksym@exostellar.io>
Content-Language: en-US
In-Reply-To: <24b8d4a0-36c3-4404-98aa-7d8e2c67ac95@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/12/2024 19:52, Dave Hansen wrote:
> I have the _feeling_ it's just a big hack and this code throws caution
> tot the wind because of:
> 
>>   * Expected to be called in stop_machine() ("equivalent to taking
>>   * every spinlock in the system"), so the locking doesn't really
>>   * matter all that much.
> 
> So the patch here kinda doubles down on the hack and continues the theme
> because "locking doesn't really matter all that much."
> 
> If so, it's not super satisfying, but it is consistent with the existing
> code.
> 

I indeed could not find reasons why locking would be strictly necessary for correctness here. On the other hand a 
clearly benign warning should not be triggered, especially considering that panic_on_warn may be on on some systems.

