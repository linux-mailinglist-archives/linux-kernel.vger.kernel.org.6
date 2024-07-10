Return-Path: <linux-kernel+bounces-247020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F63492CA03
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3C12833D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7F94AEEA;
	Wed, 10 Jul 2024 04:48:37 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17AF46542
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720586916; cv=none; b=cQzc0r93eYumospcX0/NaoAbPbtoPtCNkRtzIAMcr5uXvLBEVCjg8HihCJli+fmWKVPaT2dJT49m6+J1pQGvaUIBimVRNxrm1HBuVTrZCRVSSrCSMedhkPT7/Z0Hdguv8w/MFTDoqGcm1kM/vsVwmzAk+ca3cKAR6vZFR37v7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720586916; c=relaxed/simple;
	bh=WVFH6uwcMIYyE0zqWdYgh/RIFDJcAYHNlvOWOEQx0Bc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ry5CjLwSv/UMv1mUHtcHgkqNAfsN/qEBuNPrPmF/kPhR9fvvo6LRNapeNbRXD0/bJKcguccbuk76cU5ZIjUrh0YuqzbV2eDUPgAFXBzRrE6fAl7RlgUeSwmOhACDNLKBnKLtfXQY7NuF8SfHfcJfisktcmUkd1ERg71CK5iT9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-804b8301480so30687739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 21:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720586915; x=1721191715;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVFH6uwcMIYyE0zqWdYgh/RIFDJcAYHNlvOWOEQx0Bc=;
        b=X+PNzCzsrKuS1L1mPjnqp6973eHRHBY3ncKkYcIi9O/geg/aOyqAOLoFZ2Ib0o6f0x
         V8MifXa9ZNNIY1v5tU6hxv6OUGNCi7SeWM44EfKgoakdCBITQeQKo75IgCRhk7h+gaVE
         5B1vE6o734c1irLpzsCOS8zsViBcbCD9Js24BCeoIiC0zkwPi5z32nvPzSgQXWZD9tKj
         rf5vhnQcs4JKghH2VVOM4r7IH4F01ty0+weIgZTYV+87cOqj8DItWZ6n2XZpvx5YaLsK
         81jWJbQUjog2+1+eZ45yfZKfLx+zO9hdaJnlp7VHy1h6SdHDD4dkaf5dguH998mTlZE/
         tkrw==
X-Gm-Message-State: AOJu0YzoXUTM1XVkf+wkisrJ8D8CupQjClgfEbsgI9vJ7xFIShySEBkl
	eAonebaKhuC8CMdkgyIdOo7/XHt8rU1DplmDF/q4yTxOoGzdaAdo4SlNiVp20G2ZMok61ncnEEY
	cmcVur24XH4JA/XpIQbRKq0oks2RSdvA02wVlwtw8IrVfo1DGCcavy7U=
X-Google-Smtp-Source: AGHT+IGf2fd/QjW2nwOEuKG9NAAQh0DvnvZwQSAu1idLRhtcllg4Qm9X827oaGAr8tITXQldauVJDEH/WDutMFTF6sHv516+uZy+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d0c:b0:7fe:3630:f857 with SMTP id
 ca18e2360f4ac-80004174e91mr27321739f.3.1720586914920; Tue, 09 Jul 2024
 21:48:34 -0700 (PDT)
Date: Tue, 09 Jul 2024 21:48:34 -0700
In-Reply-To: <000000000000ee4d7c061cd1c21f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de8fbb061cdd5bf0@google.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in bch2_bucket_ref_update
From: syzbot <syzbot+e74fea078710bbca6f4b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: WARNING: suspicious RCU usage in bch2_bucket_ref_update
Author: peili.dev@gmail.com

#syz test

