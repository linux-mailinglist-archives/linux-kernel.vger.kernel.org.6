Return-Path: <linux-kernel+bounces-243320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8163E929491
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 17:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E8D1F22857
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CC3133439;
	Sat,  6 Jul 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOCnSYPT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1C04C79
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279825; cv=none; b=bo52YNshrewtHCKA52pte9FgHjRqeO65ftP+BEW6n620uOoYypQoCBvntlFW/Uh902P2MwKPvP42hjOV8EJ1qhX4Nfz8vx4peYxBOQRGQuTwj0l2GlGn18cfeNjTMN1Ip13KSq2osfONYqdfj/DJnHWcZF6hdHezkRD8M/ZLRY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279825; c=relaxed/simple;
	bh=T13SCXXyTw1o1r2UHuvo+NhGfeDaXotJBZ9hxhkMdxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N62B2WqVFiTyRFVjROwkk/RktgL8ySsMcIODHbPfE7/8T7IVMW8fvPze6ZONTCJmIt90sWHgdD8qMr79R0QRQiSHmZ4cXLjkJiffcdatL+1dyKBv9vVgXirG6FekisfRcZ22E4TXFg9HObGmIeX+0Xwh7ySfacAWVpPSj0f9Kc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOCnSYPT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720279822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1vaC3c85TB7LFRe9BKf6uD/WjUgJ/D2mXnTlQMJcHtM=;
	b=VOCnSYPTACgccY8AVN43DAIDDD9hOTzMEqQmN/FHAVeOoewQZXRAHPxyaZjM+WN/F8a+Xv
	MxLxdE3+TxMVdiLgia8mUiOz/8ZJt9/xxXNiAwbk3VKF+/D42Wqh/GcnwFR9G1WpUqLOeq
	1NFlBOkQWHw8fLfPrhU37QY2LgsdbS4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-JlPIbdnBM2qABbgda9SQMg-1; Sat,
 06 Jul 2024 11:30:14 -0400
X-MC-Unique: JlPIbdnBM2qABbgda9SQMg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 471151955F42;
	Sat,  6 Jul 2024 15:30:11 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41BC019560B2;
	Sat,  6 Jul 2024 15:30:05 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: "Zack Weinberg" <zack@owlfolio.org>
Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,  "Linus Torvalds"
 <torvalds@linux-foundation.org>,  "Jason A. Donenfeld" <Jason@zx2c4.com>,
  jolsa@kernel.org,  mhiramat@kernel.org,  cgzones@googlemail.com,
  brauner@kernel.org,  linux-kernel@vger.kernel.org,  "Arnd Bergmann"
 <arnd@arndb.de>,  "Adhemerval Zanella" <adhemerval.zanella@linaro.org>,
  Cristian =?utf-8?Q?Rodr=C3=ADguez?= <cristian@rodriguez.im>,  "Wilco
 Dijkstra"
 <Wilco.Dijkstra@arm.com>
Subject: Re: deconflicting new syscall numbers for 6.11
In-Reply-To: <a9724690-98f4-4ddb-841d-fcc9150e54c7@app.fastmail.com> (Zack
	Weinberg's message of "Sat, 06 Jul 2024 10:34:40 -0400")
References: <ZobXdDCYBi8OM-Fo@zx2c4.com>
	<CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
	<ZoiaWz9mG9rb0QND@localhost.localdomain>
	<87sewmzvn1.fsf@oldenburg.str.redhat.com>
	<a9724690-98f4-4ddb-841d-fcc9150e54c7@app.fastmail.com>
Date: Sat, 06 Jul 2024 17:30:02 +0200
Message-ID: <875xtibksl.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Zack Weinberg:

> Without commenting on the rest of this...
>
> On Sat, Jul 6, 2024, at 6:01 AM, Florian Weimer wrote:
>> The arc4random implementation in glibc was never intended to displace
>> randomness generation for cryptographic purposes.
>
> ...arc4random on the BSDs (particularly on OpenBSD) *is* intended to be
> suitable for cryptographic purposes, and, simultaneously, intended to be
> fast enough that user space programs should never hesitate to use it.
> Therefore, Linux+glibc needs to be prepared for user space programs to
> use it that way -- expecting both speed and cryptographic strength --
> or else we shouldn't have added it at all.

None of the major cryptographic libraries (OpenSSL, NSS, nettle,
libgcrypt, OpenJDK, Go, GNUTLS) use arc4random in their upstream
version.  If the BSDs use arc4random rather than the bundled generators,
they must have downstream-only patches.  I also don't see why someone
writing a new library from scratch would use arc4random because its
addition to glibc is still quite recent, and it provides no performance
advantage over going to the kernel interfaces directly.

Thanks,
Florian


