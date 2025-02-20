Return-Path: <linux-kernel+bounces-522781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D04FA3CE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0C218939FE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B25113DDD3;
	Thu, 20 Feb 2025 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ejkXvjZg"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D68488
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013729; cv=none; b=ezZ97A4nWKTJ0YCsFOMJPSTKvDpZ8+T4q+pusZ0vk6addUzSh6ARx+b13N2q3w6SuCRxxZRFxeNWkQpLZ3fB8komPwWsQyGL42/AWVn1+DZSMfQQYvDnQj7u1PU87691mWVPQvXvGTTeOEKj6ibC1IbjIEsxGrSKIoTYxOUjDjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013729; c=relaxed/simple;
	bh=eyw0JcW/CqNobLrXjUl4G9RFciMPmuTS7MsI0U8C2Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU9+wM1QiFs31xV1vziPI8waoTF9l90l8toVDjDxceWTu+glvuuk2PDq8LPNk6EXR7XDIGNOdbO1ssD5oE/jiFCElROIst6hKTmqBVgiS08v7iPqK8Q4393R1fTk5apXe+ilJWdeRLWKzhtNtNHVFcBTNTE81s96ugU7BZbSQa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ejkXvjZg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2212222d4cdso69195ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740013728; x=1740618528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqlTouY13+ElHVb0g8qWT8IbN9r+Hv7TBtx53gmJZ+A=;
        b=ejkXvjZgzJokc4agSufBGJTq/KnMWOvB9oQ3huu5drwnlj2tOqmTIIg7l+N2Ob2/vx
         HyItYJmURw9rEmbR5/Tyt7cKGdezicphyH0wqHC3gei+YmAebhXAMjUmJfw9Wrkls9Ik
         +H6wRbcqZVSukWFCvPK0jVZy+nVmB8/6uP74msbQhkdtzt+uB0h2+8g2hXFzD0wRZqRD
         QvjDsPcLENFeN3ueWP+PNLljh12/yk75SIV0X66XYx3h14B287gIIw9peVzCiX19b/rV
         4iHPbbtR+58cXRRhPOJfMcUcuOaXGd2Eam6xJ1/ea2ftJr/PqoF08rPcrUQJQJXkyQxi
         i3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013728; x=1740618528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqlTouY13+ElHVb0g8qWT8IbN9r+Hv7TBtx53gmJZ+A=;
        b=qCa4caGLFXdEdNJ7+TCBsQvvqQrS2pd6+Uc0bHtKkzD5574UhP/aoQQgIfIsS3o8DW
         X3RQN3VOqEJyLL3Ql7Q3w27vf1LpF0QsI+cLEJRsWK4vRxrmnmFv+2/amX8b8Lf8MPkf
         0s8JaG/pkZ3H+4Iy6qnu4nip6QT+74DwuIN2WVo7B1KyW/kKZ/T/mCXWanZtGAFbClFV
         FCktQn5e0swejvaYmKBecv6QysUMqKK02TfojFuIRED0PNUYFSkRt6R0kiZfCLBj6saq
         ypb1dFSTZKV96pKi9hIBEOWoCtYw6yM5AUJUs5cwtrsRGWVHtl0xpk+W6zCp5f+JT0p5
         CYqw==
X-Forwarded-Encrypted: i=1; AJvYcCUHzqBVJ9TDNEGcafXxN02bFbgRvmqc8A5oUP53jRh0rz6sZuKa7O3eEuRFS5GdL9ED4ce1vRfoqLS9WUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxshgL50HR9SXVAxFk45HehIkKLXLfrymaUZy04z4y/gmCTK+UZ
	kt25MYYtRX8lt7q97mdHoHjcrm6aAmWtQWBJkSjLlL+eZyIOhz7RxSU/g1INWw==
