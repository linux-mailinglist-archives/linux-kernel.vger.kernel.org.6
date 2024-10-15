Return-Path: <linux-kernel+bounces-365307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E699E03A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFBE1F21C81
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5631C9EDF;
	Tue, 15 Oct 2024 08:03:47 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B81B85E3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979427; cv=none; b=rVd5n2A/lt7Ua4am76Kx8x6kztuot+7eHy0CzurK1c/MtQANFmViZSS/vb6IhekRFN159ZiE/YToYSM9t1drC12H7LRQXwIkgEg9/c0w53sPVFni2XiElZx3uCXald1v9dfvkyF0vM/F3I0DywCBfk3AvlsFU0hlKpuxyi88ycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979427; c=relaxed/simple;
	bh=B9OXKF4Ws/DLDMrOjmn90wcOrWwq2L+MNydzI5HuzjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBGEtHWn9gR/3zPRBQjP++36P2AbUSRVpXUPJmsg8xv1y6XvRD5AgCrKkxFzw9EnqLWDhyi6r82a06p0U1Ql+5CTQODatqrXZG1tI0MgcMEowsWzmV8/8LQ3ADkuTu5mafMQyAMMvb+3eXHRGuDfYXzGoeQnfYVrVSquaGuaRzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43124d1ca5dso27686445e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979424; x=1729584224;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd6BERmAdANs7Wbv431w8JWCwILAEW8Q9TpJoNBrK/8=;
        b=n8lFPDdLsT0YEIcuKfvmjhwi2Z6eB/R2eqTgzyyWjen/yw+E56Dz28PRWC1FLxi6pe
         G0bg1YDIcuvZvvjfRKL7WaWjC+nzq5nDW155z2AHDEDcEBVp2kzkb8fJl4Rj3+AnY7gF
         f6qC7ovjyJJ5Nk17ipRbXDUzjzgIG3SzOXzudfzICoUk+KoQBE4hv7e8ihOsQOZuQ87k
         o5QmWQSy0lO1Ql+uQnInbYUm1chU9sZkHEhVPdGOdYcXuKpXizXAyctGd3b2nfmVMf/f
         u+QAUhpLVfn3KgGtd8rIZvI8555P4aXw5ft/74kf8V6eBXWMQjEKzwDnA77B0Ynov4G+
         LZNg==
X-Forwarded-Encrypted: i=1; AJvYcCX40DBEHTRuBYjuEqgFwdeYsa0TRIoMDj1uH+pBd00AijQeRduP+UNVRn89lcS6VCOS36zvC0JqDsrS6aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH5g0enFMTiBcJGFU9cu8NLY+x/fn25U2GKzeyKMneFUhJEscE
	rQBWhSmsUUUTE2Y0G4X9w4TyzDlThPWogmieLUw1ufqwwdi3WyJ2z6pQsEVl
X-Google-Smtp-Source: AGHT+IEPpdjzVsWTH2WKF1Oq33gbQicjX67jWPBC7rkQNNLWf3eadz0YA/WOqE+b0lMpThdob+jrKA==
X-Received: by 2002:a05:600c:3589:b0:42c:b961:c902 with SMTP id 5b1f17b1804b1-4311dee688cmr112264515e9.12.1728979424084;
        Tue, 15 Oct 2024 01:03:44 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c606esm9942745e9.44.2024.10.15.01.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 01:03:43 -0700 (PDT)
Message-ID: <a5b2e5e3-a8d5-4b45-8d56-e99536b85a7f@kernel.org>
Date: Tue, 15 Oct 2024 10:03:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kfifo: don't include dma-mapping.h in kfifo.h
To: Christoph Hellwig <hch@lst.de>
Cc: stefani@seibold.net, jassisinghbrar@gmail.com,
 linux-kernel@vger.kernel.org
References: <20241014144643.51917-1-hch@lst.de>
 <ab456339-18fd-45d8-abde-b04196e0f604@kernel.org>
 <20241015075053.GA25249@lst.de>
 <f5469873-f099-4926-883a-37badec904df@kernel.org>
 <20241015075710.GC25487@lst.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20241015075710.GC25487@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 10. 24, 9:57, Christoph Hellwig wrote:
> On Tue, Oct 15, 2024 at 09:55:06AM +0200, Jiri Slaby wrote:
>>> Because it would not comple with out it.  To be specific: asm/io.h is
>>> where __raw_readl and __raw_writel are defined, and we generally prefer
>>> the Linux over the asm headers.
>>
>> OK, but how does this relate to "kfifo: don't include dma-mapping.h in
>> kfifo.h"?
> 
> Because before that it get io.h pulled in through our batshit crazy
> header depency chain.

Good fix then. But you somehow forgot to mention this in the commit message.

-- 
js
suse labs


