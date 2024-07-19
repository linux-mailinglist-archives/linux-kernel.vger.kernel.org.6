Return-Path: <linux-kernel+bounces-257405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9F5937978
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12221C21C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78747145FE2;
	Fri, 19 Jul 2024 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8Ho4lTj"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE51459E8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401279; cv=none; b=rWf+93oYzDuYi348pu2WWexcAbZR1Ex/UadWahpEcV+7yhOx+GrNAiIq3vYb724uPgOQTi2A2IBxSCbqAX29xQ7PbauC7ZMgAB7t8EpAzgDrPa94wn7AcOFEByKCkdQdRjdasrpZBsezMr9JWFBMyX0LNIhJy8D/883Dkf1cBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401279; c=relaxed/simple;
	bh=KuhyRNYiQOsMD9uVwVQKbgaa8iImiENmrau0Q+S6+UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rN3DU8YaYBeS3k0sItLtfu0Oy+m/NqpfWny7mChdNfcqbGkGWZwGglGK+Hq3Od94spfvOMAIvJCqsuB52AbpqZe99lIWJVZWX3n2hnP/dpA/4JLAjSryINJuSmyydcAYNQGVS0FYLXFShKvv9ir+TIt/3GJvgGItcG3kxyjco7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y8Ho4lTj; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-704466b19c4so925747a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721401277; x=1722006077; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d09pK5Z153QW43MBJnSDLh9gt6xvQSEMp8AzIbeAon8=;
        b=Y8Ho4lTjRdOABSjbj/lv7KcLcrYsyAvQdrRKL5UTf8IkQXLabEutq9R/sCzGFhVF4b
         vi8J+uD1fGqjB0LcLGowCbltvkip5zPDL/R9tv1E2+8Jfllxn+tGVEAW89TVgP0+ATfP
         JPWeqy3uPpYo+N8BA51nQKR06G45HXqvCqTwmD+yyOYp/78+li8ShZtYtbmoELu2GzX/
         1Wg4Zax5lWUFXF7ImZdZw6zOu2OYm9XmDFqprRIvpk7GxdOADBeQqDMSIt6HZvWdRILF
         VI4GYD1qgzZnh7mWO6jxRTSvZtHkeBPnvz68vYl7GzYHz/IQ8C2UMvoVxHNgC7AhtZ6F
         xKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721401277; x=1722006077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d09pK5Z153QW43MBJnSDLh9gt6xvQSEMp8AzIbeAon8=;
        b=SEhv3FXQMk/cLRuiZOeLrkaUWS4d0naAqLkEL5Fx5j0b359kz/iW2rUv2pQIgAL3YX
         l8A26dhP2H6lC6zDFpDkdQ1AXt+tj0B616Y8iu65BUMnhsbrcQgb2n85GxUG0b8a2TaL
         Oueo18ZOco9rLaULmaKfqyNAer2tThNXB7M2RO6RC40rToCHKHHIxa9veNt2CZd4sq+j
         OCBpCifqvlU00UmgAZz5tnkQBZMYNFhhhPktl2lR0eGjqRvSk+xxEdrHFE66ZDdTxSBs
         +RukCFu9OAXllStSZwLs1pwnGf291ay7y4jF+oE3AfBhBeLilj6rP6GeOoWnlROtVG4E
         t0mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtLFIq8nqwiEkUz17g3Fu+ALb2bByPxGSrXhwtheyCD+tKyWCM9eaRiavIhkq5DrolaIs7CwCoRpJtmKybn+Z8QyM/czhvWiPRwvx1
X-Gm-Message-State: AOJu0YyqoEvYMBwv7KCSfVirsa4Pd6ar3n0ubNRcV5fl5UrD4tWjIuTd
	z8544HEgMAsFEjppaCjvc6VUu/pf6xwryJS5t76qJxHL6VSN4+syv6ogomsFk7k=
X-Google-Smtp-Source: AGHT+IFquEw1LuWhCKULULNOl3hedfOISNuV3QnHLqnr5dFTZd5RpbSyMPE4Fv19rwezAPp3fzg52A==
X-Received: by 2002:a05:6830:65c1:b0:703:6ca6:27 with SMTP id 46e09a7af769-708e78596b0mr9660148a34.16.1721401276837;
        Fri, 19 Jul 2024 08:01:16 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:4528:a9e:1eaf:80c5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f617399csm311885a34.60.2024.07.19.08.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:01:16 -0700 (PDT)
Date: Fri, 19 Jul 2024 10:01:14 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Max Dubois <makemehappy@rocketmail.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	Dan Carpenter <error27@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug related with a 6.6.24 platform/x86 commit signed by you -
 Enormous memory leak
