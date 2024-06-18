Return-Path: <linux-kernel+bounces-219214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAD790CB63
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03681C2262A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D0513AD22;
	Tue, 18 Jun 2024 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Y8+dWJEN"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20573451
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712781; cv=none; b=ZRGMRHlZeCoAXH6/F4F1Rrrxk6PAaqeyBLUEEyjYbgk61l4GSNHbTVbFV90YHcY9hA5xvwdo4krGc0yk3nS5apazFMYUnl7iqHve0yyeCnkc3RNdkYP4TpvQp8RuAckDAPMem63Jqgil6r07lL1mLLdfu0DSeWwqmOLoLqscr+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712781; c=relaxed/simple;
	bh=HBJ32RVZl7f2AjI4VqIrgqJkqmifavSydXetdZ6TNAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kMbn1gbpIIKH0r3NC9MdWfu4jlF3dLHuVAAuMDgE4F7gqMQBh1nagDqkspWECLPfBIn1UkYQXT/Pv2bp8wl7qdalqs3kwJ3nomUHTcj6BIsSEMChFMcY4525MCqAwaOEJ4b2J24ufkWWcakEJMvzQWhbGFrUe9jChuG/X4BAFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Y8+dWJEN; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718712777;
	bh=T4jI7ACDqQnw0bojt0S04qj2GeD1CauQlFBbE9LYOKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y8+dWJENQPWQqn3HIgtWB4uC1HDsRmQXrHWy8h/M+eJrLid+GLPp+kMZz0yjgTCK2
	 yOvhcpodtmtIQg6gNbLAGfPYCzsuMI+JCmi6iOG4jMKUFSXHvfjZBYs69W+iQclBzU
	 pptEeYm2K6ltDPiS2pp2AP2Xs9gAy9TUeeNLpezid/hbJcwayl5nEY4SHElAmiJIQv
	 YIC3BKHBGFSv1p+8/I0W+fr8GYJUI5NnfcUkd+z/w7jiDezdBEJoAgQBnEUKRsWAhM
	 LK2IRhTmhCnJQJz6+XnK15GmNTs4h03iV1j7VP0iv5O/pwJTCBgyR9GL3Msbagijq0
	 xBRccyindPQwQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W3Qcm4MFWz4wbp;
	Tue, 18 Jun 2024 22:12:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>, Jinglin Wen
 <jinglin.wen@shingroup.cn>
Cc: npiggin@gmail.com, masahiroy@kernel.org, linux-kernel@vger.kernel.org,
 christophe.leroy@csgroup.eu, naveen.n.rao@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Fixed duplicate copying in the early boot.
In-Reply-To: <20240617161336.GM19790@gate.crashing.org>
References: <20240617023509.5674-1-jinglin.wen@shingroup.cn>
 <20240617161336.GM19790@gate.crashing.org>
Date: Tue, 18 Jun 2024 22:12:54 +1000
Message-ID: <87cyoe1mbd.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Segher Boessenkool <segher@kernel.crashing.org> writes:
> Hi!
>
> On Mon, Jun 17, 2024 at 10:35:09AM +0800, Jinglin Wen wrote:
>> +	cmplwi	cr0,r4,0	/* runtime base addr is zero */
>
> Just write
>    cmpwi r4,0
>
> cr0 is the default, also implicit in many other instructions, please
> don't clutter the source code.  All the extra stuff makes you miss the
> things that do matter!
>
> The "l" is unnecessary, you only care about equality here after all.

In my mind it's an unsigned comparison, so I'd use cmpld, even though as
you say all we actually care about is equality.

cheers

