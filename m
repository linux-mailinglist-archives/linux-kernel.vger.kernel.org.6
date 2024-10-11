Return-Path: <linux-kernel+bounces-361240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C03799A57E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E226B249A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDE6219494;
	Fri, 11 Oct 2024 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gOwlOsBI"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80FE215F78
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654827; cv=none; b=PvXUWQCr+mubaJlXCMFvYIWOQ4b5u4ywAhus+sEwxzXMPBU6xtBrEiJibAuLXfsBsLzD131DM+x5QmW58pABiJILH+0GWi4R/oEcbgSRUnjcfaOAgQxaKrr4GRvYHFWUHYFgPlPhBZnG2H6wpx/J6lYPKiM+T30xcOhrPsJRuq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654827; c=relaxed/simple;
	bh=24PH1AvQ2UstDLFxh+naoT2b+0RbZS/2ZhRUHBgA1F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dg1d2EGN2snsi4JnePtUvWaHyPX0Uq9PMf9fJ1ElnT7IAM0mYBIe5ZniFmeiUt+5c0Yy4E1aetF8MuDuzDaZYCwFGLqvb6PBUEhmVrGtiNAj4BS6LaRVDec9q+KvT/vms1wE6pqB8qSiuUtls356jC8xOqfBvz+NasKRSbaeBj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gOwlOsBI; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-835496c8cefso111414739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728654825; x=1729259625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IqLEhvqcyBsBrxJSzoEoaBYS5PEjWtm/RdX++xPA030=;
        b=gOwlOsBIAM9Ppq8bkOtGAJX+F5pWL4SzQvB/2i9ZfCGMDQNb3oTWI0CiCEszJ/5RY/
         VzRbKueijl4lWbpZdqnRd3EcWCTW55YcZePl+kYFlJNURF0qYgiFSIP8PHaVDdi7m6Hg
         T7ixqjc66oD1FNKIfUV7uVn4i9Kt2HKi44W+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728654825; x=1729259625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqLEhvqcyBsBrxJSzoEoaBYS5PEjWtm/RdX++xPA030=;
        b=nMCE/kolYbNt29Dz8lDSV9anfykyugWITFRcRjY0fEgDU3hYMvR6xUL9TR7exFmXzl
         JshdZMZYO/v+Th/Ozd5gMFr+Pr6rgjf2BB/rNt04w4O8ELbYxGkHqKCchHOsyy9ozxwH
         d2wytSDQ+BFreQUuZK2xlVU1gxqh/VLQPqHeTTztNqOwO+JNu1HIHHhe4Rr2GQX2b606
         SzwtqzcAFXMTktP1EN2PtxHQm1f5GI0/lvBBdOOZWbd7e+hGBGhPK+gC8EshoeBD/9mq
         7f+HLA5c9bWoh0QC4vrVXA55xpruni+y1aKO2EbICH5I+u3JJloFJQ+ntP/1PbdHCsIM
         6mRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI3mAd9CNgRvenALef68aUrew5MRbEU/N3JaGiUjMGm/NJWr+4pFSRlN2xwQXjwyT4BP73wR52sRVj+n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynHsdYnNBETES0GvuMybIqt3Drbie9ur0QMi5fZ9G5cSuSnyMv
	x7q80Efu1seV9eJWNEPZBqDewZrb21JKKb2Pr+tIxsQELRV0A4Relqj9nkaq9yI=
X-Google-Smtp-Source: AGHT+IH0ZjoMsHPp8mc/5RWu/qnSPZNLYI8+lebD2YEEDdEZg0xP0TMZzqA7mZLEnkv71J+Hf3vnWw==
X-Received: by 2002:a05:6602:6c19:b0:831:e9a8:ce2a with SMTP id ca18e2360f4ac-8379202d846mr206086939f.3.1728654824742;
        Fri, 11 Oct 2024 06:53:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbadada148sm647676173.158.2024.10.11.06.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 06:53:44 -0700 (PDT)
Message-ID: <e67664ac-dd20-40f3-9bee-0785d428ecce@linuxfoundation.org>
Date: Fri, 11 Oct 2024 07:53:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] KUnit test moves / renames
To: David Gow <davidgow@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Brendan Higgins <brendanhiggins@google.com>,
 Rae Moar <rmoar@google.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241011072509.3068328-2-davidgow@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241011072509.3068328-2-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/24 01:25, David Gow wrote:
> As discussed in [1], the KUnit test naming scheme has changed to avoid
> name conflicts (and tab-completion woes) with the files being tested.
> These renames and moves have caused a nasty set of merge conflicts, so
> this series collates and rebases them all to be applied via
> mm-nonmm-unstable alongside any lib/ changes[2].
> 
> Thanks to everyone whose patches appear here, and everyone who reviewed
> on the original series. I hope I didn't break them too much during the
> rebase!
> 
> Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [1]
> Link: https://lore.kernel.org/lkml/CABVgOSmbSzcGUi=E4piSojh3A4_0GjE0fAYbqKjtYGbE9beYRQ@mail.gmail.com/ [2]
> ---
> 
> Bruno Sobreira França (1):
>    lib/math: Add int_log test suite
> 
> Diego Vieira (1):
>    lib/tests/kfifo_kunit.c: add tests for the kfifo structure
> 
> Gabriela Bittencourt (2):
>    unicode: kunit: refactor selftest to kunit tests
>    unicode: kunit: change tests filename and path
> 
> Kees Cook (1):
>    lib: Move KUnit tests into tests/ subdirectory
> 
> Luis Felipe Hernandez (1):
>    lib: math: Move kunit tests into tests/ subdir


These look good to me. Thank you.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

