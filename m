Return-Path: <linux-kernel+bounces-213377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519E1907461
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7838285AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE1E145FFC;
	Thu, 13 Jun 2024 13:51:35 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3614145B33
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286695; cv=none; b=er4NxEhHEgxwGgl9coLGldBWA1//EthDXBgMqIToDL7pT1YQOLddvZN21YQYEpXliGxBxGioDq0Wc8wnwZ6bpQfccFEvEfnqvUwuVNpOUw7sGemnp5x5yK9ek8KUM0hKa/U1pgxNclpKcnnkP2pe+fXygoEge6FlgmPah8cb4ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286695; c=relaxed/simple;
	bh=Cf1SRu9HDqDxlI14eWuqYg5z9lcdpSZrOsOV+hdzXkw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cAd21Cf2IVGeD+ZFuu22cJWOzu1KafKZNA9FPz3/XDYwd05Z64jfrIxOUbNJ6s9yg7OPImubBFbzJYIQvpqIGb/+B+nyqhkvAJp7YR69Cf63eelb9rITYHQy70475yJixQUgljX08nFA1Cmrpp5IPAwWsYLPCpqKN4XoPihxHsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ea8fc6bd4dso99540639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286693; x=1718891493;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf1SRu9HDqDxlI14eWuqYg5z9lcdpSZrOsOV+hdzXkw=;
        b=K6srET4/fcQGQSRi9vhDrWdfSSedKW9MA+EBP+ngD1VelPMh0yPX6ATAxu3bxUf5YG
         PKMbv+9o4mFO7GTERS0Z+MHBpxhdE9WgYHotBrOjKI0Q4dihtazlGBMUGzdmgLj3zuvp
         QwIyCbJxWA3KKmiutANAY79T9rExZ2A4H+pYbUr7JyrciMfzuU/q/oQyJJoeZsSElBvm
         ph33JfKJL4XE3OguiPmItbiJfFrtMzIJbnUUEhuprtIRrDG8lhVCVwCb34m3QdV0BThj
         W6fo+f5VbVY1klCcqLVAVBSqa/LRa1iLN4oFe1pezdCjgK1CfgzOCyqMZU5Pqo6A5THA
         pf2A==
X-Gm-Message-State: AOJu0Yyll7hzBiJBfxKYuO2Ukcr65PvdW56QDPIeQhhubfTzHAMFK0Dq
	XwS1iKeid7AsLZIhf5A8NgzWNrZ90pxZ9/nu7Ft0qxnsMGLlbCW9iIntQaKCqy2rrfFg/Shtnjs
	XPRBEp8E+zyY2ZR760IIKwwbFjaTcb55xBg8jtePMD8aZhwRFr876a4U=
X-Google-Smtp-Source: AGHT+IEl4BI41VwpKFz8ao8+Wb6WlCUDRuOHYCTy+YWoi9OCUAjZHuKCHBgVtwKdV3TSrtKuODkhBX7ohaVVoP9nfJjpeZF0VFdf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8513:b0:4b9:58e2:7932 with SMTP id
 8926c6da1cb9f-4b958e29e38mr155709173.2.1718286693092; Thu, 13 Jun 2024
 06:51:33 -0700 (PDT)
Date: Thu, 13 Jun 2024 06:51:33 -0700
In-Reply-To: <0000000000008312ad06163b7225@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6dc46061ac5cb95@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem
From: syzbot <syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_loo=
kup_percpu_elem
Author: wojciech.gladysz@infogain.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux e=
478cf26c556e4ab572ab0ab2306c986901dcd61

The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee and access to it by anyone else i=
s unauthorized. If you are not the intended recipient, any disclosure, copy=
ing, distribution or any action taken or omitted to be taken based on it, i=
s strictly prohibited and may be unlawful.

