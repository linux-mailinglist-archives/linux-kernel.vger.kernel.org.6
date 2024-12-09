Return-Path: <linux-kernel+bounces-437471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B91A9E93B4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD471886666
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D79224883;
	Mon,  9 Dec 2024 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="aSbfBIrH"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636B221DBB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746879; cv=none; b=SaTuyLsKBvkEqUoUGzxl3yBgES8zz7C9dzCEoMlit3+pQ/wLR4KaBFN8VmLJYAD3Y7Mzm0Xg8WSgiaXRgOgqVftc6E3glBZVMCImhFGaHZNgjOzXRKjuQg36wqn9PRmUshV/Ew0gN9QMMLV7HijnPYC6ww2hAqWtLNWhgWTgoy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746879; c=relaxed/simple;
	bh=8utcAxsj+pJTUqPDN860t1qjaumRVIpZTC75BYlvgmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lye2LWyA4TumiOITD8jyCWugJlRkNuHfyFMT21qoMGZ0k7hssm4hg01T4ErwnhcrRqDx7zMW+mOleRsAY+F/JMfMuTuqU1gqQQvRBfMbEXSgnYhD9Ci1C1GnIbFuFPq4PaM9KqxHeSB3/VbfCS4EI0N2/4QX7/Z+vmoD9APUlSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=aSbfBIrH; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso227094a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1733746876; x=1734351676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VAe/WrvAO614ewJyqnO2H121EDzMzUqOIWvHqI1VrK0=;
        b=aSbfBIrHPr0EMCf+07VE1IaVy5UMe09skgRhf938pZC/pyPbQgzzlPJZ9XU84KXZRI
         cltx41QvpKz14IbBnch5Q3OE1NY0TtpE/qESBjwNB2E5NEXskgl+S3ZmlvUBvoP5ZFnm
         +DcioWhX60xEtXQ5lpANTzDaPrm3kHzOYEK9O4A89xpEbsvzGuOB+PAZMllK2tzB2hJR
         1ocd8zde/gWMndxho8pO6ASj2NzBF2AHcjBYU2MMV/oie3eQxSApKFWEybVzFYgztecy
         rGcxhoPYvm2h6XGlUrcPIb/IlAXq78a418baG7NnX0Kbfoi2lyHfK87KhzKUOAX736FJ
         z6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733746876; x=1734351676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAe/WrvAO614ewJyqnO2H121EDzMzUqOIWvHqI1VrK0=;
        b=USFYIsWU3Z0q9Getl/IaOSFCq6bmkhIURm8f8kRAASRx/00OFlg5ujSKarkP6+PPIv
         yClvZD+CoxLIwckXjW1W9/k7ymGvUk+/RReGKFE6LDLIT39WetB2HC9T67ehIE2kGTwW
         E+6/nrJAbgdJmiowNMYgJkzHat6RxgfzGcfZDbs0Q1uiTe2tHsoJ/nYUTrPRI6FWsZOd
         DZRkoiqXwui5cJ0Vdr5MjniJcnWHE4vV6lGAgW5P/+M55v4n6nozbv/LgzusWwRWNbOf
         PxbAnHXP2caNUAnycbjNyyU5qTni2T4D04lmxyRm2NeJDlCZNFRa1hD0QfbesEK3zHsn
         ndPg==
X-Forwarded-Encrypted: i=1; AJvYcCXIT2HqQsEG+fQ4f+Fk75B6RVZN2JkXqMoDIuEyWdmHseZ8gFpP5miIDgyoBzuq7My29qd/tho8epO/vMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRiovvE4jF69RNka5JcK8GPwfbWigXxIRmsxTA8cXoq3HXJd8c
	eL/5uSAsKrts2h7jtwKWX2VVHYCWbbhe+NvXJzD5Qb+SD/Jy/u4HBo0X9iBfi1M=
