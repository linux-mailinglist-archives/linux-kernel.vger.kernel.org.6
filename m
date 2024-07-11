Return-Path: <linux-kernel+bounces-248665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B650F92E05E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B391C21741
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97E12EBF3;
	Thu, 11 Jul 2024 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T9/h42/x"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47AE12DD9B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720680965; cv=none; b=Ie2H7FnfOTjjqZy35/NlaEZbLmfI72phUbvg4T68ZWmU6/xxmd4ph06eG2KdXhtjp1DL9NcuGxyvgBe0xqeOa3bn3SbYMZT1QoJjJQXpKQJVTUNx28gKlXHTeP1OZIH/CRqIiLW4WMTEZcwmUazB180Mbr8+lg/3B6LvHj7T6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720680965; c=relaxed/simple;
	bh=l7t0W6Gf7X/3+4B2lO9M0f58BALdgTQmAAgT8+KIukA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWeWDdvbFnhLgKUMpYbhUGl1Ij6cKpH4Q2zsxhsyTZ4naPaHnbYnJth+UDxQ8Pr9d6VUrC4sfMKV9QsezkEz6mdJZKMTTXuduhwBCqCDrucgD1fvWMKrPGyHuvsoFI8mlzSvg8/JDMSY90heRD0DhGWL0FxEg+s11YxjA79YNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T9/h42/x; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ee7a1ad286so6127361fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720680961; x=1721285761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VcDtK91AtodOXx3CdgZhhFnwL7KOfmzTDYSuzH820VM=;
        b=T9/h42/xG7UzFEtZBi3ouXCrN4X6xMfYOubxO7uF7IjI2isdiItDr7xecNP/lRj8MR
         T/BTWhT/oeBJWyJvm7xwLxH74Ohhv6uRWK8X7SH6ZXPLCKHASPA1lyRh8DkMJelWzCBQ
         AdY/jc/NIZI0zcGJcm8upZwGQFlGxHyWxYMH073PFRP/qS+AjbujVD/jfUTVcSg8KUAQ
         hEovrQ6gAMOX1T4ePh0CaMHDkrzwDViULyGeyJQ2XtsDL7Bewd78P/3xTx5zDMx0BST6
         C6jYKgDTZoGnzMfyYuPhMscdWgEh8YMuGQM0kIheAFywN9EhZYM9/d0w0ovstKRB1EYZ
         DoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720680961; x=1721285761;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcDtK91AtodOXx3CdgZhhFnwL7KOfmzTDYSuzH820VM=;
        b=UVKlje2VNzZ9l7tObEc3n7HRbHVT75YkBHob7MguWfQq9fR1iXD5qTfABsVH0LhoY4
         29EB3MrtxgfGywx5IDTHu85jwAQS68Q9UxuQcxmIMTl7UwlLESb0A+pSVWeBriK+GgrL
         ZVcDkTdvn2O8GKYjAfu7HNCYbaY1WtFLesVIT/8FC2y83mq2JbhIJLo82+Hlsqenyujo
         0stxmfuNhuL4WtiZvek2hlKnviNMfPWzA9iiC2hU0OVSgMQkDcyx9Cgk5w0C857f9vGk
         3cQeykkLRUMqsCow0snY9hCed5hyYxM3STM4Z14obchVtCnxpBoIRQ+QqrPldorPyJmB
         UiNg==
X-Forwarded-Encrypted: i=1; AJvYcCUVjfr6Y4esKc8Vb/5nm2ciTAmZzEsFz2W/fMKBPPCtqr4pVFZUPIqBn8Qt66oLUILye28wBBTIykdsHjQ8pP++9wtY1bQqRu1ASlyH
X-Gm-Message-State: AOJu0YwuCYf0gFhmpiRYRlECvBe7P4O4qb9IwNS7YvJ5PCj4ipBEYwUp
	nQ7JVOZxLnZ9fjI1OtM0hrtx4zTVj0cs9x3vtBV5ijPaKo8xY8H3fGojL+5Cozc=
X-Google-Smtp-Source: AGHT+IGjg3Hfplh2y60uDrHiR9PtMYcLRiysODxELTVZWuhJtL7Ztc7GOYonZgINfsvmwjdIHZ2T4A==
X-Received: by 2002:a2e:9201:0:b0:2ec:52da:6070 with SMTP id 38308e7fff4ca-2eeb3182404mr55914021fa.42.1720680960474;
        Wed, 10 Jul 2024 23:56:00 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a122a1sm44803145ad.45.2024.07.10.23.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 23:55:59 -0700 (PDT)
Message-ID: <08b5cf14-8b00-4a19-ae98-e83e83357688@suse.com>
Date: Thu, 11 Jul 2024 16:25:54 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] btrfs: update stripe_extent delete loop
 assumptions
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240711-b4-rst-updates-v2-0-d7b8113d88b7@kernel.org>
 <20240711-b4-rst-updates-v2-3-d7b8113d88b7@kernel.org>
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
In-Reply-To: <20240711-b4-rst-updates-v2-3-d7b8113d88b7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/11 15:51, Johannes Thumshirn 写道:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> btrfs_delete_raid_extent() was written under the assumption, that it's
> call-chain always passes a start, length tuple that matches a single
> extent. But btrfs_delete_raid_extent() is called by
> do_free_extent_acounting() which in term is called by > __btrfs_free_extent().

But from the call site __btrfs_free_extent(), it is still called for a 
single extent.

Or we will get an error and abort the current transaction.

> 
> But this call-chain passes in a start address and a length that can
> possibly match multiple on-disk extents.

Mind to give a more detailed example on this?

Thanks,
Qu

> 
> To make this possible, we have to adjust the start and length of each
> btree node lookup, to not delete beyond the requested range.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/raid-stripe-tree.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index fd56535b2289..6f65be334637 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -66,6 +66,11 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
>   		if (ret)
>   			break;
>   
> +		start += key.offset;
> +		length -= key.offset;
> +		if (length == 0)
> +			break;
> +
>   		btrfs_release_path(path);
>   	}
>   
> 

