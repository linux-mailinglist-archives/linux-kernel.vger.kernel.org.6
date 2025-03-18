Return-Path: <linux-kernel+bounces-565234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CAFA6643D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66646189B976
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B345B126C02;
	Tue, 18 Mar 2025 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="XQvplfzX"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA37776410
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259073; cv=none; b=Ws4C6SGp9is69SbbIIaLxJGY9JTUPOwuMCwy1bKzMj8YblvJa1mng/cbhgw0vM+rql5/CdhWC89GqCDMngBPsI3DwExYFSFh/Dawh4LbTvFdHB1QB0be8AL8DUQ79bcX0v4LySnkUknGsVT+p1baKwibZgvu9XpL78Nc8I6lQ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259073; c=relaxed/simple;
	bh=FhDT6Ht4uOnAjRnAHtxZUZhftn3nLJ2mhdwA/rIdKqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKCLW1fCMpG/kA60zLU4BFyDUgWO3RhnsER9AUxA4dPCQVrBf4Gwwwn31Aq3+Xi5BwXQ+GgxdVOq4/KzWz+BbGF7h3B1lLIzdR2C/b3rtNLrMzSzn3EBYzpIEZsSYbBMzbN0Wyq4+HinUKkDkfYhIl/yz/DW4d80Z1Gcsr9M2pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=XQvplfzX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224191d92e4so96113475ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742259070; x=1742863870; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U/GqRqFocBuzF9Eb/f/joYEbo/0mtodFRieL+22DCbs=;
        b=XQvplfzXSdtr34ongeYiAJ/wo4zOYZOAmw7kYFk2wZUyODDHhkUo9bA+UNzqbJcOSF
         7tgRZEcuteivw0ehMX6iZ7xSkEffqJ45Dcrr7bHkvaBtClmg31hfVSu0niLZHhLSp0AC
         WtCVUH6kL98Kj9VbvQfrs0eA5sFrKZenvo72s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742259070; x=1742863870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/GqRqFocBuzF9Eb/f/joYEbo/0mtodFRieL+22DCbs=;
        b=aXW9e7yAsgScyKl3cNPecic5q1Cv3wID/G3KdciPAxVDozVlEMe6EkPcIvyvZ6LdJQ
         EnHvqJE/xz/sy1FVjRcv5acDZRgY0DwgfL884MEzLGt8zSG0NNC5Pix6c4P0TtP5o4AL
         JYglmvOH9QzXrkrVPS6DKZ7xPvOE9NCNy1CiwXm8QtwWNPz87eOdpLxrA4sPcOsfEWSj
         2smDWaOiWPF/ehHe/C3qmwEmEEbaKMNTG2aK94I+fqg6T2aMHfJwgCmfYcNq/iuN61GO
         WZ4NB5DtnkHJex1MiVTyh62pJYMljBVeaN1XLRMGYmQEi5Mvpibh7M/2T5C6OCcFf/Be
         gXiw==
X-Forwarded-Encrypted: i=1; AJvYcCXfVeofBMWU07NIDgM1c36TlnJWGIqPOPB19cyg6YWJf6gbAnN+WUozOEMj6GTx+62+ykJKpmgoQSfEgEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg3sX4bRCUWtkmeGb/fin7hXe6rv8UKJdIerZX+yJzc6ntHMoS
	fvyQkbEztCnjlCXw7Fw+osdbq2wV442MIMVJAINaw1wK8zw2iUB0diEAzvIUYxg=
X-Gm-Gg: ASbGncvO4t5HVhg6/BpEGX0cr5qZeXIFIWisHvupeFk+p/hokqd0CkwbvGWYaDe0TWf
	0DsHjJVl859Q7PY0F/zxV4qlX9nN/dyhm9lUWz/kfMbGF0vpWTdBRqYons3FB2wVx78qnT5oKge
	gJLKZ68ywQWOdOPcLCdk2pxQdCycznWSOHcYLQ8dPfNOQDro80v6dHFfbARN/SRyyPwfiVuddFS
	oa4sUBxEfheVBLd24kF/LHBljo5hLrlXHBRMJHEHhPPF1LWdX3ADVSpnyD7x1VC5HZLiW5Jc4CG
	+YbZoO6S9dKGAbRMUivP693/21GcUYN+HFBJt3C2OU2mU0K3mv94oLtMEuNMm0T9Zq9W7AZnMTB
	t
