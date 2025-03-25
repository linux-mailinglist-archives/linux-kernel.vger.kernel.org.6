Return-Path: <linux-kernel+bounces-575791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788EDA70746
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9775D3BF16E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489F225DD0C;
	Tue, 25 Mar 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fqfea5kj"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC44B25DB14
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920940; cv=none; b=KuhkDRCzJMAYV9llKzw02cCCj7JjUf/f2B9+39p6GZL6McMFyROQKKGsXiwZWIMD/So/ytwITtnHB9naK9C7cUoBYcQmBlO4JJB6/SF3fA3HYsGVBqDvZo2VQ6/EsiUXL9p9RjfNbT7juaW0xqPIHMzOg4rq/xWfUAYb3s4PpgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920940; c=relaxed/simple;
	bh=y7OamuBAgjFXR+Jvr6EGbrgHFrZXlUxgR2Lvs4CxHO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrCqysjoHVAtzx913qZioYHhsYPNhKDluEPeQEko9TnFuqbkZCf1Zx1dtIZl1naSouGXSJsl/LtHo0OR0BC1iqRytgjuTUcDn9XK5tsflEYs3Pef4jWZoTEHTtlru2Ppjt+90AVsHPlSSwNjNjYHGGzRi/X1ysrRg8Q1FBPMg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fqfea5kj; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85b41281b50so143222339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1742920936; x=1743525736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTTJMQh4Q7DaIdKz4FEr6Yox4Ji7tjGb+tqy7Vmt25A=;
        b=fqfea5kjcd9YySAuH7CSfe/UMHjJiBldO0bh80dNDyrhvUFdyBzS8CUDoijwa+j1qo
         YE6rBPMEEGVBqVJDmGiQbtLfbUle5WJ/QZQ9qb4TsxRkiIablo1zkZ2StUXw7IyfapIf
         NjdGXgNOJQWXu0knkLm3zYp/hwAhnnIIUfBSWLzb4Cs6Y6M8dLR+mnOwvBgDrvPQTGxn
         uygkgQncOhGbgCwbVhxZ/u6E7ChD7Lwiulx7GFVnaA5XzLJ5vx/AvL7D+kSk5M2Rzikz
         BgNgITzsdPuy5MeC/y/8Y409QPue+EvafFuXx3n6UfHgeEQVCxWIzDfRNM8FiPAy7md1
         HnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920936; x=1743525736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTTJMQh4Q7DaIdKz4FEr6Yox4Ji7tjGb+tqy7Vmt25A=;
        b=oEOnDJ/9XwmEpoTrpSG7ki8yfo55FKzoAX1bKX6y25Orv2QJZhOrw3FH0b+Eib9CpN
         nveE/dBPKF31zj1oBttCgRs3CnS9uDOGGpCI3QD9IZrDW8yKZR1n1TwGWvi7FgrgOE82
         INcW7Z5j94BJjnFtzzPEB1kGlT95lcCxYF1sdpACVSepgmUHFTzlqu8zm9QWzoiSiJHS
         mgxfIwDfsRz+8HUf+ECeXEZowXEpBIC8m95WlZgTggxBIx6qJ3SiOa4mRcx2FufPgPjI
         kp8/noykL7YdoeAXH+H+zq/WXzUxXoo36q38d0DNVz8pnZGYXR2D2R75305X7+OR6zQZ
         CuGg==
X-Forwarded-Encrypted: i=1; AJvYcCU1/cqREX2Bpv2oAgk8o8DFSMtCvUf60nuv4vunbpn7Z70zsdiXGZ90jIKI+z9rOEmNk3CgB6EftSjqjX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSIyRm6ojZb3S4vlq+elKMelBSiyLG/KrEej3SLAIjXL1FOxO
	bqXV3qZejqanyEb/4lY6UyVgO35x6ULfW1n9jsvdIa22v5kJlqUYzQ7RHCFd+cY=
