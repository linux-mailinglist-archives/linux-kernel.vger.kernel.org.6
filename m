Return-Path: <linux-kernel+bounces-265331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E8393EF9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056AF1F211E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F49132117;
	Mon, 29 Jul 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hbpf68aG"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFF12BB1B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240927; cv=none; b=W2/5/3f4p0mWKrYhtw3Cmwr1Kd6jvz41gkK0ZkLJN97idxOH0cG9170th6JQhYuHbCaMExMS+6exLbAupZkOWUNVl2utZoyZj6cS5CoNgyUn/osrIr1cYfmmU5V7aM3oxIQO6X/O9oGWMctBkAZH+XLPYPYt71J1d1r0v3u4k9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240927; c=relaxed/simple;
	bh=bVyaHbdFtxCDGAaSD7318GU+5ypRDTaqDBrfeVnmHYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gp4pDhMOOmW7tWTg/UwT3JgaDuzIj/5GX4vwM8AqGMrJ6XW8qE5gURJd+9YOUEMPtx4nhWzTgbljLNT9lmNrtWvfPU0mIUp0pumww3+p1s6FS+/fnWQvXG9HcCZ+r61S8vfRWjqDqXY+gmQWrD/sq+s90ossOX03GFaLvgQtxG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hbpf68aG; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efd855adbso4822728e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722240923; x=1722845723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HVjA+bIcDpbnmzrciVh7kfXXZ60SEX5d5fn8ZISA1a0=;
        b=Hbpf68aG2K7Jtlc5VwPajs9DMsUO0kiXZWtWxqv696ssvg8oOpghWw2LpTexW8egD/
         46NBSuUswQhgc+GcGIbL/CSyS3UEwgdH5FgXIfRx8AWJfhtPs5z7A784v3JNXiW0skiZ
         awt/wgqZGqnB3xHIU4GqvGrapD9ti0LVPsmWyVPB/mUN/5T3BycYlz6Ijx7yh52VS2hu
         wjyBXMyprFEtSldtZNITjNMWWTAWxxFFSErRU20iqmK0LpvQDicSI6piFf7lZtcPpRkZ
         JVcBXOjdK875Avn5SF3ALPIxoCRYa0wPmTj4CHKdM/+ivzeu/jwepE2/DjAP2pxzTiqz
         9bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240923; x=1722845723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVjA+bIcDpbnmzrciVh7kfXXZ60SEX5d5fn8ZISA1a0=;
        b=SXJDQM9pEmUknXMcPYJXPdfrvoZujF7i3Z0dLOq4hz35xXKt7NZ/ywKUNxcrykbb29
         h8cgTzI2f9XLDMFR/MkywQmKiZ6X7bEGHbA8lzOgP00GIZlrg4PNwTrJ32Z8tgft4/Xv
         LvcA7mpa6j3dWO0y9eEJu2nr0cU1m/8HMeRX+IpcGPilG9wXVCJYxQFQa1wrad2iQShM
         cIy2UPeD+8zg6bdnb7VAgtdpJED2m0+MU71k/rmx2h2J1cldubX7CFXxDlo5h5GqZ/wS
         MoqRm4ORm8vK63Xq2A2PSzJQiSU4qT+dTDFaPRHq/8K1uvjzxDyBNJ18gX6jTZs1/SXz
         mGsg==
X-Forwarded-Encrypted: i=1; AJvYcCVeEaCfl0fPGMxM/gR46aS+9xaaPJ6PfT/3Ru4QktOlOaY+Gklv29MKfdm+CTM4hEPLbHpV66GjOmH4h7HAfAqSJZacZK1Q03Q3r3OV
X-Gm-Message-State: AOJu0YycrPk2rqsARFNp7hqKPzNP76zU9ywoC5IL4L6BrmZNiIXo4ynp
	o3hY1Z56f+y2Sj6qie9BF8Oqm4myUkySaUwZeAIBAvtlTrgwvVuVRmAVhpIFXZA=
X-Google-Smtp-Source: AGHT+IFF0GdXCJWlZ8ukklf/dMO/E41NY+i6ecCIGsXYbN9H3J6/AlJLOOvOiZJPQdEcApWEDd3TOg==
X-Received: by 2002:ac2:4577:0:b0:52c:db75:9640 with SMTP id 2adb3069b0e04-5309b2cc9edmr4382676e87.48.1722240923262;
        Mon, 29 Jul 2024 01:15:23 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9f60sm472861066b.223.2024.07.29.01.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:15:23 -0700 (PDT)
Date: Mon, 29 Jul 2024 10:15:22 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [PATCH RFC] mm: Avoid triggering oom-killer during memory
 hot-remove operations
Message-ID: <ZqdPmtDjwDUoKJA2@tiehlicka>
References: <20240726084456.1309928-1-lizhijian@fujitsu.com>
 <ZqNpwz5UW44WOdHr@tiehlicka>
 <fd6e84d5-9dba-47fb-a39e-1f7f0995fdf5@fujitsu.com>
 <2ab277af-06ed-41a9-a2b4-91dd1ffce733@fujitsu.com>
 <ZqczDQ_qAjOGmBk0@tiehlicka>
 <264840d7-d770-29a0-7c36-6ede9063d06f@fujitsu.com>
 <ZqdHch4VZG9UC2yM@tiehlicka>
 <f2b49b7f-7622-4322-a34f-cd4b1756b791@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b49b7f-7622-4322-a34f-cd4b1756b791@fujitsu.com>

On Mon 29-07-24 08:04:19, Zhijian Li (Fujitsu) wrote:
> On 29/07/2024 15:40, Michal Hocko wrote:
> > That means that rather than killing the
> > test program which continues consuming memory - and not much of it - it
> > keeps killing other tasks with a higher memory consumption.
> 
> This behavior is not my(administrator) expectation.

Well, this lack of proper NUMA aware oom killer behavior is there since
decades without many people complaining about that enough to push for a
better implementation. So while this is not great it seems not that many
people are suffering from that.

In general dealing with a complete memory node hotremove while there are
applications with strong numa policies is quite hard to do right and
there will always be a certain level of suffering.
 
> > This is really unfortunate but not something that should be handled by
> > special casing memory offlining but rather handling the mempolicy OOMs
> > better. There were some attempts in the past but never made it to a
> > mergable state. Maybe you want to pick up on that.
> 
> 
> Well, tell me the previous proposals(mail/url) please if you have the them in hand.
> I want to take a look.

https://lore.kernel.org/all/20220708082129.80115-1-ligang.bdlg@bytedance.com/

btw. lore.kernel.org has a great searching engine.

> >> [13853.758192] pagefault_out_of_memory: 4055 callbacks suppressed
> >> [13853.758243] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> > 
> > This shouldn't really happen and it indicates that some memory
> > allocation in the pagefault path has failed.
> 
> May I know if this will cause side effect to other processes.

This eill mean that the #PF handler has failed to allocate memory and
the VM_FAULT_OOM error has unwound all the way up to the exception
handler and that will restart the instruction that has caused the #PF.

In essence, as long as the process triggering this is not killed or the
allocation doesn't suceed it will be looping in the #PF path. This
normally doesn't happen because our allocators do not fail for small
allocation requests.
-- 
Michal Hocko
SUSE Labs

