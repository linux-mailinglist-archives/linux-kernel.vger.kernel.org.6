Return-Path: <linux-kernel+bounces-406294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6967F9C60C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30389B2B192
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1DC2036EE;
	Tue, 12 Nov 2024 16:15:01 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BA7202F84
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428101; cv=none; b=LTyEf45c5UtJUS2b4eeKQ+wHA8zOhsK9wzMW2lq9/zhZlC568c16QdvFYT0tZyzety/R81odg0KH2X0cQCimTG+F4VpcwC5FkoOT4xWrJGTcgUkzbjG4GCTrMlPY6NdPyPzXoIs0o9YU5AbCgFb7YK6t4LdgLONxZPg0Rxns13w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428101; c=relaxed/simple;
	bh=wet4GcyKcPBYQGsQ+XIpVWvHP1vYW5cW0Gua9cBX5eA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aHwaSGkJ51xicx7qbeYl34dbY320W3JGGKTZ9E3/DcaNYMjRxL7oZuc6PTQNOuTvoOgB9HEIFPUr/1UHaM58daMzNAge2ba26aBZyObgXf8gonlC4MnMrQoQA6vV9cvsgSlDSQtJipVqmNRTRfgSZvkfThcUXLybUT5rCrI+FRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6a9cb7efdso59005555ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:14:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731428099; x=1732032899;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wet4GcyKcPBYQGsQ+XIpVWvHP1vYW5cW0Gua9cBX5eA=;
        b=EtEtqoLbxZKBil2bqdQ3Z+bqr0PlbSkZDgQUCKqFp1Ss3uj2rhLNiEtdlWJVowPEKi
         olQdmS4VHgLS/7mXh9r2NnNLbXjIL0ok3eKGB2WWqcnWCTHZE+iQtd11u+Vukik/Lso4
         PouLDEEWY8aFSeNvnV5WEgbFeJlT4ITefc9pS2OOZOIufrvPX03qkT6H+TJMHy0h8tYo
         VnXN4t9fY7xUcaKASogCUUWCANM2PfudrzJdOhRIx2g+9D2DYgG/0BYcfsX5dbhnXN7K
         WjKxdCuizIQhdb9KgHJJlCNcgkopMadeBq6U01hizwEcs0MuNYLRA+125O3gDbBPPrKP
         Wkng==
X-Gm-Message-State: AOJu0YzWtgE8f7zK9aJ1RS4a9ss7KowVhWUnQfEWifemo4DrR3fpKYt9
	S1Q1XeH+mW/4iMyLJSufgt2PAwWG80B6a3H1TXRMeaD8YK9Xo6F+ZtM5Ct+mvD/VZru/+BDml9V
	MVOgUsAD1Xd515ugDjqhM7m0NUrG4qSRWanRuXszDNW4c9Q3HnT4OH2s=
X-Google-Smtp-Source: AGHT+IEIzs48lwV24oamVLLjqtBHvTJwkREIsNcdSfFdpaXY1iI9UopY6S1iDUrSNHeUGcqgz++r5nZ0rh5FnPhwLEQLtUG2edwh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:501:0:b0:3a6:b445:dc92 with SMTP id
 e9e14a558f8ab-3a6f19a0823mr138995785ab.10.1731428098782; Tue, 12 Nov 2024
 08:14:58 -0800 (PST)
Date: Tue, 12 Nov 2024 08:14:58 -0800
In-Reply-To: <66fbc081.050a0220.6bad9.0056.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67337f02.050a0220.a0661.0420.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in __hfs_ext_cache_extent (2)
Author: gianf.trad@gmail.com

#syz test

