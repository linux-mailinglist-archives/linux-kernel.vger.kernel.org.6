Return-Path: <linux-kernel+bounces-326996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D898976F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7521C23C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4C01B1402;
	Thu, 12 Sep 2024 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmhbHv4k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7B3188CCA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162609; cv=none; b=fSv8vh/32Z1tVqrEeZcaQLY3hn+SqGzoGgNyPnz3XagBfAzmgeppmDs0CkitJzF6ojut7Q9uxEBx/dQOzGE32dWijPC2rsKWckoFCV4WM/jrfclxpI4P0NiLmujh2x+EeJMFd6GkNV8F3sodlWhs6Kf4DxPiYyX5e/ACN8q96Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162609; c=relaxed/simple;
	bh=LMJ1MzhL6Gl4uKG96gQhRjx+1mejnwtkSR/vqoQDdpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lp2M1t7bqYt1fGOXyZ0pKnMvEvYKd4vLEvLYz2DA7VdFn5+iyUYoWTYudb8++Q6RBapdr1xk8Lk3fmsZVP22ur41jJqeA6+p7R9Ld4t7XS9l/sgYS50b7imuBQkKWLATQ6BvvHg9U2e/Txslr8dktZAcjmlfiLNRZXQ5x3gX5cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmhbHv4k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726162606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5QtpB8TExNQVM6YWGVwyJGzRs7f3WAeIOtC1C2GaYK8=;
	b=PmhbHv4km1ePNMKioXv2qyrirHu2epSrGNIZ/e4DXVJQ0QRUnfkmvwThZvT7Kw7MIagkTR
	RLeFcNUErxbKBmKZBBRAY+qrxxExqT654B21Eb26trADcw7Zg6iP9IAvznCm+cvbOXmwb+
	xrmvkq4ae4ei6k9yIH5mLReJPukaZBg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-QV4bKCkNPN2isE11B6uwdw-1; Thu, 12 Sep 2024 13:36:44 -0400
X-MC-Unique: QV4bKCkNPN2isE11B6uwdw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6c353b29bd7so19999346d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162603; x=1726767403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QtpB8TExNQVM6YWGVwyJGzRs7f3WAeIOtC1C2GaYK8=;
        b=wjH9eopyDhZdj6XmLooS5IiihYmBb2f/dTuA8PybpCRVdEjtSrAtKYqVwLBlMQQGFa
         BGUjvQnbpAwkNpf2mC5nTqoDLXvI54L1wxKPOkc94zkUE6p9KcAV84/3AF9aRB89ZusF
         Tk0sCN/LPf1nWAeViKuRem1SDQOguUf1fvBFCX7NzBq4U4U/ImQMNHOxrd6AbZNQCWWV
         T+LTwK0A6c3GHFUqU+r5vmMWZKHa/L2RNxEs0q+dPTgfTqFsLzjSDEhz4kQiN9Hrndd2
         MauU7kSA/sH/Ymc4CEQdJGHWQ18fchixKN0gNpumGJAtw+CeV9D6mbw599/MFr7Hrz7d
         oTqA==
X-Forwarded-Encrypted: i=1; AJvYcCVJRt6FC/1DQW0Co6DCAQj734FEjTLdIHCwid29LVWHnEDOkwD2T3e4Ze66rLfZ+tZuyqXG4UB0DYmFqcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8QVd/cI7f2Ec1l5+OPsoMSaeE/ZjsEwUs4rnTOjl8EDHHZ5Id
	Ja96OxjgTnYOiL60Swvnx4F54GTf60SeWOFCett7JcT3IA2quGLOWjMKbnFUtmNRhx7MJrC6tuy
	rOvGpLY97B2+xatBdObmeic+VtVcCysuj4sCiIZOZ5JPgaKqhB8anuGpXskVHHw==
X-Received: by 2002:a05:6214:4888:b0:6c3:6e6f:794a with SMTP id 6a1803df08f44-6c57355a292mr54233266d6.20.1726162603328;
        Thu, 12 Sep 2024 10:36:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd+uhL0xCsfLz3jXDEoezjNV9J87Fao/aUhC/IKXjnpIh+QkTZ4m6eoCWG9MsxhUfCcKlrqw==
X-Received: by 2002:a05:6214:4888:b0:6c3:6e6f:794a with SMTP id 6a1803df08f44-6c57355a292mr54232956d6.20.1726162602984;
        Thu, 12 Sep 2024 10:36:42 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53432dfb8sm55947696d6.24.2024.09.12.10.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:36:42 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:36:40 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH for-next] pm: cpupower: rename raw_pylibcpupower.i
Message-ID: <ZuMmqAmr62ErjqHc@rhfedora>
References: <20240912125030.19809-1-minhuadotchen@gmail.com>
 <5785527a-b259-42ba-989e-978d2e72ff35@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5785527a-b259-42ba-989e-978d2e72ff35@linuxfoundation.org>

On Thu, Sep 12, 2024 at 10:31:19AM -0600, Shuah Khan wrote:
> On 9/12/24 06:50, Min-Hua Chen wrote:
> > This RFC patch is actually bug report. All *.i file will be
> > removed by 'make mrproper', including raw_pylibcpupower.i, added
> > by commit: 338f490e07bc ("pm:cpupower: Add SWIG bindings files for libcpupower")
> > 
> > We can reproduce the error by performing the following command:
> > cd linux-next
> > make mrproper
> > cd tools/power/cpupower/bindings/python
> > make
> > 
> > We will get an error message:
> > make: *** No rule to make target 'raw_pylibcpupower.i', needed by 'raw_pylibcpupower_wrap.c'.  Stop.
> > 
> > Renaming the raw_pylibcpupower.i is just a workaround to fix the
> > issue above.
> 
> I need a non-rfc patch for this. Please send a proper patch
> I can pull in once John has a chance to review this.

I have reviewed and tested and this. I am good with it being a stopgap.

Please send the non-rfc patch.

Thank you for reporting and sending a patch for this Min-Hua.

Reviewed-by: John B. Wyatt IV <jwyatt@redhat.com>
Reviewed-by: John B. Wyatt IV <sageofredondo@gmail.com>
Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


