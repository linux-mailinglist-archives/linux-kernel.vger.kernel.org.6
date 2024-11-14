Return-Path: <linux-kernel+bounces-409798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8629C91CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693CF1F22CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013C0199948;
	Thu, 14 Nov 2024 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="U7wFWkV5"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7781990D3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609695; cv=none; b=lACvghQzIBdKdMqZcg8dtbz3VxxLuZb1nZ3L6Dg8ql+vQqaQ8+nZrQyIXYSUU4zU/Evqbk8ktVWApWKVyqGDTcFpSjD7062hvC6qzgC4+VDJTNI0PHBrrSmyJ+r/AyhJUib+m6D10tGb1LTpYXfORUnCtv8WcypYvqnkD67IJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609695; c=relaxed/simple;
	bh=WKf6aY2AGUMfI2JDRk3jnTXS9jlX/vJJ3h1XAzt7RFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYyBpBeGIwV+mIthGiT/sVq2SpTSsSzSLfVW1UXxNMc7vagBW3m0Oi8ZKnHO3pfMBDnfornn/+bcZEJornj4b42aFrstB1NcKisKYL448uNuyQ94UkJER8xA96eyZchS7ac6aISZSqBjErbuAkgmjAvpEV2NTeW0T3KiHldeVNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=U7wFWkV5; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b148919e82so58166385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1731609692; x=1732214492; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQXEkeoQUC8p6hTmJ9wLSM3epfwlx86OSomyiO29A/M=;
        b=U7wFWkV50lGYcPsE34Ewzj22dnFWqxy2TmaqfWBT954n2CED5BD0pQFnoytANnBtuL
         t/TPf/nVtuuuCYhPI58eiPixXsHw4fkKVQ9Ux+z5ph1QPJoY+LaOJ3KMJBx7K3kwLpjb
         fg8k/5uDuwWNbZ/glmOClxJt3/vEllMocDmio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731609692; x=1732214492;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQXEkeoQUC8p6hTmJ9wLSM3epfwlx86OSomyiO29A/M=;
        b=nAUJlh5scGILh16JxPNRFX60SkFUctblm4F+/i2av8npchA61DUg1a5TTmTaZHRrIj
         u4F4Pcj0lRygcbcEVLa16t82GlUJkQHU1qrcgc720AWuEopxO+we/4BISRNjpmqwLDQ8
         wQrEwbHPiqB1mht2F9J5JdqEIfGb57X3I+XTGH2KkUcwZsfXS27C3UNbwBJjLNyv5ljv
         s3PsJoq9eEDorqQzPcyXtA8kovzL1hgsfdYI1QxWIVZEhkJZpIXKtkam6stohF/Q64kH
         5s+ARiZi7ELG4lBWyZOWUoech6GTUj4mme6eQHvLoxGAG/xZOOBNUgg4rFPHCz+0txHK
         IejQ==
X-Gm-Message-State: AOJu0YyxH2vjLcpoOOv1KpLpObLB4pPVt3gXElhGW2wf3k3xtutUmEw+
	PiQKBI532hNybfnJglZXRfHCsid0v/jrNC675sxKt97zA9rUIfe3JK84+NXyEno=
X-Google-Smtp-Source: AGHT+IEPfwJMiiA45TukagZKoPO7RV3c6JNxIvVLAhC37xOrPBQSsj0qd6agWSfawvjJJjoLtbyckw==
X-Received: by 2002:a05:620a:bd4:b0:7b1:43c0:3de4 with SMTP id af79cd13be357-7b352952c1bmr900703985a.31.1731609692593;
        Thu, 14 Nov 2024 10:41:32 -0800 (PST)
Received: from localhost ([163.114.130.129])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c9843c7sm76353385a.23.2024.11.14.10.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 10:41:31 -0800 (PST)
Date: Thu, 14 Nov 2024 13:41:31 -0500
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: register_device: was: Re: [PATCH v6 06/11] printk: console:
 Introduce sysfs interface for per-console loglevels
Message-ID: <ZzZEW5pz5WWVruvd@chrisdown.name>
References: <cover.1730133890.git.chris@chrisdown.name>
 <0312cd1e80e68a1450a194ebce27728cdf497575.1730133890.git.chris@chrisdown.name>
 <ZzTM04qQXOg2RsOa@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZzTM04qQXOg2RsOa@pathway.suse.cz>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

Petr Mladek writes:
>Honestly, I am not sure how to review this. I am not familiar with
>these APIs. I have spent few hours trying to investigate various
>drivers but I did not find any similar use case. I tried to look
>for documentation but I did not find any good HOWTO.
>
>It seems to work but it is the only thing that I could
>say about it ;-)
>
>Just by chance, do you have any pointers into a code or
>documentation which could help me to feel more comfortable?

I think you and I are in a similar boat :-) Some similar code can be seen in 
places like block/genhd.c in device_add_disk and __alloc_disk_node, which also 
do this kind of dynamic setup. I mostly just spent my time looking at device.h 
and its users.

Greg, maybe you could also take a look?

