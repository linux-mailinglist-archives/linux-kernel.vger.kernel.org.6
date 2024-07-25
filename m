Return-Path: <linux-kernel+bounces-262414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3329D93C6C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9681F2617C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573BF21A04;
	Thu, 25 Jul 2024 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dBFEZjjP"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948F119D08A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922474; cv=none; b=T+cuarADcli5/LtPbx01pvhokjJtEC6UZXkaVUUHEvkQb1edGrXECA2/WrXON4yh6PGKjeKY5jfoHTQq56MTIAThDEemRSm75B2bIGZpWocC4DYe7KxYJwsmyUfMhm5ASmcOhzBNyoN3omDmtg5aSANJLMfzCkkePGUfO2OeTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922474; c=relaxed/simple;
	bh=a6L0odqZVwjkz0+te8beRwJPik4vgylRtT86OIwZmeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RoyMkuYAsr8r8EuNgfDtxTTtjUkRFJInqqPZeDJ34MixGiLQvZ6lK+rglN26QwTz5UXSgfMjCDmdKGVRod4JSERjA+AAjkRH8bO6yLgHS1wxqpoXe2kzfHPvBW0Wo3co+RpD/GFAW8G5YfMqAAAnsDzNmdkI8UTSYb3yk4eUz1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dBFEZjjP; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81f861f36a8so1980139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721922470; x=1722527270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NY/wK/SC2b9qRhcTcT3biDroJ9aSTfxnDkIOXmpCheI=;
        b=dBFEZjjPrqY5pf1vPa/EqAEyoTQVoo+PR/RXbHjpgOB0yAoHu0etSt6NzEBp5K5/yr
         kUxEQ7MhRje48MtNzdcTK3To6zBwwz2JlkqzWHjhrxbI5PqySfZ0M3lULvBRD0y9EpQr
         GrkAsFoZGiXLS/+CPrcJ4DROXFY0k3XSsrz9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721922470; x=1722527270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NY/wK/SC2b9qRhcTcT3biDroJ9aSTfxnDkIOXmpCheI=;
        b=v6AOF0Ga6l4fCf9efAp8lyfOrPM5HlUY7dm+fftHcTZPP1KnjdUdMPZ6griinGHVb6
         N4tK8gFdM7l6O9KKX6ter8pBSakze/cKPzc0xe2xMaxtu+ob6AAw6HzXaEbHmeCJ1jQ5
         Bfk+Lcc8jID9bBCC0t7PfS+1gJRunfT32y8KBfYLPfTMsDJTaQFiCmGWQ3VPkL2D4wko
         mbOeQivznGkBDz/lDg+Dlu+Qir1mWZwlkkCKlFikmZU8sSak6kEJFCHLAfBdEH0DjtvE
         rPvm7bbRny8TlVmNNELfdOGucE4Qq9OOkGcQTCCCXEps4MuJ4ILFpsvfF56uZwM7GJOc
         W6+g==
X-Gm-Message-State: AOJu0YyCT7e417jsn3Ry/AnpqU3HMiP5mA7TPKAMUjywlV5aH3qhxZBi
	FnIVP+EBXX9mZHENsWZ6tr7A1cniwXYc9m+Z1+iQje4DEDRwW3pSxY0VaSKg0uU=
X-Google-Smtp-Source: AGHT+IFumxL+NQewlVU6VWvbnkaABDGEKgAZN3NMaqG5tjXbRd/nh/urjJZNUu6iIk/u0UMcs0HeDg==
X-Received: by 2002:a05:6e02:156e:b0:38e:cdf9:601b with SMTP id e9e14a558f8ab-39a22d399fbmr20010045ab.4.1721922470594;
        Thu, 25 Jul 2024 08:47:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22ea5fd4sm6830685ab.48.2024.07.25.08.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 08:47:50 -0700 (PDT)
Message-ID: <9bffb45a-7b06-498f-b168-c68506cb82ea@linuxfoundation.org>
Date: Thu, 25 Jul 2024 09:47:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Add kselftest to detect boot event slowdowns
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel@collabora.com, kernelci@lists.linux.dev, tim.bird@sony.com,
 mhiramat@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240725110622.96301-1-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725110622.96301-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 05:06, Laura Nao wrote:
