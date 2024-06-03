Return-Path: <linux-kernel+bounces-199329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2028D85A9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277EF1C21A9C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17FCB65F;
	Mon,  3 Jun 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YvkQ8+eY"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2A0130496
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426806; cv=none; b=pgWfCpa7H7ITl1EFR/tDVj/9bezBU/S3NIvXIGWdaSqpcMmqFN4V2k+JedhSo0jhIiDUTvz0maLG1g7hGsder1bfSA/oeQI3BhtUab523QJfppgRPmZcTzEiVbT1x8cLk5lnJQjNMmu7Y3qTfR/9k7NCRaCpHAty4X8h2+Dv7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426806; c=relaxed/simple;
	bh=iItJbynoZG2fkDdvd+Fuk2y4lnLKFsONk8y9DX7sdwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icBtBy11QdMOF4DYU47w7Q4wRTAVlwb/C4Zlop0cPc4g+HJIibpINpWipg6QS4quoZq4CLQY2Zkm42S1r7VpUGlECcebbxjjnn5KXBMYVaozZwpAaXqG40au9zfu0r4FZ2fSm+JRpV07YnXYwJCiEFs7viP48goetZiDBYAPxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YvkQ8+eY; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso48552761fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717426802; x=1718031602; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HYRUUR3cLiWnEE1d3GCHu28TWvhvOquyXAvutcjzmXU=;
        b=YvkQ8+eYdscLveLGy2lWIcf5kpoEBPgUWov+0Qgy+VnjtZxlW/ttMAp2ujijV8Tzvc
         oKJ4tcKdWwiWKr46V4ePMGP2p3xxPUmp5u1QXKzBb3v+irkiCfbxCKpEJu4ZQ2FLlr9Z
         N7wABB/1D/hurVn136jC913Qhb4aD1o9UBRdry0OsZnff7mauIh55bDyLdm6iWGoeTCr
         k+R+J7LQKmj6xU90s31b55PBohOT4Jv/Gu7VhapmCVEgw0lTAxcvxYkdOCuh5x0xeQxw
         CYV3fX4jKJq+ozG/uaYCaOixm0uGFeRh27QCea92rpyoww64l244nqwYhbS+ai+iZaZ9
         1n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717426802; x=1718031602;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYRUUR3cLiWnEE1d3GCHu28TWvhvOquyXAvutcjzmXU=;
        b=djrIXaithdX+Kws7KHEeRxgEx/CzCUl3tJk1wTWELJTEuOE7TlTpFv0PKZ0tpUUEAF
         1w+MD0snNHgPF77Ae+FuD0H5oLqMrhoiwDnnqp6KPfyyXfUBMscpr3A6fzEUuOIM1Qv0
         n1FjKhw9AaUVdWDBHWIgmrHXpbub+6ApEoN4RjLkARwCZe1uDlXcbir99DEDUFLRLX9x
         3EIdMzyDD3ObUtjUnKAqIfP99JEJ6B9XyA6wgeTRkUk/ROpP5Zmu6jOuQcIZnven5h8i
         Na7E8DMBvt9NWLkwADgEUmpfIIc2Uue3PYelmwGSd/WilkMaakfcnSESu+3Vhlzjf5Pj
         g7pg==
X-Forwarded-Encrypted: i=1; AJvYcCUPQHrXqovtgZIJtAZfCIXEIJextj8V5dQyUpleypbDQphnfmTMuF4rWHjUqDgPWT2XOoFAdApZ337Uad+DrGtB4obDJeEa/HU7OJtB
X-Gm-Message-State: AOJu0YyepStKKGBPj7Q9uZy0i6yFxkYNLpb1EfgXBOYKeL3eso1CQ4+Y
	x9fkx7VNH2nv5P6wfInWyTkT267FQuQY4BJAD4hqJkT7oMlJsODSMFknNmfjSd8=
X-Google-Smtp-Source: AGHT+IH5Dxat+Ix87X+1jaKmBYce6fT9DMH7CdUkz2iRRzf15OpyFBvw1q/h6mcTd2CZk0Bn0nrFSQ==
X-Received: by 2002:a05:651c:10d4:b0:2e4:a929:78bf with SMTP id 38308e7fff4ca-2ea951d794amr54500371fa.43.1717426802016;
        Mon, 03 Jun 2024 08:00:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b0518csm5785580b3a.147.2024.06.03.07.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 08:00:01 -0700 (PDT)
Date: Mon, 3 Jun 2024 16:59:51 +0200
From: Petr Mladek <pmladek@suse.com>
To: "gxxa03070307@gmail.com" <gxxa03070307@gmail.com>
Cc: "john.ogness" <john.ogness@linutronix.de>,
	rostedt <rostedt@goodmis.org>,
	senozhatsky <senozhatsky@chromium.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	fengqi <fengqi@xiaomi.com>,
	=?utf-8?B?6auY57+U?= <gaoxiang19870307@163.com>
Subject: Re: [PATCH] printk: Increase PRINTK_PREFIX_MAX and the buf size in
 print_caller.
Message-ID: <Zl3aZ1bfsUyX-7I4@pathway.suse.cz>
References: <20240527091929.316471-1-gxxa03070307@gmail.com>
 <ZlSewPTyQ-jMpW5n@pathway.suse.cz>
 <87y17tktze.fsf@jogness.linutronix.de>
 <1717404421510.qmo40jy5kubcunlrdknzajsf@android.mail.163.com>
 <Zl26LDOV_v946kOv@pathway.suse.cz>
 <1717420513010.hwqncbrma24lbz30knw4rdzi@android.mail.163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1717420513010.hwqncbrma24lbz30knw4rdzi@android.mail.163.com>

On Mon 2024-06-03 21:15:13, gxxa03070307@gmail.com wrote:
> https://android.googlesource.com/kernel/common/+/refs/heads/android15-6.6/kernel/printk/printk.c
> We are based on google source code development, this is the link to google source code printk.c, which adds trace_android_vh_printk_caller, if we want to change the buf size must first merge into linux main line.

trace_android_vh_printk_caller() is not in the mainline
=> there is no reason to change the buffer size in the mainline.

You might try to get the change of the buffer size into the android
google sources.

If you want an upstream support then please try to upstream
the entire solution.

But the use of trace_android_vh_printk_caller() is a hack. And upstream
will not support such hacks.

Best Regards,
Petr


> gxxa03070307@gmail.com
> 邮箱：gxxa03070307@gmail.com
> ---- Replied Message ----
> From Petr Mladek<pmladek@suse.com> Date 06/03/2024 20:42 To gxxa03070307@gmail.com Cc john.ogness<john.ogness@linutronix.de>、rostedt<rostedt@goodmis.org>、senozhatsky<senozhatsky@chromium.org>、linux-kernel<linux-kernel@vger.kernel.org>、fengqi<fengqi@xiaomi.com>、高翔<gaoxiang19870307@163.com> Subject Re: [PATCH] printk: Increase PRINTK_PREFIX_MAX and the buf size in print_caller. 
> On Mon 2024-06-03 16:47:01, gxxa03070307@gmail.com wrote: 
> > I need to populate the temporary variable "caller" in "print_caller" func with the additional information. And it's no use defining a buf in out-of-tree patch. 
> > In out-of-tree patch, I can only add hooks (special cases), I can't change anything else, because it needs to be consistent with mainline linux. 
> > caller buf in mainline linux is it better to make the buf bigger and leave some space? 
> I do not understand. Why the buffer size has to be consistent with 
> mainline linux? 
> Really, it does not make much sense to upstream just this part 
> of your out-of-tree patch? 
> Best Regards, 
> Petr



