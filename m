Return-Path: <linux-kernel+bounces-299730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5129B95D95A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DD5283647
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACB81C8FB3;
	Fri, 23 Aug 2024 22:52:00 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC8195
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453519; cv=none; b=tQkuqTU+lulcJU4b5AFFh9x6nGFXbOFcbzdmwPMuOjyhBvePoupWwit3zB12RWr+L01la1HGD7VatupqBVF5EhIecb+PgYAJ1yI1a9xk6iYw11RCGniUh/9EYyBveXTsedQNRei2HjliBLXcBRmfFik5Cbkv7zo852zyv6kwrYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453519; c=relaxed/simple;
	bh=UHZ4k4sXI8iA4Q+OtANByRGQU42P2mSmohx3ySHV7uE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f5YSPmJp6HeiL5bifHCZnTkjaia7vB0VccSMS9Mvk0UTewufbBJH7q+2O0eScuCXG8Hus+Y0EKDbtxZWdl8xzs8HPGDUAhih3uZHrs/842jz7u1x3QfHRymgcn28T4krlM2Ce/0RG63GxRpN50kmK4v5/eoxo05lbqPQI/KAd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fb21a0e41so268224739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724453517; x=1725058317;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHZ4k4sXI8iA4Q+OtANByRGQU42P2mSmohx3ySHV7uE=;
        b=cNyYd6JevsvbcZNPBLLKk56BebDcJMC9WKFejr6sWlAl6MKKXcg1X0+07HH7gSE+5Q
         GXhx/mjyY9NlGyRysomMKc0y3FJI+OAW5p8rsYZfKv8a5PtMNotUwvbC7GPIufGvaU2+
         ax+DyI6OcLHg6CHvP6cKqb/j1DG73uml31oxaReD+OvG1G65mxeJhwRv9NTkEvObJMD0
         O3TbL/O0Vg/ojENWIPj7gzkZ+ulMFhFVezFEsitCqB7uK9LdF0vmx7fPUCCb1gjWQvgZ
         1VavOnemu+3qEoStwRib17q3WTdyt/Eqktx5dboxoQV6VVfcC8PkG6z4TZTDHgClopHy
         QU6Q==
X-Gm-Message-State: AOJu0YzZ0sqAIslOJRD2IGRGe+oXgyIUC/RWqWYtn3rF4hen2yMpazQ9
	DHNrJfCp/h+l0KG3Ww9gLuWJ97ZzL4AIt6TeTpOtdwY0NDR0/Fb3SQc2rgae+5G0ZCT6tCcFyi9
	UyynSj17iYDIYKaRJmJPHPu7TCcSzFaLxkcN8PKbYcCiV6KW8oGl2Pw0=
X-Google-Smtp-Source: AGHT+IHTkGYvBermg+R7JXzk8iAoGhvEfNffWZtjlHJ5CvSvxFDE0ASe/ibUpUvliWnaw1UP5TGfnolf7stNU6vpenHmomo+QsfG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:39d:1ca5:3903 with SMTP id
 e9e14a558f8ab-39e3c97a19bmr2366715ab.1.1724453517514; Fri, 23 Aug 2024
 15:51:57 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:51:57 -0700
In-Reply-To: <000000000000aa7cb106196f6883@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057e7f90620619f2f@google.com>
Subject: Re: [syzbot] possible deadlock in bch2_gc_mark_key
From: syzbot <syzbot+050e797ad21ccc3f5d1a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible deadlock in bch2_gc_mark_key
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: bch2_gc_btree() should not use btree_root_lock

