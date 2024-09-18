Return-Path: <linux-kernel+bounces-332960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A96A97C16B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 23:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B757B21473
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE641CB328;
	Wed, 18 Sep 2024 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WOHCUxmp"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D734D189B91
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726695301; cv=none; b=oHq6qdSt70iqLOZ+xpWZ4ALl86aitC4w/QI4TpZgVxEnkWhOFInPax3TPT/IweDmBUc8oLOTZP3KVyswb1MdjhMfnKthtHQTzJy7E5DKSGaZmrf3DxtALv/dSlEUIQyeHbdKMJPeusANL+PtURdaAstS3JEIPQCTfa6fUyQTNLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726695301; c=relaxed/simple;
	bh=BdgnerTODUNMpagYy5ebcISgBzK0E3hXUWWMY6OU6YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0xL8DwAz8C+TlEwLqUilqOd0wHat0yWjhiYCqhhsIl2UGakfzwvAuj4dciWM2icrMWN2OajyPWEL8tlA7EO5dXTWBej1ZkVfSvalVt4SFJRnsPW9VBggs38aPtbg0vKO/JL18mgs1YFVxX+gVfzyBNmP2prSrYAoPYobSdFadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WOHCUxmp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso1072715e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726695295; x=1727300095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C6j4i0FrgkuZCRDPVul7Yymx4wqWERXWV9ZJm7RQN0g=;
        b=WOHCUxmpichp1z2z26l/Okfc49ak0lWDH0205GslVxa8FXZhwZvtPYCE+m8wM7sJbl
         wLTt3ONOv3RnOPRF/mFBrSbZkPeeEtrV53POwlvyjfAHo8hyNm2LgVbZwain1BzEiFS1
         1B0wsFLhHN8Q3QcHYobjyuQW5quDdwai1lDe0+iRki+JNR3Aj7W6hWMhOXIBGS84aUAT
         Smj6pgDo+yUMDm3jwe1vlfyzt47AQD7H098QbrNH3EuNmA54riaC4Rzt1+GR0GuCuYIy
         oQsdrv4j5pGq9gBje1P8mPwgUg3GrwuHNDQdLXqF4spSJunbEDfmcOnRVaqFuMILEGwr
         xZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726695295; x=1727300095;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6j4i0FrgkuZCRDPVul7Yymx4wqWERXWV9ZJm7RQN0g=;
        b=Bu4xnpPguuhNYTtBADl/ra8b1A9c9FZNmawpL6ocnf3PX8rf2UvM59eeccTelAq8rZ
         0VQAHMmPrjO8Eb/NcZGvMWfxQ37yOAVlweFxAfS/cyBSKZunsHtcXMV1np8VZf75QCah
         ezAW0IBCnfIdK6veFQH1bDQ3x6uWxV4TbJSmup4UY5JJq7dxnvVW3atv+AYj7PNmgHm2
         UuBVKrPGNnyBmBrOV2iiEXfPTULyaTw03TWnEQ7cX1aMFD+FYyCF10rBvknXvUPFt3fi
         vprcXtZNjkWgfyRGcR7EhIJ+qZOwOvhDhi1sbFBgOagqy/KE7QdG0wdMQ3Z5k9sHLPOc
         9DzA==
X-Forwarded-Encrypted: i=1; AJvYcCUkkhy3SuaUTUpai0dpiOaChC+HLnfuRPH2QDKTsm43B921DaTzfu2UYi73pUGREqnXxC5YjYqg0R30UVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuATgARXtCSIMTiOqeaFsW0qdGZp8irBDZ22X+zxdAsrVtYLFK
	JMv1M5srMKHvFZ5iBs/c7TdCjoURmToXGUpbHyZl+tljBPQQhDHN7FFIfHZYVzU=
X-Google-Smtp-Source: AGHT+IHi0q8QYWvLBhein37pmXFOov4IViZRxMIHoIOTdAGF/XByRDlK09bGb8EbJiSLUJlFWaXqFw==
X-Received: by 2002:adf:ae51:0:b0:374:d157:c019 with SMTP id ffacd0b85a97d-378c2cfeb36mr13615345f8f.12.1726695294681;
        Wed, 18 Sep 2024 14:34:54 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945db10csm69457485ad.53.2024.09.18.14.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 14:34:54 -0700 (PDT)
Message-ID: <f8e00bb5-b9a2-48fa-9939-85a882d15563@suse.com>
Date: Thu, 19 Sep 2024 07:04:48 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] btrfs: Don't block system suspend during fstrim
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
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
In-Reply-To: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/18 06:03, Luca Stefani 写道:
> Changes since v5:
> * Make chunk size a define
> * Remove superfluous trim_interrupted checks
>    after moving them to trim_no_bitmap/trim_bitmaps
> 
> Changes since v4:
> * Set chunk size to 1G
> * Set proper error return codes in case of interruption
> * Dropped fstrim_range fixup as pulled in -next
> 
> Changes since v3:
> * Went back to manual chunk size
> 
> Changes since v2:
> * Use blk_alloc_discard_bio directly
> * Reset ret to ERESTARTSYS
> 
> Changes since v1:
> * Use bio_discard_limit to calculate chunk size
> * Makes use of the split chunks
> 
> Original discussion: https://lore.kernel.org/lkml/20240822164908.4957-1-luca.stefani.ge1@gmail.com/
> v1: https://lore.kernel.org/lkml/20240902114303.922472-1-luca.stefani.ge1@gmail.com/
> v2: https://lore.kernel.org/lkml/20240902205828.943155-1-luca.stefani.ge1@gmail.com/
> v3: https://lore.kernel.org/lkml/20240903071625.957275-4-luca.stefani.ge1@gmail.com/
> v4: https://lore.kernel.org/lkml/20240916101615.116164-1-luca.stefani.ge1@gmail.com/
> v5: https://lore.kernel.org/lkml/20240916125707.127118-1-luca.stefani.ge1@gmail.com/
> 
Reviewed-by: Qu Wenruo <wqu@suse.com>

> ---
> 
> NB: I didn't change btrfs_discard_workfn yet to add error checks
> as I don't know what semantics we should have in that case.
> The work queue is always re-scheduled and created with WQ_FREEZABLE
> so it should be automatically frozen. Shall I simply add some logs?

And that is for async discard, which has a much smaller discard size and 
iops limits.

The main part of large discard is the free extents discarding, which is 
already addressed by your patch correctly now.

IIRC we do not need to bother that much for it.

Thanks,
Qu

> 
> ---
> 
> Luca Stefani (2):
>    btrfs: Split remaining space to discard in chunks
>    btrfs: Don't block system suspend during fstrim
> 
>   fs/btrfs/extent-tree.c      | 26 +++++++++++++++++++++-----
>   fs/btrfs/free-space-cache.c |  4 ++--
>   fs/btrfs/free-space-cache.h |  6 ++++++
>   fs/btrfs/volumes.h          |  1 +
>   4 files changed, 30 insertions(+), 7 deletions(-)
> 

