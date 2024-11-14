Return-Path: <linux-kernel+bounces-410062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799A39C960C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00667B23B88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CC31B392B;
	Thu, 14 Nov 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aThAOfvD"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F21B21B1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731626436; cv=none; b=gKh62Wk5bA42kPgUqRSgZHpAxF+j4A1w4emkQYMTcjRqrogW46QBaIuiZNWol7JtC2Psa74U3S+YTwWfqYLII+DV5KghWymf+luBi+5nI9vQNEghglyoBx8MzmfsB8+BwY9kiUGJ/9qcujpHjDCnOxq+MCkZXAWJF9D+F6MrFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731626436; c=relaxed/simple;
	bh=2J3lCr8uY0izW4rAjsO7mF4vUQdoDpkTPEv8VM4cgJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzejylnr0buSAqB4t8GUYmZ/yfYHufUI6fL3OmKQeAKH3uwyzlFXqQDWLgNbtTb1v8QuYpueA3xqEFxJ7kCJ3XCmXCEDBpbIHUwqx9baoMySXbh+20JhmEyzk64ev9heOI90xwjaUkmxXSSL9K2wTamAR3ecwqIegzIEl94vVNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aThAOfvD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ce5e3b116so11971875ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731626434; x=1732231234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9YyrriX8uIp9rNqu5VFcUoZVCtd3YN54Bzc9ueDhEI=;
        b=aThAOfvDpBBwm3BlsHJ4IantIKIblAEx0xzuXQQrZt6Y/611Yju8u0t2X+HacWwak8
         dkcOGtq7bli0HpD2iKYoMLSs2qnD2aBOFYbDi3k+Y9XLKEGWF60OmQTheSOtqUVa9FKS
         Us9REKRUj8WKwqNcFt1lRd8ui9P3AUAT1SR/C67lECiXONqj9py+1HyBK2g8zB2rSfIU
         //WomaslDzmketrAdsTmlGQzBu4uuJuKrsV9S3VL/LtB9WJaLKEeukmRTHw89Ap2nF9U
         B0TQOpq44ljKZ3TxRAMwz8f2nUAa4p65ElnAzv+FlU+PgzoNZxjZ/SWbMcZ3yIDpFBNF
         fmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731626434; x=1732231234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9YyrriX8uIp9rNqu5VFcUoZVCtd3YN54Bzc9ueDhEI=;
        b=Erx1azR4yvAKpahG3q4VtAYDDwqr+7kj2AyIB4Q/WEn5HiaScSPTRu0aAM+7xReTr8
         Oeg7XHvLxX8sgvXPuVS13428pCZo2fuISd4OwK2nUZJVYMkU/aOXLM6T7GekS1/5QMJt
         730CVuV9/+gyOClCagJ5bhXdBGk6DwWiW8AwSX9cQ6RN5BwYqhNYeL6hXo70SZlSBeX9
         mE3lZj2ZXpW4I1imKt9wkZ2euJoQWNiqIkq613y3Wk+NaPJbGPyq09Ef/2ZfFhVrZCVP
         hMGD9sJAzOnPqotfPyqg7Om/Dm+Xc0dd1k8WIbnGwSbfRjuiXHrQxlSUgeAPTjyTivu8
         SG/w==
X-Forwarded-Encrypted: i=1; AJvYcCURLutRgmoeQg6Z2/n7SOfTiTPUiC78ZSwxp7W433ME80svPnUlRhOBdYLcSm60czamrLSBIGTJzLC05h8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpDq6f45AVELEIBB6Biaf1Dy6JfsuDitnGjnL9yeJtMDBZhbz3
	GeNJ1hMiYtrur429PXOmTeSzNWzZ4ilsJH+BcYXWd249QOxBBnqYBxslScmCR9Y=
X-Google-Smtp-Source: AGHT+IHS7d34QAvCuuWD4YPSAGFuRe0mE9fICPyDgk4eI0PXdBluiM6EUUrY2Obmfhep2aamGY3S/w==
X-Received: by 2002:a17:903:988:b0:20c:b090:c87 with SMTP id d9443c01a7336-211d0d84bfbmr8579545ad.29.1731626434069;
        Thu, 14 Nov 2024 15:20:34 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e1c9esm183452b3a.139.2024.11.14.15.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:20:33 -0800 (PST)
Date: Thu, 14 Nov 2024 15:20:31 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "arnd@arndb.de" <arnd@arndb.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RFC/RFT v2 1/2] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Message-ID: <ZzaFv6KN9YQBRMaD@debug.ba.rivosinc.com>
References: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
 <20241016-shstk_converge-v2-1-c41536eb5c3b@rivosinc.com>
 <5a89e49fe1f9d6ee2c72af411d40e2dbb1299759.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5a89e49fe1f9d6ee2c72af411d40e2dbb1299759.camel@intel.com>

On Fri, Nov 01, 2024 at 09:47:25PM +0000, Edgecombe, Rick P wrote:
>On Wed, 2024-10-16 at 14:57 -0700, Deepak Gupta wrote:
>> VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
>> VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
>> stack). In case architecture doesn't implement shadow stack, it's VM_NONE
>> Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
>> or not.
>
>I don't understand why we need this. IIRC was some discussion about wanting to
>abstract different ways of testing for shadow stack VMAs for different
>architectures since risc-v was going to do it differently. But now this says
>they are all the same, so what's wrong with the open coded check?
>

Yeah it was born out of the need due to risc-v overloading `VM_WRITE`. Given
that's out of the door, this helper is not useful for that need anymore.

However during rebasing I saw certain vma helpers were re-organized in a new
file `vma.h` and there was helper for stack as well. So I kept it. 

I don't know if it's helpful or harmful. Let me know, I can let it go as well.


