Return-Path: <linux-kernel+bounces-560279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B67A6018C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75CF421896
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31B01F3D31;
	Thu, 13 Mar 2025 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKzFCWiD"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C536918A6B8;
	Thu, 13 Mar 2025 19:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895226; cv=none; b=ErnotwU04RjhUdr6t3BHj4QgL/gXCUoSQv4UFLDj06Cqq2AP8OLkObkXP2XVj8ehTx5XrKiUfmZZKFb/evy1bYbf/7Y04JJT8bqyfvtcgNfJYhTdGw7Zr/xHm/IDtr/GoqsAC+LPtsbxlsna7dBNArPy4hMAltzWUJI0C6R/c+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895226; c=relaxed/simple;
	bh=C70utpQ5Fg5pVOCYURJD4McKlJnl9YY21kH4QBeulXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfE/6tYuZuacHnwcYgp/9uW8fzBfuHn9zIXT/111wkRavmReD5Vd54Eb7VMD8ULG9VVxuLUR2seskJmk63Stwn6DAFbmIdmFyjzOpE7uRJE9l1/IeTbgYCAdVIk4JmU3H6njkTHrM3du+5Jvhod5o04jFyNCrP+OZp1VQLLxtV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKzFCWiD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2963dc379so235658966b.2;
        Thu, 13 Mar 2025 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741895223; x=1742500023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPLplXMJ7eioj4yLEZRqxIwmGMVKpETg6Yo7IQnbIbI=;
        b=dKzFCWiDCj6E3urQXpgzojeiDDfPt/UsfukDpfqbXFH628tjF9T8VZ+cCHfRSiwTtk
         fN0xJN8IyZ/DFAYxWRw5Fmr7SKUgAYt7tcTQAcP/mzG5gJFuIJN6hyHbzo0RSA2yjpHI
         ZJtGY6IYpHefzottqXpUhjywc9Q0c96F7Q/NJOCB+hUcWU/9d0g+R658/VkPB2a/8zbf
         Pn9fT/X+mkRvnQCFjsoHsp1+LuzMdHgWPvwbqt9Y0tGwGfveAo3vSU94ynm6JI6e3+fG
         2eVfs/JvRmeUi4nd1X3NK+yH3CvA1C8xhyMlSvTtX6dqovm7fMwXMIvd2tAGaPTrO9hr
         dw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741895223; x=1742500023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPLplXMJ7eioj4yLEZRqxIwmGMVKpETg6Yo7IQnbIbI=;
        b=Vgv9d4M2X0Hsxoesm/STo4xLqbcZ9vwYmeTpDQOzU/VvfmsJ9+p+hWtH0r6vUCWtcO
         YNfZinWQXzEWH4/KMHbmluH3V7PYjucD9uHKcLUZUEgq2EMJOReskBcDKtkBXqMTpCP7
         ENkydPIHzivnnIWugG5PktFM2Ix2J3Z1SJAwAdiypVwvd0RI1UjzAezHt++lcZb/nsiH
         oONZY6wIJjbjVqBpPhuyGNXOVoWKaoR2aZSPKhG9ugDMKa+RiE2OHo235lRDX39GXLA8
         qICZqAQSBkU2NJQ6OIAzqxGM+Can7+ykAoVcWhtLdg58PhvRTLQu/1aN0+Pjr2RxDgTr
         5UBw==
X-Forwarded-Encrypted: i=1; AJvYcCVXaB/Cevh32fxddSM6sGupRMW4YwibpmNgl3im1g99ujNucKGxhBdowonpChkPk6aTKEkmGiQbkwIwm0Yhq+c=@vger.kernel.org, AJvYcCXAB/+hbbhoElTmI1oSvE23H9zFCz1G9VxWKHKfiNF7+M0zPyfGWQsxUPDXrPrttshehXkfgLH4WCm1CJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXMuZNAUJE2SmGOLtEkvUai86x38P6H0F84cgUVl/2qIbG4Xma
	8LEkn1Bqbzd/imOOyKrrRDyiJiszBD73SFJZfi0nNy2Y2cJsj9Zw
X-Gm-Gg: ASbGncu96A5nUHQ+iG6f0i0kFw90Pr2hNqT9lCIJ2CZpaiD3PmOzNcDcJkVM8+TbyAC
	WVbrn84Pv+z4xLRTJhe3u6IHt0gAjCs8pM80GzHRHbiuU3F5MA26/hRXmAw7NBeCUSfJF65uJnN
	n9stq8zTY1z6kvMx0NQKeWwk6X5YH05SYLGnoquCSgMWhhvMPKs4KYGXPnexa78AC6GEg8hGKoA
	2P+0/QNJr5f2yPhckgxWcUIpK7tv2wH6I4U5fqT8NIPorUh6ZY7VtAkBdlc5H5jBefSWuJgN5Iq
	vd7zpQSorIf8+6GGvbVHxr2LYaKkWK1fj5fbjmpSP+q0qCYGX2cFWc0zx1EtNczPtsRs
X-Google-Smtp-Source: AGHT+IGEL4UREDPPDrxoxnNI8kfMYT7s21VawThA3HCdE5uu1hyBgahn+AgNtlGzFZRTE4NjjaJZiQ==
X-Received: by 2002:a17:907:d9e:b0:ac1:f19a:c0a0 with SMTP id a640c23a62f3a-ac3291d502amr78999166b.20.1741895222990;
        Thu, 13 Mar 2025 12:47:02 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:99c5::1ad1? ([2001:871:22a:99c5::1ad1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cfbfasm119641966b.104.2025.03.13.12.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 12:47:02 -0700 (PDT)
Message-ID: <dd82a784-3f86-4dbe-a1de-b3130ab15d51@gmail.com>
Date: Thu, 13 Mar 2025 20:47:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] samples: rust_misc_device: fix markup in top-level docs
To: Alice Ryhl <aliceryhl@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Lee Jones <lee@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250313-rust_misc_device_tld-v1-1-a519bced9a6d@google.com>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20250313-rust_misc_device_tld-v1-1-a519bced9a6d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.03.25 9:52 AM, Alice Ryhl wrote:
> The meaning of /// is to document the thing that comes after it, so
> currently the example is documentation for the `use core::pin::Pin;`
> statement. To write top-level docs (and have them rendered as such in
> the html by rustdoc), use //! instead.
> 
> This does not change the contents of the docs at all. The only change is
> changing /// to //!.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>

Cheers
Christian

