Return-Path: <linux-kernel+bounces-517184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454BEA37D73
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA9E3A13A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46801A256B;
	Mon, 17 Feb 2025 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKdED0x8"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBEC18A92D;
	Mon, 17 Feb 2025 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782236; cv=none; b=uirSmhL0wSd2Yu1jYjdGRUXkHj1lN0vfiQPvb+8FVHnw1JACgnITSeL6oc1lhUxQN5VygU+HIhSGQ5/2EXz8Ks5H7lrEzhcZVnM0MQJchLx7fDfp4PhFk+VRg9so8wkC7BJM40GmA73fzJNuseUery23qmwPX26A4v5T3XRnrCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782236; c=relaxed/simple;
	bh=LDZvrvnajfFCiVKShOMNVT6PzhqmK7Xm5kz/f3v1gs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJPwUpz7qk55/K6Aql12ONbHSLIR2ln4h1NA8qYr96AZRwCJaDd5XmtWweNZNiqAlvAOubzUsm3YXL+wriZf6o+q1zjHUz8j690mfO6yS9rlbCUiXvIqSSUWxljjyzTKfiYSzCQL/87aT2ToUG0t+9UDBXLo3P66gwIufEh4UjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKdED0x8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-546210287c1so748082e87.2;
        Mon, 17 Feb 2025 00:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739782232; x=1740387032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15sJlkRAVyPj2yXL2m25UxKAU72+1zx1kf/yxV8oK1Q=;
        b=DKdED0x8K6O1a7s61F1lgmHwIFfbnUqc6ewJedRldh4qm3npFVc/VgyetDzo2U8G+q
         D9SdBmj5Ww9Jv2AERUOJzezoA2fmTkgQwhHTcvVmMfRas7feNEnJttZhT4EtgsSMMHf2
         025/JfMbJD0FqFPeAx7V18HvYYEKUqgrUJcSvr3qPSYfqJ+cIK/o3FCb58dAinBJOFPI
         JjMKYV1TtjAepp4Wj/BbnVpk+CtnsSWLsSmONA/TIBxzE6cso9WVJ/mLqf9JybxO8Rj2
         uLL4xbODESV+hPpZdgUpPIsZyK7gBvHZOPiWsCJOVhXxpmi7qMWrn7EkK/RVjy1CAGCF
         LwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782232; x=1740387032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15sJlkRAVyPj2yXL2m25UxKAU72+1zx1kf/yxV8oK1Q=;
        b=Ddoeyo2sYuUnMxOfBB7f5ourEol8yZeoSwemD6CLiskh2RXQMf0x/L4Ihv++CrMfjK
         x+Mg8Bq3UWs4qqp1/8gI5yN5uOpS0JwBmP1ss+8gy/nBrySvfkX9RFDDhGe9XUvt7qGH
         DiOFJoKucFVGrK96oakCdbK3zmxirZcJTUiH0H71ZwO+uS+rf4xjJmNJPSUR61Wjjewd
         IkVDxR90318auL7wmf/kVy/aMt39ewzu3xlLBRKQOS2kf42Kjq5YnyAbI6hlnyQq8EsS
         FQHv15FlgfT9DvLne1VVj5SR8IkEVXbhXaXIC7mBe97A2DbwGPR28mdIFIaPbNQ3D6ej
         2yeA==
X-Forwarded-Encrypted: i=1; AJvYcCUQAqQew7LjXIT6bRkXpe19WEhaPs4ctmCUuU4kvr/C4bs+wl157K0NRBcrM8UELvsEO8ztrJlRDbU96aasX6Y=@vger.kernel.org, AJvYcCWbMGMnoGTw7ApI8d1VXDzpPeiXFL+/L7myVUlWuizk1i4hGA8t9aYo38KgBcqD6Tm5YXJnRC8bu/uOcGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7iPkizGYvEUgyj7S6WCWXwBtOWBFwEj00XTJcA2my/CoDkYJi
	HXjcE33xcZFi1w4P8BM9zbSeKKsqJgcXcdZrK+huezrXF3wgC87V
X-Gm-Gg: ASbGncvpwJrMXNt4Xwc9/r/TgqSvk8yTvMNhbyT0AUmxSkDB67vNOnJiOiNqjLEbD7D
	OpdN4RT6vNvsTfqwHqIrvinIwme3m27phkp3COd5Y9/NsERe2Q0WR8aKX92ge183uSDuWHyzE98
	784WZXyLqM5DjJRFxEHMLB7Y2dF9MjyQm0Iot68MPwLQ1/9txAMzhrj0n0G+lQtgThD8FiIYnfL
	bkq95Id1Iusu7jjumQIRz2XCi3w3syYqdgjLehAaf6YGOBp40PKRsgejf2QJAgmMd2kXx/qEYeU
	u1rHNt8WfB6SrxqyqCps4xaqK6sf0Sgb4yTxZRw9XPfsGqxBPA/xG4TRnWK9YQ==
X-Google-Smtp-Source: AGHT+IGaHheOILe7K9w5EI0RYI4+HeNtuOVz2eplb4wa4gUOP8nsm97KcUdOF6JMLYez9m6RmnpboA==
X-Received: by 2002:a05:6512:2214:b0:540:2da2:f282 with SMTP id 2adb3069b0e04-5452fe80876mr2283974e87.42.1739782232234;
        Mon, 17 Feb 2025 00:50:32 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461ad64b81sm601243e87.107.2025.02.17.00.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 00:50:30 -0800 (PST)
Message-ID: <a204824d-2280-4402-b870-9db3e2e15aba@gmail.com>
Date: Mon, 17 Feb 2025 10:50:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] rust: page: Support borrowing `struct page` and
 physaddr conversion
To: Asahi Lina <lina@asahilina.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Jann Horn <jannh@google.com>,
 Matthew Wilcox <willy@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 airlied@redhat.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 Danilo Krummrich <dakr@kernel.org>
References: <20250202-rust-page-v1-0-e3170d7fe55e@asahilina.net>
 <Z6CY4TvZwLkWmB3I@pollux>
 <a3551d7d-14c7-40a0-90ff-1fcce93be62a@asahilina.net>
 <cae5503e-4330-4c44-8a50-1ebf63ea5a24@asahilina.net>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <cae5503e-4330-4c44-8a50-1ebf63ea5a24@asahilina.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 15/02/2025 21:47, Asahi Lina wrote:
> 
> Given the discussion in the other subthreads, it looks like this is not
> the best approach for page table management and using it for crash dumps
> of arbitrary physical memory pages raises some eyebrows, so I'm going to
> abandon this series.
> 
> Abdiel, if the first two patches are helpful to your work, please feel
> free to incorporate them into a v4. Otherwise, just go ahead with
> whatever works for you!
> 

Thanks you for improving the series, much appreciated! I will try to 
incorporate your improvements.

Btw, I'll most probably pick this up again once I'm finished with the 
rust dma coherent allocator bindings.

Kind regards,
Abdiel

