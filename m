Return-Path: <linux-kernel+bounces-565658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6413FA66D00
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F862189E0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597EA1C860C;
	Tue, 18 Mar 2025 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="J/7qt6eg"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91C1DF742
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284555; cv=none; b=f5cbzbC5Wt9kRsVe/eNHMRC1tbQ47fIY4nHQbrUN4OduNJ+l09X34SKz+dtZjsZ4a596NHRUu21nwhotgamyD0HZqvgeE35zjOaHQ5QVpWqlt9GO9t/mEfHmfphG+plQJy4ysqbutPvswyj/LkOHj57B52dckPCpKM0qnS952Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284555; c=relaxed/simple;
	bh=N+vhNC0jMyh202u4Nzngi+/YScqdgkuR1GpsqEXNxTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RC+nKjvtnyMVJTXLk11tsRV/GEIl1Ny/H50GnDUrB+ttm+VRMqcu7RGaf2nc04Kk9rH6WNRhRTpKCNI5ksuFOCnJ1rwJ0JY4enbhqepxN5W0VQDbl9u0oYxKBZXR5qvZgAmJwx2ObLBzzbuT2EIv7xG+UcA5asezdWK4KVrSUkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=J/7qt6eg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225d66a4839so64612595ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742284553; x=1742889353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWqw/1YNqpsUiTasqbG4aqWj2NMVBNVnLiGA9t51nRU=;
        b=J/7qt6egEm8xpLU14Nfwpl4aCF+YBSLKG2siRAZg+zTk9E6g8PpB0hbAyrNJjDJjlE
         WFTRj0nXHIDOBY6t37Qb6IQgVk5QIBxDbSv9JIUqp+g2EWQbRhWf8UK1+vI95U2QC7x7
         f4fWS1VkpAqm0veTij9zd1ghlaaSu/R0ont/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742284553; x=1742889353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWqw/1YNqpsUiTasqbG4aqWj2NMVBNVnLiGA9t51nRU=;
        b=mUyzWZjGLYKDZFKbgjbf2rtjvDYV39DWD4QGH9Q+lfhlYZSJmb1DzLyQm6KqrnPAAE
         g5pY9vAN6zb5mmLNSPG6/lUUHCYB/SZqVPR6MM00t8BRAiP4i72qFX0xE3bzdSF9IpUl
         6560FwpL8TB6ekQtBWrSUIjIIIWpAlq9zwfm3x73mWdL9gLx2opshknnMwbbjCHUEL59
         qhSKIqcMXfXyuNzmSpvP90ZJa16EgHqjJs908OtXJBIw+mTzq4KoadctDWpd/Es8ygB0
         vkuAZi+oL2iP9mWoPq4w0TPOH0RFeEwpaeq6FMUkn0EVkYIppmB+8ZMiqP7x4fCmWZ9l
         A2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUIgCOZUE6wREJGO7VoCaFPZk0woty1tP9++YeHiaUdu9N+N/ws2pp843FMkpRDEjWOLFFAZPy1dBid+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YywQAnWitJfhprjQBpz/MFNNYr/NVJd6rMpRg0Gah8D2MfjhfII
	FdEawYn2NJiAg5sWTG/AGcnUlCjr3MU0pG5zeUVPI7ERTq4NAOsCuyNeMIKSrHU=
X-Gm-Gg: ASbGncu6a1sGui+ZEoG0V5Eqkkx/QwOqE0pY7RhRWyLW7fWZ1NmW1/HxYrf7uereHdI
	0BYAbLUr5jD5lFMLnyS/Nt85z3VturPANJOsNxmo9zgkwvAjsVbEMjSaPdg+vUh23IJGT2GQ8Hp
	PIBZoz049fjN4kkW3vpQkik9j3rhBxBkX4SZuZtdL29H8+VChA4SQLcUUH4QGCKHQILUrkjcecR
	Ex94eYA47BUT9o9rK5TbwhIJULzFPd50iBz7eScdHIzPSNV0IBcAmVyVY27nfqk+EHf4X08I9we
	p0tKJYajqcgWwiROFkAsLl3S4fYbPGbNcYQf4PRrkIVdLqKfHKanNr2kakFydc9ADJmAh48sdEC
	4
