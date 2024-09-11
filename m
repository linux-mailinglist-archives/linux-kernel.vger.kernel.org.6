Return-Path: <linux-kernel+bounces-325046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 293A3975434
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7961C227CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D519DFAC;
	Wed, 11 Sep 2024 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mzLFhP7e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5A192B96
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061640; cv=none; b=MeF0/hgOb4ctBkn8+qsAeDWQUhhcGuOSb17prSA0cULPCyFumd5Hpd+pXWbfGmPhI/E+KDFE7A1RDY8w8GlKd5usnvR3OeWawN0AuBeKqfapvau1jwhSTgrJHQp48G9p7VLROogB/zFs+9RYd3GU26dI1o38oiff7jqhyQE9OcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061640; c=relaxed/simple;
	bh=S+Ia/zxECBvBPZYwQIKdu5CtZUKuHOEcKkT7xlhAYjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCdB2tXqZvc3bwbzWkWrkbwqiK54huQUoBfVzj0MSdJlpxfrHjbLMO7seWwO+HaS6rUQ8jea6KJOyGotD/qy9Km5xrnKvAHoNSNRpIljbK+V20zDvFfoKwGpIluCfTLM4tG7uU/ZXIRStN9hT5gzs5EcybQpjLWUfQHOlQqpZao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=mzLFhP7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B63C4CEC5;
	Wed, 11 Sep 2024 13:33:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mzLFhP7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1726061636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BdM9xj7/mPtsf3ZvDEg8+iExeWNEsh58PhdMoqxt81E=;
	b=mzLFhP7ezZ072V+0TpGvVp1gL+h6LWPX3kw73iT8QqIyuqc3gkc0zzzVqxfGBhIG1Wai7/
	VE3AQX8GQIQhnQy5VjxKU1IVJF1DtH4qkyi6Mu2U4CMXD+ZzKE6ApD0nKuE9nfqn1W+/Me
	P0L8r9qEUBD5o70FL+l4AnDiRZvNFAE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 544c4a20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Sep 2024 13:33:56 +0000 (UTC)
Date: Wed, 11 Sep 2024 15:33:54 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Mark Brown <broonie@kernel.org>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>, adhemerval.zanella@linaro.org,
	linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] selftests: vDSO: don't include generated headers for
 chacha test
Message-ID: <ZuGcQnzUev6eAy0w@zx2c4.com>
References: <20240904155817.1153783-1-Jason@zx2c4.com>
 <fed980be-5082-4454-b696-6245d6a3d265@arm.com>
 <ZuEEIIV-J0mQVKE4@zx2c4.com>
 <974bdaba-6f99-4275-8b4e-f3e95d273ddd@sirena.org.uk>
 <ZuGRRp4j2qvUKxF7@zx2c4.com>
 <ZuGUpjOwE-f4YWUn@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuGUpjOwE-f4YWUn@zx2c4.com>

On Wed, Sep 11, 2024 at 03:01:26PM +0200, Jason A. Donenfeld wrote:
> On Wed, Sep 11, 2024 at 02:47:02PM +0200, Jason A. Donenfeld wrote:
> > On Wed, Sep 11, 2024 at 11:14:06AM +0100, Mark Brown wrote:
> > > On Wed, Sep 11, 2024 at 04:44:48AM +0200, Jason A. Donenfeld wrote:
> > > > On Tue, Sep 10, 2024 at 11:52:51PM +0100, Aishwarya TCV wrote:
> > > > > make[4]: *** [Makefile:299:
> > > > > /tmp/kci/linux/build/kselftest/kvm/aarch64/aarch32_id_regs.o] Error 1
> > > > > make[4]: Leaving directory '/tmp/kci/linux/tools/testing/selftests/kvm'
> > > 
> > > > You sure this bisected right? That directory isn't related to the
> > > > commit in question, I don't think...
> > > 
> > > I eyeballed it for Aishwarya and it looked related on first glance
> > > (messing around with the generated headers), though looking again it's
> > > only in the vDSO directory so shouldn't be messing up other
> > > directories...
> > 
> > Okay, so... I reproduced the problem on linux-next. Then I reverted the
> > commit and reproduced it again. Then just to be sure, I ran:
> > 
> >     $ git checkout v6.9 tools/testing/selftests/vDSO/
> > 
> > And then I reproduced the problem again.
> > 
> > So I think we can be somewhat certain the unrelated directory is indeed
> > unrelated.
> 
> Ahhh, got it.
> 
> Running `$ rm tools/include/asm/sysreg-defs.h` fixes the problem. I'll
> look into a fix this afternoon.

I'll fix it up as follows:

diff --git a/tools/include/asm/asm-offsets.h b/tools/include/generated/asm-offsets.h
similarity index 100%
rename from tools/include/asm/asm-offsets.h
rename to tools/include/generated/asm-offsets.h
diff --git a/tools/include/asm/cpucap-defs.h b/tools/include/generated/asm/cpucap-defs.h
similarity index 100%
rename from tools/include/asm/cpucap-defs.h
rename to tools/include/generated/asm/cpucap-defs.h
diff --git a/tools/include/asm/sysreg-defs.h b/tools/include/generated/asm/sysreg-defs.h
similarity index 100%
rename from tools/include/asm/sysreg-defs.h
rename to tools/include/generated/asm/sysreg-defs.h
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 5bd30d745d42..86ebc4115eda 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -39,6 +39,7 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \

 $(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
+                                      -idirafter $(top_srcdir)/tools/include/generated \
                                       -idirafter $(top_srcdir)/arch/$(SRCARCH)/include \
                                       -idirafter $(top_srcdir)/include \
                                       -D__ASSEMBLY__ -Wa,--noexecstack


