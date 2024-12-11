Return-Path: <linux-kernel+bounces-440767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 500849EC3E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC8D282B46
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB90C1BC07E;
	Wed, 11 Dec 2024 04:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mdiZNIjb"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48132451C0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 04:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733890279; cv=none; b=UM2+J2DvJH3tPkNf9ZjZWF2JHA6qtOacaNl9o3PIbkHBXlebIWwsn/8ZjhV22mtd3yMRbtAqqnN7EeAKar71o6FmIkKPQqHEJunmCMvYaTgyf2+jOshsI+9hFt8akBXilVPpOS6EJSwJfD9yyzsN8gi2ryReaNE4/akr+nqxc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733890279; c=relaxed/simple;
	bh=c58nihJmzHp29pA8kzUOhA1/r5iZuRgG591QDfhfr88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0N/Gh3l2iaT6oQVCi6L4AoFK0wyPbuif6ssz9UC3Zk9sQCP28x6FrLq5ojNg+Uc0N9omjhWpclY+6r+WOzfyDTzxNiTYMswmU9ZYHUvETChE56MsVRwI1kwQom+e8beYlLCgmZNAQ7xtesIBK/QrjB/0wor8J9EOH0U1xMw77I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mdiZNIjb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so5606740a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733890277; x=1734495077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQNAPGLTYqHsPyMqQBEBauzuDY5B9rUBU0gS2x2EpUg=;
        b=mdiZNIjb7IoLBTIGVdoijIl4XlFX32csG+eaY75bTWRSmGgApoXb6in5RB9YtPPS0g
         Lkm7N+RC+3SQaOGHt9gi1verqgrm5P2Rt1r1uQO1RDGNoZKEarbc/cr1G2Wqvf5MrbNF
         1MuetSgSL4TePI5X0Y48T3jiRSCHLC1nwWeM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733890277; x=1734495077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQNAPGLTYqHsPyMqQBEBauzuDY5B9rUBU0gS2x2EpUg=;
        b=fhMMUglWUh+4kKzF9jqdUN5v4aXMaKHfEOuNi/Df6HA5BQWFI0J6fjsNQHONiPlUdP
         789PzsUF6ULaCVUAKpJVsM1dqSc6IdLOT+mf++i9Ow0kGq65r4c2VMBdpoay7U8BRt0C
         5b3Vr8Jj7CceQ2FQXzisGqphoZIz+QD3jcE6wu6R8jLlVg/zotaMsxL193QzfxQe3DaX
         4lriksnwLY7oTblM22DXqoHigioo0GIfWYSl+DfZHkjhQxxUJacQcQm6q4bwNZfayicW
         aqCTfEIgbbDAXbt+tS0rKTtxIvkKfuSZbLcJTeUEvQgzFMDhqzu06QDiiIjTFHjUM9u2
         DhFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMS+j6sbS6OQ3AlVGiXoYBbEu0bbmSYO6ZLjWTWYuKUvKynnKAdOHTz0sZu3L6TTg2gWzMaKrqdoK8GPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfb2nlkFSID7kooAIdEqmadajMerEA+qE7OD+emnl/VNE7tKfY
	1StaXFKyzwf+yphvcwI7Q24dlUMwPl5dBk81+Lm7Q7FXhA3jui9h1+6zWhO8Fw==
X-Gm-Gg: ASbGncsaGS6DdGx/zAkW2abnIxMpba2mSy2z+zpFPBZaHpbaM7t+p/kFP/rTDVt50KJ
	scqeS1SPu1oxNh4wWRwfDQFSv1+Tsg6BpLS/jzbn9T8PxkEGmGGu6YjFFdtKA33FSVVpqYdo6oZ
	njAriJvNidydACRZq645rE+8Q2f3wYTOj27m61u65GKhev2YgDdHaiPkYTpD89CNXLyH+7zwpgt
	FjF83IGnaX5Bc6KJZg6Vd3dUprAUpfM2q7Uk1Em8OwTfPTUo3V1gMMtjA==
X-Google-Smtp-Source: AGHT+IEECCaYjCvHpajq5DN4jssUNSh9mlYRCPVm4jNMCrBot9wxnihWKK5FQR/46e75Oq6BZhGukA==
X-Received: by 2002:a17:90b:3d04:b0:2ee:fa0c:cebc with SMTP id 98e67ed59e1d1-2f127fd863bmr2557461a91.20.1733890277006;
        Tue, 10 Dec 2024 20:11:17 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd438e4bf1sm4517606a12.25.2024.12.10.20.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 20:11:16 -0800 (PST)
Date: Wed, 11 Dec 2024 13:11:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] zram: cond_resched() in writeback loop
Message-ID: <20241211041112.GC2091455@google.com>
References: <20241210105420.1888790-1-senozhatsky@chromium.org>
 <20241210105420.1888790-2-senozhatsky@chromium.org>
 <20241210165456.288ed82b8a66a08ac36a4d15@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210165456.288ed82b8a66a08ac36a4d15@linux-foundation.org>

On (24/12/10 16:54), Andrew Morton wrote:
> On Tue, 10 Dec 2024 19:53:55 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > Writeback loop can run for quite a while (depending on
> > wb device performance, compression algorithm and the
> > number of entries we writeback), so we need to do
> > cond_resched() there, similarly to what we do in
> > recompress loop.
> > 
> > ...
> >
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -889,6 +889,8 @@ static ssize_t writeback_store(struct device *dev,
> >  next:
> >  		zram_slot_unlock(zram, index);
> >  		release_pp_slot(zram, pps);
> > +
> > +		cond_resched();
> >  	}
> >  
> >  	if (blk_idx)
> 
> Should this be treated as a hotfix?  With a -stable backport?

Actually... can I please ask you to drop this [1] particular patch for
now?  The stall should not happen, because submit_bio_wait() is a
rescheduling point (in blk_wait_io()).  So I'm not sure why I'm seeing
unhappy watchdogs.

[1] https://lore.kernel.org/mm-commits/20241211005510.842DFC4CED6@smtp.kernel.org

