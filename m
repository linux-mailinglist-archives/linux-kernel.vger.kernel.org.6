Return-Path: <linux-kernel+bounces-525094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9CBA3EAB5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6423D3A5525
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED551BD9DD;
	Fri, 21 Feb 2025 02:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UebIWKuW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6FF7E110
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740104362; cv=none; b=YNLCn0+Eb9THAViXynmdZxSuVPn/YFXx7DDnUHdZjGO3UaRBCO8NLFWLAXHUcMBDYXjwwJhhpnAE0Jim2DH2DtSqKXXm7omGJFrjW9XKYq3mGzmuYn/3n7eQVOo6hjYcefTgsLvubz3RDQp/bVB872JSR9i0Uk99kkzNJj3k2+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740104362; c=relaxed/simple;
	bh=IXFVmyxXiZyUE5Rvw8hT3fkk95tLDsh1VA2zohW+Ih0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j4rUSZnMm//zetUM+XM9N8vv757+9YoMHch89YuXndY20q12BQcn79sVoUfPLQBX/wCJoRtdv7mX8blYPivwX7yt2ENbXI6/84bpi8nMAd93msey2r9kOfUXzOwctcjmkOrNJVdEHkk4J2Eu6OT5+pJfOwhk/mUebCF7z+hs27Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UebIWKuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E83C4CEE2;
	Fri, 21 Feb 2025 02:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740104362;
	bh=IXFVmyxXiZyUE5Rvw8hT3fkk95tLDsh1VA2zohW+Ih0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=UebIWKuWMhOPD+PWUaoEMWVO9NwQQADbJ4s3lZdcwgtg583zHbzrmli1adVKTdp21
	 NZMRmFHWouaMQ2wFHCoo0lONYmWWJPAZOvelFFrzJHbCcMTfRUmyPtglzedztWxjQs
	 bkD0jkJ5d+wMz8H8iffknkcHZo6Nz7S4eUYY+/pukDAVRqsupwzgRzrbv5qW1p/N0c
	 ibecU9bweVjX/KEz4eyXPTIUmeDys3gVkumROySUEtT8vv7qzXLA/52odAKMlWfcmP
	 L04Jmrjyy1mzDpMayfRASVmqOt9wEKdvSzuFSsLtfKyfvb0a/3K6T/gGZm9M/R9DPb
	 GF93GJIHrX2Dg==
