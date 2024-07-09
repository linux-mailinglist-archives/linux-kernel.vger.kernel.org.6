Return-Path: <linux-kernel+bounces-245713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6813392B722
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0508EB229B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7653715AD96;
	Tue,  9 Jul 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFNjPCgU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D1F15A86D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523985; cv=none; b=YAtRFUi0VineyjJ0uMJUOyFrk7+gYm7AcETpJ7X74dv172kCPw2zYxdUL+DRY8f5YjFzRK8dqfm4XAjOze4sfHyuiSfk73FLvkBQB+l2gRTo/LK1YoLk5oipenkSKc2C1cr+ghQ8I77Z8/kIT6xBgoRG3IP2LmjqqqjIQiYnwzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523985; c=relaxed/simple;
	bh=Xjz3MTVYq/NAB3daYzBwLF+8t3T7ssr4yfGhYIRspPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhvz8Cs6qzCKmmYjkhg9XAGGmpS4AZo/qUMOO2ifzYwBv2zvseGjsBn8nn+CFHkBI+hFNQJjGBl3ORdWLHWdWcsm0nkPHP+rhcead+BdFxN7ip3t/52oTAyHjMV+IdQdFouLrxO0ImVtR5v0wbkPgA9Lmp6hgNXW1MBcmtSwO7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFNjPCgU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720523983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YN0cRtZ4yjTFsrRdrBTPFQCjU2aNbe9nzOGwlrFJ09U=;
	b=KFNjPCgU2ZGBoXvWPoTcOmAUb6N5Z9uwykF5DwhntrjMD+YE8/LxrL7cQhiL7ACdg7dfmb
	HQgSzMP0q6NsrRtehmUxm4uHe8H+DVC0YaLqagFYux0CtDEUWoevF2xusNXVl74uuuYMD0
	frWivKDPt/64o0QBSzfwkghlxw5m/fY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-5QdinuzXNue2Ito-f4rOSQ-1; Tue, 09 Jul 2024 07:19:42 -0400
X-MC-Unique: 5QdinuzXNue2Ito-f4rOSQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3679e7eeda6so3071647f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 04:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523978; x=1721128778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YN0cRtZ4yjTFsrRdrBTPFQCjU2aNbe9nzOGwlrFJ09U=;
        b=V3N3HinnxGs5lhPEBRMHAvtraNdX3PGWSufBkvzu1aQsPH5+F67jSR94ETxVB+kgPG
         6AXgNY3qp0whjGtOSjaFwqQSb8BqWVr43lO44lg1V+p6UzHl1zPke4PfzTqOFCpVDEk+
         8raWlZF6kaqVatBwA+ZGKz03YY+QnCzZKu5k1eJC9Ib2+aH1Lwz/DRI2ggyMZs1oeCTw
         8znCMd+au8IuaFBBXslZsXVwmjGV9ILPlQpUfZJFapIO3ZJ5wAtE7wjrK36xUA1tpzsL
         NTVy2Oupnv7erCE3AuCzcYgnSsrxaFXyJEzn/Jx3lek997JQ+rxkUGYxZQj/UmbKLWNV
         5E0Q==
X-Gm-Message-State: AOJu0YygyP5be2wqeBuboGd/TAe6WG+M6TpmT/DkYLKxcpeKntF0NuqJ
	7vd6yg519kpJ2YU9sFleOPTlbW+LIgDbcUcIdxBlIK1G33NHO/Cgxn9VUab2e0BoqUXbMzGzmqg
	iAgJre6C4Icx5jzJP51PXAOZzDl5cOZkRztOggeDHHu2pztkeDcHwg/tGE0NKXvtokGb3IM3qX/
	De501TQ5B45chCsK7dYq1LnPxC+IPdUYSaigdWUbYlPno=
X-Received: by 2002:adf:f20b:0:b0:366:ecd1:2f38 with SMTP id ffacd0b85a97d-367cea45cb1mr1566744f8f.7.1720523978493;
        Tue, 09 Jul 2024 04:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoGPU/A2758fnfW+6Bj1ZJdPWuqnkDg1NjoVhU3Nny/eh6gvsNgugn821lvXZApx4Cx1TO8g==
X-Received: by 2002:adf:f20b:0:b0:366:ecd1:2f38 with SMTP id ffacd0b85a97d-367cea45cb1mr1566715f8f.7.1720523977994;
        Tue, 09 Jul 2024 04:19:37 -0700 (PDT)
Received: from localhost (p200300cfd74b1c2b6d9a10b1cecd2745.dip0.t-ipconnect.de. [2003:cf:d74b:1c2b:6d9a:10b1:cecd:2745])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e08asm2270192f8f.11.2024.07.09.04.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:19:31 -0700 (PDT)
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
Subject: [PATCH 2/2] virtio-fs: Document 'file' mount option
Date: Tue,  9 Jul 2024 13:19:18 +0200
Message-ID: <20240709111918.31233-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709111918.31233-1-hreitz@redhat.com>
References: <20240709111918.31233-1-hreitz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the new mount option to the virtio-fs documentation.

While at it, remove the note that virtio-fs would support FUSE mount
options, because it does not.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 Documentation/filesystems/virtiofs.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/virtiofs.rst b/Documentation/filesystems/virtiofs.rst
index fd4d2484e949..201ac9ee13c5 100644
--- a/Documentation/filesystems/virtiofs.rst
+++ b/Documentation/filesystems/virtiofs.rst
@@ -43,7 +43,10 @@ Mount options
 -------------
 
 virtiofs supports general VFS mount options, for example, remount,
-ro, rw, context, etc. It also supports FUSE mount options.
+ro, rw, context, etc.
+
+The ``file`` mount option allows mounting a filesystem whose root node is not a
+directory but a regular file.
 
 atime behavior
 ^^^^^^^^^^^^^^
-- 
2.45.1


