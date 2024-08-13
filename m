Return-Path: <linux-kernel+bounces-284051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA1F94FC6D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A631283655
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772851C286;
	Tue, 13 Aug 2024 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP7u6ZPY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA7179AE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723521033; cv=none; b=JbK6nU53We5aeekd8uFz+ciONzR7nGqw9r+DLazRTeYFkF48CYj4yW4+r/EDm93mUjllkUFUuRsDx92t8A5dtxqUW99Nc1dsa2beKoB7jC2v0f5vtWLi+PlY08w8IuToBQoLAGo5x5XFbQOHHavEY2VDKpIVkcwNBfiUwGnmJAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723521033; c=relaxed/simple;
	bh=HpdtZYHIgVKl77goaydOo9aidbpvk6Qq/wAQSe6qc7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBkK/cWgcOtsp66xq/DQQrZeZ8GHump0XkYFVG6ZcsdTwNYws2Q6ZxHmkLHGjweFh4DeOhcXTJDgnlpNme8Sup3/M6eflI7jFKOXtfusW+ZvZm6dDL/KFz0xPA+Ev3MNzUu3gEcqke7Z0DwN0f04l6BlHTtlWllaCAxyGc1Nk4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP7u6ZPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6712CC4AF09;
	Tue, 13 Aug 2024 03:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723521033;
	bh=HpdtZYHIgVKl77goaydOo9aidbpvk6Qq/wAQSe6qc7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OP7u6ZPY7GSUWNf/vCvhyqHQtlDllJh0pJ4KfusC4V8IU3VWuhm+Vg6/Jc245AdWK
	 kDXj7uxXB75Wn1BQ3xn/wW+7pVd6BVWP2mNaGwVuP9h8T6I8gnXLobWlPwpeoBUZfE
	 LQL9xe3HBA+N1aSallpruLfjMgL+7s5EG5p9FIxpF68Bm5mx6R2dlo8RImUZOdaWNI
	 /cGBLjEzm7TwTqz8OIpugGJhOa9hUx56TNhGwevG6qgJHJd3KY2YWT+iMdhITv08HW
	 Wir7mJLaHj58Iyq6jMwWGIIkKfe2SNILVt5+Kpfn9LYnn4JuuFjWDjw6Emye2rsTeg
	 U1SACqNBniI4w==
Message-ID: <e82ab6dd-f4a6-4648-a4b4-b092f2eaf2be@kernel.org>
Date: Tue, 13 Aug 2024 11:50:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: file: add checks to f2fs_ioc_flush_device()
To: Roman Smirnov <r.smirnov@omp.ru>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Karina Yankevich <k.yankevich@omp.ru>,
 lvc-project@linuxtesting.org
References: <20240801071707.8296-1-r.smirnov@omp.ru>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240801071707.8296-1-r.smirnov@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/1 15:17, Roman Smirnov wrote:
> If invalid data is copied from user space and if GET_SEGNO()
> returns NULL_SEGNO an overflow is possible.

Can you explain in which condition that FDEV(range.dev_num).start_blk or
FDEV(range.dev_num).end_blk will be invalid?

 > > Add checks for invalid values.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> ---
>   fs/f2fs/file.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 168f08507004..1b9c4fee9db1 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3093,6 +3093,9 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
>   		start_segno = dev_start_segno;
>   	end_segno = min(start_segno + range.segments, dev_end_segno);
>   
> +	if (start_segno > F2FS_MAX_SEGMENT - range.segments || end_segno == NULL_SEGNO)
> +		return -EINVAL;

It missed to call mnt_drop_write_file() before return.

Thanks,

> +
>   	while (start_segno < end_segno) {
>   		if (!f2fs_down_write_trylock(&sbi->gc_lock)) {
>   			ret = -EBUSY;