Message-ID: <f055fd4d-7ee7-40b9-a394-5cc8bfe52c97@suswa.mountain>
References: <707784492.392759.1721383145890.ref@mail.yahoo.com>
 <707784492.392759.1721383145890@mail.yahoo.com>
 <3bd6b12c-533c-4b6d-bc91-696db8837b3e@oracle.com>
 <20240719142037-93bd4395-1f6b-490a-8a14-50e7bcc756d1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240719142037-93bd4395-1f6b-490a-8a14-50e7bcc756d1@linutronix.de>

On Fri, Jul 19, 2024 at 02:32:15PM +0200, Thomas Weißschuh wrote:
> On Fri, Jul 19, 2024 at 05:34:23PM GMT, Harshit Mogalapalli wrote:
> The reporting really should figure out which specific release or commit
> is introducing the issue. And if mainline or 6.6.41 are also affected.
> 
> The linked gentoo forum thread has some actual kernel logs:
> 
> Jul 16 00:01:10 [kernel] alloc_vmap_area: 133 callbacks suppressed
> Jul 16 00:01:10 [kernel] vmap allocation for size 20480 failed: use vmalloc=<size> to increase size
>                 - Last output repeated 9 times -
> Jul 16 00:01:15 [kernel] alloc_vmap_area: 240 callbacks suppressed
> Jul 16 00:01:15 [kernel] vmap allocation for size 20480 failed: use vmalloc=<size> to increase size
>                 - Last output repeated 9 times -
> Jul 16 00:01:17 [kernel] warn_alloc: 3 callbacks suppressed
> Jul 16 00:01:17 [kernel] Web Content: vmalloc error: size 8192, vm_struct allocation failed, mode:0xdc0(GFP_KERNEL|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
> Jul 16 00:01:17 [kernel] CPU: 1 PID: 2761 Comm: Web Content Not tainted 6.6.38-gentoo #1
> Jul 16 00:01:17 [kernel] Hardware name: VMware, Inc. VMware20,1/440BX Desktop Reference Platform, BIOS VMW201.00V.21805430.B32.2305221830 05/22/2023
> Jul 16 00:01:17 [kernel] Call Trace:
> Jul 16 00:01:17 [kernel]  dump_stack_lvl+0x32/0x41
> Jul 16 00:01:17 [kernel]  dump_stack+0xd/0x10
> Jul 16 00:01:17 [kernel]  warn_alloc+0xab/0x111
> Jul 16 00:01:17 [kernel]  __vmalloc_node_range+0x73/0x345
> Jul 16 00:01:17 [kernel]  __vmalloc_node+0x55/0x5d
> Jul 16 00:01:17 [kernel]  ? bpf_prog_alloc_no_stats+0x1f/0xcd
> Jul 16 00:01:17 [kernel]  __vmalloc+0x14/0x16
> Jul 16 00:01:17 [kernel]  ? bpf_prog_alloc_no_stats+0x1f/0xcd
> Jul 16 00:01:17 [kernel]  bpf_prog_alloc_no_stats+0x1f/0xcd
> Jul 16 00:01:17 [kernel]  bpf_prog_alloc+0x13/0x9f
> Jul 16 00:01:17 [kernel]  bpf_prog_create_from_user+0x47/0xbd
> Jul 16 00:01:17 [kernel]  ? kprobe_free_init_mem+0x4c/0x4c
> Jul 16 00:01:17 [kernel]  do_seccomp+0x176/0x7ac
> Jul 16 00:01:17 [kernel]  ? __ia32_sys_prctl+0x47/0x5bf
> Jul 16 00:01:17 [kernel]  __ia32_sys_seccomp+0x10/0x12
> Jul 16 00:01:17 [kernel]  ia32_sys_call+0xd09/0x1063
> Jul 16 00:01:17 [kernel]  __do_fast_syscall_32+0x7a/0x99
> Jul 16 00:01:17 [kernel]  do_fast_syscall_32+0x29/0x5b
> Jul 16 00:01:17 [kernel]  do_SYSENTER_32+0x15/0x17
> Jul 16 00:01:17 [kernel]  entry_SYSENTER_32+0x98/0xf8
> Jul 16 00:01:17 [kernel] EIP: 0xb7fc856d
> 
> The lines with "size 20480" repeat *a lot*, it could be the issue.
> 

The interesting thing about that is the working kernel had tons of these
allocation failures as well.
https://bugzilla.kernel.org/show_bug.cgi?id=219061
See the attachment which called "This is a session with the last WORKING
KERNEL 6.6.23, NO ERRORS, everything fine".

I don't think the problem is Harshit's patch.  It should be easy enough
to do a `git show 9a98ab01e3ac | patch -p1  -R` and test the results.
If that doesn't fix the bug, then it would be nice to do a git bisect
between v6.6.23 and v6.6.24.

regards,
dan carpenter



