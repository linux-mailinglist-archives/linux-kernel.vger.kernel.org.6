Return-Path: <linux-kernel+bounces-407825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58EA9C74D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6647228175C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8520F7083F;
	Wed, 13 Nov 2024 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgUkGrrA"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27F23A0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509653; cv=none; b=q3BTPytRB1+dt1r+mfuyAdI1IxE4QLowjKWbHo0aJHKlZPvR2/yh98Xywr4ltZQT7iZ0F+sBxStezom4Q3kBtO6CfuMeDnj/9CptM4548CoDfqHmR02MNXy9VfPicVNvkWv1LE3/fLh/7p+xc4ED+wtmqQbHT0+GH2Woz2Dl5Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509653; c=relaxed/simple;
	bh=t9CLY7xZ/euV4YdMH/kaMgQLgWy4KBQHWDVjKzpAfAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUk/AFCtIoUt+21ENIuByqTPsH6rVrUQlKfS5iecH2647KkKBuPDRKOfhE43uCP/Gs6gn9VuGKyK9Ey6x/nbmQoQUN1ug9kN0jPP3b/DvIlTriFaR/4stzjK8qdsd+lv6t8nAbIP+Z2Ob3tIrb1IK77dRg3Zy2yVw8OxeR1/rDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgUkGrrA; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso97340861fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731509650; x=1732114450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPsqq3GsgW5QLtdw2wIeuLt0KF0vtG6d+ArqDrwNOtQ=;
        b=PgUkGrrAsZQwQsTRUPUDs7dsI33bYnjB3j0AYxrZp74HJ+xX+pG1uedNe1DZZL1JTy
         8FxkPKkj6j2TTACyW+mlEUIPCrg/Ptb8aOjiESLTxHeEoQJtNuUbaYf5IgOSSMXPf7IU
         2XHUxcrbVR7fBu7C/Jh3QBj8cg/2BzQRFVysT94o1GZr7fNlKsbnH6cQpx+UPLVmxdTr
         /qwP/KH6UhtdXApZKOpHl0WBMig2wvPEQzmrwwz/BxF5ZapYNlLpM8RdkF/iw6yMuFLq
         T5Nq6E7sJUtn1GjOfVzmcsk/NrSyLzLPdc/jwo4VUH6YQyanXy2oj9PhIRStK9IPVjV5
         1Lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731509650; x=1732114450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPsqq3GsgW5QLtdw2wIeuLt0KF0vtG6d+ArqDrwNOtQ=;
        b=nhFpEAffyqaMr3L6RJ7ygHK134C8YFiZsPfRmVtfABCYRNXXJ/BkLY4XzEWDEghwF5
         yb7zthvI6q8Gjmw/4eURReyZiiMDkSW6YTV6jXIo4BxUh6RAKLkBpBMQuRobuv0ac+q6
         uJyzg5a0Qa1MzCNMl2DeS12aN0xuSnGwOMCbxTbmWzcv3Dcy8V0HqPPTNj45BkdHKw7l
         TnGnFZpzmftP8KKIMBNSDLN360S4yvs9yFTolV20/EmuQX2ibV65z6Vj2TKukrgza3pd
         wzLvD2WGMWPG17AqffDpIdJplXmf2USMKcwE0CTWjnPz9G4/MLjp1EmkWjLLJ3YuB3pz
         nbBw==
X-Forwarded-Encrypted: i=1; AJvYcCUYrZAf6xASQ7+Qs/GYm3PuW6lxRouYOqsqPu0OL4zcUjzCJzA6leViSfjMQevv2zUk9mA1rUlhB8Fhjp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbLsxhRq/eUlApX40mccxGKUE2X0IRoryruYU3jYNqnmWEODW
	LMnElS4hdvvUZbfvnky8KnokHryyBifG7bJle6BFkz92/II++C2U
X-Google-Smtp-Source: AGHT+IFyJLrsSDJUOCNHFogeMgexCMp5IS+HXBgXMCDqPwZeB+ErCgI7Ol9mjj8/kWudvB2qEEyAeQ==
X-Received: by 2002:a05:651c:554:b0:2fb:4f8e:efd with SMTP id 38308e7fff4ca-2ff2028a97amr155476111fa.32.1731509649214;
        Wed, 13 Nov 2024 06:54:09 -0800 (PST)
Received: from f (cst-prg-85-239.cust.vodafone.cz. [46.135.85.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4b5f1sm893784266b.60.2024.11.13.06.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:54:08 -0800 (PST)
Date: Wed, 13 Nov 2024 15:53:54 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	willy@infradead.org, liam.howlett@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/5] mm: move per-vma lock into vm_area_struct
Message-ID: <hcwwxvl4bzyejjtdmrzwvwfyejzi2so2kke2b5yls3z2o67gou@67hxetrsr5ec>
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-3-surenb@google.com>
 <637370b8-3e3e-4457-81d6-5913a3ff1d4e@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <637370b8-3e3e-4457-81d6-5913a3ff1d4e@lucifer.local>

On Wed, Nov 13, 2024 at 02:28:16PM +0000, Lorenzo Stoakes wrote:
> On Tue, Nov 12, 2024 at 11:46:32AM -0800, Suren Baghdasaryan wrote:
> > Back when per-vma locks were introduces, vm_lock was moved out of
> > vm_area_struct in [1] because of the performance regression caused by
> > false cacheline sharing. Recent investigation [2] revealed that the
> > regressions is limited to a rather old Broadwell microarchitecture and
> > even there it can be mitigated by disabling adjacent cacheline
> > prefetching, see [3].
> 
> I don't see a motivating reason as to why we want to do this? We increase
> memory usage here which is not good, but later lock optimisation mitigates
> it, but why wouldn't we just do the lock optimisations and use less memory
> overall?
> 

Where would you put the lock in that case though?

With the patchset it sticks with the affected vma, so no false-sharing
woes concerning other instances of the same struct.

If you make them separately allocated and packed, they false-share
between different vmas using them (in fact this is currently happening).
If you make sure to pad them, that's 64 bytes per obj, majority of which
is empty space.

