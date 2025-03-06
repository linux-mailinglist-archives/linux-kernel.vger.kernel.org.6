Return-Path: <linux-kernel+bounces-549130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435C2A54DDC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F6D3A969E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13CF157A48;
	Thu,  6 Mar 2025 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xf51tgS1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B999370838
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271602; cv=none; b=jXRSumcS2DUvK+zpX5LLzG0NWI+z6WFFWtPsii9gZmk9mOi6jYbzKlExVlXlwYX5YOhvOE6x3xewalOZfD3UQiIj5zwoMaqiMni+z1sd9bKwVp6ZueE2XcNm4fyBM2+OR33zbDxESqKLpydDi9LY5rFZk4oLoQiCBVeyYK9SUcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271602; c=relaxed/simple;
	bh=GLf2kgX2CNw+ykh+Zo2+7ut7szuwhMoOK/e57Zaphck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Awfyue05hw2QBSHlCXInJZ5L0+1NV6XBXfUsFCH9WwNGoE+WtjrzALWlLccM9vGvYxrRgujhTYcjZyRQlVErQrb0YI8U63nXbkh4fa4TzTyohwmxo68+jO4UskQGcaVKLlm8TqKcouB9p2QMA8A5bHG0gNu4G/IbzYhWzLgcXgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xf51tgS1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741271597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=udn568GCxG2y6B25GDwsOWjvCqShxrtFVhlOD1urviw=;
	b=Xf51tgS1RTZjfkN0WFUsf9JnzH1rXkcnhKX+aDJSXDViS4O8qy14bllF3DBYH+hpORS9Gy
	kSQ+Xw4G0AYgBk8HM3IhrkCyZWAWBcZjkFVUCJdCkA0yOAjDY6onaifhSXfwvg9NNcvU21
	iwClj788fH7GkS41TZyLhAkYjRJ2Vts=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-rGRPUhmoNDKlPB_p2wZKgA-1; Thu, 06 Mar 2025 09:33:11 -0500
X-MC-Unique: rGRPUhmoNDKlPB_p2wZKgA-1
X-Mimecast-MFC-AGG-ID: rGRPUhmoNDKlPB_p2wZKgA_1741271590
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bd25bc0f0so3794755e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271590; x=1741876390;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udn568GCxG2y6B25GDwsOWjvCqShxrtFVhlOD1urviw=;
        b=d355wRdNzq8bcpnABhy67mXGCteu76daDTrwHvVE2Mh5Sj6/dJDEGx0t3LGz/FTgyr
         kZkKsKU8Dcm2Wahc+qwNAE1etj5Obb5+VMaK/1FPhPn9tNFmvZwc6+D+c6bvQrbBfJvo
         SDZzZPA+7Ku5Uq2HSyNh2+N59ROLY1RWFrj6KbKJ4Tm3nLwWWQLoQ5r3YEqJwdE7DiEG
         ON7Mvev+nWv47d9O7yRVb98Zw4R3uxQigzj8pt4bMZtusAJXgz44X7BTLVTu22x9r7R7
         5NUF0B1k+rlPZR7gIIFxceqWIpm1xs+3TmqMhoor8LJx5CkwTOAdxqoN9yZmrt0rjqfS
         GbIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMtNgMJm+8X5ctH+zOA2/bRm9NRcp+8W2ajqaVZgi2cwDOxZs623SOlVdkdhC53P0t/mybypFH3D+Tqu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQzZkdK/tQCxrrS1jd2nWGEtr0clGpsYFAQ7yKb/Hya5jI7FhO
	0SZMeZsPoIZkJ3AT+kzVup/nkonieLURZdf8KzGYV9g/Mh+0dg2imx+nS3/u+U5pspOZA2wMb/d
	b+iJMPdSrif2q5SbwrLbi6MAPPn5KCMs9/nZAOXB+7zc9mHNQGfoAM880756zhw==
X-Gm-Gg: ASbGnctAOovw7KWMj9Dqq8/26Uo5kBa4uQXFPqLRYbyhGj4OuHrrH92Qx6qhjJ1xkzw
	ARZ8Dix/nQwzbCoD40aeCQjtozEQ5ZTqiYQ5jEVEeD7wOPB5RhKVJT5K+3ti7WXspYKJgdnLB1+
	3nwDs4pRd0scdUde1ydO1qOipaiJK5kJN+xeVDfgKYoblbBHHkcctZB1UeLl7LN3wdWnbxUyEw7
	25H4XEeVAqsuaK6WV+YcVvnYrvHblEOST6py9/SqewRYBaDl9F7KQY5vvY7DbBPTI3i2ULIm/FM
	tcKdOiO4abXbsDKZ7T/QKwyMQRXf8aQL+jeqLgGcE0dJRvvuwIfuuKqIj+og1bO2KJ4EUd5fAKZ
	w
X-Received: by 2002:a05:600c:4617:b0:43b:d0b1:90c5 with SMTP id 5b1f17b1804b1-43bdb3ce3f8mr29451445e9.10.1741271589936;
        Thu, 06 Mar 2025 06:33:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN7Mg+b9fbnzG9j4LtbQ7HRPN+jd1S6Bq1GMpcn8ozmBBgsLnF4ElRVBdzwPbMZH+1rNv+vQ==
X-Received: by 2002:a05:600c:4617:b0:43b:d0b1:90c5 with SMTP id 5b1f17b1804b1-43bdb3ce3f8mr29450985e9.10.1741271589371;
        Thu, 06 Mar 2025 06:33:09 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd947544sm21206575e9.35.2025.03.06.06.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:33:08 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Steve Wahl <steve.wahl@hpe.com>, Steve Wahl <steve.wahl@hpe.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org, K Prateek Nayak
 <kprateek.nayak@amd.com>, Vishal Chourasia <vishalc@linux.ibm.com>, samir
 <samir@linux.ibm.com>
Cc: Naman Jain <namjain@linux.microsoft.com>, Saurabh Singh Sengar
 <ssengar@linux.microsoft.com>, srivatsa@csail.mit.edu, Michael Kelley
 <mhklinux@outlook.com>, Russ Anderson <rja@hpe.com>, Dimitri Sivanich
 <sivanich@hpe.com>
Subject: Re: [PATCH v4 0/2] Improving topology_span_sane
In-Reply-To: <20250304160844.75373-1-steve.wahl@hpe.com>
References: <20250304160844.75373-1-steve.wahl@hpe.com>
Date: Thu, 06 Mar 2025 15:33:06 +0100
Message-ID: <xhsmh34fqfcv1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 04/03/25 10:08, Steve Wahl wrote:
> toplogy_span_sane() has an O(N^2) algorithm that takes an inordinate
> amount of time on systems with a large number of cpus.
>
> The first patch in this series replaces the algorithm used with a O(N)
> method that should exactly duplicate the previous code's results.
>
> The second patch simplifies the first, taking a similar amount of time
> to run, but potentially has different results than previous code under
> situations believed to not truly exist, like a CPU not being included
> in its own span.
>

Had to hack up arch_topology.c some more to replicate the setup described
in

  ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")

but eventually go there, and it was correctly caught by topology_span_sane().

Thanks!

Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>


