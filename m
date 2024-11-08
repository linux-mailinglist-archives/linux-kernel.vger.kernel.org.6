Return-Path: <linux-kernel+bounces-401099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD3C9C15F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FB1284804
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824461CB333;
	Fri,  8 Nov 2024 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MeIRanUz"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740ABCA6F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731043292; cv=none; b=prZYwbYHCECEOC7QtN9jfH7ShQeHLzUQiBhR3RI532+VLIZIX8rZolTW+/bC0vF6ujtKjVcaawyK1ql2nvIhQLE4+o8B0oSVst3hwV2J7sWjRPGbv8IDmrcLq7Az1flD5CtLVw/KdOTQKMtVDzfn+fKcfhq/LqjS12lNnpEm/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731043292; c=relaxed/simple;
	bh=3Ga/cH9Ssd7NpZR1ERb8xtNJXH4cAcgWg3oYwhMnTi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfKyzEFQKheh51up8SCaInqRK/UvqoVWkNKP7qkV5kGNX5ml65cCavlz1wJle8jCrZYe8nBMRv8gt7Biz9Wj9lrG1AB9VGOCwVt8JoaC2ghfs4RD6Pkc9vMU5zCawxGjhEroFSXY6aXQBxPExa9wWs40R3RUMSlBIMrHYqGk3ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MeIRanUz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43155afca99so16081085e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 21:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731043288; x=1731648088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kY/mM9/sKjE9cX5IYkE9YA8LXwYNAqtxX8sG0nSvCyY=;
        b=MeIRanUzcBVtCL0F9LvHMT3MY7qCtRL1qA75dFj8QEw4V5cFLxpdgMHN0fqqRBVdLZ
         2fH76alHT3mqqOrElof4Zkp3l2IC2FzHSrg0maS5iaO6erSeo+zwX5xUq/Z/gVKgXNF6
         6wwZloZCf1iXJzN7BpwjWehS0xXv0vE2WrlnW6Yi1g7rKJUSriBjlxmpSzXjho0VJb83
         KcXZIcsIWCm9gs11R0WooZXh0cF20gueFVHFUS98+lEVHWl1FrOF7PWcHN2zu38aut0J
         Pc9vB73PAPCspGWXOKnTbK6ByXOkdBGhU86IQhjS5jpJSlnNeNiQ+YlL//QNZoqGVsM0
         yB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731043288; x=1731648088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kY/mM9/sKjE9cX5IYkE9YA8LXwYNAqtxX8sG0nSvCyY=;
        b=WD5KVuc2tkEb6pWvuS5PiSn4Y87/YhhAqaalrpRQ8ZlFiD4+iG5LDC4/df9o5+BOrk
         yHYa9r+XD4lE6Jb5vpEMvsLOk+844BhYkPxYNrmtXKiTH54D7IYZ6WrOobfbaHIfma0g
         Cvne/H3d61EogGVtqFoQPkk7xGvhoKHgEThqCQyLHN6+ZgQFEZ1VX0/f3xcgA2+WTlvf
         HGgI09mzYnRLMKwlfFn4KjuJLVeSp2SGsHVZscW7OjsSNCCaqUFnT8ihG5vKsOcodj5e
         Wubr+IA0znthUQOOwP2mgCaVLnUVJfsl9APt1ln+1FQJJYsPYgVk+v1Or/5ZBZeCcfeg
         2n8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4qc4K0trH05Oibjlw+aBAqWpPa+2VtEUmgab6s4vPqaQXMO/ip8fTiC3Df7qWZTfE7JHISfQIjnjHoCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqpCV5p5ObgR1bJhYyNMhSqDoGo+O2omB6t9w63ds6q7As4r0T
	OP/BP8beCbQP3GFs67XnNlfQHAY1mkTeRIgybsP5hIaeHX56YAtst15OSmegjz49uVDZALpZmkw
	Gx5ZrfQ==
X-Google-Smtp-Source: AGHT+IEzglwxMlWs4nQ0oGuGRnAnpCrltFhfHCeuJeBgDc6Pnf6ESySquAIOU4F00X9QrFygh1xS9Q==
X-Received: by 2002:a5d:588a:0:b0:367:8e57:8 with SMTP id ffacd0b85a97d-381f0f7f1abmr1517058f8f.19.1731043287726;
        Thu, 07 Nov 2024 21:21:27 -0800 (PST)
Received: from u94a ([2401:e180:8800:eb21:7695:a769:ff9c:3830])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fe8eb7sm2572829a91.50.2024.11.07.21.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 21:21:27 -0800 (PST)
Date: Fri, 8 Nov 2024 13:21:22 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-50063: bpf: Prevent tail call between progs attached to
 different hooks
Message-ID: <tcb3xez6spzcrbv3umgbrjzfrskekjsylwswchrvvzsekfjyfx@okljgt65srjr>
References: <2024102136-CVE-2024-50063-1a59@gregkh>
 <phyhoab337c2vgpfgtrjru2so6luvmymfrugdazacz3sk4to7n@nutpfnn4ivdx>
 <2024102419-deserving-veneering-6641@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024102419-deserving-veneering-6641@gregkh>

On Thu, Oct 24, 2024 at 11:55:46AM GMT, Greg Kroah-Hartman wrote:
> On Thu, Oct 24, 2024 at 12:04:45PM +0800, Shung-Hsi Yu wrote:
> > On Mon, Oct 21, 2024 at 09:40:04PM GMT, Greg Kroah-Hartman wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > bpf: Prevent tail call between progs attached to different hooks
> > > 
> > > bpf progs can be attached to kernel functions, and the attached functions
> > > can take different parameters or return different return values. If
> > > prog attached to one kernel function tail calls prog attached to another
> > > kernel function, the ctx access or return value verification could be
> > > bypassed.
> > ...
> > > This patch adds restriction for tail call to prevent such bypasses.
> > > 
> > > The Linux kernel CVE team has assigned CVE-2024-50063 to this issue.
> > > 
> > > 
> > > Affected and fixed versions
> > > ===========================
> > 
> > I do not know that exact commit that introduced the issue, but given
> > that the fix addresses the following BPF program types:
> > - BPF_PROG_TYPE_TRACING (v5.5)
> > - BPF_PROG_TYPE_EXT (v5.6)
> > - BPF_PROG_TYPE_STRUCT_OPS (v5.6)
> > - BPF_PROG_TYPE_LSM (v5.7)
> > 
> > The earliest affected version possible should be v5.5.
> 
> So what commit id should we use? 

I looked at it more carefully, and commit 9e15db66136a ("bpf: Implement
accurate raw_tp context access via BTF") should be marked as the first
vulnerable commit. This commit introduced BTF-based tracing
functionality which was later renamed to BPF_PROG_TYPE_TRACING.

> ... Can you send a patch adding the
> ".vulnerable" file to the vulns.git repo for us to mark this properly?

Yes, will prepare and send a patch.

Thanks,
Shung-Hsi Yu

