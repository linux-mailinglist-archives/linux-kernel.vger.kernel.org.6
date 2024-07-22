Return-Path: <linux-kernel+bounces-258870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7FB938D87
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55E6286C26
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA9E16A94F;
	Mon, 22 Jul 2024 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdKJyWoA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B82716A399
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721644251; cv=none; b=i0DpFvwu0Pz1OJITf2kp8nJM5jLnfNcVPb8w62ge4I/8XsRjO9SjaprPH3PpoYaQZSOy1QdRfs9reGidfi6F6LByqsUuxO13WMlzxkTsDK4FFUqhNjOFulvQF+Z4GSN/JmnQRZp3Z/sEVCngmAMeRZYiCoFlpaFCWnJIy/iJyc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721644251; c=relaxed/simple;
	bh=ZQC7Cy6nO2zKAZm9DYf71qtiwTMtWegr7L8JE77iZSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucuz39igvtMV7iovdh0rU8t7kdd407Wv4pj/e+yoJ5QVzzcim6dybOKJUdlxvueiMRl/ZXweulo055b25F83SP2fKvVeRgGqO/0hB8kkactdsxwNtTaxJgSwMhLI6TTYyoRFZdW5luQi8QAoT7Ch8y69ywPa8GgudMUVZYcSjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdKJyWoA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721644248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=920T09UfGz6bsniIm1Cf50ju0AGe0vceUzq5dRrbSaw=;
	b=PdKJyWoAf0pGdne+1CKL6NyMuuoKey5RnNqRHnKgI2jF/DuIFJHkOaTakgneEj2NHJp/T5
	X3uplXMIjICJZljvK4RhAk3Qa+sKzRnLIGsnLrB4vQ0rLeS7u4AqUl3kGBYl4tlM9qwVXh
	NqUw8mxye1Fx2yPs8ut1Qw0+/9YYeZ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-QsRzAvh_OJS8UbRmtQQzbQ-1; Mon,
 22 Jul 2024 06:30:44 -0400
X-MC-Unique: QsRzAvh_OJS8UbRmtQQzbQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8476A1955F65;
	Mon, 22 Jul 2024 10:30:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 112031955F40;
	Mon, 22 Jul 2024 10:30:41 +0000 (UTC)
Date: Mon, 22 Jul 2024 18:30:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] kexec: Use atomic_try_cmpxchg_acquire() in
 kexec_trylock()
Message-ID: <Zp40zOw+E1Na/Lly@MiWiFi-R3L-srv>
References: <20240719103937.53742-1-ubizjak@gmail.com>
 <Zp3NXf9UBCtFKBsa@MiWiFi-R3L-srv>
 <CAFULd4Y8vhcTWG-eNMSLEJHR_1=LuQzKj7q4JX8Kv7auJKAYDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4Y8vhcTWG-eNMSLEJHR_1=LuQzKj7q4JX8Kv7auJKAYDQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/22/24 at 10:53am, Uros Bizjak wrote:
> On Mon, Jul 22, 2024 at 5:09 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 07/19/24 at 12:38pm, Uros Bizjak wrote:
> > > Use atomic_try_cmpxchg_acquire(*ptr, &old, new) instead of
> > > atomic_cmpxchg_acquire(*ptr, old, new) == old in kexec_trylock().
> > > x86 CMPXCHG instruction returns success in ZF flag, so
> > > this change saves a compare after cmpxchg.
> >
> > Seems it can simplify code even though on non-x86 arch, should we
> > replace atomic_try_cmpxchg_acquire() with atomic_try_cmpxchg_acquire()
> > in all similar places?
> 
> Yes, the change is beneficial also for non-x86 architectures, please
> see analysis at thread [1]. I've been looking through the kernel
> sources for these places for quite some time, and I believe I have
> changed most of the places. The change is relatively straightforward,
> and immediately results in a better code.
> 
> [1] https://lore.kernel.org/lkml/871qwgmqws.fsf@mpe.ellerman.id.au/

Good to know, thanks for telling.


