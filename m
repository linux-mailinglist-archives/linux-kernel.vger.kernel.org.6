Return-Path: <linux-kernel+bounces-187468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333128CD243
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BA31F22F64
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8283148FE2;
	Thu, 23 May 2024 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu/HD1iJ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753FB1D6AA
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467170; cv=none; b=I64nkk6qcTTFRrQcgZSfnb6u5GaBZgwvT2FRHe3MzZY1VLxlQTBxLG0O7LZk+wbB7tuLqDC2Ql/C66R1yGiuazr6kx/3KSdIdXlWzjIBKIJ3byWA79Zj6uRz8Isj4MNhouHQeBszW6KGKYWACsZMqwdxBc46htkQukQxl33HF/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467170; c=relaxed/simple;
	bh=Hz679FGldUumfGnK3T0dVKDX0bO5Ne8dcy8RD/sJ/7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEJcn2Pn8ZwqrhGUrWOxvDYJTvysZBSyCN1QBrl1m/1fnGqnDAu2O8xjDX1X8C9JLc7/gQiAgPTXE6zwej9dZa0s2W8fQ6Y4AK24NjuBzcpChIbMCM9rHfi8zn5iCdoqxbzXajRdiB6Qcq1SHSmSwGWyMxvW6pryP3YtFSj3/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vu/HD1iJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57824fa0a8fso3456067a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716467167; x=1717071967; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wUzztMJk6TZ3WRsNpCu6wZEy2fKtuZUq9Vt9f0V0Dk=;
        b=Vu/HD1iJN5IOQUNEqNy2YrHNlrt9CST5Y7eMw0WrtwTYFfUhLJz+Rjy2WTWcbmaowi
         i69o6Vp2CRGP9YIB94aUoaHsRqISgM/bIwML0t9CtNSdWp6jHk8RltGdTKQeKkosVoOV
         f0PnapX+XgMdlI7QcOwcOhlPeav4zQXZ9oZvdCfhrM7td1GnDV4F/H+ssNPlxRyXoiNg
         +EHvCcLoTzAdPJ32b0OOyHU3cBptAHzie4I9KQYgic7p4ZywT8A9DNhYwJU3+l/B0Ome
         yQN3D7KoDlGssfAjrbru6hqSCqIp/P6GBcBIXxMg773laux78S6u7X3Nbrbo32axUKAk
         P5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716467167; x=1717071967;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/wUzztMJk6TZ3WRsNpCu6wZEy2fKtuZUq9Vt9f0V0Dk=;
        b=R2g3HrRGt3zmVsX0uYUMgw+p4GV9II5BjrNwcHhi80PCXrLMjM+c0tCVLkBJTKUhxb
         bqlD/mJ0ZFLEd0kOgaHca+1PxK5e5SchycwFWtXKvAmrb3WitgkrxEngaG84ECJwlwL5
         IRf4wucil28P/hluH/K3Lb0JHG8RjZFUWbvf5aBXu92i0PB8sX1i5P82D4w5VuRXxCZW
         zHz1HoHcVpQ9AmD271h1JDNDh8ygB123dWjDER4YhZYsF74mveMow/7ZTazg4aijvbNo
         xzrOjxvEus8Xis6cUtA2vPrYbocml+zhFPr7CdpY/zg1copqRgJ051Mr7aFnd6aAri5C
         aX7g==
X-Forwarded-Encrypted: i=1; AJvYcCXsGsJ2fkVVB6KlFI0nyJ0Jnux8frxrhTqj/YxP7VK8mSZJGn8IazuL6yErp9PKft+rr2ECgVpkBvtfTt7WqOIOpsYtbwJJ4sFYNZgq
X-Gm-Message-State: AOJu0YwstOQHTngdHJCF0kPssUIW1Gp+ZUgr/naMc8o75ddLHiIeDhML
	0qbQAsgKryogUxiBOqbmVQguKoih9QqW0ZIceN66Uv+yR0vJVD45
X-Google-Smtp-Source: AGHT+IGxSknXBNirEvHJccvujR5vheSRG9wlahEtmXXtCc9qk9cdBeiBerqpUmJoeOHIrmfeNgvt+w==
X-Received: by 2002:a17:906:682:b0:a62:2cae:c10 with SMTP id a640c23a62f3a-a622cae0f18mr298652366b.47.1716467166456;
        Thu, 23 May 2024 05:26:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b0177asm1958596166b.173.2024.05.23.05.26.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2024 05:26:05 -0700 (PDT)
Date: Thu, 23 May 2024 12:26:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, Steve Wahl <steve.wahl@hpe.com>
Subject: Re: [Patch v2] x86/head/64: remove redundant check on
 level2_kernel_pgt's _PAGE_PRESENT bit
Message-ID: <20240523122604.2owqxj7fmgudewzk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240523083752.11426-1-richard.weiyang@gmail.com>
 <fej5k6ikc3biecm5xadxgwv2pflktpjmvrxjhzmhia4p5kipun@ny3swf6kcqwi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fej5k6ikc3biecm5xadxgwv2pflktpjmvrxjhzmhia4p5kipun@ny3swf6kcqwi>
User-Agent: NeoMutt/20170113 (1.7.2)

Thanks for comment.

On Thu, May 23, 2024 at 01:33:28PM +0300, Kirill A . Shutemov wrote:
>On Thu, May 23, 2024 at 08:37:52AM +0000, Wei Yang wrote:
>> This patch tries to remove a redundant check on kernel code's PMD
>> _PAGE_PRESENT attribute before fix up.
>
>Tries? s/This patch tries to r/R/

Will use this one.

>
>> Current process looks like this:
>> 
>>     pmd in [0, _text)
>>         unset _PAGE_PRESENT
>>     pmd in [_text, _end]
>>         if (_PAGE_PRESENT)
>>             fix up delta
>>     pmd in (_end, 512)
>>         unset _PAGE_PRESENT
>> 
>> Since we have compiled in _PAGE_PRESENT in this page table, it is not
>> necessary to check _PAGE_PRESENT again before fixing up delta
>
>level2_kernel_pgt compiled with _PAGE_PRESENT set. The check is
>redundant.
>

Will use this one, thanks

>
>-- 
>  Kiryl Shutsemau / Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me

