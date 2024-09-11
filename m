Return-Path: <linux-kernel+bounces-324136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BEA974849
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1421F24D48
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11763A1CD;
	Wed, 11 Sep 2024 02:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NzKCaIvj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4F139FD9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726022695; cv=none; b=Jlt5B4KBfX4IJ6bEjQpHn5sXI11qpIv8hNzLiDbU3wSNpMtaW/aWNECdYajq08XCsJe7EfaKm11urbmtjQ5ilIatjLCxeRMhKoxSDB4rhbYRKteq0H2nd4KXHhVy+4lraHBOenLUItMOIUbK8CT6ipSGp68KBY3FN43ihaWNGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726022695; c=relaxed/simple;
	bh=fAYFh8Hqx6fYD0xHOD8eU7oI6vInwmUAu/8HoLZRgJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPOJyxsEUjkSZa7thpsGMGrhLI+L4HUwkvlvbZwNUcCmXV893frtLywe/VRaSSVfoQ9JMCuM+GObWX8XnKwXR40M81+FxcmPpZVa/dkrJkENNg0bHVnNFRngoDTfhtUdqKd90bnF0t8ZIMO+rKcWTT/lPucV65zc21KsMvze9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=NzKCaIvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE10FC4CEC3;
	Wed, 11 Sep 2024 02:44:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NzKCaIvj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1726022691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fAYFh8Hqx6fYD0xHOD8eU7oI6vInwmUAu/8HoLZRgJA=;
	b=NzKCaIvjJLjRia2VyChjtqE27VtTIK2s050caAx6Hk2ZhvNiA/0+UOJdFWb0zY4R3n/T3x
	HCdcgDCGVBVAB/O6/UskHmIQ1XO+APXi8JtbasBoO2+cuQrhdI1foQz01a7zIebRuoe/lB
	bfpf2Ezjr+LaRLclLswaQloWAgXNwjg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e5f0da36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Sep 2024 02:44:50 +0000 (UTC)
Date: Wed, 11 Sep 2024 04:44:48 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: adhemerval.zanella@linaro.org, linux-kernel@vger.kernel.org,
	mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] selftests: vDSO: don't include generated headers for
 chacha test
Message-ID: <ZuEEIIV-J0mQVKE4@zx2c4.com>
References: <20240904155817.1153783-1-Jason@zx2c4.com>
 <fed980be-5082-4454-b696-6245d6a3d265@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fed980be-5082-4454-b696-6245d6a3d265@arm.com>

On Tue, Sep 10, 2024 at 11:52:51PM +0100, Aishwarya TCV wrote:
> make[4]: *** [Makefile:299:
> /tmp/kci/linux/build/kselftest/kvm/aarch64/aarch32_id_regs.o] Error 1
> make[4]: Leaving directory '/tmp/kci/linux/tools/testing/selftests/kvm'

You sure this bisected right? That directory isn't related to the
commit in question, I don't think...

Jason

