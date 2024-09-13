Return-Path: <linux-kernel+bounces-327964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C7977D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569B51C20E29
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731B51C2422;
	Fri, 13 Sep 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vE2plQ85"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA0518BC20
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222822; cv=none; b=dEQNjha8lakv2kSBws7tXy4WHzdFdB06/hKiUrhUpogfFqUa21HdaThmBSBZxv81EbMx03oJSnYBwLf29IbxdEO/FaHP15BVTy3J+e31bByDdTR2o2ldS0hXkZWi63vZt97/2GimubZW5hNzrzPZsUSilBsADqdb2aoZwPlroL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222822; c=relaxed/simple;
	bh=+a8dHCpcOKdPblR+icDGIFbRfJiKQRh9zmI9229E+lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTbvxgjTjSb2dKEvF4QAhG56lI+dukF7KqEWGkT8J4O+cb7HqZQD4SbWMINY/Ji7zk3fNzSEd4/RRJMLrmCLganlQerCxKXvXPwh5C8p1OayMpBlAi6b8/mkIc4ikPp23Jbuw4CeiK6R7IkM2i0Zibux7uydvIC+bFRywmDuzFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vE2plQ85; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so18880355e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 03:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726222819; x=1726827619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/UmlrqFmFGfqE/2SG7iQXFLt1xw4r5tdaO/8FXG+IYI=;
        b=vE2plQ85Kb3ya5mEsJpKDQsSvlfvxkkQCBlkvDDUUi7MQE7zQ1+HVMIOzlKH1ZDRqG
         6xXnQ+hXavH2eYqH7TpVVUe/xlbqeY3gPt4gGq47IecFQrXcG+z1Bewt+bZk5Kj0A182
         k4b/21fE+QJcmrZckgPSs1BELE01KzlDolkUkY/5x8VakMsW2yFALoIBq9GPVfzsX4aD
         thB9ywSg2zzf0zx5r/7WtgYiqxLi3aZmqydGZ7V2gwmcW4tg6g80tA5sQ4wu59mDeU6i
         woFPXralLAd0V5hlezVv/ezOujW55ZJ0YxqBxrieBX49wd9K0apcDsCq0wgvlp4Zjt3v
         7umQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726222819; x=1726827619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UmlrqFmFGfqE/2SG7iQXFLt1xw4r5tdaO/8FXG+IYI=;
        b=n+rKzZ8U2+2O+UM+dSi9qUWBAxQamcUlIPPy15AGJeJ1JrPzp7AUYNFAX5zLqw4grL
         uTMkrusqGXDKAVl09RIra4CQIhdKb27NzQ+QGOa1b4S3v5cjpA1AacRgt5DoovBHU01i
         YNwXsuhmoaNWeSXyZf23gkk3dhvdC886t0H1bY8hG26vPqtq50XLyoR1QltJ62NgONYD
         zNDro4+Zq+ZEO78LT4EE/xpnYXM+gKd1i73DNStgtjySC53r4kL8T7zmgiLuwPxaHpnx
         yVnhPJ+YpdgXInDj6VPAR5dfDYC2xhmWiYGPZz7HYGVC8TMVzzyft5v6ElsFhd2H4ZR9
         Yd7A==
X-Forwarded-Encrypted: i=1; AJvYcCUGbxbUNAjmI6Jp+72RbJZd13MCoUgJ5x/aqJSzYTwO/AQ4IwU6qHyGL4Jt2WBHty1wpu1hWyGSeIsYnBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLuG3UI/OqKV5cxeRzALLigIruo+Fc6Oi3oLmMUO9fFD1HV+hu
	6rrAx7VEL3BYdd3IxnEA05ltFZmLBFfU4qfbqWTIpglzrjcJm41xeQkzp7E2lCY=
