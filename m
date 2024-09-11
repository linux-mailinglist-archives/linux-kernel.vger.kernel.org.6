Return-Path: <linux-kernel+bounces-324928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13769752D1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F931C21E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BE4195FEF;
	Wed, 11 Sep 2024 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JoKd3Fhw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A9185923
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058830; cv=none; b=jwMLxCzOb6pxqxMGKWqTHFBOPfBsfbGIX6M05ko4BfYDihG1itFQM5zSlo7CbM+19YYb5168P2c86VXSD64lDmqCR5dY2xC7Fts+7KsBXVwJUB9YQsVuMOZ+KoNOa3oq44urTo4Vx/Mu5CANejll8GTToew8ol2JPxaiP/8QneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058830; c=relaxed/simple;
	bh=5MbmYEAq+EvL6pAu/hj+08vVatOHdsVWwq0ZX9Jmbt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXNIHPZc85f1XYFThLM2U8R84MBIFd9sofFBhJEDeF0wMpaVcgoKHSJqNC2DxQ+R29OCWkHGYvhTFF6PSwdd+uPB88/Fa3DK0+2Bcvgd0x2hgmmvy2jKQXcUZxDonctXn4MZz1bfnotKmOB28Gw3B5fQ4OhDhAHQBOtWGUhCiqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=JoKd3Fhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8ADC4CECE;
	Wed, 11 Sep 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JoKd3Fhw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1726058825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2pT/bnzl+G4bkdNVAxKs2I0ZCwyUxAkuSjW+lefK1eg=;
	b=JoKd3FhwdcFwHLk9H1CqDe9IKnlmeFOJszEMKuhudCnn0Tzuh7R4zFvRdrTzuxtu4e9zIi
	55WUEL0dMW44WEtlGxcwHgg+KJwYjp1MXXHA4WdMvi2J0YM8sU21lgsjWY6XVE3cKo0fbV
	lnMPeO3bRhIYooGf8dy4UV9NwSSi0g0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 775ab41d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Sep 2024 12:47:04 +0000 (UTC)
Date: Wed, 11 Sep 2024 14:47:02 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Mark Brown <broonie@kernel.org>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>, adhemerval.zanella@linaro.org,
	linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] selftests: vDSO: don't include generated headers for
 chacha test
Message-ID: <ZuGRRp4j2qvUKxF7@zx2c4.com>
References: <20240904155817.1153783-1-Jason@zx2c4.com>
 <fed980be-5082-4454-b696-6245d6a3d265@arm.com>
 <ZuEEIIV-J0mQVKE4@zx2c4.com>
 <974bdaba-6f99-4275-8b4e-f3e95d273ddd@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <974bdaba-6f99-4275-8b4e-f3e95d273ddd@sirena.org.uk>

On Wed, Sep 11, 2024 at 11:14:06AM +0100, Mark Brown wrote:
> On Wed, Sep 11, 2024 at 04:44:48AM +0200, Jason A. Donenfeld wrote:
> > On Tue, Sep 10, 2024 at 11:52:51PM +0100, Aishwarya TCV wrote:
> > > make[4]: *** [Makefile:299:
> > > /tmp/kci/linux/build/kselftest/kvm/aarch64/aarch32_id_regs.o] Error 1
> > > make[4]: Leaving directory '/tmp/kci/linux/tools/testing/selftests/kvm'
> 
> > You sure this bisected right? That directory isn't related to the
> > commit in question, I don't think...
> 
> I eyeballed it for Aishwarya and it looked related on first glance
> (messing around with the generated headers), though looking again it's
> only in the vDSO directory so shouldn't be messing up other
> directories...

Okay, so... I reproduced the problem on linux-next. Then I reverted the
commit and reproduced it again. Then just to be sure, I ran:

    $ git checkout v6.9 tools/testing/selftests/vDSO/

And then I reproduced the problem again.

So I think we can be somewhat certain the unrelated directory is indeed
unrelated.

