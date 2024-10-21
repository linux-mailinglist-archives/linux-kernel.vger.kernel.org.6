Return-Path: <linux-kernel+bounces-375075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7C79A908F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A612B2879BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6901D7984;
	Mon, 21 Oct 2024 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="QbeBZhfM"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BCF19E968
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541168; cv=none; b=N3WBEOtEnvbnJVbspS1/o6/RgzHjlk5RE4KshrmgYMYAdqiXTMmU8pLleq5xlEJ0CkzbptAHehY0uOE9R7FDSnF0C5GhSn+wRC9zdnb2GfwH+aBVhbfSEVh0pAdrvk3kX1/klm5lJ4q9PYC0DbB+cRunFmD9RPU24dd+OAf9Ph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541168; c=relaxed/simple;
	bh=YSKw6jb8QPWFx83Peoso5ccFLz73UcVx429F0xZ3Ez0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OChsCNYMH+2JAXKbHgD/cOsOvsCggxdRCyEqdMbE1oAX8P32mBHppdplITVFCJyEO25z/UyDZwwp2AlUqOvM6okfTfFVL+g+k/PE9KlGnL5Sv+rXo+ibEHe13+jfBdwMtp//GyNqWEmJhC8EnohCeti0hJ41dj2KT8BZ7/73aUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=QbeBZhfM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ca17bf0d9so3570155ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1729541166; x=1730145966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrqqRk6hzjGWjq29e3qz8ttMOlAUA5wKTrVPk+XCY4w=;
        b=QbeBZhfMcMuI3BDLF+sVIhRZame6FJZr8hmxdnT1+z6ihQn+u7t2rRbByxYEIl6vCZ
         Rd8q4gapHtB4QdiqEecs0ggYD4Ve3dbiabjXjTZcIxX2a4M6yNeAQduCuHVluaTDf5Y9
         4UQTWl7Npn6vgRqi99iExQzKJ3q6htlnKibziYXuYpLlgPrN/ssYUTisGjMWzg7MSjUs
         qk39N9rk3m/bW5mTwYQt2hvfbResK+TvfChQZWph5hfwl6Ba2FRixZiNAJfH//1L1XaO
         DeMgJrMoWd6m4jLIb+f1OzXAia8NF5cYfLbBVvu1Rd3te9XaqLhIFCTJuLjw22umVC6Z
         +2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729541166; x=1730145966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrqqRk6hzjGWjq29e3qz8ttMOlAUA5wKTrVPk+XCY4w=;
        b=wtW9Ybr/7c9YOMG4YQRfdbN9eBbq+y5LrngY4WRSj3N+dlsVX++Apu3hlL3+ldCRJT
         bXFFjNrf/eJb0EJZwDh8JFl5ikD7diWCn6fleKwBQISPl1C1iQ0P1WhDcUFAaYqsDQvF
         PUT5/z5hNlvKuZ1u47lbIJckEOJqQrLdhPZO82Cfnu+kBZwBqOnbdEVQ6cEiP6GLJe4c
         zc4tKudmZH5HxwxSSDpXbL9E2XIsrQqf8sIdKncy6gW+DLIPdMXpcr+MI1/6MaRj93kr
         6Hc6xDyKyWrYhZj4nMbbnOen4AIxGuEYMLMU5gyAJpfk56919Owpi4lsnN6nx0JbS3Fx
         Etrw==
X-Forwarded-Encrypted: i=1; AJvYcCWigox2Xz/N7ieQ/brtELSSK7xOQLyhH3WVVvP2Zvw2WGbIqC3O5iNqYJuNBIUt/s+c6+o1VR2EDl/bHzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmNmaTeHPaYuXQS3M647pYxALPfsf1rxtEvTNeyHE1ZjMoRW6y
	b6KURgbEoYPp6tscN7D9BFZ+G1TPR6BBs7BVEfhBAaujMMoww0n1qWB8xLganV8=
X-Google-Smtp-Source: AGHT+IGw0pHFBO2qR1RMPMHDvfyXxvAHkrtR735iXBeKZTTZs8ZlsbDet6VFNPejquCo5hRUYsh0lg==
X-Received: by 2002:a17:903:2309:b0:20c:6bff:4a26 with SMTP id d9443c01a7336-20e5a9601e1mr67498045ad.15.1729541166558;
        Mon, 21 Oct 2024 13:06:06 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:500::7:4942])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee3c7dsm29769045ad.35.2024.10.21.13.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:06:06 -0700 (PDT)
Date: Mon, 21 Oct 2024 13:06:03 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: Re: [PATCH] 9p: Avoid creating multiple slab caches with the same
 name
Message-ID: <Zxa0K-4mhSI91S-w@telecaster.dhcp.thefacebook.com>
References: <20240807094725.2193423-1-pedro.falcato@gmail.com>
 <20241018172804.GA2151929@nvidia.com>
 <CAKbZUD0Z_Kyumx3ourywUYhfksGNgJWrCpjAdnxtsbwS4vMRkA@mail.gmail.com>
 <1cb07628-269c-4d6c-9936-f3a2b233165f@leemhuis.info>
 <b6852c2d-3371-47a4-bfeb-049f4048e88a@suse.cz>
 <ZxL3FsmjGrTT_EV9@codewreck.org>
 <d937fd92-249e-4660-a59a-ee85b6ec4691@suse.cz>
 <ZxafcO8KWMlXaeWE@telecaster.dhcp.thefacebook.com>
 <CAHk-=wjpxeTifM1LFPQFR5_RjD2uvDAHbZ-ATCqox+RuFwkbDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjpxeTifM1LFPQFR5_RjD2uvDAHbZ-ATCqox+RuFwkbDQ@mail.gmail.com>

On Mon, Oct 21, 2024 at 11:57:38AM -0700, Linus Torvalds wrote:
> On Mon, 21 Oct 2024 at 11:37, Omar Sandoval <osandov@osandov.com> wrote:
> >
> > FYI, drgn's CI started getting EIO errors from
> > getdents("/sys/kernel/slab") that I bisected to this patch. The problem
> > is that dev_name can be an arbitrary string. In my case, it is
> > "/dev/root". This trips verify_dirent_name(), which fails if a filename
> > contains a slash.
> 
> Bah. Does something silly like this fix it:
> 
>   --- a/net/9p/client.c
>   +++ b/net/9p/client.c
>   @@ -977,6 +977,7 @@ static int p9_client_version(struct p9_client *c)
>    struct p9_client *p9_client_create(const char *dev_name, char *options)
>    {
>         int err;
>   +     static atomic_t seqno = ATOMIC_INIT(0);
>         struct p9_client *clnt;
>         char *client_id;
>         char *cache_name;
>   @@ -1036,7 +1037,8 @@ struct p9_client *p9_client_create(const char
> *dev_name, char *options)
>         if (err)
>                 goto close_trans;
> 
>   -     cache_name = kasprintf(GFP_KERNEL, "9p-fcall-cache-%s", dev_name);
>   +     cache_name = kasprintf(GFP_KERNEL,
>   +             "9p-fcall-cache-%d", atomic_inc_return(&seqno));
>         if (!cache_name) {
>                 err = -ENOMEM;
>                 goto close_trans;
> 
> (whitespace-damaged, but you get the idea)

Yup, that works here.

Tested-by: Omar Sandoval <osandov@fb.com>

