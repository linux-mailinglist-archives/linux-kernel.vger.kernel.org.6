Return-Path: <linux-kernel+bounces-231008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D259184DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0A928C4BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830D8185E46;
	Wed, 26 Jun 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6vZeqAr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3143184113
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413536; cv=none; b=HoasorGpQR56iX0WUqZBHpw9muRrk3XAzfE85URfXtAHtAy7R+hUORYai95WZoTvQOGSS6rLIJz5mNV3F8Mts4TdqO4mW6rCD7BPwjtr2ma7NPWlhRbZFUoqlihCxeaBfrHW36hbdgQYlj8ufkjjKdliBBJZV6FJ8YVAJuAlZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413536; c=relaxed/simple;
	bh=3x9aUwLlLr35lFq9vjm9SpBmwK+WBb/nORwA4i0c9DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAKEbsvval/ERKCIFrIzzwyr6Ip2EeiOL/vfNRl6NkMfOU/Il6RzjUDwDsyJSeJXLABbGpd6e8cT+WeJpxCFblDYauxSIwGWfdpsaBHapQfAA7nWsADmtYgBCgAWygJKDMIIu4TfGn9f2/8ZBDEBh7RYeH3uxPh9MvpTvwkevTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6vZeqAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8A6C32782;
	Wed, 26 Jun 2024 14:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719413536;
	bh=3x9aUwLlLr35lFq9vjm9SpBmwK+WBb/nORwA4i0c9DU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R6vZeqArLHkWtIXakOJchVtRCtfukG1OGrQEcksKO6X0MW3WQwRUtIcrp2Sw6I75t
	 EKqMd4D49oSKgE9td3r86efsJhBGyAPmJvToRNXGFLQhKkCGEquOAYhv/fRsPG13QU
	 1CCNZEQuwNZcLwDcckB+gZrZCD6Lz/lIXEWMczORqmqBhwhLJDRB7/896TArFwyQcl
	 eGfH7mPHZVZRCNaL+diJyl4AL2pBzvEa/pi+aN9yugbX6N7nIph4BnG4yGDOPFDvDp
	 nmKXRl24tiucXIf3S7J72+n43/nVTuk8nzq3RwJGTm5A2CEzl9s4+5/N0u23V/Gaay
	 Vhz4wZ2032ZKA==
Message-ID: <f5f4f84d-1719-4e8c-a2ce-71453884b19e@kernel.org>
Date: Wed, 26 Jun 2024 22:52:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid racing in between read
 and OPU dio write
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240625142512.3916063-1-chao@kernel.org>
 <CAHJ8P3+VUozoMVHvMxqDrDRVttRWDJ5a4A2ysJv2_O4ytfq8OA@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <CAHJ8P3+VUozoMVHvMxqDrDRVttRWDJ5a4A2ysJv2_O4ytfq8OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/6/26 10:01, Zhiguo Niu wrote:
> Chao Yu <chao@kernel.org> 于2024年6月25日周二 22:29写道：
>>
>> If lfs mode is on, buffered read may race w/ OPU dio write as below,
>> it may cause buffered read hits unwritten data unexpectly, and for
>> dio read, the race condition exists as well.
>>
>> Thread A                        Thread B
>> - f2fs_file_write_iter
>>   - f2fs_dio_write_iter
>>    - __iomap_dio_rw
>>     - f2fs_iomap_begin
>>      - f2fs_map_blocks
>>       - __allocate_data_block
>>        - allocated blkaddr #x
>>         - iomap_dio_submit_bio
>>                                  - f2fs_file_read_iter
>>                                   - filemap_read
>>                                    - f2fs_read_data_folio
>>                                     - f2fs_mpage_readpages
>>                                      - f2fs_map_blocks
>>                                       : get blkaddr #x
>>                                      - f2fs_submit_read_bio
>>                                  IRQ
>>                                  - f2fs_read_end_io
>>                                   : read IO on blkaddr #x complete
>> IRQ
>> - iomap_dio_bio_end_io
>>   : direct write IO on blkaddr #x complete
>>
>> In LFS mode, if there is inflight dio, let's force read to buffered
>> IO, this policy won't cover all race cases, however it is a tradeoff
>> which avoids abusing lock around IO paths.
>>
>> Fixes: f847c699cff3 ("f2fs: allow out-place-update for direct IO in LFS mode")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/file.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 278573974db4..866f1a34e92b 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -882,6 +882,10 @@ static bool f2fs_force_buffered_io(struct inode *inode, int rw)
>>                  return true;
>>          if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
>>                  return true;
>> +       /* In LFS mode, if there is inflight dio, force read to buffered IO */
>> +       if (rw == READ && f2fs_lfs_mode(sbi) &&
>> +                       atomic_read(&inode->i_dio_count))
>> +               return false;
> Hi Chao,
> A little doubt:)，force “buffered IO” should return "true"?

Oops, too rush to send the patch...

> another want to confirm is, "thread B" in commit msg just doing buffer
> read, so this modification just cover direct read case？

Oh, the fix is incorrect, will look into it soon.

Thanks,

> thanks！
>>
>>          return false;
>>   }
>> --
>> 2.40.1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

