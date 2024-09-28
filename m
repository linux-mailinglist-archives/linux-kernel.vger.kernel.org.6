Return-Path: <linux-kernel+bounces-342435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BDA988F10
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87ACB282338
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ED8185B46;
	Sat, 28 Sep 2024 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="I8C/2xpt"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B92A1C0
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727523102; cv=none; b=mCjmceZcJSApToXrLEBCk5S6kl+Peyelmkxsyi+TYcPbYCLxemeeFfE4HhG6evWwM8EixEEDyqmU78o1a519eBEQ3hCZJIfdYtLL7/nM1Q9LeFo36ZOy32/prme8bLYImInAQuzgIAfvvZgwtb4+AP5hdp8R03VSOQ7apm2mNEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727523102; c=relaxed/simple;
	bh=2IOcOI4Cx/pMmnP5AyyiAvzOKafU1tYLUkBai0BYW38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krFjU6sItZv2MQnhC0sme+/jOKVNAuQxsnJbvcs5Uh3YazTHYDEXRtbnzohEK3IgUhrrFZ5A+UqW3qoYzlte7pwGmnnULHj4flBVd5Q1s7A9F8gSK1MDEF+yZNe7G9wu2ngK7dL+1Pdu8cV6VxosZro3OEbv9UK/glw61Ikc4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=I8C/2xpt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-208e0a021cfso27236065ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 04:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727523098; x=1728127898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4FFY16tKmQf9ppUBnxp1LbUAJsRD2WiXp98eBacV/rA=;
        b=I8C/2xptu0QvsMMZYqPB8Kzx2jeqKe99lgKnFMRCXEkuD0+LtEyJaS6ICgljNSm0X4
         FVs+zNgNw73oAyfOc5UPhPF6qWK8HEm4crxQOBYUG1BbGUJ7UH3Y1e3lW21kEPO9RzzT
         ofvIccInRw5En4SvcvDSzAIlcbR1ihEteZUGR/PM/7HQtUANl+2W9bKCn9gLPe4W60Wt
         UrIMzjGOzzKqxoislmdF4SCbKG9k9wa21MdrLYLW3Nn+31Qp6lyL3xoREGwlhTf/EmqD
         4sIPmZRHPgcoB90adnR1MeVXGGSfjLyUO38qT1FnbjVRyFogFZexOIK+ShNeOHlUftR8
         jKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727523098; x=1728127898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4FFY16tKmQf9ppUBnxp1LbUAJsRD2WiXp98eBacV/rA=;
        b=MDoBjYeA6qoyR/gDaqNBStRBazEPSsDsH4AfV/pUuA1Yi9x3SvP4MRZSNo+Ah1uNrH
         EqZ5aPdxWz+YWL6t1vAQ3kRHAJScGNtGFpFvRJxlb5nIbY2WtNR4tGYIUOM6nD9xn5Us
         Rmwg2C95eqD3WJRo2xXhuBhX7Lyr4oVn5gJmoBxeyDyIdZRCuqa7O0zmb0HJJVu7FnEJ
         EaCCfvPf/Xtq7C/OU0Qqs0HnQEHtXsogqDJb0+vm8niuYW/ha7InIjxbIvzZNST7pC5x
         9luIlKh6TH7VUgXbJE05Mkm2eDCNOlTTD/aah+lhUO9/feWjs4zQf+iNEkVwvCuIhn+S
         35mw==
X-Forwarded-Encrypted: i=1; AJvYcCXHiTQL3WzZ8m7/h7AAgLn5eI+QeModacEwgVcrmJ7FoLxSHFAS/MtX0Fl3nwnlVhwGV6A0jWyi8e2+wZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4mXM/lnJ/oSuXOghjdoonjNYH/Ri/zgfs+wk+2kVAu74mY21f
	JPuhFKagdt0+7HV4G3/5ay2AW++UPPEhOAQvDTQW5EC3hk6Cv+kWb4QOx6JGhfM=
X-Google-Smtp-Source: AGHT+IEOgZIi0hArSLmXT1cPZY7t7JvwXbVjn6B3Tf99CmAx5xvr4cOoQ+nv7H51L/r4E/wh3sb9sw==
X-Received: by 2002:a17:903:2b07:b0:20b:5645:d860 with SMTP id d9443c01a7336-20b5645db47mr39049095ad.36.1727523097965;
        Sat, 28 Sep 2024 04:31:37 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4db78sm25644995ad.239.2024.09.28.04.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 04:31:37 -0700 (PDT)
Message-ID: <5fe1e264-c285-4988-b1e3-46771d07172b@kernel.dk>
Date: Sat, 28 Sep 2024 05:31:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD zen microcode updates breaks boot
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
 <20240928061038.GAZved3hMSU3XahWrJ@fat_crate.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240928061038.GAZved3hMSU3XahWrJ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/28/24 12:10 AM, Borislav Petkov wrote:
> On Fri, Sep 27, 2024 at 09:17:46AM -0600, Jens Axboe wrote:
>> which seems plausible. And indeed, reverting that commit (and its fixup)
>> on top of current -git does indeed solve it.
> 
> Can you send full dmesg from that kernel with the patch reverted and
> also upload somewhere

Here's dmesg on the kernel I booted yesterday, which is -git (and some
other branches) and the two patches reverted:

https://kernel.dk/r7625.dmesg.gz

> /lib/firmware/amd-ucode/microcode_amd_fam19h.bin

https://kernel.dk/microcode_amd_fam19h.bin

This is from:

axboe@r7625 ~> apt show amd64-microcode
Package: amd64-microcode
Version: 3.20240820.1

as the box is running debian testing/unstable.

-- 
Jens Axboe