> Add a new kselftest to detect and report slowdowns in key boot events. The
> test uses ftrace to track timings for specific boot events and compares
> these timestamps against reference values provided in YAML format.
> 
> The test includes the following files:
> 
>    - `bootconfig` file: configures ftrace and lists reference key boot
>     events.
>    - `config` fragment: enables boot time tracing and attaches the
>      bootconfig file to the kernel image.
>    - `kprobe_timestamps_to_yaml.py` script: parses the current trace file to
>      extract event names and timestamps and writes them to a YAML file. The
>      script is intended to be run once to generate initial reference values;
>      the generated file is not meant to be stored in the kernel sources but
>      should be provided as input to the test itself. YAML format was chosen
>      to allow easy integration with per-platform data used in other tests,
>      such as the discoverable devices probe test in
>      tools/testing/selftests/devices. Another option is to use JSON, as the
>      file is not intended for manual editing and JSON is already supported
>      by the Python standard library.
>    - `test_boot_time.py` script: parses the current trace file and compares
>      timestamps against the values in the YAML file provided as input.
>      Reports a failure if any timestamp differs from the reference value by
>      more than the specified delta.
>    - `trace_utils.py` file: utility functions to mount debugfs and parse the
>      trace file to extract relevant information.
> 
> The bootconfig file provided is an initial draft with some reference kprobe
> events to showcase how the test works. I would appreciate feedback from
> those interested in running this test on which boot events should be added.
> Different key events might be relevant depending on the platform and its
> boot time requirements. This file should serve as a common ground and be
> populated with critical events and functions common to different platforms.
> 
> Feedback on the overall approach of this test and suggestions for
> additional boot events to trace would be greatly appreciated.
> 

You don't need a cover letter for a single patch btw.

Please take a look at the tools/power/pm-graph
bootgraph.py and sleepgraph.py to see if you can leverage
them - bootgraph detects slowdowns during boot.

> Example output with a deliberately small delta of 0.01 to demonstrate failures:
> 
>    TAP version 13
>    1..4
>    ok 1 populate_rootfs_begin
>    # 'run_init_process_begin' differs by 0.033990 seconds.
>    not ok 2 run_init_process_begin
>    # 'run_init_process_end' differs by 0.033796 seconds.
>    not ok 3 run_init_process_end
>    ok 4 unpack_to_rootfs_begin
>    # Totals: pass:2 fail:2 xfail:0 xpass:0 skip:0 error:0
> 
> This patch depends on "kselftest: Move ksft helper module to common
> directory":
> https://lore.kernel.org/all/20240705-dev-err-log-selftest-v2-2-163b9cd7b3c1@collabora.com/
> which was picked through the usb tree and is queued for 6.11-rc1.

This tool does need some improvements based on the thread
that includes skips.

> 
> Best,
> 
> Laura
> 
> Laura Nao (1):
>    kselftests: Add test to detect boot event slowdowns
As mentioned earlier take a look at the tools/power/pm-graph
bootgraph.py and sleepgraph.py to see if you can leverage
them - bootgraph detects slowdowns during boot.

We don't want to add duplicate scripts if the other one
serves the needs. Those can be moved to selftests if it
make sense.

What are the dependencies if any for this new test to work?
Please do remember that tests in default run needs to have
minimal dependencies so they can run on systems that have
minimal support.

> 
>   tools/testing/selftests/Makefile              |  1 +
>   tools/testing/selftests/boot-time/Makefile    | 17 ++++
>   tools/testing/selftests/boot-time/bootconfig  |  8 ++
>   tools/testing/selftests/boot-time/config      |  4 +
>   .../boot-time/kprobe_timestamps_to_yaml.py    | 55 +++++++++++
>   .../selftests/boot-time/test_boot_time.py     | 94 +++++++++++++++++++
>   .../selftests/boot-time/trace_utils.py        | 63 +++++++++++++
>   7 files changed, 242 insertions(+)
>   create mode 100644 tools/testing/selftests/boot-time/Makefile
>   create mode 100644 tools/testing/selftests/boot-time/bootconfig
>   create mode 100644 tools/testing/selftests/boot-time/config
>   create mode 100755 tools/testing/selftests/boot-time/kprobe_timestamps_to_yaml.py
>   create mode 100755 tools/testing/selftests/boot-time/test_boot_time.py
>   create mode 100644 tools/testing/selftests/boot-time/trace_utils.py
> 
> --
> 2.30.2
> 

thanks,
-- Shuah

