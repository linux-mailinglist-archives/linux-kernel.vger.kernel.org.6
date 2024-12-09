Return-Path: <linux-kernel+bounces-437394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DFE9E92AC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FEA81621D8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FA021B90F;
	Mon,  9 Dec 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2IE4kwr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79155213E93
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733744672; cv=none; b=H5IeDY/ofqfJuzMfQJqsC9Od4W8GYZKZNiJRNh8wV66KyYY+W2nshNJgB0Xh9b6tB5dJgTsnqQKpNmy5IppefYcYOtKLauq6MODnLVLk/OCHRlQHsJuG0nZEj4/U5bIEy3Yx999wj/RwRCZCVMLS5r8OfEhaxJ1tcDW4tRtWtBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733744672; c=relaxed/simple;
	bh=hq1sueCzqHZNHSbggzIve9g4szap3SyOsz76Fjh+ZmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOlbllhFtI4RFJpQKcuYGhqlSfRnKUPpDBsc6GVR9KA4P2oSqznTzVPm4WuqASxKOXKSJX6+FdigvtJ3Qwd0XCLL3dhy/98Ku6gYaN99pG2rRKUZB9e2i3Ya82A27IqrlQKKAn1Tr3W6rYhIMwSVXT7Nj23trI8bzD2zimJmS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2IE4kwr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733744668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D0vf5KmVndTZJOw5WazCUC6iSihWtoQfdxVi1xAN4fU=;
	b=V2IE4kwriodBJ/i0oMRoFkEZOlp7Dio88DqtYjD6HiJqnUdDORfzk2+D9JtHFTCHJYrSw6
	OwKU73yMphhuaCsGlDcZWgpK0cV45AV+ZFN7UHvDLonNpbnF5dKbQHThXsKnvMnycFvFJp
	gUhauEN95iSe22EKifvRzYBI2l1ELpQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-qtVj3slzNxmBUU2oZvRdiA-1; Mon, 09 Dec 2024 06:44:27 -0500
X-MC-Unique: qtVj3slzNxmBUU2oZvRdiA-1
X-Mimecast-MFC-AGG-ID: qtVj3slzNxmBUU2oZvRdiA
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8858be197so78065736d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733744666; x=1734349466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0vf5KmVndTZJOw5WazCUC6iSihWtoQfdxVi1xAN4fU=;
        b=fOgVWtmTbIHAfEhXRO9hRk0Y70FbvHwjo7sESoXTZdKdgXXFqH6+8Ajhp7QB7h0NjL
         pqSPSYFM5IUoU6Er4XPsNaikOE3xpS5NfcOV8UpSS6vLc7mabBO8P4Fr4xygzu2wFeEE
         +nYStFlzBms8Kqdtvl4/ORU/XjPdEJETAVB4aXcgPljrHx6MqWiRxx637XypLWyTZIX6
         dKVGyVQJSYKEnxgF2uLtrf5WAwWKfUxdmdkq6Sx3NFEd6pZB90bK/Sua57jNpu/ZRYJH
         4j5EIQ58h/EaOIfos6RzIS65OJUCsi9JyU4n2XmhSy1wBJ0YbrnFCmvZ/RZF4gRWcYYK
         q8TQ==
X-Gm-Message-State: AOJu0YwH+O4TXJxnItD/Rry+FXJGoUICZKx5AvKHBv4lRN0N2bathlzZ
	Q/1+wfbYzcqhymGgHiFGM+iNqOiqC7bHbBD6g2IqciMHTJ6ASh3CvQaMFuR7hl0BX+l7+D4A9TP
	KdI2Nfu0U36sIzXti+hYBqTB2m9FQZKfLAASalf3C/bRdbEvIuMfpppj8b2O9Vw==
X-Gm-Gg: ASbGnctfzrCM42NAmQQRu4agVjhBi1JFj/Q2fZQn50+kNGF1RyaZo448wOeplTH9pGI
	42M70Ik6jldsbxwy1yCIUM8WTb8PPZYYlu1dopWf5Ys6CovS45qTWWrIdgzlCSq5iuXwUAcsyRC
	myAEm2TlkwHaK5M+zc46gjgzHcDVveQAWnT1gAsMjkr83v50O5rdoRo941+QTozz4sxLu68gOgz
	pLkAZCMEMYvq+d7U9nUw6ha3TxIXeKTxnLYk0GZ1cHtPao/5VUiB1q1MDPaJ4aTtnUChtlHXgnq
	EAo+cbI2L7pHEYnYVyhW/jmwHBdh5NpOgQ==
X-Received: by 2002:ad4:5be5:0:b0:6d8:9dad:e167 with SMTP id 6a1803df08f44-6d91e33227cmr2124246d6.15.1733744666590;
        Mon, 09 Dec 2024 03:44:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZSfgWecnDf5VgQgePvtwl2rXZFyY5xP534j8FTsW8r1698u295rs1vz3Npq4Ul3zFXUSxwA==
X-Received: by 2002:ad4:5be5:0:b0:6d8:9dad:e167 with SMTP id 6a1803df08f44-6d91e33227cmr2123986d6.15.1733744666315;
        Mon, 09 Dec 2024 03:44:26 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-2-102-14-117.as13285.net. [2.102.14.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da696aa2sm48062936d6.42.2024.12.09.03.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:44:25 -0800 (PST)
Date: Mon, 9 Dec 2024 11:44:20 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Wanpeng Li <wanpeng.li@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Todd Kjos <tkjos@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2] sched: deadline: Cleanup goto label in
 pick_earliest_pushable_dl_task
Message-ID: <Z1bYFEJF5lezddFe@jlelli-thinkpadt14gen4.remote.csb>
References: <20241205211632.1181715-1-jstultz@google.com>
 <20241206000009.1226085-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206000009.1226085-1-jstultz@google.com>

Hi John,

On 05/12/24 15:59, John Stultz wrote:
> Commit 8b5e770ed7c0 ("sched/deadline: Optimize pull_dl_task()")
> added a goto label seems would be better written as a while
> loop.
> 
> So replace the goto with a while loop, to make it easier to read.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Wanpeng Li <wanpeng.li@linux.intel.com>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: kernel-team@android.com
> Reported-by: Todd Kjos <tkjos@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri


