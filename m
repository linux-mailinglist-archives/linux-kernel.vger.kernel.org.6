Return-Path: <linux-kernel+bounces-407832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C0D9C7702
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2634FB31F88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3121313D2B2;
	Wed, 13 Nov 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGLOJ1NQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2B13AD33
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509935; cv=none; b=GDIzz/XQHL+t2p4KR9tC2MVcgI9+432P9ukxOh1oDG76vMrqnvJQ1UiUAE/s4RutUJ17J0TbE6OO8t/66tXZK2NBu6CTGtO5mhH6ID0eqCxzYCTUrYR60cXVGkzhYYPhc/DbbAcCi1hrqbK38GQB2Sda2PPMSy4Ywr2Ebm4O8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509935; c=relaxed/simple;
	bh=AppAQ7wltJ/yoE0Id1YlcSnmvkFhTnGrtfCF7tE/z+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRJHgImXRXj9P0thBfSVpx/wP+0/cl+gqaln4NNprrElN38CjQLdby9nrB4aPczRGyxLQ0BZ7LQUXNk6T+nhjgfv9G9Zfk4B7zwie9E3a7AeV584wMIWfn+wvhsqCry9k1Xqgkgjt7cq2bewLlc9ZHBJEpXvbzpjyQaphPYz/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGLOJ1NQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731509930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qkatl3uPxKN3f5OhVtGvUoCEjJCTENaafdUlHbDnvl8=;
	b=OGLOJ1NQ4LALsz3zQ172K+qo2EaMX+x+ZxO/UZt/QtZ0FmtW0OX8loruuGcbNw05nicZ7j
	XBIbSVZ8VzGYR63R7gwC6MJM4Vx9Hj7DveLb7gr9QvRhh4ZIlEy9d3scD+ByGdWr8mheI/
	pbj6OREHJfubqR9OLIyaK06rGSgzlv8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-XWatR2OjNdGak7beVhbwZg-1; Wed, 13 Nov 2024 09:58:45 -0500
X-MC-Unique: XWatR2OjNdGak7beVhbwZg-1
X-Mimecast-MFC-AGG-ID: XWatR2OjNdGak7beVhbwZg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d531a19a9so3898388f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731509920; x=1732114720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qkatl3uPxKN3f5OhVtGvUoCEjJCTENaafdUlHbDnvl8=;
        b=eLKcjz6TGMbVgd2sd165hSNUFAWg73Qur1n2Vi9mUzeQe1ReiHaNJaiAXc9h+Vlksw
         +1uxhW2iHUMV1w3ETZj6ZgxYCvnDEx9PZePHObIrzFXkzpX6cwUQBOM75ypBYbV3UgHH
         4MB8iP4EWoksnojZblrHpFyw53G+Z/pbe45KaRI9AW3broOCLN3kdOFwRWa0pdmmWrDQ
         Gto+nThHT7xCkkDko/uKRu4p4d6kW5selwu8nVKxoJlyChA7CYsdSL5zuuTkQHU6MDak
         QAbrkvmoJUDr1ljQHmZaeq+PMvTqJtT1MSrlzobiTC6UUBx/yKLC0unZ47J5SxTjO97V
         GYEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0g21G9oRHZMjUj7o6UMLe97dx7VeDcGxVh96sDWCVCv3Nv1rFYAbVrIvMGWZbCrSSA00TBxoSW1Yk2Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsBPnRwO83gQ0TsL658kQ+FivuzTXDq7HT2cteVIxrPA4lM1Sp
	NpWNdpNsGzJi9czI+vbj+qEfQSxg7AzSeLBiSz1qbuSzHa5AxF6DKwZSgbge2SsYcI5RVDAg2n8
	wbW1cawQoH6pbLfKb1H2jTBgGZxDxAqZSgIUjw/Ccac2ENdBcwDOFCQa7Qm123A==
X-Received: by 2002:a05:6000:186c:b0:37d:5129:f454 with SMTP id ffacd0b85a97d-3820df61020mr2619232f8f.15.1731509920510;
        Wed, 13 Nov 2024 06:58:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSdAOXbIQrKY4kjfQvG0fVihJT7Qe0ao00JJmqS399/ErbTtnTr9GRovWUnGjqJfmbUxq5Qg==
X-Received: by 2002:a05:6000:186c:b0:37d:5129:f454 with SMTP id ffacd0b85a97d-3820df61020mr2619199f8f.15.1731509920177;
        Wed, 13 Nov 2024 06:58:40 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970713sm18871309f8f.3.2024.11.13.06.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:58:39 -0800 (PST)
Date: Wed, 13 Nov 2024 14:58:37 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Phil Auld <pauld@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
Message-ID: <ZzS-ncIOnEgrOlte@jlelli-thinkpadt14gen4.remote.csb>
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-3-juri.lelli@redhat.com>
 <20241113134908.GB402105@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113134908.GB402105@pauld.westford.csb>

Hi Phil,

On 13/11/24 08:49, Phil Auld wrote:
> 
> Hi Juri,
> 
> On Wed, Nov 13, 2024 at 12:57:23PM +0000 Juri Lelli wrote:
> > For hotplug operations, DEADLINE needs to check that there is still enough
> > bandwidth left after removing the CPU that is going offline. We however
> > fail to do so currently.
> > 
> > Restore the correct behavior by restructuring dl_bw_manage() a bit, so
> > that overflow conditions (not enough bandwidth left) are properly
> > checked. Also account for dl_server bandwidth, i.e. discount such
> > bandwidht in the calculation since NORMAL tasks will be anyway moved
> 
> "bandwidth"  :)

Grrrr. :)

> 
> 
> > away from the CPU as a result of the hotplug operation.
> >
> 
> LGTM.
> 
> Reviewed-by: Phil Auld <pauld@redhat.com>

Thanks!
Juri


