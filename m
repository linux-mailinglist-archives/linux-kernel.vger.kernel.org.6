Return-Path: <linux-kernel+bounces-445385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9089F1554
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9CA188C666
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828551E764A;
	Fri, 13 Dec 2024 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lop/zUVh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340E18A92C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116340; cv=none; b=HUU7uHLCKrUax9Ue0mrcr3eqjyHJ/yEr2oWqonKh4xqKVbRU90TnKzKtaqH/TIbwiDZhT7AEj6XQLcsOu7E4umQlVOutguHnfngBrC22TbFnEpWzH23cPjzYlqrAz3RYJcz3Km+wgchd4HcoWhJyA5rKzHwICxk08tkBW67nHJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116340; c=relaxed/simple;
	bh=t7Np4Aa+tgtujgWBmCLmpiOGbTdtLucpjvWi7GEHhkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgQeHKYsURZoI4nwjquszktdVHyJJxBVY1PGHUnfrbs3vo2LRVmBt0ZVQKSc1Fa4A2DvmgLSz2KBn3mYYvWWnbPtZ9RnWDfW/NocfcnU1xUjedpR7dJg1mmfCG2hQU7962qRt1PvtuWFzyAj6QeyQYfHk/tMBY+3wOg27LZcX0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lop/zUVh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734116338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mI1mOtjG4nC/az8D+B88vVhaoQDxbNllCYmgLL5S3Ec=;
	b=Lop/zUVhKwcCBwhc3+mGaKy6iTjNlfwwQlN0JRePiLfj9clSxXltzjGac1K/HSKT+53uUE
	xnEl7K3vKpBdFGg/o7GW5VlzCM8U0/l2qjY9bjXhWmRrdyVnXOtVOFF2rhf/6konNrCxG2
	mJoRfyPvc/BXxhsYa6uvNMsDQxILga0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-f6e4rTGnMniMlIO-_4MroQ-1; Fri, 13 Dec 2024 13:58:57 -0500
X-MC-Unique: f6e4rTGnMniMlIO-_4MroQ-1
X-Mimecast-MFC-AGG-ID: f6e4rTGnMniMlIO-_4MroQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361d4e8359so16753055e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734116336; x=1734721136;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mI1mOtjG4nC/az8D+B88vVhaoQDxbNllCYmgLL5S3Ec=;
        b=mBsch3xwACDhfE9NaxEJrPUMojYDvzUeIrfS+5UnFVM708/snyxBwAKbnVgPCP+L8Y
         yKE5uQuDcbEyDSZqHa931RyxK2kOIBvBgkruP5F/z/B0n64j5Zvg9JI/wQ+oXF9mGu3Q
         GjGA/jLgHIDrTRDdBzV/6jVqw7Ia9rS8zreVow5z7dFQL8HzxWafIeB/vp0xKqQAt1tv
         nMjr7fdmIm5rmzF/EBbsn7T2THqi+AARFwl12JOX07rQWCDIgbxRiWV8eCAcAXet072e
         SHq5Zk9neDQYO0F7d9H2KFxFcuTalWuTpdKwY4A7UX2ZTn0ohCPTrnBpAVVt4U80CBjn
         aFmA==
X-Forwarded-Encrypted: i=1; AJvYcCW3IdAHT5eRYfbADturnSp5G9S4Iy5aY6BG/OTO8/ilFkHorbxtDgDw39jieRRYgkswaPFJg0+A9QAuits=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKo0I2z5XjSU1TuCK3QF34MLBz5k76JnMc/dy2q2PccVdOm/Fu
	rxYjOl+n0yikDatbOnyWBOxI1PLiTrEB5xwiqcsak4nbZc8sgkXLKUHmetYLe6jxUZcZ1mmIBHx
	SVKaQ7J1dW7avlk8Yr5dRe+ddB62D1iM37vKl7UZbbIt7lHJtdEwxx7StrnxSTQ==
X-Gm-Gg: ASbGnctb03Yw7PhwFH84KT8SChzoqMpNWiEAO/J11pXZki+ZPwjo791jXBYAvDf144c
	Y+i+1Z0LEFqOOP3sSBeF10OoGq+ecnvl2NmhS3ffwv+gWIwxIcWQIR4iJ6yZ0ICdUwE41n7BIaH
	1KXZ+LmfVKHmAiANAf+mgOb33Xj8toLEhVWKIkURpC6B95A/HolDspLuRENkjPi28ohqQFccThk
	WA6nntczdXSGlauZIhixpmIhLWzpwCIRvwZZycSpkeSYfhmCAcIKYiKBQs=
X-Received: by 2002:a05:600c:190c:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-4362aa9d675mr34183115e9.23.1734116335992;
        Fri, 13 Dec 2024 10:58:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCocN09lwrJ18yznQg6RRv3t1XmTAkjMEIYeGuE67QjSo4SyJA5WAXCajyTNxHaPEkuz0Z7A==
X-Received: by 2002:a05:600c:190c:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-4362aa9d675mr34182965e9.23.1734116335622;
        Fri, 13 Dec 2024 10:58:55 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-388c80602a1sm251014f8f.97.2024.12.13.10.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 10:58:55 -0800 (PST)
Message-ID: <257491b6-f70a-4347-b97d-cc7fa22aac85@redhat.com>
Date: Fri, 13 Dec 2024 19:58:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] KVM: x86: Address xstate_required_size() perf
 regression
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>
References: <20241211013302.1347853-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241211013302.1347853-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/24 02:32, Sean Christopherson wrote:
> Fix a hilarious/revolting performance regression (relative to older CPU
> generations) in xstate_required_size() that pops up due to CPUID _in the
> host_ taking 3x-4x longer on Emerald Rapids than Skylake.
> 
> The issue rears its head on nested virtualization transitions, as KVM
> (unnecessarily) performs runtime CPUID updates, including XSAVE sizes,
> multiple times per transition.  And calculating XSAVE sizes, especially
> for vCPUs with a decent number of supported XSAVE features and compacted
> format support, can add up to thousands of cycles.
> 
> To fix the immediate issue, cache the CPUID output at kvm.ko load.  The
> information is static for a given CPU, i.e. doesn't need to be re-read
> from hardware every time.  That's patch 1, and eliminates pretty much all
> of the meaningful overhead.

Queued this one, thanks!

Paolo


