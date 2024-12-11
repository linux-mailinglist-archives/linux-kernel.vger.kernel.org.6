Return-Path: <linux-kernel+bounces-442067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7049ED787
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D4E28343F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238E82288E5;
	Wed, 11 Dec 2024 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hgs2mhW4"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C1F211A0B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950473; cv=none; b=rWnIX6c8C9Eo7gRJzClaM71TfF0cmNSI2eAjlaj5UJo1kqwF/oIpeUfhZr/vq2greF7Aiv3lUE+Ao1p8xsDTcpNQUZjIVR+nPLwoWX+vjE88VN6I2G6yVeMxYJunTaMqdTmJ8cjF6jd4nEdyETY1C8CqMaE5Qm8fGjaCg2r+gm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950473; c=relaxed/simple;
	bh=M8rBj1IljQtNyRfls9tPtsK1h0RFHLNTVO3V2E4tMqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdQOZKfNiCh51MitXDLEn9gGYq9wOQsPVCEX+UjGktDyznp+5pWHlFuzD3Bm5unO4da+eMV6nTzTCSmxGw0sfWMv0MzuEd48pj1Tr2u7T50SpwvDmrbZ5wem4JU/X446tM4MHO7eGyaS6VRb1IqY2gwvgq5CRJ7TXkzrodELyQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hgs2mhW4; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a77bd62fdeso33616645ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733950470; x=1734555270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdUZxJPlOyqm9HlhNWGKr+g7jlb5DGzBTeX9RjzfBIk=;
        b=hgs2mhW4SyJK0rx3o6qCjz21ixamGYhqQO59pp8VVqz3mDli496Q4PFzOLpEglt9Bn
         pMW5osnn1kzXHc8Ntq+UcICDGxZbg+cxulHkmqlXTlvsNxtitygVia0E65xHo2fMvDD9
         IMmDdF+ZN3H6fhmGs7bYQzV9qjPpKpxxDjwYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950470; x=1734555270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdUZxJPlOyqm9HlhNWGKr+g7jlb5DGzBTeX9RjzfBIk=;
        b=N3Zcns01957aTalAn/xirKilHFBB0B9MAY9ISuCNgAoXSL07kUBLGSKtbDLgyqjBpR
         6lovSpTG0IerkhXV/NJidtru5lphR+qTixHKohyXBi2MdvFs7Jfar5ZBBMxhJhROz3kC
         4HvH3rU9WLSQj3HB/pdLkxDMH8hgXAIR+btdWaW7VCXem3I/4PMAAizlbVJRpkl/ulSv
         RdBowYe9rIqwpjeJqujs7Jl5twI+DQ1yg2tYPpZ/juGmot5cp3Y9LviN8G4dVkOqudcP
         MbVgkWub7S65vgjv7Sb1zohMKk94alP3OIJZrM6BWiUfK+sXgKi3V9nKEXPCntATWaVX
         wsxg==
X-Gm-Message-State: AOJu0Yze8WbwRQOf1hxe8cgkXRCvWfo2hsBHm9xxHFd9u/RR75NodsnI
	7DH6moo2g30xMurz2/MsdoABViEXzZbIB91Lhbb3AenjwFR6O+n0PCa5DiDJreA=
X-Gm-Gg: ASbGnct1gqZGa632Qb16cFeBmnT784YIDGekt+EY6wHzztFI8dXHTRGFgyQCS64XsgA
	nHT/3ZbgmRGT+RdBv8rZsyRQboR+bRxR3+hKE9NYMnv8xJMmCzTDKu4yRRwpHI93f4wB3l+AT44
	h7DQszZmXEHvh4/6NlZuykysYYRWhEgHX+hpJGJC8cLvY4Dc70MilaKHWooq5PDZwhNinVk7hd9
	uB1JbFL+EHrua3ittG8skE+4B+ulCcRVqVIJJsUVj6odbrwhPHEG2GeKrJPE3pbOg==
