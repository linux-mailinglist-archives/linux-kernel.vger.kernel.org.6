Return-Path: <linux-kernel+bounces-425175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E659DBE81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2A8B20F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD1D14B07A;
	Fri, 29 Nov 2024 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeJDpuy5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D83422EE4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 02:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732845681; cv=none; b=hrRILrsUajlLAPY6QnQp2EHCTC4gIVls48tR+Y1coKn9aFOjZX0lQ7rstyAe5qG1FyPrTn7L4dKwodbQ2X14ohGQjppNrfYZnHno8oHsRPGZ0ajMuqyJ2AeBS9lK+eqFbXqKY+P8UnTmTtfVBIgtlEuN5HEMDlOEeWjG6j8Oxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732845681; c=relaxed/simple;
	bh=xXZFwynv6anzz67LCtvbnWIsKlnNImIWMTMGnxNcqk4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fNCTyikEN3jdgzpXl4oGT3f2KSpT8MUnBOh9iLcZjUyyEz++p9kF0MUN5SxO4YNa4LEjnA030yc1AvXvAnfEeCF1AbTM5f9q5mgFvoh1rhgywI3bh0PT7Fmec8Xdlq9UWxvGBG6hsPGC9DBEeZzuGKY/44fbthkiJlAs8gKn0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeJDpuy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2275C4CECE;
	Fri, 29 Nov 2024 02:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732845681;
	bh=xXZFwynv6anzz67LCtvbnWIsKlnNImIWMTMGnxNcqk4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=EeJDpuy5lFk7zngbyXmuE0X0gkbRfeoQsPLX9AJk9wdksa9gFhpstCKY3xFC/v3ve
	 QC7TXK2r54R4TksjNm5HuTQZ2bGW2ZwRiqPB6pM/JxoXVrhSiSPsjzF4bw24XzN+VY
	 iV17bH0fThNghNU0qT5XmQa+kJc0sJBRWnQPn3uObZUEoPvqHC4DGRVxAXRJvYwLxS
	 lq8dV+kx9qQTYYAS4OCxfhke/OmNlklznD8GHjhdIFDVduztC4DgRMC4TQgBnou3jN
	 DDvnfQYOa7IiPbp0rHNntjd1/+eHfwRKzZ5/icJLeXQGISp34mU8THj5pbeUnwQEBS
	 OWNwQ+frZayPQ==
Message-ID: <63a65be2-7ad9-4d65-8c3e-d872f83c011d@kernel.org>
Date: Fri, 29 Nov 2024 10:01:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: Add check for deleted inode
To: Leo Stone <leocstone@gmail.com>, jaegeuk@kernel.org
References: <20241124010459.23283-1-leocstone@gmail.com>
 <1652260c-7657-4f40-ac79-027666f512f0@kernel.org>
 <icjuhtz35zvp5j6zvgbubydbmirbsr4ceasgxr3rk333bj55dp@mp5yf532hd4i>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <icjuhtz35zvp5j6zvgbubydbmirbsr4ceasgxr3rk333bj55dp@mp5yf532hd4i>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/26 1:56, Leo Stone wrote:
> On Mon, Nov 25, 2024 at 07:16:41PM +0800, Chao Yu wrote:
>>
>> I'm fine w/ this change, but I didn't get it, how did above commit introduce
>> this bug?
> 
> Hello Chao,
> 
> The commit from the bisect didn't exactly introduce this bug, since it
> would still be possible to make a different image that does the exact
> same thing in the older code.
> 
> This commit was blamed in the bisect because it changes the layout of
> struct f2fs_inode:
> 
>> @@ -271,6 +272,10 @@ struct f2fs_inode {
>> 			__le32 i_inode_checksum;/* inode meta checksum */
>> 			__le64 i_crtime;	/* creation time */
>> 			__le32 i_crtime_nsec;	/* creation time in nano scale */
>> +			__le64 i_compr_blocks;	/* # of compressed blocks */
>> +			__u8 i_compress_algorithm;	/* compress algorithm */
>> +			__u8 i_log_cluster_size;	/* log of cluster size */
>> +			__le16 i_padding;		/* padding */
>> 			__le32 i_extra_end[0];	/* for attribute size calculation */
>> 		} __packed;
>> 		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
> 
> This changes F2FS_TOTAL_EXTRA_ATTR_SIZE, which allows the syzbot
> reproducer's inode to pass the sanity check for corrupted i_extra_size.
> Before this change, the inode gets rejected as corrupt:
> 
>> [   62.794566][ T9662] F2FS-fs (loop0): sanity_check_inode: inode (ino=7) has corrupted i_extra_isize: 36, max: 24

Leo,

Ah, right, thanks for the explanation, anyway, can you please correct this
"Fixes line"?

Thanks,

> 
> Thanks,
> Leo


