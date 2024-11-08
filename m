Return-Path: <linux-kernel+bounces-401417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D329C1A0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADB61F26192
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3489D1E22FD;
	Fri,  8 Nov 2024 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfR8BcyF"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C81D3625
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060764; cv=none; b=m3CxNexbm/C5UMS92nwE70YbXBOsJuAgabdfJLABg3iNpTYGU5ZEG4AU3eUIHtmp0vKC+pgiWi4UfN8NrNFZwI8sDDnbSfiVU+ObuAJM8cRTjkC2GqHeIfKSueEAm/iJ0VC6McxX+J2UF9BvTLkjali2Ab3lWnACv0RndnJV39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060764; c=relaxed/simple;
	bh=SeEZ3FiTtve+//uUNTtAHmQb9BBMARmB8mLGRp0N+6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADobdGdYyhRrLuLXbi4KdnMNIsDdVZURvJIQxsQTZIsimS3+l/CcnY04n12IgVPjQ17uF27UIEaUVQv7Oxp0LlrKxgrMYpUaKqqTMxTVhCAPGrIPW7Gy+CWNw3Kc6DXPp9ww6HVBWMWcBbK4K7BsjcinuydNKUsr6WTwiQn1oZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfR8BcyF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720e94d36c8so2740966b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 02:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731060762; x=1731665562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCeFBhi53dTGSGPWiOQdp9+xDJ2cZ8mlrfTnzvDIhuM=;
        b=dfR8BcyFCNn1r+f2ggJM5/4DsjE6JcJS4RYz1bfWHzX0VymZMDjI0mGMisVKXk233l
         n5x/lHlSgN76eNMSR0rFlBYkraGxTW3s/st5XE46ll+ZiyXRKmSxfCyYO8ACUYucXbHb
         zQdjUP78OaV2fTiAtRbK/wy85aqh+77JnxmXhz6D3URo9U/jtWKHFYCAi7OH7fUw3+h4
         F34tlVP5D0yE37bzWnoh/dQ5JtUNYyYLb1sf7n8HboCDYqrxAZ1790oSR5mRtPb6RpWH
         WH1TnlCmEAuSoA7/V2O7IZGmtLF2VnwI1jN55wdaFjWcLMDOEPBSdu//YAFIgnBk63/E
         n58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060762; x=1731665562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCeFBhi53dTGSGPWiOQdp9+xDJ2cZ8mlrfTnzvDIhuM=;
        b=vr83ThCtlMJWWtTSOW2fu4raANl/4XL3b2E5CoaUvcd2YyTFGqsdz02mmrAOqkBzxx
         3yA9f56qm5Ri2T82GpOksRRHFX1AdKk1GVgTgYMmhcSJZbu6xFtfbRzQGZDAJbztNMWV
         L2JeqqdZe0rJP9gNN9nJSNQ1oQ/GZFGojYUBbLR9A1zoaWJWXciQzKubFyWpW/wh35r6
         dpi7Z+x02OOESHv7ZnP/cD9JDT9IvxFB3FhNdXupF2vll4SNuzKF4nC3I0kHGMIzN2qI
         Ix7URAjgY4TBpAj/XiEMM30/XFsAxb0v3hyjWez7soG+Ag3EP7lZcTqpqhC6EPLligmG
         W75w==
X-Forwarded-Encrypted: i=1; AJvYcCWbMszq6AWK3mhMrH+7zGlcExRZ28kMr+Gnc5LxuByljHIcfp5dwz7K/fDdnQMPgZ20Il6yh2fwg9+fFNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3CzvqzzLa7kyoyx5fl9yft9IV+xqX4JxcHiUKEj1KMbqAoDh
	hI/G5V/ymEVr53r6+eZTMlwniCMGjnzuk8xvK3EsCtKciyWVu6G6
X-Google-Smtp-Source: AGHT+IED/7Ma5XQVyEfvEzCla5zLTZctQKHQbYg3d/yVdLqHQKmY3qhfc/N0TxEiAF3EhZikIVSSUw==
X-Received: by 2002:a05:6a20:7349:b0:1d6:f6a1:786 with SMTP id adf61e73a8af0-1dc204cd758mr5129256637.3.1731060762429;
        Fri, 08 Nov 2024 02:12:42 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f48b508sm3032426a12.1.2024.11.08.02.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 02:12:42 -0800 (PST)
Message-ID: <a278c4a9-eae2-491e-8f13-5a87a25dad26@gmail.com>
Date: Fri, 8 Nov 2024 19:12:38 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] tools/memory-model: Distinguish between syntactic
 and semantic tags
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: boqun.feng@gmail.com, dhowells@redhat.com, dlustig@nvidia.com,
 frederic@kernel.org, hernan.poncedeleon@huaweicloud.com,
 j.alglave@ucl.ac.uk, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, luc.maranget@inria.fr, npiggin@gmail.com,
 parri.andrea@gmail.com, paulmck@kernel.org, peterz@infradead.org,
 quic_neeraju@quicinc.com, stern@rowland.harvard.edu, urezki@gmail.com,
 will@kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <3d72b92a-4935-425c-abd5-ec4631baef2c@huaweicloud.com>
 <46d291da-ddb9-43b9-bd93-b81aacd5e29c@gmail.com>
 <7542399d-87c5-4f1c-9d09-6a6f96d148da@huaweicloud.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <7542399d-87c5-4f1c-9d09-6a6f96d148da@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, 8 Nov 2024 10:10:48 +0100, Jonas Oberhauser wrote:
> Am 11/7/2024 um 11:51 AM schrieb Akira Yokosawa:
>> Jonas, despite the CC, your message has not made my gmail mbox, not even
>> the spam folder.
>> I'm replying using lore's reply link. >
>> As Paul mentioned elsewhere, the [v5] patch misses tags from Boqun at the moment.
>>
> 
> So if I supply a new revision of a patch, should I include in all the reviewed-by
> of the previous patch?
> 

It depends.

> I hadn't done that before (because I thought I should not add other people's tags
> especially if they hadn't reviewed that specific revision), so we may be missing
> *a lot* of reviewed-by...
> 

Section "Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:"
of Documentation/process/submitting-patches.rst has this paragraph:

  Both Tested-by and Reviewed-by tags, once received on mailing list from tester
  or reviewer, should be added by author to the applicable patches when sending
  next versions.  However if the patch has changed substantially in following
  version, these tags might not be applicable anymore and thus should be removed.
  Usually removal of someone's Tested-by or Reviewed-by tags should be mentioned
  in the patch changelog (after the '---' separator).

Does this help you?

> If this is the case, I'll try to scour through the previous e-mails and add
> all the missing reviewed-by.

Only if Paul asks you to do so ;-)

HTH, Akira


