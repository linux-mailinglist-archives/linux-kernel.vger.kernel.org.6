Return-Path: <linux-kernel+bounces-417318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 130CA9D526D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8741B240D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15071C303A;
	Thu, 21 Nov 2024 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EW//nkgP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5FD1BC9EC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213183; cv=none; b=oOX5Ycn117pmyEMKdG6qg0VuNFxksWvDwoGoO9d5ZuBdlrU0C3t5jLU9onsIVGreDwoK7tei7mT95H4uM1s9vNbf5YxcufGHu/7GQ8h+JUPBAYU1p3ynfpRnauCaUO9ZVUordtixNT6XC2Ne3+SmH3R4S54hUyqswf0oTZCMQ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213183; c=relaxed/simple;
	bh=EW3bBLGqFZuVOquRcnnHYxrZc3htXZlVYjqsYt+HG3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/0SPZCgm6eyY/lNpxw7ufjGTauI995A35QMmmtsKqxY2+byJC+CMyPH+vEEf/WNtZrEoDLu/Y3FHNCpOPf0FykX0ILhKvja0hNBt6nXfe6xTrDdlKagtHcX3OzbKMvtlj0SFdpFJRhOpsSn2oulqLEI8F6MOsay9N3gnCTh5Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EW//nkgP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732213180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6bSHmUUve5JUe0VVjTwXDvvxVOJ/4Qyk3ST+VWP2lMc=;
	b=EW//nkgPg4eNIT40qQ/FNPLC3nOljLHAt3ianx2fK7AP7eEh6wr1NfBgCMoQPn8BXihMqg
	nlRI9hroHfD+JR5hUkq6Ul8bikF10j7YaarBQOp2imP1vem3N3pdxkMkIeIdDivwyyPV2T
	6ejIMTGVjsdHv6xTNcB+bxMw4tpXlWE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-9tzZ49faPg-vRNW_qoUwnQ-1; Thu, 21 Nov 2024 13:19:36 -0500
X-MC-Unique: 9tzZ49faPg-vRNW_qoUwnQ-1
X-Mimecast-MFC-AGG-ID: 9tzZ49faPg-vRNW_qoUwnQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4316e350d6aso8759125e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732213175; x=1732817975;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bSHmUUve5JUe0VVjTwXDvvxVOJ/4Qyk3ST+VWP2lMc=;
        b=rkpF/bN+lhs1q75J4w3JME69LiS0JL3bYQuOtcUhUArOTaWMOs7eD8ch24F+SRzwgk
         jcGlq2h+ECCQkwu54Sex1h4mebfJ7titQfWXAt7qsDkegnof21YqUMKhGns+m+sk5oYh
         oF7RrweIJ2i0rvKU0fvHm8azIrpbyZ0cATtUyekz3mnKVHfvVbAqYztxwW/drhMsqB5x
         ozmgz6JZbmSxOPZXO+4djLiDrom0dBGx2OzXhHOUOpx9l1tA4GuSKWYzDM5cQC2PKVuQ
         I6F4Djqt6+z8qjDsiF5d7JH0iEDh8MTIlC+S626Mjf+IdVNtBzxp5/nF4JZS2Tb2tgo6
         qHpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX082yvjZxLLSLj0rlGtsnnSW32AKBYK/fgay4CH66rJdMFS6CAYLhLhfRQYFlyGddCdxqx1qGYHgQ7CE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5GNAC4djDxQmJT0INg5W0VB8UgjGDvv0T1cHx/GCUFEAjv+s4
	AzcM6z/l8fTKMGAQQS5XQLcvyDrYO0gKD8J/ZWqdLy3+B2ZRGR7vx02F56lbF9AOvuOwIPrGikc
	OSWPfXWVes0SSba9aa8SrCqy5/4zqaXZ2uxfM5o5MY308Fich776bhNaiebPPHw==
X-Gm-Gg: ASbGncuNaIWaIpup/yPv56Ipi9rwf9KMxMbX3OQ/+fF++jIcMuBL+/fTMnWQEV/F97v
	j0OuR6vLzGIWLPJymc14L0PanDYZXDC8kHmhuGF09VFD7eygsFRTlEG8OZxDQuM06BS+oe3oplZ
	I1CdICvHV1OlqGu3F4dlQQ8HQ2XU5Q5V9/xFqZlZNJJRI+YKmB+G8pvrf+m8RmyoajNP+Qe8Vjh
	gSwTZO8l3M32e4hOiqnzfL3sChs8yiWSevnRJQrBs1RrZvPvltQ+Q==
X-Received: by 2002:a05:600c:314b:b0:431:51c0:c90f with SMTP id 5b1f17b1804b1-4334f0202damr63248565e9.21.1732213175447;
        Thu, 21 Nov 2024 10:19:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlbswkPsJ2lZyPxiokUXA1d8lSrr31vnDcP+V8VFKHQkVPt3llt+6wRwlSHdB/BCqQqAboZQ==
X-Received: by 2002:a05:600c:314b:b0:431:51c0:c90f with SMTP id 5b1f17b1804b1-4334f0202damr63248365e9.21.1732213175059;
        Thu, 21 Nov 2024 10:19:35 -0800 (PST)
Received: from [192.168.10.3] ([151.62.196.119])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-433b4643100sm66575945e9.39.2024.11.21.10.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 10:19:34 -0800 (PST)
Message-ID: <d4048dc8-b740-47f6-8e1e-258441eb77d1@redhat.com>
Date: Thu, 21 Nov 2024 19:19:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] First batch of KVM changes for Linux 6.13 merge window
To: Sasha Levin <sashal@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 "anup@brainfault.org" <anup@brainfault.org>
References: <20241120135842.79625-1-pbonzini@redhat.com>
 <Zz8t95SNFqOjFEHe@sashalap> <20241121132608.GA4113699@thelio-3990X>
 <901c7d58-9ca2-491b-8884-c78c8fb75b37@redhat.com> <Zz9E8lYTsfrMjROi@sashalap>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Zz9E8lYTsfrMjROi@sashalap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/21/24 15:34, Sasha Levin wrote:
> On Thu, Nov 21, 2024 at 03:07:03PM +0100, Paolo Bonzini wrote:
>> On 11/21/24 14:26, Nathan Chancellor wrote:
>>> On Thu, Nov 21, 2024 at 07:56:23AM -0500, Sasha Levin wrote:
>>>> Hi Paolo,
>>>>
>>>> On Wed, Nov 20, 2024 at 08:58:42AM -0500, Paolo Bonzini wrote:
>>>>>      riscv: perf: add guest vs host distinction
>>>>
>>>> When merging this PR into linus-next, I've started seeing build errors:
>>>>
>>>> Looks like this is due to 2c47e7a74f44 ("perf/core: Correct perf
>>>> sampling with guest VMs") which went in couple of days ago through
>>>> Ingo's perf tree and changed the number of parameters for
>>>> perf_misc_flags().
>>
>> Thanks Sasha. :(  Looks like Stephen does not build for risc-v.
> 
> He does :)
>
> This issue was reported[1] about a week ago in linux-next

Yeah, that's Linaro not Stephen.

> and a fix was
> sent out (the one you linked to be used for conflict resolution), but it
> looks like it wasn't picked up by either the perf tree or the KVM tree.

Yeah, that's not surprising. :(  Neither KVM nor I weren't CC'd on 
either the report or the bugfix; and the perf tree didn't have the code 
at all as Ingo pointed out 
(https://lore.kernel.org/all/ZzxDvLKGz1ouWzgX@gmail.com/).  Anup was 
CC'd on the bugfix but he must have missed too and didn't notify me.

Paolo