X-Google-Smtp-Source: AGHT+IFZWSEkNX9E1xvb5Yis84qOQViHxVTlB7kMTpgprOsy8jLaKebBWk2JUnkf5Ygn4PNGztoSvw==
X-Received: by 2002:a05:6e02:1685:b0:3a7:44d9:c7dd with SMTP id e9e14a558f8ab-3ac483fe4bfmr12769875ab.6.1733950470069;
        Wed, 11 Dec 2024 12:54:30 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a816297961sm32619605ab.19.2024.12.11.12.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 12:54:29 -0800 (PST)
Message-ID: <0985bb0c-091e-4e5a-b066-5b9cfd072aa8@linuxfoundation.org>
Date: Wed, 11 Dec 2024 13:54:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: fix TSC MHz calculation for Mperf monitor
To: He Rongguang <herongguang@linux.alibaba.com>, trenn@suse.com,
 shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com
Cc: linux-kernel@vger.kernel.org, shannon.zhao@linux.alibaba.com,
 linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <60562222-6186-4eec-9c20-08b1cebb1311@linux.alibaba.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <60562222-6186-4eec-9c20-08b1cebb1311@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/24 20:20, He Rongguang wrote:
>  From e17f252433c923578e9c386a998200e488d9567d Mon Sep 17 00:00:00 2001
> From: He Rongguang <herongguang@linux.alibaba.com>
> Date: Thu, 28 Nov 2024 16:50:05 +0800
> Subject: [PATCH] cpupower: fix TSC MHz calculation
> 
> Commit 'cpupower: Make TSC read per CPU for Mperf monitor' (c2adb1877b7)
> changes TSC counter reads per cpu, but left time diff global (from start
> of all cpus to end of all cpus), thus diff(time) is too large for a
> cpu's tsc counting, resulting in far less than acutal TSC_Mhz and thus
> `cpupower monitor` showing far less than actual cpu realtime frequency.
> 
> /proc/cpuinfo shows frequency:
> cat /proc/cpuinfo | egrep -e 'processor' -e 'MHz'
> ...
> processor : 171
> cpu MHz   : 4108.498
> ...
> 
> before fix (System 100% busy):
>      | Mperf              || Idle_Stats
>   CPU| C0   | Cx   | Freq  || POLL | C1   | C2
>   171|  0.77| 99.23|  2279||  0.00|  0.00|  0.00
> 
> after fix (System 100% busy):
>      | Mperf              || Idle_Stats
>   CPU| C0   | Cx   | Freq  || POLL | C1   | C2
>   171|  0.46| 99.54|  4095||  0.00|  0.00|  0.00
> 
> Fixes: c2adb1877b76 ("cpupower: Make TSC read per CPU for Mperf monitor")
> Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
> ---
> Changes in v2:
> - Fix scripts/checkpatch.pl style warnings.
> - Link to v1:
> https://lore.kernel.org/linux-pm/269b8bb2-85b5-4cc9-9354-a1270f2eed35@linux.alibaba.com/T/#u
> ---

Are you sure you sent me the right patch. I am seeing exact
same errors. How are you sending your patches.

Here are the problems I am seeing:

ERROR: patch seems to be corrupt (line wrapped?)
#103: FILE: :173:
double *percent,

WARNING: It's generally not useful to have the filename in the file
#108: FILE: :177:
+		timediff = max_frequency * timespec_diff_us(time_start[cpu],

WARNING: It's generally not useful to have the filename in the file
#119: FILE: :210:
+		time_diff = timespec_diff_us(time_start[cpu], time_end[cpu]);

WARNING: It's generally not useful to have the filename in the file
#130: FILE: :230:
+		clock_gettime(CLOCK_REALTIME, &time_start[cpu]);

WARNING: It's generally not useful to have the filename in the file
#138: FILE: :245:
+		clock_gettime(CLOCK_REALTIME, &time_end[cpu]);

WARNING: It's generally not useful to have the filename in the file
#149: FILE: :351:
+	time_start = calloc(cpu_count, sizeof(struct timespec));

WARNING: It's generally not useful to have the filename in the file
#150: FILE: :352:
+	time_end = calloc(cpu_count, sizeof(struct timespec));

WARNING: It's generally not useful to have the filename in the file
#158: FILE: :365:
+	free(time_start);

WARNING: It's generally not useful to have the filename in the file
#159: FILE: :366:
+	free(time_end);

thanks,
-- Shuah


