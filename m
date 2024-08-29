Return-Path: <linux-kernel+bounces-306953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FBA9645F7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA0E2894A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E82D1A3BCE;
	Thu, 29 Aug 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="cC025rxp"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA161A3BCF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937144; cv=none; b=m7rix+RhL5p5HRrVVeGu//qZ91khYtGcgJUOzZyrL/1XG86HgWYCJyRnI5MqsijIGi7if6/VkineKlAypY/F5Id2HNxxZ6mFbfJsR6s2C5uT+WfWEGpPrjW88rFj0+tU/Arc4diRZZO4WuwGfW5lltTts/xV5yPDm4N4qIBUuwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937144; c=relaxed/simple;
	bh=A/ukJ4jBr8jJQwS6YKUvYcuWgw8ce4anDS07GtBUeqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpm76skR7SXMCKKj6oYawTNUiuuATcrzKaARD76eQSFjeeYcqNVBwhBbUfo2KE2OQYENI0eywLRd6jbyXFiVPLDo+Ync0q1rxs2a32AFqCu1Cv7n0+d67UQ2CyjF4SsNb9sjY+U4+6ZJDIPT+n/UsKx6r/6YJIIG4luPIJvjkAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=cC025rxp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d439572aeaso476469a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724937143; x=1725541943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qX/f6dofDtGfqoUjh7wF0DGgkcB4Ol606CTys8bLCc=;
        b=cC025rxp2s0f9GU8p4vFM6gK/4CEuAH6aoyzZVG8TzaHQKelvBm+U9hT0BRgzwgDR+
         kABSDebTyiEq/IJ11jRgRMkAdcrQmWqqTKbHsLB+XyWVgv3aXDNwND1ac5zT49GaBQuy
         We/n4Is49FIPa2ssOupls8mNrbPnHleE+x9mLiZLokPnEDhe7PtVSRycuXJ7noZrlLMl
         DhM5WSSCbQZN4QsYUVw4ELdyVw0v9f+3TcrcQAbz1tg35HcgpY/XHlUebzmx2sO7uGjX
         IwpeXFw3oHa77o5TM3pEqgZvJaug/Km4747KQweRsFHIFJ5sFLqVG5ii0gLQxQidO2B/
         NIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937143; x=1725541943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qX/f6dofDtGfqoUjh7wF0DGgkcB4Ol606CTys8bLCc=;
        b=s8EYfLCKqrLObheftINHoHiZyl6WjVzgcLF6uhzmA9myV4xU0GA7aFI0A6QO7lx8wz
         I1h59z3E+L60WeVMoRmUz+hdRUS9VMC2Ye1cfef/LVBDAAxBMeL3nPHjBUJNJf/hzmkP
         02cA06kSFmkf97w1c+MA0NDrQDWnQeL2wloX8HtSGoeOu39d4O9UHUdcTnHIzRPlqnkO
         dKoIvkE7c/STD9URjPIKxihorQIyAjagmWETjYlJGAof5P5kvXbKpeyMjuPCyLUD/IVb
         ONXBpf6gJ9QEclkXw+78dEH0GBrIQKF5Ya/LQKO7sZQLk6HRBUMZ3CjfL+GHk8wzlT0u
         4ipA==
X-Forwarded-Encrypted: i=1; AJvYcCXwe8rK6+LXL45gQx5TZyphldWwLHeS5Xn0E2L41aOpp8fkT42Tixgw02W0evgN5uEC4kptTqsrxYdNSGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlLiIFIVnzZNt4m5p5HtIwnSH2psmZi+yGPs7zjaMn7Z2dNg1q
	b3IsO3626/xCIZJOu63yoV+VjksNATzPVuK+YMKGmI+t7x9wjhOCfiJpRSNmA3s=
X-Google-Smtp-Source: AGHT+IE5og1QyFjbYL+fjlxeemY0chdVMvPBO6yd0H47y0vJ8/ygu0YjmhWpP08sTZ8j5BBHBY/dlw==
X-Received: by 2002:a17:90b:c12:b0:2cb:5829:a491 with SMTP id 98e67ed59e1d1-2d85c7d28c3mr2403333a91.20.1724937142595;
        Thu, 29 Aug 2024 06:12:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515542376sm10955575ad.204.2024.08.29.06.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:12:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjewk-00GwzF-1j;
	Thu, 29 Aug 2024 23:12:18 +1000
Date: Thu, 29 Aug 2024 23:12:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <ZtBzstXltxowPOhR@dread.disaster.area>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>

On Thu, Aug 29, 2024 at 06:02:32AM -0400, Kent Overstreet wrote:
> On Wed, Aug 28, 2024 at 02:09:57PM GMT, Dave Chinner wrote:
> > On Tue, Aug 27, 2024 at 08:15:43AM +0200, Michal Hocko wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
> > > inode to achieve GFP_NOWAIT semantic while holding locks. If this
> > > allocation fails it will drop locks and use GFP_NOFS allocation context.
> > > 
> > > We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> > > dangerous to use if the caller doesn't control the full call chain with
> > > this flag set. E.g. if any of the function down the chain needed
> > > GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
> > > cause unexpected failure.
> > > 
> > > While this is not the case in this particular case using the scoped gfp
> > > semantic is not really needed bacause we can easily pus the allocation
> > > context down the chain without too much clutter.
> > > 
> > > Acked-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > 
> > Looks good to me.
> > 
> > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> 
> Reposting what I wrote in the other thread:

I've read the thread. I've heard what you have had to say. Like
several other people, I think your position is just not practical or
reasonable.

I don't care about the purity or the safety of the API - the
practical result of PF_MEMALLOC_NORECLAIM is that __GFP_NOFAIL
allocation can now fail and that will cause unexpected kernel
crashes.  Keeping existing code and API semantics working correctly
(i.e. regression free) takes precedence over new functionality or
API features that people want to introduce.

That's all there is to it. This is not a hill you need to die on.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

