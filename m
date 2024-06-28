Return-Path: <linux-kernel+bounces-233212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E74BD91B461
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DAF1F21F52
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB54125AC;
	Fri, 28 Jun 2024 01:01:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F010A0A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536486; cv=none; b=fG9bsi5XXawZVBQ88HG9irTDBuBRdaw7y0JXju9rVjOLpJJh7XehW13nPDtPM6gz9/zupaEhIudqCzP4yBqTnhflnap+MJvYWDuULZHTI6sQe8oFleblW03ryMha/MxU40DC+y4yPmD42cTGrzDOi8RjNlvSSTfN0gpWsVUEkac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536486; c=relaxed/simple;
	bh=pk70t7n1jhwXkPeGOZENhP22iNJ2kXmr56niIXrL9Pw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FwOSVNIBrK7pJPTtxji36AZQoPUFHNyaXCErmB0yW50AekQvFOYv1FVWHTLQr8s50+L7PejBoE5FuOROaCmmoZFj7lDH5PUbnJAOsDdlwbFOTSD7u+xr6IKiBJkGVPCFDeyE6d5OdBnanfJzZxD51cDU7Fp8JL3Mppbz5Z3zpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3d2d068abso6378839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719536484; x=1720141284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4Unbt1KIR4kQzPZuSS7gYuja1eqkEM/m5nftfbmguM=;
        b=CZ0GdjDdcWW7lUNarxqb8oRPzVzDyT3cIljb7vtgg6tzvlx7y+Y4yq1tvBvVh2yHo2
         d/6zI0MZETYKKWUIrdgjhkxmpmOY7qLpiMggGF1BWdrU4vEgTuC5MguD7ytQCw91negR
         YpNGqSDwz2wotaMJimvCslJvVrfuP1NQCQEb8F4gj5cQYDKaBO4zQocUY9sTgFhK3lRB
         xbiBWZcZupTKGtUqmVdvAkr8zsx6Owckf0hGR3X/dUX9VgRvrYnMPSS5YF787+lmqR3N
         piBnU0XyHgZXFNOUdzIMl8YHfFJGuIeFr5nWfrVBqumSQZeXYP9i3pCRbEuZ7GhaHmKI
         srGw==
X-Gm-Message-State: AOJu0YykRRa3ATKHXP8arJ1lgjn1BUFgUQC/vvxXMc5paXI3APAQMNWO
	QFHzysn/9O3WRGV6K6CuE8IQv+yO9K1/oXMm+0qbbjKgnwRN9JSw86NMa/HCiPgR/yNAg2+GV8B
	PM7KElihgGfVeaD3qZ6x4Sdh6kD3W7m1fACN84hkjEHdsgPuiyV0FJGU=
X-Google-Smtp-Source: AGHT+IF8XeByC3aWRmkhYVL7arcsqgLsuQSaRVR83WMjcGq6oMz/VokBFmS7oImDb3SFV/JS8GHzwzCxKlGZwqWi01nnFIf0gjrY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:248b:b0:4b9:6e74:bafb with SMTP id
 8926c6da1cb9f-4b9e7a0451emr724377173.0.1719536484617; Thu, 27 Jun 2024
 18:01:24 -0700 (PDT)
Date: Thu, 27 Jun 2024 18:01:24 -0700
In-Reply-To: <0000000000000b2e35061b9078aa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000582151061be8c9a6@google.com>
Subject: Re: [syzbot] Re: [syzbot] [btrfs?] WARNING in __btrfs_free_extent (2)
From: syzbot <syzbot+fe3566bcb509ae7764ef@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [btrfs?] WARNING in __btrfs_free_extent (2)
Author: lizhi.xu@windriver.com

#syz test: upstream 2ccbdf43d5e7

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3774c191e36d..8cab95333f35 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2979,10 +2979,12 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	ret = btrfs_record_squota_delta(trans->fs_info, delta);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		return ret;
+	if (btrfs_qgroup_enabled(trans->fs_info)) {
+		ret = btrfs_record_squota_delta(trans->fs_info, delta);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	}
 
 	ret = add_to_free_space_tree(trans, bytenr, num_bytes);

