Return-Path: <linux-kernel+bounces-400982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9700D9C14A0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B1C1C22513
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457C94962C;
	Fri,  8 Nov 2024 03:28:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A53D11187
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 03:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731036503; cv=none; b=DB4AgRd149skCYe4cD5xnjOnJ6yA4D3QPC5MhDw0hLEsP2GTdYlfZ0LV9gyK3LWYF6lnwj4CVPiwA5k4OWo57ubZmUAkM2ge23yFhW3TagXfgWKx5i7+L3qLQCjdcHRZIo9IoaP8Kfy9W0WIWO44S10HV+w4ORDf33t9zseP9xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731036503; c=relaxed/simple;
	bh=DMvGmfEDvtElgqHmXKOgpSbLud9yAAR8K01mbx3UyNo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ghjf123RQXrLlnBKCA7cKGb6u6/Q43910b3ZyQgemPGLUyr73Isst4DJBque7HEl1Fzz/vmCgVHosYSc4zn6vDR0gP7inUITAZDTCRqIZzhvMpelZWQd1UVaSbuDrgzioKa3mN0dhSCkVn8Yrrrw8UiVWa3zIyMpaZa8d61BGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso21441725ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 19:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731036501; x=1731641301;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlFBqFKm0gW3F5gYh+mJb1nrd1ShSOYEgH021LpBOnI=;
        b=Af+HXmnFQHo7yha4YIRqaVIp0+W3ADOM2md24E29dYQugthev3TUBeLI/9Vtppx3Wf
         FEE8jqOv0Ulyk8eKUCIFExG0ZVn7rbGf/VvkcU3AglRf2qU75gJJMGQmYhdIf8X2LDxS
         shS0lIHDIq1oPzJq7/nYrjXgxqJ8S7OvPyanOo04m6G1DHNvTx//kro9d6SxeTwgwwzN
         glmZDEYxH4x/s1/vGEEbWNQfyzapK1OB38pFlOOsBM2MJMnzpbV/L2O2t9AjPdt6/vZs
         eXv49USUbdfD+Kf0HIaWUMJhfGOFmwD8TRmfOFOqCwC2JTR0+ekBtalOzPL2Q+CZKUIs
         0pvw==
X-Gm-Message-State: AOJu0YysfWI7KcOfvOGoTbkXTWFIXZJ5xzF3CL/fadbHz7PtvEezNO5/
	7+zh/O80bJgcLT/lfpmo9Or4wtkiACXx4Q0QQ//qPpODlser70TU+b0hZWYG7LlgD3tyAuhpJDo
	/o8GBFN4E8Z6QJhtZTq16nfnZoD5hzuBNXdxP4Dsl5YRqOO0MBCidnYQ=
X-Google-Smtp-Source: AGHT+IHhn/o8tkhb4NhUcMBrdGxDIIju0aa/65FA87sGLrIuJP7Z5i5I2epGQsyFpkKkHj+lDBQO51/nmIcY6cqJ35+okVuh8A27
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2148:b0:3a6:c651:3dad with SMTP id
 e9e14a558f8ab-3a6f19c5ef5mr22305925ab.11.1731036501675; Thu, 07 Nov 2024
 19:28:21 -0800 (PST)
Date: Thu, 07 Nov 2024 19:28:21 -0800
In-Reply-To: <671b3f3d.050a0220.2eb763.00d3.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d8555.050a0220.0db4.01bb.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+859300e61790263514a3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: bch2_btree_write_buffer_flush_going_ro()

