Return-Path: <linux-kernel+bounces-267884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67B1941916
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D122818F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EAC18454F;
	Tue, 30 Jul 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HT0hz34A"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4731078F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356931; cv=none; b=E57RUCWPVwYybxY9+slviAbYPvy7jIHRCbW6K5UCg44TDNdU9rfEKWEORhwbWYJEpETkbEiW+dhv640iwLhSoqn7bFcWFJIdtXIFuk8MaAdYPczzQNZPf44zHnk+ubpBj2YZy4SD6JYBpN0chJsTDQf+f0BagLm+eHQmEUgG9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356931; c=relaxed/simple;
	bh=/WrqX39V/EGZlU7gkM+jA9j7Jyn0OjEJ1Mehdy12oxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUw9lEXt3DjadspNYD9GtdHaBaQlasr+FpTjyZk/zvwBPirsExteCaaNclGyptIbrr0Juw8DQZOH0sww/K1HnoLioj6bKhGB3ATSG1sKMtXRYyeeJs0Fzu29UQ34nA3TUg+SH7F+cVA+ammA44pkxZeDMERStEuwKo/W+artd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HT0hz34A; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso447945566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722356928; x=1722961728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfuNs9RJBxSHtgXaAG8xtdh6dR8/ZJRWqaxb2ZGOGQw=;
        b=HT0hz34AV6AQOhCDOqRoWZOg8kSqMBzmx3P6JlVSEUBoBqcFqHofONDiRu4Te+WWVq
         p6Y9EKYcyc457hg/5hRi9b9iZ6xBfdo5bQRyEEIpwQ4XnSNZAaCzf7TltKeESxQMHeLe
         mtVXoJQ+ti3kIitz3bRxYaMul+afdcJDVDujtjjkvBj08on3jxBFcipcMnjJ7H14hGg8
         Y8le95YOsIFhqGJ4oaFJPfQpa8G+12t+p1KcxSwncNJeNzUv0YowLBg+rbE/srCOuhup
         3wRKfhcWAskV8UVaHV+vaminX6hgYEY2F08gIfQIvJs4F2V8k/q6TGL7qR66XHH0RAQv
         wwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722356928; x=1722961728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfuNs9RJBxSHtgXaAG8xtdh6dR8/ZJRWqaxb2ZGOGQw=;
        b=a7aQoH6BDWmGG7N3qIpaVKHRM0JqD+WO4rkokFEtw8vUhst/zFga9GtHe/QrtIdm/y
         g9vJFZrfY9YGP2Rmm9vqOkJ+7+MaStob6VrZxuU4fIOnzUOnGGKfCFuF9gqOYG6L5xd6
         Tyz4o163J1sN79qWXY8GhsE4FmdYotg67+xV4sn/Am323caAMj4MEqhYJfx9RMsCNxWV
         HFty7urLoIo/CHKf5ouukOJaarWWja0gD524qqkPf+d0FSKbsBhIPphDbAzpHrfereBC
         kIf7jGSl43UPK2gvxAA2vJy5o0hPGGSBEHCBe6mmsKOgrAR8lT/Xx/ssCWiNS1bIi5/W
         lg7g==
X-Forwarded-Encrypted: i=1; AJvYcCUz6dgMq0hgXA9hTehmde1tffi6+6w8EQ69E8yjCypup7t6fJUdBEnZBvCO3M94a3WBCLzFM59rGY7gfV8+Yiin8cJBlpPQ/ArBKD80
X-Gm-Message-State: AOJu0Yw1soBrgpPJAdcD9EQLMmGfyWA/vqoIuODERkPVE0/lIa433HQw
	lCgCiL/+NDYg2SZr9BOOIGxG6/hCeTrOF9kvzioFGE3KpDDvQHoByJShuB24n63h8EvO4o+AWd6
	QBCQjxvKUS7EONlRyGHvv7GN9cN96sKr+79rCUg==
X-Google-Smtp-Source: AGHT+IG1VcMHenRJE4OMv8Wdwm4JETBLEpAvJgISa1/m5vlwH5K/nlA4PdfCRxYRpOU0UfdTVOnSQCZN39wxbmaGSUY=
X-Received: by 2002:a17:907:96a0:b0:a72:7da4:267c with SMTP id
 a640c23a62f3a-a7d3ffa612bmr940477966b.12.1722356927933; Tue, 30 Jul 2024
 09:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729091532.855688-1-max.kellermann@ionos.com> <3575457.1722355300@warthog.procyon.org.uk>
In-Reply-To: <3575457.1722355300@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 30 Jul 2024 18:28:36 +0200
Message-ID: <CAKPOu+9_TQx8XaB2gDKzwN-YoN69uKoZGiCDPQjz5fO-2ztdFQ@mail.gmail.com>
Subject: Re: [PATCH] netfs, ceph: Revert "netfs: Remove deprecated use of
 PG_private_2 as a second writeback flag"
To: David Howells <dhowells@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, willy@infradead.org, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:01=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Can you try this patch instead of either of yours?

I booted it on one of the servers, and no problem so far. All tests
complete successfully, even the one with copy_file_range that crashed
with my patch. I'll let you know when problems occur later, but until
then, I agree with merging your revert instead of my patches.

If I understand this correctly, my other problem (the
folio_attach_private conflict between netfs and ceph) I posted in
https://lore.kernel.org/ceph-devel/CAKPOu+8q_1rCnQndOj3KAitNY2scPQFuSS-AxeG=
ru02nP9ZO0w@mail.gmail.com/
was caused by my (bad) patch after all, wasn't it?

> For the moment, ceph has to continue using PG_private_2.  It doesn't use
> netfs_writepages().  I have mostly complete patches to fix that, but they=
 got
> popped onto the back burner for a bit.

When you're done with those patches, Cc me on those if you want me to
help test them.

Max