Message-ID: <e62dfe59-61a9-426f-bec4-69223b7247f9@kernel.org>
Date: Fri, 21 Feb 2025 10:19:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not use granularity control for
 segment or section unit discard
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250220154904.2698964-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 xsFNBFYs6bUBEADJuxYGZRMvAEySns+DKVtVQRKDYcHlmj+s9is35mtlhrLyjm35FWJY099R
 6DL9bp8tAzLJOMBn9RuTsu7hbRDErCCTiyXWAsFsPkpt5jgTOy90OQVyTon1i/fDz4sgGOrL
 1tUfcx4m5i5EICpdSuXm0dLsC5lFB2KffLNw/ZfRuS+nNlzUm9lomLXxOgAsOpuEVps7RdYy
 UEC81IYCAnweojFbbK8U6u4Xuu5DNlFqRFe/MBkpOwz4Nb+caCx4GICBjybG1qLl2vcGFNkh
 eV2i8XEdUS8CJP2rnp0D8DM0+Js+QmAi/kNHP8jzr7CdG5tje1WIVGH6ec8g8oo7kIuFFadO
 kwy6FSG1kRzkt4Ui2d0z3MF5SYgA1EWQfSqhCPzrTl4rJuZ72ZVirVxQi49Ei2BI+PQhraJ+
 pVXd8SnIKpn8L2A/kFMCklYUaLT8kl6Bm+HhKP9xYMtDhgZatqOiyVV6HFewfb58HyUjxpza
 1C35+tplQ9klsejuJA4Fw9y4lhdiFk8y2MppskaqKg950oHiqbJcDMEOfdo3NY6/tXHFaeN1
 etzLc1N3Y0pG8qS/mehcIXa3Qs2fcurIuLBa+mFiFWrdfgUkvicSYqOimsrE/Ezw9hYhAHq4
 KoW4LQoKyLbrdOBJFW0bn5FWBI4Jir1kIFHNgg3POH8EZZDWbQARAQABzRlDaGFvIFl1IDxj
 aGFvQGtlcm5lbC5vcmc+wsF3BBMBCgAhBQJWLOm1AhsDBQsJCAcDBRUKCQgLBRYCAwEAAh4B
 AheAAAoJEKTPgB1/p52Gm2MP/0zawCU6QN7TZuJ8R1yfdhYr0cholc8ZuPoGim69udQ3otet
 wkTNARnpuK5FG5la0BxFKPlazdgAU1pt+dTzCTS6a3/+0bXYQ5DwOeBPRWeFFklm5Frmk8sy
 wSTxxEty0UBMjzElczkJflmCiDfQunBpWGy9szn/LZ6jjIVK/BiR7CgwXTdlvKcCEkUlI7MD
 vTj/4tQ3y4Vdx+p7P53xlacTzZkP+b6D2VsjK+PsnsPpKwaiPzVFMUwjt1MYtOupK4bbDRB4
 NIFSNu2HSA0cjsu8zUiiAvhd/6gajlZmV/GLJKQZp0MjHOvFS5Eb1DaRvoCf27L+BXBMH4Jq
 2XIyBMm+xqDJd7BRysnImal5NnQlKnDeO4PrpFq4JM0P33EgnSOrJuAb8vm5ORS9xgRlshXh
 2C0MeyQFxL6l+zolEFe2Nt2vrTFgjYLsm2vPL+oIPlE3j7ToRlmm7DcAqsa9oYMlVTTnPRL9
 afNyrsocG0fvOYFCGvjfog/V56WFXvy9uH8mH5aNOg5xHB0//oG9vUyY0Rv/PrtW897ySEPh
 3jFP/EDI0kKjFW3P6CfYG/X1eaw6NDfgpzjkCf2/bYm/SZLV8dL2vuLBVV+hrT1yM1FcZotP
 WwLEzdgdQffuQwJHovz72oH8HVHD2yvJf2hr6lH58VK4/zB/iVN4vzveOdzlzsFNBFYs6bUB
 EADZTCTgMHkb6bz4bt6kkvj7+LbftBt5boKACy2mdrFFMocT5zM6YuJ7Ntjazk5z3F3IzfYu
 94a41kLY1H/G0Y112wggrxem6uAtUiekR9KnphsWI9lRI4a2VbbWUNRhCQA8ag7Xwe5cDIV5
 qb7r7M+TaKaESRx/Y91bm0pL/MKfs/BMkYsr3wA1OX0JuEpV2YHDW8m2nFEGP6CxNma7vzw+
 JRxNuyJcNi+VrLOXnLR6hZXjShrmU88XIU2yVXVbxtKWq8vlOSRuXkLh9NQOZn7mrR+Fb1EY
 DY1ydoR/7FKzRNt6ejI8opHN5KKFUD913kuT90wySWM7Qx9icc1rmjuUDz3VO+rl2sdd0/1h
 Q2VoXbPFxi6c9rLiDf8t7aHbYccst/7ouiHR/vXQty6vSUV9iEbzm+SDpHzdA8h3iPJs6rAb
 0NpGhy3XKY7HOSNIeHvIbDHTUZrewD2A6ARw1VYg1vhJbqUE4qKoUL1wLmxHrk+zHUEyLHUq
 aDpDMZArdNKpT6Nh9ySUFzlWkHUsj7uUNxU3A6GTum2aU3Gh0CD1p8+FYlG1dGhO5boTIUsR
 6ho73ZNk1bwUj/wOcqWu+ZdnQa3zbfvMI9o/kFlOu8iTGlD8sNjJK+Y/fPK3znFqoqqKmSFZ
 aiRALjAZH6ufspvYAJEJE9eZSX7Rtdyt30MMHQARAQABwsFfBBgBCgAJBQJWLOm1AhsMAAoJ
 EKTPgB1/p52GPpoP/2LOn/5KSkGHGmdjzRoQHBTdm2YV1YwgADg52/mU68Wo6viStZqcVEnX
 3ALsWeETod3qeBCJ/TR2C6hnsqsALkXMFFJTX8aRi/E4WgBqNvNgAkWGsg5XKB3JUoJmQLqe
 CGVCT1OSQA/gTEfB8tTZAGFwlw1D3W988CiGnnRb2EEqU4pEuBoQir0sixJzFWybf0jjEi7P
 pODxw/NCyIf9GNRNYByUTVKnC7C51a3b1gNs10aTUmRfQuu+iM5yST5qMp4ls/yYl5ybr7N1
 zSq9iuL13I35csBOn13U5NE67zEb/pCFspZ6ByU4zxChSOTdIJSm4/DEKlqQZhh3FnVHh2Ld
 eG/Wbc1KVLZYX1NNbXTz7gBlVYe8aGpPNffsEsfNCGsFDGth0tC32zLT+5/r43awmxSJfx2P
 5aGkpdszvvyZ4hvcDfZ7U5CBItP/tWXYV0DDl8rCFmhZZw570vlx8AnTiC1v1FzrNfvtuxm3
 92Qh98hAj3cMFKtEVbLKJvrc2AO+mQlS7zl1qWblEhpZnXi05S1AoT0gDW2lwe54VfT3ySon
 8Klpbp5W4eEoY21tLwuNzgUMxmycfM4GaJWNCncKuMT4qGVQO9SPFs0vgUrdBUC5Pn5ZJ46X
 mZA0DUz0S8BJtYGI0DUC/jAKhIgy1vAx39y7sAshwu2VILa71tXJ
