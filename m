Return-Path: <linux-kernel+bounces-545522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91EDA4EE24
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F6F188FD2A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9E259CB9;
	Tue,  4 Mar 2025 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MvtoyzeX"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BD923F383
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119254; cv=none; b=AGqKqr0SCWbqvLABy2JqU12NWKvcVLwODKQ06r7Fc8/WNlTvmJRoVIIpYTOBT5Z7rWwAAS/4jy86uJywjIgK64jMnMrBMU+QAJ14aIRR6t3jfmjhIfcN42IuVD0L0Wp9VBhuxMHdty/BXyDx/pBW+Y1Mir3+3HDXJ36E0nyeWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119254; c=relaxed/simple;
	bh=otZ2YUUK1H6x0azyQmfRakGXbj0W/8MjqeBHgun7gY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELaxtQ6aP6V3e63ahrRc0Q7Zwjx995xtNQRtCPQRWl9jN2QbYCOZQ9KDjKcYfksJ0rUZX9m36AOo+jqq9UWqbUVARnaJRqeptlXJU/zUosTRzhsWM1RRQe5e1ITeEIOzYyFh6mV0sfTMHo22tp83E6jY0XPSx64kO55o1LOyHfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MvtoyzeX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e4cbade42aso276661a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741119251; x=1741724051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=49GpfsO5lTCFXPhObY2qREqYNSVKDxhxnjEh7DtFdqw=;
        b=MvtoyzeXXao3t91qZotjl5CMCWr5MODEPhl1bMbrKNNZ7J+qn8MzvSvJKwOOwkSuCv
         0r+IM8d59Q3pokhgP5kzYFMInd/LYqWo7kUMe/v/67OfJbFclGl1MQhZemnpMjHVCEP5
         PHg5zswqBtPZAFJghP6uKqq8otijmuJMhrzqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741119251; x=1741724051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49GpfsO5lTCFXPhObY2qREqYNSVKDxhxnjEh7DtFdqw=;
        b=lrixsGsJz2NAAl/eDrS7MgGp7lCC3e5CvuvtSdREsdluqdj5myJQPSXOQ7D+V4NjCS
         neJQPXo9XsWC0HnMXF714dvuWc4fLalqfKlwhoXBtVkrFfoXJzyA4K7NZLT6UWbbMV+J
         rzA04QnFJnARFa1L6quOeEuIbvnYmod4aOL6yiYvcr+Fr340ghV1yx2EoglKF+EOwXIn
         Gm4AnlOWRPNB2SjNg9jztiXBSj9K/rLil4tsgp1uB6BM3cXj4JvuCPcTNKurQprNtt0M
         kdyOVpW3WXIqKUPPqLO6WZNUekPVK62q4GkcKJRG/itA4NxhoVJARDeT9IZwvzIys9TM
         yrPA==
X-Forwarded-Encrypted: i=1; AJvYcCWq8OP8/5S8XPgQoCq9qxBaMJGXzsevlR3nUKn9vHCaw5owe7N92zFauiUMXnPqDsAiaJoVLP6/DfZdQMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZbP6s2oz+Sx2O9lszaUtOb/d3x7RwMIJ1XbGCb24StA65D0AN
	SV1FDYaO4hWT3whGYwtdMfxNpMs3BJdH3grozTeIPljql4g4GFR5r7NUBXdZYuTb4pKZNm+0QLk
	RTVnb/g==
X-Gm-Gg: ASbGncsR9fhcHZ9nV6ZQp5si8hhHLl9h2/6OOf6rLyf3ms2fIj6DdeD8iReigoE8k7N
	oOF/PIHy8nMimf/UeMsyJ6nGq0BF7+MJd9HkLmQzI0t1LE6vWGB2lbggs/BLT1mEn8Ka/zV0ftw
	RIlJ8GZJVl1puMCO//pXGvQPBpLAD1p7u1CaClm12AGcTpJCQuvxKsiFbmckHKDoLq/JCDL7LNJ
	XU9pVdq00ThHPyB9xZZmebyz5RwPpeVzUV5juQPpQxA9p2LKmQX92XVwYSuHgJHGK29JaqswJYI
	SoChPa0cAwXeUOp8kz44Wq3DkEyE7UPzcfl8DSopmcEASgEtTOVv2tAsDr/iPmpQweFmlgyouet
	q07J4QmPGdBxmqhzQZ/A=
X-Google-Smtp-Source: AGHT+IFuIY+poXSyiw1KtFk6WlReZSwUEqIIHlb56M3gZMLM4ycxUZmQ9ucwt8jyE+BBgq6ryLKg3Q==
X-Received: by 2002:a05:6402:51c9:b0:5db:68bd:ab78 with SMTP id 4fb4d7f45d1cf-5e59f191b7cmr431900a12.10.1741119250891;
        Tue, 04 Mar 2025 12:14:10 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm8515223a12.50.2025.03.04.12.14.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 12:14:09 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf4cebb04dso29998266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:14:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJBAHYyOY7XfUhjUb8GhwKlZGvzsK71hEXNTZHF3Df4uPzz0Uo09E/TdF4M96EXTWzjDFsQCDLx0fqy2w=@vger.kernel.org
X-Received: by 2002:a17:907:2ce1:b0:ac2:3a1:5a81 with SMTP id
 a640c23a62f3a-ac20f006701mr47671266b.26.1741119247978; Tue, 04 Mar 2025
 12:14:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com> <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
 <20250304182132.fcn62i4ry5ndli7l@jpoimboe> <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
 <CAHk-=whqPZjtH6VwLT3vL5-b3ONL2F83yEzxMMco+uFXe8CdKg@mail.gmail.com> <20250304195625.qcxvtv63fqqk6fx4@jpoimboe>
In-Reply-To: <20250304195625.qcxvtv63fqqk6fx4@jpoimboe>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 10:13:50 -1000
X-Gmail-Original-Message-ID: <CAHk-=wizdAA_d1yHZQGHoJs2fqywPiT=NJT2wNA0xybV+GVefw@mail.gmail.com>
X-Gm-Features: AQ5f1JoKZIHGqjuCfBykdkEPbT5nD_o-lICTkuKmDUSpS0YyL9JFBzQs2Wrtl3Y
Message-ID: <CAHk-=wizdAA_d1yHZQGHoJs2fqywPiT=NJT2wNA0xybV+GVefw@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 09:56, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> While that may be theoretically true, the reality is that it produces
> better code for Clang.

Does clang even need it? Last we did any changes for clang, it wasn't
because clang needed the marker at all, it was because clang was
unhappy with the stack pointer register define being local.

                Linus

