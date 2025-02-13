Return-Path: <linux-kernel+bounces-512913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E13EA33F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF948162681
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602A6221704;
	Thu, 13 Feb 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aaoZdTz7"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB5221570
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449750; cv=none; b=UUi5Nxtl4B94n+edE9RYP0PiGKs/RxqoItnA2/p8aJtnt8Ac5xi8o+uovYM8kFzn0msVIPuTYby7r9A2jxARmAVwmrggMFT0TfrCrskVknaL4/ZwhZZgWMx25HU5qczXuWzC1fjF52bFUOuPbch9z6yPPx9og0N7h5oW06WZT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449750; c=relaxed/simple;
	bh=15aV3C5iXt/K20K1GXrgUiHDvIkbgpNT7xTAnC7OwUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdo8W7ygxv9tcbJoBH4Ch6r8v/LFBAnlBT02RYDAT1isTLmAS+IRvHHYfssb8GJfx0o5DdtM0vuySenb/Mz/IbW9UtQYzn92fJsSD3McACpo3Y8TXZSHEcFBRNM0LqzypvqI4lZsQenqLCcYKNZZXK0ZyhHHXyxyhqUMglYMDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aaoZdTz7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f49bd087cso11385735ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 04:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739449748; x=1740054548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip5h1JfWGabWfAWrvBtypMY3P6wpAqFefktZh/UCz2c=;
        b=aaoZdTz7TmzLjEiW83GfTaII7WnFoIHJHint6AShaWIivSOjEX81O/lVyw4PUdftbr
         w5Mdv92WpUOW5HVRFs1127I3YkklHNIQHoE1eVOUA++zDBTOXdY512KRdCc6bAF5YWWN
         mubLQCQ+6vXHkUV59KXkQrv13Cp+pJ2z4js+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739449748; x=1740054548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip5h1JfWGabWfAWrvBtypMY3P6wpAqFefktZh/UCz2c=;
        b=Rswuq5FiOSCE4+tXk9kavV8Kg2C2zTbP/3Tp+4j62dnJq9Y9LmIt2AUUB1cIm4crMd
         lzmkvSLaIkmgMTzvTlRseXPxHVrPcMemLkpOedKDgEVhkxCCupHgRmdtBJHYFcVrtWg3
         lxGeWObFEiHqSdS2f49gaPhbZQuPGU2ZLZfhSbiN35Y5jpSKek3ymN0Lsrhbe/Alql4d
         ePj5T3tb1ELEsH6ztXY2L7Pr80T7ZpNAlH6ZVpsZvmvnUiPdMcicvqm/mf+F6azNlSmB
         omwRzimhYLcF/SvECY6GZHwds+/7+HVWnRcgjzm41fh9x6aUnv0R4oRACaeftEcifpw9
         eFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvyfOJ/psWfYKFCtYTGASF36rlqTOwPFKuhE0gz4xvnjQVSzHB/BHbgNnbux+tLk0z2yWZmg9ldx8QGfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBD6V4YouTBOD41PdaKxRXca3FzXJocmSczM/hLEvHuniZNiP
	J+ofr2OYqGSfXQW95j4G47+FN/X0/DJ1EuT+evVlMyDKBG9T0P5rXD/3QlDrPg==
X-Gm-Gg: ASbGncvnbcXvzUGmmqwLAqDdtE7rfcyv4FsOBwf17C/VD4NlSUebgcZ8U/v0ot2G+ul
	Rrrdnczui/vieglQlBnNwpdBF6GCfWwd57iHtIQPbx+4uiczzbDVeWWWPr31ZY3BXfbqgXVKk9c
	7y/NN+7qEGMf7iBtsnEzOyBT7kdfNFHWLdLTkyDFOA3O0U5wrGyNXiMHQptHRBFqJP7MJI/Vc8G
	nQ4NYjTGaw+CxIdR/4NDTL+J9aA9cjG2TTYy+fI5ymoF/2gOhRXzlZqpGyefC335s0MVEBHD3Rg
	EoBuEqfrdtrL9ti6v+8=
X-Google-Smtp-Source: AGHT+IGvy9bHiW6eLIQST65q4a0D5N/cE4ix+Nk7FRtNm71aqWece00BtmbRZzNr2vej9UsDDSn/cg==
X-Received: by 2002:a17:903:138a:b0:215:aee1:7e3e with SMTP id d9443c01a7336-220d1eb567cmr53800975ad.5.1739449748326;
        Thu, 13 Feb 2025 04:29:08 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3ed3:97ce:5f5f:1f61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f4f62sm3209135a91.26.2025.02.13.04.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 04:29:07 -0800 (PST)
