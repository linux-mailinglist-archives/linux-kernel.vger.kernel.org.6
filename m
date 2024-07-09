Return-Path: <linux-kernel+bounces-245337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E63992B16F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEAA1F2420D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2271474C8;
	Tue,  9 Jul 2024 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gANHOw5g"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A717313212D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511185; cv=none; b=epCobXFh6dhykzFbaCL5FPDwxfJ6fFrgyesKCfiFbRVmdA2msdVQZJO2x0UdxhLRJa+lpR1e1WcbFZ0/bPv3lf95xS7TLjwr2wiQ4IOXDcGNxh9G6g8Uzbntj/rO4Yi3GBGzA/IlbdbZrEK9R1C0XVb6/UwOWH5HzPYCVoCQjM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511185; c=relaxed/simple;
	bh=ga1z06v/+Qn1EDVPvTkLZxiC3vvzYTIQaO9U1oJ3FVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VC08je/lIpi41YyDsSt5coF3NC7/6KR3tmnYR3K8uDKSPxtYmVsNWCd0/QpaOM1PUD8L5ZwSQ8aEBRvnJVz1eB8wHZjNSz7O5NFqd0VM2e8POHjlMs/ye90ebNynjkuaEWdW8yRAghlVqWBt4hRjoZ1bWOx06gEkihwkf61D7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gANHOw5g; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so51727071fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720511182; x=1721115982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=97DdeyQzZ6NpVDRuHLam7+G9SbKJZZTLVkPODrKJaac=;
        b=gANHOw5gtG8ne9v0hIBpN61/Q7qauiNfxYJy1jcLZDVdyb+hqLzf1r5vc5J5wtKOaj
         1u78lmDig1+lFRhVoEId69yYHVVDYggV7kpbeUIWEIx52dQSvl7B0MR3QGe9pTthHDES
         FjeOONWyatiBto/9BMM8x9F6iy8hLckQOZ5dDucEvsN59VhVzbNh7BdvI/uY6GbgFU1l
         /tdglYbK1k9eiMZqqo3kXpvpVeGiGjVMTurve7YPLFi8jyrs6J4/ilLZTi0jwziaP3Zz
         ulIx6FVQPY0OBZyljEtgwVfntLXgRwL59vHplDuFuWhJEZGoBv/nLDz78/eQ13SKvrU7
         bfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720511182; x=1721115982;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97DdeyQzZ6NpVDRuHLam7+G9SbKJZZTLVkPODrKJaac=;
        b=dtLSbvmwTmO5cRJ7oCaI3mcvS8fcaCz67tUmbi7I5xKoipaoA09yTVmSVeZQD2gp8A
         3FjmQVqnflPNYeqYJVszSRVEuf+Aa44SEpUpmtX/5kU71oCGNdcmdPG3w3cExLOCLHk0
         dxfM76NittTs7UVEvo5efKu/i4z8jDZLHoHBxvTXesqUByhF+mI4J0v72sSaMf7T4fRx
         QGFUgWprIoG5YepdgT85wjkQcceY0b4012ZSNKByCXxpj7x3XMVvSey2eKYLgjKeYXWp
         yBHTZazN93iHqEjTuYIkLy6cHMjJAxpYL8svDsQsJQckuvv1EBtI7e3W3mbtAUV5U0te
         BKCw==
X-Forwarded-Encrypted: i=1; AJvYcCUncPqz88SMSsMexbI91OsXjfSIhuXA49ZRAeCdwei4dmcw0w4pECjZ9rhHisYHcxYdQgYS+1Nu+/qoFa0gQK21rYGXT4LKx9nVpBLY
X-Gm-Message-State: AOJu0YwDQ04k1fGDK47pu8vtbUOGISVGeHp8QZ107sVRfgckevOxPRYa
	lZb6Kyvx082qxZIq0rsTrpajCzjSuqukn6f6M1TOUClP6bFb9pFOgZhKIarugRU=
X-Google-Smtp-Source: AGHT+IENOFpRlTwre+m1idW8+pYjDS3+Jb5oEQc8R1zju3pmKNgccy/pfr9NdHF/PqnDXRglo+y4ww==
X-Received: by 2002:a2e:8297:0:b0:2ec:5b17:29a2 with SMTP id 38308e7fff4ca-2eeb318aaf4mr10904531fa.32.1720511181485;
        Tue, 09 Jul 2024 00:46:21 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca3bd7892dsm353179a91.0.2024.07.09.00.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 00:46:20 -0700 (PDT)
Message-ID: <bca6a8d7-b23e-49be-9cfa-f387aca82e60@suse.com>
Date: Tue, 9 Jul 2024 17:16:14 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: replace stripe extents
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Filipe Manana <fdmanana@suse.com>
References: <20240709-b4-rst-updates-v1-0-200800dfe0fd@kernel.org>
 <20240709-b4-rst-updates-v1-2-200800dfe0fd@kernel.org>
 <4211723f-ddc9-4646-91c3-14a9a1769d22@gmx.com>
 <09f08d98-a615-4952-9949-daf4a7119b96@wdc.com>
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
In-Reply-To: <09f08d98-a615-4952-9949-daf4a7119b96@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/9 17:00, Johannes Thumshirn 写道:
> On 09.07.24 09:18, Qu Wenruo wrote:
>>
>>
>> 在 2024/7/9 16:02, Johannes Thumshirn 写道:
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> Update stripe extents in case a write to an already existing address
>>> incoming.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> Looks good to me.
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> But still as I mentioned in the original thread, I'm wondering why
>> dev-replace of RST needs to update RST entry.
>>
>> I'd prefer to do a dev-extent level copy so that no RST/chunk needs to
>> be updated, just like what we did for non-RST cases.
>>
>> But so far the change should be good enough for us to continue the testing.
> 
> I /think/ I have a fix for the ASSERT() as well. It survived btrfs/060
> once already (which it hasn't before) and it's trivial and I feel stupid
> for it:

Wow, it's indeed a little embarrassing, but I'm still a little confused.

> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index fd56535b2289..6b1c6004f94c 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -57,6 +57,9 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle
> *trans, u64 start, u64 le
>                   /* That stripe ends before we start, we're done. */

Didn't all the btrfs_delete_raid_extent() callers expects to delete 
exact the range? Thus I though we should always hit 0 from 
btrfs_search_slot().

>                   if (found_end <= start)
>                           break;
> +               /* That stripe starts after we end, we're done as well */
> +               if (found_start >= end)
> +                       break;

Another thing is, just to be safer, you may want to do the RST entry 
search using key.offset = 0 or key.offset = -1, instead of an exact search.

The key.offset == 0 search example can be found in scrub_enumerate_chunk().
And the key.offset == -1 search example can be found in 
btrfs_free_dev_extent().

And do extra length check to ensure we always hit an exact match.

Thanks,
Qu

> 
>                   trace_btrfs_raid_extent_delete(fs_info, start, end,
>                                                  found_start, found_end);
> 

