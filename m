Return-Path: <linux-kernel+bounces-574614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6194A6E7AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA8B3B7FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5861474A9;
	Tue, 25 Mar 2025 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0fGFTeR"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C0131E49
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863290; cv=none; b=SEmQyFtC3josQXhPLg/BUP3pViBRBpHg+qBmue3S7CT2T1RTvuZabJ40a3wZQHHjI7a9IW1pT7S0T5CEWOY/rvoQOKYwBr/p0di1Y7D7TlamQv+CTt4kXDp0u5LunXpnnfUaMeLrgCsOr02ZQe+XZgYXSaXkWuLl3TqKfO03V64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863290; c=relaxed/simple;
	bh=od0QfR0rMpPGF69S83HSS5agtIrZpU6vMWxsKpfJueQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of15l/rh6O0rtADgm/8mUzeaoWvu+mYii32+OCI2G8JxtwLm2qFvCRmc9zPluXBYxuGKaNFqTylXns1BUfTW2nnEMqtRjG7TiFNnpB35wRzGmaLW+rRusZ+fTaguFlQukOlEsE/pr4TmfOBf2kGOsKAHFVpUCxcb9gOxiFQ/ajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0fGFTeR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2242ac37caeso57835ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742863288; x=1743468088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5AgxujU80WPjHOiNMttbooT2HjhmtlQKYvMc5RvT68=;
        b=S0fGFTeRUmFfN6gUK+EH9/R8rhiw5Au2GhaOCQp0xcwG4ebaF3uT6EGCjcsI1ZmgG0
         ZDB8RV06CoI/b5L6U3gDoVNMk/68wpBJmhqqEv0Q5tH/zwfNj/OI7+0K6oO4m1DhRDzp
         FrnDzRieRlby9NFpLCAc/mXoKzcNTnxQDJdErKmsSO7ydwX3FJpvyle35Mx8nAGESI/R
         XEe+dEHtj1ZFSZGw7x0xLhi1kX7fMNLU7KAKfXRnjKBIbZAVpYjU4lwBuGL9g9t91AVP
         7A3nAoQ5FHONQPqLFYmKSZRb424an1Uaz++7Ed29+b3xmgnigyqOMkYCMwK0rc2xUlAu
         Yghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742863288; x=1743468088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5AgxujU80WPjHOiNMttbooT2HjhmtlQKYvMc5RvT68=;
        b=EHLknjjhOPW1zX7YJv2x6h8UbmJo2tqZzBEXfv+6x9tMYAJiORZ69iNoV8FFXDk1XA
         ryL9hYPMUJGHPs7pNsHYEUGDV8C7Ayrgiv6gfFpTzWa86jGh/luDYpcEkKbXdm2TJmNp
         lkmsL4x+TxjDv09ryU4rXKzNdGM9Hqv3YxiCM5y6V2AkutKBEERCttk5WTtpg5G/dCy9
         7d+UtpSdrrQDQruQAaaMEDVw72KIWPS0jmOyxWmlue1KIDyYbWUC50bGhktXP7lGHR3Y
         4alu2mAl1jMJz1yd5hzZUcFSVLct2vhqfAAbTbP4Kg/A3j3EyaeXE5zqqojFjzw4qjIo
         6Uig==
X-Forwarded-Encrypted: i=1; AJvYcCUtzqBJNzeR1oIOPxoVi8tUsdzxbtC5oJlp7xpBzlrrf3fLLJCfsvWNAr/hF2VKeJxL6+R1ZbElNIr6X2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YywO8IDCPO45DoT1nHi5cuicQ46tuOOFig3qR+lwuPKF2E9fYr/
	3YpV7BGudVBLHvBeJZ11r18bvuOghHqNG7kaDuS5/DhLi0liyN45NCQhtD107Q==
X-Gm-Gg: ASbGnctZ6gvmqnGOKxSis2D+OfkDtKx/akOb9fWzLt+gp104bQKk3KKT2WaOkck8AZh
	6OLhFRewVhIW3bVz9gGN5Fj1cHCvjSggLAwIdW94vdJOGUWiyhdi7K11GmQ9URC01hGG8pftkQK
	FQCiBwZXuQ/0gV9yzqsdplpBG6xT9YWT58DdpLwACdndpMbT+2ZsSVVdHy2Dp5z+tGXGLEeQ5f1
	AZMNxFPBpeWB12E47c5sgA3TRNTMqJVtP+iwCl8IlomdVhO1TYx5PgIsOVdypAa5dceVywXauTh
	NbVSNqQGdncx+fHPeutIIKNkH0MtKsw/MQ7DiPdSQEG0159rrjTc4qeL228deFyp36qjWWRgdXF
	j6s7L
X-Google-Smtp-Source: AGHT+IGrZBFaeieRCmTP3gjP5aoOgcPn4pgOdQ8TEhXOPZ3mj95Nt5nZxAwI2yCtLfLUGmohjjKldA==
X-Received: by 2002:a17:902:f607:b0:217:8612:b690 with SMTP id d9443c01a7336-227982a7b83mr6963725ad.8.1742863288141;
        Mon, 24 Mar 2025 17:41:28 -0700 (PDT)
Received: from google.com (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd6dabsm9023593b3a.69.2025.03.24.17.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:41:27 -0700 (PDT)
Date: Tue, 25 Mar 2025 00:41:23 +0000
From: Carlos Llamas <cmllamas@google.com>
To: syzbot <syzbot+799a2d4576c454ac2693@syzkaller.appspotmail.com>
Cc: arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	maco@android.com, surenb@google.com,
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Subject: Re: [syzbot] [kernel?] possible deadlock in binder_alloc_free_page
Message-ID: <Z-H7sxU0WoeOpcef@google.com>
References: <6782483e.050a0220.216c54.001d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6782483e.050a0220.216c54.001d.GAE@google.com>

On Sat, Jan 11, 2025 at 02:30:22AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7b4b9bf203da Add linux-next specific files for 20250107
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17d02dc4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=63fa2c9d5e12faef
> dashboard link: https://syzkaller.appspot.com/bug?extid=799a2d4576c454ac2693
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10302dc4580000

This was fixed by a new version of commit e8f32ff00a66 ("mm: replace
vm_lock and detached flag with a reference count"), making this report
now obsolete.

#syz invalid

