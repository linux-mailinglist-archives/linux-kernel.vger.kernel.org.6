Return-Path: <linux-kernel+bounces-304293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 512C7961D61
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7B31F241C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F71A145B11;
	Wed, 28 Aug 2024 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ogYpZJeJ"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0279C3398E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 04:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724818204; cv=none; b=SRVeLamPsmiUqSw8dK52VRIRrZTS4ch0ZtpTcIhcPAEmOM6Vjc2QE6VcB9H+50sZ9kCMj7/3Ifw6LHT8y4tw/GnJclCSfYGlU1hZ6a0r4b9BLjxG9c2EgJIL6hpciovB4RwWQZq9jPhPOFYsIJTc/UIfkeo4L4GjAge2q9HV60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724818204; c=relaxed/simple;
	bh=zNlNxjFW08JSSEcyMPvi4h5DZH3WzzFkawQQUbG3njo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYN1Bt0rJQM5h1IykWaPV947KH96tV0H2diPSutI8YTqJsZM2KQhmaiJ4Y1HM+rY3envoiKKRkcTYiGQJdfuU1Vz2JPLwy3Hiit/CHKIjo/t/sqydA8pjMaywOhj3lQNscG4qWNM30F20eD6AxpVPVSNZuVGnpsf1JV+eETewiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ogYpZJeJ; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5daa93677e1so4600197eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 21:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724818201; x=1725423001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TbUlXEtla2rVUESWfqavCUSiACHVI6vmcJ0NsirDOl4=;
        b=ogYpZJeJCWC26f4eswjmffJffjMHzY7WOGWDv/8n3yhN5BLJuWqGRQvRrBKEX7NuEJ
         YkIZmgbgv0Xv9ICerTAjo0Nd5L03a47n+kZ6rYRhKx+x2YKSwY9ScjB+y/Ui8pWYzZt8
         vJBqoRpCB4lpK+luMv7d2kZ7uGzSLNglH1WB9yeQnnChIamUmjJ9D8eatMxnbqhpab3Y
         UnMtG3pZXam98GJBpdydDC7t8jkhbntMcc3KKthNzv+JpHakYz3Hlg5mKUZQnOGydQEK
         qzKtJnB3zAAP+kyRpzaw38L6jKcsXIZXFIVFTrMEVUISarq/4IzjG4pl+9jUOxkS8IZh
         WInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724818201; x=1725423001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbUlXEtla2rVUESWfqavCUSiACHVI6vmcJ0NsirDOl4=;
        b=W85arGRgTNWuSmYNyNwLtBt7j2oXx7sPuovDMszyDfHOknch4SBM+MQCYNQlrfHrlG
         cnQ6oPkRRJHr/VPmBhBFvs/ROb1FoUh+qhz3VcPSdjjuZZe5kELljwEpj7lolHV9NmOD
         kOt2Cku8Hjj+vcupC2SQGU6j8px+2cGw6HDgIzGh5a8usYyDgzob8OjkRIz775CMAB9U
         TaAkHOtWuhSk7vsMrOaKaZ6fv6xCgUacsXS4QwDnJ8yaEl3OQd5k3W5OIzXWdodQNyqS
         9IB4GTbSVtIYsIcffVW50nVLUFSkpq/xBjGVRMlt76DYyHdTug1Zc6wV/0mKacHSo96S
         g9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKKgyLf+jD2b4YjxBuUm1z6RhntPA9erxau4MdhDwN0bj7BCKVz+uY0aVqK6BURdvpswIoX7CyGoilNHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVtOBC88M55ROWUp8qqrPhZIVZ9EgDqz/BlsIxyCdMptim5n6
	yFw/FedPH1ZTs/Kl7XWvjz85IFWkv+4lAv80JfOhUqgiJKNPr6F8eC8NnYq1xQs=
X-Google-Smtp-Source: AGHT+IFfFN76jaKMmeyJLYLrAmGyGf6VTmFCJDdjyeumUMkRB244pfXxTGN0Cua4OLIg1wtsh8Hazg==
X-Received: by 2002:a05:6358:9143:b0:1b1:a961:7977 with SMTP id e5c5f4694b2df-1b5fad71e17mr97610355d.29.1724818200852;
        Tue, 27 Aug 2024 21:10:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143432ee26sm9279075b3a.188.2024.08.27.21.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 21:10:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjA0L-00FJwC-3A;
	Wed, 28 Aug 2024 14:09:58 +1000
Date: Wed, 28 Aug 2024 14:09:57 +1000
From: Dave Chinner <david@fromorbit.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <Zs6jFb953AR2Raec@dread.disaster.area>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <20240827061543.1235703-1-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827061543.1235703-1-mhocko@kernel.org>

On Tue, Aug 27, 2024 at 08:15:43AM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
> inode to achieve GFP_NOWAIT semantic while holding locks. If this
> allocation fails it will drop locks and use GFP_NOFS allocation context.
> 
> We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> dangerous to use if the caller doesn't control the full call chain with
> this flag set. E.g. if any of the function down the chain needed
> GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
> cause unexpected failure.
> 
> While this is not the case in this particular case using the scoped gfp
> semantic is not really needed bacause we can easily pus the allocation
> context down the chain without too much clutter.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Looks good to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

