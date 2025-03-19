Return-Path: <linux-kernel+bounces-568734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B921EA699DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27618A4A39
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C88214801;
	Wed, 19 Mar 2025 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="btEM9Gmh"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8E17A2F0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414301; cv=none; b=JE27jVQ2R+CBEaKwE5lgv49Y7i6FMZAOGhYF8wQENXgvGKrdoO+5+30JCWpHO0nKCPqgkB9F+nvaafV2Gw8HZRcwnx7fbnk8INuvptewz8DfWN7XXPMeM0Y3CAZ8k9OdNBIr8QWSl5WYebb8PqTeL4Bl0LStocOWt8aV5+n6G4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414301; c=relaxed/simple;
	bh=4PAuKV8GTcYbrbN6cu4KCjfX2Idj5fDdJDCql+ZtTeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dv74RewDuMZJg1YuSQZeYjCI3WPFCqivIPErrwi3Kvr6ay0VEkCAUvrDovOEcVkkI26n1TWjebIqcyp5ca1unVAOfdqh/L7VKtHcmfM2HWSGxriVnDzaVkVAiGf8nIPoaN18WiBj4+xwyxDG+zp94RgTK7YVwvUobIOCizqZrhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=btEM9Gmh; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476f4e9cf92so533431cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742414299; x=1743019099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LCYkccOc0ntzBQ3bHOsOPYrpatM51UPOQJ0ehcRQaYk=;
        b=btEM9GmhveMDjXdXMekss2lM/2qo1llhgIgX5EjJXyvEr5Jj6VV+DyLtIojm8tOTmi
         tOd9U30do9a8UICVc5Qiy3N/xjl6doq6FRpIN4J11a16mSGyqUcUpeQMmaEjIh7YxWIN
         ywEDZHJObIVsZqqyieziaBBSOJwR89LRz/cfHT40+2nsfd2RvTrvMHpT5bP+gENVBTYC
         ncKPIC1V3+QT2zbQzUXebF8DcYoICD0AljCFmXP4/o1N9NHlWLhCP+pYlvEoyVWxf6ef
         tNygG/RTHqwI0CJgAU9lMUR3Ig0Mj49aQIRcoWXE5+KFWRZ99Jl/s1JtNxMOONnG3Mw1
         qhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742414299; x=1743019099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCYkccOc0ntzBQ3bHOsOPYrpatM51UPOQJ0ehcRQaYk=;
        b=DY3rjLjhIFrZ6Q510lHYcOSFfMuJ+PYIiehkCQap6z4F0WPZfn3w69yBEMkSKsIW0G
         DGBH2iXVLYI8xCc3iB94SuvZk3HclSs7o32bb+lauod7foXZitSJBIbJ/hcMz/usE1U3
         etSVfXclTrKACGw7PzjgSUNv3/bljpkBGZzNQGY7mgi0GK3ZADxwL/7iUn8j5tS5yrpn
         vmJXNyF7/xIJ5LacugPMAtnF5HGjCsZ8F7Wytt6lWID7IYHtKOjKPLB4VaGT7aYObczu
         ujLUhxg/8R6OtfE7yX8Yu/rnWWchn3G/rQPpKQdhbyt8m84MqGvEYVJGHQ+g/gE/nrmN
         AF5w==
X-Forwarded-Encrypted: i=1; AJvYcCUYNKGOJ4MVRDsMJ3mjJmSScaVEZ2VYZDif0V6NAtNsZYNIs/UzkG4Tzd3w/SbbgQmY63UXH+2+ObhYg00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVBSd8T2wLDRX66bLM6ahTOkhWPkb7kAXzGbmyKKF/HVLQtFxC
	BNOES15BPBkZSsU1ehQDgIDJt2LNXp3zYe4zrn6o/1TS2pLa21bx73RtIQ5ChZEPKq4N/tqSYvV
	T
X-Gm-Gg: ASbGncuZb4o6KjcnKMvNu9seJkFK+DlVilTW2lxSoEdceVZ0t/7/4ZCZc+mVEbH15fB
	vj8Q6UlM1J2Ft3FFOwFpyZkXhrbpC3AFwux53y+YTluz+7SlQMZ4xAbQCHwmPd5sVNR6fOWWJRZ
	ef5yq4s+Dyk7DAxFWQ9XGar0/KBm/X+ApThFR5SFFSioClcBVGT5KmVuT0FcELHEpXc3tvhY5fr
	L7Wm4hm16MSUcptVsPOfX0Ntf/N1LTmlW/LJbhLIsnEC5SRaC9MQPmGzdzwQxL/6X70+Ti/rKu0
	3LP/MvguQI9+EYhTwmDYqLFA1IlqQcnQvl5Ux+2kSaU7fLmXupBSjoUJioXvamwKUXhnuRnO0BS
	qwLSIMo45OgqLaIPi4Q==
X-Google-Smtp-Source: AGHT+IG53s8RQIGxUBD86DpXMIw0IDcEe+RmX3GLFguy7uWXatNqzU3QlP/Blh82b4rIVQ0M6FejlA==
X-Received: by 2002:a05:622a:5447:b0:476:7dfd:fd7a with SMTP id d75a77b69052e-47710aedc24mr13012781cf.0.1742414299183;
        Wed, 19 Mar 2025 12:58:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb611c83sm83409521cf.2.2025.03.19.12.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:58:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tuzYQ-00000000XcU-0zGM;
	Wed, 19 Mar 2025 16:58:18 -0300
Date: Wed, 19 Mar 2025 16:58:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC PATCH 3/3] tpm/tpm_svsm: use send_recv() op
Message-ID: <20250319195818.GC126678@ziepe.ca>
References: <20250311100130.42169-1-sgarzare@redhat.com>
 <20250311100130.42169-4-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311100130.42169-4-sgarzare@redhat.com>

On Tue, Mar 11, 2025 at 11:01:30AM +0100, Stefano Garzarella wrote:
> This driver does not support interrupts, and receiving the response is
> synchronous with sending the command.
> 
> Let's simplify the driver by implementing the new send_recv() op.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> Note: this is based on "[PATCH v3 0/4] Enlightened vTPM support for SVSM
> on SEV-SNP" series [1].
> If we will merge this series before it, we can just ignore this patch
> and I'll squash these changes in that series.
> 
> [1] https://lore.kernel.org/linux-integrity/20250311094225.35129-1-sgarzare@redhat.com/
> ---
>  drivers/char/tpm/tpm_svsm.c | 46 ++++++++-----------------------------
>  1 file changed, 9 insertions(+), 37 deletions(-)

I think the diffstat speaks for itself, you should send this as
non-RFC

Jason

