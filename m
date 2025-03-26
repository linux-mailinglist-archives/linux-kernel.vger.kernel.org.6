Return-Path: <linux-kernel+bounces-577664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FCDA72003
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4753B89CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C3C2566DB;
	Wed, 26 Mar 2025 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia27e4p9"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ECD1A5B96;
	Wed, 26 Mar 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020718; cv=none; b=rvTReBX+AWyvPvl1/wJwj9TjJOElbGVZmZ1cNHB4MS7qd/7vKH1T1bO7odNZJ353HDFkDihgx7YJGsNPdYlnv6KRD6SZEM1sjdkVDk6/QxKYKf88qsrWYiU/s13/Gt/M0ZhtEaR9Pmr5g42PhNOn4RT95v5469sSJ1V1F1L3FhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020718; c=relaxed/simple;
	bh=tPVRUhMWVkJ9PxP6Ur4tVUym6qpBliVYGzde6Kl4v1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GissViOEmrYyK/89InT3ElVHyMuEqJBhjXQZ1CyngiXd76Tt5tq1ANHywXQ3c+T2OVCyjN5rDD4JNSG7fBCf6KZ9cqXlSwnsx+U+4xKmquTzIL1YTrf+MaQchtXMio5AAA5i6QfpRCM3HvOYYbODhe0bG3fOsSVM4rRU5ZzHTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia27e4p9; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30db1bc464dso2882131fa.0;
        Wed, 26 Mar 2025 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743020715; x=1743625515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0fdi3IrtkqEcFmhvSbSZiTssjNUGS4pwIMBoAoOEqo=;
        b=Ia27e4p9jlpQeYEhI3C1X6MkmGRRJcXnGhVeoCqLbKeQsTqM1IGFovq2nU5EVlfLM8
         Ynkkz6Mhh6mATAL62QaXRf2X+lUppC+G9aV/KRvChPMvHss2rb7pOWUQdWsPNo5UPctM
         eG0W/M1SNf8EQlKA8LXd+eNZFp4L+WIvsySlIgB3yaFNDg5NmHYdQkbp5g+tzWW7nwN5
         a8WFn8Xk/iIUhqE0YusC4tEprPeQVmFsDOt3FT+WA8mDTEIXVoOW/pwdQlaWe2n7faTD
         /WQQ4h52432nIwSuws44iBcJ9dDzkBKc8DkKJpL1Z1/pymCKQr32pSvm/Y9NWnHrYrES
         YibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743020715; x=1743625515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0fdi3IrtkqEcFmhvSbSZiTssjNUGS4pwIMBoAoOEqo=;
        b=R0JBTvxvVd2zloSzaVxQw2eCD5jpa2FLck0k4C/yeMOHn0xpWCUyn6COoK7UBaq0Xp
         zzFpRzObm395ojsf9VpFCofD1fU5CMlRXKpt58Roorhjdqa2uu8TnmXxH+oczXy3SQ9m
         qqy7aVIvJ/0h44ZZo1GW8qpGHHjjD+Hbk/LJ+o95metdp86mq5yjersY0zYtMpW7aOvJ
         /OsxiKfH5YczpLx5ZfZTopkmNYGhl5c0nnWTJF0WXyaQoTu1iwCrYfgp+ZZxWFf4+m+l
         P/PsVDqlDBzlytO+sLcWKXVL6RsWyNZ35dQKFZHiRECQGUUZxbefJm4ZRO/lkvTVUgqC
         EwYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+nnFDzgmxylLw0yAzaToK1V7/7QByI+d+AhjaNYh+jcjMMFrBMW+Vinc1xSjy3Xv7AmiPMlXbMT+ng+JZrEo=@vger.kernel.org, AJvYcCVaBrtjXgkhOLflE9c5bZG26LOFLlUdgM04sDpclUToRjmhSr55N5EK6mHOEpCPJftCH6N7n+w043S6qXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqAtkrXiCxoNdaxtVPP076leIzvflrfswkJutXkJqrCQpirAg3
	fM7Am2DJzGRnkFpG4w7QEMeWUt5lTo7USMUELR0r3g3CK5nN3lGU
X-Gm-Gg: ASbGncvL+TcNEvHa4cfyMg6xvIkFBdUOHOzIRRSL87MIrX8wYYSrVhx14b/TZG1GGOi
	/wAdTLO8SZYGKc6gfLL7c6tlkjXph+ndeZa46SoJG1jqwnZW1ZguASvjyIxwwuBFqzBKDGSZ5oY
	Ng1+xnVJhnkwbkyZK7vAbC4YYxDz9xV7kXsArIl/oDt4SAzsb58p2l7NLUy1/oDNSjgzDPfySry
	tnV/yul8j8qVp9KRTA6a6pFycJAfSHpgRBw6Rt9QUPxAcR59v0yBsI1P0Cn/ksgwGV8tE+EqEfm
	Z0yyeSvLFlsPgUBPUHrA+5nFVLpoOsR074JJdr8mqU7bEfswkA5Y9DtPasYMyUzTNwZ3h/qAPIb
	0Y1d/NqqgV/woOs8aMJD1nUGRyEnrtnmq
X-Google-Smtp-Source: AGHT+IFdOlY6bZJtugWwu4+7VhGr8RibxS/MBz2jzdvvu1DKGb190DlRGml6NCw91lHqsWPMebtLEQ==
X-Received: by 2002:a2e:a99a:0:b0:30b:c96a:775 with SMTP id 38308e7fff4ca-30dc5dce21emr5104141fa.14.1743020714870;
        Wed, 26 Mar 2025 13:25:14 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d8f398asm22753641fa.72.2025.03.26.13.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 13:25:13 -0700 (PDT)
Message-ID: <fdc54cf6-5574-4061-a90e-81bd9e2f2be1@gmail.com>
Date: Wed, 26 Mar 2025 22:25:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Additional fixes for dma coherent allocator
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: a.hindborg@kernel.org, ojeda@kernel.org,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 "open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]"
 <rust-for-linux@vger.kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
 <CANiq72n6X5gV2rGB=TEw0jPdiw7mT79bdEOXHP30j=mRk92_NQ@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CANiq72n6X5gV2rGB=TEw0jPdiw7mT79bdEOXHP30j=mRk92_NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Miguel,

On 26/03/2025 22:18, Miguel Ojeda wrote:
> On Wed, Mar 26, 2025 at 9:13 PM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>>
>> Additional fixups to improve the documentation and make the read/write
>> macros return Result as suggested by Andreas Hindborg as well as support
>> for reading and writing large blocks of data.
> 
> As far as I can tell, these seem improvements more than fixes -- so
> can they go through the normal process for the next cycle?
> 
Sure! I'm totally fine with it.

Regards,
Abdiel

