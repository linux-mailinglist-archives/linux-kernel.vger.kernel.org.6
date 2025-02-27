Return-Path: <linux-kernel+bounces-535676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56951A475DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82E9188AEAA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1692D20FA9B;
	Thu, 27 Feb 2025 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ArRFhGmF"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914671E8355
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740636983; cv=none; b=PdEdFfTrlUgnfjYb89lbohLfHNsq9s1ejr7CWgJ/vNbpCazKMq0PNOfVHzPmpxzJkSfkh0MLBS4nG+V2CuONnghCLODjKSqSrcjdkMExNZRhusgcNsGRN+MUL9W8eNbKB2nfc4y2FoKi+7ruvoLoV9ioaVFK9lDCMIhj4uHrvno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740636983; c=relaxed/simple;
	bh=bfBkBfye9mY2ueKjnar04CizjWdmU4hGbDcn2c/8ADs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI64ggZ084NM/fI+gIK5/rmwnTYTp0CuKXtcCG5UruWdWji1WqSq89Hq20gzLiBnByU/DAcV75fDWoDe1P9hU8MzQFcRGElRDKq8lGg49u0s/MVYtdD0y5A9jJ1YEtIt8PDvPGes6yip1xOL19ED4ZaDoxxx0dlkRz37f+qzuso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ArRFhGmF; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c0ac2f439eso71065485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740636978; x=1741241778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hIRNfZw7sAL9nU9Dv2qbYVT7pWVShOhPHJeE1WYpjeI=;
        b=ArRFhGmFEaF7BzsUaXNrljsiQQfT1QNccY2Z7cx/xUGUH5Xf2FlaOwlAy/jvjLgALP
         HdJ2AZVJL9ZGZz6A5VFZHhL7LX+Hevo3cB0Y4p00H+AgysIlZzqL9lFeibLz2pi8UkBH
         Yr9/PojLEswQp+PwD4IP8Dca9kFqovfU+tWiIKNpAud91RU3JI48osqCOR/2coupQGhn
         d4mqsAexmOSpGPRSePQfU4MxE57KC6IPMD3E/7CWNG6cWa7EHo13XXCPhKwvfNFofNol
         BHs6UEMIJ0Mf5kPWMSSkF5L0wcm+8wAS0ugJVFDptFPIoW9t0yTRZMk0QCTRGaWJjgLK
         bLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740636978; x=1741241778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIRNfZw7sAL9nU9Dv2qbYVT7pWVShOhPHJeE1WYpjeI=;
        b=L67UqUCvvoGTQF/KHQACBtL6Hz1HvfI6SoNizoM91yuM5r3Zj+3rD6Y24/2vGjgCYO
         zPcbWE2NsFR/92btemvlJYtZW1qn2uR1begk4dl4PDeu5eWcMJAIkQCUpsl//zzS1WzG
         5X5F+D5gWfPdgCIsBR3LHFpjMPbYrSKBbHgNqwwHXhn2y2womZElZlxtt5s1J/4MF0V4
         0sM1+wg/QZ8xseTGxs008oHCe6G9kNRUebb9UACuGYDkXiba8JRXCDcy4GC3SIcq98J8
         Lp4qr34tbzxgzcgStgcdN6O6TTAf5i/bqVrrMCe+K1ckalWfNOO5tZnpHx1ckJuRgkvc
         WpIw==
X-Forwarded-Encrypted: i=1; AJvYcCXF5OO22+dVC7G9e/fGTdNngYPhJwnSo8KC2MHfigv7pL3hP/dBg1ooK36z+Ncw/Egb8NzkXIbGNnigShU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytU0rIDF+Qjbm6cWla6DbddssO753mB7Dvhwt2Ubov1beGW9cU
	FVNSpuB0XwZCD334QEK65afOCW+OiWkzYd/pz0M9lFthgNRJwxWLCbhARC5akXg=
