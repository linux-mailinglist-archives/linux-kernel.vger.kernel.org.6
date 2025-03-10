Return-Path: <linux-kernel+bounces-553879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E962A59010
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49859165F77
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B24722655F;
	Mon, 10 Mar 2025 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcVQeaY5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E3226556
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599859; cv=none; b=CK/luTeLuacpAAW7Ke0GX22qW6NXK3NG5YcO5MNBcfreGDwOA9TnpBZzjB89Mai2bEwNOyIzVu7V0QpIFpgTjznxghpzZRrH7nQ+rW6zExDQj/TAR+ivEonvt1WaVn7eQQal0ch+1EfM4cL0QyBQFMY6zbeyeNscq68n/3wnddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599859; c=relaxed/simple;
	bh=ow0vSqKBH8xstu1wBVYGDDOLkaAxIDlC21i68FzicaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEj0ExvcDaa+6X7Wxxez/XlCePYesWSSy+vmIyYoVBI35UVOAlEdMKcBQ9CQP7BmVQmA6qqyAMFk/rzAdX+VChIAJ+kAGEJYO2TIQiD4wU4injcAfOuTv+YCfYrjI6F43pg+v4GEru2FdWgdRc4kypYYuqN3N0k3LPgeNbdSGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IcVQeaY5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ow0vSqKBH8xstu1wBVYGDDOLkaAxIDlC21i68FzicaY=;
	b=IcVQeaY5vs7uhUmnYLAQvWkmVjhTCR3kOkqkKz8HL7pRHECbDhCIV650gUlaAnVdDX3FcJ
	OjdHb7YMsJbDzqN8vRfdj6XPsezNYQznLwLB/WPYgRAd6Z6/DZxdG06ErcDzZyguat5F3a
	kcGOz0BqRvukgGK+9cpJ7xKEWrH2r+0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-EJTIJD94MIST4H9MdDEXkA-1; Mon, 10 Mar 2025 05:44:14 -0400
X-MC-Unique: EJTIJD94MIST4H9MdDEXkA-1
X-Mimecast-MFC-AGG-ID: EJTIJD94MIST4H9MdDEXkA_1741599853
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bdfb04bffso25902265e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599852; x=1742204652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow0vSqKBH8xstu1wBVYGDDOLkaAxIDlC21i68FzicaY=;
        b=fDjMjRL04mXG5Cc6bPpQigMF1v5T6P90+S0CMAIJnuC5TaG1MNER5dfN3ZVhIMBau4
         2QTN9vWlRJZ+aB+4eCgMEoJM6lEN2720wWMLj6ngmaQX9QcJu4ceBxZz84tHhvbyuIxm
         xw278012gIRIIHiaEdFbFbENY1JcYYnAYRlzHt/v1t0UrzCUB8HzvFk86fM75X6VytMS
         UDivEeeFUZyzrhVtiZkK95Pm/wtMCWv0FLYMnw4oB12W+33AUWtLZ4Ywzuv3eSJvEAuV
         pfadom/qeR0BE2poDsZq6D0XOMhRgdTJOz0ltwSV+HGYQBFqv8o3zSIK+gnoUd9jLq84
         qp7w==
X-Gm-Message-State: AOJu0YyFgIcxgWbnSrJb/89PxxTsJo+fd4nFvPRipPabCQZDHwFKaO0r
	aLMVOSXKS3JebWa+NaC7TtehHCbsMTpO8SUlaO/Vyq0f+XK8nYNqnzoYOtxAPaDIp2ALwTm9066
	8VbVxHTKrJWRa036Q0o+hYEiWRYp/9O3THTI6m6Nkj5xDfA6VpfOqB4YKskZAzNaC3OJKJ073CA
	dh9bSqAVkJJ+4pwuTB0wxWy2b2E6eDBou2w1rT3UG1iU42brSnyhE=
X-Gm-Gg: ASbGncs8BNTm8CB8ApJAqDI6GehV5g8uXmT/vXGp7Vqz2kEQefpj8N3KPhG2PoQ+LtF
	ctAx+FjfGJTWqGgHnfHVvJR99q3OYGGeAjuVgA5ImcZsuXQ4q0Gbeihvr4hHpzcjaoFP7VqBrnX
	A+aaaQOPbKcdV2EvXtUNzwdxn1yuvu5QF6sc9eFvT1S/7yTA2ysctrm8buNKF/L973LHVIxfs9F
	e59WDNXumXRI8XHsIxFzl9WNCEvAhvSEdqpf8Hrs7Q9UvHJux/44+5PXutHIRcSxIMkGjIuKZ3z
	obW8jYLwIR3vqMPsZ2t4PespzRrri7/MuQbsYlRcD7M=
X-Received: by 2002:a05:600c:5248:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-43ced612d1amr36757375e9.17.1741599852204;
        Mon, 10 Mar 2025 02:44:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG77fEdHDZRZKrDxEEmFxw1lEnfG31UV0hCRnof1QV2KuaEAH7NTEsz+9UqqwywiQuSyuEvGA==
X-Received: by 2002:a05:600c:5248:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-43ced612d1amr36756885e9.17.1741599851658;
        Mon, 10 Mar 2025 02:44:11 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfd5082ccsm9538975e9.32.2025.03.10.02.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:44:10 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:44:07 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 0/8] Fix SCHED_DEADLINE bandwidth accounting during
 suspend
Message-ID: <Z860Z_aPTWh_-juW@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310092050.23052-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310092050.23052-1-juri.lelli@redhat.com>

Hi,

git-send-email acting weird, please disregard. I am going to resend.

Thanks,
Juri


