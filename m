Return-Path: <linux-kernel+bounces-247977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A59A92D6D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4FB28679B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B9D194AC7;
	Wed, 10 Jul 2024 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIYqhKrg"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8902A189F54
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720630008; cv=none; b=K1++hSmnAvsM1/Y+2g0xxeI+70jTL458gMlnVqi8X4d1D8TwBqbwLVoib0viJmBIux+CTCEGTQWmkB2lEz9IDIOPI7XfnrHVDaQocIBmG/lKx003mDXe1B2Fy1xBfmhfyP8qjicvgzV8m0vQphdL/UunzcfHgt+AB3h9P40Byc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720630008; c=relaxed/simple;
	bh=V2n+Ze34PEYFSyQdvOGt1c4qyPWWne875QtYOiCnpw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8/q1sUQoN0DvmDqUakk81VWiZzAijm12EAqwmaqpYJR769qcw850Wy5hpUzuWc3INjgz0A1lvOJ68QaCtAoxKH8IAXgxy1TFAZJDkqpN95M+Qp5sI4ItYmtKNDx3dZD+ueuZi6KW/Ncw/abrLCJvgXnBhLLhWVjCygtIUju7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIYqhKrg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb3cf78ff3so45531385ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720630007; x=1721234807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mofC4X5TTESlT4CnJ/wmSmndZ3QAbkDzpU+xUACnz0Q=;
        b=nIYqhKrgrauR2Ap+KYQaMIkiMGe1on6NCBbChTj4q8z0Tq0pnGSVRFwB5N6kxdh/hq
         cfFVHoYjV1+sKtfYOeOmAY88wJnZ+MTFzQk01DWfNOInRuIH9FiTYMudhV5spFl+pZ+P
         2aye7iZHoEq151dh6yhfy2Ftj5dKU4USuxyA5h3XO30zeGRI3vb/3GhnXmgmo3coFO9e
         xVMcB5XgRUcgsS+mVrWd65c1rJwzmWKuM5J67iS6PV8YPdqkAQ0KKCXltFw+1VDNrwIL
         fmZpfuPahyylY8jJ4Y1IIVEcB9FPa3p8PZmmllkTu51By77JtRZ6BlmXE9hpr32D8vwK
         PZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720630007; x=1721234807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mofC4X5TTESlT4CnJ/wmSmndZ3QAbkDzpU+xUACnz0Q=;
        b=KB8ulBxEhERBt8S7lBrTgDRfY+NDsnl9ESKnv480L4dNRkaEQZCam1s4IzTKLz0uUf
         4xl7laOm4UNRSQ46abk0/nA6wcMwzAdCfEaFV94G/hGJszBiWikS0w04TxUc2iU10wbx
         k+e6dQkHRRokMnKMqkMiXcRJ3VzP/XeRerz9lR0rrRUku8ZBN0Ufrnd5hXu+earwsz7k
         sNg43XUu0u7RaRmqXJY9tyQi8GA7y1Nnh9YzoD5odwpqdSsI5LBSIJbPZsMTUg+7ZztL
         EKV62OKPxdBvbrNRKeyVCrKU9mOPqFcSRDYZZ9kJF5RvYRUMvES8Ov3a4qBVxYheU2wn
         hi2g==
X-Gm-Message-State: AOJu0YwRxFwWDAXeQTqAUuzFE/zyQbbCK97OyKfDpcdCf6mekLyJ9J6g
	EJ54bQgZ3KMQkM2NMkfQvGoXoCcWYJArJsN7jHzwDJpr4VjL2OcB
X-Google-Smtp-Source: AGHT+IH9cCVNitNXz2yx1yT42G3RDrXBoPo/B3ONEiTzm6BcR/O5JS2Xz6wadxzm7IHo7QQ8to2t8w==
X-Received: by 2002:a17:903:1252:b0:1f6:f0fe:6cc9 with SMTP id d9443c01a7336-1fbb6d8938dmr51192005ad.54.1720630006777;
        Wed, 10 Jul 2024 09:46:46 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab7980sm35913715ad.177.2024.07.10.09.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:46:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 10 Jul 2024 06:46:45 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, righi.andrea@gmail.com
Subject: Re: [PATCH 3/6] sched_ext: Make @rf optional for
 dispatch_to_local_dsq()
Message-ID: <Zo669YYpd9oYVoaP@slm.duckdns.org>
References: <20240709212137.1199269-1-tj@kernel.org>
 <20240709212137.1199269-4-tj@kernel.org>
 <20240710161025.GA317151@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710161025.GA317151@maniforge>

Hello,

On Wed, Jul 10, 2024 at 11:10:25AM -0500, David Vernet wrote:
> >  static void dispatch_to_local_dsq_lock(struct rq *rq, struct rq_flags *rf,
> >  				       struct rq *src_rq, struct rq *dst_rq)
> >  {
> > -	rq_unpin_lock(rq, rf);
> > +	if (rf)
> > +		rq_unpin_lock(rq, rf);
> >  
> >  	if (src_rq == dst_rq) {
> >  		raw_spin_rq_unlock(rq);
> >  		raw_spin_rq_lock(dst_rq);
> >  	} else if (rq == src_rq) {
> >  		double_lock_balance(rq, dst_rq);
> > -		rq_repin_lock(rq, rf);
> > +		if (rf)
> > +			rq_repin_lock(rq, rf);
> >  	} else if (rq == dst_rq) {
> >  		double_lock_balance(rq, src_rq);
> > -		rq_repin_lock(rq, rf);
> > +		if (rf)
> > +			rq_repin_lock(rq, rf);
> 
> It feels kind of weird to have the callee need to know about pinning
> requirements in the caller instead of vice versa. I mean, I guess it's inherent
> to doing an unpin / repin inside of a locked region, but it'd be nice if we
> could minimize the amount of variance in that codepath regardless. I think what
> you have is correct, but maybe it'd simpler if we just pinned in the caller on
> the enqueue path? That way the semantics of when locks can be dropped is
> consistent in dispatch_to_local_dsq().

Yeah, it's kinda nasty. I think going the other direction probalby is
better. The reason why we're doing unpin/repin down in the callstack is
because this is being called from sched_class->balance() which is invoked
with rq locked and pinned, but also with @rf so that the lock can be
unpinned. There isn't much that can benefit from extending rq lock pinning
deeper into balance implementation, so it probably makes more sense to do so
in the outer balance function so that the inner functions don't have to
worry about it.

Thanks.

-- 
tejun

