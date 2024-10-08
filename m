Return-Path: <linux-kernel+bounces-354408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB12993D23
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDBA284F05
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BB922075;
	Tue,  8 Oct 2024 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWRBBK3a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C786225A8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356241; cv=none; b=Kapgx6raUEiG0y1q8Cwml+UcEliAw1zKbwjLk68/phMwiAvy/ac9SrBL1U2nARXzSTR7WWHUYoZPF3BAcQhsb9xgCAF+SqFWsrd4xbr0QKZcw1xrvDP5JHoI+l1nUwmaBlrKYx756uvTe7OcQijRtrv/8rcpsmYzYYOgv9kFaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356241; c=relaxed/simple;
	bh=tYoizC/9cSnXCwqV2/3ziGZiBxqaimtQwdOuus2djNk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p4dUu+BavKYI2n0qAdDCEA0DfXM/DbI5kNw2tl013BfWZ4FdSVRB9YbF1/6JnD2Bh48qw5OXuj5VjZNyIi6KxLFACV+2R06jQiizS0PPWSCPi6+FzFxV/3jDqBfWC3g6l3jpa/qMeF/dLGYir5bdbKX9w2Gp5Kanx/T0rdiR7mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWRBBK3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F89C4CEC6;
	Tue,  8 Oct 2024 02:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728356238;
	bh=tYoizC/9cSnXCwqV2/3ziGZiBxqaimtQwdOuus2djNk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=lWRBBK3aekOSw3rSwB8/IVBqPVdRCkivOODPjnsXjj4rJLnWLrMxtlmos0NlY2hMt
	 vBFs3ER2eOdceh9By5c3T0B3pRbbILRlwnQ31H8SPxX8hDSs2/n0k7ZQChnNNzsCiQ
	 alLOvk/9GEsGVDRe8iwlYFLvQ4EFCs7F7Ok1pHjcgCS8CtOidSkX6HI0saAOkqDPwg
	 Rst8+NLHC/ZKSH/TFRlZ0cGVHEOLaAL2x5J/D0NTAS1iQspJ1W2ES9tP2ggmHqpUlg
	 LePdjzQ1NbudVf8V7JRi4ppyPJtMJ8DOVp5rd/tLfezGwe51jsTZMgRfDj8+X1FF1U
	 vgiWMeDTJofqg==
Message-ID: <1f0f8f49-b220-4b5d-a141-6d8dcecb9ab2@kernel.org>
Date: Tue, 8 Oct 2024 10:57:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: compress: fix inconsistent update of i_blocks in
 release_compress_blocks and reserve_compress_blocks
To: Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20240929080011.3802327-1-hanqi@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240929080011.3802327-1-hanqi@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/29 16:00, Qi Han wrote:
> After release a file and subsequently reserve it, the FSCK flag is set
> when the file is deleted, as shown in the following backtrace:
> 
> F2FS-fs (dm-48): Inconsistent i_blocks, ino:401231, iblocks:1448, sectors:1472
> fs_rec_info_write_type+0x58/0x274
> f2fs_rec_info_write+0x1c/0x2c
> set_sbi_flag+0x74/0x98
> dec_valid_block_count+0x150/0x190
> f2fs_truncate_data_blocks_range+0x2d4/0x3cc
> f2fs_do_truncate_blocks+0x2fc/0x5f0
> f2fs_truncate_blocks+0x68/0x100
> f2fs_truncate+0x80/0x128
> f2fs_evict_inode+0x1a4/0x794
> evict+0xd4/0x280
> iput+0x238/0x284
> do_unlinkat+0x1ac/0x298
> __arm64_sys_unlinkat+0x48/0x68
> invoke_syscall+0x58/0x11c
> 
> For clusters of the following type, i_blocks are decremented by 1 and
> i_compr_blocks are incremented by 7 in release_compress_blocks, while
> updates to i_blocks and i_compr_blocks are skipped in reserve_compress_blocks.
> 
> raw node:
> D D D D D D D D
> after compress:
> C D D D D D D D
> after reserve:
> C D D D D D D D
> 
> Let's update i_blocks and i_compr_blocks properly in reserve_compress_blocks.
> 
> Fixes: eb8fbaa53374 ("f2fs: compress: fix to check unreleased compressed cluster")
> Signed-off-by: Qi Han <hanqi@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

