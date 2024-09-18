Return-Path: <linux-kernel+bounces-332762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FC097BE86
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDE02834A4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E0A1BF33E;
	Wed, 18 Sep 2024 15:22:31 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B567A15B
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726672950; cv=none; b=MXrVUa2eAOQMcDPDdDngNhpyF8KPvSD7d/VTSwtBPXFlW3K/gt6e/c/PHaqtijHn6Sh4ZpZ/OoavYgamCfj6tGnTTcx8bO/uEmGevYRQEohUrDsYYoIPgjMw/7U4rQCXArDDMaa9jNDvY2qxB1mWFZrDimq4egquGuIxp2GofbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726672950; c=relaxed/simple;
	bh=eUkNUaswIa8P7UVmusL8ktZjfYKFFrALf17jGP5Uc7c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NH9TcGEvSbB1e2rolrnEWcIJkVYRbKxkKHsytNBQKwBABMhR/qBsBJMqILCAaynOT+Gr3dY/euvtU1X7B8Fe1wPf8eSOb+uZYLMjUvoXtzrCKKRasQc9I2DMjw24YNr66lvPreu6dap+coaaZUBeMNK9LnV5AXuF2BVa/nXlQd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a09da3baa8so8189525ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726672948; x=1727277748;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUkNUaswIa8P7UVmusL8ktZjfYKFFrALf17jGP5Uc7c=;
        b=bfAEv//3IBeikTvvRpXaulNdXSw5rY0du+pVHClFB11IxSrkrDF6IA2/MHrVuzNvtt
         4evCEhEAWLKBJmNwfCWvr6VLbsLbQ+Yq5Z/bug4NwiY8L+KJgGpG8Ox3NSvYPY1N9swR
         BYoazRWCgTxX3bVSe+2aSS9UhTA1S6BSZjb0uVMtaAok+q/9uGfDMtRj2zySuEig+1FZ
         jg1RPWxT4X8iCmZdzXVgN0KL7a6KICd0aSYuEDj4LwQcovZ2MxkM7244S72S3wFyFyJi
         ZhTlnIe6+8L0IRWL4VavXcIIYtApQbQVZvPHPKTWr47bd/H8TnzQbiGHvPrrrWLHQGy6
         pG7A==
X-Gm-Message-State: AOJu0Yy+qxsPSfW2FGQB5tWAx/1kn3AECMI8TXA1Gy41NHhK1CTVpgYx
	imnQDPVlLllv0qg0vGivLDTOFJo3nPb8sac1cU0QdLGXA+3Kit5/SSIo+iEmiWzunxNvz3FQDSk
	C/vnPkJbwEFXqxwwPGoHDMi1a/xE2mbBNqNFLo+mVW8HYzy0DYKEl3I8=
X-Google-Smtp-Source: AGHT+IE9nEdgNufBEbAMqs9BLneRBVUXFpxiMclhXvkmm4xtyignv92KpJRh5r4G+zpmVoq8mxmh51R3K+JjWNNQ6dXSlmzzP/ie
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:505:b0:3a0:9c04:8047 with SMTP id
 e9e14a558f8ab-3a09c048195mr86727705ab.6.1726672948503; Wed, 18 Sep 2024
 08:22:28 -0700 (PDT)
Date: Wed, 18 Sep 2024 08:22:28 -0700
In-Reply-To: <0000000000005ef449062240d69c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66eaf034.050a0220.252d9a.0017.GAE@google.com>
Subject: Re: [syzbot] kernel BUG in ocfs2_write_cluster_by_desc
From: syzbot <syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in ocfs2_write_cluster_by_desc
Author: pvmohammedanees2003@gmail.com

#syz test

