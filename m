Return-Path: <linux-kernel+bounces-429543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FDD9E1D91
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BEE165F2E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0118B1EF0B0;
	Tue,  3 Dec 2024 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWTH7MBu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C223F1EF0A9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232595; cv=none; b=soI+xA/x4G94WzVh0jJZw4tYyoIaKtK5TyJ618/ulDrq7MuvyM0daDiJbpHvCg70ryBXmmKDvoAbzW/fySTEbzMUaN8DBmdMMYCajwfDEJ3Y3gFgedhkQKqfSamER5jJRhp8wqWgAhj2DrQ25glbcgXbyzQ5nMRK0UPDnMTFhpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232595; c=relaxed/simple;
	bh=n7Ct1wtWEdEx1EUVVxKWgSFrezyal9HC05HiJZkOymU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWr0fmPju1Lr6F34c+1BkIbmJtBHW6NnJ+YktuEDnT3AZGwpfMfBy7MpE/mEC6U3AmZAmtp67bSRgtfi5ctQiXg78jVsCuOwXt3F8QpO5y0LfUb6MJQ5b/2o74tOOJ/xZdWCXJU3ZpeE9AGrUMmTqvnO+uF+5bkZjtnj/W3798k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWTH7MBu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733232592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7Ct1wtWEdEx1EUVVxKWgSFrezyal9HC05HiJZkOymU=;
	b=SWTH7MBud0kKOpbBCAw1kQyqHJ8LDJheapxI3SrY1rxI8NWyIxIv8ALoIFGyOpjaDnFTcp
	nrulfLnvbTYb2u0Rn4tK5kfJCSvmR+Nj8MB2ib6gcB95J53c4kU4BNYKmMQ3Dy/+cFOrC0
	WDgrqQ3vUJ9cuW/srwoRM5AyerJdyp4=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-cSrcgpCqNAq3-Bu6KvhHpA-1; Tue, 03 Dec 2024 08:29:49 -0500
X-MC-Unique: cSrcgpCqNAq3-Bu6KvhHpA-1
X-Mimecast-MFC-AGG-ID: cSrcgpCqNAq3-Bu6KvhHpA
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-29690f78d57so3459119fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733232589; x=1733837389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7Ct1wtWEdEx1EUVVxKWgSFrezyal9HC05HiJZkOymU=;
        b=IvhMBbdaZKjzJ5FnntsKMu119RhqLUR/wjDTK35UseDGU9CokgDajLGwQRRjc7o5B3
         IB2RMRWlNSAkJ07Q87xAuG/JU8peeXUwsXSdwtGb4NRFpGSiuhHP1z//e9teijHIw+qa
         y1VwCHekRgBAhtsZC3QDpTAF25wfNzNqRG3B25ZLLea5a8j/awnytN7FTRXP666gatwA
         JmLIx36wGV9tUGAQKwVVjsIHyA/RUKCLK2HvwyIKLIVv8t+Bg2yCBvhrLqi6+RI0RiHK
         uTDOapyS0ak7oerkdfWB95IdEjuFIt1rnIn3OwW4sybpHGJsv9LZVnaNU/zI19NpCVKn
         9Ipg==
X-Forwarded-Encrypted: i=1; AJvYcCXpEPw79o2xUJ7wAMsOQhd+MCZjMlnNLEqhaaCbBuC4iMHH3T4+rMit7iGh+K8MX5ZdNm+ppymn9YuHKQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVjW5K3kFBorWWdS7DnWDF87Nd/Xu9yY6D+slDtY6jRwUsQuni
	ZLjUNf/FXp/9l4cLTpSBHcVmqWGfUmPjvm5ydgaMqvSzzF2KNJ90U04qWR3+fBEPYIMMVwpnz4l
	d3C/eyXpQVvv8lTBP5WY1uKdPc16vp6G9q5z9act2KLnHsj891vaYR6CznA2nGuNysOdRraOxu9
	lFoX+Wcjnq6GjL0UHE3z/1hATSorGf/a2rTfXu
X-Gm-Gg: ASbGnctOjkC4Y/90C2yoPmwo4fhC9aUuHePISwe/c50w75A1nOXfXZ3UulxeADuJxlk
	/hDOcgc1FN5JbUzleK5hDqetE0x7VPxWhRSpnQDpdhqaWSXHgaE1B6vdRVhGM8kMc3g==
X-Received: by 2002:a05:6870:3b85:b0:29e:684d:2739 with SMTP id 586e51a60fabf-29e888946f7mr2186263fac.32.1733232588877;
        Tue, 03 Dec 2024 05:29:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFExfH2VrDltV7oN8LmeRawcdQojOLEdyX09vyUx2aadwBxD8ckIt1qPwPw8S0zuZPWUmzatJonWZ74bxlmRJM=
X-Received: by 2002:a05:6870:3b85:b0:29e:684d:2739 with SMTP id
 586e51a60fabf-29e888946f7mr2186242fac.32.1733232588658; Tue, 03 Dec 2024
 05:29:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203095414.164750-2-costa.shul@redhat.com> <6scvm7d7pcwtgo3gqu6jxf6ht6qcr2rnmmdwnhpopkd44gayej@ussah6oaxssn>
In-Reply-To: <6scvm7d7pcwtgo3gqu6jxf6ht6qcr2rnmmdwnhpopkd44gayej@ussah6oaxssn>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 3 Dec 2024 15:29:12 +0200
Message-ID: <CADDUTFzfgrA3tjmkedxd+JWrK_rMLiuOZMH9p5-+5rmW1TcS3w@mail.gmail.com>
Subject: Re: [PATCH] cgroup/cpuset: Remove stale text
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Does
"Accessing a task's cpuset should be done in accordance with the
guidelines for accessing subsystem state in kernel/cgroup.c"
means `css_set_lock` defined in kernel/cgroup/cpuset.c (moved from
kernel/cgroup.c)

Are mentioned guidelines now in include/linux/cgroup-defs.h?

Thanks
Costa

On Tue, 3 Dec 2024 at 14:31, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello.
>
> On Tue, Dec 03, 2024 at 11:54:13AM GMT, Costa Shulyupin <costa.shul@redha=
t.com> wrote:
> > Remove stale text:
> > 'See "The task_lock() exception", at the end of this comment.'
> > and reformat.
>
> It seems you've read through the comments recently.
> Do you have more up your sleeve? (It could be lumped together.)
> Unless it was an accidental catch.
>
> Thanks,
> Michal


