Return-Path: <linux-kernel+bounces-310974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E96968377
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 631E6B23518
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBD01D2790;
	Mon,  2 Sep 2024 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VKHEjSrh"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C26C179654
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270067; cv=none; b=oKqELwfUfEcBlZKrtoxygrij4qyHvOFUFYLmpw1vps9gbU5Jp2dHZzxJVC0MwNstvpK3MNw8xfqwWVm6bW5FI0tubQQaQvw2C6kB8tNPK2+iIDORNvLHpgEX/U2lht26VdIbeb/fuYAYYsNNRv8zevZbJqIa8U/oRoZ91LGCJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270067; c=relaxed/simple;
	bh=+8H0nZraJ5jFDIxi66tvyEKliFbtcb4B7nCS46xHU/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4B2FTV7kbjHxDnDglw0dYZmyCbrXg+HVDBfSEDnxmJwdRJuEACjD/LzHy33sKtdn8NdUc0BI+1f25elRzreSoZZp6mDBSdu2kUXh4BN/RcaUkoZ1q9pttnY0eUGI5zCNGagih056y0ZwxDc3ZC0Iu3s354VhnwaAyfDQy7w9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VKHEjSrh; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f3f68dd44bso41430051fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725270063; x=1725874863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EhGDfu64ImqEz19Rd+H49S8HGmwb4Sou/tR2ArqG17U=;
        b=VKHEjSrhmkWih97knD3AjCeMvBPFLDidHelAuHAABmGa3eYnumu/rCK5gw9TL86F0F
         oXivugda1giEg1Twuurzf8VXy4xZL73NdY+OZLG3p5tAITb0GcVtjNMSiq7Rkod+wfSe
         VRG6cCNW0Os3/XaL6TwBqvMpDHWxI3vGJS7E5BsTZ7mc/5vHTxdv8MEZvYCNK5iTDmDa
         GDmbt6d73d+OGnArbt7A4A42AxswbBaVK5fhI+R9y9mrsP2fsXlWA6p2WId6kDhsml1p
         j2L/4Ivv60AJITZKvUto+qMKD5KHBmCjbHhXZ20hioLetDX+2Vh1fvIbbMpO5PafyRoR
         TLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725270063; x=1725874863;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhGDfu64ImqEz19Rd+H49S8HGmwb4Sou/tR2ArqG17U=;
        b=RhL9AJLRMWDykmZ9Cw4OKV4cN8DR1DKHO9P2Chrjy7u91qFozDqO2xKCx8XzPO2rn6
         AVSzt55qRL4PvvVYGi+LRJHHUkrmphCdSkvd1GCD5TMHID67iUi7W4+ghyr4krIy+Eej
         mq62g+L0rFWPcgGH2LIdzXlpxnH0hYkAPhSwJoK8tRCBHma/+n+QZVgEVeEItARfomU7
         kP0K0mYukoT8VBJRWX0Vs9CIZGNGzIPW0T825xdhjMWoBE9fgIi6f/n+yyFKTxjzEuec
         kOl/rWiYnXC1JsZbBNHcXurDEuUbDFWM/QPm9I105Il1kRYDj8bHtj/BhVD0I1MYog7C
         00xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO+6BtC4xystWcD3+GwfwIbv0rtBcIJUqxvI7TOlpZgJ4mXtzYUU39d8suuQ82QhKV7B2rZqCGsvRFtSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6k61X/56FbUslnt6mBnJS0cddMOCY6v3wq5aw4pKC2cMMWek5
	iiPE4QP4mfjJy+CyPfHDXM/gfc4s/XK9ZRi2qh9jmRzzaTOfWZRlC7kmm2zcss8=
X-Google-Smtp-Source: AGHT+IFQGQZh4yhPcIy4txM1Ef4V+wrkAVPt6E/RF+Gy5qd+rB2Lv/rVMMxNrL3zJ8HGLbsFMzBzpQ==
X-Received: by 2002:a2e:b8d1:0:b0:2f6:1d9e:adfa with SMTP id 38308e7fff4ca-2f61e056430mr63706661fa.19.1725270062940;
        Mon, 02 Sep 2024 02:41:02 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56e4273sm6742531b3a.149.2024.09.02.02.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 02:41:02 -0700 (PDT)
Message-ID: <2e72f744-7262-4d22-a3a1-44a323036ec9@suse.com>
Date: Mon, 2 Sep 2024 19:10:57 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Don't block system suspend during fstrim
To: Luca Stefani <luca.stefani.ge1@gmail.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240822164908.4957-1-luca.stefani.ge1@gmail.com>
 <400d2855-59c2-47d2-9224-f76f219ae993@gmail.com>
 <745754f6-0728-4682-95a0-39807675bb18@gmx.com>
 <CAO0HQ0X3zk6aau50Ew2nmNP-pwNEkmgAoC2Ewmi30sGi7uQwDA@mail.gmail.com>
 <22c49ecd-e268-4738-853e-9f79ea1e87f7@gmx.com>
 <94178c8f-c9d6-4c3e-9d1d-6d465d379e0f@gmx.com>
 <072aba7d-6571-4b22-875d-3409c0eefe40@gmail.com>
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
In-Reply-To: <072aba7d-6571-4b22-875d-3409c0eefe40@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/2 19:01, Luca Stefani 写道:
[...]
>>>
>>> Oh, then it's fine.
>>>
>>> Except the return code, everything looks fine to me now.
>>
>> Forgot to mention that, even for error case, we should copy the 
>> fstrim_range structure to the ioctl parameter to indicate any progress 
>> we made.
> This seems to be already the case.
> range->len = trimmed; is always executed regardless of previous failures
> and there doesn't seem to be any early return.

What I mean is inside btrfs_ioctl_fitrim(), at the end if 
btrfs_trim_fs() returned error (including interrupted), copy_to_user() 
will not be call, that's the problem needs to be solved, as long as we 
return error for interrupted cases.

Thanks,
Qu
> 
> Will try adding back the errno and try the repro.
> 
> Thanks.
>>
>> Thanks,
>> Qu
>>>
>>> Just please update the commit message to explicitly mention that, we
>>> have a free extent discarding phase, which can trim a lot of unallocated
>>> space, and there is no limits on the trim size (unlike the block group
>>> part).
>>>
>>> Thanks,
>>> Qu
>>>>
>>>>     Thanks,
>>>>     Qu
>>>>
>>>>      >>       }
>>>>      >>       mutex_unlock(&fs_devices->device_list_mutex);
>>>>      >
>>>>
>>>
> 

