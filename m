Return-Path: <linux-kernel+bounces-392884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051BA9B9946
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A5C284555
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069ED1D279D;
	Fri,  1 Nov 2024 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VkE7DZG7"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50019D089
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492134; cv=none; b=S95xyPaHs6vI9iQJGwh5/4NozTVPk2r7FnAx5gj3InmAba+cVUyEQILs6F71kWPmqVUTkzbnwTn3GCrLfKqBOQLsE4R4yVN8iGV6ptFRCwwlJCdUVOWuiP8I8XPxRS8Rx1wu+u4QktZ+w/J5BlHd/4daSkm4sb1mGQuItLH2QeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492134; c=relaxed/simple;
	bh=KojzClBS51NXZHtfP/ssEPl81S3kAgFdoobwtV9/FUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaKMIbIc3YUSrmebuGzcrOMtCyrbs/dRaIee3PgqbFizPPHBFTpliMqkOkFzoN9oMBQIYv54EVJZ19rPF2S8FOjttjtzLTxZM6Od9Zm8u1rfxAZhJ+xQWYedW8CcXpLwAlVDuKoeoJqg38pL15vTMjkoMYLxgLXuxu86z2AT5xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VkE7DZG7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso1628059a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730492132; x=1731096932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rOWj5wq1SGCaCslB1TWBLOjmfXZ4GP9FgmX1YHf/NE=;
        b=VkE7DZG7bce/7rzDqfgjd5v6gbe0xL3pHMErjgPQSgLnHfYJ8Twqdt7N0w7x9p/GxC
         yeF3Cb0VSlusfkQEcgIl/EQpQ7Oyg8peMEhOkOCqig36yMlaZDpzlOOyzKUaqKQzSJck
         ZShtvq9BGrYanVAb179nR+AfPE59ZQGhXkgE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730492132; x=1731096932;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rOWj5wq1SGCaCslB1TWBLOjmfXZ4GP9FgmX1YHf/NE=;
        b=A2/S3agcVUGP4Rgf9EUCNTZb5kbVhehCh0eXS3OpgxUFfigMmce7hjRW4k2WOMxksr
         mRCCSGJRu3on4xLxjYxzTTJR7Va2+25rh+dlHEbfnlyLIrsohWrYSAQQjNFMJpKBqe6D
         o0Eqd49BhI8riQQgiB2LfpiNEeQwdttbJbs3he5clTZusLja669h2ozbb2cK7ynOD3fq
         W+Pe++163tK2ug7b9ECyrsWoYg4EfO6kmnNtSLGjAjB0li3Y9+zW9DZ4E/zAGrERPjMb
         cgKNrXFWD1kN32559uFtJEoiovkmVTQ7tWYzrONokxT1ImV7tNCkUl5P8/uAlYHpKeoa
         HU/w==
X-Forwarded-Encrypted: i=1; AJvYcCU6VbsfGn0qAK32gjF6g7oOoPZaSMNT5SjMaEKgbZj/OazJ6HA1CN3EhsSm0fDXLI6HbIjZCeNzAs9Q5N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW9xBkrHKiXsVkFtDcHAm2IrZPom/u7ufKsHyOwpCepcsWyzpi
	t8FPwXMUmAqvMo2o8VYe/n36JZSLqpkD/ERPO2WGzWYXJEDx+K3H6XfFNJncH3A=
X-Google-Smtp-Source: AGHT+IGLQMQLNv4xaq8DqBOYiAGWYiXP+moKivQ5tFF9FFk0WRRRqQkt0/6YXC6frC7khIREMn44nQ==
X-Received: by 2002:a17:90b:2e42:b0:2e9:4967:244 with SMTP id 98e67ed59e1d1-2e94c2e4c29mr6924981a91.24.1730492131974;
        Fri, 01 Nov 2024 13:15:31 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa2603fsm5316018a91.17.2024.11.01.13.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 13:15:31 -0700 (PDT)
Date: Fri, 1 Nov 2024 13:15:28 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v3 6/7] selftests: net: Add busy_poll_test
Message-ID: <ZyU24Kogy3HlzNqx@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com, namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20241101004846.32532-1-jdamato@fastly.com>
 <20241101004846.32532-7-jdamato@fastly.com>
 <20241101063426.2e1423a8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101063426.2e1423a8@kernel.org>

On Fri, Nov 01, 2024 at 06:34:26AM -0700, Jakub Kicinski wrote:
> On Fri,  1 Nov 2024 00:48:33 +0000 Joe Damato wrote:
> > +	ip netns exec nscl nc -N 192.168.1.1 48675 < $tmp_file
> 
> Thanks a lot for adding the test.

Thanks for the review.

> Could you replace nc with socat or
> a similar tool? There are multiple incompatible implementations of
> netcat packaged by various distros, we get:
> 
> # selftests: net: busy_poll_test.sh
> # nc: invalid option -- 'N'
> # Ncat: Try `--help' or man(1) ncat for more information, usage options and help. QUITTING.
> 
> nc is a known PITA.

OK, I've replaced with socat for the v4 I am working on. I've also
added some additional documentation to the FAQ in the cover letter
and the kernel documentation to help answer Sridhar's question
because it may be a question others have as well.

> > +	# set the suspend parameter for the server via its IFIDX
> > +
> > +	DUMP_CMD="${YNL_PATH} --spec ${SPEC_PATH} --dump napi-get --json=\"{\\\"ifindex\\\": ${NSIM_DEV_1_IFIDX}}\" --output-json"
> > +	NSIM_DEV_1_NAPIID=$(ip netns exec nssv bash -c "$DUMP_CMD")
> > +	NSIM_DEV_1_NAPIID=$(echo $NSIM_DEV_1_NAPIID | jq '.[] | .id')
> > +
> > +	SUSPEND_CMD="${YNL_PATH} --spec ${SPEC_PATH} --do napi-set --json=\"{\\\"id\\\": ${NSIM_DEV_1_NAPIID}, \\\"irq-suspend-timeout\\\": 20000000, \\\"gro-flush-timeout\\\": 50000, \\\"defer-hard-irqs\\\": 100}\""
> > +	NSIM_DEV_1_SETCONFIG=$(ip netns exec nssv bash -c "$SUSPEND_CMD")
> 
> Can you try to run this test in installed mode?
> 
> https://docs.kernel.org/dev-tools/kselftest.html#install-selftests
> 
> IIRC YNL moves around when we install, you'd either need to do
> autodetection of the path (see tools/testing/selftests/net/lib/py/ynl.py
> and if you go down this route please move the helper which exports the
> YNL variables to lib.sh so other tests can reuse); or teach the C code
> to do the setup, you can link against YNL fairly easily (look at where
> ncdevmem is added in the Makefile, it uses YNL)

I think I'm going to go the C route.

Just to make sure I'm following how to do this properly:
  - I've added busy_poller to YNL_GEN_FILES (and removed it from
    TEST_GEN_FILES)
  - It still needs to be run via the script (which sets up netdevsim
    etc), so I am leaving that script (busy_poll_test.sh) in
    TEST_PROGS. busy_poller is not intended to be run on its own for
    selftest purposes.

I am not sure if YNL_GEN_FILES are expected to run standalone when
invoked or if this will work as I expect it to (busy_poll_test.sh is
run):

  [...]
  TEST_PROGS += busy_poll_test.sh
  
  # YNL files, must be before "include ..lib.mk"
  YNL_GEN_FILES := ncdevmem busy_poller
  [...]

Doing the above: I am hoping that busy_poll_test.sh will be run
(which will use busy_poller) and that busy_poller won't be run on
its own.

Thanks for the guidance.

