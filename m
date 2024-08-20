Return-Path: <linux-kernel+bounces-294377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C618958CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B8C28313A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D5C1BBBE0;
	Tue, 20 Aug 2024 17:13:44 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F97F18C92C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174023; cv=none; b=aQTbOl0hJdpTSSWPrsHmuuHPOmgmfdbZFc4CZ8VIrExqY9z0xe/cDk17c34uncjDmFfnOxP4ut8TOomlO5O68ZuDAZvw+BACBL2gkTUOMEh8+mgNgDZbF9KMlB6G6uBcQbeYb1eERKVrQedowZAc/w4aufBHT/5uux44CUkTFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174023; c=relaxed/simple;
	bh=IVsI4NX1RYhDiNJ26GZ5B1ghvs58WCFrHs9lrbmlAJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEfYVQ3xJ8WTwQvlNYoxvJyE5sc/R+XQ/XIdbIUowdXGnSCMFicvctJEZiBC3jF+atlkUvm70AyZ3iqRfA1kQVZ9cDSnsMIYdFERomkD0GP6UF3KaJxpmiVBw1K3K86pTLPJylhfdxAR7EZhA3yykjzpUQM48WB25Ku8wclCSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso66415511fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724174020; x=1724778820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPfvRz364Yrg31+aCz9pQMAt48YtNxQfL5cE9h5IPF8=;
        b=gTO0yI3xLdbG3ODSQPNbzrp+Tp1v7FcILJ8BaqeJQ8a8u7XADOIh43Tx92o60kZm3H
         0IwzyLZpvuCuppi5qjgNnWmDhmp8vcyTOIA9vqdjpYqB3urW/qrGd9qx0EXa2V+iwagB
         j3ubEhVI7l+9fKQBedLvwTPJUXJaG7fi4Y5CdPiPc1KNDNUayyKj9+mSSNFGQyq+yUl/
         M37RqAdA6bGcNblGwxOAP13flLLEZGIaGzkR9+zLvCFT7PkG8tRdsFrjjcyXhD3pId+D
         j/0DLGn4uNQ0/5jFrmnk0o/P1lJB2lEZAiR290IDv5xXA3NjH7HU/qWNfBUUi7O9JCGX
         k9VA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ6ydWZHbMk9+70zyPc/MFZ4kdX8akEJTiI3/2k57FFbyTzOOvRVZVHyDyR0OM0H9Xsfno1HfUFrhoezc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxosHF4BW/x/8znWdESIubMGxNxoe4qBBeN6vXf2vgp9eAH685z
	+K+OZlNoq7q6uCIF+ljYNt+q9+3mtwc3sG3pHWvZUrIg+jWw8Jmx
X-Google-Smtp-Source: AGHT+IFEW9gb00cLbV3AnseNpxMNkEqRhtSBtJMPviVtuhQF/3fVTImYCBW09nPL/SoyTtinFUg+tQ==
X-Received: by 2002:a05:651c:507:b0:2f3:ed61:d168 with SMTP id 38308e7fff4ca-2f3ed61d2c8mr18618911fa.39.1724174019322;
        Tue, 20 Aug 2024 10:13:39 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc081cf5sm6948059a12.90.2024.08.20.10.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 10:13:38 -0700 (PDT)
Date: Tue, 20 Aug 2024 10:13:36 -0700
From: Breno Leitao <leitao@debian.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, yuzhao@google.com,
	david@redhat.com, huangzhaoyang@gmail.com, bharata@amd.com,
	willy@infradead.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Johannes Weiner <hannes@cmpxchg.org>,
	zhaoyang.huang@unisoc.com, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH RESEND] mm: drop lruvec->lru_lock if contended when
 skipping folio
Message-ID: <ZsTOwBffg5xSCUbP@gmail.com>
References: <20240819184648.2175883-1-usamaarif642@gmail.com>
 <20240819181743.926f37da3b155215c088c809@linux-foundation.org>
 <29e481af-b5e1-4320-a672-8251f5099595@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29e481af-b5e1-4320-a672-8251f5099595@gmail.com>

On Tue, Aug 20, 2024 at 11:45:11AM -0400, Usama Arif wrote:

> So Johannes pointed out to me that this is not going to properly fix
> the problem of holding the lru_lock for a long time introduced in [1]
> because of 2 reasons: - the task that is doing lock break is hoarding
> folios on folios_skipped and making the lru shorter, I didn't see it
> in the usecase I was trying, but it could be that yielding the lock to
> the other task is not of much use as it is going to go through a much
> shorter lru list or even an empty lru list and would OOM, while the
> folio it is looking for is on folios_skipped. We would be substituting
> one OOM problem for another with this patch.  - Compaction code goes
> through pages by pfn and not using the list, as this patch does not
> clear lru flag, compaction could claim this folio.
> 
> The patch in [1] is severely breaking production at Meta and its not a
> proper fix to the problem that the commit was trying to be solved. It
> results in holding the lru_lock for a very significant amount of time,
> stalling all other processes trying to claim memory, creating very
> high memory pressure for large periods of time and causing OOM.
> 
> The way forward would be to revert it and try to come up with a longer
> term solution that the original commit tried to solve. If no one is
> opposed to it, I will wait a couple of days for comments and send a
> revert patch.

I agree with the concern, but for a different reason. Commit
5da226dbfce3 ("mm: skip CMA pages when they are not available") was
intended as an optimization, but it  changed the behavior of the
isolate_lru_folios() function in a way that had significant, unintended
consequences.

One such consequence was a notable increase in lock contention, as
described in [1]. Addressing this lock contention issue with a quick fix
seems like a suboptimal solution for such a core part of the system.

Instead, a better approach would be to rethink the original
optimization. Rather than applying a band-aid to the lock contention
problem, it would be more prudent to revisit the changes introduced by
commit 5da226dbfce3 and explore alternative optimization strategies that
do not have such far-reaching and difficult-to-diagnose effects.

[1] Link: https://lore.kernel.org/all/ZrssOrcJIDy8hacI@gmail.com/

