Return-Path: <linux-kernel+bounces-265414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B83293F0C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174EB288089
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA04013DBBF;
	Mon, 29 Jul 2024 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YHLRz/FZ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED74B7F47F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244576; cv=none; b=EP4krJGEfUpcjIX8lvjJnyi18w5cGncY4RHV3JC8+Z9GBwEBIYZdhMoXKROycd1obxP2fO1dvNghC9Pu0cbtGDyDkDXbHVIKCuIcOiXQ63uvldyzK8y+CmIAZ8Wvv0Ihz7BqNEXWVvN4NNPr6cPLt2Yaldk3KUhSDwVdXYlhZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244576; c=relaxed/simple;
	bh=gbutE41D4l1tBCm8vtQ7p4LBr9tDpADqql74TXHZ5nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXMZKX8h1ERdTirXP4qxDNBBl+ScLFaSviQXy9oyGYYV64XUJqsNVXDW/8sxXjtBLQYXxu0vGmfRHZyBmlxkgMtoMRUWHOmha5icg2y/+IsibuhIjr6RiFUFQGQz4peSqtTvUFjB4AUTVnDUBdF/BDqS/Mc+/JPoCtC4hNZm+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YHLRz/FZ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so9101474a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722244572; x=1722849372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYc1ZmJx2XVqtcsHWUqPHgPqOHsYUXN3rnFWYgqlyJE=;
        b=YHLRz/FZdjfdrTmcEcS+5+JHfzDSJjUUPeoPges/uXa3KqXhyPu1goiOtaF9viTsQM
         IKTwG6lESycYHxGjlGkTwsw3GDrcHF4RlKbdHJxOUp5FG5yiIUsaAf61VxFbkHQubn3Y
         3m+mhAYSU9NibPZX1Kg5xqiX3Prq9c3upH9acI+VQBeY7Cvv4FtSdnAT4N8uiPNVQ5wW
         OP9SvgAMA7zPCwnP3OwLB4B/eqxwyXGNgqV8rkkzWdzK9IlsA5uC0gJs0KvWuajstVIu
         jPRx6wDqHsfWMIsf9aye6ZZujnAKF1mCR1ZaNrSDftj5m/ixccoEyZhcv76I1S860sLJ
         /Lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722244572; x=1722849372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYc1ZmJx2XVqtcsHWUqPHgPqOHsYUXN3rnFWYgqlyJE=;
        b=ifXNJ00NRlrDTdMkBVfm8KpGrTXCGZ1tOFGoKqYOlTCXT6CDtNss2KMj3ifQ9nGbu8
         PZ8CO+guZbwPtkABY9Shmw+5m+1ab44PttI417HDlC8ZGTES652B6KQoCFDTGjGa+2B0
         zqxnuZ0cFcvz+IpauEFaScDCyAYUa9u7GvhJIeNvm+/HUjahaoD5IrtqHfmAyccoqSL1
         Yab0gz+hkiouh0+rJtcnH4SYXWJlpu4HtshIYONgK9ZliKpzU2eTSwqw+q7Cw7ev0vBh
         M80DsqzfXlVdECz/RJOwkXNsOBSk8u3eUAU9BgQ6Ox6pWDVHUtkgUwn8SnwU4BHe80lE
         09QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmDLnLe90Dt2iC2hFUxi6NUXgHk5MkveOyQdu45F4NtFKcbv8WjW2GBRaoxT9Kx+vLCljCfProj17YIjxIzgPYfHfHDXbKhV6tj4Vh
X-Gm-Message-State: AOJu0Yw1x7X3qXZ4o2+NTFr3ihoBsLCKOboICy7wYAvw54o4hPW1jn9i
	/MS5YpGblBWzI2GcnoHw5lqoHc7EX4SkYV3WsswdTIU7wTOs6hzM8A1kPACtklU=
X-Google-Smtp-Source: AGHT+IHfPz/S4gRwLZOUpjeY/bmDb/vX8NBuPNNZeC5crnI63zQ6Uu6zXFZa9IsC6LicBp9V4HxVgQ==
X-Received: by 2002:a17:906:bc11:b0:a72:7ede:4d12 with SMTP id a640c23a62f3a-a7d3f81dc4dmr681570166b.5.1722244572272;
        Mon, 29 Jul 2024 02:16:12 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab233aasm481728766b.8.2024.07.29.02.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:16:12 -0700 (PDT)
Date: Mon, 29 Jul 2024 11:16:11 +0200
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
Message-ID: <Zqdd25XhcEDPEQIS@tiehlicka>
References: <20240726084456.1309928-1-lizhijian@fujitsu.com>
 <ZqNpwz5UW44WOdHr@tiehlicka>
 <fd6e84d5-9dba-47fb-a39e-1f7f0995fdf5@fujitsu.com>
 <2ab277af-06ed-41a9-a2b4-91dd1ffce733@fujitsu.com>
 <ZqczDQ_qAjOGmBk0@tiehlicka>
 <264840d7-d770-29a0-7c36-6ede9063d06f@fujitsu.com>
 <ZqdHch4VZG9UC2yM@tiehlicka>
 <f2b49b7f-7622-4322-a34f-cd4b1756b791@fujitsu.com>
 <ZqdPmtDjwDUoKJA2@tiehlicka>
 <280af822-577f-468b-953f-b70190551b6f@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <280af822-577f-468b-953f-b70190551b6f@fujitsu.com>

On Mon 29-07-24 08:53:11, Zhijian Li (Fujitsu) wrote:
[...]
> >>>> [13853.758192] pagefault_out_of_memory: 4055 callbacks suppressed
> >>>> [13853.758243] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> >>>
> >>> This shouldn't really happen and it indicates that some memory
> >>> allocation in the pagefault path has failed.
> >>
> >> May I know if this will cause side effect to other processes.
> > 
> > This eill mean that the #PF handler has failed to allocate memory and
> > the VM_FAULT_OOM error has unwound all the way up to the exception
> > handler and that will restart the instruction that has caused the #PF.
> > > In essence, as long as the process triggering this is not killed or the
> > allocation doesn't suceed it will be looping in the #PF path. This
> > normally doesn't happen because our allocators do not fail for small
> > allocation requests.
> 
> Thanks again for your detailed explanation.
> 
> I think this is acceptable for the process bound to the being removed node, isn't it?

It shouldn't be happening really. This is a sign that something doesn't
behave properly. E.g. some of the #PF returning VM_FAULT_OOM without
calling into the allocator.

-- 
Michal Hocko
SUSE Labs

