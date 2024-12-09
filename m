Return-Path: <linux-kernel+bounces-437487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D347E9E93F4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A779162B18
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027B9223711;
	Mon,  9 Dec 2024 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="RVWcxYod"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D515521D008
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747393; cv=none; b=PkFBdTVb5AhyGNjYQb01F9xy1mjFqEYlP4TBJwws3TbNRE8HYSeJh5eu10+9VnJeBEnZ9GnouezMb8FL0hxLUEOoU5hYcJ93wc3WsGAtxu8Ng2jc+TJVx8+nW5ZI0WGntRGrz8X4q/NWacywiTC68lmvS2R6zl7JubRrJwVCi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747393; c=relaxed/simple;
	bh=sUfST4In6BFaz4cncct0K9JmI5C47/iyHU7EzK2F71Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMbjMUn2zEodM9y17l22vILoVCtpcsbUlrFfAkRLlwoHY1/waaQGmmF28+yHgS3q8zn/zhhYnYP7GvtMhukSOhuuNoCwX+AmwTVjK8ev0lteOxc4CINiJxEtO9wJTuKyUA+Hgr2qFi9YRiceFUHqt18SRbNOSr7qHOL2biAbn9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=RVWcxYod; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so4298556a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1733747390; x=1734352190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sk/tDYD6KLC2uTv+ULUwwSmFTXAbs0Ll7BQ/8lxfZoA=;
        b=RVWcxYodI0YpVJkAhsUQbzs5+/kzV9uTotJZz7CrK44j8RGSupfw1Yvg4yksjEzUyz
         h5iXHMniNuh4nNVPZVAlNfaifp4ekBuv2ls0UjsOCOXnEXfaOKdJfGVlSMJeu+aXNtvY
         uoaDG1v075EwWmMsRfalRKsTcMIngSYAE0dDb8skSzhoHSVIi0bBIc3hLg1/+MI/1c9W
         NyEi60zosZai9gKfRIrYooGc8wHJCVnNBVk6Ja2zo7DyETuDNJ0jXi6Cdl6iDfGBhLPO
         G6TYwx/vSuc8HL2KRv5bhZVLU/GLuzGurU7dSrpn9zF9L4L2WWmfDZ06LoBQyLTrOEyt
         45zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747390; x=1734352190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk/tDYD6KLC2uTv+ULUwwSmFTXAbs0Ll7BQ/8lxfZoA=;
        b=Q/liJTIYfP2gvRUGpMRrYkiHiJxWzY/JY/AoekRPt9GHA7au8ig2+a5Hb/PqFvdux0
         B8R/RtVYTl5nPTRBu1BhzkuN0Ih/9n5FTfRJVoJdugYTprlt4mCi4J5cHEqg1xSt+yPM
         skEh1hGkplTf8+GOh7NDSErSaVf0jkQNIDQroBFAx/fvIvbVYxf95/+f82SscWlLThKH
         u+h0/1slJ7RmlI91/dvqVTeKLZSAT0C1L+cOfWphYLjtR5L+9vTcP7dlRi1dWV5Dg3zL
         GT4J9Bm9yEDD8I0KY4bhNgF6ppDh3D1kZD/09jER3o/SNVs87CWQ6tu2NGTPaNgvUK/L
         ucjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9sDysnm+ZZ2Tf+uGp9zvrW9dFzBos8gx2ClUX56v+B0KgSOccwJWjix4isu3sLkGwER1wESoGe0diuPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxF7ZOJfie/EHkqC01Itq9qBnXoviAeJibwJ00pVGRUf3vnM1I
	sW3wr8exPPoKMz6ozMWFJ7/fgxUmTNbZUWpJku5llum809kzegYovVqP37dd+zM=
X-Gm-Gg: ASbGncsRkKlDyvlVSuQXryjry3TSOHMmPcaVcR9GP0zfT4lPD+CRNlgt/6yX3eJ7o7z
	b+c9Be6Rk3etVcK45hGtXzCM8kwTg9lvBC+Y99AmDECOE769tcZ613illqc+b9NZgLx5CgsCIqU
	cWmEh/qCeQys0nCsomC+OP43RBu81tSVclf52br1fO0ifSshWz1qocfm7sEQIp1L8CgQk4iDGGu
	OuOG1pT4KhjNiIeSgf85csbczZ5wH+dTUyGl8thwmmkb0UA6j9Wn4inhSIac/kf
X-Google-Smtp-Source: AGHT+IH2aAKoc3rAG/qXUabUikj4892OrzH2t0bgWmHMpBTkxJWD9/FuokOe61AUb1FB7NHXZ/X5nw==
X-Received: by 2002:a05:6402:350f:b0:5d0:b455:36ad with SMTP id 4fb4d7f45d1cf-5d4185faa5emr504294a12.27.1733747390155;
        Mon, 09 Dec 2024 04:29:50 -0800 (PST)
Received: from [10.0.5.28] (remote.cdn77.com. [95.168.203.222])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3bf50397csm4910222a12.79.2024.12.09.04.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 04:29:49 -0800 (PST)
Message-ID: <23097a11-2bf3-4ae0-a1d8-9df5f772e15d@sedlak.dev>
Date: Mon, 9 Dec 2024 13:29:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH] rust: macros: add authors
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: guilherme giacomo simoes <trintaeoitogc@gmail.com>,
 Wayne Campbell <wcampbell1995@gmail.com>, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, walmeida@microsoft.com,
 fujita.tomonori@gmail.com, tahbertschinger@gmail.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241206192244.443486-1-trintaeoitogc@gmail.com>
 <CANiq72neo_RtANWJu_GW5LxsR5KWxriS1L8nsXkNn7ioiaEQKQ@mail.gmail.com>
 <30ddfc7f-4b13-4caf-8859-2cd2e72ef878@sedlak.dev>
 <CANiq72mh2_QhHcE65-t+6UEEqe+9XwGQ3gJ1CCQpZ6r3HOcokQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <CANiq72mh2_QhHcE65-t+6UEEqe+9XwGQ3gJ1CCQpZ6r3HOcokQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/9/24 12:47 PM, Miguel Ojeda wrote:
> On Sat, Dec 7, 2024 at 11:15 AM Daniel Sedlak <daniel@sedlak.dev> wrote:
>>
>> I think we could fight with the code formatting, because when it comes
>> to the rust macros, rustfmt is often very confused and we could end up
>> with variations like:
>>
>>          authors: ["author1", "author2",
>>                          "author3"]
>>
>> or
>>
>>          authors: [
>>                     "author1",
>>                     "author2",
>>                    ]
>>
>> and rustfmt would be totally ok with both of them.
> 
> Yeah, that is a good point. There are hundreds of drivers with 2+
> authors, so this could indeed be an issue eventually.
> 
> Having said that, we already have e.g. the `alias` and `firmware` keys
> that take a list, so I think we already have the potential issue, thus
> being consistent in our use of lists sounds simpler (unless we are
> discussing migrating those away too).

Ops, it did not occur to me, that we already have lists. I would propose 
to migrate them too, however it may be controversial.
> 
> We could also try to mitigate the formatting issue via e.g.
> `checkpatch.pl` if needed.

That is true, it could be part of `checkpatch.pl`, however I would argue 
that if we can overcame the formatting problems by repeating the field, 
instead of modifying `checkpatch.pl`, then none code is better than some 
code (regarding modifying `checkpatch.pl`).

Thank you for feedback

Daniel


