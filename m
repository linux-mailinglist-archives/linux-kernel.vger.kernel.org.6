Return-Path: <linux-kernel+bounces-276699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAEF94972E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE9A1F23256
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CB57581B;
	Tue,  6 Aug 2024 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOrGkEHb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193607580C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967053; cv=none; b=Cth4dS18jPR9sGB8/yciAR91TyPbXWdWWl1KbPFsBUXEgP2gSd0RfkvdjeP7PflkhgpUBDDcBUnfs1ccy7RpHWue8qjmvjq1C99xJIa3VWm9eFcjUyTXAmx5+ocGhljzupozO1EeX/r3E6Z1d6YYPR2AMeX1o5w1Rr1s57qJdSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967053; c=relaxed/simple;
	bh=Y3kpDopP34wSS4aefVZmlrz8cQFzCX6exogFHU3d/Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mfL7kf6iYPWVd/5Tcr7KGnXfFb8fSC1myv6R3EVIP+TGJfLfANbNkfvRRyLarMfqfEDScyYB/XXwDYjVSZe7qFp9IsNhioCn4lJH4u0cr70reG1VGmqs9y3vhXSWwDlPdy2fhH+8UfImG0z+kV8nl06Dsa1MBKd8U0Z/SObf8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOrGkEHb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722967050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=PCE6y3gd/ZLdIqr+zXDfXpXA+sJAwSBPUwATht6B/14=;
	b=QOrGkEHbq18AlKXPOs5GgVYjKtcUBLYRET7OWvQPpOqEZ+FgEQR2WVsuWvotDJ+6iQUL/V
	Io6lMOFhkRfYwSoJF6BTijEFr6mXED1+pmh52s1YpeAlsvtpAf2zb1iAaFj9XcwUfTk/mw
	V+BSqEXJPq/O4XGQ59SRm8egiJryrjI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-Z4tzlKPfMj6jv8UyNZ8ovg-1; Tue, 06 Aug 2024 13:57:29 -0400
X-MC-Unique: Z4tzlKPfMj6jv8UyNZ8ovg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5bb35b28f82so681923a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967048; x=1723571848;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCE6y3gd/ZLdIqr+zXDfXpXA+sJAwSBPUwATht6B/14=;
        b=YyVNi2y95ESF/rR4pgRVoNSqvcThhm5GfSX9isrzgxWm7GkOjxo8JnwEVSCG8PrW2V
         5e3mTCDHWZ1R8uA+xcVmnpWI8ukezymN9PSDCVnhCEkphPLEx2ihfcAGyr38saoEA3tB
         qCdzZbUVaGapxcPV5e64yRxJd1ITaL+faHXs1ln4hrWgFwMm3W6jzAFdpqu8wHevQNhk
         Zf5O/sodkdxA8QKFRNUVoHen/fnAC4XZPQdPT+FXl4nqRRPuhFIpGN/e1/X+9sTucEKR
         B64703q/j91Q60UFfk54sCKmrT97gKGhcm0Js7ppTRPpMILoordMmXwU7JYS1dmN5bQD
         sVsw==
X-Forwarded-Encrypted: i=1; AJvYcCWqmKwXqUOD2+owgtB3Fr9+9jL4PnIEdZMnCQgivugQdEgS20Fgx3ilEB9C8RmFf6EWISBuV3Wx3Yuk1QpeXyEdi1x3RBCBgyE2SAZj
X-Gm-Message-State: AOJu0Yxh/dQP/caenFqMCSnR+sipBi18q+Kp5ZzdbB97NUOmnR0MplCo
	mUUanS4jGTGHpwwLE9qT64bp43jFMI/ScOUXW/2kfK0wE6j7ps9NFnzJ9UvXLhYER6TE46SRDK2
	2MBW8gK8zoCg9dqsGT/+WlA/+cZ0YTSx4mYL1vY5ng9keZQ6nCV4C/LZlFEQL8PAM35nD0Q==
X-Received: by 2002:aa7:dcd9:0:b0:5a1:40d9:6a46 with SMTP id 4fb4d7f45d1cf-5b7f5dc5d68mr10453924a12.36.1722967048116;
        Tue, 06 Aug 2024 10:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9wiBpXfkiQpEvZZyARq7/ap2Ik8pTsT+kT/0l0ZHqK+AvR7K5fHmkyUYpLFX0WwVH0aYZHw==
X-Received: by 2002:aa7:dcd9:0:b0:5a1:40d9:6a46 with SMTP id 4fb4d7f45d1cf-5b7f5dc5d68mr10453907a12.36.1722967047202;
        Tue, 06 Aug 2024 10:57:27 -0700 (PDT)
Received: from redhat.com ([2.55.35.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba442ed7f1sm4421307a12.81.2024.08.06.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:57:26 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:57:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dtatulea@nvidia.com, jasowang@redhat.com, mst@redhat.com,
	stable@vger.kernel.org
Subject: [GIT PULL] virtio: bugfix
Message-ID: <20240806135722-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 6d834691da474ed1c648753d3d3a3ef8379fa1c1:

  virtio_pci_modern: remove admin queue serialization lock (2024-07-17 05:43:21 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 0823dc64586ba5ea13a7d200a5d33e4c5fa45950:

  vhost-vdpa: switch to use vmf_insert_pfn() in the fault handler (2024-07-26 03:26:02 -0400)

----------------------------------------------------------------
virtio: bugfix

Fixes a single, long-standing issue with kick pass-through vdpa.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (1):
      vhost-vdpa: switch to use vmf_insert_pfn() in the fault handler

 drivers/vhost/vdpa.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)


