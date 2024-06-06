Return-Path: <linux-kernel+bounces-204105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012A98FE435
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D0D286344
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43068194C6C;
	Thu,  6 Jun 2024 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adTpfS4u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC21194AF1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669558; cv=none; b=ERoUllElF8adBaHjrefs1ganfHYkzgJOgsS1eSLgWHIOkqX0LAU3w8GR+Lq5/BdERwPcD/DciKAbrilb2kEmLobmU/xdvEeyPQMl97BkDamK1cpZSZ+5Pwl1yBH4+H0dk335dhEHvg6nuoutmr4ka5dvSsfhAjJ4g6ISFHEnw+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669558; c=relaxed/simple;
	bh=EML4Iu9obdDE1EzLWPCy+Tg6xc1taE+7rID1/jbyoWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCy1fQODZddtMkUTO7LMShL51D6ZQiM6dV56kQRbJSHwmAxmUixH/Vff+eEMJgylXUfazdy3WjAjt7npLTMWG3mjAWi/va9rtK+E3ZvFWpuqrxqwG1Pp+5KY1ERBdxR7eqdHgRnD5bqmLAdMtIta0oG7PcNYFZn9c93gwBe8J2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adTpfS4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEDFC4AF0E;
	Thu,  6 Jun 2024 10:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717669558;
	bh=EML4Iu9obdDE1EzLWPCy+Tg6xc1taE+7rID1/jbyoWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=adTpfS4u6O7p4cccXFmpZ6PGWSlYTab+RkGczPewwAisg7qVq3ZDcx1/X5/+vSDMU
	 9+uPjcTeO+6x90ZSsfWJExpRNXRt1DdeICbRWWOd8HXiLECUnbhglu9Citbj4LvXCV
	 Q8HPgl9mzJfYorBONIJcLnR3nOsL5s1SO0QNtuHd3SHr29bsqmCocVKKS+iZQz88WQ
	 sL1eCqUp4M6h8yoU6vEtqtS74xKvIOttDQ8H3JFWBXEbrp3R1ikB5yuguCRcEN15sb
	 NP1ub/QQDsdFU3ieXtWkjprff5hBl5iPS+7xhe2VJV/a3WP61+xPDkx17IG6jsPLde
	 asMQahX3PzlOw==
Message-ID: <62c9301c-eea4-4e35-9b6e-04525769985a@kernel.org>
Date: Thu, 6 Jun 2024 18:25:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: fix to avoid racing in between read and OPU dio
 write
To: Wu Bo <bo.wu@vivo.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20240510023906.281700-1-chao@kernel.org>
 <20240515083219.1601289-1-bo.wu@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240515083219.1601289-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/15 16:32, Wu Bo wrote:
> On Fri, May 10, 2024 at 10:39:06AM +0800, Chao Yu wrote:
>> If lfs mode is on, buffered read may race w/ OPU dio write as below,
>> it may cause buffered read hits unwritten data unexpectly, and for
>> dio read, the race condition exists as well.
>>
>> Thread A                      Thread B
>> - f2fs_file_write_iter
>>   - f2fs_dio_write_iter
>>    - __iomap_dio_rw
>>     - f2fs_iomap_begin
>>      - f2fs_map_blocks
>>       - __allocate_data_block
>>        - allocated blkaddr #x
>>         - iomap_dio_submit_bio
>>                                - f2fs_file_read_iter
>>                                 - filemap_read
>>                                  - f2fs_read_data_folio
>>                                   - f2fs_mpage_readpages
>>                                    - f2fs_map_blocks
>>                                     : get blkaddr #x
>>                                    - f2fs_submit_read_bio
>>                                IRQ
>>                                - f2fs_read_end_io
>>                                 : read IO on blkaddr #x complete
>> IRQ
>> - iomap_dio_bio_end_io
>>   : direct write IO on blkaddr #x complete
>>
> Looks like every COW filesystem would meet this situation. What's the solution
> of other FS?

I missed to reply this...

Other cow filesystem like btrfs, it will update metadata after data IO completion,
so it is safe.

Thanks,

>> This patch introduces a new per-inode i_opu_rwsem lock to avoid
>> such race condition.
>>