X-Google-Smtp-Source: AGHT+IGLSujM6CyWqFOh57z55RWygpWHWUeBFLDSwNoV+Z1DhMnmwP9sY/TJGMmFDBV3BlyR8M6DEQ==
X-Received: by 2002:a05:6a00:4fc3:b0:736:b3cb:5db with SMTP id d2e1a72fcca58-73757a53663mr3191488b3a.11.1742284553335;
        Tue, 18 Mar 2025 00:55:53 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371169c3desm8846112b3a.155.2025.03.18.00.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:55:52 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:55:43 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v4 4/5] btrfs: ioctl: introduce
 btrfs_uring_import_iovec()
Message-ID: <Z9km_8ai2zq86JKI@sidongui-MacBookPro.local>
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
 <20250317135742.4331-5-sidong.yang@furiosa.ai>
 <3a883e1e-d822-4c89-a7b0-f8802b8cc261@kernel.dk>
 <Z9jTYWAvcWJNyaIN@sidongui-MacBookPro.local>
 <566c700c-d3d5-4899-8de1-87092e76310c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566c700c-d3d5-4899-8de1-87092e76310c@gmail.com>

On Tue, Mar 18, 2025 at 07:25:51AM +0000, Pavel Begunkov wrote:
> On 3/18/25 01:58, Sidong Yang wrote:
> > On Mon, Mar 17, 2025 at 09:40:05AM -0600, Jens Axboe wrote:
> > > On 3/17/25 7:57 AM, Sidong Yang wrote:
> > > > This patch introduces btrfs_uring_import_iovec(). In encoded read/write
> > > > with uring cmd, it uses import_iovec without supporting fixed buffer.
> > > > btrfs_using_import_iovec() could use fixed buffer if cmd flags has
> > > > IORING_URING_CMD_FIXED.
> > > > 
> > > > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > > > ---
> > > >   fs/btrfs/ioctl.c | 32 ++++++++++++++++++++++++--------
> > > >   1 file changed, 24 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > index 6c18bad53cd3..a7b52fd99059 100644
> > > > --- a/fs/btrfs/ioctl.c
> > > > +++ b/fs/btrfs/ioctl.c
> > > > @@ -4802,6 +4802,28 @@ struct btrfs_uring_encoded_data {
> > > >   	struct iov_iter iter;
> > > >   };
> > > > +static int btrfs_uring_import_iovec(struct io_uring_cmd *cmd,
> > > > +				    unsigned int issue_flags, int rw)
> > > > +{
> > > > +	struct btrfs_uring_encoded_data *data =
> > > > +		io_uring_cmd_get_async_data(cmd)->op_data;
> > > > +	int ret;
> > > > +
> > > > +	if (cmd && (cmd->flags & IORING_URING_CMD_FIXED)) {
> > > > +		data->iov = NULL;
> > > > +		ret = io_uring_cmd_import_fixed_vec(cmd, data->args.iov,
> > > > +						    data->args.iovcnt,
> > > > +						    ITER_DEST, issue_flags,
> > > > +						    &data->iter);
> > > > +	} else {
> > > > +		data->iov = data->iovstack;
> > > > +		ret = import_iovec(rw, data->args.iov, data->args.iovcnt,
> > > > +				   ARRAY_SIZE(data->iovstack), &data->iov,
> > > > +				   &data->iter);
> > > > +	}
> > > > +	return ret;
> > > > +}
> > > 
> > > How can 'cmd' be NULL here?
> > 
> > It seems that there is no checkes for 'cmd' before and it works same as before.
> > But I think it's better to add a check in function start for safety.
> 
> The check goes two lines after you already dereferenced it, and it
> seems to be called from io_uring cmd specific code. The null check
> only adds to confusion.

You mean 'cmd' already dereferenced for async_data. Is it okay to just delete code
checking 'cmd' like below?

if (cmd->flags & IORING_URING_CMD_FIXED) {

Thanks,
Sidong

> 
> -- 
> Pavel Begunkov
> 

