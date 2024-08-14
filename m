Return-Path: <linux-kernel+bounces-286842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2C6951F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182B11C216DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA841B86DA;
	Wed, 14 Aug 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQzPRwXb"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA71B3F0F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652255; cv=none; b=JF0dZLel7txsZs+YPFwVFm2O8OVTs1Q7Ure0W7+dEqlJlTylvp6CDfzIyaRTXYUnkmvzi8iOQcmLOmMx5mXR3uK2HAFM4JXhXJtqsVjtiP2gFaT6ZA44PCLpWK1oPoi8zTJ12PEX6LXnXfvddZVrnMImd7MwfeUAVsVHlxs5QR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652255; c=relaxed/simple;
	bh=6uU5bPOhpsLtgNrDyr3EXfPL73MUahiX/RBlfJxZcek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zn0dAc2GDCSSX+nnPyF20JG4uK0xeWAT4bVpvN5Kcs1cNHATE9NkTzBCYuTZ3JKAUELZrj91LG88Kuk3rbjnAroQJOcG5/pcDYcHePuk89BManBKj8N5oguw32A87zsJWAwZwdOM+u6k4RXcqwegbILG5Q4VIcHOUZft+kVf8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQzPRwXb; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-530e22878cfso13814e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723652252; x=1724257052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DcC1t0kafFLuJe1JRzgDwbaPXnUNDb2757E1G8pYF4A=;
        b=gQzPRwXbmTYzoUyqJ10UitNT9vx/H8k6pk8KJ1xpyLanPS0XG2fToWg023kkqpqigS
         zhR8E8hsvWPGbaKDRTBrpwYiyatnAoIrpfFe2s/FLjYRTsZsAh9aNqYN7qKhZUok1syV
         LvWgLRh/QXgrLgvn1ukIFtqfP+y3gp/1MtAy6xqwXShzyKWZi4bR2clK79JcY434L5HV
         bzukji1j5m8E2bYsDFGyW+yxEfm0pZVgUgm9U5BalB1fZ6P4104Vu6QM1FxHQglARVJ4
         bDduhc0ijIM/x5GWJjv1s37GhY19qR6MCioMZlTPohw8LpQRDAHgU891Qw9P44tQJ5QC
         CdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723652252; x=1724257052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcC1t0kafFLuJe1JRzgDwbaPXnUNDb2757E1G8pYF4A=;
        b=CpXCB/0krDduEhWZ3StEM3NN9H0bhFyeSt6hCzKkyL4bkTFvbEcsezsBW3TtdYn2nJ
         vYg3LMWwYxb/gbZuTRxBNYw8eQO7HUsbw3RVk5KlpH9fQsAFUb5xnkcvw0qMM8U15KIY
         wuX27X0WSgkF4KBQH3w1UV3O91jjxxUihHSaq4dhzJ7zn+YwZvGjf5vIlqEYSYQeLEpr
         gOn9rQVCaVdwkUPgTv9t6f/WHe5cSK1+tRoRFq30B4sZyejJK/QMclypAtwKn07LAmGr
         5wlX2Ks+huLYQyz0ww2gDHN47OYHTMvVoFz50QyGoF2LSZNCCvzWosIruSu04N8sYgV7
         UuaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhZXhju5rc4PddnZ41RFmwuAAxiQn0aSTC0ncL9vh1wrchHJwor+RdXZnFq+pq2iaTmVzDTmi1UCnuuuiUZ2QheAgqhf8DI3wrYg6/
X-Gm-Message-State: AOJu0Yy00vye8wMig2SqcylyqWDikiEzq3YUAJyaLlWkU3oMSzRGX7aZ
	tqjLLPV41M7Zx+MyCEG8MZXm8lP/KM4eImXiu8q7llJbm8invG/O
X-Google-Smtp-Source: AGHT+IEjQIKcBJ5wux2ADElwYZ8qiLfjrritXGwsWqCqFkGfysJr9AKddeiPZr1T8HquAH/I579aGQ==
X-Received: by 2002:a05:6512:b22:b0:52c:d8e9:5d8b with SMTP id 2adb3069b0e04-532eda86287mr2356129e87.25.1723652251129;
        Wed, 14 Aug 2024 09:17:31 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:61b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f4183a60sm189405266b.198.2024.08.14.09.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 09:17:30 -0700 (PDT)
Message-ID: <64e9c1b6-79da-488d-8e7f-8b3fce3d14c1@gmail.com>
Date: Wed, 14 Aug 2024 17:17:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: drop lruvec->lru_lock if contended when skipping
 folio
To: Yu Zhao <yuzhao@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, leitao@debian.org,
 huangzhaoyang@gmail.com, bharata@amd.com, willy@infradead.org,
 vbabka@suse.cz, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240814142647.3668269-1-usamaarif642@gmail.com>
 <CAOUHufasQ5019b4L6R69-G=k-dCa1WuC5g6yGfYvzNOk4Au_iA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAOUHufasQ5019b4L6R69-G=k-dCa1WuC5g6yGfYvzNOk4Au_iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14/08/2024 17:01, Yu Zhao wrote:
> On Wed, Aug 14, 2024 at 8:26 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> From: Yu Zhao <yuzhao@google.com>
> 
> I think in case the patch should be "From" you, "Suggested-by" me, and
> "Reported-by" and "Tested-by" Bharata.

Sounds good, will change it in next revision. I will wait for a couple of days to see if there is feedback on the patch and resend with what you have suggested.

Thanks!

