Return-Path: <linux-kernel+bounces-355304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B91899504A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03281282833
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07A41DF25E;
	Tue,  8 Oct 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="dt6ISIb4"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2B17C7C9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394703; cv=none; b=qF+9ENzMTobQ+cU0iLDYV1vepw6ytVzgV9+404ZMP+G15vogGWmhGlT4obgUD7CLLWFGhaxsWrqlfL3bH17Fs8hW4vU7Yy0zg2mK9dl6mXMWdcKq2RzrcwNXzTZQWMrIfSkvk2f+67TP3ecS9QkpCBqi4jwNf81JWlEeXYJagdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394703; c=relaxed/simple;
	bh=O/DJF8QaFTVt8ng7A9lDHnkL43TRC4kbjBua/S78vHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9wGR7ztqkPJVErDuv3OU0gII2PeSsIDgnS7S9e7iyfYimRnFOf9mid9UdqBFPUIEFXdovpN+bCdofHqF2B+22cYUJRu+PWReGOe2eTnX/sjgjXE/8bNs90b+7j6teAJw1W41E01p7DmxKhhq1pJo7/mEeHCyLn2ra+kDf+pnKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=dt6ISIb4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b3e1so7898566a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1728394700; x=1728999500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hyIsEzvAC9kso3P/ACx6wqdWFmj5EAjywZd8U076dbA=;
        b=dt6ISIb4DEmjxCSAskDfVBa9j2t1KVB7TKKni7de8p4QHGFyycHxRhIm4/E9pgVqyi
         i8wUoZIMn9ZXAWFFh00ZLqj9AaHwI5B+Mp4ceI1uiIlOgBguddw0nlbQXHtJWcdrAGz/
         aZBf4Wq0Ea0jeUIZZ3SPhQfLxMEKaNOR/yORU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394700; x=1728999500;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyIsEzvAC9kso3P/ACx6wqdWFmj5EAjywZd8U076dbA=;
        b=gla2t4soat0dmzWZeVG++WIbtjuiRPG4llDaoCtklvP8i7Pfa9sZ19tMzAxGCffRFX
         1ffUhlUwl1EE9xq7x3P9B5bkt9afZ5kB6Dwqyq539NgB+6mFp3lg9w2Q37ujJXluhfaG
         la2RPgPbzp8EhZKp1HVSY381MYl88jw5A3+8/l5e5MqatQ548eR34+iL7TYXynZ0TJUd
         ZeHNLR2wSR324r7wUNCiM6dxIfu6Kxdh2HBMi5tSjRUvEjevkgzabsZ+IqVq7OSUbGw8
         HT5DrWTAQkUnMWSrgjR4h5uXHJN/DD9N8m6w+tnEmZdYcPTy/tKZfgghO3Q5id9SHm8b
         ffug==
X-Forwarded-Encrypted: i=1; AJvYcCV35Cufn8MgZdOhori/XsuM1H2Q7HGJCRUocfSrQ4BbDZi7HI2wSyWQy4ToMuFZaZGLX1zH7o5kNms7958=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYkDqFBqVSjFFKu0d9yh5Ea5HUngjEZaueYbFvCoWnbcZ2ebU
	Z8k15I1rsGCr5uAzGmtS/gWLn9t7AKR0x/wFwcgEITzz695vctWbkQTrrblctis=
X-Google-Smtp-Source: AGHT+IEockzVU6BUbof0Fs4SGjLra1/kt+jbE65dg0BuJS51grI0CQ1crqmv5zVGFbn3+RX8ka53mg==
X-Received: by 2002:a17:906:c10e:b0:a99:76a9:a9b3 with SMTP id a640c23a62f3a-a9976a9abb7mr213683666b.14.1728394699809;
        Tue, 08 Oct 2024 06:38:19 -0700 (PDT)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e5d0a3dsm508027066b.24.2024.10.08.06.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 06:38:19 -0700 (PDT)
Message-ID: <55f755e9-2712-47d5-82d5-d6e685969461@citrix.com>
Date: Tue, 8 Oct 2024 14:38:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] x86-cpuid-db: Release v2.0
To: "Ahmed S. Darwish" <darwi@linutronix.de>, x86-cpuid@lists.linux.dev,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Sohil Mehta
 <sohil.mehta@intel.com>, John Ogness <john.ogness@linutronix.de>,
 linux-kernel@vger.kernel.org
References: <ZwU0HtmCTj2rF2T8@lx-t490>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <ZwU0HtmCTj2rF2T8@lx-t490>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/10/2024 2:31 pm, Ahmed S. Darwish wrote:
> to:
>
>     /*
>      * Leaf 0x0
>      * Maximum standard leaf number + CPU vendor string
>      */
>
>     struct leaf_0x0_0 {
>         ...;
>     };
>
>     /*
>      * Leaf 0x7
>      * Extended CPU features enumeration
>      */
>
>     struct leaf_0x7_0 {
>         ...;
>     };
>
>     struct leaf_0x7_1 {
>         ...;
>     };
>
> Overall, this removes ambiguity for IDs like 0x16, and improves kernel
> code greppability (x86 PQ pending).

So what does leaf 0xd with 62 subleaves look like.  Do we really have
one number in hex, and one in decimal?

~Andrew