In-Reply-To: <20250220154904.2698964-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/20 23:49, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When we support segment or section unit discard, we should only focus on
> how actively we submit discard commands for only one type of size, such
> as segment or section. In this case, we don't have to manage smaller
> sized discards.
> 
> Reported-by: Yohan Joung <yohan.joung@sk.com>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/segment.c | 29 ++++++++++++++++++++---------
>   1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c282e8a0a2ec..4316ff7aa0d1 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1661,12 +1661,20 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>   				f2fs_time_over(sbi, UMOUNT_DISCARD_TIMEOUT))
>   			break;
>   
> -		if (i + 1 < dpolicy->granularity)
> -			break;
> +		/*
> +		 * Do not granularity control for segment or section
> +		 * unit discard, since we have only one type of discard length.
> +		 */
> +		if (f2fs_block_unit_discard(sbi)) {
> +			if (i + 1 < dpolicy->granularity)
> +				break;
>   
> -		if (i + 1 < dcc->max_ordered_discard && dpolicy->ordered) {
> -			__issue_discard_cmd_orderly(sbi, dpolicy, &issued);
> -			return issued;
> +			if (i + 1 < dcc->max_ordered_discard &&
> +					dpolicy->ordered) {
> +				__issue_discard_cmd_orderly(sbi, dpolicy,
> +						&issued);
> +				return issued;
> +			}
>   		}
>   
>   		pend_list = &dcc->pend_list[i];
> @@ -1701,6 +1709,13 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>   
>   		if (issued >= dpolicy->max_requests || io_interrupted)
>   			break;
> +
> +		/*
> +		 * We only use the largest discard unit for segment or
> +		 * section unit discard.
> +		 */
> +		if (!f2fs_block_unit_discard(sbi))
> +			break;
>   	}
>   
>   	if (dpolicy->type == DPOLICY_UMOUNT && issued) {
> @@ -2320,10 +2335,6 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>   	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
>   	dcc->max_ordered_discard = DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY;
>   	dcc->discard_io_aware = DPOLICY_IO_AWARE_ENABLE;
> -	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
> -		dcc->discard_granularity = BLKS_PER_SEG(sbi);
> -	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
> -		dcc->discard_granularity = BLKS_PER_SEC(sbi);

Hi Daeho,

I think this bug was introduced by commit 4f993264fe29 ("f2fs: introduce
discard_unit mount option"), since it set discard_granularity to section
size incorrectly for discard_unit=section mount option, once section size
is large than segment size, discard_granularity will be larger than 512.

However, w/ current implementation, we only support range of [1, 512] for
discard_granularity parameter, resulting in failing to submitting all
dicards.

So, what do you think of setting discard_granularity to 512 for both
discard_unit=segment and discard_unit=section mount option, as I proposed
in [1]? Then, discard_thread in DPOLICY_BG mode can submit those large-sized
discards.

[1] https://lore.kernel.org/linux-f2fs-devel/53598146-1f01-41ad-980e-9f4b989e81ab@kernel.org/

Thanks,

>   
>   	INIT_LIST_HEAD(&dcc->entry_list);
>   	for (i = 0; i < MAX_PLIST_NUM; i++)


