Return-Path: <linux-kernel+bounces-422537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DAF9D9B01
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 835A1B24716
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082A91D63FD;
	Tue, 26 Nov 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Azjsy3ms"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D161D0DEC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636626; cv=none; b=Kha/6YCqqLDywUazuMBkDu1a5MS8I3Y0lLglUifDcgJqxutOj4zvu1+xDx71cT3IbkFKkVWbMwljGC9bYEIAOZ37RfXl7xYTu9UzEHPyHRCkJ92Y7ics/tWpavXe6xBXSKdZX3udyxpE5S6DfLCGY3OVquYGH9bI9jZh62aOqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636626; c=relaxed/simple;
	bh=9IiYq1o4UnfYjmBHmi547Sr5N6hz1Ub5qg9j8X87g90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr4RCHgF/jEfCRiQj/vGNYl2r5ThCjOAlgNB8SIQHjtjASZ2wEZM3L1VSqlI5Qbz/+5S3NLFo7pPjrITWT7Q6cC2qBgxQYQ7a6Btvs5wTPST4kSDCYHTFvq3uAkwI9DcuJj5fIuwUrjdKYVaqKkUknGroz9jEwy4rZ0MUaz8IrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Azjsy3ms; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732636620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGBc9QspParoSALSj68dPsJofxmonDtszCfLhSr8dL8=;
	b=Azjsy3msCIwJK4M90rH2uSMo0rDrewdZCzEv81Sfp1A5hAA2DIRDq8yucVGAt//rg5aYa+
	08+PF30mmW1ltGCRs2TZQylEz7TtdIOtva3vDnY3fk1QKjFXk5W9tXbyj3S8+U2vuVH9/u
	/9EKzqBk54qINYqsGCqevD2Q17+Nycc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-GvbyEc3SOTCb635kU3K4Ng-1; Tue, 26 Nov 2024 10:56:55 -0500
X-MC-Unique: GvbyEc3SOTCb635kU3K4Ng-1
X-Mimecast-MFC-AGG-ID: GvbyEc3SOTCb635kU3K4Ng
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83acaa1f819so629909239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 07:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732636613; x=1733241413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGBc9QspParoSALSj68dPsJofxmonDtszCfLhSr8dL8=;
        b=XBAKkkL0gYG2pV9WUovSS7ElDqiWXoDs9vxKG0yVIvoEli30HS6LIEz8LEQlCjrocG
         ZTPFtl4w3Oxnm0xZxBa9zPLfOa0dfVpU7jCdGvInUpr1RRvugV9dTzBkwgYJnLoEshGz
         5wuksavYFQnUZPkMVoSZcLB0UW0lmlh1z4zEpBuwTA71ko96q9BdsbRWqVOi0A6dJT4y
         sQ/F5DFLikK0Q7D55EF6rAUZodmD2hYEz8W1wLbVqnY+C7640yvwLviQkEL63AmEavBX
         +Lv5DqmOsD9NUJMhFFTZX60Izoza8ePKojyVSebJ8/zOM81DDp3aDaY1cnGwv6OEOHG7
         2OJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWubeowc7mKvaA4+4n+A1PdPqd5KsL0EG5uN1b/sPekDeeaY+1wfLqa8FAli62syE7LZ1uWTXCSDNbFWm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2dUJqESHueyzJIl5joNxSVA7TjbF6iMb3qNlrMVJmJ2vPkY95
	ziIn7p5C3z53n38/NwHRBvzg0fHte9sRQHcpj60PDvf/cLGruqyyRHGeRqRmeNP6Dgln2DHMWGe
	srZ+iA3fLhkmwTpe/adIpXDMZp4DB2AgzP2YWb1rnjIlP3XwXAdC6uYP8rPm13Q==
