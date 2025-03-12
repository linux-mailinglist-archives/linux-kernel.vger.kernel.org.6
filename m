Return-Path: <linux-kernel+bounces-558132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F94A5E20C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69295189FC53
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D856C24419B;
	Wed, 12 Mar 2025 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqvfYYhr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE11D5CCC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798306; cv=none; b=bR6gzqL/k+fGPlke+rfDVAxcQmkfCSoUAO1MBxDbN4LGUQ+uaFx2+NUUcqZahr5xHX3d+IM74HeyiXtADuHX6t0HJnYgjsp/Bh0hZ0b7kgmYNDzXjwKLh7Mis2QXwv+FazUI6BpI1PnPEb2CUt4EPScSBJm/s4HR3OoZ+r8+YRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798306; c=relaxed/simple;
	bh=/xk9BSbVzT8YdrZU+8qu2kEBkOWLWjLBT09+jVAfDSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hou3STYwajK2Uw1XwVpyOwejE/PS9PkkXNLJkQFVQ3/ZVaH7savLHqiVPc3szBNaCcDVTnMgwmcK52ULfeODG63VBAtrgf6lCqrhSJTjnnvmAIOyCxiRDMf94npa72/0T1vbZkH/45mkd6+AWBQ7Rags5wveY+rjl3pv65e628Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqvfYYhr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741798303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhC3dGei2rmob1KmMR9I6J8XiZcIS7aiLPCRejPFAkg=;
	b=KqvfYYhrrXaDGDEKtAJkERWJLTuQ9qPePMZLIoPVjhX/82GcXcyMUHZZha7o7/RPl5ZQgZ
	vxGMrJ2KuAQ/bwSoZt6ITEmf59+w8hey7DcpoQAANxN/L22LsB7sQqt845FrEv/ysfqQDA
	YsU+1sRo9HWBw8rfsFrkNE2g5D853xw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-Z_xmygbtOISzXr183CHgug-1; Wed, 12 Mar 2025 12:51:42 -0400
X-MC-Unique: Z_xmygbtOISzXr183CHgug-1
X-Mimecast-MFC-AGG-ID: Z_xmygbtOISzXr183CHgug_1741798301
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so5945e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741798299; x=1742403099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhC3dGei2rmob1KmMR9I6J8XiZcIS7aiLPCRejPFAkg=;
        b=i95/mMDu3oan8X8cG7lxVAxd4eGf/sITFJrHoKoyyXjOgpdvV3egGFPk2JsWGiUA2Y
         72JOnobM6jHtDjKaewR0ngP+zF/mIkvlokHHLiyWW0vKBAHAC20E85cCRQdWO0kyuWb8
         gfyF6q0nq0axbk+wjQ84+mmJCTkocZNE53d2HocW4XEg12K7CvE02Le+AgQUfKeUTEJX
         JS09BkZVFcB6Ly/S6Wsw18Vs0jSPnll0tMsG6gGKGIEaWMgaqumcgfh6AFc5h3WxH34z
         1/j/Gzy7D1WixarBslGIATLCzvgDMJhSQ3R8TQ7CWW/569GgoMvyP+SA59JcL66FQrkQ
         dqFw==
X-Forwarded-Encrypted: i=1; AJvYcCVA1cgUQvShVIxiPZKKUiSZiY+Q0z9Ims242bJ/3HVstuJgaaYnlkNOXNZBu81gWqh84jCoWWhKNnJA1BI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn2fnqAjQ5q/oND0xkg/UtYn/NwJ4YvlrF/Is9qAPo1GJuQmJn
	czT8KDoSmrDD9t5nlljoHdfiuXvOv1JGL1HwXyLSrvy4VhYX1OvP6BLrO0xgck51UunoeaCYZ2x
	0pfgQKvntOoh9codkB9FEV9oNlf+YmzTicF6x6a61wxhJDJOMVQ8SG0ShW56Z/oJaXIXm6A==
X-Gm-Gg: ASbGnctDmfksmW28sRKCAgnuz4hR7HPNm0BAPoBSJN8yjwSp2adsXVVlqO5VzwrsqKE
	rqrvgGQJBPP8k5QPcXy94kBFcOPSTjuQLtvn4nJJRjLH8ardZSnAFT6AbwOREANnDV+IZLyFPLZ
	SuAMMacnWl+PQS09MLfIjJ8NoAiv8N5fkQMxEyd6/N1Y3q8GsBSyxw7XATiTgBFifAKxF0OwMgq
	VOcxypFLjm9tXNM2LIVfCJHZ9f5rUPw2NlaIJpeRcQcU3sTMh3yR2nGv1+dMtxn0iUejF1SRqKA
	he6erTMDXt1Fu3YvokfGOhTTByOoAeoS4sJpKQic/BY=
X-Received: by 2002:a05:600c:4589:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-43d05ecc145mr65274735e9.10.1741798299632;
        Wed, 12 Mar 2025 09:51:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuP4Gn6dH73Db2O+BlcqpNQGP2AydhiF2o9YtbaI8drJWF4RsJmiH3wOi6KmOdX07GL/JZGg==
X-Received: by 2002:a05:600c:4589:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-43d05ecc145mr65274405e9.10.1741798299266;
        Wed, 12 Mar 2025 09:51:39 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a74d4bbsm26286775e9.13.2025.03.12.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 09:51:38 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:51:36 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
Message-ID: <Z9G7mMQ3xG15FmLy@jlelli-thinkpadt14gen4.remote.csb>
References: <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
 <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
 <be2c47b8-a5e4-4591-ac4d-3cbc92e2ce5d@redhat.com>
 <e6731145-5290-41f8-aafb-1d0f1bcc385a@arm.com>
 <7fb20de6-46a6-4e87-932e-dfc915fff3dc@redhat.com>
 <724e00ea-eb27-46f1-acc3-465c04ffc84d@arm.com>
 <Z9FdWZsiI9riBImL@jlelli-thinkpadt14gen4.remote.csb>
 <d38df868-bc65-4186-8ce4-12d8f37a16b5@redhat.com>
 <Z9GWAbxuddrTzCS9@jlelli-thinkpadt14gen4.remote.csb>
 <78bc0eda-7471-404d-a816-bd5f1a8d4b27@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78bc0eda-7471-404d-a816-bd5f1a8d4b27@arm.com>

On 12/03/25 17:29, Dietmar Eggemann wrote:
> On 12/03/2025 15:11, Juri Lelli wrote:
> > On 12/03/25 09:55, Waiman Long wrote:
> >> On 3/12/25 6:09 AM, Juri Lelli wrote:
> >>> On 12/03/25 10:53, Dietmar Eggemann wrote:
> >>>> On 11/03/2025 15:51, Waiman Long wrote:
> 
> [...]
> 
> >>> I unfortunately very much suspect !CPUSETS accounting is broken. But if
> >>> that is indeed the case, it has been broken for a while. :(
> >> Without CONFIG_CPUSETS, there will be one and only one global sched domain.
> >> Will this still be a problem?
> > 
> > Still need to double check. But I have a feeling we don't restore
> > accounting correctly (at all?!) without CPUSETS. Orthogonal to this
> > issue though, as if we don't, we didn't so far. :/
> 
> As expected:
> 
> Since dl_rebuild_rd_accounting() is empty with !CONFIG_CPUSETS, the same
> issue happens.

Right, suspicion confirmed. :)

But, as I was saying, I believe it has been broken for a while/forever.
Not only suspend/resume, the accounting itself.

Would you be OK if we address the !CPUSETS case with a separate later
series?

Thanks!
Juri


