Return-Path: <linux-kernel+bounces-297758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C71395BD56
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE219B25B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3A01CDFB5;
	Thu, 22 Aug 2024 17:31:50 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115691CC899
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347910; cv=none; b=RQ7M9piMKUXL38zdNFPy8ZXz4KlsR+HOO4AuWpzrfIDxxN3MAAfvERBOY5PQvzQBhW6jEdAe0gsGjV9iUmV5j2C3m+Kf1GwouEi7xG38026WKXGsi5wX11CcXCU6ZH+AsbBaEBJrPnV8Asvy+MzVyxBn52QBzM5nf264Rko9zko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347910; c=relaxed/simple;
	bh=9JCv/vx5AHoPLFlsebdHtRp/plzH+EWvS3Dy5bcPQws=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BDn3XynrqN8Hu4gWpLQk3YZpG4rtJzUN7nnEkIrwb+mN3+h/i+uKEHZc2Wxq6emUuor1i6wN5IPYP6CZpMaUSvbcCin0jGq1e4VigaafANPJ1X5Razzgbfnbd+kiAciB6AzbcfYtOto98r0exSBZsw0ctFc9io2WU8gkOmRL9m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fa58fbeceso110615939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347908; x=1724952708;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JCv/vx5AHoPLFlsebdHtRp/plzH+EWvS3Dy5bcPQws=;
        b=gnlQdIV0wuxCXkneAg0pFqocIPTWhvMd8yY8AFqdFyAfGxPQa4Ta57C4HCyL5k0Bgo
         Ir64OJcBWSkQPiYdNGNEWvn4gx8QEEPpRZf7suGY9NHb5Pdh2L3Lbhlfgiinbk2s9bur
         YVHTDOQ41oZj3LPc/6Ylxjozk59FS5lfbag6ezdou/l1x1s547G5zi+HeZp6mZyQ21Sv
         IfSDNaXztTpG5Q7bW+v59+XUOI/KrfKRHD2G9Qgs/0SC/1UPLNXO0qs0C9t5WRnXXYkJ
         kWCiat5SR3UadUbd+nrA6lyiMYiZu7XaBqqp3ptXsxcFiViZLAW88wNr75vEtqWnxZkK
         QbVQ==
X-Gm-Message-State: AOJu0YwVg6s9A3dClxz2VsPpq1hVNhy1luPhVbGWgVpr37K95plX9NX2
	EddrdGjcmvBvnpAauwpICAd5YohWjjfPRxBOjRB6dDz59HbAH899BP0ZkLcZ6u1yDEu1ASLu9Mm
	n0/nJv/hFKID52a9VGVMI9pNZ4e94TYbarfJADB4idhR1Qo8MWtyDiWw=
X-Google-Smtp-Source: AGHT+IGfTLd8FwT3nQvQmssABNou3KLj3n6o6ZsSQECxXKkjNvvRMycpNPv/TLGFm2tpyetzTjwFXR8MlRr5u1AyBtGu6DJcxNdR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d12:b0:81f:904a:51b1 with SMTP id
 ca18e2360f4ac-827851d5dd0mr544539f.1.1724347907946; Thu, 22 Aug 2024 10:31:47
 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:31:47 -0700
In-Reply-To: <000000000000e097b1061beb2182@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085db6d0620490811@google.com>
Subject: Re: [syzbot] kernel BUG in bch2_fs_release (2)
From: syzbot <syzbot+9db8552458d57264a358@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: kernel BUG in bch2_fs_release (2)
Author: kent.overstreet@linux.dev

#syz fix bcachefs: Switch online_reserved shutdown assert to WARN()

