Return-Path: <linux-kernel+bounces-538802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BE7A49D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E627AA3F5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE752755E1;
	Fri, 28 Feb 2025 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fgeeu5hI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9099274267
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755970; cv=none; b=KP1DfSViYJrPGZutM7+j5qB1mGlUuqcugKUvKXpWQCcRpejkaHKQoYUDU+ZpdnDRht6/+wL8vjJAn+HFhQIhrSH16EbKmduosh6lX4amBXzFr00cKNPVzFjzKWPBBjxi+vxD3Iz8B2oAv1WV0qtbETdAMMJUZ2OD4gi5hwUu2qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755970; c=relaxed/simple;
	bh=hlCicZosQRWsNRQVCi4guHJEF/qfP1cDfLacBb0OncA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sgQsCkDGrHIcIdzbNayt/5YWoMkNnGPXiX2TKM4dsJeCvZksiVcCrO2gtHOzs27n70NAhtQ/O/8qdtVDxnoSoOBEQCl1EmJ4CuA/cpwFv/R71MUyxuQk5pEwy6oWdRSL87XXiYk0jjZsFV1UcAIp1RQPH0yO0wYaiRbwEic4iE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fgeeu5hI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740755967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4vbBIUY6t+jDE+HBv3jSoJOW6m+Ign7gsbcQg4cF5JU=;
	b=Fgeeu5hIjbkhnRrk2OeUeked2eptuHPlsmNobDBfvaD2tFkpWjFKdBSsGxPdt+l9Fg5ke4
	dUcJ6MXVMLysi28/K/BN8HjPBhqHyiidjXetRE8eagP6OUrr+bmJcAwaQTISf/wo+4fI07
	rJYRzoDuA3xQh7QvRxc+DAVV6r5F45k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-M3JUcLlkNXS2R0WbkQPO2Q-1; Fri, 28 Feb 2025 10:19:26 -0500
X-MC-Unique: M3JUcLlkNXS2R0WbkQPO2Q-1
X-Mimecast-MFC-AGG-ID: M3JUcLlkNXS2R0WbkQPO2Q_1740755965
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390e5214efdso1318526f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:19:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740755965; x=1741360765;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4vbBIUY6t+jDE+HBv3jSoJOW6m+Ign7gsbcQg4cF5JU=;
        b=tdMPnqUKUZh+w7jkpiY8OZIAK1MkHcPOKOol3XGtEahp3RO+i2NE1IE/0GA9FwiN/A
         CiPSYZvskX7Z2LjsUHHI84GW1XFdgyzf7fiEnP23KBGymhs9czqA5St+MychvYmK2C9h
         39j2BXazcngtlPNoJ87E36Yy1G/CMjTJQnA6fMM1Syju8mPS8qzbtx2Nk/AAsTiVm8UM
         cgabL0E6Leto5e5aGX314Jur2rJkzNxQK+TVMw6WgVjh0ZBIHyySXTE9lH35VAYQjle+
         d5GSgsNDzwmiQXD9TTngTZSGRJm7zz26gGV2E2QZeoH/42jIVCpwdggbhjBM3PpXVoOp
         Xwvg==
X-Forwarded-Encrypted: i=1; AJvYcCXp/2E0OxNUrsndVNdYcrU4k/T3QxOQ6P52ay/5jDGv+XixQaBDJo6hcLOvW2hsSdCGGo2mxk2hz9OaINU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVF1OSuJBCdytW7VMq/GdsM+J13DAc/qC0iCdYBHacPnt6u1uW
	ajY9wYH8BmX/mXF8RRqRPZ4lrQJUq7UOlZe3AqtusbF8vPWGsK9JbkVUEZV0kh4fiEqbViZunQY
	YK5noSXYJzfI3B2pHfbxmtpHQnTInjrL5DHrzdtXjmrdgxnkeAu8MJJPA3G6VGg==
X-Gm-Gg: ASbGnctn6cj/6iE/SX6mfSLW9Rk242oe+02pZjALlTFF5Uon0ownq2+ZW68Rug2hXdO
	OFgbj+rfz3tQJhF7c/NIullkLa8GPuVtTbKyKOe4wUkqsPyn1xL5JRHf79oj6tKZC1GJapB55QH
	4HVs9EaZx+j9lWSpefGnXJHU6xfjZ5WtTeuZMl7Kv3vSwPnf6ZEQ5RzGB6XqlqD9OnYkKyKLUWc
	3AnE+Z8U+scuiGzD3OdK+j0WB2slyNH6hhp/tjliI2qhVfNPbx/wzia2ZieEff/5L/FHh0eU5nD
	JoWlL5Pa4RyS9j5rB+E/i+LW
X-Received: by 2002:a05:6000:188c:b0:38d:e15e:17e1 with SMTP id ffacd0b85a97d-390ec7c6743mr2982640f8f.10.1740755965143;
        Fri, 28 Feb 2025 07:19:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESVoeT2S2DdM1k5KmwWSEDG3+Y6ip8nyJ8DaRL56CSQn6DUaBjNk1VxnyULKFcvL58bMulcQ==
X-Received: by 2002:a05:6000:188c:b0:38d:e15e:17e1 with SMTP id ffacd0b85a97d-390ec7c6743mr2982591f8f.10.1740755964697;
        Fri, 28 Feb 2025 07:19:24 -0800 (PST)
Received: from ?IPV6:2a02:8070:4688:86a0::a40b? ([2a02:8070:4688:86a0::a40b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28b6fbsm58947605e9.35.2025.02.28.07.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 07:19:24 -0800 (PST)
Message-ID: <4705cebb-dc11-4fac-bfcc-74d0cb5af5fc@redhat.com>
Date: Fri, 28 Feb 2025 16:19:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
From: David Hildenbrand <david@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <029759d4-f7b2-4ec6-b5d0-7c8a1c0fbd80@redhat.com>
 <Z8HPN5sAgInM4dN2@google.com>
 <e110e00f-9032-43ec-808e-45a912065fb0@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e110e00f-9032-43ec-808e-45a912065fb0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.02.25 16:10, David Hildenbrand wrote:
> On 28.02.25 15:59, Sean Christopherson wrote:
>> On Fri, Feb 28, 2025, David Hildenbrand wrote:
>>> On 28.02.25 06:17, Linus Torvalds wrote:
>>>> On Thu, 27 Feb 2025 at 19:03, Mathieu Desnoyers
>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>>
>>>>> I'd be fine with SKSM replacing KSM entirely. However, I don't
>>>>> think we should try to re-implement the existing KSM userspace ABIs
>>>>> over SKSM.
>>>>
>>>> No, absolutely. The only point (for me) for your new synchronous one
>>>> would be if it replaced the kernel thread async scanning, which would
>>>> make the old user space interface basically pointless.
>>>>
>>>> But I don't actually know who uses KSM right now. My reaction really
>>>> comes from a "it's not nice code in the kernel", not from any actual
>>>> knowledge of the users.
>>>>
>>>> Maybe it works really well in some cloud VM environment, and we're
>>>> stuck with it forever.
>>>
>>> Exactly that; and besides the VM use-case, lately people stated using it in
>>> the context of interpreters (IIRC inside Meta) quite successfully as well.
>>
>> Does Red Hat (or any other KVM supporters) actually recommend using KSM for VMs
>> in cloud environments?
> 
> Private clouds yes, that's where it is most commonly used for. I would
> assume that nobody for

forgot to complete that sentence: "... nobody really should be using 
that in public clouds."

-- 
Cheers,

David / dhildenb


