Return-Path: <linux-kernel+bounces-379047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B2D9AD903
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3139E1C21484
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBA1BA4B;
	Thu, 24 Oct 2024 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GGw7VJnP"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2A02C9A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729731186; cv=none; b=bQydEfTV7ZzH+5kUWNirLN86eLaf9L364GZGFwdByAG6yECatopXrgdaQ/t3h8pM3knW5VAxMErQxMfMzyafC7BCZvMxZEazMDA7G7/WxAEygSgLWFpqdze57zGTxZw9GDuTznonvdU4lIJK0DlvqQTHnv6ujbzydUKbkqFHuYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729731186; c=relaxed/simple;
	bh=g6MY8tx7hAUiyrxqD7Kvef4097w0WwcKT1GklYmOwM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2xkNxpfN7eoL8RRHlvHYLLEcbr6zBbb63Bu4KZzsIFkWC5xkqN3i2Ifurzf3P8NlC/DHj5zZ7GqaC5RbZxBMy+m6kkB+UkhI/K7erYA9ui5Wbqy2S4HD2MX9R2EgSsnve69ILmIgYILEzqouUg3OQKjVRPDu9hJI0Aqmr99AAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GGw7VJnP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d51055097so213170f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729731182; x=1730335982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nIJWyB8BsS3cplKl7XBD0w2FsVtewGZEqkBOiok0vMQ=;
        b=GGw7VJnPNqSC9EyJXcNe73koNm0IFg09FuYi2M0ZLdiV6K0PFIyYpYjSr9+qPV4+T7
         eHYyj5P+T2FFN4wmdaGllFu7rwedKS1YeS7CLpHgNGTIaXMm294cBfnBIz/ihScAnIPH
         GIBsVB4Wje1m2DlKVSTPyhBN1NIK6bek/dZlQydbNNlTPnNL83uJIxgI2ySheqUappKU
         7jhe6VV6asSMiSxd9MrVDJzBirVFPr/q2j+7SPNaW9CHrMAdJ3hvuPIwd+WdLphLDDH0
         d/t8emI7YBRKLAJTS0N8Mfj0HJybJxHmMa+AJ3W518RyCAln8qskmIkegcRCc+WpBVva
         d7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729731182; x=1730335982;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIJWyB8BsS3cplKl7XBD0w2FsVtewGZEqkBOiok0vMQ=;
        b=eB3FtHgJ895cjcfpobiaPu90wQGHLuk3ezp+ehjsDdzfTpEIWjH35PIsLwP5RZOgod
         BAzA3rK8OOm9/EgbkP1kaXtnXBpJN0Yg3ILNU5EB8SSvJva2P3S1Jd0W8R5iZphmSXDB
         zAIvjF/XNSyTLQtau/tGPXxhHip0qcxaJKgzohXO4xbYEnP/8fGCi9wJ/rgBkX4gW5T8
         UOgeeKswkBl18q8xHGe2TUDbmAy4BrHOOEKb76jvzHaHjbDz0LE4zqDVpwFd+bx2G4Fq
         WWxOmMXDq2hnwtJxsQvqVHJ+zQ/+5nd3Aqf7p4mJxHL7sHufxFC2H0VioMDunot8aJO8
         Puvw==
X-Forwarded-Encrypted: i=1; AJvYcCWgc10kDkZ/4hLkMRrZlyBO+GCX9AogKAkiizUqvupDpKIcdx3FjSJz3unYRpstYM7ulcCcKIh5ne3fNvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD8sqgHl2wBN7kW20RKzTaZtxC2fnSZVPeMtiVBIu6tFqXnV9U
	oAOi8nSAnCsyVGL2F5KTtphUn9pTkW52R5/wXNomzgLZLDvBmy7q8NKmR+1mijk=
X-Google-Smtp-Source: AGHT+IHh8b50957ZJb3xmgqP8ldMn4gVL80KwpZGyKO8b84mjt+bpYegvWC2zSamdfxuzgozePEJBw==
X-Received: by 2002:a5d:410d:0:b0:37d:50ed:daa8 with SMTP id ffacd0b85a97d-37efcf0b517mr2619319f8f.18.1729731182274;
        Wed, 23 Oct 2024 17:53:02 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabd9bebsm6411965a12.80.2024.10.23.17.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 17:53:01 -0700 (PDT)
Message-ID: <1ecd327d-108d-427a-b964-da46b0496088@suse.com>
Date: Thu, 24 Oct 2024 11:22:57 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the btrfs tree
To: dsterba@suse.cz
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, David Sterba <dsterba@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20241024085701.64263a3b@canb.auug.org.au>
 <95af7735-cb97-491c-be22-8e9759f4720f@suse.com>
 <20241024004729.GF31418@suse.cz>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20241024004729.GF31418@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/24 11:17, David Sterba 写道:
> On Thu, Oct 24, 2024 at 08:58:58AM +1030, Qu Wenruo wrote:
>>
>>
>> 在 2024/10/24 08:27, Stephen Rothwell 写道:
>>> Hi all,
>>>
>>> After merging the btrfs tree, today's linux-next build (x86_64
>>> allmodconfig) failed like this:
>>>
>>> fs/btrfs/super.c: In function 'btrfs_reconfigure_for_mount':
>>> fs/btrfs/super.c:2011:56: error: suggest parentheses around '&&' within '||' [-Werror=parentheses]
>>>    2011 |         if (!fc->oldapi || !(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
>>>         |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> cc1: all warnings being treated as errors
>>>
>>> Caused by commit
>>>
>>>     4642e430c55b ("btrfs: fix mount failure due to remount races")
>>
>> My bad, in fact a new patch is going to remove the oldapi check
>> completely as newer mount using new API will break the per-subvolume
>> RO/RW again.
>>
>> Thus a new patch is needed to remove the oldapi check first
>> (https://lore.kernel.org/linux-btrfs/e1a70aa6dd0fc9ba6c7050a5befb3bd5b75a1377.1729664802.git.wqu@suse.com/),
>> then the newer v2 patch
>> (https://lore.kernel.org/linux-btrfs/08e45ca0-5ed9-4684-940f-1e956a936628@gmx.com/T/#t)
>> will be completely fine.
> 
> I probably missed the v2 and picked the patch with warning that I did
> not consider too serious but it seems linux-next builds with -Werrror.
> Meanwhile I've updated the for-next snapshot branch and dropped the
> patch.

I'd prefer to pick the v2 and its dependency ("btrfs: fix per-subvolume 
RO/RW flags with new mount API") for early testing.

As I'm pretty sure the rolling distros are already rolling out new mount 
using the fsconfig API, and breaking our per-subvolume RO/RW mount.

The promise that new mount API will solve the per-subvolume RO/RW 
without reconfiguration is mostly a lie.
The reality is, RO mount is still passed with both 
fsconfig(FSCONFIG_SET_FLAG, "ro") and  mount_setattr(MOUNT_ATTR_RDONLY), 
doing exactly the same thing as the old mount.

Thanks,
Qu

