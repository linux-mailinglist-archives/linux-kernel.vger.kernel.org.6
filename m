Return-Path: <linux-kernel+bounces-402252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 214069C257C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8281F244A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF60F1AA1E2;
	Fri,  8 Nov 2024 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wY5x51gF"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3769233D6B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093731; cv=none; b=km2dKlPhrzSJZ3iyq54SFbG3Ra2HOy1oUA4youvmIbVWg7BRi9JaVtnajkKJ7C0VY7bM8ofOcO00JmyhJznhkMDuhTt6DePjF3LNpLItHMjV/00GqZwpjlQ/YuFpA2MNRyGZmFHaqrdecUvjQgVjFiITLGgdn75lV7ETKT7Of7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093731; c=relaxed/simple;
	bh=WJkgn89DHt09s6DFefmR0m4l+HU8x7LH0bcI5yvmfeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtDeiZoPf3dI+2UxLwAtRC2n0Xu4SHoM+VOtzZavCwGQdybwR+V/l55vqlxeIHDTjBA/oGECCbLfa7ekB3/eWhZTPh32gEI30laE+FO01cswE9YxVIcD++6B5zWh4djJInXigcpo23mkQIyF1j+mnZD+09Vfeb5GnWPj0w00tD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wY5x51gF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso2285784b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731093728; x=1731698528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/2xw6bQGR1qVT12RbfKbkIMjqt4HqMiwUGLwAnBMYg=;
        b=wY5x51gFP6W7p+NjVYVVVodHM00W1nXX7AuTcFK4aZ3HBGmNLXkn8x47uTP7GKb3GK
         DUFC4K09qG0hkBIx3884HnjUe5CE3DJdp6fltnVjr9I1rZoCQPyuqfKf0qZ3E1p4WA2s
         4pXN6ojX90WZ8gS4Xm/CqZxettZtfQ4GsiG78IChNpg7xaB7hIKOgza4O7FUq4Kn+q7E
         qL/a+LHdgyFIb7xI7Ympt0ftuyynPp+aJRJLWtGsDlZaVc0YbFw2DUUk90EjkAZu2Lq0
         nVjixMn93/ZcRYbhjplj6YLmUTREwL5DRGscLr8FCbUEiQd06Yf3xyQz69vV8oedExaN
         8IVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093728; x=1731698528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/2xw6bQGR1qVT12RbfKbkIMjqt4HqMiwUGLwAnBMYg=;
        b=xLEzq8fN3Xg0+wBuG0igMCYoPEa9DlrVDstjiymIjf65ZctnhPsZqsoMbOEemtaqfS
         bztQ/tfC/l41d7zkjwkVlkEToE7yLFUjA5DZrkGRrC3GcWg81Q98+kZbIdNpAqNzs3it
         yacUnfZNSzswRWYKFUMaJFBy5UezepbjGAzfytS3xStBsZ2HXB8HqMvCMZiQaealcmGs
         sZvPK50A0lfynxA/FKyHit+cKa5D/LNNSrXven9urscfnThyMvwaxVtiiE/dWY/0IUd+
         xXMsFKy7umnzGlQsp9ch1Wd67TIGeAlTxvehanAOySC25CA8jng88ijZ+CAjeKFxCkuR
         Y9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUdsdc6wwBlORod9OYBKw3maevrfvMN9M3lpQKmXMTRbH2XW7Swv3K8HOYlnll9CFbpDSMThzU6wMCpkuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSWP/XKtBtGFs0sc96fMyjbwBQ7/1sWDWprq93TDJKuiZNKzQx
	XZ1OfvmZu5CX7UAQCMFbQBSvj1LUukoSgvTLy7ztm1zPg7758S2UyZfavJ8GW5U=
X-Google-Smtp-Source: AGHT+IE4GpRSxNEAACaLFtf3NzAfVlp/T4+DBCJgGssmHg8jA29R5sIhhTXp3PgmzohpeqnGTSBFEQ==
X-Received: by 2002:a05:6a00:18a5:b0:71e:4a46:fdb6 with SMTP id d2e1a72fcca58-72413f52db5mr6397257b3a.3.1731093728157;
        Fri, 08 Nov 2024 11:22:08 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240799baf7sm4278733b3a.121.2024.11.08.11.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 11:22:07 -0800 (PST)
Message-ID: <e7aaf585-0919-4f10-9fd1-7f80eb94296c@kernel.dk>
Date: Fri, 8 Nov 2024 12:22:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] mm/filemap: change filemap_create_folio() to take a
 struct kiocb
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-2-axboe@kernel.dk>
 <Zy5V9QmrUzWV7jv6@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zy5V9QmrUzWV7jv6@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 11:18 AM, Matthew Wilcox wrote:
> On Fri, Nov 08, 2024 at 10:43:24AM -0700, Jens Axboe wrote:
>> Rather than pass in both the file and position directly from the kiocb,
>> just take a struct kiocb instead. In preparation for actually needing
>> the kiocb in the function.
> 
> If you're undoing this part of f253e1854ce8, it's probably worth moving
> the IOCB flag checks back to where they were too.

Ah wasn't aware of that one, didn't do any git history digging. Sure,
I can move the flags checking too.

-- 
Jens Axboe


