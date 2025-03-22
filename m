Return-Path: <linux-kernel+bounces-572467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF249A6CAA0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 15:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544751B65774
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BACF1FBEAC;
	Sat, 22 Mar 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OxBk3Ttf"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE793398A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654190; cv=none; b=UUfKgwoBxHpL04o1KIV54thKumGSAWMLsy8PWpkGfJQmYJ6jeb87DY1vuHiou2C/q+9Jk9BagkVrhyH+n1dMqUClcOInHJLAcgNzPbDZghZpO+p93w1S2N/UeqAguOvNcd7/3kp9KPkQgnsKm79NLdgxnA/QkhTVaLFXT9VedYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654190; c=relaxed/simple;
	bh=DLfj/EKdZnDxJ8SV2gD77VcUMwr9AOBjKqJfUMBekOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZvROqouWiMP/qKqjdwSXuJAH4BNKDOIyV3TtclOJ724v0VxRrvpOKGSglDBUstOymum7jGkb3hefRLiypigCKo1fy6uMgtC6Fvy41nQxKGr+KDcI16S0yBOD16/02sHeEGTe57ET8H1TlwC0uqYiEovhACmt69xeoGe4X1o1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OxBk3Ttf; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d45875d440so14868415ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742654187; x=1743258987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAy3xIM4NCrJgDIQw91YRtLIyAoQ89z8OZE//Lie9+M=;
        b=OxBk3TtfPe6Iic+VmwEnMfIOXiPcl31ce/faHyVx/w5LjuA64mhXQUSZZUw8kqQLyN
         dIDFZyPlbt3NY3vDq4lXw72NkZbfj28AP79hqy4hfk1kQ/Yj6EXCaUMHYlXLsAf59Q+j
         Mg6ilP9/tQF1Fu6wrHFngfuAvse5j/PboXNnvM2g6DN2F9KyS7VQaCoGDJr2sfWmYmEa
         oOf9y5+dh616i+LBtwpm7y1+7B2+RRe2MpncELKMHpWXuY3lLg22kuivaBtz9y0tu9Kb
         zBvjq5xPrzFZFCGwrDorflAm38o3ssZ/FBd/tNIEeM243bi3o/Np4jW6eBYENRLqElfL
         n/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742654187; x=1743258987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAy3xIM4NCrJgDIQw91YRtLIyAoQ89z8OZE//Lie9+M=;
        b=Yze1DU4yCAp1EBovZsrPgOB4s2mOeoxZ4usRcmPWG1MKWS0UM76wHSQdKXHvq2IGCU
         hmdIYBXLRef+QN4nnqn2fZeEm50Ng0yXEn1EHVf9E9Muy+gRpsg1GOgYJMSfRH15ybBJ
         knHfbfJ7L9DzQrhcQ7UIO+t5IvuoW0U9mqc6B+ivMhAIkEUUzmGXXjT9WgWbF+1NmNE/
         gncOgi8YI7dD4oM5U/vEDFHTATrwtnyY7ieGpgWgReP7zcjNEpj8oyrbsawfkrHSkqDR
         ax3OwHBcTA4IOd8zN++7vsCoOlktORmuQ8DVpuOEUphhbzHXEvzrt5+xiduh7Da4xOaN
         /8Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWLi5N3iEhkvwo1j0S1nBUay3HCb5Efm1SD7S7JK7dgTwPC4Uq7fKeZYJTi2lEzYBg4vin5OQBSVPtqqY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLeelEtBcGiMXY13/E4Hz/r1QA4bhmieP7atJVx08l8MjOlgga
	K5LMNFX4AJ3P/7LcFKPpqVZ1P3vRx/ocdzyZIUdouzTHX4PDAMyuGR4dngwKArQ=
X-Gm-Gg: ASbGncvoIdPcsHoj2J50xqiH2enKqFVyMtUDmBwCr4bmBVyVNLrPCmOIGaAm60M5TkS
	ezs07pYp8cfRHx7+lkN1vr3wvD/izBQO5qEjACKrEtfe6rDh4ntxFxCXMcPZXnrt7PdGPo5Eyeo
	lCtEJCnrYAEh3+m3vqzuSNFguJZ67i1F7oZgY177zgV1XP62m680LuP7J0UGTCsV7EWhaG0EfdA
	WNwhGppkoFAFKZzjEzsKEG8ZP5o3OXD4P4DdsIRHffw3wEzKW6TJar47Ua//roInY4MZ4iEpvVv
	g9moxqav/cRCUwOUeDBoXi5Wto+5bx03Y/98K0DqJg==
X-Google-Smtp-Source: AGHT+IHj++8zMvAmO1TA7Oum2ETs1AoNfXAhaL8efjlxkZ38OAysWAUUz+CRqIEh0qJvSHCMQdX6Fg==
X-Received: by 2002:a05:6e02:32c1:b0:3d4:3ac3:4ca3 with SMTP id e9e14a558f8ab-3d596118578mr83702095ab.12.1742654187376;
        Sat, 22 Mar 2025 07:36:27 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbe82f7fsm923267173.83.2025.03.22.07.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 07:36:26 -0700 (PDT)
Message-ID: <1083f491-2da2-4ba3-b85b-53a057af0e65@kernel.dk>
Date: Sat, 22 Mar 2025 08:36:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 0/3] iov: Optimise user copies
To: David Laight <david.laight.linux@gmail.com>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
References: <20250321224557.3847-1-david.laight.linux@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250321224557.3847-1-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/25 4:45 PM, David Laight wrote:
> The speculation barrier in access_ok() is expensive.
> 
> The first patch removes the initial checks when reading the iovec[].
> The checks are repeated before the actual copy.
> 
> The second patch uses 'user address masking' if supported.
> 
> The third removes a lot of code for single entry iovec[].

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


