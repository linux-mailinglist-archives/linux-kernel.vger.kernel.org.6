Return-Path: <linux-kernel+bounces-371737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583F09A3FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A97B2371B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C681EE009;
	Fri, 18 Oct 2024 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eX6i2bUc"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AFB134AC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258221; cv=none; b=r0P0mUmxEDuW8Vua5CFUj7t5XqoFpspwZJ+LCpOvEPDE3OnWmAcXjpd4y2ZNxswHkqhiaVTmPeM1WIOr5/stn/yNJiacThr8A6x13CdeGRozK1WfqcWtyVV4v7fm2QiHTsqWK7v8myHFUca3pHG9vDgWcQVb8r+Hxjz/1LqniRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258221; c=relaxed/simple;
	bh=KPSDXFRajCiADW3kOGC7o+H5Jjxj8YqYn65iwwChS6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9bdyzgUJkPrexRaMAgIfF7ih6BYgW/8PuEbdVN97Apt+g2DXeSWsjpN5HMpN1qgNY3M+ECnmywQqaveAYvlHuLdxGlWX+IkyuIb9ALzZn+6aPE3K+8hEBQ25mQi6uhAqPimpRZYPwYb3Gbz8XCcNUz/6acK8VBUyJxlCCrycAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eX6i2bUc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso20042085ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729258217; x=1729863017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RoQjeOuXX3AlCfEBISUxX7T/BVrV6UabUw4LIP4IFB4=;
        b=eX6i2bUcQifDPRB39wLZAW3iF9lblQm4jiJTkmRE+4ssP5zlQcnCeie/Sq8eapdP9o
         5K6Y87BgCMfQn/y3vbcoeI512lQhyssHqJqipYxVR7KKJFINVPVB3bvVnLIVUIKAoB2R
         3InhLYoDGyL0NWqJ5geDZl1WPsJSVROCWoufqKZE5GAnB3iAjhGWk2PIvsRqgUyWFQo/
         AQKjry2rfqE5fLkxEIg3msni2FyK+XOWEzxFId30AKvpKJIpNCRwzbYxS8FvSCArxZEk
         eDqAnT79Am4IVl77jOWXdGMT24KSEw0nXR46w9rZQ8+JmmwT2cw9kuA8DZ9ulP5IqQI5
         yKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729258217; x=1729863017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoQjeOuXX3AlCfEBISUxX7T/BVrV6UabUw4LIP4IFB4=;
        b=ed6rUFmnOseWc40stgjoDOt9h/VwYijJvHkUpbe5m479zACJRUVlcK/e+eluckGe+8
         Q7quNZdyWAbKA+SfZ+aRNv147ziaqKW78KsGNaYD+o+90P2vVYwi7yWQedl8JNHjPR60
         7zQFlZccpPCR4RiKbHPoOtZcJTmO/dqOA5s/Li8+nTSGZC6c81iZWo6+L8DQLj6tyOyB
         GWzIulotn8iFtu7YCGCVIU8xDDRPoJU3GWINm1ZY+CTsSlR2sqwef4rNeN4BTb6+d3oi
         /uXAB5ofCp5h0ZKyFSyzJTzIuNAWvhU042bWZnd98ZJBmKPhgpC2UH1ev4SMYF2Tq9Ma
         rjFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj3oMYa+zlEKFnqz6VdNEa0xRnMSxCWZc7ZLJuvZ0QXEL07WSECyqlV1BJRfRXiCkoSQp/MdtmfV2t6fE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5mzYOUKM9xM9SvS1qfdWLue1PMec+cR40tzuKznmORkh9jMYE
	myoHa7ggMWZS8s7eqgFmSsR+auvteeO/K9oYD672Pg5lvNLc3bDPKXdoug4XBhcDXHJYm1WQmq4
	B
X-Google-Smtp-Source: AGHT+IGk0asjwlSemWFvowI7NtGy4UmJu78/1/m70oxQTRdp4QpvFvbGEmRsvoG/eVeLt+N1ihdayw==
X-Received: by 2002:a17:902:e848:b0:20c:da66:3875 with SMTP id d9443c01a7336-20e5a78ae60mr31288335ad.24.1729258217464;
        Fri, 18 Oct 2024 06:30:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8fe68asm12410915ad.237.2024.10.18.06.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 06:30:16 -0700 (PDT)
Message-ID: <79296353-1fa3-458a-b055-88bc6a772180@kernel.dk>
Date: Fri, 18 Oct 2024 07:30:15 -0600
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
References: <20241010134613.GDZwfapaZ8AKp0n72C@fat_crate.local>
 <842a76fe-3d6a-4846-83da-bb113634b8bc@kernel.dk>
 <13fe104b-d83b-4d6d-a348-1103d402540d@kernel.dk>
 <20241017100257.GAZxDg0VqDAesee00m@fat_crate.local>
 <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
 <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
 <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>
 <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
 <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>
 <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>
 <20241018124943.GDZxJZZxtwA9O9eqiU@fat_crate.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241018124943.GDZxJZZxtwA9O9eqiU@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 6:49 AM, Borislav Petkov wrote:
> On Fri, Oct 18, 2024 at 01:58:57PM +0200, Borislav Petkov wrote:
>> The next thing that is catching my eye is your simulated NUMA config:
>>
>> [    1.668943] smp: Brought up 32 nodes, 512 CPUs
>>
>> Lemme see if I can repro that here.
> 
> I can do only 4 nodes here:
> 
> [   23.137188] smp: Brought up 4 nodes, 255 CPUs
> 
> But that thing boots fine too.
> 
> I guess the next thing to try is a two-socket box like yours.

At least on mine, the BIOS has an option that says something like "L3
cache as numa domain", which is on and why there's 32 nodes on that box.
It's pretty handy for testing since there's a crap ton of CPUs, as it
makes affinity handling easier.

-- 
Jens Axboe

