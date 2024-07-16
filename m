Return-Path: <linux-kernel+bounces-253792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A79B7932708
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D53B23DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E128519AD60;
	Tue, 16 Jul 2024 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IurXiT/7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783419AD5C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134870; cv=none; b=h1/f1bpzGIqCMAo84b5LSchNky9mB0boqcdfetPM+qsCmDJjV8Jz9gCq1644mtp4jmVwOBgqc4GW22zdi4sL6ktAFyUI4SZBrvCPZ94w69JvKnVQJMRmTMsphuFODlF1q9scTmXI3s6nGILZP6zwHduVxjcI2oplVOMLaTF38IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134870; c=relaxed/simple;
	bh=FJJgJvzPopCwqYH3fUo0VaN7fvAfkGUKIvw4PORdsOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uKNg7tF2o89omt/y0d6AH3zw9a8hxLqSLhOUIlX5JERVWPujkH9JGvxuKHtdewT1UPt9BOeuUMTO87BAp4+4YasyAx/UCK9lmVFgqip/v9QaDMsDUGWzLQNhjfrcqxa74YOhlnoL9wtgx2dRaPd9oUOeUS3RX+xlUgi9RhAxii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IurXiT/7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721134867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJJgJvzPopCwqYH3fUo0VaN7fvAfkGUKIvw4PORdsOI=;
	b=IurXiT/7zaQDXjlVsfxOjgmUafPmax284QFhkMIUDw5G4CkFvadaVf/yimDP1UcnFYNBfU
	Tos3q3WP7nWwgMY/c3261Jq6I230J5FtobatpmJfWiHOZN4/B+iOmPTW8bft5QV0ta1M7E
	zwF/NZDEG+jqmULAZ4jH2jHEt0e3iKQ=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563--OpKin3TMlWcBY0j6sKyLg-1; Tue, 16 Jul 2024 09:01:05 -0400
X-MC-Unique: -OpKin3TMlWcBY0j6sKyLg-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-2606d76b5cbso3793165fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721134864; x=1721739664;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJJgJvzPopCwqYH3fUo0VaN7fvAfkGUKIvw4PORdsOI=;
        b=gcbPytFIOdWZpamnJ3mnSGfohfTSNySGLi73siWbGY6nFPf1blClVs9ELWYvrljXOv
         7x5u7nJ6MO+SWlBHdMYRSyKLK+iUweA9Ujd101wZkewVf4kPNb8ZoHKwh7IYPXnyWEPA
         IkTJzh8elvUa92xpfTKviBifr+f+32e+wxPfxJgtwCRd5Ia6PmnNxjyLIr9kt24nhpgk
         KYVQWbVj3z82dQelk2NgakfFnmD4KKfrRvYN938aX9garCOxw8ht56OTXecXuIRsQIRQ
         wX5aiw+n8QAOOlKnG074VeNuJNcnU3j2OmbEjsEj0JrNsB+t3caB+By0Qn6Urcfl6Sgw
         Df7w==
X-Forwarded-Encrypted: i=1; AJvYcCWkapxSEDsGkmXjWkvQucm/x7EQsFoKxEJGBZ1r0Vovb+nciXjE9XaPyfqd9gMqdsTri/UmoYUIjmY5vv4qm9C2HbbP83VvxaN8uI3S
X-Gm-Message-State: AOJu0YwBr1xDCx2YlMcbISPwk6zQc9E6yAdkesX2oMObximvj13MrLJw
	oiSEnouiRH3NjNbfBNBuPoC11/PNa6Nh9qBWV4bRP8uVS/O28b5hQAtF1uTa7bKTBfz0R20aKib
	q7H34axbmS/VNnCwylx1c5kl03gThSwGsTmq/RdJOunmbqxAIImbMVoicfZYPBA==
X-Received: by 2002:a05:6870:3:b0:25e:97a:cd69 with SMTP id 586e51a60fabf-260bdfff106mr959182fac.55.1721134864427;
        Tue, 16 Jul 2024 06:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1XlSw+cH+c/9VB6YxgAZSGUUI8XcL+RAapyvyixEyDXX7KMBsAzuc78ccU3t1JVRFpQsqUw==
X-Received: by 2002:a05:6870:3:b0:25e:97a:cd69 with SMTP id 586e51a60fabf-260bdfff106mr959166fac.55.1721134863999;
        Tue, 16 Jul 2024 06:01:03 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bbfadbsm290790885a.35.2024.07.16.06.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:01:03 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 3/6] sched: Use task_work_queued() on cid_work
In-Reply-To: <20240625135244.20227-4-frederic@kernel.org>
References: <20240625135244.20227-1-frederic@kernel.org>
 <20240625135244.20227-4-frederic@kernel.org>
Date: Tue, 16 Jul 2024 15:00:59 +0200
Message-ID: <xhsmh8qy11ofo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 25/06/24 15:52, Frederic Weisbecker wrote:
> Remove the ad-hoc implementation of task_work_queued()
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