Date: Thu, 13 Feb 2025 21:29:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/18] zsmalloc: make zspage lock preemptible
Message-ID: <uuejsxdilozxhallkev5tspm6kfpe47lgkoonlubnauwj4ckvm@iui2n2g56cat>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250213113248.2225-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213113248.2225-1-hdanton@sina.com>

On (25/02/13 19:32), Hillf Danton wrote:
[..]
> > +static void zspage_read_lock(struct zspage *zspage)
> > +{
> > +	atomic_t *lock = &zspage->lock;
> > +	int old = atomic_read_acquire(lock);
> > +
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +	rwsem_acquire_read(&zspage->lockdep_map, 0, 0, _RET_IP_);
> > +#endif
> > +
> > +	do {
> > +		if (old == ZS_PAGE_WRLOCKED) {
> > +			cpu_relax();
> > +			old = atomic_read_acquire(lock);
> > +			continue;
> > +		}
> > +	} while (!atomic_try_cmpxchg_acquire(lock, &old, old + 1));
> 
> Given mcs_spinlock, inventing spinlock in 2025 sounds no good.
> See below for the spinlock version.

I should have sent this series in 2024, when inventing a spinlock
sounded good :)

> struct zspage_lock {
> 	spinlock_t	lock;
> 	int		cnt;
> 	struct lockdep_map lockdep_map;
> };
> 
> static __must_check bool zspage_write_trylock(struct zspage_lock *zl)
> {
> 	spin_lock(&zl->lock);
> 	if (zl->cnt == ZS_PAGE_UNLOCKED) {
> 		// zl->cnt = ZS_PAGE_WRLOCKED;
> 		rwsem_acquire(&zl->lockdep_map, 0, 1, _RET_IP_);
> 		return true;
> 	}
> 	spin_unlock(&zl->lock);
> 	return false;
> }
> 
> static void zspage_write_unlock(struct zspage_lock *zl)
> {
> 	rwsem_release(&zl->lockdep_map, _RET_IP_);
> 	spin_unlock(&zl->lock);
> }
> 
> static void zspage_read_lock(struct zspage_lock *zl)
> {
> 	rwsem_acquire_read(&zl->lockdep_map, 0, 0, _RET_IP_);
> 
> 	spin_lock(&zl->lock);
> 	zl->cnt++;
> 	spin_unlock(&zl->lock);
> }
> 
> static void zspage_read_unlock(struct zspage_lock *zl)
> {
> 	rwsem_release(&zl->lockdep_map, _RET_IP_);
> 
> 	spin_lock(&zl->lock);
> 	zl->cnt--;
> 	spin_unlock(&zl->lock);
> }

I see, yeah I can pick it up, thanks.  A couple of *minor* things I can
think of.  First. in the current implementation I also track LOCK_STAT
(lock-contended/lock-acquired), something like

static inline void __read_lock(struct zspage *zspage)
{
        atomic_t *lock = &zspage->lock;
        int old = atomic_read_acquire(lock);

        rwsem_acquire_read(&zspage->dep_map, 0, 0, _RET_IP_);

        do {
                if (old == ZS_PAGE_WRLOCKED) {
                        lock_contended(&zspage->dep_map, _RET_IP_);
                        cpu_relax();
                        old = atomic_read_acquire(lock);
                        continue;
                }
        } while (!atomic_try_cmpxchg_acquire(lock, &old, old + 1));

        lock_acquired(&zspage->dep_map, _RET_IP_);
}


I'll add lock-stat to zsl, but it's worth mentioning that zsl "splits"
the stats into zsl spin-lock's dep_map and zsl's own dep_map:

                              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
                          zspage->lock-R:             0              0           0.00           0.00           0.00           0.00              1              2           6.19          11.61          17.80           8.90
                       &zspage->zsl.lock:             0              0           0.00           0.00           0.00           0.00           5457        1330106           0.10         118.53      174917.46           0.13

That is, quite likely, fine.  One can just add the numbers, I assume.
Second, we'll be carrying around two dep_map-s per-zsl in lockdep builds
now, but, again, that is, likely, not a problem as sizeof(lockdep_map)
isn't too huge (around 48 bytes).

