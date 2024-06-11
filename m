Return-Path: <linux-kernel+bounces-209715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C619039CB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5731C21BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC59179203;
	Tue, 11 Jun 2024 11:17:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4713E8AE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104649; cv=none; b=n4+OsWi7K/W22fagiFqRPHneujQ4KzdRZ9Y+2CZJaFAfJdY6hekZ5Fp6fwpwLmdyi/+LJzUsbXS8HQhAEKZ8FE7zal74voEK90QXjYRAGX72HMJ94pVYdl5pzNdSpuiG6pZkpL6AD9FU1IsWNfCeC6jTk0XXPbU1B1RVTP4th0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104649; c=relaxed/simple;
	bh=H5hfJES+y6/fEUd4HOft3N27puzOeOCO6FPSaDwlL2M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Vteb4qlB4jg6gJg1XKtIu8aq15ZHV93tE4Q9HuJ0xhvGIlh5fDFN1Iqghs6sqVG/ZjHvij/kGiQKsP1norxnJ5jRolItYVPVsemVTOv3RhbZZoBBJjdTYAsuSAn0XvonrJeZ4VPOBqxmKZYpPwmOfsZoZLaUjVpbp6Bp+dd0n78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-37586a82295so39706105ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718104647; x=1718709447;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5hfJES+y6/fEUd4HOft3N27puzOeOCO6FPSaDwlL2M=;
        b=k6+0KlGxQUt0WsgL4n4MdN6YSaecUCWgSgc8FNfkYEAyt2YBMjPu/S1YGk+g95kdXp
         jYvEE5KkxQkZlYLlV/QXgV7B3dD6UkL/MQJOIzAyfOsrKEAXnvM9dklTcexmdxzv2rzp
         4HqcrITErGgJSJ69ubTJ2DEZzR9JSHR/U5yE6sTUq+GELx0wnBNBbopwmNXBfh3uZnNa
         FLZU/48HkUwbWn3x16PsYbnWnAeh1Y9M391E1dCDts2/mpm1jWP9xhx22RkfM4Ab0UKo
         j21hTFJebH9UCJ9yWYCs4rCZzJ/XFJFyjls0emqMbGfT0vmqqElmCMq3VpL046V/yQxs
         z9Cg==
X-Gm-Message-State: AOJu0Ywh7K40SI23O4aYaDUeGZFQDiicKf7G80RALVeRyiLm7FqVgEqB
	PCq4xZ1sAsWD7r47zPew3goh0daCYa8ZM0xS2wnDukxLv/bG8rTGcP0AOqzIxV8GBrN2GJThWus
	BiJJl98+5XNXK6YJIoy/kQ+B4hkO5KzFi/UAtwhUjsZFwKmoNQlUML40=
X-Google-Smtp-Source: AGHT+IHVeRPvAyxFfl/sBM47RWmZbNCjpCZKSLhMvg8931swg5ddNqhG52owZgq4GDYhnKmAXu/cAv68I0TfMAO8j5V91SAmrDOB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f0e:b0:375:9deb:ceb8 with SMTP id
 e9e14a558f8ab-3759debd2d8mr2933905ab.3.1718104646938; Tue, 11 Jun 2024
 04:17:26 -0700 (PDT)
Date: Tue, 11 Jun 2024 04:17:26 -0700
In-Reply-To: <0000000000008312ad06163b7225@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b042d061a9b695c@google.com>
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

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux 9=
56a9878a57078fafea171ded9cff2ad5352f446
The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee and access to it by anyone else i=
s unauthorized. If you are not the intended recipient, any disclosure, copy=
ing, distribution or any action taken or omitted to be taken based on it, i=
s strictly prohibited and may be unlawful.

