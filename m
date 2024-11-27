Return-Path: <linux-kernel+bounces-423354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BA39DA63C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425851642C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CEC1DA622;
	Wed, 27 Nov 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="LS69UuNH";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="uwsJfH+3"
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EED1D89ED;
	Wed, 27 Nov 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732704962; cv=none; b=WEeq3AHaLTfv0EbJMzsWv+a4s2QyFbuj54oq/egiukqEhHL+g9wvbqtOS06a7F/Huo1eVUuTFh+U2p8SF/2bBCdEzTd5cY3mBYDdslabyKQJEeZ+TbfYnARM/M55iX69p5AOHhPcDYBd3DCVW9NSRgjwnAjkxRKsDbt33Hesi1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732704962; c=relaxed/simple;
	bh=1yU/qlGi1UeV8a2MiKkmtcspdlkNnyaFzSDiPOaFkJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YerwAz345eVd0fXpqBDZ0baOGtGsBbfhOfk4FPIaIHRp8vfC7FrJV1LARLUAqNlM+gfGrU7Ca/wejx1kP8sUXJsAUmn3jmuREzZntBavARgWpqp1R0tpJXeS82WMWhRcRukknxxZUqYtUDd3kjJjsP4eXIIjryfrMhoWcQLk9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=LS69UuNH; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=uwsJfH+3; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 48A0E122FE1E;
	Wed, 27 Nov 2024 02:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1732704958; bh=1yU/qlGi1UeV8a2MiKkmtcspdlkNnyaFzSDiPOaFkJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LS69UuNHegvzH1QSVS9u26+DzTmRUuAlEOWIyQCWg6gHwC/xTRVDnLJVMA5CMLvw9
	 jgvd9Rei8dwzBzUJqtObWxY7lqY4eSGhv+d7YruAoVyCkKn7fnyIIIZiIFFDwfCf62
	 hFopsYayeFM0SFASoPuRhE1CHIbBp7CqPmRg2ONgiXw18fEmCd8j62gmhSV4LRwW8o
	 ra3bkHSwHwqTQhVZxw6w9vQGsP1nvn3pMY/62z7k1U1F2tMxIOhk5FrQjvcYDCTwf0
	 XlsLFTnm9O0CuaQbjsTiAwlgoeIv1DWE1XLvPwOfRXWZ+pvid18ZQR8KIgcfuM5DWO
	 5yMxMAkOe6QYw==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YNS0vbNhMu1C; Wed, 27 Nov 2024 02:55:54 -0800 (PST)
Received: from ketchup (unknown [119.39.112.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 9EAAB122FE1A;
	Wed, 27 Nov 2024 02:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1732704954; bh=1yU/qlGi1UeV8a2MiKkmtcspdlkNnyaFzSDiPOaFkJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwsJfH+3HRYpZD5erNRE95tLavoK9z63ZaX9LVjxZJHBKdEgmgXeS6ic7WBmDKMvU
	 /eSyJl+JNlQy0ZHrPdw1iDW6BpZaPrdDwT4BfMmqBBwESOBfkRDgLdnaPdjMsgIFeP
	 s7pYW+XoA7hHNQ9Mp17hcE5uWgsxQ7jUXegvYUt7z49HQbFHYK7QUvqiRGL7+0qC2+
	 lbwhlTD4TJKqBmcFSh1/vw31YmsqnFJKO27CmJS4WssIQABF4Ml3jlz4dwLb+AngsB
	 uXXPfZwVEVQqdABuBSP8hsIP8+4hQL7pTgJ+bEEu2HFFUf2IEvC9tBKedT2g61J92f
	 RobmCn9pjXc+w==
Date: Wed, 27 Nov 2024 10:55:42 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v3 0/3] Add clock controller support for Spacemit K1
Message-ID: <Z0b6rqurcj-gfzjI@ketchup>
References: <20241126143125.9980-2-heylenay@4d2.org>
 <015ca99c-e3bd-4e45-8d92-0e0f4de6aacc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015ca99c-e3bd-4e45-8d92-0e0f4de6aacc@kernel.org>

On Tue, Nov 26, 2024 at 03:44:20PM +0100, Krzysztof Kozlowski wrote:
> On 26/11/2024 15:31, Haylen Chu wrote:
> > The clock tree of Spacemit K1 is managed by several independent
> > controllers in different SoC parts. In this series, all clock hardwares
> > in APBS, MPMU, APBC and APMU, are implemented. With some changes to UART
> > driver, CPU cores and UARTs could be brought up (see below). More clocks
> > will be implemented later soon.
> > 
> > No device tree changes are included since Spacemit K1 UART needs two
> > clocks to operate, but for now the driver gets only one. I would like to
> > defer the changes until this is resolved.
> > 
> > This driver has been tested on BananaPi-F3 board and successfully
> > brought up I2C, RTC, mmc and ethernet controllers. A clock tree dump
> > could be obtained here[1].
> > 
> > [1]: https://gist.github.com/heylenayy/ebc6316692dd3aff56575dbf0eb4f1a9
> > 
> > Link: https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb
> > 
> > Changed from v2
> > - dt-binding fixes
> What fixes? Be specific, what did you change?

Sorry for the vague changelog about dt-binding changes... I'm willing
to post a more precise one here,

- drop clocks marked as deprecated by the vendor (CLK_JPF_4KAFBC and
  CLK_JPF_2KAFBC)
- add binding of missing bus clocks
- change input clocks to use frequency-aware and more precise names
- mark input clocks and their names as required
- move the example to the (parent) syscon node and complete it
- misc style fixes

> 
> Best regards,
> Krzysztof

Thanks,
Haylen Chu

