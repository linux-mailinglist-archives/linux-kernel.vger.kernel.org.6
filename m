Return-Path: <linux-kernel+bounces-241089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B4A9276EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4EF1C223A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D38F1B11E8;
	Thu,  4 Jul 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U84Q1wPY"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA1A1B11E0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098690; cv=none; b=uqXBFndBX6fuwoXxY3SOJ6HiSCOwY50A389MF8qEZXj5N6npkpZ5bukjcaSmmMZiBIGDbNWFKQcbl9VhF/g1FqpPzmqsLMoZL/mt5IdYHW4FSCsBZbzThpAyUdViW6bGzYFznw3qBxzPtI9Kru1UGQWjU833HPW9JVoM3yAvPbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098690; c=relaxed/simple;
	bh=hVV4R9N6Il7G4bUXdtBB23tsGvc1rn3HEJyWwMuiSvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxA8n0kwr1zkUy6TvTq9Bsmjx9+TxERZkpFqAQBVUMI53RqWTCmFKwceH5AxJUGzPDXqyE3oba45mClMJZPhr7PF5e63uaFUlIvCI4LHthj9hzHyCd87mEYjGqhR1Esa5D5T4MertYjhsr0iMe3fNML5PaEd9zsFvuncQBWkQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U84Q1wPY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e8b27f493so706103e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720098686; x=1720703486; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vaOxsXGnBAOwUPhVA/or7J3Tl+VYPwPMYl6uVd6KrAA=;
        b=U84Q1wPYR2e9NPHSWRexONz30MANoJEz2BHxddS5EB0U/lKNi10cQS5CI8IQXa21wD
         0vkAAckLDAYpvNCm2v7KKGv2YDmjH2IbBu0nJjFY1yj3iyXH6DHex/mIxkPKDgjmgidt
         S5oqj2IPztSnus0Q8peBZf/HB1eye4IyDhX0s3jHEXQyWUgTZb0R07F9wqTrT09Nwn8i
         oYtgdW/qZp3Q2HMkduUi0vJhbLTAQl0jYvBYeI2/Uj79vPVKjOreY9d5zZANinFLEJaH
         DZdHMpfO9NWNBETcUysXiqg2VSOtF/sByC74uK4jQdefQq4Izn2G50Gn4BkmXSH5nvop
         ODZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720098686; x=1720703486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaOxsXGnBAOwUPhVA/or7J3Tl+VYPwPMYl6uVd6KrAA=;
        b=JK9+nltLqf9gfePitdKMKTKE3g8cpFWjc/uFDhfpAVXjsylUpPjhFqaGsb8RCcN/nx
         wBMW9x/DzNWYamfVyJJ5CKTy33vaNG1y/1/TUs9EoVLx8qk7uZNtNA6d/iqmIazI5qQV
         cXrCWJrI8ODeHoqkOEoYZgdmpR71mluwwP5w4rua/omwqLmf9up6n1Q8rgECjyFLe84s
         qAqT1lUHmj49ZjuZTQCZsEkD3XxYdyIr/M4QA0g3Xtsjhes2TOfegUgwMWdnsenir9Fy
         QU33IXA9s+BAsL6ctYdUFTVP/+p5lBw9u3Je7E5MpfTiaLnNeCGecM1oyLbvCai/ZU+t
         hm5A==
X-Gm-Message-State: AOJu0YzGSU3MRsljkEFml3BXcmh7iUvd5tGvZjRFsdKcorOUnxXyuVsa
	ks1Zl+FVQG8u3W8xjBTffJgFEvblykrxTiTHTwgCtqM8KYRxzfzBeCwGXkY/ePU=
X-Google-Smtp-Source: AGHT+IELT9NWH41NIAeEJ59A7LkQz6Vn9l3ELFMlVKWt1OmoXmfHWgzIXQiKWSRD4Pa+Ik/aMAR1eQ==
X-Received: by 2002:ac2:5e66:0:b0:52b:88c3:b2bc with SMTP id 2adb3069b0e04-52ea06b3c8bmr1131952e87.48.1720098686184;
        Thu, 04 Jul 2024 06:11:26 -0700 (PDT)
Received: from localhost (109-81-92-226.rct.o2.cz. [109.81.92.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58cb2b83380sm2359687a12.74.2024.07.04.06.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 06:11:25 -0700 (PDT)
Date: Thu, 4 Jul 2024 15:11:24 +0200
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 6/6] mm: Drain LRUs upon resume to userspace on
 nohz_full CPUs
Message-ID: <ZoaffMfFdEgs2N7o@tiehlicka>
References: <20240625135244.20227-1-frederic@kernel.org>
 <20240625135244.20227-7-frederic@kernel.org>
 <ZnrSEf1xuFxKxj1D@tiehlicka>
 <ZoVJhXcR26paUNhX@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZoVJhXcR26paUNhX@localhost.localdomain>

On Wed 03-07-24 14:52:21, Frederic Weisbecker wrote:
> Le Tue, Jun 25, 2024 at 04:20:01PM +0200, Michal Hocko a écrit :
> > On Tue 25-06-24 15:52:44, Frederic Weisbecker wrote:
> > > LRUs can be drained through several ways. One of them may add disturbances
> > > to isolated workloads while queuing a work at any time to any target,
> > > whether running in nohz_full mode or not.
> > > 
> > > Prevent from that on isolated tasks with draining LRUs upon resuming to
> > > userspace using the isolated task work framework.
> > > 
> > > It's worth noting that this is inherently racy against
> > > lru_add_drain_all() remotely queueing the per CPU drain work and
> > > therefore it prevents from the undesired disturbance only
> > > *most of the time*.
> > 
> > Can we simply not schedule flushing on remote CPUs and leave that to the
> > "return to the userspace" path?
> 
> Do you mean I should add a call on return to the userspace path or can
> I expect it to be drained at some point already?

I would make the particular per cpu cache to be drained on return to the
userspace.

> The other limitation with that task work thing is that if the task
> queueing the work actually goes to sleep and another task go on the CPU
> and does isolated work in userspace, the drain doesn't happen. Now whether
> that is a real problem or not, I have no idea.

Theoretically there is a problem because pages sitting on pcp LRU caches
cannot be migrated and some other operations will fail as well. But
practically speaking those pages should be mostly of interest to the
process allocating them most of the time. Page sharing between isolated
workloads sounds like a terrible idea to me. Maybe reality hits us in
this regards but we can deal with that when we learn about those
workloads.

So I wouldn't lose too much sleep over that. We are dealing with those
isolated workloads being broken by simple things like fork now because
that apparently adds pages on the pcp LRU cache and draining will happen
sooner or later (very often when the task is already running in the
userspace).

-- 
Michal Hocko
SUSE Labs

