Return-Path: <linux-kernel+bounces-554940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 577CEA5A3A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8AC3A7890
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54272230BD4;
	Mon, 10 Mar 2025 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZRR5AMP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8E189B80
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633745; cv=none; b=Q0EDZDuiRXMB/zavKbRznae2pIFMF23mHJ4ZbIx0BlPd68bomzBo6rL0gFic+89OGcZzneVipRfw6MQRS6W+UNhozHMXoV0GYIAJQLXLg+fdcdGx7nEhyaFNcxFCoJDpPcclYa+UciJj4SdMOamMhVIYzgU4YyJPWx48tdGE/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633745; c=relaxed/simple;
	bh=94BLM8I4Iq83Qseq7x7CFPGfm7TLCrXXLplG8u98kvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HOs9mL1WPb2cG17Lr3mKis1W8Dz5btPJ4wrgmjWeV0e3OdL+LF248SvBt/bWmvfiXSOsU9mhh18OCNj/IKRyEK5+aMZcR30819h4a2T7aNAJaYMmDohfvOJEd0zfBChNPg/Tv/CoJ3tP1H2R3qOCb2DJWiNP3sa900AChAnnJY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZRR5AMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8FBC4CEE5;
	Mon, 10 Mar 2025 19:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741633745;
	bh=94BLM8I4Iq83Qseq7x7CFPGfm7TLCrXXLplG8u98kvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XZRR5AMPMdk7ZB16EirURn/TlcYn8Hvck7OAPCUxjBv2KSIkw/KsHoQ3+drQB5T1V
	 ROMtT5MHluDHssmcdcqYO/aoZlylAaFjFxitFG0ZW8G55U89BMtcOCmAL2Aqq3ARGI
	 Hb2LHpBtfNNfxy1MschfIT3s3uiUo/pYQubB1lZQJ0aPj6tTmfrrIl7E54tXvtni45
	 z9GY+zYm4FJT4qrI/ABI2MeD6x12AiHOQBQ4GShE1FsQQfGi8asgy95FOjMb/264i+
	 CBnG1qLcF3kjy6J3JIsMa5SJYb9sUmGJr/js6FkGzziSmk3hEwslcDvYVkwOf2FMWd
	 QAjiu/khUe15g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andy Chiu <andybnac@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 bjorn@rivosinc.com, puranjay12@gmail.com, alexghiti@rivosinc.com,
 yongxuan.wang@sifive.com, greentime.hu@sifive.com, nick.hu@sifive.com,
 nylon.chen@sifive.com, tommy.wu@sifive.com, eric.lin@sifive.com,
 viccent.chen@sifive.com, zong.li@sifive.com, samuel.holland@sifive.com
Subject: Re: [PATCH v3 7/7] riscv: ftrace: support PREEMPT
In-Reply-To: <20241127172908.17149-8-andybnac@gmail.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
 <20241127172908.17149-8-andybnac@gmail.com>
Date: Mon, 10 Mar 2025 20:09:02 +0100
Message-ID: <87h640k8j5.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andy Chiu <andybnac@gmail.com> writes:

> From: Andy Chiu <andy.chiu@sifive.com>
>
> Now, we can safely enable dynamic ftrace with kernel preemption.
>
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

