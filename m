Return-Path: <linux-kernel+bounces-260569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC093AB04
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CC02840EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C891617753;
	Wed, 24 Jul 2024 02:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S7eFaVoy"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFBDFBE8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787352; cv=none; b=YH2GmvtQoJspC//noh1oPIZobUH4C7psfhclHVK6YTPI4f6PXBWkxWE5kf1pSXMGzzaYs4OYNyvHHyNsIm6hEksx+xZMQIk8GYO9eo7hOrYBa1JvAEtJ11VMjnQW5elVeEG0hUF5REVvqnMEbsGJWPU4IO9Rbp/THvlyyR9r5fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787352; c=relaxed/simple;
	bh=P8nJD/KCxvmfMwVMcqrmGqdyW0isPDerLmymcyVqRRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SG9b4jH0n1amyYGxqW3RG2383Pwu8F8Cf33l44Z1HvC5zXy4+8PDEaC+DHHCFOAgI+TUJjS0TAYDT2lqz5tlq//Sal8Lm0wZjz2FKeMkyYu//63SdLTHrNxc6X/WvsiSs1W5r5OU7PzKPr5rXTBiUT/rRljJHnxbBvA6XN6v5ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S7eFaVoy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-368557c9e93so3257672f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721787348; x=1722392148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AuL3FeXguAc3+nsOmwfYctvgsfwgCdqQEo9r6jM+fEY=;
        b=S7eFaVoyARQhFJtNfyWaw1gBdijx43tbSnEoOzoytdDKlls5u1R1L/jgJE72IyfjrT
         1fP8TWxYfewCA/9+JD5BeZ0oyuAIBDomtY2Ji6aDf5x8DEm1xrRe+jVczuzCOZnY5/xD
         vDSCXLW8PPPDucjxJU8C2B9R9uw/Dv6afUQOS0wW6rCex181fPGu9Myvso3YdODHq7al
         TZSU9esKt0X2NpZCS7FB0+C4C55/hT4GS6y5+K8vcIndWfaF6mawiKi2SvWm/4STMdTQ
         sjF/q4ezpvJSi9ZftjkNfwPE+PMEAwkvd3/Durta9nXuWKMSz7/ifLB92onTVwii2Gp5
         LZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721787348; x=1722392148;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuL3FeXguAc3+nsOmwfYctvgsfwgCdqQEo9r6jM+fEY=;
        b=laK4l2IWeDDHYb/K0SHjYwdWx5PfzN8algMMKFcMXeZ1BEdzuWq5yYlYEZG8K5gAwh
         B16q1GwSZaPHqGUcE/a9EPlwgb9mYRgOXLOnZUVcHkH5FhATcKOwA9efbC04/ua7MvNR
         uNFd6HkXc5woie2FTSWbrJ4AsoUct9OMZJJV+Y4MkaWUJWkTmEFFmmkg2VVVYu5PLooL
         CR7GKMSMp9S3L96hwA1frJgvmzE9IfAshUCM5r834CKC2/WcwlUBKWWEEmrXHl5L3dcI
         laxBLfyWHuOWWfHewaI7tz+99JFFV++Cxzda4p24dpexQxBJHAZnJuEYbc+5fYLx/Jc4
         piOg==
X-Forwarded-Encrypted: i=1; AJvYcCWvy4ELCGF2yqLexpadHp4YiV4G08LPxr1tTLbLEeTonvrH8N99uB54S7hhVOoxBknTJHINjqoBeRAMlqMpQPN/5Lo2rAaTEkbI+/61
X-Gm-Message-State: AOJu0Yy8IVFzG/pLUgqpdl7pJMFA/yYBArknT6JE273UYqZhbIhJT9+d
	+LAExeqSqOzzHm9/OLYkA1NNnIXO7xOunwPPS5NRRgs5Au83mCTeutrIT9yHEB8=
X-Google-Smtp-Source: AGHT+IE8dfzosmeGNaj2NcATW/WIv8dUgyfRE7zu3fpXUy9Q21glx3UbR4TnIDdzH3lCV6WzKEYMXQ==
X-Received: by 2002:a5d:51cb:0:b0:368:7f8c:1b38 with SMTP id ffacd0b85a97d-369bae248e1mr6407008f8f.30.1721787347638;
        Tue, 23 Jul 2024 19:15:47 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31bd9bsm82370295ad.157.2024.07.23.19.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 19:15:47 -0700 (PDT)
Message-ID: <fbe7c1cd-ff4f-4252-baf2-88d3c5e50fdc@suse.com>
Date: Wed, 24 Jul 2024 11:45:42 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fs/btrfs/lzo.o: warning: objtool: lzo_compress_folios+0xb0:
 unreachable instruction
To: Philip Li <philip.li@intel.com>, kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <202407232006.7Gelsbv4-lkp@intel.com> <ZqBgvYYl154a+bV6@rli9-mobl>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <ZqBgvYYl154a+bV6@rli9-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/24 11:32, Philip Li 写道:
> On Tue, Jul 23, 2024 at 08:18:41PM +0800, kernel test robot wrote:
>> Hi Qu,
>>
>> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   66ebbdfdeb093e097399b1883390079cd4c3022b
>> commit: 400b172b8cdcff87038697169fe9e4222120dd9a btrfs: compression: migrate compression/decompression paths to folios
>> date:   3 months ago
>> config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240723/202407232006.7Gelsbv4-lkp@intel.com/config)
>> compiler: loongarch64-linux-gcc (GCC) 14.1.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240723/202407232006.7Gelsbv4-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202407232006.7Gelsbv4-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
> 
> Sorry, kindly ignore this report which could be related to tool chain upgrade to
> loongarch64-linux-gcc (GCC) 14.1.0.
> 
> We will further check whether the issue can be reproduced on gcc-13.

Gcc 14.1 is totally fine, as that's the version I'm using already 
(although a little newer, 14.1.1)

It would be even better to focus on more common architectures first 
(x86_64, aarch64), and put a lower priority on less common architectures.

As most developers are not really able to access those platforms easily.

Thanks,
Qu

> 
>>
>>>> fs/btrfs/lzo.o: warning: objtool: lzo_compress_folios+0xb0: unreachable instruction
>>     fs/btrfs/lzo.o: warning: objtool: lzo_decompress_bio+0x140: unreachable instruction
>>
>>
>> objdump-func vmlinux.o lzo_compress_folios:
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
>>

