Return-Path: <linux-kernel+bounces-417876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F349D5A21
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449471F22476
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2D0175D39;
	Fri, 22 Nov 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKhpmIpo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB513AA38
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261391; cv=none; b=gkmc/5dJp4Wn8dTFRaNqj1jGT8aU1CLe8SmozLKcfPEibV6d1vP9IW1eDrvVf6VO0EFL7vMIFEnXqZf3HGQ+j42XDG9UchAppn5rXsZ0UX3KDnkmmNhsLIV+RQ4KAbDlkbhOWsS4VytJFrwXuKHihlWIBXaBd/5MnNXKS+DKpRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261391; c=relaxed/simple;
	bh=jK/FNIlK8tsMqB8ZFmlzab7x6UGHSAQ5wXn2mzOrQSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vlj/2AcArZUTlIRatMKuR05rHlqmoVUApd1Sjg8WMBuosL1M/TspQbyDNP4f1NmW69xPqxZIORfpduDaERSANE5Cp3LEcCpZTe2NiahIUeayl6eq4gsKIDao2upjXt01sGa4L6rAqMo12bwBM7tVxe5q4H3VUrr4HU3WAP/pmtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKhpmIpo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732261388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MLuOM2jyOvbwOm3slJe1qDQLYEaIBoA5WM2sEjnXbxs=;
	b=VKhpmIpojWHQrcXtH133DmqA8aMt86YZUtI66Ss8iLn9zBysu5kN1/lOeEUIadhJlOlYXy
	s6jk1xwMumzho4NO3bMGTQ/mXvVzRSUEL9hS5dV17wB6dxp7uBpmGjBlwhZ7J9ivhHYVYP
	fcxMeydvE9yZR23cissYdnR4IXDDF9o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645--DlIZB2JNza4K6apAZFxWg-1; Fri, 22 Nov 2024 02:43:07 -0500
X-MC-Unique: -DlIZB2JNza4K6apAZFxWg-1
X-Mimecast-MFC-AGG-ID: -DlIZB2JNza4K6apAZFxWg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3823fe49055so887004f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 23:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732261386; x=1732866186;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLuOM2jyOvbwOm3slJe1qDQLYEaIBoA5WM2sEjnXbxs=;
        b=d8bw+DmZKC+UwqftmbKH0irQZe89SjfhaF/lhYgIAu3RzS6OZ6NXbRGbFMyEKV1uqX
         /aSP1pfK+Oy/REVyZjqppXJ//+z+j+wIDetYuQK0b3N9NO80UAVr1us0wmYxO+O5Z2vP
         6kMUT8pJ6tVK4qoHQHPcpAavfn+pFWbXQ4jOGRet8MYv3ExeHITOUwEHTdSKVeo7KoQQ
         nfKmEJBLq7MkeomNshKR3csB59c178aIyPkZYLJAclf9FUoOG9t+24HzZt4PY+NrPoY/
         Qr92T3LSmOfF/FYbDRmPDvAvruutYsse9xyx0G76xGH53g0oqT4yyImo/Yt2AguUJs2d
         74lw==
X-Forwarded-Encrypted: i=1; AJvYcCX1TtClIfV67ozGiUbrET99XTqLoMoK1aa9N77Fp1Wft7/xb2uQu/zmFq1vbr3g0YOs7ViDFZGl3DPqYjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqTybSmXb5ldxHI/Nro2S6MwigRHylfhtSO13NBtqOSOWqRAw
	7h6TtYikrgxCNJ2Mq4ioU93ptMWshtfUkDueY/rZsYeme7PyAtJpE91BqzncaQ1pMXlr5dgGuzY
	DEsjzD7UsjcG0x8br+WsxIdfRLUEnAG/idHiN5ANYVuC72r0gXDFHnAb1KRdOyw==
X-Gm-Gg: ASbGncuOTxA6tf3snMtHEK22jJ1UaGvHASyxqg6ZA2Tz2Sqkdt67SI+j+02vshM0qlA
	1nCc9/6ydbdBvDYiHP+Cp3d/f/mqP1IxaU/LT2CGy9+HQLzKTbSuPJog7C0KWSD+/jonBo6Kk/j
	hhdGvwBlByiuXaXcTn9NoTmlVIgsSLdAePdEl1aApX5VnmQL6DoT8qpwCHXDbpY+qKxyOLuiTL4
	cfkqld+813DzixbOK/rDShmarqO3TFoPO4GYyW+6ijVNoQqDh3Kzg==
X-Received: by 2002:a05:6000:1a85:b0:382:4a84:674 with SMTP id ffacd0b85a97d-38260b4d71bmr1550581f8f.6.1732261386205;
        Thu, 21 Nov 2024 23:43:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErr6tGtMpb1BI/SaT/P9DocViH61GRfOwtoSRh1kWEGsxbd7v7DIZjhkvQ1DPGpB8NU6RJNw==
X-Received: by 2002:a05:6000:1a85:b0:382:4a84:674 with SMTP id ffacd0b85a97d-38260b4d71bmr1550569f8f.6.1732261385918;
        Thu, 21 Nov 2024 23:43:05 -0800 (PST)
Received: from [192.168.10.3] ([151.49.204.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3825fb537dfsm1641614f8f.63.2024.11.21.23.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 23:43:05 -0800 (PST)
Message-ID: <d24e6a07-eff2-403c-ad4d-f52d55fffe2f@redhat.com>
Date: Fri, 22 Nov 2024 08:42:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] mm: rust: add abstraction for struct mm_struct
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-1-eb31425da66b@google.com>
 <0c6f4dbb-ff09-439c-b736-35568c1450cc@lucifer.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <0c6f4dbb-ff09-439c-b736-35568c1450cc@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 19:13, Lorenzo Stoakes wrote:
> I will obviously inevitably ask a TON of questions as a result of not being
> a rust person so, bear with me...

I'm just a lurker on the rust-for-linux mailing list but... thanks *so 
much* Lorenzo and Alice for this thread.  It's the best introduction to 
Rust idioms for kernel programmers I've ever seen.

Paolo


