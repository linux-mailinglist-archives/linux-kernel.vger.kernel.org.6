Return-Path: <linux-kernel+bounces-540489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97592A4B145
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE53A7A6A96
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C691DB546;
	Sun,  2 Mar 2025 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9DoiiXY"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72EB1CDFD4
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740916197; cv=none; b=FViSphYEsCT1YOoGs694mcFSEwosn14cDrIbzHbYPbsT8O0U9xogeCW4T9edIlCn6TU8rKUuyf5W1GNomB0xK00P6smXtLOTLJhOzy0BdyxfEhHsYGRWZywbsRRvJV4q3wf+dZMjoGzZEHvEl1VRtGBhuYEIC7blOF9y3rNDQ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740916197; c=relaxed/simple;
	bh=OtMTbuA4NxLyHUjpiNS+T+VVw/aoRfyUeABT54Ua6XU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4WPw5QMr1EwSnh+K9GoCKhH5atsQIGdnzrlvRR5uFGtEicjG+GnVtRnDOB1iE3VxoZGd03GiJ+5b/oZzzf4higNe7fRIpM9lXUH4ur5I7wX3QWlCo7dCn+4u2cKIDZliTyxWLF3oaPUaBEl6F7X3stHmfaQkBt67y/tUUDcCug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9DoiiXY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394a823036so33618875e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 03:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740916193; x=1741520993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDWzcbxIvlIvGTw93dXaxSEzESqsRSQBbR/NvExKmkg=;
        b=j9DoiiXYR8witZeQKu6StkYz2DokyTkb1TMz5q6cY954XLYYopL0Lhz38nd3t90t+v
         0lftmlSVVIF+1/sGO2xPYrgyiyvg42edMybACNJBFTJr9Y74cQvtNHk+5yXrYNeyh8Vi
         6ivSKOnHI4BiWZ6ryunWSrQowOTFk88CPq9kcB0LVAy1lcWj9N8siCWvyW1CsB8yl9iy
         lZejMR+eYwP2fx616VFLAwJ6qdl14dTtzqVDyIln8tLp4owPo3MPs8rKCzik7Weg1mcZ
         ncRLGKVbF7iqDEaV3++/ho38wD75vVdKOeRhqLpGNUEZVHscunWxeLUiSNqOuqKJlK3u
         unFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740916193; x=1741520993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDWzcbxIvlIvGTw93dXaxSEzESqsRSQBbR/NvExKmkg=;
        b=gN/mEiII4tIzr0kO38s8B6ZYaWR99gKW8k6gB6cM0hfztL3rVlczSsL0TJqg4+e/oK
         HRWjtObirZE4MhhDwgRw20TmnJKYsKRPkYf8fZPD+Xw34vL8wasP/82baE1RckC+bQSu
         C8b7DlGXZqKbdqJWZbAMOQ7MwTyrOi8GN0jurm5eEiXjm7jebBHbkGAHN9qZ8bVVU95W
         nkISm0jPR+LblCdVlLAdodnM52l4QWxDuqfiu/RaaDsAiDXZm2jRNHJfX7WWHIlZoxn7
         9bIs/XcOXrZmAuU05qGodGGsZHjwrjmeibkcQrUP2af8zZR7A7zW2TKn7S228QEHnsHX
         d7fg==
X-Forwarded-Encrypted: i=1; AJvYcCUzOcZWEcrqpWMAC6YXc5gCpwLeO4vQfmeEARIEG5VQPi/yrwgBMT8WCSeSNbSAemh9G9f8QCWzFZqyAhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAF64Uds2urfMRxHYZS4dPWFeTisVoREDo65zHIOqE6kgihKO9
	KXv35vp6Gmp9b8fgN2Wxggy5lv8DIedoz35IKKnmv8dqrjbNr0LH
X-Gm-Gg: ASbGncs2qF99mdN2tWwh8S/2DefFWOipuwd1tpGHUTP328HLG36D9BbRQ48yrF3GstB
	GZgKdB7vtom6OYFZC2AS44l062B9JQeXqRny5bG6BFfbn8fP7L/kUjlYPkPDRQDCKt4ezXibjaX
	FnD21qZgjNjeJK56nI+iZ732MnPh5tYcat5PG6cFXpCHuX6MECOYlwwMpLNcm19RZMJeccBKBB2
	C8A4ZnxQsK0BQ2fywiXHBSrmXHxcqUAJlxdbV+uQwIX40DXdNIGELL9JMu8bt5W6nrmsopCJjwn
	23h+K0xzBhuElxIzMaxfjQJva7H9kC1yKsZQRjer9s7PMNGfhjJHvw8/slVYzvf9HMnpxPKti6+
	XxLmcc74=
X-Google-Smtp-Source: AGHT+IFSnVl3KaEQhdVggHE4Q1aPuMVBXNtHqEHxvCXcB1KPL9q/eBkWt8pH6VwwowmoXs0mVYntEw==
X-Received: by 2002:a05:600c:138e:b0:439:9a43:dd62 with SMTP id 5b1f17b1804b1-43ba675a8fbmr67558155e9.24.1740916192800;
        Sun, 02 Mar 2025 03:49:52 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b694524c6sm125935285e9.0.2025.03.02.03.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 03:49:52 -0800 (PST)
Date: Sun, 2 Mar 2025 11:49:51 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: switch to using the crc32c library
Message-ID: <20250302114951.6eff96d7@pumpkin>
In-Reply-To: <20250226190122.GA3949421@google.com>
References: <20250226062841.60688-1-ebiggers@kernel.org>
	<03dad20d-1293-47d1-a55d-8430fcefc0bb@suse.de>
	<20250226190122.GA3949421@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 19:01:22 +0000
Eric Biggers <ebiggers@kernel.org> wrote:

...
> I have patches for nvme-tls almost ready too.  Just been taking my time since
> I've been updating all other users of "crc32" and "crc32c" in the kernel too.
> And I need to decide what to do about skb_copy_and_hash_datagram_iter().

I've wondered if any of the 'copy and xxx' functions are actually worth the
extra complexity they add.

The (non-Atom) Intel cpu will copy at 32 bytes/clock provided the destination
is 32 byte aligned (so for an skb copy you may want to copy a few bytes of
'headroom' to align the copy) (I'm not sure how any other cpu behave).

The 'and xxx' algorithm is likely to run faster without having to worry
about writes. May cpu can do more than 1 read/clock, but only one write.

I guess the main benefit is for buffers that are larger than the l1-cache
(or half the cache size if you do the copy first).

It is likely worse for the 'iter' functions (which scatter-gather copy a
linear kernel buffer). They have to allow for the unusual case of multiple
fragments - and I'd guess the initial fragments are likely to be short.

Although I'm not at all sure of the point of doing the IP checksum with
the user copy. My guess is it helped NFS (8k UDP datagrams).
These days most high performance ethernet hardware supports checksum offload.
So RX UDP datagrams (which probably rarely matter) have a valid checksum
and there is no point making send() checksum the transmit data.

I ought to double check that the TX data is always checksummed in send()
I don't remember a conditional - and you pretty much never need it.
UDP TX are going to be short (no userspace NFS) and the normal path transmits
on the callers stack - so the data is likely to be in the right cache if
the checksum is needed.

	David

