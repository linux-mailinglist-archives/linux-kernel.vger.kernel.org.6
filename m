Return-Path: <linux-kernel+bounces-206056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 085729003BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353BC1C20D62
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D791922F2;
	Fri,  7 Jun 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jR83zLvT"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8961847
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763843; cv=none; b=k64bQmryuZH36l1LkSOcn0HrApl5N+5XRpoNaSZihAkW8pfYR0tnAXRIJZ1aH9bBmijgR2qcwbwatRo6sxauaQ5RsOUEB/0kyIgRvQ2oAxbDeR812Cvk4oWBdUhnbZj4uh+KjNow9ErX+kaDPOZLGF3awuMBUJNbO0YVexqruy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763843; c=relaxed/simple;
	bh=TZ/ZhmIzrqOSG+OEUHTv5WbsvCvdliRlsVlV3lPdpdk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Si0/Ta4bltAN6vwKP+rC+pZ+AWoA0oY/BQQxnxjP/l2phRvNHOXyiiReO+xYbyG7zSPHxaiqC14Gc8bQaRvn6CQtvJGAOhMI7yoI2xzpKvHOV+NfLRfgzA/mI63OG/+7bCh4A04VV0elUmWoLt8ypsvFuxHGiCI/XCMfMeXwwb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jR83zLvT; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso29877151fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717763840; x=1718368640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZ/ZhmIzrqOSG+OEUHTv5WbsvCvdliRlsVlV3lPdpdk=;
        b=jR83zLvTEmWqyNKg+Zxqc0kOGohw6FClSnPE5kOW9fhjl2Dj9Xqjv8nmtQW5YW8Ivh
         5S+OF4rjdbjq4ppnaMcjKK+Jju4vx3FkGOtzzOaXMo1J4sw9JG6LMaxGVC5vmj+KtSZH
         KNF2N8uu7DSFO/JmJgJ+6ny80p5hG28uI/0qqtUjidBKolL0yMwMz3v+fXDfR20Ks8d2
         0W0yQj0BuoHmxl61GBIfenF+9ulIThMThRFXrlYoJbukyCkkJBx2CsuM5jgkfFnJgF95
         YxAYLUP5Yiqzva7JMWD/msUZru/jnbOrXL70bPJvkk0Czw61gFGxJiXXmvzjXnjwOnM7
         bAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763840; x=1718368640;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TZ/ZhmIzrqOSG+OEUHTv5WbsvCvdliRlsVlV3lPdpdk=;
        b=mqM6p495Ol7+H2qiaof4pm/5l+nQyJ7NA3MIUC3TzdKvK+DQ/OyricZzfUbijzLWbY
         2OzdQx7bBRhodwJWXGuOfYLuWFMfMtIORBGO3Jn32+4ehWWv2wKl0S5P88rhZsTAvby6
         kXgaXe2vDhRl6G2+Nt7THQ7bcfDydmMlL2yBqSWnksTeEDQUyR07oRMmTIJS+3yrY2K+
         aKp3MbMrLOy1TEyu+fDsEUJBI7V1zMdl7dlhdiNIqc0epcXlSLDtHP5vZPNwOwOtkaZL
         vZwR010RgSzKKDsmZIyn1eQEnhgragFeKLDRikYzHYvYAeH7ctdeTLLZCRguK9eZNG9O
         N1cQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9OE2TCGzLIjOiywUbStc8kpeSzGJm6HqYZoXD78rQuFfQ4SQsvapQjOJR01mZC4/weYWBbyNLjEkhzC+jbOeoNqPLkDNhegviwAHD
X-Gm-Message-State: AOJu0YytZFcgsPL+xpWa4ezNhgIGGoIkxfzxLFBInmwJqyflc+M/0DV3
	BfzQk5B+BfcFkn1+MhFAVuUaMC0Sg32bCmYrNaMc6L7Kb64F3bUL
X-Google-Smtp-Source: AGHT+IHMzxB3qb3l+2IugZUadnhQFabfZ7UdW/eQFyy+n3U9YQNITKkcggv8h1NfKBSjVsXd/XQ/Ow==
X-Received: by 2002:a2e:984c:0:b0:2d9:f68a:d82c with SMTP id 38308e7fff4ca-2eadce71c17mr16467551fa.41.1717763840064;
        Fri, 07 Jun 2024 05:37:20 -0700 (PDT)
Received: from [10.5.1.156] (188-22-218-164.adsl.highway.telekom.at. [188.22.218.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae20238asm2696643a12.73.2024.06.07.05.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 05:37:19 -0700 (PDT)
Message-ID: <0bfc6b38-8bc5-4971-b6fb-dc642a73fbfe@gmail.com>
Date: Fri, 7 Jun 2024 14:37:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Christian Schrefl <chrisi.schrefl@gmail.com>
Subject: [Bug] Failing kunit test on ARCH=arm and LLVM=1
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: kunit-dev@googlegroups.com, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,

when trying to port Rust to ARM I noticed that the DEFINE_FLEX_test
kunit test in lib/overflow_kunit.c:1188 fails when combining LLVM=1
and ARCH=arm.

I have reproduced this on v6.10-rc1 and next-20240606.

Here is the clang/llvm version I'm using:
clang version 18.1.6 (Fedora 18.1.6-3.fc40)
Target: x86_64-redhat-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Configuration file: /etc/clang/x86_64-redhat-linux-gnu-clang.cfg

I have not looked closer at the failure so I'm unsure if this is a
problem with LLVM or if the test case is to speciffic.

Let me know if I should open a issue at
https://github.com/ClangBuiltLinux/linux/issues instead.

Cheers,
Christian

