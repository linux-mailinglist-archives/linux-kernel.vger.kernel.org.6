Return-Path: <linux-kernel+bounces-528228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CBDA4151F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FF516E25C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705FF1C6FE5;
	Mon, 24 Feb 2025 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9LdBgo6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECB01B4234
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377502; cv=none; b=cWTJIkV7jxRTL52d74fgJ41uwPMYepe+/o5YqGFYiQ2avlQNnPYFScpuJ8ePMoXriQztJdDcondaT7n/qhZkkO0teFXqxjK+rQa2aj4MmAVIHGF7hXyMc+VD7Lo5unTZk6He0biE7XNW2YewwtaH51B23V/QJMhZGE0ttImi7fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377502; c=relaxed/simple;
	bh=DusIi7MLerQhf4R4o7zGcF+PN1nI4nAAOn4TINKuBZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqa+1xiOxFyTtGjh4ei+MKyJApCS11MlUhDhHAp443G74LbEuUlNYSuBfvxuKBoR20T39apeAS4negfHAxwv8i6PvYyam1c8UHVp5UcyL6NIqa8jovK2+kdykbrM2sgjWaHEMa74DdLDluhwzq2+onW11OaPFygVsRMpJUfiWCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9LdBgo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1945FC4CED6;
	Mon, 24 Feb 2025 06:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740377502;
	bh=DusIi7MLerQhf4R4o7zGcF+PN1nI4nAAOn4TINKuBZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q9LdBgo6gn60zqBwNsfLakHlyukhwiEMdDEuBWfkfiTHiri/zf7/FrBPfVekflwJp
	 VjH8RDt3fppn5GL2km5+ZqYofCybcTaBmh65krCe4azTiBvsYESwMcSRD+GIoEa8bP
	 pkjIJYyMjg/Dy51L2yDYewVvI9uggn2qRAZAkbWAO5+4LAIADa5dSc49IIvE9zhffs
	 Dp56Eed8d+Emmppiex4u1JdgoaCgD/L3spcLYMmAMMgHBRxXfkFJO8DpDBtP3E7WfC
	 VvmZBWoD4+XtNAxuFHZpIYr/o7Wl7hkFMoQXpDdxRtJ89j2p5YPGlM0vIHuGsYx6Bg
	 iwMX6lNUGtKcA==
Message-ID: <105491ee-17a1-4f6d-aa0c-5cb5864d185c@kernel.org>
Date: Mon, 24 Feb 2025 14:11:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] f2fs: fix to ensure queued discard commands are
 properly issued
To: Daeho Jeong <daeho43@gmail.com>
Cc: Yohan Joung <jyh429@gmail.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Yohan Joung <yohan.joung@sk.com>
References: <20250204145353.165-1-yohan.joung@sk.com>
 <53598146-1f01-41ad-980e-9f4b989e81ab@kernel.org>
 <CACOAw_x2v9fhorDWx9+f4VufddSPA5S6PF22AM_56smjjD5Faw@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_x2v9fhorDWx9+f4VufddSPA5S6PF22AM_56smjjD5Faw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/21/25 23:56, Daeho Jeong wrote:
> On Mon, Feb 17, 2025 at 4:38 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2/4/25 22:53, Yohan Joung wrote:
>>> F2FS zone storage requires discard and reset zone for each conventional,
>>> zoned device.
>>> In the current configuration, Discard granularity is set to the zone
>>> size but queuing is inserted into the pend list with a maximum size of the
>>> segment size As a result queued commands cannot be issued.
>>> so we are restorting discard granularity to its original state
>>
>> It seems commit 4f993264fe29 ("f2fs: introduce discard_unit mount option")
>> introduced a bug: when we enable discard_unit=section option, it will set
>> .discard_granularity to BLKS_PER_SEC(), however discard granularity only
>> supports [1, 512], once section size is not equal to segment size, it will
>> cause bug. blkzoned feature became the victim since it use
>> discard_unit=section option by default.
>>
>> What:           /sys/fs/f2fs/<disk>/discard_granularity
>> Date:           July 2017
>> Contact:        "Chao Yu" <yuchao0@huawei.com>
>> Description:    Controls discard granularity of inner discard thread. Inner thread
>>                 will not issue discards with size that is smaller than granularity.
>>                 The unit size is one block(4KB), now only support configuring
>>                 in range of [1, 512]. Default value is 16.
>>                 For small devices, default value is 1.
>>
>> What about this?
>>
>> Subject: [PATCH] f2fs: fix to set .discard_granularity correctly
>>
>> commit 4f993264fe29 ("f2fs: introduce discard_unit mount option") introduced
>> a bug, when we enable discard_unit=section option, it will set
>> .discard_granularity to BLKS_PER_SEC(), however discard granularity only
>> supports [1, 512], once section size is not equal to segment size, it will
>> cause issue_discard_thread() in DPOLICY_BG mode will not select discard entry
>> w/ any granularity to issue.
>>
>> Fixes: 4f993264fe29 ("f2fs: introduce discard_unit mount option")
>> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  fs/f2fs/segment.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 6ebe25eafafa..2b415926641f 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -2320,10 +2320,9 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>>         dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
>>         dcc->max_ordered_discard = DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY;
>>         dcc->discard_io_aware = DPOLICY_IO_AWARE_ENABLE;
>> -       if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
>> +       if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT ||
>> +               F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
>>                 dcc->discard_granularity = BLKS_PER_SEG(sbi);
>> -       else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
>> -               dcc->discard_granularity = BLKS_PER_SEC(sbi);
>>
>>         INIT_LIST_HEAD(&dcc->entry_list);
>>         for (i = 0; i < MAX_PLIST_NUM; i++)
>> --
>> 2.48.1.601.g30ceb7b040-goog
>>
> 
> Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks for the review, let me send a formal patch.

Thanks,

> 
>>


