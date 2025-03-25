Return-Path: <linux-kernel+bounces-575584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBECA70470
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B9A17A2466
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E88E1DEFC8;
	Tue, 25 Mar 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jo4lS6nb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABAC25BAA7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914806; cv=none; b=gkmC/9ZF8y9x1QYV9fzdPO0c0mUso56lfq3wQsafW7tEY+qY2COuAbODhXxSr2IIyjIb4tdJB/8VAWcjymujkBCW74bfHq5zfOQc3c3BIQa8x2uMb7xc2rm/QxR5bzM4TFTZKrLGdq5X6voIUNLXtuV4DMlSXVf+Fii8ZViNF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914806; c=relaxed/simple;
	bh=GPD56TsPvi3UfQl0ryL3JUmt+MmqXDPi65xi8w44GI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktf0031qhJDYmEAyXGofJhrkdiQJWbgfyqTLjofTITcfo/LMLa3evcuevfvfWW2I/X2ssuJod9aCKNd5Xp5vTenEa60+VkqO8w/mLQtUBQu4gxBl2vxDhRwYmAx24j9JVX5qRnqv/+GbAQ6jQq2KbZQ8x8pXLwpOUsyKtaaMWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jo4lS6nb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742914802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPD56TsPvi3UfQl0ryL3JUmt+MmqXDPi65xi8w44GI8=;
	b=Jo4lS6nbSPFUZqQ/YRSzh47wyg/MiAFjBkkpBci2pLWgaKT9Y0MlnvS2QXsy4X13l2R9H4
	ejad+NTAGfILpWnDfHsPYE9rfUrsJ48bNnjHrxRlHMbIcOef087NLrzcrDxTgE8nYrV14E
	ZHrDxSnDbOH5rrYMnmX+a3mea471IEE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-5Fcm4JHDPSW29qY40pxkVA-1; Tue, 25 Mar 2025 11:00:00 -0400
X-MC-Unique: 5Fcm4JHDPSW29qY40pxkVA-1
X-Mimecast-MFC-AGG-ID: 5Fcm4JHDPSW29qY40pxkVA_1742914799
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac6a0443bafso216891466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742914799; x=1743519599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPD56TsPvi3UfQl0ryL3JUmt+MmqXDPi65xi8w44GI8=;
        b=TFAWtBN9oQfLsYbQXNRBgnB7MZO7oIndCRHIf/LT0ihOXUd6rTb0FhoUg9oLc2DU+C
         awdLqiHrQz4wLcK/4fqo6hqElPbJm5SCcJc06qeT4CNECbgcOq3OogqPqjPuA45Wk1+s
         YojD1hfVI0LyTT64cEUKdGiZ5kko3L4jcLUkKztRUFmpcP5I36SMMgJJP/gFKgqBG0rj
         8X2V6Gdy6LVokly+iQQxoJFXTf5qFcfbkUSH/FTypA/phAeIY95CZ+1FioEOj0ZYg1uc
         K2QNDON2kG1YvElubx3KGXlQ7Vit3/YXegvxaZE2u4eEVMItDEqPwYgUxVZ4MPuBKXyN
         6lzw==
X-Forwarded-Encrypted: i=1; AJvYcCU8wf1TX473qUwwY/yAwlyTfEe2gcbKKWvpXo4HsUl7oIjZ+ALec6g3f5VU+9PFEuwOTeQgFP1KU+d6YdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIs824WlnB9TUjUsa1XdsOgIm+jX8mC8xtWnfwpX97XmhxkFnS
	dAANzB5LPgQQDTR13EmN+VJJCLsX57xV/aRCCOrWcpCQetcN04izdp+aygiTt2XUzUz9byBddgu
	Jd0buFfHmNX9U/OLxK6TCZ4h9aECzKt4pcXduDiVo+6TE0ZqZooKwElWcC3bzPi14mEYstyMUKh
	kmtDSgFFjSvY77BTVVLOBi6zUyX+AApLFOXzvu
X-Gm-Gg: ASbGncvh+KsBaaNDnufKiO4ImnnC/gArEhcSoBCQ9nSl9Z0gOyf9b7vZX7OmFaGAJ0r
	6aCHTPRQIWMW5xLfPpCABQ6QtHETKdCfKdN/X2Gc47X6YeEH/+Zh1PkG8ZJTpnAULllfMvtCBbw
	==
