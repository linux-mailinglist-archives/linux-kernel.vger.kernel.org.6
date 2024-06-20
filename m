Return-Path: <linux-kernel+bounces-222071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D9690FC75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB65F286F62
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DDA38FA5;
	Thu, 20 Jun 2024 05:59:43 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78538381DE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863182; cv=none; b=ArtxKgqkKy2Q8SjrY3iJ0NFNzleZ4tHiTS5IqmsKHQFh+OlKg8xOA+oPom/c0P0xwEj5//b7LBCaP2LhkofrztpbFX1LQF3aBVxa45cIuJwpthHIhxU9v78un+5Fw71UaAkiU/s2g50NDiQ7J/uwy0w/QVrKrD+sMHY+mhK364Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863182; c=relaxed/simple;
	bh=a7rwMT1WFkgLc//fv1f3LCgWK42Ug4eFDEFwqYZmBMo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=dGFV1CiHEBRe45wTRRlvXay7win/S/bx/oOv2ckUnXHRpe0SCLVGsbQ5A0Wck8XqaPJ7ETXunCZi0jg+bZZUmosnEO2pUckOUGeQYQe9mhs3wqyeRyzG9lD43Tt2hTDU2e3LN7/zPYcGWtGJyNDhs/qUUVAcGRZN+5o0R2wceQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eee7741583so64484939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 22:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718863180; x=1719467980;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7rwMT1WFkgLc//fv1f3LCgWK42Ug4eFDEFwqYZmBMo=;
        b=Zh2n026iNMzTsVIm4ViQEsD1vcFm9O613uWco4hpaDTnTKdCB+bEHcHLIL66Swh4SA
         EhkJ6DgqIXizj/7ZILaEq7/qu7+6MPg00owjEYIVrkTz05hqtFXcG2yP89LDF0YEa0uD
         emNgpk81T1A+NE7IcFOuDFcswHPT5cdc8SB3Yg4SkRLUZGOt54a75XAhGK8ACp2Dc+uD
         EftsXJm+IRQskknIg393CJ4Nf3YciI4esUjxKvDbp0NvvJ6fG7yItYhH4em6m3SYUZIK
         Ux51XV9UgUZizOx0IiE4cm+HWLmOYsTL5ZhGEic/JFN7vo+LCGkfz4HPGc+YH7+UyaJp
         Pg5g==
X-Forwarded-Encrypted: i=1; AJvYcCXy2SAQBQ0dgvMXNoj7Y1sXbCHZuYruJ9dnLB1lN9pepQLnQXb/BDAP6pMngABlyrYuVgDvCecVa3UH8xaE5yNA5BIbHmUTSKpNu9o+
X-Gm-Message-State: AOJu0YwBGuXLvOemvJEjFFZvKCkL968av8yD2C9PjbNU+MSTGF6lSiZF
	hGXSkENhVeUylagxqBIStJ8TcueWU8NBwIWGpSVbxeIlMvYB8GlbdsvBgCT9OT6RinjMa9QCZkN
	WQ4lAkvXcN9UE9/6VpfjaxsY2BGdIs3ShkRMuyu++IJDT5WmYnl+kL8Y=
X-Google-Smtp-Source: AGHT+IFQ+fYoYhL6ECmr0r4vfmieLqKNzHapPNbXtQ9byG7JPqUEC7N4MgSKiiuQ+Ddrw9YcK58myN9OuyW+y9aetpVJdGdVCmnR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6422:b0:7eb:8ba1:af5 with SMTP id
 ca18e2360f4ac-7f13ee0c25dmr10098939f.1.1718863180614; Wed, 19 Jun 2024
 22:59:40 -0700 (PDT)
Date: Wed, 19 Jun 2024 22:59:40 -0700
In-Reply-To: <PN2PR01MB48915169F16CB698728A7F74FCC82@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c64be061b4c0578@google.com>
Subject: Re: KMSAN: uninit-value in sock_hash_delete_elem
From: syzbot <syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com>
To: wojciech.gladysz@infogain.com
Cc: wojciech.gladysz@infogain.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux

want either no args or 2 args (repo, branch), got 59

> The information in this email is confidential and may be legally privileg=
ed. It is intended solely for the addressee and access to it by anyone else=
 is unauthorized. If you are not the intended recipient, any disclosure, co=
pying, distribution or any action taken or omitted to be taken based on it,=
 is strictly prohibited and may be unlawful.

