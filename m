Return-Path: <linux-kernel+bounces-259601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285B393993E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCFE1C219D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095713C9D5;
	Tue, 23 Jul 2024 05:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bbytvAe2"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FDE13C832
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721713085; cv=none; b=sMzuHvugTlzMNrQ1v3xxZP1jKLixnE/2dg+NtY0T77iBhpVfiv1J5XSH/XelVhX8EICdLEgbnxtn5+rlyBl4dOMdM/tOd1scKv6s/S3AyVf3bwHu23eMqOIZ2rcAW2Yhap/qMbrVKyf41R4RHcW+j+GFWR66P/1rEhkDy7OJZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721713085; c=relaxed/simple;
	bh=07B8zQW2e6MJEUWUS3r6jlNE2x+GGxML5ROYg234HBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/NvAoyO70ns6ohXbEKMRB+u1iL5FfW3rv4Qhj2DegFqFl0szPBXPHlb8IBQ4RsTD9tPcDWoPoS9C53kGNwAAa22Hd5J+NkAxR7vZ/vCScDpR/ErWzSBpxYlnLOUXsDJKqydbxZeuPBZTQirxLs8z2SlaKfxxyYgVN+NWq6ywz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bbytvAe2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef2ed592f6so21250781fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721713080; x=1722317880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MhVxpGALzzOhSKfl7F3ZZPNcwL9E3a6Ged4o5h3oz2Y=;
        b=bbytvAe2pOSHO/qbQ3ZL1rHnNp3z3k/3f7IGCzAvphE/mJsDEhvfCUN372CO6xEjGd
         3kALY7rpSUXygzKHUogxrLWiD3qNxvmlwwdnAbwg8s0yggYy3HSJoCpbBQbbgNvGwdlB
         ulkJFcWP7lq7v76BqSvEi2hChGA1dfk3LwBbu+Q/Bvq5jF97c6j87vrmmttmJoZkX+tP
         ukAkgqknCL0G7V4kfpESrqjRGiD5b1Mt1GoqMsDRCKXF1/B/Q1dLJJ4kFKHOw+fmxLc7
         e5c6CNibosyRQEhWiCPpuSG5KuRHeic4m24co2pA5ax1xV2NypdMunlzuJ4eB4zJaNDj
         PBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721713080; x=1722317880;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhVxpGALzzOhSKfl7F3ZZPNcwL9E3a6Ged4o5h3oz2Y=;
        b=Q6/HpNwXVfTF8jTk2BiOoMKLHa4Aca8KbIcdx0zpBf6RDf+rjq9rYxwcMks/WBk/2H
         d3oxyRx/ImyTPPcodWtskmCjMgPKzflwak/fhkFD3cDKZa229mJSvl2rb7bLbK2lf9nV
         YVMBXCXSEO6w6UyAYampmrPBsoGTAJ9XiF67W6CbekAY1tWKR/rj3cRQ9BbKt4r8uPvH
         wd4FPd0H4WWAeHx5X0vlD3HuqhYeaWAFH9mmlA0hbmgqzEtHF07r76gYk2X1SwSEbN+E
         /kNsTeKjFM3FjJDe44fD52sEmpLVXPQSZtjQ2d64bLuLE/mUMgPLz2WqJb+K+VpYN2a3
         NOUg==
X-Forwarded-Encrypted: i=1; AJvYcCXpZYpOPBC76o36RcU0l+0Z9nmVnLr9xWsxhHx1770G24sOy5LupbZMaoD+JQn3eykUc/NJwihfd7UPJZkE2srBnQWJIuZWLtvh+4Y6
X-Gm-Message-State: AOJu0YyN4ZW/cKGqj3W4UCw7stSQD1u5ciREnsscVitE4UDZHg2XuEET
	iXIdXTrAUX8TcVknGYEmc4ERKqm6VZpbIsUo4t9QiXwPXrqXGskF+qFDcfob47w=
X-Google-Smtp-Source: AGHT+IHt+fRslPQyYUmEreRH5rHtJrKGvvXlZj2AUDmUCe4EZiRVHjW2fq54ka1RO/VI5bWXhCRoZg==
X-Received: by 2002:a2e:8005:0:b0:2ef:307a:9988 with SMTP id 38308e7fff4ca-2ef307aa0fcmr28362421fa.35.1721713079516;
        Mon, 22 Jul 2024 22:37:59 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f3184f9sm65431575ad.169.2024.07.22.22.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 22:37:59 -0700 (PDT)
Message-ID: <8afac96c-979e-47b4-8416-c26ba4c4a348@suse.com>
Date: Tue, 23 Jul 2024 15:07:54 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fs/btrfs/inode.o: warning: objtool: insert_inline_extent+0xa8:
 unreachable instruction
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <202407231331.vNHHJPnu-lkp@intel.com>
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
In-Reply-To: <202407231331.vNHHJPnu-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi LKP team,

Thanks a lot of your reports.

在 2024/7/23 15:02, kernel test robot 写道:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   66ebbdfdeb093e097399b1883390079cd4c3022b
> commit: eb1fa9ab470285d39bee268bc2a90d1786610711 btrfs: make insert_inline_extent() accept one page directly
> date:   3 months ago
> config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240723/202407231331.vNHHJPnu-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.1.0

> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240723/202407231331.vNHHJPnu-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407231331.vNHHJPnu-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> fs/btrfs/inode.o: warning: objtool: insert_inline_extent+0xa8: unreachable instruction

However for those not-so-common archs, mind to provide the code line 
number if possible?
(Better for all archs)

Although unreachable instruction warning is mostly false alerts, I still 
want to be sure.

Thanks,
Qu
>     fs/btrfs/inode.o: warning: objtool: btrfs_del_delalloc_inode+0xb0: unreachable instruction
>     fs/btrfs/inode.o: warning: objtool: btrfs_set_delalloc_extent+0x18c: unreachable instruction
>     fs/btrfs/inode.o: warning: objtool: btrfs_evict_inode+0x9c: unreachable instruction
>     fs/btrfs/inode.o: warning: objtool: btrfs_get_extent+0x3d0: unreachable instruction
>     fs/btrfs/inode.o: warning: objtool: btrfs_set_range_writeback+0x7c: unreachable instruction
>     fs/btrfs/inode.o: warning: objtool: compress_file_range+0x388: unreachable instruction
>     fs/btrfs/inode.o: warning: objtool: cow_file_range+0x128: unreachable instruction
>     fs/btrfs/inode.o: warning: objtool: btrfs_finish_one_ordered+0x174: unreachable instruction
>     fs/btrfs/inode.o: warning: objtool: btrfs_invalidate_folio+0x1b8: unreachable instruction
> 
> 
> objdump-func vmlinux.o insert_inline_extent:
> 