X-Gm-Gg: ASbGnctBIC3BMJLEnQd9BC127E9PvaulMlxBTGypGhzXK/N+yRdoPlAxXtsu7glxI9k
	BAPE79ixsQ3os+86vDpwREnewKdZ93jjuF5w6q1mOrSajtzSeXPmMe8w8marBCOSZspmKfARZE+
	2VXVFCS24U7HHC5XMcsnVhcsVlvXU6PTf4l9EEOOBOny8+BnL3q4eHoJ9XdbUQbzLginDeC/riG
	CVSb7D5XatXVR0d1mfuemLAeXAWUtvjOuT3NztmOIXaKfaI6jpBH1ZXx26/
X-Google-Smtp-Source: AGHT+IHjrh6LE0PcPZmR8mr8RHYphJyd/XBzn2/0KrIDe7xA1buFgD7f4zOLwWuixcQm58vMO7Dqtw==
X-Received: by 2002:a05:6402:a00e:b0:5d3:d8e7:d6d2 with SMTP id 4fb4d7f45d1cf-5d3d8e7d818mr9722162a12.1.1733746875821;
        Mon, 09 Dec 2024 04:21:15 -0800 (PST)
Received: from [10.0.5.28] (remote.cdn77.com. [95.168.203.222])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48acasm5985744a12.26.2024.12.09.04.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 04:21:15 -0800 (PST)
Message-ID: <47973753-510a-4410-af72-dea9228ca5de@sedlak.dev>
Date: Mon, 9 Dec 2024 13:21:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: macros: add authors
To: guilherme giacomo simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com,
 benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 fujita.tomonori@gmail.com, gary@garyguo.net, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, tahbertschinger@gmail.com,
 tmgross@umich.edu, walmeida@microsoft.com, wcampbell1995@gmail.com
References: <30ddfc7f-4b13-4caf-8859-2cd2e72ef878@sedlak.dev>
 <20241207160703.55846-1-trintaeoitogc@gmail.com>
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <20241207160703.55846-1-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/7/24 5:07 PM, guilherme giacomo simoes wrote:
> Daniel Sedlak <daniel@sedlak.dev> wrote:
>> Since module is a macro, if we would allow syntax in the macro like:
>>
>> 	authors: ["author1", "author2", ...]
>>
>> I think we could fight with the code formatting, because when it comes
>> to the rust macros, rustfmt is often very confused and we could end up
>> with variations like:
>>
>> 	authors: ["author1", "author2",
>> 			"author3"]
>>
>> or
>>
>> 	authors: [
>> 		   "author1",
>> 		   "author2",
>> 		  ]
>>
>> and rustfmt would be totally ok with both of them.
> It seems to me that the rustfmt.toml in the kernel, don't have a max width for
> line. Are you sure that the rustfmt would broke the line for big enough lines?

That is not what I meant. See [1] or [2] as an example (there are plenty 
of those cases).

Link: https://github.com/rust-lang/rustfmt/discussions/5437 [1]
Link: https://users.rust-lang.org/t/rustfmt-skips-macro-arguments/74807 [2]
> 
>> I think accepting several "author" fields is the best one because it
>> mirrors the C API, where in C when you want to specify more authors you
>> just repeat the MODULE_AUTHOR("author<N>") macro.
> If you (daniel and miguel) are ok with repeat the `author` field and think that
> this is the better option I is happy to make this change.

I am Ok with repeating the field, so I would vote for that. However if 
Miguel thinks that it is a bad idea, I will not contest that.
> 
> I was run the follow command:
> grep -rwo 'MODULE_AUTHOR' . | awk -F: '{count[$1]++} END {for (file in count) if (count[file] > 1) print file, count[file]}' | sort -k2 -n > res
> for found the modules with more than one MODULE_AUTHOR.
> I see that the maximum of MODULE_AUTHOR that is contains in a module is 11. 

Thank you for posting your results and working on that.

Daniel



