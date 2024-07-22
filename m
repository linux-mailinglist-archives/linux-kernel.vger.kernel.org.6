Return-Path: <linux-kernel+bounces-258575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065D69389FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8691F2167D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548121B969;
	Mon, 22 Jul 2024 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Mo57lr+R"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3AC17BD5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633065; cv=none; b=qvUmEbo56ghOhP3tMIymybMI1jAwONOf3VRooPBZXV1pu/WZlNaT94t+DNAdNBT0RRCLcZ6jcugYhPaxey/2ka0Du9vz0kJr9JPNrFqJnYOopCicxaua0MIm8k3i1vfn4TgqFnjkMmv1jEnN8ybdhVUc83CGmyTUUafJVfe8WLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633065; c=relaxed/simple;
	bh=71VcNa9JotMg66vYwr2mbLx9xOfQOcorJypa+paYZZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=knCoviUmwNqH0VCoxs203AhaWJfkQbJbjrH22v3F5vV3ICSvU7BFKqULKeHYwCzA1wDTMhNHXax0tyycAIz0/wvdIBwRMwmzpty3xeVguNzJXf8HcDdwPjnbl5qxaChpvvekFwOTdn9FJ2A0mHylllQ5o6CkWX0yPpc2wxKQDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Mo57lr+R; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721633057;
	bh=7xYb9iaHHsO53zX4r++CVPw1TcU/Qoda/IxZitAYyes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mo57lr+Rk5tEBPzo+Uh0Sak5AZzOKKbaJhj9ORzW0/FazE6xM0EWBA2oJR49LeSCh
	 q+r0cxX76MlKwT+R0sEsg+fSVS4B3k9G/U7iDTYZGq27GwkQuJ7q7NybR1DBxMA04w
	 ugGEn4j6oEy4xK5CUYjRuNJeIgrUhEA8z0KBD+QqwXdUVa0tHBYi3NY+FolJoA0HZu
	 gGX3FMtWx9flPJtO5aWg7dnqSh+daKFEVD3N/agHqfzGn4v5qhreUFUn3K+MdBZ/Vm
	 Pk0LtjQ+oJtEH5EeRmtZLBU1W9/i5ClHMzEsdYxxdoN7Kme1c+fFa21WrPKfC4TsbH
	 anjTTO/JXdlOw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WSBc13ZZ6z4wc1;
	Mon, 22 Jul 2024 17:24:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Dr. David Alan Gilbert" <linux@treblig.org>, Sean Anderson
 <sean.anderson@linux.dev>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: camelia.groza@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/fsl/qbman: remove unused struct 'cgr_comp'
In-Reply-To: <Zp2QtPET9649y9pA@gallifrey>
References: <20240528231123.136664-1-linux@treblig.org>
 <336239e6-4369-44ea-a60c-d300cf6e6f81@linux.dev>
 <Zp2QtPET9649y9pA@gallifrey>
Date: Mon, 22 Jul 2024 17:24:16 +1000
Message-ID: <878qxtx527.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Dr. David Alan Gilbert" <linux@treblig.org> writes:
> * Sean Anderson (sean.anderson@linux.dev) wrote:
>> On 5/28/24 19:11, linux@treblig.org wrote:
>> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
>> > 
>> > 'cgr_comp' has been unused since
>> > commit 96f413f47677 ("soc/fsl/qbman: fix issue in
>> > qman_delete_cgr_safe()").
>> > 
>> > Remove it.
>> > 
>> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>> > ---
>> >  drivers/soc/fsl/qbman/qman.c | 5 -----
>> >  1 file changed, 5 deletions(-)
>> > 
>> > diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
>> > index 7e9074519ad2..4dc8aba33d9b 100644
>> > --- a/drivers/soc/fsl/qbman/qman.c
>> > +++ b/drivers/soc/fsl/qbman/qman.c
>> > @@ -2546,11 +2546,6 @@ int qman_delete_cgr(struct qman_cgr *cgr)
>> >  }
>> >  EXPORT_SYMBOL(qman_delete_cgr);
>> >  
>> > -struct cgr_comp {
>> > -	struct qman_cgr *cgr;
>> > -	struct completion completion;
>> > -};
>> > -
>> >  static void qman_delete_cgr_smp_call(void *p)
>> >  {
>> >  	qman_delete_cgr((struct qman_cgr *)p);
>> 
>> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
>
> Hi Sean,
>   Do you know who will pick this one up?
>   I got a notification a while ago from a patchwork at
>   linuxppc-dev marked 'Handled elsewhere' - but I'm not
> sure where.

drivers/soc/fsl was orphaned, but Christophe has recently volunteered to
look after it.

This patch looks trivial so I can just pick it up if you like Christophe?

cheers

