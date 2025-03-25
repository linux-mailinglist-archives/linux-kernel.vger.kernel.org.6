Return-Path: <linux-kernel+bounces-574634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 606E8A6E7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2171886474
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C94219E4;
	Tue, 25 Mar 2025 01:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3VcojmvZ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185152AF03
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742864630; cv=none; b=WFOGjCClotzPHpP1Jf6pHIx+ps0lgI8xAckgpR4y7St81ZS7MIM9y2aIcxIjSWX0NymUVHVu76Cw+HJQ1dviZSD6bvRL25N1eM8exUc6eewOSy0sPLXhWLRRdZWq1C9Pu6ToF4IGfi9mE/vEvJMwNiTFPg3iFrO7CMd/9+60rg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742864630; c=relaxed/simple;
	bh=kHUhABQOm7Kka+TGj3FObkGV73KqsEx5RM4qqkDTdVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+cC3IdTOku6w5brSpzvPmVV3kFdg9H+BMzs7cHKFzLt6HbGr+tkB84CADpSk76St/YYiTTmv74jG295M9faicGF4Z2VoRG/b2hLKdmmw3Mqjumzxj46LIf2poBrtHDuZLIzSPPWTcRFLd5boDzNO1tmzjI0OiSoY8FO1bBnmNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3VcojmvZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240aad70f2so122465ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742864628; x=1743469428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=18CLDqkysgNvN75njuQO9+PaQmWsG+3H73QaakQSKdw=;
        b=3VcojmvZGvPyZ3HpPbS/wczJmYpHoCKA+5oR3o7OPHkvub1Z8WK/VJb76pMRMIJ6/8
         t6F0L4LGpuXQc8VwnVzfONIt3uFUWCO5ZtIhEIUCQiYJ9LXysdgf4S7RW4c3Vp67kU7t
         yZ6aS/v3WAaDfzOqcqBgEMyHEkHLyAIJwV0QAiGHyOA8qDY6TRrWYCyaXHsQgnuIRIZV
         Pn6vnGmeRsRGKMneMI7YSyDazEwGclB5huTQc8Of66H8Rb21CwfLFrcpPW0iqZJb0jvy
         apijrUk/dJW8MdSB3ZLnfwAeswKA1HyttE1k+oGoN1O7fs8tombe2kaZtgsyxkB+6tQT
         Ka4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742864628; x=1743469428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18CLDqkysgNvN75njuQO9+PaQmWsG+3H73QaakQSKdw=;
        b=gzxY+hHy9tdAlMXN6xj5/YDHtfRwnujncf5YCuWjbk1KHaCLCIBKihz6fbg2YebjXF
         Nz+X3CygJnVvJi2MBMg2FQk0kEwcEv+H9pl1GTocCzkMs+lepuh0xiv7JSH1yJjirOAd
         QM85IE3t3+Di3V+1sHriYCycnBdD/YcsiB9X31yqKKG96aVso3HNDKpn2xtxgS+w8LRx
         R31WK38EMZ+V/tA5KSdctiaIC4Tt14PHZlv37+sWsvsWDLCNGeF9WinUz5ukorgjIB3a
         oR/ukxxZqd9HzJRu+qD5QeR5/gTNb6j/tetTyCBL7GJvcxRfwwh9VDEGhghjsuSQPhvI
         u0+w==
X-Forwarded-Encrypted: i=1; AJvYcCX2TAh9Cj2WaIIPR/vpeObeDrMXz3OnVMQ2G5SKzVr9COgkiq96HAJPvkpwPSATYl6E24mJxQWz5QDQuxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmnu4vf3OuJeukwer6DnpVWyYTJUrEoe12wKA5X0jGn1jUnfLS
	W1ihu6zNDoM0V6bMKNPyWVfG/xbJ8m+Dj3u7bFC+L7otaPc73lxeEMIEt48Ixg==
X-Gm-Gg: ASbGncu7i5w/TT1NESJuzBXdlU0QwHQE/eksh8PvMuiF0zUN1B0XOIVy4bNp9zw0Cjk
	bw+FVlcXcVTb/Hrhg5IB4zr14YMrGNTRJe6jWs9wFyX4Jdd5kD9sPXO2ZYvkJlL95sORTevl+p6
	zphZ3TAoqxr2AP3XOn0yrRXXiqHD3U2csP15hJXvsR4PUp3JqUsB1R57VfO96XvZCMWEOK5I/Tw
	0wA1NFgQuDs9ymo4Zwn4qL2kWtCvWJ81b7cWSXiPAk9n7zEQp8WVgATgILmNRItUAMsoRPLK5kF
	/CvbPAvkHbtu6lXCGDud7+Qmba3dh3X3Lv7CKWyb5TZEyBBJTUlN463j9ZVG3GAC0lkE2NITXxl
	OxRQ4Tg1LmDAotE4=
X-Google-Smtp-Source: AGHT+IFTsKJjoqf/HYydRllS6N6S5nLgxpQoK6xrs0UCFAsBv6WP1eGUThEBJ/LdWiji5edEtMzR5g==
X-Received: by 2002:a17:902:ced1:b0:224:6c8:8d84 with SMTP id d9443c01a7336-227982a822amr5910585ad.4.1742864627927;
        Mon, 24 Mar 2025 18:03:47 -0700 (PDT)
Received: from google.com (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fab72asm8740045b3a.27.2025.03.24.18.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 18:03:47 -0700 (PDT)
Date: Tue, 25 Mar 2025 01:03:43 +0000
From: Carlos Llamas <cmllamas@google.com>
To: syzbot <syzbot+810b8555076779a07399@syzkaller.appspotmail.com>
Cc: arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	maco@android.com, surenb@google.com,
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Write in
 binder_add_device
Message-ID: <Z-IA7ztxy-EduTcy@google.com>
References: <Z-H__dbcSB4htqUZ@google.com>
 <67e20003.050a0220.a7ebc.0034.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e20003.050a0220.a7ebc.0034.GAE@google.com>

On Mon, Mar 24, 2025 at 05:59:47PM -0700, syzbot wrote:
> > On Mon, Mar 24, 2025 at 05:49:53PM -0700, syzbot wrote:
> >> > On Sun, Mar 16, 2025 at 03:51:27PM -0700, syzbot wrote:
> >> >> Hello,
> >> >> 
> >> >> syzbot found the following issue on:
> >> >> 
> >> >> HEAD commit:    b7f94fcf5546 Merge tag 'sched_ext-for-6.14-rc6-fixes' of g..
> >> >> git tree:       upstream
> >> >> console output: https://syzkaller.appspot.com/x/log.txt?x=134f303f980000
> >> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=cdc24cb631dc9bc4
> >> >> dashboard link: https://syzkaller.appspot.com/bug?extid=810b8555076779a07399
> >> >> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> >> >
> >> > #syz test
> >> 
> >> This crash does not have a reproducer. I cannot test it.
> >
> > This is likely another version of this report:
> > https://syzkaller.appspot.com/bug?extid=353d7b75658a95aa955a
> > where access to the binder_devices list is unprotected.
> >
> > #syz dup: slab-use-after-free Write in binderfs_evict_inode
> 
> can't find the dup bug

ok, how about:

#syz dup: upstream test error: KASAN: slab-use-after-free Write in binderfs_evict_inode

