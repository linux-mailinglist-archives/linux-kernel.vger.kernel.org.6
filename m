Return-Path: <linux-kernel+bounces-556344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F263CA5C440
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E370172F50
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF65825D55B;
	Tue, 11 Mar 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcSzep9x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C025BAAE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704821; cv=none; b=PiJcb6CAcwDbyHrsWyShDrrVrxMxLrTXfLdUW2muLHB4aazhjpbNi0IgrtRSUtqSQgx0dBF8dGvuxyaYuK8jLCGx1B6CiTyrOsTARc+LYzon4k+HFkaiquxrMab3K0XpOCqDlnz3uF2bV5BkvOdkAfQZn0U6go5YCV/uaKh7SUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704821; c=relaxed/simple;
	bh=24VDDfQsgP85KV3cgCbdJbgcSlm+eoXqCV9vCMXqR1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ny8gd4izNA7LQARZZRcLvv9dd1CMBh9W3pPNIc0cut+yvzX7o4EAxSe5iM2DwI2/lomvst4G6u+TB1Y2hzI+u33tPwDVqfNf+u90miWEdVyVIfryGTS+synx4+gp5PlORYB53dRz3KNLDzP7Xl24tPycQGC0SfNmNz2XiYEUqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcSzep9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7FEC4CEEA;
	Tue, 11 Mar 2025 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741704820;
	bh=24VDDfQsgP85KV3cgCbdJbgcSlm+eoXqCV9vCMXqR1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rcSzep9x06fUWbwUl+77589WNOmhHHgQIJJzO/rKqYyfWH+N65/fzTWpxaY36Xx3F
	 q9emmywvjCWbTl2Hdyjr8TP9UJwFd2FQYafqLJxLzkL91VSdDSFQokqRjd+yhOVj3B
	 U/7BBCawjfqvYyJTv5hNF07GNNhTX+WCFE2839LnlHrtw2CL6POCJ23aYq1XFvcnRe
	 l8mJazkW1FZIYxdG8lcl9r+2I4O1XLWDvAKleJN5fwTNblpLEmdbXY9ZDyahQylSrk
	 DgjcJteJOPGgUAHTdoXkpX/kYff42nlxJZDdG0gbw5gEtWfp1RpbxTrGAq8WoZpmvA
	 7Oah9Q6t8THEA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Andy Chiu <andybnac@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bjorn@rivosinc.com, puranjay12@gmail.com,
 alexghiti@rivosinc.com, yongxuan.wang@sifive.com, greentime.hu@sifive.com,
 nick.hu@sifive.com, nylon.chen@sifive.com, tommy.wu@sifive.com,
 eric.lin@sifive.com, viccent.chen@sifive.com, zong.li@sifive.com,
 samuel.holland@sifive.com
Subject: Re: [PATCH v3 6/7] riscv: add a data fence for CMODX in the kernel
 mode
In-Reply-To: <Z9AwF5hwF0ES9Grl@andrea>
References: <20241127172908.17149-1-andybnac@gmail.com>
 <20241127172908.17149-7-andybnac@gmail.com>
 <87ldtck8k0.fsf@all.your.base.are.belong.to.us> <Z9AwF5hwF0ES9Grl@andrea>
Date: Tue, 11 Mar 2025 15:53:36 +0100
Message-ID: <87ldtbwrdb.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrea Parri <parri.andrea@gmail.com> writes:

>> FWIW, the for S-IMSIC the write is already writel(), so we'll have the
>> text patching and IPI ordered. Regardless, there's more than one flavor
>> of IPI on RISC-V!
>
> AFAIU, this writel() is intended to order the insertion (and the initiali=
zation)
> of the CSD object before the MMIO writes; so, the "right fix" seems to tu=
rn the
> "other flavors" into using a writel() or providing a similar ordering gua=
rantee.

Yes, that's probably the right approach, or maybe follow-up!

> As a bonus, such change should address/fix all current and future occurre=
nces of
> the message-passing scenario in question (the patch addressed the occurre=
nce in
> flush_icache_all(), but there appears to be a similar one in flush_icache=
_mm()).

Indeed. I wonder if the SBI remote fence.i needs it?


Cheers,
Bj=C3=B6rn

