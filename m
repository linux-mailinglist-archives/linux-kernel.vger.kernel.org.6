Return-Path: <linux-kernel+bounces-404961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D34019C4B03
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9359B2811F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBE81F7097;
	Tue, 12 Nov 2024 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XtuK8EZ5"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2685223
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371712; cv=none; b=QtoH10lI0bQ7zy2QnMzVTVAkb680dayq6CYod2w0tFHAnyURHs4Z/9Rq9KniFm/6JqENQdqYhloIj6HgThGTvT+9wrt+oLMXz4vDrtpRbjKcWqHvxKeje8869051XewJdeVWjR4auDHRRUF6eLGJxpp9m+pcK1tfDqK41zz8hQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371712; c=relaxed/simple;
	bh=PkbyTMgFqOzcboehWlrrNjFh8Q2ib415gbHXRRFnbKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4ceNBc7UhGlgJcJI9DvrfWOfODMrvhJ42sc4yFCKDp5Z0v4c9mP/JvdpW9T5ZPEQ9lOq+wDkzCyldYkB7qqFS+D8eFTI8satrRctSXHVgel8EKHfJIujoPWlhPXVkUfILbmBMXFCf3AYRqdyOyPths1KAvmvvlT2o7dFeFUKRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XtuK8EZ5; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea8de14848so3071029a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1731371709; x=1731976509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKgRrgLp424rRp+9+I/8Qg6L1UWiV8NeCx/IXJG06O4=;
        b=XtuK8EZ5k0B8EVS8lRpTMmyiSJxFc1EDkFbTXoxtx9vK6MIba3rfrQYXjWN4wCFgNl
         KVmV1YCHOlYfFs91bgsD5uZfXAX2RtJjDeT5rAGeWRHZS5wdYsjwH7xLuEdpLPFcbS2i
         0IFXutOvz/P3fbHTY9RqSw8+v7wu2cqAI6sSRjsB9m9KrgMI+7BhShgk+hVKxn7R12Gw
         FvhakkkgAhhjzy9SjtneVLmShHgl8tPNP1GUspDLXlM4IUJswOKOb9n1DzDBRptwLjXd
         oNS9iSJ52FDxMepWV3f7L+2kvu6QuoeEdICOfnTthmTbqKslZ2P9BqzkPrw2Wp2twy07
         xTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731371709; x=1731976509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKgRrgLp424rRp+9+I/8Qg6L1UWiV8NeCx/IXJG06O4=;
        b=mBOg3/faWjejQwc0u6cjIZ29qhCybePQlMRyaY5ptCltGjoAvB5XeJrN1R6Fy97Zxz
         aNEG00xOoKWXM9GUIopp8JMpCpvxWSC0fBsMNEDEJMPEToAqsDBGkC9sIKS27sDiuN/l
         YGGVgyiTrbD+8/vkoPM5IZzLXXbxORk2xx8udPyHakR66GBD7zhyP/gwzY6Zut354q2i
         DRapNBRqVEUkpf9h8yT6gc6NDOawiOL03RukHuA7Wv/lBqm9kOEtnSrAlBLg6I5mURt9
         6VEKURUGHWPhavLhouisLFMT9Nv81sY7QS5DSqmCdCAbhtHemBy2AIOO5r+WlGneTaAl
         /htQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKqjRVFfFxsi6/BAMyIlb4Pp0NZRUfZ2kV7sPow+Oj2NTVx2bUDVDW6CVfNEtctEA4ETosKl538P9X3Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8VeHxdOvwcojc3m7HE5b6XjtXAOXvlP7ETjSwuEuI1a2s3v5f
	SGdHgk+z34EVcCWMFUwvvz96Rb5VKppOcOOer9+9E5QksflAfNVBIiB7wdYOYDs=
X-Google-Smtp-Source: AGHT+IGQTUP7sJ930EzsgxemjH6kwFcSH2PpZgSrP5gAgxNP+jgwhKNTZv9LbZwLWAoEXjOkZzUgZw==
X-Received: by 2002:a17:902:d4d0:b0:20b:ab4b:5432 with SMTP id d9443c01a7336-211834f2d6bmr134631535ad.12.1731371709530;
        Mon, 11 Nov 2024 16:35:09 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc8376sm82809975ad.44.2024.11.11.16.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 16:35:09 -0800 (PST)
Date: Mon, 11 Nov 2024 16:34:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>, Aditya Prabhune
 <aprabhune@nvidia.com>, Hannes Reinecke <hare@suse.de>, Heiner Kallweit
 <hkallweit1@gmail.com>, Arun Easi <aeasi@marvell.com>, Jonathan Chocron
 <jonnyc@amazon.com>, Bert Kenward <bkenward@solarflare.com>, Matt Carlson
 <mcarlson@broadcom.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Jean
 Delvare <jdelvare@suse.de>, Alex Williamson <alex.williamson@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI/sysfs: Change read permissions for VPD
 attributes
Message-ID: <20241111163430.7fad2a2a@hermes.local>
In-Reply-To: <20241111204104.GA1817395@bhelgaas>
References: <f93e6b2393301df6ac960ef6891b1b2812da67f3.1731005223.git.leonro@nvidia.com>
 <20241111204104.GA1817395@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 14:41:04 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Nov 07, 2024 at 08:56:56PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The Vital Product Data (VPD) attribute is not readable by regular
> > user without root permissions. Such restriction is not really needed
> > for many devices in the world, as data presented in that VPD is not
> > sensitive and access to the HW is safe and tested.
> > 
> > This change aligns the permissions of the VPD attribute to be accessible
> > for read by all users, while write being restricted to root only.
> > 
> > For the driver, there is a need to opt-in in order to allow this
> > functionality.  
> 
> I don't think the use case is very strong (and not included at all
> here).
> 
> If we do need to do this, I think it's a property of the device, not
> the driver.

I remember some broken PCI devices, which will crash if VPD is read.
Probably not worth opening this can of worms.

