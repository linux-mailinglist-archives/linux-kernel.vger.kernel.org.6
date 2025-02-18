Return-Path: <linux-kernel+bounces-519611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7C0A39EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4FD3A42CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFED26A08C;
	Tue, 18 Feb 2025 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wt4oU0TS"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD3269D1C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888494; cv=none; b=oQbQIH9QzdoIVoyAyr1VP4ERGZYn6O6TH/ZdReDmJROyxpeV91IoLS+t+gwV6CK6UrkRgxKIwBJ000ZPK9rwgJkOb5k2yM/yjAAPCXrh3mObuUhEk16mggbdKoQzfrkYTM9k5C/DVBfjInz4DwVFAxPWYXfly26E+eXGIlsNiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888494; c=relaxed/simple;
	bh=33TMhdfwzRIeMgbcmfNy/XvfM4Ozc97THaJpS4//qnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXMszT7py6pIuiRfJbXZO/HregHBKzVMGTY1jeU8n3zYod/kdjx7H0CRKP7pD8G+HvIfs8xM9FkheSrLVjb4bxg+KqGYymez7RZhdvk0R+U0WKLbUixQ5OxE9z7CwckIjWXVFcNea9tQMKKsRinskF8/lo/0Td7sR/d8+GC/Aak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wt4oU0TS; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so10040751a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739888491; x=1740493291; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=epp5Oj1kI3V0zqhBHGE/nEmzKDkVzIEDSBJvoi97Moc=;
        b=Wt4oU0TSeHw/sNLLwxxqdsAPK0G/PW+799uk1s//YzBfZbx8D6ExFJulH2PHJDClVd
         MZkEBolLuM7VGvxtnuS42XcLz8ZciqBJtHRfYcrlVjM5Rm3QBQ4L7/h2jgBYQ5AxDM5v
         17Ut6u5N02gT6BTxYqOpSoV5OJg6iZTLRn1pGbPNgD2ADYIMVdsz5xjhc7OApyZkHS/4
         7QRuojWNye63p2YzhHvor/opGvYeJOqxxcvQmQQNYfEyTJ9gWM/FUm/i5iNkg3J6mwCt
         gdE51ZZlwvAoLfNwKV3RY0bxIxtsl29wT6y1iezeopl2PGrP5WN8X/v9LoiJAWsesCnh
         vVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888491; x=1740493291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=epp5Oj1kI3V0zqhBHGE/nEmzKDkVzIEDSBJvoi97Moc=;
        b=TUKhy8lhMBltHufLL9t+GZbgFHjZTmSIicmeApG2KpMCDm99KpX/1t2hbmHWD2JYVZ
         ibrrBBQlLwyGtGWy+MzTO+5hL9F0YZ+RrEI3EpO+MYEm6nTr+fRb/68r7bchvKejjt1u
         1+vyd92DQRxBluVoWjWTmxYw4V9ayv4kI44UeqLtvFX3deC++I9zBaRgZi38S3FH107M
         YOGZaTkSusmWUu4Qc8SdJAPLnlt5D5JXYDjet1JpAWrHk8WMG4KUuLRt83F6erIlacJG
         b7zSi4n5eFXLlkp4bB/21Vjm0MfttNJEStroyIUkLdPg4KZ5wuAvNUNsms3O+iPVXMj+
         Dn3A==
X-Forwarded-Encrypted: i=1; AJvYcCVsMdJhCRHTyGJAHIuIMFCD/xQbaT33s09uxJtZ/5ngp3keWLwkSfQ85uFKi8l1hhRp57d1XxV/Fs9yL0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjXoJDpZ9LgJh9niffg1obDS2ijLh8MJr6dAZ6FzB9jiDZ/HN0
	iIdIRp3nKEGy9aE2oA5LaSeL9+NLuvaOPoy3xue+rK0NRXVG/n7VC5W10icVcTc=
