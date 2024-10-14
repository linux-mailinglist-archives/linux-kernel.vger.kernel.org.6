Return-Path: <linux-kernel+bounces-363619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CE699C4BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A631C22DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1C9159596;
	Mon, 14 Oct 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXFTJtbv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B0158DDC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896777; cv=none; b=d4W4tVvCbUK+q6oB5cOVXPNXcymAiItTUWEHKbQMkteZ8YoOKiCRB6yx5Tto0XBYUxFQZZUp6sKbtHjLF7Xg6kxAKZQtY/l927GKVkpTTaAFqUK7xknfzGpsFojC9VtUcmK7rX68H9omvaPOeoD4mrkE+pmq5J8K4/tQBsYfsQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896777; c=relaxed/simple;
	bh=/NYDUbcYsfrPCw8OG9MBVDUi8PxJyMeQ6kptO07FNQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYk6ajeWXWBsq0a/I4TPxsU2QWGCtKS43WkHTtjepMfqTsb4gh4v3qMdjmf1fdeTKen820HZtFC6Iwmx5MlBBTXtqpBeIF51+mfOiJDBalGU0yoc2hqgH2OfluL4tEXFi1eBFbrPLHRKv7Oc2+7dyQYMBLcXjZo68gFUuMbVCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXFTJtbv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728896774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F17udMnek9Ri4VpOz181mg426zHfJskr96SKZNMjm5U=;
	b=YXFTJtbvcdEw2QMpQc6fHWLSRAvp1M/wgnotR0bwFbeEAdDTyrQj2LLQnUT6sJRUURJGHv
	0lg2kX32hveVrMefw9Jxaiwke7pzxoO4zzmVgroAhQfNxZPdvisodr2x0jYO4EYkfgIUvu
	ckeFpNRBCIah7bAQnwIGd4FPQtEyEPc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-z4etaohFMsKE10SjTXoCKA-1; Mon, 14 Oct 2024 05:06:13 -0400
X-MC-Unique: z4etaohFMsKE10SjTXoCKA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d4cf04be1so1914728f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896772; x=1729501572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F17udMnek9Ri4VpOz181mg426zHfJskr96SKZNMjm5U=;
        b=ZneBqW9AoaCMi/6auHUZ3bSFp7fcxC8JjTYDuehZgxHbbKyCP1F3++9Tn3hOrgDTuZ
         rGDg1slN3+IpdVYG5XAxzLY3mRJrMPljx4zpK1yT2hG0r9k+6oOmuW/K52T4/qt/EHtb
         /pP9DBwKuZItklVFEpIzqz+vA8GLmichxIZtnQmYru69yHJufHORKBiCQfS9xx+EMOZG
         HUSfNn56g7FI8G8rb5cJyOgIPHRqcEYcOdLaySg8i8PL9PVo5KHxanB9hSkwvt5eIIct
         nL5KCdtPjrjCLrmRg6YU4CYgx6M/oHbstcuR0gHEUmEl8CJUvqmqpBW/Kj/1pAmi+HgL
         m7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYuh1wRy0OXxhYLpZwN2vdo+Bf0JGlv9ikfhv9RcFZZrjldWdAhsQ2OHYF1Qa8isw2ksMtntK5+xUXRyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyee18l6rGGkw11sjJPBXbxeU7yntAQdD2g5ciofW7yocvsxPsW
	VV/Wx0uNFcafeK/8y6FugZBHvzv5vtYO0678WPzycxcZH1FOUrMvP9aYmjVThbAcSSBYRtIUT4h
	GempzIx5WlzCzCQ6WvSowpPI6de51UYKEXEVHaqoeSxyUrlZ3Uy4W3BoUBNJT7w==
X-Received: by 2002:a5d:424c:0:b0:37d:47f9:be8a with SMTP id ffacd0b85a97d-37d54e0b808mr8221819f8f.0.1728896772251;
        Mon, 14 Oct 2024 02:06:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmaiFzGAr2+K2rmr2gQwMt3POCAx28GuVYLjzk3R6/H+xl7EfaOtsr7q3eGv0V1GoD7XacMw==
X-Received: by 2002:a5d:424c:0:b0:37d:47f9:be8a with SMTP id ffacd0b85a97d-37d54e0b808mr8221783f8f.0.1728896771824;
        Mon, 14 Oct 2024 02:06:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd057sm10790092f8f.35.2024.10.14.02.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 02:06:11 -0700 (PDT)
Message-ID: <cfde8e06-0931-4a53-bae5-469219e77b49@redhat.com>
Date: Mon, 14 Oct 2024 11:06:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/panic: avoid reimplementing Iterator::find
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 =?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241012075312.16342-1-witcher@wiredspace.de>
 <CANiq72kG0Ai2DHfERD0aPDVuEpLYrZ_2uYdw17=eeHRp+2Q1Rg@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CANiq72kG0Ai2DHfERD0aPDVuEpLYrZ_2uYdw17=eeHRp+2Q1Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/2024 13:04, Miguel Ojeda wrote:
> Hi Thomas,
> 
> These commit logs are nicely explained -- thanks a lot for taking the
> time to write each!
> 
> A couple nits below.
> 
> On Sat, Oct 12, 2024 at 9:53 AM Thomas Böhler <witcher@wiredspace.de> wrote:
>>
>> implementing the same logic itself.
>> Clippy complains about this in the `manual_find` lint:
> 
> Typically commit messages use newlines between paragraphs.
> 
>> Reported-by: Miguel Ojeda <ojeda@kernel.org>
>> Closes: https://github.com/Rust-for-Linux/linux/issues/1123
> 
> Since each of these commits fixes part of the issue, I think these are
> meant to be `Link:`s instead of `Closes:`s according to the docs:
> 
>      https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> 
> In addition, these should probably have a `Fixes:` tag too -- I should
> have mentioned that in the issue, sorry.
> 
> Finally, as a suggestion for the future: for a series like this, it
> may make sense to have a small/quick cover letter saying something as
> simple as: "Clippy reports some issues in ... -- this series cleans
> them up.". Having a cover letter also allows you to give a title to
> the series.
> 

Hi Thomas,

If you want to send a v2, the easiest way is to download the mbox series 
from https://patchwork.freedesktop.org/series/139924/
and apply it with git am.

That way you will have my reviewed-by automatically added.

I can push this series through drm-misc-next if needed.

Best regards,

--

Jocelyn

> Thanks again!
> 
> Cheers,
> Miguel
> 


