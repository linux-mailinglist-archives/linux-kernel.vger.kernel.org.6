Return-Path: <linux-kernel+bounces-413064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738759D12E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE2B1F23B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37B71AA1D9;
	Mon, 18 Nov 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="TkFxCrjQ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139A51A265E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939766; cv=none; b=CUFkhmJAfa8t+yVluHjIfKFDiVsAyXJv5TLzyJMnKm6j/gZkQupwZb/xvN13fxV7b04kALhXgkvpil3w+6aw/CloFJRnDm7tYkb0CWCcW8QMco0pBu/TizXTL7Q8yPf9ntemjqLEQ8bB533ienBDr7Xen3s821OfpDa0jgm7CzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939766; c=relaxed/simple;
	bh=0/JguiZcTPrNz/YSnYa6PH270B4ZDgqsime95IrntPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRfW2NW/BUSSny3qIO9wthDfMryIdNiEjBmd1ttuNmoqmeVSIiieaDYPH/31glMHgBO/aTuzHZP4u820SqOgPsSrmRBy9Q++xjm5FjCOW0xTujKHH/K7BCTxIehU3ZfoFtMbN8fvIkd1tk/P/4oadUQ7OYwxDsahsL6rbDObTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=TkFxCrjQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso3345294b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1731939762; x=1732544562; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8U2P1opxMKXLCU8WluCY8oxXYTWyAxW/3p1HSS0hYGc=;
        b=TkFxCrjQtoLEfTUtL6ah/uLRqqYZ+E8u4J682epsRchlgBYV0M1BSM8earQcMlG0e5
         mmMdvDdqmOKwfrDZ4lelsCLAHA3UUgNcqBnJqjjrq8aKZtKCNAAl8yErmMyOeaK3z30c
         c7e5e8H9fEzWDH1itMyZEEqYJWV7ZskYRypFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731939762; x=1732544562;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8U2P1opxMKXLCU8WluCY8oxXYTWyAxW/3p1HSS0hYGc=;
        b=pivexvqxo8zmQxjV9bCm57KxTfHZ23uF8cdeTCerBlpCsF9BAAJipkSlICutyuJkse
         Dg01qaFiz1LsUIz2xyxjbpxXEaQoZ/APH9N9l6ISy8bJIgE5G3t360AisuVIyjjc/VVk
         OAyqgQh0a7moFopsWOJQxxyHnCows9hz8t1fbX2U9T26fxAQFnpAV/z+E0IaomtWzdKo
         //HKHb1pJXIp0+tUcVl0i09Yean80K3l0E/l/nNykNQoaECKbbFNDbMvDcHqP5mHsGOF
         K0Dzjl9hLjzqZvQIH/yp0Ga/1v8lT/KywKg4DI2biZS1F9TPTcPtXmYqt9i/acDWVbZ/
         Pk3A==
X-Forwarded-Encrypted: i=1; AJvYcCXbCRjx0uLVeE9exSfB8n4tmoAfjYxBxO4+0D8Ces6IrRLgd7uOt9umMiqN7tSQxAu182Z1ccrb8CwdWso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSAohqPFylQOcb740VCxEaewt1cQcDu+oaUuYEm/5QArVM2Lou
	fXmEfgjtwHgUs+eL5Z4PzW4vTeWFjzXquUOzytJLzLiZoXWUMLGn8X79soKBBT0=
X-Google-Smtp-Source: AGHT+IGgcOjKbKA8w5b7kuKMeOESVvEYFAjmcimvNF36hlrzlrHCp7ZaXrb4iv9nf7aq17KqWEhawA==
X-Received: by 2002:a05:6a00:1792:b0:71e:4bfb:a1f9 with SMTP id d2e1a72fcca58-72476d58965mr15670768b3a.22.1731939762414;
        Mon, 18 Nov 2024 06:22:42 -0800 (PST)
Received: from fedora ([103.3.204.127])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dc03fbsm6002289a12.70.2024.11.18.06.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:22:41 -0800 (PST)
Date: Mon, 18 Nov 2024 19:52:29 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Alice Ryhl <aliceryhl@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: block: simplify Result<()> in
 validate_block_size return
Message-ID: <oc2pslg33lfkwpjeho2trjltrg6nw2plxizvb7dq3gvlzkme6t@eauzzfnizzqu>
References: <20241118-simplify-result-v2-0-9d280ada516d@iiitd.ac.in>
 <20241118-simplify-result-v2-1-9d280ada516d@iiitd.ac.in>
 <CANiq72=o56xxJLEo7VL=-wUfKa7jZ75Tg3rRHv+CHg9jaxqRQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=o56xxJLEo7VL=-wUfKa7jZ75Tg3rRHv+CHg9jaxqRQA@mail.gmail.com>

On 18.11.2024 15:08, Miguel Ojeda wrote:
>On Mon, Nov 18, 2024 at 2:12 PM Manas via B4 Relay
><devnull+manas18244.iiitd.ac.in@kernel.org> wrote:
>>
>> `Result` is used in place of `Result<()>` because the default type
>> parameters are unit `()` and `Error` types, which are automatically
>> inferred. This patch keeps the usage consistent throughout codebase.
>
>The tags you had in v1 (Link, Suggested-by) seem to have been removed.
>
>Nit: the usual style is to use the imperative tense when describing
>the change that the patch performs, although that is not a hard rule,
>e.g. you could say "Thus keep the usage consistent throughout the
>codebase." in the last sentence.
>
Will do.

>> Signed-off-by: Manas <manas18244@iiitd.ac.in>
>
>Same comment as in v1 about the "known identity".
>
Actually, "Manas" is my __official__ name.

>(The notes above apply to the other patches too).
>
>The change itself looks fine to me of course, so with those fixed,
>please feel free to add in your next version:
>
>Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
>
Adding tags in v3.

-- 
Manas

