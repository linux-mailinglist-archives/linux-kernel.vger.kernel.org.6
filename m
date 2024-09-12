Return-Path: <linux-kernel+bounces-325925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 629E9975FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0429B23CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20218757C;
	Thu, 12 Sep 2024 03:48:12 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA4187843
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726112892; cv=none; b=rsf3wDFbGz2j4vtshP28tQhdknNqN2MuomqW8VyYVAVvSGJ7ZPFpIPN9USbAal2oDBkjaeIv8BCEQpi4dwwp5nmXlZJc3/awyiGigBitKO/8KGemmWHMXjO2Bj7cuGnXPBoeKC7uWmIA1ar2UaaFYri2szK0qoFS2tKrY33M7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726112892; c=relaxed/simple;
	bh=0MK/c4GAV+zHtqdHxd6jibO7cEO+KxZra4XqwgHHVNw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KSiZjtZHEGgvHZIak/l/3DivlQTetoE7yWCXnpZ0+A9nnNjxW37RfufAY3VI9phuFyfVCQqPPXuyzt55jYqsw0JnD23LTQQ0TGXyjvdMkKSVfnefq20HtazxV2Ac8GsRBDjQYC5OWREy9LXYnxaB0Fo+t2yq1cWICw/PtlJsrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0541f519dso10538535ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726112890; x=1726717690;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MK/c4GAV+zHtqdHxd6jibO7cEO+KxZra4XqwgHHVNw=;
        b=RgNzmC+kwUMEPW/w5yjq42l4GXyaJam0SfqgMAKISGm3ErONeVwX+aOXAb6Nx8KoNU
         6muQ+TRaHg2NYvd2hsxgTFokD1uJ9XYDb4H9OysKxd/FRf6rlOZDGvFS7/pZRNHnycLE
         MjqiCn2Hh1du2KhABoEVe8u2gHIAO3/u96KuggJx3WIRlJxEDkyu6SJTQJ+E6craC+SU
         qPLzl8tNwJPCXaXOqRgOMaCtDgDy0qLfpA+V81Nv+5hZ+EsPzhv8w5iuXb0db0vxaVVQ
         1uNXKUE3VwdC9lCj9FUnQOokUS6qw5BltQt/mr2+WDF02K8XhKAgB6ZIeJu7b1uWOAb0
         KjUg==
X-Gm-Message-State: AOJu0YyAZn13zX81GPPFVDHBzhDMkOejapWy0M8iukFNPi80d6Vc4Pgf
	8xwrMXtZK4jIRpoox1exAEVvqJg5KhJEKUgF5emVacgby1byo4KH101ZN4DKB1qGOfW4RVW7NVj
	KRs60jBy5SibtRkdCYpXCK+TCZCmS9fBVI+nf1p25rbllvyopwNXtHgk=
X-Google-Smtp-Source: AGHT+IEgk1tiDcr3rn+8JhKAwECFkk0IV6HpX1kQ02egzrOTeXodPFgXZvI6zgqN3PYJ3khy8KZyoVmwrj2Z2Y5JQMzQfE/INsVe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2d:b0:39d:4c8a:370d with SMTP id
 e9e14a558f8ab-3a084933c7emr15087235ab.18.1726112890004; Wed, 11 Sep 2024
 20:48:10 -0700 (PDT)
Date: Wed, 11 Sep 2024 20:48:09 -0700
In-Reply-To: <0000000000002e944b061bcfd65f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6b69d0621e3f93f@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] [s390?] possible deadlock in smc_vlan_by_tcpsk
From: syzbot <syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] [s390?] possible deadlock in smc_vlan_by_tcpsk
Author: alibuda@linux.alibaba.com



#syz test