X-Gm-Gg: ASbGncvKa/jmn0YMnie01cD7FeEx4OeaEM9EFgmQniQVmDmP8pq/SMmBDnRuHLiKA6S
	E3km+qO23hyhmjQ3QGyWxJo8OGZnbJt6orGMEMCVsGLpskAi3W+fhGyVNj5UlpzycJQNeu33NBR
	nwXar9GLJ4U9j4wBVTBP/Ul1YDIP47wg40+wh2/haheqGXnVTCGozGQ78GB7MhcBKhx2AkXWn6v
	vtjXT+ojEAw2ItbeaueFAbwINYV6OTY5Zq5GnsTD6++/FDUTKKzaRc/8B/hdCn+glZ7eGbQMtTO
	xN5h69SLdeRnInR70BChwWjc7w==
X-Google-Smtp-Source: AGHT+IEdPrW1IPp7TaRd95u5F0Qr/v/DMqiOQfCe8RwxVTGAx/HzWij7cnyT7kVBsmL45dqQiPVHww==
X-Received: by 2002:a05:6602:7206:b0:85d:a5d3:619a with SMTP id ca18e2360f4ac-85e2cb4e77emr1733704839f.10.1742920935834;
        Tue, 25 Mar 2025 09:42:15 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:8152:1b37::2b6:1])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbeb3817sm2454206173.126.2025.03.25.09.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:42:15 -0700 (PDT)
Date: Tue, 25 Mar 2025 11:42:13 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	James Morris <james.l.morris@oracle.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-ima-devel@lists.sourceforge.net,
	linux-ima-user@lists.sourceforge.net,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-team@cloudflare.com
Subject: Re: [PATCH] ima: process_measurement() needlessly takes inode_lock()
 on MAY_READ
Message-ID: <Z-Lc5WxW7NRA6AiT@CMGLRV3>
References: <20250325155934.4120184-1-fred@cloudflare.com>
 <ed260472-c07e-4172-b389-deb8e92f416f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed260472-c07e-4172-b389-deb8e92f416f@huaweicloud.com>

On Tue, Mar 25, 2025 at 05:30:32PM +0100, Roberto Sassu wrote:
> On 3/25/2025 4:58 PM, Frederick Lawler wrote:
> > On IMA policy update, if a measure rule exists in the policy,
> > IMA_MEASURE is set for ima_policy_flags which makes the violation_check
> > variable always true. Coupled with a no-action on MAY_READ for a
> > FILE_CHECK call, we're always taking the inode_lock().
> > 
> > This becomes a performance problem for extremely heavy read-only workloads.
> > Therefore, prevent this only in the case there's no action to be taken.
> > 
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > ---
> >   security/integrity/ima/ima_main.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 2aebb7984437..78921e69ee14 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -181,7 +181,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
> >   	action = ima_get_action(inode, mask, func, &pcr);
> >   	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
> >   			   (ima_policy_flag & IMA_MEASURE));
> > -	if (!action && !violation_check)
> > +	if (!action && (mask == MAY_READ || !violation_check))
> >   		return 0;
> 

Hi Roberto,

> Hi Frederick
> 
> thanks, nice catch!
> 
> Thinking... in fact you are saying that there are conditions for which
> ima_rdwr_violation_check() does nothing.
> 
> For better clarity, I would add the conditions for which we are doing a
> violation check in violation_check directly. So that, one can just go to the
> function and see that in fact nothing special is done other than doing the
> same checks in advance before taking the lock (the conditions you are
> checking on are immutable, so it is fine).
> 
> So, it is not a write, and the file is not being measured (this would be a
> bit redundant given that we are checking anyway !action).
> 
> Thanks
>

The ima_rdwr_violation_check() call takes a action & IMA_MEASURE
argument anyway.

My initial thought was to replace ima_flag_policy & IMA_MEASURE with
action & IMA_MEASURE there, but I wasn't sure if there was a race
problem that the ima_rdwr_violation_check() is trying to catch for the non
FILE_CHECK cases.

Otherwise, I think the checks in the ima_rdwr_violation_check() demand the lock,
and therefore we can't just move them out to that violation_check
variable--unless I'm missing something. As for other conditions, I think
it's _just_ the MAY_READ we care about.

Is what you're suggesting to move the check mask == MAY_READ to instead be in
that violation_check variable than the branch?

> Roberto
> 
> >   	must_appraise = action & IMA_APPRAISE;
> 

Thanks,
Fred

