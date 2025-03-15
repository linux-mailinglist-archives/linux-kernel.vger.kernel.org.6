Return-Path: <linux-kernel+bounces-562518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D32A62A4C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8F319C100C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCF3192B8F;
	Sat, 15 Mar 2025 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=one-eyed-alien.net header.i=@one-eyed-alien.net header.b="Zo1B9aZ2"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96E11F55FA
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031473; cv=none; b=TiyZiRDDRgMF5ybnghuGVfDniUhuA0PEnAq0QVxDbE+H0hpOS6aS9vtV/zxlwzCcYlWBbcUEDi06myWWM6leMpfDjRNIuNXzi8nD36gOKNb8lHB+0Ll6oJYT65I3WG1a+snwk5D7Qoum2paY+8Eb0gywQ1oxvBVFWgNzSV88jUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031473; c=relaxed/simple;
	bh=kgSmtXF4ScB5drJt9J5ZP4Yv3u/Wt5sgt8vE4aPRN9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PljMHydCE7ZNjSlfM72qi+rH9iobsBeDc+VAg7246e4DEJQDnyRzx9ybaIj7TDw0j5zpciYVGVDLYTJ+e+mhRQVpMRj+xB4Nf/423vHDuAk9vuZ9FAcNxevTDcSNA3Rf1gy7WHBcMTLcbgkQA22CO91GJOLFeWKWBzERuWB7rrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=one-eyed-alien.net; spf=pass smtp.mailfrom=one-eyed-alien.net; dkim=pass (1024-bit key) header.d=one-eyed-alien.net header.i=@one-eyed-alien.net header.b=Zo1B9aZ2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=one-eyed-alien.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=one-eyed-alien.net
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so2229955e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=one-eyed-alien.net; s=google; t=1742031470; x=1742636270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoKr7SHE44HOAp5gkOEleJFWJM8MifMY5kyE47IK1H4=;
        b=Zo1B9aZ2a/W+DSLHO1EjFg43TEfUAZkYWi/DIiIdR6D82I5qt7TDBtqm6jbY+tuAXl
         uAb8dTl0efCS+DMt1A3hq7vcSLEKvJHcYgqAhzqIxhr74QBNayDoMpoPDNoMie9Q98YR
         fHBQnqvUUDbF126jEjW/7RNd1goqlbXpArx7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742031470; x=1742636270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoKr7SHE44HOAp5gkOEleJFWJM8MifMY5kyE47IK1H4=;
        b=sek79HkGOjNKl/va+zkoyOUB6LELCNICWDHWc4QVNC7BPQm6oU3UU75ENW2gcEmVh0
         PfRkQwwUfs29MwgEGNVrlu4HvFcUTFuz0FWCqcVNdxBceTlzB4RMj/08rw0KJu1Dz+0F
         bq5NZt3N5JnO182CzrOZJarEEKs/y7KCzpKArIzk2HesAwbHtVQ3FERCisOBHo0fISHh
         2uP0+3PMxEIKx/ZF9HtEFF3NMdvoq7+/SISW7yCcwNDUEdXBU3AnequwVy9hMs4xw432
         tL0eibLu+b66RAU+vOeTyoSZMHZzpj28KD6jXW4GVTWZiokafca3I/UW/S1zs0jA3DaH
         luHg==
X-Forwarded-Encrypted: i=1; AJvYcCV7+nAtDY0OiqOGgrhlG0n0FSlLMKMOtjFwTHw4ofTgAQbovzpHmJcHSAE13cICsH6h/ZplmMUILzZnZpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6O4A2KW2v7qx8ljyP0daUdrw1CWvozGULuFUkKJYmy6NcAjDY
	ZbeAMyGawbGQse0KVQdICDB9wjuoAgjpOqOmUvmulDlrVkbkrDlR/8J5mTZ6mi/IPZxMpeNPikY
	TbF8LirRYs9jvRUZxPJ+HHf1tTJPtf+mduVGHXr7X2hvYpsVD
