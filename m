Return-Path: <linux-kernel+bounces-557179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61264A5D498
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E993E3B5966
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB9F19D080;
	Wed, 12 Mar 2025 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="G1jxs9nR"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B97DA6D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741748749; cv=none; b=cP5Qf8KYUNGlBJp7ONH/Xy3GtRAHL9YjNB5FJH06eeLwxuzdzJMYizgtEWEkA8VDTR4IMKiWDW4GwxcXPR3Q8OUHdSur/mfIbGa56w1ilDJ/LXDf/yKkt68S2TabyWSH+ldWxgs9f9283P5+HOmI7/9yKwOPnA0WvkWZIc3qXDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741748749; c=relaxed/simple;
	bh=AZVGWwpSs6vVA7gZ8qiQaYBcWp/tS3lx7Jf9klKPgbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJk+zkPqybNsZnvGjEy+KNTLK3/ENb+ZiAWn3jbVXIeNKoMCgrAKt7um/iwXv882aCQEA2kfeUqUoiYzVPSxgWe0ORuI+qg5J8LxdG+4UtT8KZcRflD/ysRW/Lc280cv6PYW63XnnxKK2Ps9GD0cs5TFNizq490M6XkGEyNfp8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=G1jxs9nR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225477548e1so69506635ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741748746; x=1742353546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxIJUbJst/FnriyNqJsBfUw8Y0pzbE0QuiyjoQaWCNg=;
        b=G1jxs9nR1wX916WyUOWmw+jdyfOl1AYHXHQSTF5BON4UULyyQTjqBj97bd1dKGmvFa
         71AVhzIrWlDDn+O7Wcyy9jb8EO25qS0v9zRbLz7UBiQetF4VoXPS0ACkZU3dL3XTDhi4
         USywb72AcbfjGBesV25Rj3NufF4FVoBBq1owVHpojE61f0nd9BYVBxcZnmHg28SYEPKr
         UU34v/t1rJ8XLwoqQdqj+oZ34dHLKOdUiZy+16HsPayu7/GtT7nwA1jGcOJihMQ/ncuI
         jcsC5tXZoaNzjN4d1SEWB29b8Kl3H/Gq/6QaDwRj7eL2FvQlWiccYm4IsZmrBRj+TPj4
         5bMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741748746; x=1742353546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxIJUbJst/FnriyNqJsBfUw8Y0pzbE0QuiyjoQaWCNg=;
        b=JbUKr9N8hQhwhYLaHq/UXzBf8gKKI3tkO6XOrndXFA/YKHRJEmNSxqvVSpRVB9IrxS
         q3lw0GM+wd9+CSN33HUY3ZWofEMT5LqxLm1ULTUbCboVHLQfIJY422L1GNVbp1TvknXZ
         ibdhDmsHWOEaemfyIdR7MK7CVIJOqTe+K2Brt1IyUrAFb/XVjZK29nfpOBQOvHzhYzzd
         ZPGkMD0aRAqhw6ilxcp8yeZJd4ZaJ34Y8ViKNelAccBuY6tX6fsr17rlxYBdAD3RM9Ck
         doGseEd9wryRJSHYvihCyDEI0louiMxIGXXllfTbOr9VYMzcNjH9KdDvsi4nSgHViVOz
         nMGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtlsR0K0qbZympo19Sf2z4oO0q+UmJuRyZNWuhiXcvfM3hJHmUeWQYzf9vr++oL5gGlYmwsVgtabqT7UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqjG3KjLmI0L11/cU+19ZgKoX2a8Guw6i7ScKFmIE4CRFrlyZ
	tRCXI4+U2K9eU67XbrO8lN1eXUqIs8F0DLjtx5HBBxVY8pmnHBaWPP6qaWusW1c=
X-Gm-Gg: ASbGncuAwYdoFlF/gT6XJZblOeF5GAyDdSlBzh96i/PeUUYvsyjwyHrgHXlb68/X1IR
	jx3KWc5wWUlQ+VDQ61Ll1uCUT8ui3+CUiCsGvXDKupLfzF3M7EnwijXVV1rwz5oTmCBxIYchyCh
	29qkNrzqc8zTk+2W3Wkc+3EGzrYlcp1bSfV0Eju64rNd/pMYhhOxX1Lj0yNrIXFhg2NX6JIYn1+
	U8i9oQlLg78dKGQqG8BArwtvuUxEAHk7l56HBIlIJhZ8RLIsdSDJE/5/pr/thgTA9u6fY2JuFcO
	sLxBHBFllrJPx8HgrU5p3OktnRA7dFBjcuAFUfQB8Xw4n5glUFGah0uO8kOcXV7g75x50E4WpNa
	F
X-Google-Smtp-Source: AGHT+IEMHkbd6b0xTC0DUBVIL+QnQKlshOyaYInuo6Qt8/bg6Hart/Gd6hDiomd/nTFlnaC/tp1Mrw==
X-Received: by 2002:a05:6a00:174b:b0:736:5f75:4a3b with SMTP id d2e1a72fcca58-736aaa1cfaamr28287847b3a.7.1741748745637;
        Tue, 11 Mar 2025 20:05:45 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bf9f1852sm7433158b3a.117.2025.03.11.20.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 20:05:45 -0700 (PDT)
Date: Wed, 12 Mar 2025 12:05:30 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] btrfs: ioctl: use registered buffer for
 IORING_URING_CMD_FIXED
Message-ID: <Z9D5-muwGmdVqSDl@sidongui-MacBookPro.local>
References: <20250311114053.216359-1-sidong.yang@furiosa.ai>
 <20250311114053.216359-3-sidong.yang@furiosa.ai>
 <58181ba7-dcb5-4faa-a03a-8ff88cbffc24@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58181ba7-dcb5-4faa-a03a-8ff88cbffc24@gmail.com>

On Tue, Mar 11, 2025 at 12:55:48PM +0000, Pavel Begunkov wrote:

Hi Pavel,

> On 3/11/25 11:40, Sidong Yang wrote:
> > This patch supports IORING_URING_CMD_FIXED flags in io-uring cmd. It
> > means that user provided buf_index in sqe that is registered before
> > submitting requests. In this patch, btrfs_uring_encoded_read() makes
> > iov_iter bvec type by checking the io-uring cmd flag. And there is
> > additional iou_vec field in btrfs_uring_priv for remaining bvecs
> > lifecycle.
> > 
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> >   fs/btrfs/ioctl.c | 26 +++++++++++++++++++++-----
> >   1 file changed, 21 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 6c18bad53cd3..586671eea622 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -4643,6 +4643,7 @@ struct btrfs_uring_priv {
> >   	struct page **pages;
> >   	unsigned long nr_pages;
> >   	struct kiocb iocb;
> > +	struct iou_vec iou_vec;
> 
> This structure should not be leaked out of core io_uring ...

Agreed, but this was needed that priv needs to have bvec than iovec.
Thinking about this, just adding bvec or make union with iov is
simple way to do this.

> 
> >   	struct iovec *iov;
> >   	struct iov_iter iter;
> >   	struct extent_state *cached_state;
> > @@ -4711,6 +4712,8 @@ static void btrfs_uring_read_finished(struct io_uring_cmd *cmd, unsigned int iss
> >   	kfree(priv->pages);
> >   	kfree(priv->iov);
> > +	if (priv->iou_vec.iovec)
> > +		kfree(priv->iou_vec.iovec);
> 
> ... exactly because if this. This line relies on details it
> shouldn't.

Yes, we don't need this.

Thanks,
Sidong

> 
> -- 
> Pavel Begunkov
> 

