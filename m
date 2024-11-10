Return-Path: <linux-kernel+bounces-403246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EECFA9C330B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2F41C209A9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3DF3BBE5;
	Sun, 10 Nov 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqR4N2oM"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECCAA923
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731251881; cv=none; b=FdVpcVlHS1sId2OWGHnclqGF9jcz+6H68NEsju7CJlARVUG8lkDCEJH6IUquqpfOcSXu9vOfKGBNxHD733sV9zh4mwoBXZ6XtKY0IM0FLUrwk7FV46PdrD0RiyCb1PYQbiQC86ViE2Yrvv65sOW3zVJwd3ajEG4fYyxQVxDz87c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731251881; c=relaxed/simple;
	bh=LcTbIpUtuy4Z81nMVmgyPvAqJiaUV/40H3miLAStkxY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a19QpBdPW4L7jYutrCD+Esytvf+VNjAyofQ2Au5RtomqMVVsRgc+ybDxzzjJRexAsKbHf2M8q7fsrU0Lk09b1Pad6hBZIbW2HK/LBVhZz9sqgwK9Lob8AO0L3hBLGzw9+UBFGQtPdzry/n01npfYKRPz+44UNeX2QVcmMOjAHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqR4N2oM; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so2553065a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 07:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731251879; x=1731856679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VCteRcxFW73jIBTSDNFvUke7Cd4VTBcnPuE7xVCRgco=;
        b=TqR4N2oMY9k3cxj1ilrqU0HFciQ/3hrn4xt7X1Tiyt3OhMQiCy2nXfFmIm5nE+nDRg
         aKbJqxycTpcCJk2tAd4ec1p59QxVblGB7kSNTrHCAB7qkwIbVHjQvbmcuA4AAsR1FMwW
         D6AIFDsvYKwSwkxCDNKm6IMcm+pnqPPorhFPVpFaxWGVKPQZrb0s9PFprEJ/+BNJcGiW
         LhxrT8ZJG12ohp1ye7LNVZxUHvYs9ZKcrcqdxP+bUxe3xcYBsskwtvW2WwtMMWe1W7zf
         4+2Em9s+7Y4CFJC/JLxQPqH2QJ5z26JKr4yPvPamTWL5ZX1omdzSHWfdbEXCbEQECzoU
         mb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731251879; x=1731856679;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCteRcxFW73jIBTSDNFvUke7Cd4VTBcnPuE7xVCRgco=;
        b=WmJevQKUfIgWIDkjdlSLVXvayeSKdqGFz9siRlXthangR/a3jeGidgIEX9fGJGlCeQ
         7Pfr3RnSIXXhMQTilHE+Fvt71O9UHb0+p4omulSjBX6erdTvBf4VByTkg/AmDKD8sY83
         6vvNnhETaHL081hOEU28DZEzzFy8MQpnHf/uWB+kC7Lb89N/ZAaXzsqIZON/f6mrUakH
         pxf2QWYkHMvNgQn8vpCs7miKafAHQNY4JHz+5jIQ6q5WCIVPAUwSXwzrQi27k5yru0L+
         VmiUfGwVSED/dlHymdb0MDoqeRWJQDOiOAsToyQ+p4+5HxvKQdJvs3DRNCFopOQlBSci
         yknw==
X-Forwarded-Encrypted: i=1; AJvYcCVzZ4ZXVomzxmRTRSwvROgepJBoQWPGQQG7x9iAoI7AW3lNujKFVOUQdGY+9TC5ZZrgFJPhzNkTzr5vSqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMWgGqTZWIw9HeD/5rzO06+jVn6udDDd0gwJC1SPI6WuvsvB2D
	Fm4nakvAXuqsQQ1+Qwekk03DDuDz6dvBGN6B5DhxlF+B204ZBdb8jX5PF2dY
X-Google-Smtp-Source: AGHT+IH+vJY8EncW+paA866s5okR7BWgRo7IgGmpsIQm/xAH4m0C9WN1WMzLduMlet1VhARiDQ5F3Q==
X-Received: by 2002:a17:90b:4ac8:b0:2e2:bd7a:71ea with SMTP id 98e67ed59e1d1-2e9b16558admr12300902a91.8.1731251879435;
        Sun, 10 Nov 2024 07:17:59 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6a471sm60430325ad.233.2024.11.10.07.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 07:17:59 -0800 (PST)
Message-ID: <ab79531a-5b01-49de-874e-718cb59332a2@gmail.com>
Date: Mon, 11 Nov 2024 00:17:54 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v4 0/5] tools/memory-model: Define more of LKMM in
 tools/memory-model
To: paulmck@kernel.org, luc.maranget@inria.fr
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, dlustig@nvidia.com,
 joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
 frederic@kernel.org, linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
 hernan.poncedeleon@huaweicloud.com,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 Akira Yokosawa <akiyks@gmail.com>
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
 <70907739-56b9-4712-a1db-e55161c2a8d6@paulmck-laptop>
Content-Language: en-US
In-Reply-To: <70907739-56b9-4712-a1db-e55161c2a8d6@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paul and Luc,

On Mon, 28 Oct 2024 13:16:23 -0700, Paul E. McKenney wrote:
> On Mon, Sep 30, 2024 at 12:57:05PM +0200, Jonas Oberhauser wrote:
[...]
>> This second step (comprising patches 4 and 5) is incompatible with the
>> current herd7 implementation, since herd7 uses hardcoded tag names to decide
>> what to do with LKMM; therefore, the newly introduced syntactic tags will be
>> ignored or processed incorrectly by herd7.
> 
> Thank you, Jonas!
> 
> Queued for further review and testing.  This does need at least an ack to
> proceed to mainline (hint to LKMM maintainers).

Paul's lkmm.2024.11.09a branch carries these 7 commits:

  1  tools/memory-model: Add atomic_and()/or()/xor() and add_negative
  2  tools/memory-model: Add atomic_andnot() with its variants
  3  tools/memory-model: Legitimize current use of tags in LKMM macros
  4  tools/memory-model: Define applicable tags on operation in tools/...
  5  tools/memory-model: Define effect of Mb tags on RMWs in tools/...
  6  tools/memory-model: Switch to softcoded herd7 tags
  7  tools/memory-model: Distinguish between syntactic and semantic tags

As the first commit is already incompatible with released versions of herd7,
Paul will have nothing to upstream for v6.13 unless we see a new release of
herdtoolds7 whose herd7 has those atomic RMW bitwise ops and lkmmv2 variant
support in time for the upcoming merge window.

Luc, I have no idea of herdtools7's release procedure, but is there any
chance for us to see such a release of herdtools7, preferably by the end of
November?

        Thanks, Akira

