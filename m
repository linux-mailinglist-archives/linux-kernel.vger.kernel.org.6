Return-Path: <linux-kernel+bounces-280298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A64C94C853
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBAC1C21B18
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605912B82;
	Fri,  9 Aug 2024 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMSdxDJ/"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD911185
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168672; cv=none; b=lby6aDhsvoWtgrx4C2w2gQ9r3iiPOoTfnSWkCZAV+FJMztjekZkTVtQEllvE48EJmjIDqWsKKwCZZ8QF2QYjyhha5NRwLRdzSCnwUNet+FnYnYxDPWYfoR37nA1z0FJz5kjNLAkepgiG9mzraYnYA6WWKMSRwtdUikBh+0O5Tu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168672; c=relaxed/simple;
	bh=e3hWooo6TlTCb+z5/eTYrLth+2Cm0fnj2Bq11rJlINA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECc/pglP4xyQhAhViPJrx5iScJnqXIq3reDRAMU5iPsKy80r88qLPBFLBUQAYsNdmXHLBtA4iqhVijiSXFLUo/hitY+spGNQVZWMp9ZkD88SeONnjWfnhurlrDmUGeFwCSRdln52JysSogI7EWtfp9lZqicRl7CvfRjq437f6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMSdxDJ/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc5549788eso15494395ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 18:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723168671; x=1723773471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e3hWooo6TlTCb+z5/eTYrLth+2Cm0fnj2Bq11rJlINA=;
        b=IMSdxDJ/X3gA6ZFnyT6PJnzbjUqpsEYSvMOAH+gQzJ+eb5PYa5VcKiNq9zitfPLuZd
         rUVpkJG8e2V8AvyZ/mWEWA5VJzaFdt0eziXiFpeTM8FoZOQzgtEB2puZJZPeeTkoob2I
         Od1thtL2jz9kZQGtNBTlkFAqaLOsHlVVfpMOPyVWTPGHmGs4zlYsO6V/SJaAxpHmWFBz
         g24QgvF7TZLFi+gPVdeC4EjChA2Xbab9RrHSaQnMWpCWxWEaOxEyfe1vg6FO3865Secl
         bsYO0RJuH7e23ceM07qF7UX8g+6OZCkMGvpthd/hqzzCSd+Hv1STeQl0r0BhKyhiNsqU
         qW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723168671; x=1723773471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3hWooo6TlTCb+z5/eTYrLth+2Cm0fnj2Bq11rJlINA=;
        b=iiXcIJ95TIUQEgUkz6mALWVyX0prlnro/eoy8VNAutQSFW878QgCppNXWDC+OdT8Ul
         Ce+quHKmY+TCmIuM5cEGyEq2EoSTKhIz+Yu5GAA+BEAdKCn9LNVmEEQmJ63N4fcn/mSy
         bKg7s1MO3iDxwTpEMkkCfCaPPw2MYaBpYog2sfsgiYCNMCLnLZ1DkPrCMNkJc+nBmiAT
         0CLFMaYxGRYzsnekl8Whhb+u9JezrydQW7YL72GO8w82w58R4ZPuLmN8bKuqSqQg0DYV
         akaGC5lIhAwFXZcPasCrg00GVmEmEprrrNLXwJHJBqTE+LZ5EOjal+ICJz8DobDwdG+S
         PrRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1dnjv7TD5X82k7/fmRR08W4IjrzyxXabGDv6frmx6+C4QYHIlqX4Hnjfyx1Zfu6BtlsYoL9y/agdR3nFMhQOGLVtxYGLvKO6gNC7p
X-Gm-Message-State: AOJu0YyESX+ARyFptPYOQzA9lWV2qJLp5iWVvxmdn1rnY3SXKyARe94d
	AMbBqwU8Pvm6iYTl88d4DXwcCbl5WtYRsP5sK42DtkSvM3hij5M2
X-Google-Smtp-Source: AGHT+IEHZcxbJyvEDWpe9FMJ03OibGbtIVlG0Rvh/bzNg467SQswLOfXy+AVc6vJX5wHlo0fkYgx0A==
X-Received: by 2002:a17:902:ea09:b0:1fd:6c5b:afd4 with SMTP id d9443c01a7336-2009535c4c9mr51846265ad.64.1723168670804;
        Thu, 08 Aug 2024 18:57:50 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2007728d837sm59945385ad.84.2024.08.08.18.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 18:57:50 -0700 (PDT)
Message-ID: <73d3e43c-cdf0-4ed1-9df9-fc0b8069db39@gmail.com>
Date: Fri, 9 Aug 2024 09:57:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/22] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: Vishal Moola <vishal.moola@gmail.com>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com,
 Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-2-alexs@kernel.org>
 <66ad2ad7.170a0220.3a8e93.6a32@mx.google.com>
 <c591405b-3034-4a55-8664-e0c8ea393b79@gmail.com>
 <66b50cbf.170a0220.295f9d.891b@mx.google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <66b50cbf.170a0220.295f9d.891b@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/9/24 2:21 AM, Vishal Moola wrote:
>> So I wrapped them carefully in zpdesc series functions in zpdesc.h file.
>> They should be easy replaced when we use memdescs in the future. Could we keep them
>> a while, or ?
> IMO, Its alright to keep both pages and folios due to the size reduction.
> However if we do keep both, it should be clearer that we Want zpdescs to
> be order-0 pages, and the only reason we have folios is that
> compound_head() size reduction (and nothing more). I think a comment by
> the zpdesc_folio() macro will suffice.

Right, will add some comments for this.

Thanks!

