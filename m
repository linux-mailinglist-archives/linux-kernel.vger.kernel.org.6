Return-Path: <linux-kernel+bounces-347487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C543698D352
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5961C20C8F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5866A1CFED0;
	Wed,  2 Oct 2024 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfykZejP"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA54194A73;
	Wed,  2 Oct 2024 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872312; cv=none; b=uIM+pxvs6GqFV+Dz1K1V23S++6aYhiAgtuElOgcX4q6LPqQpOup/NL3Ztv8AhpH1qb/gz8aoxsdAi32RcfhSTeWsVqWUWxLOBaSbmXZSRY/gqJV84AudUBWUCQOblzlSoVm0f8MIZt3o+h4gDgG1dMrA3oZ1/7SrNIo+q/Ue0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872312; c=relaxed/simple;
	bh=0QpmFL8c2POpI5zdvk8ZfpecN6SLdNmWf8JIT34B2oE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UVtt180hDZdwAEP0TObPXfqoWYeCJc6HNY27rLS9eAAD1Ajii+gohNuOmpYoY+8fALFkb/pMe6cTWAvusOYQGRNnsS2HE1LZWMmL9yRmwScZks7NguKEPy+iPCU1aq+tondC81FnfZad63j0zQ8s2aoCMZxuOE61Z0X/4gaEI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfykZejP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b93887decso27654455ad.3;
        Wed, 02 Oct 2024 05:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727872311; x=1728477111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QpmFL8c2POpI5zdvk8ZfpecN6SLdNmWf8JIT34B2oE=;
        b=PfykZejPTEkN4cPNtTFLGxlzdb2g35xN4DTGegfHVDxIdR+FSM+YsRDK4VX/enHSTA
         81YL8VQQ5IXIkVjuhNbemopyWiHr1/ckXv/05iPzF0jMGPpVlFI4mEtrVa59lH0G6OFP
         On/tjHZgcH2UqU+o6NaoQyV3YtIh9uK8K7mh01mTb9EPK0UyOQB5t7NlT1AcoPC3qlaf
         wU05/siEP7u42r851nzmTOOU7kZ1X8iYGryvlBgxTzlgS8SWCNCKDZRyx4mfATHg0Jw+
         9PbbRgUX40UEnmJVjfl8HNp+n/+yChtXUnEnaQJomd6/LWewXjbP1SmdqDP651Wy1rhC
         wO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727872311; x=1728477111;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0QpmFL8c2POpI5zdvk8ZfpecN6SLdNmWf8JIT34B2oE=;
        b=Poyc9mz9lix6P6kFGKn1B2XF1nVvYXP1C/QATzqZA25/8UAf+OskmCbYR0HsvLlpfZ
         +4pt/vNRK7t+Vit1+fuYwOqT/Z2WamQxARIrBRd5TvBKCI6q/JjDMtjGxFI8LeNr2T1N
         mLdRPZBEZHfOo7M/Eu8aZyQOV0avSwm+TOKf5XGbTPVGsaXzv47r8YQJQwEiWSXKO1EP
         oApU8SAvz+nGRvjykNlfH7hEtaNOI1EdpV0julKOQ9lS1KbOVYUWA9aDsbc0yvlIusKE
         Ws3I4m1OAcdZvc+1WY0aRA5YFeR4xy6PM3reszqs1RkHScifgL9kndYNMygKhKPRgfyc
         d5Og==
X-Forwarded-Encrypted: i=1; AJvYcCVhIT7kFhrMOwwo2jz6EHBcHsuLLe/ECS+UuhJgyn8sEOzZtuIKb2a2+4TmbH5HQw5mKrW81VZWyNrT+qM=@vger.kernel.org, AJvYcCWUFLJ2iHtkAEwPe0+WnSn/nOxQ5ynoBz1di/H3K+a9jTiMcf3hlQAi5GUCfQZnMYoyUoYkgmWtEua/XVwwETI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5jVermsdFMds8h9aLnWOwFXr/6L/+VlCL6Pqgb9LwxT3UYig1
	HSuCIuCjTTLSRk93fm2crvYOmgCTsg1HWBSf7a6MjpOCkH0+wfbz
X-Google-Smtp-Source: AGHT+IFuFfakisfvFTluNUVhCSm27HxT9PsUdm1fFTdu5haxn6wec4Y9tB/5+RhMwpurf19t0L9nGg==
X-Received: by 2002:a17:903:1105:b0:20b:a576:1896 with SMTP id d9443c01a7336-20bc5a5dc02mr41922635ad.43.1727872310664;
        Wed, 02 Oct 2024 05:31:50 -0700 (PDT)
Received: from [127.0.0.1] ([106.200.85.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e357absm82741495ad.190.2024.10.02.05.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 05:31:50 -0700 (PDT)
Date: Wed, 2 Oct 2024 18:01:32 +0530 (GMT+05:30)
From: Hridesh Mg <hridesh699@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Patrick Miller <paddymills@proton.me>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Message-ID: <53f86af2-45b3-4bb8-b5de-54e3c6c70750@gmail.com>
In-Reply-To: <CANiq72kEPEcqqJmLEtT7=Ku5mseHe6Js_jptVQHMzRwfUzFtMQ@mail.gmail.com>
References: <20241002022749.390836-1-paddymills@proton.me> <20241002022749.390836-2-paddymills@proton.me> <CANiq72kEPEcqqJmLEtT7=Ku5mseHe6Js_jptVQHMzRwfUzFtMQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] checkpatch: warn on known non-plural rust doc
 headers and empty doc comments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <53f86af2-45b3-4bb8-b5de-54e3c6c70750@gmail.com>

02-Oct-2024 5:26:15 pm Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>:
> I would also include Hridesh's cleanup here too if we are doing
> everything here. Something like:
>
> #1: clean A
> #2: add check for A
> #3: clean B
> #4: add check for B

In this case, I suppose it makes more sense to use the From: tag to signify ownership than Co-developed-by since the latter is used when multiple people work on the same patch according to https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

