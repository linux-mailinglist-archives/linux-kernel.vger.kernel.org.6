Return-Path: <linux-kernel+bounces-541939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BA5A4C39B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F98188B4C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECAE214A6E;
	Mon,  3 Mar 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="brJ9tgVk"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC83214A6F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012784; cv=none; b=M0MjobMaT7y6X5kr0JB7jl19DryEto8h7mCEXOyLz0S16WJrVbcHT0Xtd0AWJdXl1EGPHV3D24UGa8PlpXyhfRz59lT397yps1hN/nubI6w97fgt2U7dNPpQ/YQQstAsPwfhXQguLgITQRhsoN/SgZT/R84WV7wQqQB3DkgW7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012784; c=relaxed/simple;
	bh=f/MmzAXL5OQHpffX6sGg4Xf3VuYmFv3FUS7egesUiFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfUMrtYdB+SdtN18YSUynWISwdwgqZUFULz1vbMHLRP093mnOzR36CFy2ixEnHIJKAZDlVhNCWUdlKU5d7at+dX2L1tTVaSAKbai9wZv8UbY1FsuzXpVMedYanVnJ8C9qESurf6cegpGAAFbQLxVoNmMXsvz0+ZyF9DZZKZ5SI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=brJ9tgVk; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4721325e3b5so38266331cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 06:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1741012780; x=1741617580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r7AsLn1sMs50UyzmZS5BkUzscifC9xG2WhaFTFTMT1s=;
        b=brJ9tgVkPvWjnCoaI4E5SsjSbz+n96HwUjYfe4g2fhSne9wZkdnh/TRNDfWyS7vvwO
         WfueyuMJAd4BXggwfq1lJSHZOUUyoI+oLHJGb2KFB74I1Db0xIsXhTOw86GBZVhcvGZ1
         /jWWKU9K0ya0UTIzFu0BtldgZhrHlt30x6fXmIkvojWnXiXQI7j5jvfS29igLw2q/H7z
         fRSjAEouFunNNyB3ghgA6BfdaepNl/j3kedLxskViY9yjZSQ5CXjJ5HgUF5ViUKVJU+Y
         nwNXOW9bGODlAdubpJg4P8KXOUZNRNuPUI3+M6FVRYdBawZLmrzLM0PbfzNLSbCpgdRs
         K2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741012780; x=1741617580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7AsLn1sMs50UyzmZS5BkUzscifC9xG2WhaFTFTMT1s=;
        b=ljDHwDkD5m62RBTd8+IzpD6BZ+gevsu2dxub/pBjWbKZhJ+fo3nH9GnOWYlg+pOF2n
         UTkX9XJNj8S5NENYiPA7V58ae+FZVfwUkBcOQBGumuuN6K+OWm8U8ETrbLzchHtEZw+V
         HSMcgtww0QIyH+3JVq3zCyiSbQfBMOLCWZnysP/w+NUnK/zPhTZeUajAyv2S36w19XVB
         Qx/2nSIUGEdkGf8/AcLa7sRCfq+m25NymqsTnhTt2FCwsvWFyMx1vkJGj//CZcg6lzus
         zyE9HOIbqVuGNxi05aiIeVzk38zwKaZaayDZOMJJdKpvr61OHA/P/xaQZJTPBy4woihS
         kFrw==
X-Forwarded-Encrypted: i=1; AJvYcCVtRR3iG0J/CzXyICflF81FPu9/yLCQkCGFJ3OHfkJ9VY/fCxlDGDkivuF9CCuJRW45LNcB/4LWSORbwCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz20GdnsIliK0QljTKSY6aFDQJGUBFoleOuYujnbgFCUYjuYzBF
	qXahwoWepuZ93KjveB33G2wm+CzFwyz4imRqBe4C7Y/padYN/Q+wPy7CHhDVMA==
X-Gm-Gg: ASbGncuAJ5p9g9v6e2aD8KASrgTzN50sGAd4Q04kqYx2BpDPW1M75bB/9d5+ciAemyp
	HFV1oC/ghprT4KDIU5Zp00n+ea5fpHCmlnc2reeR1k53kEBSJLrfW2y+z/L7uelK0M0Zr6EzzYh
	YI7v9KHSn5Hn/C5WJTf3b/BWSPVwzx3BBV+vYT+LjHkh9wfYpWkshObYHtquyy8r/XNHGmOjqY1
	ypV5dysmOKCCagSyxDT4Mj42u8XLZyEXg2PPmNYnUmKio9ZQPjfjuMQa6m8eRKoRfYOUxVNd2If
	GUR8p8Y21JEs2r26v7jLc9UyXF2/YJJU4dzOHdYeqcEhyOX3Xfr2bXuxlyHDMkA30w==
X-Google-Smtp-Source: AGHT+IFQZWctUnPbfZ4JFiToDWuPse3P6E/7UY4w/4me8CrHgeGRMctdZBPOfHW7+lK6TZ19RHYQgg==
X-Received: by 2002:a05:622a:8d:b0:474:f991:b3b1 with SMTP id d75a77b69052e-474f991b60bmr12202431cf.43.1741012780563;
        Mon, 03 Mar 2025 06:39:40 -0800 (PST)
Received: from cs.cmu.edu (tempest.elijah.cs.cmu.edu. [128.2.210.10])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474e90b8853sm13021411cf.65.2025.03.03.06.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:39:40 -0800 (PST)
Date: Mon, 3 Mar 2025 09:39:37 -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Joel Granados <joel.granados@kernel.org>
Cc: nicolas.bouchinet@clip-os.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Joel Granados <j.granados@samsung.com>,
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 3/6] sysctl/coda: Fixes timeout bounds
Message-ID: <20250303143937.etzv7idjbenugsgw@cs.cmu.edu>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-4-nicolas.bouchinet@clip-os.org>
 <u7q5rpzw6mohtnnhpa2j3u4photckmgllsl3noafnyfttepbui@rzmndu533xcv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u7q5rpzw6mohtnnhpa2j3u4photckmgllsl3noafnyfttepbui@rzmndu533xcv>

On Mon, Mar 03, 2025 at 09:16:10AM -0500, Joel Granados wrote:
> On Mon, Feb 24, 2025 at 10:58:18AM +0100, nicolas.bouchinet@clip-os.org wrote:
> > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > 
> > Bound coda timeout sysctl writings between SYSCTL_ZERO
> > and SYSCTL_INT_MAX.
> > 
> > The proc_handler has thus been updated to proc_dointvec_minmax.
> > 
> > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > ---
> >  fs/coda/sysctl.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
> > index 0df46f09b6cc5..d6f8206c51575 100644
> > --- a/fs/coda/sysctl.c
> > +++ b/fs/coda/sysctl.c
> > @@ -20,7 +20,9 @@ static const struct ctl_table coda_table[] = {
> >  		.data		= &coda_timeout,
> I noticed that coda_timeout is an unsigned long. With that in mind I
> would change it to unsigned int. It seems to be a value that can be
> ranged within [0,INT_MAX]

That seems fine by me.

It is a timeout in seconds and it is typically set to some value well
under a minute.

Jan