X-Gm-Gg: ASbGncvl06/3Aj/HZjOfLxmvno7arbwJytsK/jJWy3X824zNaie3b8yJvfWzIzQnDvi
	DUEEZ4W5pWOfT6GFYHrT7rBERzBYVOfqAOoWTND7vvs5XvXRvS0f4dOVQo2GJLr4V9yuCmCq/Qv
	OOT6k/IyUL2uAquGbT3zsfzljl1pqEUKbbrXte7demPGT9h8yf649QYhF5yw29
X-Google-Smtp-Source: AGHT+IGYrZt/EjT3A7jq2TzWlQX83QLzyzeDh5Jc/J5jRlZbCYObqBxDmnkzAXLaWCDT7Z5ktTMEU/QHZ2+eGqH+4LU=
X-Received: by 2002:a05:600c:4f0c:b0:43c:fe90:1279 with SMTP id
 5b1f17b1804b1-43d1eccbfb5mr62124925e9.21.1742031469978; Sat, 15 Mar 2025
 02:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311084111.322351-1-daixin_tkzc@163.com> <2b6c4aa7.b165.1958f6b7a3a.Coremail.daixin_tkzc@163.com>
 <814316b6-013b-4735-995d-b6c0c616c71b@rowland.harvard.edu>
 <1681f087.2727.195927b7ccb.Coremail.daixin_tkzc@163.com> <516c8f89-45f2-4d3f-b1e7-29aecfc8cd3c@rowland.harvard.edu>
 <6e125c5c.2541.195990d2daa.Coremail.daixin_tkzc@163.com>
In-Reply-To: <6e125c5c.2541.195990d2daa.Coremail.daixin_tkzc@163.com>
From: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Date: Sat, 15 Mar 2025 02:37:38 -0700
X-Gm-Features: AQ5f1JqLq3W3-lzt1kCzj4W5ovolac2rp7tv48_Dig_V4UK7vJZ2Kqb2p5FsisA
Message-ID: <CAA6KcBD=CbW6S8vZ-n2v4BuJfC03vuNPzAG-WD5AN5_mMjgUfw@mail.gmail.com>
Subject: Re: Re: [usb-storage] Re:Re:[PATCH] usb: storage: Fix `us->iobuf`
 size for BOT transmission to prevent memory overflow
To: daixin_tkzc <daixin_tkzc@163.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 2:05=E2=80=AFAM daixin_tkzc <daixin_tkzc@163.com> w=
rote:
> Yes, dwc_otg should indeed ensure that DMA writes memory data no more tha=
n 13 bytes (even if Rxfifo receives 512 bytes).
> But in fact, the dwc_otg manual has different configuration requirements =
for the XferSize register before DMA transfer:
> For BOT's OUT transaction, the HCTSIZ register is filled with as many byt=
es as the software requests to send; for IN transactions, no matter how man=
y bytes the software requests to receive, the HCTSIZ register needs to be f=
illed with 512 alignment, that is, the software requests 31 bytes in the CB=
W phase, and HCTSIZ is filled with 31; the software requests 13 bytes in th=
e CSW phase, and HCTSIZ is still filled with 512.

"Alignment" is not the same thing as "size".  A buffer can be 32 bytes
and aligned on a 4MByte boundary.  Hardware devices often impose
alignment requirements as it simplifies the logic required to access
the buffer.

> Please allow us to explain the reason behind changing the US_IOBUF_SIZE m=
acro.
> 1) The macro comment says, =E2=80=9CBut Freecom needs a 64-byte buffer, s=
o that's the
> size we'll allocate=E2=80=9D. We thought that "Freecom" had a similar pro=
blem, otherwise a 32-byte buffer size would be enough.

Your reasoning is incorrect.  The "Freecom" device does NOT have a
babble problem.  The Freecom device uses a vendor-specific protocol
which requires a 64-byte buffer buffer for all of its command and
status transfers.  us->iobuf is used by multiple protocols for command
and status, including CB, CBI, BOT, Freecom, and others -- as such, it
needs to be the largest size required by any of those protocols.

Matt