X-Google-Smtp-Source: AGHT+IFhB5EyB/CfUyNt8iViwsCYv0St/esuI7Acf2pdZ8K8lLzJYDgZXj+Sq5blNB5V9TXvy/DuXg==
X-Received: by 2002:a05:600c:548a:b0:42c:bc60:5332 with SMTP id 5b1f17b1804b1-42cdb54eda5mr40853065e9.19.1726222818809;
        Fri, 13 Sep 2024 03:20:18 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01d3d17sm105403095e9.0.2024.09.13.03.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 03:20:18 -0700 (PDT)
Message-ID: <49fe18ff-827a-429b-9d74-9d8ed02ac409@linaro.org>
Date: Fri, 13 Sep 2024 11:20:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf build: Require at least clang 16.0.6 to build
 BPF skeletons
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
References: <ZuGL9ROeTV2uXoSp@x1>
 <caad2d84-a8ff-4304-b8ab-04642ea18323@linaro.org> <ZuL_0V5jgaaEUOY_@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZuL_0V5jgaaEUOY_@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/09/2024 15:50, Arnaldo Carvalho de Melo wrote:
> On Thu, Sep 12, 2024 at 03:40:32PM +0100, James Clark wrote:
>> On 11/09/2024 13:24, Arnaldo Carvalho de Melo wrote:
>>> Howard reported problems using perf features that use BPF:
> 
>>>     perf $ clang -v
>>>     Debian clang version 15.0.6
>>>     Target: x86_64-pc-linux-gnu
>>>     Thread model: posix
>>>     InstalledDir: /bin
>>>     Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>     Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>     Candidate multilib: .;@m64
>>>     Selected multilib: .;@m64
>>>     perf $ ./perf trace -e write --max-events=1
>>>     libbpf: prog 'sys_enter_rename': BPF program load failed: Permission denied
>>>     libbpf: prog 'sys_enter_rename': -- BEGIN PROG LOAD LOG --
>>>     0: R1=ctx() R10=fp0
>>>
>>> But it works with:
>>>
>>>     perf $ clang -v
>>>     Debian clang version 16.0.6 (15~deb12u1)
>>>     Target: x86_64-pc-linux-gnu
>>>     Thread model: posix
>>>     InstalledDir: /bin
>>>     Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>     Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>     Candidate multilib: .;@m64
>>>     Selected multilib: .;@m64
>>>     perf $ ./perf trace -e write --max-events=1
>>>          0.000 ( 0.009 ms): gmain/1448 write(fd: 4, buf: \1\0\0\0\0\0\0\0, count: 8)                         = 8 (kworker/0:0-eve)
>>>     perf $
>>>
>>> So lets make that the required version, if you happen to have a slightly
>>> older version where this work, please report so that we can adjust the
>>> minimum required version.
>   
>> I wasn't able to reproduce the issue with either of these versions. But I
>> suppose it could be an issue with only 15.0.6.
> 
> Interesting, that complicates things, probably the best way then is to
> try to build it, if it fails, mention that 15.0.6 is known to be
> problematic and suggest working versions?
> 
> - Arnaldo

I still wasn't able to reproduce it with 15.0.6. And I double checked 
with V=1 that the build was using the right clang. I suppose it could be 
a build configuration issue, or maybe with a different kernel version?

$  uname --kernel-release
6.8.0-76060800daily20240311-generic

$ ../../llvm-project/build/bin/clang -v
clang version 15.0.6 (https://github.com/llvm/llvm-project.git 
088f33605d8a61ff519c580a71b1dd57d16a03f8)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/james/workspace/linux/linux/../../llvm-project/build/bin
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/11
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/12
Selected GCC installation: /usr/lib/gcc/x86_64-linux-gnu/12
Candidate multilib: .;@m64
Selected multilib: .;@m64

$ git log
commit 003265bb6f028d7bcd7cbd92d6ba2b4e26382796 
(perf-tools-next/perf-tools-next)

$ make O=../build/local/ CLANG=../../llvm-project/build/bin/clang -C \
   tools/perf

$ perf trace -e write --max-events=1

      0.000 ( 0.026 ms): gnome-shell/5454 write(fd: 5, buf:
        0x7fffa102d9b0, count: 8)                           = 8


