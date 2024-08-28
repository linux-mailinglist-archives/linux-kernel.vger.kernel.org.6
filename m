Return-Path: <linux-kernel+bounces-305758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D4A9633E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A83B22921
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3981AC45C;
	Wed, 28 Aug 2024 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og6hg+9T"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5915C122
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880722; cv=none; b=Zc5fjVVdv9wrBv8hy//rALcvg2fkWyzeSpr6Yyswmoc9dcM7ewi/A2u8WSByl9VaWAz7V7qvyZpb6Aj8v87Jq45tu6mv+nRlAANqamGKmxQ5GE70raJW8EfW7Lhg/r5DwQXziOI9U8Jiw3F2oBURRWbe9G79X0OSx6CuZTfD1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880722; c=relaxed/simple;
	bh=H4R9g6Iobfj4JMDyL6DwUQKuQNgFMCfVlAO9tUYyKNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lDfVlSxk3v+/nwWheBBgoq2HuxgsO9XHuDfIdZLktaLIW1T5LNFR+XL2sHQU23VQnoJ+6p8Tmd5ebi493BWXV7dZZ/9i0p768lAMjMsffRR+AFSEsRThaVVBRd04AlRocdyDi1VpDH2fJOdJ8vYHTdmuv3s7OZbptvlsgp7F0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og6hg+9T; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso5552771a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724880720; x=1725485520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nx9DjwCsGCZUKpWJ/hQpc5jk2i3rFky4eqc82yPK8nw=;
        b=Og6hg+9TzF2e+MA4gVCibGMMfsROhaJ06lCktJZD4igJfzczzkjdppNvOwxLX2Xxhj
         ux3N3vZ4J0cbdZ6fWnXC9z73PIudrfzSxBOGoe8sJo86MKSgqf2BOoTnqEtB30FLDiuz
         i6J63LjhsU1TVJik0AIxzoQr5YziG5JmVwvuTLQxDqNBwjrbX2zatCBwk3d/oe3yKrLN
         Zlk+/hxPZZh8KHYNu4OfZbY4cm/ri01LpMZL38WQYLY7GjpPxIbbig2G9NJtiQDVoAUF
         Gsa/RwzQUMMDyGnUQZwHExvO89eUHQG2AoHneiy63j/J7DrCMkgxtySNxbyUH8qs90AA
         b+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724880720; x=1725485520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nx9DjwCsGCZUKpWJ/hQpc5jk2i3rFky4eqc82yPK8nw=;
        b=fme+BNs2Xj0zfPgi89BPn6LOulbqSOwLq0E+pAtUn3R/tHE2ClmBPHDrUrV/8AAoKw
         50OY+IBWuTT0iakas6ZQcQHIQVyqizGlnYvPxSmGQ6kGbXDPoOYnH0WW0ZX6bAS+PX3d
         SWUFBB2zDteh6yKEj7aHYMvnNbPT5+isP0yZhQBd9QMad0fWFIoxOQK8TyQRefw6kF9+
         PRNqyjbtZ9d6Z0WhNlPVA7Bs1YfkWOBgHOrPhZtqPGTTy9dos6HxdncfcyPYgsiLLD6J
         dM2q3PwFjKBccbZXUSutMdGOzS17Tdm/vXJzFhzmp3b4NQdVGm7/ylk+upLI5Inwrco4
         G2sg==
X-Forwarded-Encrypted: i=1; AJvYcCXGuWJbaklzXj47auvtlB7C+4eX2yccWWk8gx3qqkjD6Q7YkprEACZYl5q6C/LNGgxp1khPMBZ5BAsIziQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCTu9BKjTECUT1u0QbtuE8MWfPf17oPxjzPCRbzPjH9FreKNma
	BBdGyN6LdXivlNBiPnnvuuzqDovIK5dnkzqJoKjgtI5H2bWIp2X4
X-Google-Smtp-Source: AGHT+IEUTuWqeUtytVipyREn1IN3doQxNyucABAMY7DF81UlttGz+n/UxEI4ZZ5V6EYemIb/0ryCLw==
X-Received: by 2002:a17:90b:4b01:b0:2d3:ce8d:f7f1 with SMTP id 98e67ed59e1d1-2d8561c7556mr732745a91.25.1724880720492;
        Wed, 28 Aug 2024 14:32:00 -0700 (PDT)
Received: from [192.168.79.27] ([49.207.54.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d84465527bsm2423042a91.48.2024.08.28.14.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 14:32:00 -0700 (PDT)
Message-ID: <15c72a61-9592-4427-8e71-e662e4a1d205@gmail.com>
Date: Thu, 29 Aug 2024 03:01:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] staging: rtl8712: Calculate size from pointer
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
 florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240828204552.26790-2-masingh.linux@gmail.com>
 <20240828204552.26790-4-masingh.linux@gmail.com>
 <bbd42daa-319e-4390-99ac-7bf874fd0007@gmail.com>
Content-Language: en-US
From: Manisha Singh <masingh.linux@gmail.com>
In-Reply-To: <bbd42daa-319e-4390-99ac-7bf874fd0007@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/29/24 02:45, Philipp Hortmann wrote:
> On 8/28/24 22:45, Manisha Singh wrote:
>> Calculate the size from the pointer instead of struct
>>
> Hi Manisha,
>
> the first line of the description is good. Please just add the why (to 
> adhere to kernel coding style?) and the "." to make it a full sentence.
>
> Omit the next two lines.
>> CHECK: Prefer kmalloc(sizeof(*pintf_hdl->pintfpriv)...) over
>> kmalloc(sizeof(struct intf_priv)...)
>>
>
> Thanks for your support.
>
> Bye Philipp
>
Sure, will do that.

Thanks for reviewing.

Manisha


