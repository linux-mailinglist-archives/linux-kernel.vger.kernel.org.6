Return-Path: <linux-kernel+bounces-230151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C82D91791C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113CD283219
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDB014D70C;
	Wed, 26 Jun 2024 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke+aOl+C"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA48171AD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384246; cv=none; b=aJ/KlEkfM8PSoHu1jLxAs3szqL3oLp6vn+z0O/sduqPAf7OzZ1QxaqBf09RQk8qJEpI1HETNXTuzazcwimZFvrbDlqlQjFl8r+a3icg7VssuMfjrGBfXfCdcIBILUt86MkwJAnrBnTBCp/3scrnGK5Ax78X04/lJijA2aHnSVL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384246; c=relaxed/simple;
	bh=CnrFWiV6+PQGf6bq++sRF//4nL5UuefToDuOKiRZGGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUQGBb80+4bHSLLYvnXgSdAn6vamARcSaawMacseqrL3Qj++up5pE35+9upH64WXTJYzt+DHfWdVrUqZ9J8gq01M/WfsquNFf4N0CvUEGE+w2cxQw6HlyDYGwZwyY7K/BmQv+axyMLKlbYszYYflf/8Hs1iVgJtxgAvLfctZQIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke+aOl+C; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d562b35fb6so96249b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 23:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719384243; x=1719989043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNw0dskDHLVIQXzCGgLODiSI5oPf0Z65i8AIhbRzTM0=;
        b=ke+aOl+CR3kGOri2VW+veSaV3AS63icy5EUGr1YiM7BveOAg3r83+g3nxo9+ExlKJG
         pi5v0KZoFZRZBeA5vhKP5CXSPLhijVYhg83e9MtEp8OXS70/F+bFU+XkrW7usqufR2LI
         /cjjw84bwUwv/o+WYfu/ncFH+CzYKhblKc9Q449dprwc+HhAidaI5SSnZjKxKPFpu/08
         MXuhqSCa4QnxCmgH07efXudrQQ0UFhgjagYyHkQROR3H4JW6R6j4zVKCrpy74hpK7lQg
         h9hii5hl4JQoWRODdHZJNqhbuRSrWRbpPK+vkLCAl77as7wbVzMeKLlk2n/jZPc/kJ59
         drMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719384243; x=1719989043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNw0dskDHLVIQXzCGgLODiSI5oPf0Z65i8AIhbRzTM0=;
        b=tNeaonz0H9VcFwYrjFj+KCq3bqi8dAsxwnhI8VeuGwmZwKfYDVZx9UqHpAuozbtU1n
         La/k4r47fudvy/hjJvqhFeLFEZ62785oahtLO/STpzyBBbDq5iOo7h7J8t2dmhS8yDn8
         3ew7IeX94HnIqUO16EjQfAhmfM+aFXivRiN+LBiuaxWaXENqtMueV9O2OkDlDV1edneB
         hI7qJpZ02SxBkbLHx2FcJjT0IYT/qK++DInexSi/R1m7aSef/kKWWh8Q4Q9GpzroObSa
         ftlbi1y10D8+lnO/e0b0rAMMR2Lzixqb8SKhr0gqWDH14xbBTELsfHGagyX52MT0gM7n
         hsKA==
X-Forwarded-Encrypted: i=1; AJvYcCWiOQsajfsuoBdLf3QpM2qglXDwcsxsazDRqXri1/H9ZbTzDzWe+6ISADG2cED3RedP7TioA9ESIjD9IxuE8V1fQiSKivLpzNmaEQdg
X-Gm-Message-State: AOJu0YyK5xokaiBDAZppHq06Rf0BuHF8HnzQBp4XljB0LG0wgs8DNDkV
	fH947a8JmOrmvptgSITR93R6aKtuRrNaw0P32DXejsKaODngsFbT
X-Google-Smtp-Source: AGHT+IEh4Y/5K7DnRvm22rOOcOL3Obh8b2E7hfzm7A4/EcLjkbK17Ij8bQ9YtNn+GqFGTh1tj6wJ/w==
X-Received: by 2002:a05:6808:1701:b0:3d5:4256:26d4 with SMTP id 5614622812f47-3d542562770mr11477631b6e.7.1719384243533;
        Tue, 25 Jun 2024 23:44:03 -0700 (PDT)
Received: from localhost.localdomain ([43.135.72.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7068c719371sm4311312b3a.102.2024.06.25.23.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 23:44:03 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: mhocko@suse.com
Cc: akpm@linux-foundation.org,
	alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	ebiederm@xmission.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mjguzik@gmail.com,
	oleg@redhat.com,
	tandersen@netflix.com,
	willy@infradead.org
Subject: Re: [PATCH v2] mm: optimize the redundant loop of mm_update_next_owner()
Date: Wed, 26 Jun 2024 14:43:59 +0800
Message-ID: <20240626064359.79119-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <ZnU-wlFE5usvo9ah@tiehlicka>
References: <ZnU-wlFE5usvo9ah@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 21 Jun 2024 10:50:10 +0200, Michal Hocko wrote:
> On Thu 20-06-24 19:30:19, Oleg Nesterov wrote:
> > Can't review, I forgot everything about mm_update_next_owner().
> > So I am sorry for the noise I am going to add, feel free to ignore.
> > Just in case, I see nothing wrong in this patch.
> > 
> > On 06/20, alexjlzheng@gmail.com wrote:
> > >
> > > When mm_update_next_owner() is racing with swapoff (try_to_unuse()) or /proc or
> > > ptrace or page migration (get_task_mm()), it is impossible to find an
> > > appropriate task_struct in the loop whose mm_struct is the same as the target
> > > mm_struct.
> > >
> > > If the above race condition is combined with the stress-ng-zombie and
> > > stress-ng-dup tests, such a long loop can easily cause a Hard Lockup in
> > > write_lock_irq() for tasklist_lock.
> > >
> > > Recognize this situation in advance and exit early.
> > 
> > But this patch won't help if (say) ptrace_access_vm() sleeps while
> > for_each_process() tries to find another owner, right?
> > 
> > > @@ -484,6 +484,8 @@ void mm_update_next_owner(struct mm_struct *mm)
> > >  	 * Search through everything else, we should not get here often.
> > >  	 */
> > >  	for_each_process(g) {
> > > +		if (atomic_read(&mm->mm_users) <= 1)
> > > +			break;
> > 
> > I think this deserves a comment to explain that this is optimization
> > for the case we race with the pending mmput(). mm_update_next_owner()
> > checks mm_users at the start.
> > 
> > And. Can we drop tasklist and use rcu_read_lock() before for_each_process?
> > Yes, this will probably need more changes even if possible...
> > 
> > 
> > Or even better. Can't we finally kill mm_update_next_owner() and turn the
> > ugly mm->owner into mm->mem_cgroup ?
> 
> Yes, dropping the mm->owner should be a way to go. Replacing that by
> mem_cgroup sounds like an improvemnt. I have a vague recollection that

Sorry for the late reply.

Replacing that by mem_cgroup maybe a good idea, a rcu lock looks good, too.
But before the above optimization is implemented, I recommend using this
patch to alleviate it. Both [PATCH] and [PATCH v2] are acceptable, they only
differ in the commit log.

Thanks for your reply. :)
Jinliang Zheng

> this has some traps on the way. E.g. tasks sharing the mm but living in
> different cgroups. Things have changes since the last time I've checked
> and for example memcg charge migration on task move will be deprecated
> soon so chances are that there are less roadblocks on the way.
> -- 
> Michal Hocko
> SUSE Labs

