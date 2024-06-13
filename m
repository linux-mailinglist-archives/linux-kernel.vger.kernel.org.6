Return-Path: <linux-kernel+bounces-213350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1054907415
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D791F2362C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD911459EC;
	Thu, 13 Jun 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SDWbPVRe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5384D1428F5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286142; cv=none; b=GJsPWD7dCw5vawr/lIGRtwNzxvetmq4PQziVah9/DhOd40DU/VuoK9XkgAEnDouHHgZP1hVMd9CQtCUIuMaVXzKrpeovKBGyXmA4hKR28MF1piQ/pOe+8b3zIRDYskOhD8WZdV5cPgEydIXqXs9hBchKOzwXYP/2psialKQCCVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286142; c=relaxed/simple;
	bh=qybj4kTNkAom9T8KJOd5ib0qCqBjwxZEWgukBBToPfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJClDs4YPm5DJzdMOowEo0FrBe/pgsifP8827bWd5W1k41HGuAvt7i38A6EhhG0qwaIzj1XjzohP+oDAwJJX70c/ql86TyxIBwRoH2kOw4XYHLo3r5b0DdpA2WJL13fvmg72M2qqj69gQHEn668hj9OY1FlM5IoRReZ/Tn5FJ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SDWbPVRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1C6C4AF1A;
	Thu, 13 Jun 2024 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718286141;
	bh=qybj4kTNkAom9T8KJOd5ib0qCqBjwxZEWgukBBToPfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDWbPVReyj0w+2/jm+UGM5juXWMlKFdZYCYcxU6WlAR4en0p8iFahz4fSmccnr+3h
	 zYsitfb2fwMQ3EuClrUOmEMjMVAq+vRwIf0YkPgKP0BmIfT68RjwGgeCGpTGBaWcUN
	 TMmn5aDR9KLnGUw2Uvoq4DcM/KfQRKRHgDEd40qU=
Date: Thu, 13 Jun 2024 15:42:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] binder_alloc: replace kcalloc with kvcalloc to mitigate
 OOM issues
Message-ID: <2024061359-deniable-boundless-96c3@gregkh>
References: <20240611085629.25088-1-liulei.rjpt@vivo.com>
 <2024061216-faster-cufflink-ceac@gregkh>
 <39eaba63-0e18-439a-82ac-834505e6473e@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39eaba63-0e18-439a-82ac-834505e6473e@vivo.com>

On Thu, Jun 13, 2024 at 08:01:39PM +0800, Lei Liu wrote:
> On 2024/6/12 17:58, Greg Kroah-Hartman wrote:
> > On Tue, Jun 11, 2024 at 04:56:28PM +0800, Lei Liu wrote:
> > 
> > > In binder_alloc, there is a frequent need for order3 memory
> > > allocation, especially on small-memory mobile devices, which can
> > > lead to OOM and cause foreground applications to be killed,
> > > resulting in flashbacks. We use kvcalloc to allocate memory, which
> > > can reduce system OOM occurrences, as well as decrease the time and
> > > probability of failure for order3 memory allocations. Additionally,
> > > it can also improve the throughput of binder (as verified by
> > > Google's binder_benchmark testing tool). We have conducted multiple
> > > tests on an 8GB memory phone, and the performance of kvcalloc is
> > > better. Below is a partial excerpt of the test data. throughput =
> > > (size * Iterations)/Time Benchmark-kvcalloc Time CPU Iterations
> > > throughput(Gb/s)
> > > ----------------------------------------------------------------
> > > BM_sendVec_binder-4096 30926 ns 20481 ns 34457 4563.66↑
> > > BM_sendVec_binder-8192 42667 ns 30837 ns 22631 4345.11↑
> > > BM_sendVec_binder-16384 67586 ns 52381 ns 13318 3228.51↑
> > > BM_sendVec_binder-32768 116496 ns 94893 ns 7416 2085.97↑
> > > BM_sendVec_binder-65536 265482 ns 209214 ns 3530 871.40↑
> > > Benchmark-kvcalloc Time CPU Iterations throughput(Gb/s)
> > Both benchmarks are the same? Or is this labeled incorrectly?
> I'm really sorry, I got the title of the table wrong, here are the updated
> data:
> throughput = (size * Iterations)/Time
> kvcalloc->kvmalloc:
> Benchmark-kvcalloc    Time    CPU    Iterations    throughput(Gb/s)
> ----------------------------------------------------------------
> BM_sendVec_binder-4096    30926 ns    20481 ns    34457    4563.66↑
> BM_sendVec_binder-8192    42667 ns    30837 ns    22631    4345.11↑
> BM_sendVec_binder-16384    67586 ns    52381 ns    13318    3228.51↑
> BM_sendVec_binder-32768    116496 ns    94893 ns    7416    2085.97↑
> BM_sendVec_binder-65536    265482 ns    209214 ns    3530    871.40↑
> 
> kcalloc->kmalloc
> Benchmark-kcalloc    Time    CPU    Iterations    throughput(Gb/s)
> ----------------------------------------------------------------
> BM_sendVec_binder-4096    39070 ns    24207 ns    31063    3256.56
> BM_sendVec_binder-8192    49476 ns    35099 ns    18817    3115.62
> BM_sendVec_binder-16384    76866 ns    58924 ns    11883    2532.86
> BM_sendVec_binder-32768    134022 ns    102788 ns    6535    1597.78
> BM_sendVec_binder-65536    281004 ns    220028 ns    3135    731.14

Great, can you please resend this as a new version?

thanks,

greg k-h

