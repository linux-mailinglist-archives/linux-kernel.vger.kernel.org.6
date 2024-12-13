Return-Path: <linux-kernel+bounces-445454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D110A9F16A2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCD02886BE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E831EC009;
	Fri, 13 Dec 2024 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MJ8yG7O1"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAE81EBFF7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118976; cv=none; b=Ex61oJsmVDwfCUqJuHIjjH2a56JX9vma6G64Bf6ANQ0ajfeKile5crnTawmzlRDs6mtOhRkPCQYQQOAyF16400m/Rj7BZPoqlcflQvTJwS19rom2kCSalqXGfT1K2W29ub3l/4F4Ja0ks1Viu8LrHTwf4NoM7w/kaP0+vaKVnTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118976; c=relaxed/simple;
	bh=x2Rx4v4/pqy2IlfBdt0TguKqLkRZHaoNwvIMcPXKy1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=um2XeED6IA3bQ1qK0xbYdnCZYop/LTQRtwaVADgCMp1W0u3mn+U0l6d7i8YLrukVQWpICK43o82FT1tAkxZNv9CPeBHdLZXalSrOPpQIEjcs1E4kn6ckChrlroLtVmZLU6AUit/ZN/ysh1qzoTTRrLfNeVL6VtLW4blCqrJlOM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MJ8yG7O1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so1427877f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734118972; x=1734723772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GluOas93alLBBkKVZFU1+XKbFDOCY24Svu9E99bNf2I=;
        b=MJ8yG7O1uX6rSQxihUQsMwfxKy7Fykckyp8SqNlQ8DcFJq3kZ2Aaw+ypwBrwmYu8ZD
         s/jXqVEXaQXyJ73Lxqta8ReQVp5ezO1Qu1RFK3hOpiSEzuVwEm82nJqFLRb9shsXEu6S
         YuN1gQZro26Eh/WWT4QYlGX9oNUI2q6tbBHADii7pvkKOXDOeUv0Y/Pl9IrdrWbVTsRY
         i8AcxL64wGPR2BJj/6A2mF6Nj6HtM90euc+PnWOb3pwqlQxmyy7AFm77jGjn1seqEMRz
         LeveXOLIANFvJMqMShKSoa34EO7MfnrpS/dTZLFyW2uE/Y2A+vXxYRTUolpN0rlclqrq
         AuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734118972; x=1734723772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GluOas93alLBBkKVZFU1+XKbFDOCY24Svu9E99bNf2I=;
        b=IqNRkJ8xyDhCCicFZjh+SJn9RX3L+nbm1qk4Sy/yLqA1HP9OKL9SVlNC59sQke2q8m
         VHjyKv63uVleau02tywkCkHlSDCi8ce8/+5vbBRmPqZEEra84RUB5nil4oeWMjrsbu4/
         DobUvFyr0NUbJBXRwoB0S4qvOIxQrwpKY5dCniZ1dH5+3emljj8+X4shswK65M7bCdRE
         mE1JZKvjPgYkGXeTFz6wcTYter9MQhGKiQ8GBSdjU+StJON308+QIcqGAXlsTKKTmC6X
         B9k1mGoQ/CJispjyT77t1riWoy3ItxEJHJj49GhTFolb8DmiqlLVDtgEhCi8urbnUaGF
         FPMw==
X-Forwarded-Encrypted: i=1; AJvYcCWSjrb659oMHuchZ6eDpvHR9irlC42e/6wgr/pbzIrXqGuxKiM3bWRSxkKFgiG096AhjQ/fuZuGTCp6ZZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOg95/+ouWntTSNFatL0oKNj5Oq/MtyDh5DBXIifECHof0p2C
	pYiHFKYEZDNe8Aqs0Fun+zYO9TWabfYkmDAtmt5N1u3MuG1tB52mm4PQ/kP1Nkg1bPYAF60ky/C
	5A2I=
X-Gm-Gg: ASbGncvoS5JOg5Py18J1h0ccFG6GORuQQeX/vsWwI/1IZqZ8iRbOeCR2BogDcvjeUs4
	yIR5Td/n7Y71YNiI/q7QKHkG5amtP5zU1i5V7DGczw2jeBPIY8/YEnmkjy62S0lygZiESTw5ul9
	s6iX0YUbbHUSKQjuMXzrWPJxtwbJf3GXsAjTVXBtPxoMT9HO2Y5ax3jMC1i9m5UQy9IBmHcOWdk
	rBeAosu83zah6MByp6gxfuoG4j+PtUznCwJwyvlJ0E4Qw==