X-Gm-Gg: ASbGncuOlBmskTKE6kaAYiddgFFJStSQCTS/DqvoU9EPdpTKjm8mjmTQ5SQy06eUB5i
	9pikGeULIG3iZF2zTiJqHq+8J5Og2yCoVZZKwHy+K2BHC4h8rkHMGpz0/TUIuv70QkP8dDvBduw
	CQCrbXHEsSuvP25nSYmwV7ab3dmkMPauTxyLJmCYQcBqo5bpmKVT+6izg7+WaWDdATcxPxhi0OZ
	A4OvbreNmFm/3DkiCuvZiJgSVYl9zx3OZkyS5NLplQrKSIVNfwLevbfgerX1xcjC+MO4xS/Ju8q
	Fxjl+1nyGAAUTNVRQAHg6GnV
X-Google-Smtp-Source: AGHT+IGpheiFaPQV+vHiSGfdo4uJer00Fm7VGOok0pckB2A3V+XmwGYe7G6QUkbygmdGPwoLEH9X6w==
X-Received: by 2002:a05:620a:6002:b0:7c0:b0a8:52e6 with SMTP id af79cd13be357-7c0cef4953emr3752564485a.46.1740636978196;
        Wed, 26 Feb 2025 22:16:18 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c36fee9844sm72875785a.19.2025.02.26.22.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 22:16:17 -0800 (PST)
Date: Thu, 27 Feb 2025 01:16:16 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] zswap: do not crash the kernel on decompression
 failure
Message-ID: <20250227061616.GD110982@cmpxchg.org>
References: <20250227001445.1099203-1-nphamcs@gmail.com>
 <Z7-9o81kBfw4tFSz@google.com>
 <20250227043141.GB110982@cmpxchg.org>
 <Z7_7vah_U1JzmpCX@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7_7vah_U1JzmpCX@google.com>

On Thu, Feb 27, 2025 at 05:44:29AM +0000, Yosry Ahmed wrote:
> On Wed, Feb 26, 2025 at 11:31:41PM -0500, Johannes Weiner wrote:
> > On Thu, Feb 27, 2025 at 01:19:31AM +0000, Yosry Ahmed wrote:
> > > On Wed, Feb 26, 2025 at 04:14:45PM -0800, Nhat Pham wrote:
> > > >  	if (WARN_ON_ONCE(folio_test_large(folio)))
> > > >  		return true;
> > > >  
> > > > +	entry = xa_load(tree, offset);
> > > > +	if (!entry)
> > > > +		return false;
> > > > +
> > > 
> > > A small comment here pointing out that we are deliberatly not setting
> > > uptodate because of the failure may make things more obvious, or do you
> > > think that's not needed?
> > >
> > > > +	if (!zswap_decompress(entry, folio))
> > > > +		return true;
> > 
> > How about an actual -ev and have this in swap_read_folio():
> 
> Good idea, I was going to suggest an enum but this is simpler.
> 
> > 
> >         ret = zswap_load(folio);
> >         if (ret != -ENOENT) {
> >                 folio_unlock(folio);
> >                 goto finish;
> >         }
> > 
> > 	read from swapfile...
> > 
> > Then in zswap_load(), move uptodate further up like this (I had
> > previously suggested this):
> > 
> > 	if (!zswap_decompress(entry, folio))
> > 		return -EIO;
> > 
> > 	folio_mark_uptodate(folio);
> > 
> > and I think it would be clear, even without or just minimal comments.
> 
> Another possibility is moving folio_mark_uptodate() back to
> swap_read_folio(), which should make things even clearer imo as the
> success/failure logic is all in one place:

That works. bdev, swapfile and zeromap set the flag in that file.

> 	ret = zswap_load(folio);
> 	if (ret != -ENOENT) {
> 		folio_unlock(folio);
> 		/* Comment about not marking uptodate */
> 		if (!ret)
> 			folio_mark_uptodate();
> 		goto finish;
> 	}

Personally, I like this one ^. The comment isn't needed IMO, as now
zswap really isn't doing anything special compared to the others.

> or we can make it crystal clear we have 3 distinct cases:
> 
> 	ret = zswap_load(folio);
> 	if (!ret) {
> 		folio_unlock(folio);
> 		folio_mark_uptodate();
> 		goto finish;
> 	} else if (ret != -ENOENT) {
> 		/* Comment about not marking uptodate */
> 		folio_unlock(folio);
> 		goto finish;
> 	}

This seems unnecessarily repetetive.

