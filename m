Return-Path: <linux-kernel+bounces-570019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10434A6AAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8195E7AB626
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C326E1B81DC;
	Thu, 20 Mar 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="AqttIiog"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDD01E3DEF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487582; cv=none; b=Uuoc+Al0TwaHMtuw2d1H9wxZTNg/udFIjOE8sioF/d2X2iR3cem7XHQdnwDUK4nRRImW0aeX6tQz4aB/3/iJOM35AuQnfxcHQfhZOGRr65juRTH4RdxZ3mQ/t33jTkA0vyo5pgvoj0X2Y3CG2HeHlfHyETUXMBojTHXVYmLX8N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487582; c=relaxed/simple;
	bh=qBJxg1shh5xIWb/EGEp/yZw666gWV1SYFdnG1TDjCyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7mVOlAIXQ6uH9lZjZr1bhY3cqj1GONQsOOqEpCxWq8qQcyuWraMPRewMuYPcICIPEh2Y5Jfn8wzfu04JjjpLjd7sH0O2Rd0YORM9YHF6TmULsQVb9xpaD8Twv8YpjKnTdovEY5ANCBvOm/TwrrHtQlESTn/1621tMSEWALK2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=AqttIiog; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2239c066347so24127115ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742487579; x=1743092379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E1EkxBQfCDmnx+n40Vp0lQXT3U/EpuuEwT1O/tsDLy8=;
        b=AqttIiogKzRrEVtvUGN2K9Xsux6kBQ2eXR67MVBG4b3bnlxxH0x9ujI7g+xf0dDygc
         /77HOQjrRowrjmnxrsM31rVDKtp8XbnQuZXKey0UadV+fSD9oIs2KIBVncoerm3xuqUA
         JMMuYK4WfcieUGuLUPB3PYzowcUH0cB7ZzNwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487579; x=1743092379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1EkxBQfCDmnx+n40Vp0lQXT3U/EpuuEwT1O/tsDLy8=;
        b=iPpyV0kXqZrxkxJvJG8O85n3EVjLN1mLg8bTp+mvCmxyz8jhvpo1y60i2ZV9qiPZbn
         czRo9EFapUTWWVjKQScS8conJbDB53wEjVAjwEKk30Kpnvf3x8OXrgosMMIlimikOzD6
         y9q3ow7rhH0j26e3f4LO7tQ5dzwQHxWEIYrbxMhtwQ64/NS/iJ04HTo3g1rSC+D1BX43
         H09TjsrxcPiW6YNsISHK8WwdusYzutQL0ZcYLVyxzDf+JyLYVjnuxsyb47ZOgiM+ur7Z
         qvwQvg/D3ELj0osnEfgkWZFGIx+YlGC6yfimrGZED9nXfNsx1fsx2+OfRrJBH+8bt4Oi
         ViYw==
X-Forwarded-Encrypted: i=1; AJvYcCUr5kS3NWOJVion1/ZCGboS8N1qQGrVzvJpl1W8/nW3Y10KUJQSPclpGAV1FBdvZTaQr/k/yTaVd395u9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnpAbHrBBJvNnhqxgZMvji76KA5dQuhG8At3hTigrTwx3r2Bwf
	x6oT/lT2hOPMC2JLyYEM9+1DJHtjj0QBjXipNDxSJyrvmCAYXICe2IJlmzJOCMM=
X-Gm-Gg: ASbGncudO5QVZVYq/WfhVsttzRTXf0a8c+MaqFyHlMnS9yyZdkQBbLQgaxbGOfKz6mG
	VaRwPow1QuLz33OCKWajHi2Cfdq6hRizV+AkV212DhLQnTwfH6rQJTKQajGfysJf2/X0AwHgcAd
	//9hRdEAFd/5QaVttkWX5FztroU5zD1SoFQVzyxC9rbd39x0hi+Gnf3SjtDFdQOFO03eZ/OX4jq
	M75suESH7SCaso8cagCHdMCQseaEfSRpmxkneIuKd+wDOtuhEfwjwFUV0OjeRTmPTGly5uzAfj/
	x6iW0nzQbsFV0baaMpwOBbVDrj4QUJ/ggj+JlHWSJYPC093ieuUJEC84I4d2RAAQWF1D+kukky8
	h