X-Google-Smtp-Source: AGHT+IFCTe5n82yUGpowrbpfL0mcn1Bw7/SjhqpalmHXGc+c3b40e/vG3uqcukMNwusAsrCQ70GyTw==
X-Received: by 2002:a17:902:d54f:b0:215:9bc2:42ec with SMTP id d9443c01a7336-225e0b14fb5mr171079355ad.47.1742259070107;
        Mon, 17 Mar 2025 17:51:10 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6ca3sm82072255ad.134.2025.03.17.17.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 17:51:09 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:51:05 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v4 4/5] btrfs: ioctl: introduce
 btrfs_uring_import_iovec()
Message-ID: <Z9jDeU8flCI3SWgZ@sidongui-MacBookPro.local>
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
 <20250317135742.4331-5-sidong.yang@furiosa.ai>
 <CADUfDZoR+L8za5h6-Q=EL-7bRekBt03CeARE48EjMr18S6gvww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoR+L8za5h6-Q=EL-7bRekBt03CeARE48EjMr18S6gvww@mail.gmail.com>

On Mon, Mar 17, 2025 at 08:37:04AM -0700, Caleb Sander Mateos wrote:
> On Mon, Mar 17, 2025 at 7:00 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> >
> > This patch introduces btrfs_uring_import_iovec(). In encoded read/write
> > with uring cmd, it uses import_iovec without supporting fixed buffer.
> > btrfs_using_import_iovec() could use fixed buffer if cmd flags has
> > IORING_URING_CMD_FIXED.
> >
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> >  fs/btrfs/ioctl.c | 32 ++++++++++++++++++++++++--------
> >  1 file changed, 24 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 6c18bad53cd3..a7b52fd99059 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -4802,6 +4802,28 @@ struct btrfs_uring_encoded_data {
> >         struct iov_iter iter;
> >  };
> >
> > +static int btrfs_uring_import_iovec(struct io_uring_cmd *cmd,
> > +                                   unsigned int issue_flags, int rw)
> > +{
> > +       struct btrfs_uring_encoded_data *data =
> > +               io_uring_cmd_get_async_data(cmd)->op_data;
> > +       int ret;
> > +
> > +       if (cmd && (cmd->flags & IORING_URING_CMD_FIXED)) {
> > +               data->iov = NULL;
> > +               ret = io_uring_cmd_import_fixed_vec(cmd, data->args.iov,
> > +                                                   data->args.iovcnt,
> > +                                                   ITER_DEST, issue_flags,
> 
> Why ITER_DEST instead of rw?

Oh, it's a mistake. It should be rw.

Thanks,
Sidong

> 
> Best,
> Caleb
> 
> > +                                                   &data->iter);
> > +       } else {
> > +               data->iov = data->iovstack;
> > +               ret = import_iovec(rw, data->args.iov, data->args.iovcnt,
> > +                                  ARRAY_SIZE(data->iovstack), &data->iov,
> > +                                  &data->iter);
> > +       }
> > +       return ret;
> > +}
> > +
> >  static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue_flags)
> >  {
> >         size_t copy_end_kernel = offsetofend(struct btrfs_ioctl_encoded_io_args, flags);
> > @@ -4874,10 +4896,7 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
> >                         goto out_acct;
> >                 }
> >
> > -               data->iov = data->iovstack;
> > -               ret = import_iovec(ITER_DEST, data->args.iov, data->args.iovcnt,
> > -                                  ARRAY_SIZE(data->iovstack), &data->iov,
> > -                                  &data->iter);
> > +               ret = btrfs_uring_import_iovec(cmd, issue_flags, ITER_DEST);
> >                 if (ret < 0)
> >                         goto out_acct;
> >
> > @@ -5022,10 +5041,7 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
> >                 if (data->args.len > data->args.unencoded_len - data->args.unencoded_offset)
> >                         goto out_acct;
> >
> > -               data->iov = data->iovstack;
> > -               ret = import_iovec(ITER_SOURCE, data->args.iov, data->args.iovcnt,
> > -                                  ARRAY_SIZE(data->iovstack), &data->iov,
> > -                                  &data->iter);
> > +               ret = btrfs_uring_import_iovec(cmd, issue_flags, ITER_SOURCE);
> >                 if (ret < 0)
> >                         goto out_acct;
> >
> > --
> > 2.43.0
> >
> >

