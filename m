Return-Path: <linux-kernel+bounces-383711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5829B1F65
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F934B20FBD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0304D16FF45;
	Sun, 27 Oct 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUG8Wn3M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410627466
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730049880; cv=none; b=hSd3iKpUtQmxuGEFFeHjGMLU6n68WLEBK2sTAdcrgDd5W1jysSPYp0PVfM1PMk7qfBKT3cQuVcqY1Cso+d4h6xT9b88kG2iODzj3miHEWyKT6fRwLqbb2lTZP9GrcQIxrayPqI3X6cwWqQsZwQBMkw9N/eFDs2xf30c2tYN1CoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730049880; c=relaxed/simple;
	bh=zhVGBVUvdv5n44mB2wEPT5OL2UEmLnnvAOHar/u2w1c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0IR1Lc6tNphbiUYCmDxfNeg2KHEnAMY/vAfdw7/N+mArsoHbMCSWQnKrreYXsruEINNqKj6dHKpUlgP0M2YunC1fWWjLlEvj84SFoiGPuW1VKcOCG9tur71PpymG2V3w3gkIJyheBnl3keYxctuKJ6ZSM4F8eeVfOs6PWGHZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUG8Wn3M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730049877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oKr50uLSi3qbyn6NnQwGUQ1OqmR3FtuQutM4PWASyVU=;
	b=NUG8Wn3MW4TTkst0+/v3NaeLXJZDsjtKrUX9YM0N/ead9BxRIeVo+thn6NGRb60O3ejbOC
	s7rZHvQp7CNVDV6Zt5vAEcfmDisO/YN2TaqNIV+D04muO6VHLstAcKr4M+w3B8iLWJCqcq
	mde35Vu1GV6OpjUFdt5kxP3D7qqAy0o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-jzk2n5YRNhqIfRxgeODhTg-1; Sun, 27 Oct 2024 13:24:36 -0400
X-MC-Unique: jzk2n5YRNhqIfRxgeODhTg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e2eba0efc6so3636457a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 10:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730049875; x=1730654675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKr50uLSi3qbyn6NnQwGUQ1OqmR3FtuQutM4PWASyVU=;
        b=vS047K61A0dg23HcOMNF0MDPGMMwvgsl2b/zRU8IGQl58wEsxAmT2mHUM0CSaEaf5z
         KVYZnKWsMN07ekM214OcbsqTr05us94kPnyTDerC97X8lCqXIm9qLUutD3KVMytfJ0Na
         dIXi088yBg6qlPMAVtcunXv3bqnVYjutOG13To+ue4nwFAZ0RMMI6d6HJOaJKrY5r7zN
         O6T70+dSKDpTlgCzeq41AXGjtcgErvnzMCPjr+MdfPVguhy5oIoWTITEjIRLdX1N9P34
         Ux4lUG/3lWVOsp2Gz8fJOJqXNNitCP4GJy+nYLyPt43Xtj2svyvnfmLcG8cwDZYE6q4M
         zbPw==
X-Forwarded-Encrypted: i=1; AJvYcCWRRIKpqKX2J+7spSzpkOCmRNRvQ48JAXelpu7vhtZvLa1z9vzOdz/qdqr5Z4D4uHGV6Vjf6vhb2qZ+UQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7MaV134XXsNMVbp2DxHZp8pHeDqhf9DiWQuVUT1M6O2Yzs9n
	NNTnOWNoG5Z/IK3i8OUoewq1u6coU5NjFsFdhy9uq/SKT2ktq8q5/OdY0jHGuVqumGbe1I7lOct
	Rv+GpVXG2sbIyVnVDPsFFQdn6wjefnL2NPOx5yJ9TV/cfqRZESEGuswq97z2LiQ==
X-Received: by 2002:a17:90b:1d89:b0:2d8:3fe8:a195 with SMTP id 98e67ed59e1d1-2e8f0f53d9dmr7801776a91.4.1730049874820;
        Sun, 27 Oct 2024 10:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe+3d9HBdJOxMCmo51cWugL7SDRTWmCgDMsRin/SjlPT/YU/GdVOSAVPjeVeYYGsQojJUnHQ==
X-Received: by 2002:a17:90b:1d89:b0:2d8:3fe8:a195 with SMTP id 98e67ed59e1d1-2e8f0f53d9dmr7801761a91.4.1730049874473;
        Sun, 27 Oct 2024 10:24:34 -0700 (PDT)
Received: from treble.attlocal.net ([2600:1700:6e32:6c00::3e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e56f468sm7388597a91.41.2024.10.27.10.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 10:24:33 -0700 (PDT)
From: Josh Poimboeuf <jpoimboe@redhat.com>
X-Google-Original-From: Josh Poimboeuf <jpoimboe@kernel.org>
Date: Sun, 27 Oct 2024 10:24:30 -0700
To: Jens Remus <jremus@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <20241027172430.h6xvamrauxmwccx7@treble.attlocal.net>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <a5c67047-94d9-482b-892b-ef1662d2fe65@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5c67047-94d9-482b-892b-ef1662d2fe65@linux.ibm.com>

On Wed, Oct 23, 2024 at 03:22:35PM +0200, Jens Remus wrote:
> We are looking forward to implement support for unwinding of user space
> using SFrame in kernel/perf on s390. One major concern is that your x86
> implementation currently relies on a fallback to unwinding using frame
> pointer. On s390 unwinding using frame pointer is unsupported, because
> of lack of proper s390x ABI [1] specification and compiler support. In
> theory there would be a s390-specific alternative of unwinding using
> backchain (compiler option -mbackchain), but this has limitations and
> there is currently no distribution where user space is built with
> backchain.
> 
> How much of an issue would it be if s390 could not provide an unwinding
> fallback implementation? Do you see the possibility to get away without?

No problem, I'll make the fallback dependent on CONFIG_HAVE_UNWIND_USER_FP.

> For s390 support of unwinding using SFrame we would need to make a few
> changes to your generic unwinding framework in the kernel:

Also no problem, I'm sure there will need to be tweaks going forward.

Thanks for looking at it!  v3 will be posted soon.

-- 
Josh