X-Gm-Gg: ASbGncsF4LxHSlDgeYJn91mZEK5VY3m35xaV758RWw1Bs/4RKAwWhDM4OxXTj9X2SbC
	ESAxX6BL0mQ93KyRF6qI9hYr9qMheNNOfgKAcHu/OP1ksvPXL/CweFhb+cQy4jgJ8FOryZH2NO4
	EveZElZZmhbACVYR/MMrClag7v+xjlJdWZ8wpv4SKJPTAapyn6cJZsw3Vy4NZtQXV3mJFsFTv61
	4sjjhT9XR3jtbx0VjHmLyfafdJ7lgyijQjEw5wOCVQDlN/pZF3WoCNdOVhzCcIWbIlCp10HQ/ia
	yPPZQkdf50vJRwLq18R/
X-Google-Smtp-Source: AGHT+IGm8Y3zgYesHPFu1v5tsyTj/+j/bH9iWtpP4bLHsu1ODM2GS9NeO/WPPPsgDryp1DtOkgMs3Q==
X-Received: by 2002:a05:6402:234a:b0:5de:a972:8c7 with SMTP id 4fb4d7f45d1cf-5e03722345amr12702547a12.5.1739888491339;
        Tue, 18 Feb 2025 06:21:31 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece1b5415sm8699308a12.4.2025.02.18.06.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:21:31 -0800 (PST)
Date: Tue, 18 Feb 2025 17:21:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philip Li <philip.li@intel.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Christoph Hellwig <hch@lst.de>,
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-riscv@lists.infradead.org
Subject: Re: fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x'
 is never less than zero.
Message-ID: <78ff844a-0fb4-42f6-b54f-4d19e14cfd05@stanley.mountain>
References: <202502171326.j4Xd3I0j-lkp@intel.com>
 <20250217092445.GA29568@lst.de>
 <a14347d2-6189-49bc-a1cc-e5959e76e6c2@ghiti.fr>
 <20250217131203.2657cc4b@pumpkin>
 <Z7PWuSA4jtZnxp5J@rli9-mobl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7PWuSA4jtZnxp5J@rli9-mobl>

On Tue, Feb 18, 2025 at 08:39:21AM +0800, Philip Li wrote:
> + Dan
> 
> Hi Dan,
> 
> On Mon, Feb 17, 2025 at 01:12:03PM +0000, David Laight wrote:
> > On Mon, 17 Feb 2025 13:06:49 +0100
> > Alexandre Ghiti <alex@ghiti.fr> wrote:
> > 
> > > Hi Christoph,
> > > 
> > > On 17/02/2025 10:24, Christoph Hellwig wrote:
> > > > On Mon, Feb 17, 2025 at 01:53:08PM +0800, kernel test robot wrote:  
> > > >> New smatch warnings:
> > > >> fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x' is never less than zero.  
> > > > Looks like this is an issue in the riscv virt_to_page implementation
> > > > which also shows up in various other places.  Any chance this could get
> > > > fixed in the riscv code?  
> > > 
> > > 
> > > To me, the only test that could give rise to this warning is the last 
> > > part of:
> > > 
> > > #define is_linear_mapping(x) \
> > >          ((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < 
> > > PAGE_OFFSET + KERN_VIRT_SIZE))
> > > 
> > > But given that the config is a 32-bit config, it should not be evaluated 
> > > at all.
> > > 
> > > Could that be a false-positive and then an issue in smatch?
> > 
> > Why is smatch even looking.
> > The equivalent check in gcc has been moved to -W2 because of all false positives.

The Smatch check is a bit more sophisticated than the GCC check...
I think if you removed the (!IS_ENABLED(CONFIG_64BIT) condition then
Smatch wouldn't trigger a warning here.  How would I duplicate this
warning?  The "ARCH=riscv make.cross" command does a 64bit build.

Screw it, I can just silence this warning based on that it's a kernel
build and the variable is called "_x".

regards,
dan carpenter


