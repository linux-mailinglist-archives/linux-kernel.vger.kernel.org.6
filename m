Return-Path: <linux-kernel+bounces-394180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F889BAB84
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FB31C2060E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B871632F5;
	Mon,  4 Nov 2024 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaS8IHuL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B276FC5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730691624; cv=none; b=s+q/e4RXnPnkTGUZw/QT5IVf4N4qGra3vAhTgUumDjLS2+dC6tF3VaaRFzaJorVuXGlgrihSAI69o+OESJ4G/gjDAx73duSe7llkGhoEXnqnuTxXvJZAadfI9pFag2/4G/6J+z29U2L7xFNfg2e/xKKZC7Wzj+u74M9Iml78q/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730691624; c=relaxed/simple;
	bh=ypH+68HSOJbIiIdIPZ7738g4MkZaWVv8H4tRN/NdEn0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=clP+Sx4LG7jSotkxBFnT/QrOTtsnrln21r7yWiiMk0W3zm5G/3QnzmP6Jt72AXPAEiA80Hg9OIF4vfTCl9Al0GC46RASxoKP3zWX/hEyA90cmkC7ydN1ZW2namHMWtNX5IR/JVPJiHduaBQjb3NNu2xpnXwji/Yw6EGZSCORA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaS8IHuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D07C4CED0;
	Mon,  4 Nov 2024 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730691624;
	bh=ypH+68HSOJbIiIdIPZ7738g4MkZaWVv8H4tRN/NdEn0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=iaS8IHuLUv7B6/uOasNzXCcZPxpMWHI7zj71RYktoLPpVgfEY2IiI3CBd1Rw4Twxf
	 /+mT1xbwAD7wp+U5mwRtV2fdreZvPAv4PHwnL3m6vn+nWCJXiVIniWHXtvttqYDEUn
	 RdWUSzzKUgIGLECh478SiShVPyAByxMMKxEjAjB/lz6LY6tcUzW7J9k1N98/SU7nnU
	 EiFdSDMER0ceeakFjCyWuD2Px9aQatUclZ5ExcBIKjA2bsmnET72Nvq74htRFFCxC5
	 GaK/CvfFFkCdrhdpTJeTDrT5muClAht4r/DC6qfoEuSHMCYkPUi4IWdK8ij2ntLHUh
	 XgJe6JcWnVIZw==
Message-ID: <7f5af1ac-ff50-4e9d-b4a8-94d7a6a2f378@kernel.org>
Date: Mon, 4 Nov 2024 11:40:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid forcing direct write to use
 buffered IO on inline_data inode
To: jinsu1.lee@samsung.com,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
References: <CGME20241104022816epcms2p2213e9a1b0003cfeb30521927252b6bbe@epcms2p2>
 <20241104022816epcms2p2213e9a1b0003cfeb30521927252b6bbe@epcms2p2>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241104022816epcms2p2213e9a1b0003cfeb30521927252b6bbe@epcms2p2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/11/4 10:28, Jinsu Lee wrote:
>> Jinsu Lee reported a performance regression issue, after commit
> 
>> 5c8764f8679e ("f2fs: fix to force buffered IO on inline_data
> 
>> inode"), we forced direct write to use buffered IO on inline_data
> 
>> inode, it will cause performace regression due to memory copy
> 
>> and data flush.
> 
> 
>> It's fine to not force direct write to use buffered IO, as it
> 
>> can convert inline inode before committing direct write IO.
> 
> 
>> Fixes: 5c8764f8679e ("f2fs: fix to force buffered IO on inline_data inode")
> 
>> Reported-by: Jinsu Lee <jinsu1.lee@samsung.com>
> 
>> Closes: https://lore.kernel.org/linux-f2fs-devel/af03dd2c-e361-4f80-b2fd-39440766cf6e@kernel.org
> 
>> Signed-off-by: Chao Yu <chao@kernel.org>
> 
>> ---
> 
>> fs/f2fs/file.c | 6 +++++-
> 
>> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> 
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> 
>> index 0e7a0195eca8..377a10b81bf3 100644
> 
>> --- a/fs/f2fs/file.c
> 
>> +++ b/fs/f2fs/file.c
> 
>> @@ -883,7 +883,11 @@ static bool f2fs_force_buffered_io(struct inode *inode, int rw)
> 
>>                  return true;
> 
>>          if (f2fs_compressed_file(inode))
> 
>>                  return true;
> 
>> -        if (f2fs_has_inline_data(inode))
> 
>> +        /*
> 
>> +         * only force direct read to use buffered IO, for direct write,
> 
>> +         * it expects inline data conversion before committing IO.
> 
>> +         */
> 
>> +        if (f2fs_has_inline_data(inode) && rw == READ)
> 
> 
> Chao Yu,
> 
> The fio direct performance problem I reported did not improve when reflecting this commit.
> 
> Rather, it has been improved when reflecting your commit below.
> 
> 
> The previous commit seems to be mistitled as read and the following commit appears to be the final version.
> 
> The reason for the improvement with the commit below is that there is no "m_may_create" condition
> 
> when performing "io_submit" directly, so performance regression issue may occur.
> 
> 
> I wonder if "rw == READ" should be additionally reflected.

Alright, thanks for your feedback.

I thought you have bisected this performance issue to commit
5c8764f8679e ("f2fs: fix to force buffered IO on inline_data inode"),
so I sent this patch for comments.

Can you please apply both below dio fixes, and help to check final
performance?

https://lore.kernel.org/linux-f2fs-devel/20241104015016.228963-1-chao@kernel.org
https://lore.kernel.org/linux-f2fs-devel/20241104013551.218037-1-chao@kernel.org

Thanks,

> 
> 
> commit 2b6bb0cd3bdcb1108189301ec4ec76c89f939310
> 
> Author: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
> 
> Date:   Mon Nov 4 09:35:51 2024 +0800
> 
> 
>      [f2fs-dev] [PATCH v2] f2fs: fix to map blocks correctly for direct write
> 
> 
> 