X-Gm-Gg: ASbGncvRUcboHeze4+rFVyjHoi29FMzPD3P6Mppn98pkOCPIX7XiAERukieYinJcsWB
	Rafa9VRye3AywMbaEQOB1827e6L/21D/2N8tK4i6FfBzsjGFSGLJ5gDRStkLPAcHVQL+6tF27gh
	HUPp1xn/IGNzEfXOHcfCs5MfM351r4k3PiUGErN6kmbFdm3Y6snpyT238JvD7HpfJp/oT65hoVZ
	7cEjJH0UoIZuMQxueNXy980VopB4weM7FnDrYu81T85Gch5zP4egRrzTrarsvBm+w5X537adOYH
	E0RGpH6y2js=
X-Received: by 2002:a05:6602:2d84:b0:843:ea9a:acc4 with SMTP id ca18e2360f4ac-843ea9aae9dmr92344039f.8.1732636613501;
        Tue, 26 Nov 2024 07:56:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn4uYy6YNzn51eeze838FOY5ApSWVfGdKdG1vLeZcJJaOVV/uOc3iri/6RGFdA32irjpqvTg==
X-Received: by 2002:a05:6602:2d84:b0:843:ea9a:acc4 with SMTP id ca18e2360f4ac-843ea9aae9dmr92342039f.8.1732636613219;
        Tue, 26 Nov 2024 07:56:53 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-843e41ddbbesm22944439f.15.2024.11.26.07.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 07:56:52 -0800 (PST)
Date: Tue, 26 Nov 2024 10:56:50 -0500
From: Peter Xu <peterx@redhat.com>
To: stsp <stsp2@yandex.ru>
Cc: Muhammad Usama Anjum <Usama.Anjum@collabora.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: userfaultfd: two-step UFFDIO_API always gives -EINVAL
Message-ID: <Z0XvwitcZ6ujoV9Y@x1n>
References: <Z0Se4BuVfqwjeCWV@x1n>
 <b0818813-5a4c-4621-9810-dc7443a23dd1@yandex.ru>
 <Z0Ssq15MQd3rimBr@x1n>
 <da978e8c-2a72-4b7b-ae67-41e6ff0d5089@yandex.ru>
 <Z0SwOILi4R4g9JBa@x1n>
 <9b68a811-ffed-4595-83a6-0ef78a7de806@yandex.ru>
 <Z0S3isgc-QlEF7oW@x1n>
 <4689f014-2885-42b9-91a4-ff8b8133599f@yandex.ru>
 <20a1d49a-1f5d-4d3d-b59d-29b9791b72bd@collabora.com>
 <2dd0bcee-a594-4de9-b499-a8ad37be155c@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2dd0bcee-a594-4de9-b499-a8ad37be155c@yandex.ru>

On Tue, Nov 26, 2024 at 10:32:28AM +0300, stsp wrote:
> 25.11.2024 21:44, Muhammad Usama Anjum пишет:
> > The UFFD_FEATURE_WP_ASYNC was designed for exactly this case.
> > The IOCTL will return you the modified pages. An example of usage
> > can be found in selftest/mm/pagemap_ioctl.c.
> Thank you!
> I studied the examples.
> They are quite clear and good
> for copy/pasting purposes.
> 
> I had yet another "problem":
> I tried to create the usefaultfd,
> then register the API and fork()
> the process. In child I do UFFDIO_REGISTER,

This doesn't sound like the right thing to do.. as the fd (returned from
syscall(userfaultfd)) should be linked to a specific mm.  If the parent
invoked that syscall, it's linked to the parent address space, not child.
You may want to do syscall(userfalut) in child process, then pass it over
with scm rights.  Otherwise IIUC the trap will be armed on parent virtual
address space.

> but the parent can't see that.
> So instead of copy by fork, I
> had to use SCM_RIGHTS.
> Is this expected, or should it
> work fine with forked fd? That
> would be a bit simpler than to
> apply to SCM_RIGHTS tricks.

If child is the process you'd like to monitor, I think scm rights is
exactly the right approach.  Otherwise you can have a look at
UFFD_FEATURE_EVENT_FORK.  However that's not designed for child-only traps,
IIUC.

Thanks,

-- 
Peter Xu


