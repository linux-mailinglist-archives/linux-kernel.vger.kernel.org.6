Return-Path: <linux-kernel+bounces-276635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B095949666
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5794D28C17D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC876F2E2;
	Tue,  6 Aug 2024 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awUJRX6u"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F85A0F5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963853; cv=none; b=RaP32O4YMQHGwwpNe8GQjNulHJroh5IQxaCmrBdKpEGLxcrcqlL+tYieDMWAT/9j+S8S8uuXOax3AD7scs1+EV4mGkZkhlz7RfP4jlkERAtipDlZFCoiGofdMxIJEllg9Nj1jZRBi1RrKJHvPyBjc/bqD8jU0+O7gRvsgtPRNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963853; c=relaxed/simple;
	bh=NQMLHLLE1Vo1QIF73SZPeTRX6ub8B8LKrAeNaOP6pDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr5vn6p9109TPGVJpaCWVc2kMi2jWke6qWqT2UtRnqSlFvY3M4pJUOsVvBhRsyyiEGRPqkuqHqqgqpQ8WBeuOI9WlyNZ3P2R+M/jNW5/njtqSjJt1vHhi/tM/P95bpqImzpv3/IAarEUea2LkhRUIyTHxs8/Ru7dC7dAcRzknv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awUJRX6u; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so674439b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722963851; x=1723568651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPFNkOXCoWcuRMnDIrlBvpKQJaUeyFAllA2zxKPFU84=;
        b=awUJRX6u2sbP51dSxXIS2eMaPdHaSw3cir/+HtJC/buasOVVwcU4h+dyT2oMSXE64k
         JtdgCGb+N2Zw98o+xz9t76xgdi65R+IpQXIU84iKGArKcaP0dJmWFyaal+X5looMmx5D
         +LA/XiWBsq8O4VclWDZETXlk4brXolcGretdoFdM/PGc98zoQZGkRkWrER7sAHupUFLI
         AT2PiBhaKWBKNJNceXVk1wb4l5nlR3XIbEKC3CCiJlRbOWGCUlLexJMVLTKZ0QtCPYDu
         ajIULMYIYBEximLfyjAzdbDrxfkVaDJ5c9yko9YR9MgsR0rqzgCKj9vS+UoFROygq7xO
         sYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722963851; x=1723568651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPFNkOXCoWcuRMnDIrlBvpKQJaUeyFAllA2zxKPFU84=;
        b=C1mrDv0xJ8T9AWLyp7fCFrFXw6AZWz2+w0MRjHksv5faZLDIXXidq1ZJ0vl7/ktOyv
         Lg3JpG1uui3zaG6Z5SlIlPoWAK9EBMng63CQ4at1kwUjXaB7Fu+L1F57YBUYweCiRO40
         WVw2YG3ffs8yKxtnBkrDZR92ceyxeKVv7PmBQ3BvX2h5cMWhejoQ+vvwB7aGNtud6UzI
         1lI7WA35bhTwZbMgLMb57MV+csaAaYzvkJPMNdAw3azd2hXCSgG5FrWCKwhcLm2AlnXE
         6ejahIuJhCZulkIVzc9G9xeZ8mxmokzrwq1xW0vokz6XSJ7Ali66XtkqK1AV1nOwO359
         472w==
X-Forwarded-Encrypted: i=1; AJvYcCXKVC4DUMiFZHJayHD+SKm/lqRifsNDHqCyR67tVRT4K9HTKdmgj8Pp57+fGgZZab2G0LwkwkzZrIb4x2YPwmCpqg+aXkeuIcV5S3FL
X-Gm-Message-State: AOJu0Yy6Al/GJuQHw10KaFPO5Y+5CLRDH0rgcS5aO6eQg381cV4ReVLH
	3ETHp2SyA67x3Cum5obZIpdxpVwFYK2LYEp5T6lIDC3npZ0ExzHKzuXF6A==
X-Google-Smtp-Source: AGHT+IGw6X/CVB1cVkIlBbg2/oONrEtRl1pwZX0TWQ0uj4MC7rWt8L2V7a3XIv5hCQ1pWx9KkLBAXw==
X-Received: by 2002:a05:6a00:9481:b0:70b:aa7:3232 with SMTP id d2e1a72fcca58-7106d046169mr16731986b3a.27.1722963850583;
        Tue, 06 Aug 2024 10:04:10 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec0611fsm7200298b3a.44.2024.08.06.10.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:04:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Aug 2024 07:04:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	mingo@redhat.com
Subject: Re: [PATCH 6/6] sched_ext: Make task_can_run_on_remote_rq() use
 common task_allowed_on_cpu()
Message-ID: <ZrJXiU5H11_qzbZl@slm.duckdns.org>
References: <20240804024047.100355-1-tj@kernel.org>
 <20240804024047.100355-7-tj@kernel.org>
 <20240806081259.GN37996@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806081259.GN37996@noisy.programming.kicks-ass.net>

On Tue, Aug 06, 2024 at 10:12:59AM +0200, Peter Zijlstra wrote:
> > +extern inline bool task_allowed_on_cpu(struct task_struct *p, int cpu)
> 
> This wants to be "static inline". no? I think we try and avoid "extern
> inline".

Oh yeah, definitely. Will fix it up.

Thanks.

-- 
tejun

