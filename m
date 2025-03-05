Return-Path: <linux-kernel+bounces-546235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BE8A4F82C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625F93A47A6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B771F419A;
	Wed,  5 Mar 2025 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rgm7zUuT"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9A1F153A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160665; cv=none; b=qUcb0fk4HFtcteF3WH7NoxWal2H3sJSXpyGFGnzEqswPgYlY3Nsl94r7Aabvax2hW3Bax2TW5uRjubvaan+OuDKLztS0I6T+LPHdqF9JHH6AobkdIEJd/SjflM3iZ5ScjBY3/Rq4nRf0ITkfM+rY0oUFWBoQnNSwPr/q6ypH5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160665; c=relaxed/simple;
	bh=UrNgFfuy70+VwkPgxKQZ6ZdnvRh29b6/odukdfgIbj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=howndhzp3ExNynFlGB6IpONREoQxhYdNLXmKe4u3YwsxNJGFvcdmh5b8gAuOVv2/JslPDeJSluYgygBeqwvtfgxyMndYtzOdXyn+WqV3sPHInbFoMQMBbxteRe+gOBzOFhilaSjFrfm8zwazCNbHnpOVGUFIEt98PfX1Op4t05A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rgm7zUuT; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac1f5157c90so264444466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 23:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741160662; x=1741765462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1nldCz0GLZ3kYSpyVKXApLHSDBz6vCT9Ad7Pgzjf9wI=;
        b=Rgm7zUuTz+aU+Zkl3TcTyDR40rknetSkopNPCj/oSmxLfT35JjLSfnqAIQxD9gGFzs
         uDp5wuq34Gl1gVeC2LyMxLVy738NuD1kchn2SYU8qZBFdFGLoG6CbWoLuSKO0bt1QxGZ
         WNVVRVPRZ3O/FPz1mIaFdr7i6cHPJeQpSJnxVhyYzmEBXSIYabPJsbSLN+SKoiASpLEH
         Bjh1+ZA7jF19zBzw6kzKKOQVf0Vy6oc3J4crZD8MVTbwi3XghH7vSWXpmGWwzZfguYfV
         R/Y2XjjHDTUPTNFCN1PLz1U6sOSEfM95KxLDLZ0kUKygW85trDx1LL4lThhTgC89sFJr
         up7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741160662; x=1741765462;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nldCz0GLZ3kYSpyVKXApLHSDBz6vCT9Ad7Pgzjf9wI=;
        b=pSTWEa8aF+tE8tMEPJ/W/IEl0em5h1RL+OBDpJQvxgOIUsjedmO5dOV8RLO9k4QDGN
         ZjGA9FVzuL1ev0SJ3UIASr+FYruAkei64NskgrGpAuhU5ja4qiAn1IRTpzYs4M9iC/Kr
         77JTC5m2yeQkXN+N5ltmT9bche9bH1yQ/u588E2U24+Xt1tTQz/imMKUJooZjjozhKaL
         pFb4Jvhm96UjyxBHGx6DN3y59NY4pCjF0go0TIF/Zj1H6qlogJAhgX7vPDwP7DFrNKrS
         IFIiPnzEPq8Je4ijpqLtF436B7DuDwH4B/8DLehkUlA0PuoFnrpitXNqGSzYjCCSFewR
         ti2A==
X-Forwarded-Encrypted: i=1; AJvYcCXjiHrN0wd6LUbonkt/fVyc1UaLpfxwfahaho569ePHwx0xNiKhAVvGVTlQ6LA3Hd8baz89nj1cC3ymgV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF/8yxHXVMcBkOh6TruBUYPGLJ07nNVQD1IQQZ5ixgLGT5aCK5
	V+ZBvjdObeszoTrIFaSYc/F/29n+8dPpRv+lyBulMH+AHRsMWrM+W2JSYIzFUII=
X-Gm-Gg: ASbGncvBQKCxs1PchUE2lJVJ7wVaynllAhRmPbOWtjD3rfkeI7IKMykdHR5qx/BbyL0
	GQAEnlK9W5ac9RISbVZvyLs/Z5P8fUamUCGJhmRBRWQNcWODuK91JpuXC2gsOx8agk1SMi+iNCi
	5S4mZ1ZsgpTJZlK4QL4vEZz+PBDHPgCizpVOowR/7+GbM7+ox5hQj7yu3X4lG5dAdFDvOB7+4B0
	LhwyJ7wVYW8RfdDFKDS2ps9aGP3s44eM0q3fcJv0LuUhDKpS7JIFKh+oZS8eJL/MOVpp3EGm3IU
	NHmXAStbfsIOP8gHJMqay36ip9jNOkFrqOnye/LWbzjgW5zJtslLQXqYW9fcxq668XUFiQiR
X-Google-Smtp-Source: AGHT+IEDD9hLz++jtkr7mot50/VoADnGAIUOd5CuyJMU3KXlvgUIQG53kvXGhMENiPlw/k2p22uueg==
X-Received: by 2002:a17:907:6d0f:b0:abf:d4a9:a09d with SMTP id a640c23a62f3a-ac20e02de81mr213786066b.47.1741160661447;
        Tue, 04 Mar 2025 23:44:21 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350529edasm107223195ad.230.2025.03.04.23.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 23:44:20 -0800 (PST)
Message-ID: <29ec66bd-27a0-443e-b19b-fb759a847dcb@suse.com>
Date: Wed, 5 Mar 2025 18:14:16 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/defrag: implement compression levels
To: Daniel Vacek <neelx@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250304171403.571335-1-neelx@suse.com>
 <bc3446ce-347f-41da-9255-233e2e08f91c@gmx.com>
 <CAPjX3FcZ6TJZnHNf3sm00F49BVsDzQaZr5fJHMXRUXne3gLZ2w@mail.gmail.com>
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
In-Reply-To: <CAPjX3FcZ6TJZnHNf3sm00F49BVsDzQaZr5fJHMXRUXne3gLZ2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/5 17:32, Daniel Vacek 写道:
> On Tue, 4 Mar 2025 at 22:31, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
[...]
>>
>> I am not familiar with the compress level, but
>> btrfs_compress_set_level() does extra clamping, maybe we also want to do
>> that too?
> 
> This is intentionally left to be limited later. There's no need to do
> it at this point and the code is simpler. It's also compression
> type/method agnostic.

You're right, the level checks are done in the compression path already.

[...]
>>>        /* spare for later */
>>>        __u32 unused[4];
>>
>> We have enough space left here, although u32 is overkilled for
>> compress_type, using the unused space for a new s8/s16/s32 member should
>> be fine.
> 
> That is what I did originally, but discussing with Dave he suggested
> this solution.

Normally I would be fine with the union, to save some memory.

Maybe I'm a little paranoid, but the defrag ioctl flag check is only 
introduced last year by commit 173431b274a9 ("btrfs: defrag: reject 
unknown flags of btrfs_ioctl_defrag_range_args").

So it's possible that some older kernels don't have that commit, and may 
incorrectly continue by ignoring the flag.
Thankfully that should fail with -EINVAL (type always in the higher 
bits, thus always tricking the NR_COMPRESS_TYPES check.

If that layout (type in higher bits, level in lower bits) is 
intentionally, I'd say it's very clever.

Anyway either solution looks fine to me now.

With that commit message fixed:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> 
>>
>> Thanks,
>> Qu
> 