X-Google-Smtp-Source: AGHT+IEAUUjOElqRmvNa4K4PtmDB0+C2OQOumefOospDww8TdhIC4vvQY//WTBrbfTwBslRD3kDWZQ==
X-Received: by 2002:a5d:584b:0:b0:386:3afc:14a7 with SMTP id ffacd0b85a97d-387887e24c5mr6782955f8f.7.1734118972186;
        Fri, 13 Dec 2024 11:42:52 -0800 (PST)
Received: from localhost ([152.250.153.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fa218bsm3542556a91.35.2024.12.13.11.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 11:42:51 -0800 (PST)
Date: Fri, 13 Dec 2024 16:42:49 -0300
From: "Ricardo B. Marliere" <rbm@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Hawley <warthog9@eaglescrag.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ktest: Check kernelrelease return in get_version
Message-ID: <bhzxnyiyktfkqqrb53xc2jfyubegljy7fc5bc5lksm7txs5cpi@lp7crc2tlstv>
References: <20241205-ktest_kver_fallback-v1-1-8029b9189527@suse.com>
 <20241205144807.6962b57a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205144807.6962b57a@gandalf.local.home>

Hi Steve!

On  5 Dec 24 14:48, Steven Rostedt wrote:
> On Thu, 05 Dec 2024 16:20:50 -0300
> "Ricardo B. Marliere" <rbm@suse.com> wrote:
> 
> > In the case of a test that uses the special option ${KERNEL_VERSION} in one
> > of its settings but has no configuration available in ${OUTPUT_DIR}, for
> > example if it's a new empty directory, then the `make kernelrelease` call
> > will fail and the subroutine will chomp an empty string, silently. Fix that
> > by adding an empty configuration and retrying.
> > 
> > Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> > ---
> > Hi! I'm not sure if this is the best fix, but here's the gist of the
> > problem:
> > 
> > If the test has something like:
> > POST_BUILD = echo ${KERNEL_VERSION}
> > 
> > Then the option will be evaluated in __eval_option which calls get_version
> > before there's any configuration within ${OUTPUT_DIR}. Like if the
> > following happened:
> > 
> > 16:08:09 rbmarliere@opensuse ~/src/linux/kernel/master master
> > $ git clean -fdx
> > Removing build/
> > 16:08:13 rbmarliere@opensuse ~/src/linux/kernel/master master
> > $ make O=build/ kernelrelease
> > make[1]: Entering directory '~/src/linux/kernel/master/build'
> > ~/src/linux/kernel/master/Makefile:777: include/config/auto.conf: No such file or directory
> > make[1]: *** [~/src/linux/kernel/master/Makefile:251: __sub-make] Error 2
> > make[1]: Leaving directory '~/src/linux/kernel/master/build'
> > make: *** [Makefile:251: __sub-make] Error 2
> > ---
> >  tools/testing/ktest/ktest.pl | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> > index dacad94e2be42a86f9680fcb50b65d1f3a78afb5..a57b6cb9d817e2a3351a64de96092bd47733f5e3 100755
> > --- a/tools/testing/ktest/ktest.pl
> > +++ b/tools/testing/ktest/ktest.pl
> > @@ -2419,6 +2419,11 @@ sub get_version {
> >      return if ($have_version);
> >      doprint "$make kernelrelease ... ";
> >      $version = `$make -s kernelrelease | tail -1`;
> > +    if (!$version) {
> 
> That should probably instead be:
> 
> 	if (!length($version)) {
> 	[..]

Indeed, that is better. I sent a v2 but forgot to reply this one.
Anyways, thanks for reviewing! :)

-	Ricardo.


> 
> -- Steve
> 
> 
> > +	run_command "$make allnoconfig" or return 0;
> > +	doprint "$make kernelrelease ... ";
> > +	$version = `$make -s kernelrelease | tail -1`;
> > +    }
> >      chomp($version);
> >      doprint "$version\n";
> >      $have_version = 1;
> > 
> > ---
> > base-commit: 9d6a414ad31e8eb296cd6f2c1834b2c6994960a0
> > change-id: 20241205-ktest_kver_fallback-d42e62fb8d88
> > 
> > Best regards,
> 