X-Google-Smtp-Source: AGHT+IHkoC8+a/PI1OgLEI6QOhiYG1kobquqNfEOAiiqzCU00hktNWB4i+b5NArdRabJhomNAfkeIg==
X-Received: by 2002:a17:903:2301:b0:220:f151:b668 with SMTP id d9443c01a7336-22780d9597dmr51485ad.20.1742487579151;
        Thu, 20 Mar 2025 09:19:39 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe766sm137642715ad.184.2025.03.20.09.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 09:19:38 -0700 (PDT)
Date: Fri, 21 Mar 2025 01:19:34 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v5 5/5] btrfs: ioctl: introduce
 btrfs_uring_import_iovec()
Message-ID: <Z9xAFpS-9CNF3Jiv@sidongui-MacBookPro.local>
References: <20250319061251.21452-1-sidong.yang@furiosa.ai>
 <20250319061251.21452-6-sidong.yang@furiosa.ai>
 <14f5b4bc-e189-4b18-9fe6-a98c91e96d3d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14f5b4bc-e189-4b18-9fe6-a98c91e96d3d@gmail.com>

On Thu, Mar 20, 2025 at 12:01:42PM +0000, Pavel Begunkov wrote:
> On 3/19/25 06:12, Sidong Yang wrote:
> > This patch introduces btrfs_uring_import_iovec(). In encoded read/write
> > with uring cmd, it uses import_iovec without supporting fixed buffer.
> > btrfs_using_import_iovec() could use fixed buffer if cmd flags has
> > IORING_URING_CMD_FIXED.
> 
> Looks fine to me. The only comment, it appears btrfs silently ignored
> IORING_URING_CMD_FIXED before, so theoretically it changes the uapi.
> It should be fine, but maybe we should sneak in and backport a patch
> refusing the flag for older kernels?

I think it's okay to leave the old version as it is. Making it to refuse
the flag could break user application.

Thanks,
Sidong

> 
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> > 
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> >   fs/btrfs/ioctl.c | 34 +++++++++++++++++++++++++---------
> >   1 file changed, 25 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 6c18bad53cd3..e5b4af41ca6b 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -4802,7 +4802,29 @@ struct btrfs_uring_encoded_data {
> >   	struct iov_iter iter;
> >   };
> > -static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue_flags)
> > +static int btrfs_uring_import_iovec(struct io_uring_cmd *cmd,
> > +				    unsigned int issue_flags, int rw)
> > +{
> > +	struct btrfs_uring_encoded_data *data =
> > +		io_uring_cmd_get_async_data(cmd)->op_data;
> > +	int ret;
> > +
> > +	if (cmd->flags & IORING_URING_CMD_FIXED) {
> > +		data->iov = NULL;
> > +		ret = io_uring_cmd_import_fixed_vec(cmd, data->args.iov,
> > +						    data->args.iovcnt, rw,
> > +						    &data->iter, issue_flags);
> > +	} else {
> > +		data->iov = data->iovstack;
> > +		ret = import_iovec(rw, data->args.iov, data->args.iovcnt,
> > +				   ARRAY_SIZE(data->iovstack), &data->iov,
> > +				   &data->iter);
> > +	}
> > +	return ret;
> > +}
> > +
> > +static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd,
> > +				    unsigned int issue_flags)
> >   {
> >   	size_t copy_end_kernel = offsetofend(struct btrfs_ioctl_encoded_io_args, flags);
> >   	size_t copy_end;
> > @@ -4874,10 +4896,7 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
> >   			goto out_acct;
> >   		}
> > -		data->iov = data->iovstack;
> > -		ret = import_iovec(ITER_DEST, data->args.iov, data->args.iovcnt,
> > -				   ARRAY_SIZE(data->iovstack), &data->iov,
> > -				   &data->iter);
> > +		ret = btrfs_uring_import_iovec(cmd, issue_flags, ITER_DEST);
> >   		if (ret < 0)
> >   			goto out_acct;
> > @@ -5022,10 +5041,7 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
> >   		if (data->args.len > data->args.unencoded_len - data->args.unencoded_offset)
> >   			goto out_acct;
> > -		data->iov = data->iovstack;
> > -		ret = import_iovec(ITER_SOURCE, data->args.iov, data->args.iovcnt,
> > -				   ARRAY_SIZE(data->iovstack), &data->iov,
> > -				   &data->iter);
> > +		ret = btrfs_uring_import_iovec(cmd, issue_flags, ITER_SOURCE);
> >   		if (ret < 0)
> >   			goto out_acct;
> 
> -- 
> Pavel Begunkov
> 

