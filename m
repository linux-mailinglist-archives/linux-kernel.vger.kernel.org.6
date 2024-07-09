Return-Path: <linux-kernel+bounces-245711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D5192B715
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008A11C22499
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FFB1586F6;
	Tue,  9 Jul 2024 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+9DE690"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7E3158A11
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523973; cv=none; b=mcGAwJhjBSC99Pcf7vzjcsYUvFYZnYlr7MPKIo060vSZCb8HLhFXveNrv6SSgruPDdHjKK3jO8HKHPz36LAeuMoQYd1Ozy278ZDIdLKMezF2SG9isb1inFs8A3nYSyRrLmRuD4e7m/U5Vghxq7LV97j55EqRCAx+udNsWX/AJP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523973; c=relaxed/simple;
	bh=BItnevYQftOCRFmTco7LyFoPZ4oUphW+9VYSudo+9NU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSwOWk5HGb1faxGjrqpk07Lmw2OGADM0L4iEvSC/mXLU89cCWaoFPXeHEFpsqmKTSIQnbNl+fJcx74o1CJWJd9Qj9FRS0y3PfoVLgbsd8wwuatZ3Bq1LCtCaLsO5GF4L2SgNEvl35X6CsTgP36BC+isKqvpOeNqbeB7CK3wbEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+9DE690; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720523970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qwbHLNXPzAR/N/8uXrZSRmFQ5c/uLTMXj08MAhKvTTE=;
	b=F+9DE690Sn8bB2+E1O3OZ1GzzwbdPhvMBPGxpdeKEQmL1ZsHfb5IZ8EIFBb8Q5AyZrBguX
	Qe481D7Qqya8uz5U/Q4s6EsFZzeB4NnwwbOj8crTPSaCy6/ypEI+AkXq/InZPEMV4i/Apc
	LDxrNu1Ms0dEn6c0Yn3Rk46HXtYqyiA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-Xm6_DOisMfW8cFqvva8Vrw-1; Tue, 09 Jul 2024 07:19:29 -0400
X-MC-Unique: Xm6_DOisMfW8cFqvva8Vrw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee8a745746so50441351fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 04:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523964; x=1721128764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwbHLNXPzAR/N/8uXrZSRmFQ5c/uLTMXj08MAhKvTTE=;
        b=MsBfarxmyLCqePErYZ9kjRuRROWsF6rNXpQtsUvKipnzMPEJ9NRrCL/nKwInl4y0uS
         lnYDF1PesJ/jSlX3ltB4zrDGnEfykmqE9G4ooB0UAi3kCLGKBBVxL+OyvKojiSvy/5+P
         I2PZvFtIy+gp11u0r1WndTGM0+Vi2kViodlEdzHAE+F4+Bi9kL5N9REIh7AzC+RukQKb
         DZbA1c6qX/YXqDO4u7NMALJ9uVjUlLXV2B3sZWkkPq0RkyrTzg1fZq1852EIxXvEjVWz
         JtHJkZYOH7oGZjckNHfbnMR4/7hUdj0uq3+W8WhxzH52cjwJSZ3YWGMy6biQwk6A6RfH
         iF6g==
X-Gm-Message-State: AOJu0Yy+ofs5X5Dv0Qf+fOHNVfjlGwVYaUTmtexgvYNhsckROPyMkwfX
	dlkyRZDuZgF751XY65XHGMpBSL2FfVsbVzw1cbtsmUeGo+VhNMPpXPHW12bCQWjlEz/d6xHT1rn
	x2rI/i7VDAa3TDC3TFKfu5nUj5rHKelTxztCzisWpsUQ1NGPkZ/GOJ/M43P9OK/iLUknRyVQj3z
	Ue8TtcRj7KJMT84xUpoYGsWqEc5EP+fh61PzUJ59QN6zs=
X-Received: by 2002:a2e:9f03:0:b0:2ee:4ccf:ca4f with SMTP id 38308e7fff4ca-2eeb3101de6mr16105021fa.31.1720523964606;
        Tue, 09 Jul 2024 04:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFGxEpvT2wnJU72VkvZj7q8tuPCVpDDqG6kBc7TA4IZyQG8gcuy+uWDWNgH2hnWmFNmVBcCQ==
X-Received: by 2002:a2e:9f03:0:b0:2ee:4ccf:ca4f with SMTP id 38308e7fff4ca-2eeb3101de6mr16104291fa.31.1720523962911;
        Tue, 09 Jul 2024 04:19:22 -0700 (PDT)
Received: from localhost (p200300cfd74b1c2b6d9a10b1cecd2745.dip0.t-ipconnect.de. [2003:cf:d74b:1c2b:6d9a:10b1:cecd:2745])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa078fsm2244778f8f.71.2024.07.09.04.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:19:21 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Hanna Czenczek <hreitz@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 0/2] virtio-fs: Add 'file' mount option
Date: Tue,  9 Jul 2024 13:19:16 +0200
Message-ID: <20240709111918.31233-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We want to be able to mount filesystems that just consist of one regular
file via virtio-fs, i.e. no root directory, just a file as the root
node.

While that is possible via FUSE itself (through the 'rootmode' mount
option, which is automatically set by the fusermount help program to
match the mount point's inode mode), there is no virtio-fs option yet
that would allow changing the rootmode from S_IFDIR to S_IFREG.

To do that, this series introduces a new 'file' mount option that does
precisely that.  Alternatively, we could provide the same 'rootmode'
option that FUSE has, but as laid out in patch 1's commit description,
that option is a bit cumbersome for virtio-fs (in a way that it is not
for FUSE), and its usefulness as a more general option is limited.


Hanna Czenczek (2):
  virtio-fs: Add 'file' mount option
  virtio-fs: Document 'file' mount option

 fs/fuse/virtio_fs.c                    | 9 ++++++++-
 Documentation/filesystems/virtiofs.rst | 5 ++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.45.1