X-Gm-Gg: ASbGncvDTtyikJLGRZFlBrxbNRDzVlv+aMNhWVExCN8Vc70FoU4w47PNm6x1ekObgRN
	CY1EM6VRpkvYAuUy6lXnq3Xv22kbTYBh4ptosDzexyaM9lPj/E0op9OyEyZH79M051Mvr2BaDq+
	t5myq0lICjkD2s+hlhe30a/K7SWFJ04OqL94rUYPO2lsegwJae+C+8c0823zcW5oipZrNMZ9qou
	Z2wgeBl/t8sXLnFXVzru/ohMUnxOygri7vcHspnSqsI2UqlCnmmuvqIN6p9OZkCp2hJgKSB0qVE
	rj5bQzocyl6ocQdvHd/8S9uZRDO9FrfCP9grpFpA3invOINb7J3/vw==
X-Google-Smtp-Source: AGHT+IHBCZai8rbFA4Rqq1UVJMpTYpXlGgtVYKfEUQXi147oPGSC9aAN6/e5rjvXREapJcLK8L3TrQ==
X-Received: by 2002:a17:902:d4cc:b0:21a:87e8:3897 with SMTP id d9443c01a7336-2218db4ed75mr1293055ad.4.1740013727466;
        Wed, 19 Feb 2025 17:08:47 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366882sm111350425ad.95.2025.02.19.17.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:08:46 -0800 (PST)
Date: Thu, 20 Feb 2025 01:08:41 +0000
From: Peilin Ye <yepeilin@google.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bpf@ietf.org,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yingchi Long <longyingchi24s@ict.ac.cn>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 8/9] selftests/bpf: Add selftests for
 load-acquire and store-release instructions
Message-ID: <Z7aAmYi5zaVIgRKR@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
 <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>
 <6976077bc2d417169a437bc582a72defd1dec3d4.camel@gmail.com>
 <Z6ugQ1bd0opoGRYg@google.com>
 <1d2d919ae6848e2cf80b81ffe5f94fd31b8ea6ae.camel@gmail.com>
 <Z6u4O930eIbAVVMZ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6u4O930eIbAVVMZ@google.com>

On Tue, Feb 11, 2025 at 08:51:07PM +0000, Peilin Ye wrote:
> > > > Nit: why is dummy_test() necessary?
> > > 
> > > It's just to make it clear when these tests are (effectively) skipped.

<...>

> > > Commit 147c8f4470ee ("selftests/bpf: Add unit tests for new
> > > sign-extension load insns") did similar thing in verifier_ldsx.c.
> > 
> > I see, thank you for explaining.
> > We do have a concept of skipped tests in the test-suite,
> > but it is implemented by calling test__skip() from the prog_tests/<smth>.c.
> > This would translate as something like below in prog_tests/verifier.c:
> > 
> > 	void test_verifier_store_release(void) {
> > 	#if defined(ENABLE_ATOMICS_TESTS) && defined(__TARGET_ARCH_arm64)
> > 		RUN(verifier_store_release);
> > 	#else
> > 		test__skip()
> > 	#endif
> > 	}
> 
> > The number of tests skipped is printed after tests execution.

I tried:

  void test_verifier_load_acquire(void)
  {
  #if __clang_major__ >= 18 && defined(ENABLE_ATOMICS_TESTS) && defined(__aarch64__)
          RUN(verifier_load_acquire);
  #else
          printf("%s:SKIP: Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/or JIT doesn't support load-acquire\n",
                 __func__);
          test__skip();
  #endif
  }

Then realized that I can't check __clang_major__ in .../prog_tests/*
files (e.g. I was building prog_tests/verifier.c using GCC).  I think
ideally we should do something similar to prog{,_test}s/arena_atomics.c,
i.e. use a global bool in BPF source to indicate if we should skip this
test, but that seems to require non-trivial changes to
prog_tests/verifier.c?

For the purpose of this patchset, let me keep dummy_test(), like what we
have now in verifier_ldsx.c.

Thanks,
Peilin Ye