X-Received: by 2002:a17:907:1b05:b0:ac3:8626:607 with SMTP id a640c23a62f3a-ac3f251fbd3mr1795386466b.38.1742914798874;
        Tue, 25 Mar 2025 07:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+YUjGVWtfpyBwCFBLJ1QlJAEWsiUBcgZ5CATDRVTkA/NPywRDWZDxKGd2LtWzuRZROP8MS1zhzDRVTnbwctU=
X-Received: by 2002:a17:907:1b05:b0:ac3:8626:607 with SMTP id
 a640c23a62f3a-ac3f251fbd3mr1795382466b.38.1742914798382; Tue, 25 Mar 2025
 07:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com>
 <8b0b2a41-203d-41f8-888d-2273afb877d0@qmon.net> <Z+KXN0KjyHlQPLUj@linux.ibm.com>
 <15370998-6a91-464d-b680-931074889bc1@kernel.org>
In-Reply-To: <15370998-6a91-464d-b680-931074889bc1@kernel.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 25 Mar 2025 15:59:44 +0100
X-Gm-Features: AQ5f1JoiLoJo4ZTpZl2aK1T1MfyI1PFI0KWuUJogAG7QL32ZnjVnpgltDvnuL14
Message-ID: <CAP4=nvQ23pcQQ+bf6ddVWXd4zAXfUTqQxDrimqhsrB-sBXL_ew@mail.gmail.com>
Subject: Re: [linux-next-20250324]/tool/bpf/bpftool fails to complie on linux-next-20250324
To: Quentin Monnet <qmo@kernel.org>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	jkacur@redhat.com, lgoncalv@redhat.com, gmonaco@redhat.com, 
	williams@redhat.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Quentin, Venkat, Saket,

Thanks for looking into this.

=C3=BAt 25. 3. 2025 v 13:12 odes=C3=ADlatel Quentin Monnet <qmo@kernel.org>=
 napsal:
> If you talk about tools/tracing/rtla/Makefile failing to locate bpftool,
> it's another matter. As far as I understand, the RTLA Makefile assumes
> that bpftool is available from $PATH, this is why the commit introduced
> a probe in tools/build/feature: to ensure that bpftool is installed and
> available. So here again, I don't see the motivation for changing the
> path to the binary (And how do you know it's /usr/sbin/bpftool anyway?
> Some users have it under /usr/local/sbin/, for example). If the intent
> were to compile a bootstrap bpftool to make sure that it's available
> instead then it should replicate what other BPF utilities or selftests
> do, and get rid of the probe. But the commit description for
> 8a635c3856dd indicates that RTLA folks prefer not to compile bpftool and
> rely on it being installed.

Yes, that is correct. The reason why I opted to use the system bpftool
is that bpftool itself has a lot of dependencies, and they would have
to be available at the time of building RTLA. Since RTLA only requires
basic bpftool skeleton generation, and the only "special" feature it
uses is CO-RE which is already quite old now, I don't expect the build
to fail with system bpftool, so I chose to use that to make both the
build dependencies and the RTLA Makefiles simpler.

My commits sets BPFTOOL to bpftool since otherwise, the feature check
would fail, as BPFTOOL wouldn't be defined, since it is not passed to
the feature detection make call. I observed we are doing the same for
Clang and the LLVM toolchain in tools/scripts/Makefile.include;
obviously, there is no problem there, since neither of these are
in-kernel.

Shouldn't the selftests always test the in-tree bpftool instead of the
system one? Let's say there is a stray BPFTOOL environmental variable.
In that case, the tests will give incorrect, possibly false negative
results, if the user is expecting selftests to test what is in the
kernel tree. If it is intended to also be able to test with another
version of bpftool, we can work around the problem by removing the
BPFTOOL definition from tools/scripts/Makefile.include and exporting
it from the rtla Makefiles instead, to make sure the feature tests see
it. The problem with that is, obviously, that future users of the
bpftool feature check would have to do the same, or they would always
fail, unless the user sets BPFTOOL as an environment variable
themselves.

Tomas


