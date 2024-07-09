Return-Path: <linux-kernel+bounces-246525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8645C92C31A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5401F239C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164C317B056;
	Tue,  9 Jul 2024 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TN8H2bbZ"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC486BFB0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548559; cv=none; b=bYYTys+BaMcIhuAo4s7xGFhRc8ZEB5ze1YlKkd3/lencgLcDmIKJBrQsA5Wb3eVy+Z9ysOsVTwDlIAr61BmB6kexukFtUtuMu0Oo36/Lm5L3yMsrEjLZ+3UK6/QVm6kedhV0vorg3OGlPD6z9E4Nj6ebjfOKyh+7b3T1tU7TyMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548559; c=relaxed/simple;
	bh=Nedr5O72MMaCJZHo0lSW5X91GqQNSfgbP3hdBOw9eC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xnv9UH4JuNjn10HRTqiEPQEwybPX8Ep1bPjr53htgm5v1Wa7ZSw5if2V7DzZu6WIP6/uxLcHLoREbsOOUJ4apKVQ/GzfGtHRuDWt0C6JqyQ3qAnRMTcYBl4QXZDWxvL7/Z339Gz8tTkhmfQLMszhCq69raOrlaZbQpr25CYyHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TN8H2bbZ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7fb3529622dso9534239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720548556; x=1721153356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1E/FOgz2bzLAk7czsspwJRssUwyfo69Q4JV8FZsYC/0=;
        b=TN8H2bbZ7ibYoNF1/DHVfQSYP5qoFtQyexlE/dzeUFZbgg/QELjX7t0j2ngDxcA+iZ
         bHmZqjljGlnX/rOe2rfEGkxU0NO6qyvXOQFq7Fo77WzXMEIPjTHJY9QzeqIj/2qcp0kB
         T1QuH14XYCiZr20E2bLg/GX180keEh6mnqYZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720548556; x=1721153356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1E/FOgz2bzLAk7czsspwJRssUwyfo69Q4JV8FZsYC/0=;
        b=B4/cEUbLd50fzow9jwxfYXKwZjzrpgfKmqanaMBQ9nrsAowULDj3Yt3I3u3M1u87rX
         zLUPBcx5/SW2NrFx7BMvtOi290GVSK0m6veYypotiCzCgKAqiTp/Okc65Mp6dtdb85D6
         9gliKqU31as3MRz+Fir01B8EuC0H6znGpj7eXdvol6NKjX+7khgUfexAK6ntCrsQtHe6
         v65YHQdksnCxExdP3dpSsD/00IEzV3gGXbAAZAJtS/TUf9KxXyIcSY1vTnaiN+zM4w2Z
         MFk9m5O3XzLJM8TnytJtmI57v2RNrWZzc2FdwBKo+ClpTH2xZvbXq0DWF1vnKZi0EHX+
         VUfA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0R9F6IAdNNB5U2iooZ8cirRaTD0kgCXDkoOuxu0QpJ3AQKk5GlBXWx2XM/k9Ap+pcvIYsAdH13TfQNGgrCXLJFsxMGO51tw+Xg9M
X-Gm-Message-State: AOJu0Yzq3nwz/ELVItKbxfAWcyDhoWdkjengVegPCCTXGvh3Yehskhba
	N7lfH4kwdKXrJF7PtaSDI+ClwO73IwtNdGcHNIV/K1jqlngVCubSRQvhguIYK04L+wd9Ru1RlbF
	I
X-Google-Smtp-Source: AGHT+IHeHnBu5isyAddwI1V9QJx7d99P47RZ/yrGAW+PJhY/k0T9TJ/9xtTL5eHYe0IzkmsubRMkRg==
X-Received: by 2002:a05:6602:3413:b0:7f8:bfcd:db53 with SMTP id ca18e2360f4ac-8000269672bmr385534639f.1.1720548556008;
        Tue, 09 Jul 2024 11:09:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1b0d41csm612367173.38.2024.07.09.11.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 11:09:15 -0700 (PDT)
Message-ID: <bb8602f1-71f9-438d-91b9-6793250648ea@linuxfoundation.org>
Date: Tue, 9 Jul 2024 12:09:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patches in the random tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Shuah Khan <shuah@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240709180829.65e8967d@canb.auug.org.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240709180829.65e8967d@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 02:08, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the kselftest-fixes tree as different
> commits (but the same patches):
> 
>    868680ffba11 ("selftests/vDSO: remove duplicate compiler invocations from Makefile")
>    7bb79ef48b9d ("selftests/vDSO: remove partially duplicated "all:" target in Makefile")
>    14cd1a877fc6 ("selftests/vDSO: fix clang build errors and warnings")
> 
> These are already causing an unnecessary conflict
> :-( Maybe you could just merge the kselftest-fixes tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git#fixes),
> but first make sure that it won't be rebased.
> 

They are now in Linus's mainline. :)

thanks,
-- Shuah

