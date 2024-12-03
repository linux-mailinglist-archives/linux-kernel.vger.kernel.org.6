Return-Path: <linux-kernel+bounces-429398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5484A9E1DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11838B359EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02E51E47D4;
	Tue,  3 Dec 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfPvoxMC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958311E47BE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733227213; cv=none; b=oQOs/71W5ocDBXcZIyPjpC3/AuVuyUWGIl/WBkJDTbuQTyFxxIK0fAzuiXFAlassKkOXzudrlnsumVMTgpuMbSOwGF7xxdI1VIzkb7GakWxJVSD9SFd6Jak49Qbcp8OucTq3e9fA/HiE5EUyskDXQFQPBAkMSX/A70vNpbkou74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733227213; c=relaxed/simple;
	bh=vCWjo4UwK/zJnGBd+Ae+dYddf0xdwHelnN1vgicoN6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NttNyKvmEIINezeEb6uvb/jrYY48GtCYp8gmc2wgxUg8P5/2zYqQCX7gChnul2Ph6yQk4kU1OYUiOotbjSHapeSr3KhsKhrfxm9E25/jwfIpwBL6sTErjFNiZnRRehTuSZ7ErQkkU8VoktcBiZ5Au/XVnAVUCpxS+CjHHGh3WI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfPvoxMC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733227210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+gcZq4akU5famwcdbMHLgs5gLJ8OKdKfq60hRuVR5Y=;
	b=dfPvoxMCcsNK3BqY/SlkpX7/IV/CcdvJdSRDL3uViRL9eErCAlD100ZJlN5ee/PtvuR3bK
	HB3Sde+DoEPR3mIeQrKErxYTHPDtVFLJE+mwt9PfuvCNL49gyBPrcnBpPZYXlY9IbVBri/
	3VIXIePFVJxlhLyF6aRey/+3Aj4lI2U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-WCfQjhYtMWG1B7M9BXYdeQ-1; Tue, 03 Dec 2024 07:00:09 -0500
X-MC-Unique: WCfQjhYtMWG1B7M9BXYdeQ-1
X-Mimecast-MFC-AGG-ID: WCfQjhYtMWG1B7M9BXYdeQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e03ee802so1682983f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733227208; x=1733832008;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+gcZq4akU5famwcdbMHLgs5gLJ8OKdKfq60hRuVR5Y=;
        b=h1SEEopMc94yAIXgq6WIVQN8gONjPUt65P1Zn337kg7251Ae58Ss3mh4RaZOJqhgVn
         m1hnBAlF2xdgqItRXNJS4dDRwf9lyB7pz2rrU5jk2vSxAF41bcAFnr3Ga3zZFRcypMiq
         iRADnfwU6R1e4Cc2fxLb7Nwwe8D4crd1shRmGc/O32n7n/GALZDthFtJp1OhK62ca+KJ
         QrmbFyaFPkVBUKarJ5nsFq6rNunfPsK25UnJfB5TSleFqTNbHCJa/yRKDLZqssxEHeW1
         7qeRZYPlJMZX8/7zyc2Lj2FBXgosgLSAP8P7YBzcL4IgmkYAUL3NGW2j4Qxvj5q8x+B6
         S5Nw==
X-Gm-Message-State: AOJu0Yw3y6sSkIrN66d/2cXT1j3RTJXrpt3F+pkGzGMarjgYpSmTvD2o
	0uwBS/CPWMUtF/FBc4tsq661aPyTMfQvEQ1C39RSDhZvbmjQAFhyOWHjTVX4wgij/1UvhRzYDsi
	RqZw2r9Wxdz/BXVQR7a4pQ2gqWyWxXuHhn11q6V83vt1xBQr6rh8QvzNOhTeceg==
X-Gm-Gg: ASbGnctZXKMfcYwI9xqa+dlzrNDSR7MQvQ1iAvPP0+BwvzlD9ESCYA951t6u4otpUq4
	I5tqV+s0GRwieM9Mb18MBncQC4dWGZPmSs0jQeDHyhlD+OL8MZrzb6IAxbRZRguA0LOfL6SddYU
	St2OG//K7G4GrqlnqiGr62YuNG0FKArZrEJGzmA8Zdiex6L/ayPflwIOHTN71XsK+9+WyNagYuP
	O63G0jvru4njX1wNjgdtNZZ/njbzq2sn7hfZQ87K0p+EwkzZUToeObGqFqBQrmoMtwiCmJkqapu
	LWHJ4w7B0vor0XKnoCJ/JfpYBI4oQooTuJY=
X-Received: by 2002:a05:6000:42c9:b0:385:f7ef:a57f with SMTP id ffacd0b85a97d-385fd3f1c4bmr1431340f8f.27.1733227208147;
        Tue, 03 Dec 2024 04:00:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1gmAc+ZEEBHrfuNXDTG/UpwaAK/S0WeHK2J3tcVT0AzfMePj9e0aQTvRzwnquWudR75Acjw==
X-Received: by 2002:a05:6000:42c9:b0:385:f7ef:a57f with SMTP id ffacd0b85a97d-385fd3f1c4bmr1431325f8f.27.1733227207833;
        Tue, 03 Dec 2024 04:00:07 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f7148fsm185888995e9.41.2024.12.03.04.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:00:07 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/3] objtool: noinstr validation for static
 branches/calls
In-Reply-To: <20241128013507.6um4vkfz2ojqwnoz@jpoimboe>
References: <cover.1732682344.git.jpoimboe@kernel.org>
 <20241128013507.6um4vkfz2ojqwnoz@jpoimboe>
Date: Tue, 03 Dec 2024 13:00:06 +0100
Message-ID: <xhsmhh67l5649.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 27/11/24 17:35, Josh Poimboeuf wrote:
> On Tue, Nov 26, 2024 at 08:47:39PM -0800, Josh Poimboeuf wrote:
>> v2:
>> - Add some fixes reported by kbuild.
>> 
>> 
>> FWIW, this reports the following static keys:
>> 
>>   - sched_clock_running
>>   - __sched_clock_stable
>>   - mds_idle_clear
>>   - vmx_l1d_flush_cond
>>   - stack_erasing_bypass
>

sched_clock_running, __sched_clock_stable and mds_idle_clear are already
covered in v3

vmx_l1d_flush_cond is modified
- at init via __init vmx_init()
- via a module parameter write ending in vmentry_l1d_flush_set()
So either init or user/admin action, IMO that's a "don't touch it"
scenario.

stack_erasing_bypass is modified only via a sysctl write, so IMO same
argument.


>> and the following static calls:
>> 
>>   - pv_sched_clock
>>   - x86_idle
>     - perf_lopwr_cb

All of these are only ever modified at __init, so they can be made
__ro_after_init.

>
> -- 
> Josh


