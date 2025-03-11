Return-Path: <linux-kernel+bounces-556021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B481A5BFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB5B3A530F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C115253F13;
	Tue, 11 Mar 2025 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW2bYuQn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F3221F3C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694433; cv=none; b=p7W0nqPEw5QHfjtZfUNIer1C4ODcMjGwh6RLXUOoCZBdoxRv0zmruYrtlGtUnOfXs3KkVm87f8EyCAXEnupRYjwsD7lc1hoOd3YmXMUzwuc4LayZdyd2IgwE984Fy8mt8iqU924DvyDJ91Haq4BPalxDwABzaepQnp6Mcx/02Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694433; c=relaxed/simple;
	bh=UUkiOgx3l9K4c/V4+FZ1/gOMX9QIDKDarArDS8WEx9M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ccZPOM7iHW2tGdr5WQ2AGxd966oJp6MZllaRJBCH8NaP3JTz7zum0zN2N3NCskNd3jKcsoh/9DDOS/bTV5Sii5FR/sXnBz9OdvOCSlEiQxqlQ0/IXFq4LRpDe7wDA4DrMC7HMtXFF17h4MFt8L7JG2CxnGpWhh6WEI/zqg5dMDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW2bYuQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0426C4CEEC;
	Tue, 11 Mar 2025 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741694433;
	bh=UUkiOgx3l9K4c/V4+FZ1/gOMX9QIDKDarArDS8WEx9M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=TW2bYuQnuLjiIIhKubGCj7e0KKKz/2eN9gynz5I27Ev8DqUTQiUJfySH2UqnuImLn
	 g+zw7sMkPyytdcZUMMEHFB+mN39UyPm8eDm9eRZZvGAbegCfRvoj5qPMsqgnWA9Bna
	 gS1J+FFV6hBsRhnjbxXdkKvNKKG7mQh19QJepnZ1ZA3T1JsG0a6H0QBXNo1MXMyshl
	 EKYTNtLeB1YUgJnkWMn1x9cpWY+XbpvoioeWGJ94O2C8Lew8i2GbjdOwkyYsyaVnx0
	 H8S5Ch03TTR0UjYV3Amsq2kEmZ/BH7o+BqsXIDW0AgqMiSJ3WK8Ss0YHOJEfxEkVhc
	 lJphfKu5aMasA==
Message-ID: <936351d5-e99c-4c5b-bd8b-8d541122f709@kernel.org>
Date: Tue, 11 Mar 2025 20:00:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Yohan Joung <yohan.joung@sk.com>
Subject: Re: [PATCH] f2fs: optimize f2fs DIO overwrites
To: Yohan Joung <jyh429@gmail.com>, jaegeuk@kernel.org, daeho43@gmail.com
References: <20250307145650.568-1-yohan.joung@sk.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250307145650.568-1-yohan.joung@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 22:56, Yohan Joung wrote:
> this is unnecessary when we know we are overwriting already allocated
> blocks and the overhead of starting a transaction can be significant
> especially for multithreaded workloads doing small writes.

Hi Yohan,

So you're trying to avoid f2fs_map_lock() in dio write path, right?

Thanks,

> 
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/data.c | 20 ++++++++++++++++++++
>  fs/f2fs/f2fs.h |  1 +
>  fs/f2fs/file.c |  5 ++++-
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 09437dbd1b42..728630037b74 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4267,6 +4267,26 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	return 0;
>  }
>  
> +static int f2fs_iomap_overwrite_begin(struct inode *inode, loff_t offset,
> +		loff_t length, unsigned flags, struct iomap *iomap,
> +		struct iomap *srcmap)
> +{
> +	int ret;
> +
> +	/*
> +	 * Even for writes we don't need to allocate blocks, so just pretend
> +	 * we are reading to save overhead of starting a transaction.
> +	 */
> +	flags &= ~IOMAP_WRITE;
> +	ret = f2fs_iomap_begin(inode, offset, length, flags, iomap, srcmap);
> +	WARN_ON_ONCE(!ret && iomap->type != IOMAP_MAPPED);
> +	return ret;
> +}
> +
>  const struct iomap_ops f2fs_iomap_ops = {
>  	.iomap_begin	= f2fs_iomap_begin,
>  };
> +
> +const struct iomap_ops f2fs_iomap_overwrite_ops = {
> +	.iomap_begin	= f2fs_iomap_overwrite_begin,
> +};
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index c6cc2694f9ac..0511ab5ed42a 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3936,6 +3936,7 @@ void f2fs_destroy_post_read_processing(void);
>  int f2fs_init_post_read_wq(struct f2fs_sb_info *sbi);
>  void f2fs_destroy_post_read_wq(struct f2fs_sb_info *sbi);
>  extern const struct iomap_ops f2fs_iomap_ops;
> +extern const struct iomap_ops f2fs_iomap_overwrite_ops;
>  
>  static inline struct page *f2fs_find_data_page(struct inode *inode,
>  		pgoff_t index, pgoff_t *next_pgofs)
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 82b21baf5628..bb2fe6dac9b6 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4985,6 +4985,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
>  	const ssize_t count = iov_iter_count(from);
>  	unsigned int dio_flags;
>  	struct iomap_dio *dio;
> +	const struct iomap_ops *iomap_ops = &f2fs_iomap_ops;
>  	ssize_t ret;
>  
>  	trace_f2fs_direct_IO_enter(inode, iocb, count, WRITE);
> @@ -5025,7 +5026,9 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
>  	dio_flags = 0;
>  	if (pos + count > inode->i_size)
>  		dio_flags |= IOMAP_DIO_FORCE_WAIT;
> -	dio = __iomap_dio_rw(iocb, from, &f2fs_iomap_ops,
> +	else if (f2fs_overwrite_io(inode, pos, count))
> +		iomap_ops = &f2fs_iomap_overwrite_ops;
> +	dio = __iomap_dio_rw(iocb, from, iomap_ops,
>  			     &f2fs_iomap_dio_write_ops, dio_flags, NULL, 0);
>  	if (IS_ERR_OR_NULL(dio)) {
>  		ret = PTR_ERR_OR_ZERO(dio);


