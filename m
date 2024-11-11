Return-Path: <linux-kernel+bounces-404269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 678019C41AD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03628B223BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C815413B5B3;
	Mon, 11 Nov 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GxOMQhbz"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16EF25777
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338250; cv=none; b=nkyIZw2SdtbxXL5nz4NNoSlmUZK/Fk3IiRUxSaarJ7pTWh4ZH+47XV9KuL2aZRUJ/iDVyFabWDlIVv1r8pITJXD1/VkTIeSbtnAepldQ7WRXXTXrd+/mDy4Omz8eNMywmlCTyH3oN7Lehyw4SElROhCj4/2Af9xZXU91r0esNu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338250; c=relaxed/simple;
	bh=Daf0mYXlmf4T1ev49fvkiEgHmfaRXVSpW0/1qYp/j3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1CYL5h+4kdwFMWSaRRKo3pYL9LrvQ00iRlz3NTmgTBw6/fPbmlXFKawukuYGylZKo93NhF7xwTYKs4A329AAeQUTQMirjEvh3o+6NU6dPGsg/JPbN5uT5PPe6OujRu3e1MdWUmLzBnEyxuTwEKXa3Xq3gTReJCe7r/Nm+Wv8IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GxOMQhbz; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2958f5387d2so822952fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731338248; x=1731943048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tiYSaZ7j3e2lyxuartFGx7bNhNoe94NxeTusFO5AVec=;
        b=GxOMQhbzc/Hn8o780QeMjdPe8jJlZMYbxry4FG1bqHPhnS19Bf6kStxDHUtlUeT+ds
         Mbz4+jkQz7DQ/9D9JuTPQ0Cqz9LONs8DBFI/Ucw10p2u5N2z3b0kDdqK68YjxuYnNhxd
         23W+bo7ydPbgCWx20DPp6GG0Dc76V2O3DnKM2NWHm983G1w3N8fDg+Ij1OqEE0ibKLdL
         DsxTnFHyTTcm3lOj4a71KhnCTfaRcdRKIS0f4DeXpBZGmqBKrQyUlW1ok/jBWeXQit9B
         Wk+c7Ajex3/ihdvJaYTUOC80MokOxO4eIds6ir4emTMPa/47wVMOqAqyYP6+8+PS9AxQ
         gMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731338248; x=1731943048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiYSaZ7j3e2lyxuartFGx7bNhNoe94NxeTusFO5AVec=;
        b=TADD4C21MtthjYTdPwbLyEcjiCkh6WSXkxgCyLHlu9lT5zYEUNTYDMYEERCeHQu+qh
         d4uoVO65XBUp9Zymz0FL7E4HRQJQdSGNx8GjPg/+8r75JbFhe+Nnv3eVZCuJgzl+//XU
         1q58vYQmPyT5/gZR3T1IadMyK0HYkQCpeZB3x/m/zTWqDxGf6KLl+LQLKXEPA/TmgCC4
         ELv0mGF58BAvX6n4FfiIo/EZe5+ZzZTlWjh+W/EjBGdDmzhnpDcp/N4EryOIFvgbhDd+
         GA83oEbnySEMq6N/Qr4gw8MKukAtgDgsLaLxX+mXrVjMyVIW+goft8+U7tRPjTZzcLWC
         /jtA==
X-Forwarded-Encrypted: i=1; AJvYcCXNmfv70CzRdeGa0oDrneLuN3Wy6e5iR0aXo63mo3D+uhJy2oIw+1QxN0KcF9acnCZh4bBBT6cIxRcQL40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHB2lGvKEjc3lGxq9iRu3aStVyQyMleMSG622rnydg4+e0ZKQ9
	sXyhMuhdLTFoSjKQYPbX5lznoOriLvAstd1AU119mTw+xA0bIjQUohi3D6PeBF4=
X-Google-Smtp-Source: AGHT+IEL3MeJjAp4TyqgVqF+Yja3YT8p1GLxY+9WdEndAdiJxZ9fOcJlhwsAZ8uUlUYPCEPr2AXPsw==
X-Received: by 2002:a05:6871:8796:b0:278:c6bf:fd34 with SMTP id 586e51a60fabf-295602d3130mr13239115fac.27.1731338247894;
        Mon, 11 Nov 2024 07:17:27 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546eddc9csm2826521fac.36.2024.11.11.07.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 07:17:27 -0800 (PST)
Message-ID: <04fd04b3-c19e-4192-b386-0487ab090417@kernel.dk>
Date: Mon, 11 Nov 2024 08:17:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
To: Christoph Hellwig <hch@infradead.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
 linux-kernel@vger.kernel.org, willy@infradead.org
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-9-axboe@kernel.dk>
 <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
 <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
 <ZzIfwmGkbHwaSMIn@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzIfwmGkbHwaSMIn@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 8:16 AM, Christoph Hellwig wrote:
> On Mon, Nov 11, 2024 at 07:12:35AM -0700, Jens Axboe wrote:
>> Ok thanks, let me take a look at that and create a test case that
>> exercises that explicitly.
> 
> Please add RWF_UNCACHED to fsstress.c in xfstests also.  That is our
> exerciser for concurrent issuing of different I/O types to hit these
> kinds of corner cases.

Sure, can do.

-- 
Jens Axboe


