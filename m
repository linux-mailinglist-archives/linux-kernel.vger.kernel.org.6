Return-Path: <linux-kernel+bounces-538931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ABBA49EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B663BBCD5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543252777F7;
	Fri, 28 Feb 2025 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCs8xwBp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A32777EE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760381; cv=none; b=tXF2qwFc26jr5tFtJRfAi8Cun5DlFCsKoG3WHcx0zPNl971peWMrypytqUkA/WKfIUZVGRRnpFoZ5uDAzhawkGMUzLr9V5ZClwIKJoCaYOKZXtRHNfqTp/Eo5ei63ZAGX7Bo+QQhsjfcY4Jke+mbsN+YZDCs17iWrRNhZFexkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760381; c=relaxed/simple;
	bh=4wATX4l1H2BWElvjJTVQv1vq2NmU9FEovisBtSVis5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SU/RC6bbF9DEHRTgwvLn8nHP+nePrYdNCy20ET9w9GIiOk7f4oZS5aJCXp2KPtsMmnF26w9jjPDC2QWUG1eq48yud92TRloezZwbWv1PkMiuux6xwNqFt/BU/VVG+1g3j5NlTM9xylfOo/SRRayns/7HF6HXKqfuljal68zpmfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCs8xwBp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740760377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OCJcrPzr3A/AHRXCrU9C3FBfy4miRDHusgGC2Z9SIY8=;
	b=HCs8xwBpUQn0Ze/RdYCmk3XEsYo1MeNHyNyzr1QMP5QZArsXj/KtKNonlpujrwFWdLStVJ
	nheNheIcrt2frU2kzqCYfNHXOumYTvgwa43ZJYv4kLtA16unzVwvh7zzSq/kH7QqgjJW04
	WfzhMxUa4oTyYzurmKYuDwOc9nllZ9g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-rcT2g0uhPG6MzFWQWeHxNQ-1; Fri, 28 Feb 2025 11:32:51 -0500
X-MC-Unique: rcT2g0uhPG6MzFWQWeHxNQ-1
X-Mimecast-MFC-AGG-ID: rcT2g0uhPG6MzFWQWeHxNQ_1740760371
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8aece7e67so2691586d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760371; x=1741365171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCJcrPzr3A/AHRXCrU9C3FBfy4miRDHusgGC2Z9SIY8=;
        b=iktzIk2dBLBr5vwS4QjN2cfKwYzXfbaUzW8ZTEqm1x+1m4LSxZjitrDtKaDyReWRv2
         qf/tZOu6qwl8KQkaq4mbsYD6C6gFlvLRVwuHR+df2IrL7+RZh1etof/KtFnhaDq/Qg05
         uOjR442xtswU+oyLN6jhBmbaALClEMXFxudwrdUOfeSSlIRn0eswD/HL50Wj/Nvl47f9
         P0/qS7vesA6CTqmQ31JHu9yDt/1TLLEedtUOoYIz0yv0FOwdzT8ZFZUdMTg8yWeWdwll
         PsYpmE8ZvgoML1tOoLXBU92YptMLO5qtR+knHhMkaVBjDW0KrkKELg5qEcRQhuY8mEQK
         KvaA==
X-Forwarded-Encrypted: i=1; AJvYcCXbYJ1wmq8k/s207xjpWOzeDgC226Do+6q5jA9gdpaKyoPkxXP1rv0z6rMJxZ+G3jt29kuDMdx0mzJPI5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYa0IMO38advY1i0M5kKyNxeH+gnbNx3T3J/H3cLWubQbeTKAX
	b1LzW4X0hjrO1pkQ8HXoorhd0O3QdLZm/ZqM6vWYw38hRwEzoR8JNGB3tK2TynpvP6n1OmktMpe
	ne8a4AOGdRpnRaqbOIsgA700R0kwC3cEQPWM3bdBq1+aj+qu3O0BoF9impsVTXQ==
X-Gm-Gg: ASbGncst7AnALaPdXGShC33ULYMBGoRVOWyeTpghagfiYEiRp6Ya045/NrEQg4hFtsM
	PG3ktUfGpxCmONc6dhOA0++RLIWFRnzTiV5puYagviJpco9fy8e++Ol17hnS8q/g/nQaNTRpJ39
	nZ9cirx/EymSt2kN2RgWCbqcKvxe8mqm2MMlGqm7NxtEnNvFYMS9y2OnFvWhXZDUtgiNvjuE8ME
	3+qQp+OODiWancje2jA65hznQaMbfjeD87INMQq56BdfbGcvexrFit4ffu3dSNXx1J6vhnin1JY
	1bsMmrQ=
X-Received: by 2002:a05:6214:da8:b0:6e6:6aa5:2326 with SMTP id 6a1803df08f44-6e8a0d39aadmr57997846d6.24.1740760371144;
        Fri, 28 Feb 2025 08:32:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMmv2Ukls+BvKUlcCeBjyVq35bje9dDgoPOVErQ4sfeUMDi+boD9UPwd1+kNXyA4VVkA30rg==
X-Received: by 2002:a05:6214:da8:b0:6e6:6aa5:2326 with SMTP id 6a1803df08f44-6e8a0d39aadmr57997616d6.24.1740760370840;
        Fri, 28 Feb 2025 08:32:50 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897653894sm23926016d6.44.2025.02.28.08.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:32:50 -0800 (PST)
Date: Fri, 28 Feb 2025 11:32:47 -0500
From: Peter Xu <peterx@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Olivier Dion <odion@efficios.com>, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
Message-ID: <Z8HlL4FopVjeveaJ@x1.local>
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <cc1dec8c-8323-4c67-913f-5d8fb55ce715@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc1dec8c-8323-4c67-913f-5d8fb55ce715@efficios.com>

On Fri, Feb 28, 2025 at 09:59:00AM -0500, Mathieu Desnoyers wrote:
> For the VM use-case, I wonder if we could just add a userfaultfd
> "COW" event that would notify userspace when a COW happens ?

I don't know what's the best for KSM and how well this will work, but we
have such event for years..  See UFFDIO_REGISTER_MODE_WP:

https://man7.org/linux/man-pages/man2/userfaultfd.2.html

> 
> This would allow userspace to replace ksmd by tracking the age of
> those anonymous pages, and issue madvise MADV_MERGE on them to
> write-protect+merge them when it is deemed useful.
> 
> With both a new userfaultfd COW event and madvise MADV_MERGE,
> is there anything else that is fundamentally missing to move
> all the scanning complexity of KSM to userspace for the VM
> deduplication use-case ?

Thanks,

-- 
Peter Xu


