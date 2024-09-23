Return-Path: <linux-kernel+bounces-335900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C23C97EC42
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9901C210FD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AE6199930;
	Mon, 23 Sep 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTufOe9T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26619644B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098147; cv=none; b=omOWTD0tAIH7RvKGbOcgufW1028adn1i1xmjkD2KH1PzHpoOQeApM7SH6qcQDX0wmsQkAi1FzjLyGnkQfHI/069DpiM2n0Tlq4eisbZozaVZ0JNvR1qXkcTF065SV9wz9NV33Zc9kt/OMuk8TkQfhUQyZtFbd8D0l5oB37l0Tmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098147; c=relaxed/simple;
	bh=msEb1X/nEcnG4bk7IVMn+Wb47RheqIVhxYd4dGOLXqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBqYX3B4Ss3ei2icDrd2XjFSAZL4MTAEmdHo9L3G4IEaAj7TnuujNI8iiAVL71ntAlNkEaykPz5LpNyrVjNXqrV1XKajAqfgF1WxxjO64s8KvLXatDvJJteg1vcHDyBAie1JCQyuyqjRaQNy05OM9bqERzg9w54FubCtYEecREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTufOe9T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727098145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20s6lwzO5vISgIlU0MNWzFQNkl/acYGCSCT2Efes/80=;
	b=gTufOe9TtrxJEG7KmYKS+VhvfalUuZARjFdZ4XXH28Pi4Cww9vEtbFSM1EDHLSTvKtfUTo
	LAtQ5zF9ANNUTKXkx0j+445P3GRcCIad7UQYR5uV+Kc16JhGw6lpv3CxN6oI1u7YGlZOh1
	GwOiWK61tSpcDlVkQY4h+2lOOO6uBbk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-wkftPBouNoinLcQzrMMHeQ-1; Mon, 23 Sep 2024 09:29:04 -0400
X-MC-Unique: wkftPBouNoinLcQzrMMHeQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7acac374c62so902722585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098143; x=1727702943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20s6lwzO5vISgIlU0MNWzFQNkl/acYGCSCT2Efes/80=;
        b=kzF4p7tmseuaVarBxBPo/B40+Z1ITdyyqHv1yPdzM6T3USHJIbHvPO37N/Q7VOo7LJ
         Lo/ixC3NGD86VQ9nf62lFbYvaKRSUN+SxcQmcgZYNqX/JbjjsaLBp6sGRUqqIP+xA/Ko
         cO7eD3HYNMHiBWmiOOXezlLEqZLIZ/tJlXjXyJ0xaJh2SjPjVYs/sZGDc9wodAJw2TfX
         1v9Wf19h77qjLVvDqrqbXDNWTRlIWmEYQojtOPwIfL5yFJYlXeT96KmG2GFdzA+pgXjA
         AVbjKRh+iaaZAlvQTxQlbyFwEyGQbRlcnwF+r9eTZe/s6vYBXGFA+6wl3yC93o3w/Gsv
         lNTg==
X-Forwarded-Encrypted: i=1; AJvYcCVh+rjZYo1VpD4u7C3VejEd5M2QrvoG8KCOvXl+I3ZguMdT8Gvfvj4tzKbBfS+BgOJe9W/OLH/Gr7C+FLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMh0zF8l/plvVPZgBB9i16Wrjib0UJwQ6H80NHzn8Z5s78OK5q
	kqIQi9Qk8d9QCN02P3hjNQKdfbCDrT4FfzS+yCEUWIK1CXvw0suxOMLG1EbWPsd/1QREW5hnb/K
	rL5KimNQApEZanTNA13W8q+SZ266GqmA1D1g9BiB1kIUhhN4NpVWUYXQRuD3zXw==
X-Received: by 2002:a05:620a:3712:b0:79f:932:86e3 with SMTP id af79cd13be357-7acb80aacecmr1706616385a.19.1727098143617;
        Mon, 23 Sep 2024 06:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFproagSsXayd2M9HgYrmHoDPKeKrL4pq64vG6McfTTSNTepO4s2SGJNiff5R+iIxsC799C0A==
X-Received: by 2002:a05:620a:3712:b0:79f:932:86e3 with SMTP id af79cd13be357-7acb80aacecmr1706614185a.19.1727098143204;
        Mon, 23 Sep 2024 06:29:03 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08c13c4sm482204485a.98.2024.09.23.06.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 06:29:02 -0700 (PDT)
Date: Mon, 23 Sep 2024 09:29:00 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v3 2/4] pm:cpupower: Add SWIG bindings files for
 libcpupower
Message-ID: <ZvFtHM5465aOYX24@rhfedora>
References: <20240905021916.15938-1-jwyatt@redhat.com>
 <20240905021916.15938-3-jwyatt@redhat.com>
 <0ff4937d-0e51-4d67-9b8a-d2bf1bebe1fb@roeck-us.net>
 <CAHk-=wjVpftmPF3SopywFgQ+uzgdScTPWTxmq7HwinVqwbue3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjVpftmPF3SopywFgQ+uzgdScTPWTxmq7HwinVqwbue3w@mail.gmail.com>

On Sun, Sep 22, 2024 at 08:39:28AM -0700, Linus Torvalds wrote:
> On Sat, 21 Sept 2024 at 14:23, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Wed, Sep 04, 2024 at 10:19:09PM -0400, John B. Wyatt IV wrote:
> > >
> > >  .../bindings/python/raw_pylibcpupower.i       | 247 ++++++++++++++++++
> >
> > This file is deleted when running "make mrproper".
> 
> Yes, please don't create files called '*.i", "*.s" or "*.o".  We
> assume they are generated files (the result of the preprocessor, the
> compiler, and the assembler respectively).
> 
> And yeah, obviously "*.i" and "*.s" and not _usually_ seen, because
> they are only steps on the way to "*.o", so maybe they aren't _quite_
> as obvious as some "*.o" file would be, but they are very much
> standard naming, and we have build rules for them (ie "make
> kernel/exit.i" will create the pre-processed result of exit.c).
> 

My apologies. This was reported and fixed with this patch by renaming
the file to '.swg'. '.swg' is the second filename extension used by
SWIG.

https://lore.kernel.org/linux-pm/20240913201705.7764-1-minhuadotchen@gmail.com/

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


