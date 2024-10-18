Return-Path: <linux-kernel+bounces-372185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A24A9A4564
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE47128164A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A792038BE;
	Fri, 18 Oct 2024 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="N/oH115q"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F320264A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274604; cv=none; b=uQc/qeYsVIuoNGDQoZrVzlFtgtTmEivtBSNAlmMKJ7hOWZQah0QTMs8uxNnW7fPYVXOpCS4ePAW/FY9Pcl+ND3ReDSLuIXx7cH08l7RCDC/B8bqQ9UmuWmj8OYMc3OxlcrwfTpT8bX+FoY+fhDjq5X7Pm0NVlEP2tmvegdnMjRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274604; c=relaxed/simple;
	bh=zxqa3/qqKqvRYqqj3Z+cv4GKWsObzym4ycxYsNtVp50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrpyUAz3EaSiHvLtynX07Se12zTgHgRGk9u/gYNhE8cmalnDn75JKoCX16DE/ph1NSEkuzKcy0tEsL/YTvA/1Mted3gv4FbLvxR1LBBEqlqr2GeCKKHl423miGnEnsknw6lDhHh8iW1L/Pem7FqK6BiJZ+vTwmy5uMOsYNfpSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=N/oH115q; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3bd42955bso9909605ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729274601; x=1729879401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2zH+UgTmxiSGcgRF5ylverOTn7g/wnZyHq4IeCCvEKk=;
        b=N/oH115qPft7KbQBBb65nP6znoapO6JlMhxU3Fl697e2Jsg9I2tIFSEQYEYiTpTl1W
         JxLLY8WvcVfxbCzXvwCknHqc8k01a+101wCORmoin7PlPvgovu+vbTm/D5GiKLeFb3hJ
         7+DlqIXC7ea9Yomn6GLJ/4M+GbKvv3oGBa2um0OpcuXMo/weFLK6sYcrg24rPiGPR22R
         nP8nVrd9K8PcxyrX895I2fUKKWSn1EiAjMVwmtKgjcLsm0Mjt4RwapbAXI8+g+uzCYL6
         ejGlQOZMdHQ+onPb4Opx6AzJc+InJsTpmhv81J905zTOxZJ9Vid8iwpY1bazNWvYpkv/
         brog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729274601; x=1729879401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zH+UgTmxiSGcgRF5ylverOTn7g/wnZyHq4IeCCvEKk=;
        b=h1WUOl0M/SbcVzQ8CNl/Zjqc/1BG4zkJvUcL+js9zossz/zA6phtchKtZFMEDZwqi4
         pyt3/DVTuaV+FzWkgkJtMNtmrobtVtopntWPcWQUffysL0DYACnxNalCuUezAUTjIomB
         SgZYh/iMmU0or20hCxOBYnr1a3RTA/w2tJaLJo5TmSO/vKPFzecDMIYyMoF5HMmSnabc
         o+VxdqiA4hky0nOrG3Us1gAfceAoctBG112ToBP2Oa3DC8Qc04VRZUSbouAAHZ3v6qDo
         zSFwK3v2kOp0ienMRrubwyguJE5MxMvE6sQifTObabkObTRTqYrLJMWYBlEPPD/eDV1q
         hYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdwIPZNLq5/Svffpvb1uxoaCOoiq6cQJ6RXktBr0+3XIsirnDZVHhcpL+4i33pKwQR7Pu7+cBmTSSrEY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Neqz/AOKkH43plzcfvwUw2ocOZ29SU702gOdDZJ+/l03R2Uu
	LSSAgWmNHFBZVUstC9sFcUJgIoggXuhPXEgfb3fUJ/jOIDtGbqmM5TyeWs9IB/ssWE8/lEQbIdK
	5
X-Google-Smtp-Source: AGHT+IE+pGq513oDYSwzlCR3+veRZ0wcIsLmnHLa4KDvFAyR+Opj2KFGW5U0RftsuR8Py+wlzIITVQ==
X-Received: by 2002:a05:6e02:190e:b0:3a0:5642:c78 with SMTP id e9e14a558f8ab-3a3f4073e06mr31868635ab.15.1729274600995;
        Fri, 18 Oct 2024 11:03:20 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3f402dfd5sm5125995ab.55.2024.10.18.11.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 11:03:20 -0700 (PDT)
Message-ID: <016ecb00-2331-472c-88e4-66b1dbecfc99@kernel.dk>
Date: Fri, 18 Oct 2024 12:03:19 -0600
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
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
 <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
 <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>
 <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
 <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>
 <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>
 <20241018124943.GDZxJZZxtwA9O9eqiU@fat_crate.local>
 <79296353-1fa3-458a-b055-88bc6a772180@kernel.dk>
 <20241018155143.GIZxKED9YcF0Jg1CWZ@fat_crate.local>
 <320024ab-63af-45eb-a3ae-5486cb2015c0@kernel.dk>
 <20241018175606.GJZxKhNmW9nCLwNS6Z@fat_crate.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241018175606.GJZxKhNmW9nCLwNS6Z@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 11:56 AM, Borislav Petkov wrote:
> On Fri, Oct 18, 2024 at 10:48:19AM -0600, Jens Axboe wrote:
>> Funky... Not sure I'll have time to get a serial console on this
>> thing before next week.
> 
> That would be much appreciated.

I will probably have some time to get that going on Monday. Just to set
expectations in terms of timing, the above should've read "before the end
of next week".

>> Like I mentioned before -rc1, maybe we revert this change and I'll be happy
>> to test patches as time permits?
> 
> That's my plan if we can't resolve it until -rc6-ish or so.

That sounds fine.

-- 
Jens Axboe


