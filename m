Return-Path: <linux-kernel+bounces-378947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC5D9AD793
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34003280049
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40841FEFA4;
	Wed, 23 Oct 2024 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F9GH1MaN"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E603F14EC55
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729722548; cv=none; b=iMWZDAlnVi8g/y34u5Eu+FO7DqLig6i3y0Xcwb5o2dDOe2UbqdccjBlYvHtaq+ox/W85jZ+kMtrzyyuHMIHgoJ+KKb7RwRK4qUwhoLquqNjXWkhFSTB3bNStx7hhBBLN0rY6u/zgCdd/3feSGYds+j+N8/UgepBPxvkeKLqiLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729722548; c=relaxed/simple;
	bh=wlaMWK2D+FUwRw7jYMObS1BQMNE6oLXovXvWeDmFqjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLyys5ZGOXoYxmG2jfboW1Atk8jOuj4/Q2pqvl+rJBnGvp+lhwp7SB64dUFIqZX6isF9bT71CE6d6Cs0/hjB9kRNwxuVcmooH+5iMYzFicq22+OKKvlgcqV5Wfn2LPw5AqTOiS4aKbALQi7j/O1Hjx3i/MCkoeLbJ3Ql2LRKHBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F9GH1MaN; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb51f39394so2438741fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729722544; x=1730327344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1BNv+9ccdONtxE/unrWMfm+hHYMEAzpv+OHzE9ABF/A=;
        b=F9GH1MaNvdOaISSFbWb8fpUjovU7qoiOIfnu+2VwVGurMtPtEkj2dpX6CqWsPbDatl
         jTwOamsAQMMfiLcOkTOr7gBGu9FZ0eoAnpxlbyXx/OrCoJ10x7tpSR87kSso19GUTIbQ
         AgIx55tYevw80gUtMIELQbHko2ayzx/On4HW3n7UMm9GotRSJISY6fcbfThv+WJwwqDF
         6gWFxEmV+CT/fBh0RCs2R/olScc1Cjfv0HDf+YbyvRj/hnar6Hlidh5bcfDH2PuD2aKg
         KAiXIfs/dmCqw1w8VPv0JL32vDWhZP3NJLcamQJ+kj4ilbDRkmkVtm+Z56oR6j5fRUL8
         3dkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729722544; x=1730327344;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BNv+9ccdONtxE/unrWMfm+hHYMEAzpv+OHzE9ABF/A=;
        b=Pt3nbd6/0TmOknLWAZ/DtZ59uGRs0AMrXAsLiZcBVGe45Do0LKW8DEHRaLQccJ0+b4
         TuZlBSZ1r9qKOE/XXlvfMKaQqdC0zzoEp+BZcNSTXd8Bj2X6icZF6LESCkB8VsA392/G
         OUmbekxX5qbzyq6Xh9P7KndJ/pcQbf16ucOH2ksWG2pIaUlJVlg6618aJ435UZ6GeHLh
         SG/Oh0n0jsbjB3G7PhL5JwtrAI2WRfUY/N2/n9849shthIEh0npJ5ykUYNhTnUMulelF
         W34cz6apNnXsThXWWlT+EmtWSkZL4xEmti43SsBHPzVqLRE6xynWTuJJbQuhrHFtcFYx
         26JQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7XrbCzhVtKjpYPa4G58dboHKPoLEqTkiztaWSP3dLhJFBABAe25JYIZQkeJK668SE9dz6+TkWvHTtCAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0xx/GTXK1Cbj2jdeMD1RVqJB62sUnSEfvcAkC1VipJMQo9JBq
	vYX20kAbNyslqDyo3HdNXmf/6OjFIFxbdzfIB6W4tzjunHD5hHefS0N1x3orc/U=
X-Google-Smtp-Source: AGHT+IFeujF+wKbP/nYkWblQ0PgqpM4Q6qB9kDV45S+eyhIfyeKu1LSMz3xFV6fVKkLXfkdjTgbSBQ==
X-Received: by 2002:a05:651c:221d:b0:2fa:d345:18b9 with SMTP id 38308e7fff4ca-2fca827e963mr137621fa.38.1729722543614;
        Wed, 23 Oct 2024 15:29:03 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafb1e0sm7390048a12.3.2024.10.23.15.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 15:29:03 -0700 (PDT)
Message-ID: <95af7735-cb97-491c-be22-8e9759f4720f@suse.com>
Date: Thu, 24 Oct 2024 08:58:58 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the btrfs tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20241024085701.64263a3b@canb.auug.org.au>
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
In-Reply-To: <20241024085701.64263a3b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/24 08:27, Stephen Rothwell 写道:
> Hi all,
> 
> After merging the btrfs tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> fs/btrfs/super.c: In function 'btrfs_reconfigure_for_mount':
> fs/btrfs/super.c:2011:56: error: suggest parentheses around '&&' within '||' [-Werror=parentheses]
>   2011 |         if (!fc->oldapi || !(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
>        |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>    4642e430c55b ("btrfs: fix mount failure due to remount races")

My bad, in fact a new patch is going to remove the oldapi check 
completely as newer mount using new API will break the per-subvolume 
RO/RW again.

Thus a new patch is needed to remove the oldapi check first 
(https://lore.kernel.org/linux-btrfs/e1a70aa6dd0fc9ba6c7050a5befb3bd5b75a1377.1729664802.git.wqu@suse.com/), 
then the newer v2 patch 
(https://lore.kernel.org/linux-btrfs/08e45ca0-5ed9-4684-940f-1e956a936628@gmx.com/T/#t) 
will be completely fine.

Thanks,
Qu
> 
> I have used the btrfs tree from next-20241023 for today.
> 


