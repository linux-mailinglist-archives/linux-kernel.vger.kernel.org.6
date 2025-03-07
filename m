Return-Path: <linux-kernel+bounces-551512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA5AA56D74
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2235516DBC9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0076B23AE66;
	Fri,  7 Mar 2025 16:21:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD5D23A9A5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364464; cv=none; b=tLct+/Mv2pDhk06kfBNYrzaNkr0BnfGuKxU2GRz8MtyNBe7qN/uPKwnghiLQVfYZGqhC0lVsn4IBBpq+1knOc/fdDFplfrVhAgrvjGJz66YNPJwrEo+f46YrJdGO1m6WAH2aWZ+hVoY84YxXAnRn88Keho0KpVenFJNhVVH9VQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364464; c=relaxed/simple;
	bh=NtertMuEVLb4GQJzbCtunKWOV/Sy4gysXnmuTeY8Afc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Huq2Gx00UlWd6L2n3ywH+aTyBn/i6ae4t9kYB9IL1EF5h6OuyElwvC6Y9VkcZShTStiRhoOmeyzvQAqCx7On6fXpjElN9oOVLCNt2UNxNbSoKz0XEs5a0hQrV+hrFRUH6g/s9JtCA7/Kw5Lu67pE9CBc+rnb/p+tvUmPElyR6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d43c0dbe6aso33514645ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364462; x=1741969262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqoZmbhmrm3Wo0MivXF1llagCoU9e35MwSyCFLjrWUs=;
        b=RYCqvmtzJJ8hURJ3DU00bxiw7TQLDf/kHqsCZf7ljVHbA/z/pASKSyIfdC+QiwaiWU
         gvM7lQYVxNon1jmmFvPDzm7YdyOBlE1NBbpTqYda+u1b5I030JLN7jPKnZD7AvLUwP7N
         Kgt83udZ8PU8Hbq2h6xIg0eO4/x7hoE9rXG1V4my3A2HsKblOg3E9MRiwWl/NIfq7rbR
         qoSirDDW4QlewjsWSVZm0NPWrRfn6THsIysQJYtJ3mdJPJGMzUmM2KHTS1fIz7M3fGyi
         W9LzlZKfRUEL2UfoV42biJ9wkUzgtM7t/SH7Xl+DEgO8j9AE2J4uaWLyBxCA4RRqjZS9
         C5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXReD0MfRhJSaKiRUJTUL6ia8LrYSnTa41FYjSMTFjknwJGI572Foiuj6q6tvPSb3GJuMvk5i9EBoyzgJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIlcyhpjpIPwTZnHlOMsxo/Wh047lca5yV77YwnU3kCshSWWQb
	8NMJ7hYonlrdDKL7Rz6IzB8Ps3Gh5QZ239jw49sR7nakBkWbitTjw4YzdQQifcNIO1e3+uTTPcN
	F+HsIYla8VqIqnjJ5EE76USp0JgeROGkf21HwevM72v84qX0KtlBEnsE=
X-Google-Smtp-Source: AGHT+IE2nPYnITDZFp2SAZViHoxjw6aguupsRSsmbyNsC89hqZr0PErp4tSqaFr1UoOWuFXn55n8KZ94RFEwvPF2I/+bF0BN3faJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2168:b0:3d3:d28e:eae9 with SMTP id
 e9e14a558f8ab-3d44193d992mr52659425ab.7.1741364462402; Fri, 07 Mar 2025
 08:21:02 -0800 (PST)
Date: Fri, 07 Mar 2025 08:21:02 -0800
In-Reply-To: <CAOQ4uxizF1qGpC3+m47Y5C_NSMa84vbBRj6xg7_uS-BTJF0Ycw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cb1cee.050a0220.15b4b9.0082.GAE@google.com>
Subject: Re: [syzbot] [xfs?] WARNING in fsnotify_file_area_perm
From: syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, amir73il@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cem@kernel.org, chandan.babu@oracle.com, 
	djwong@kernel.org, jack@suse.cz, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file include/linux/fs.h
patch: **** unexpected end of file in patch



Tested on:

commit:         ea33db4d fsnotify: avoid possible deadlock with HSM ho..
git tree:       https://github.com/amir73il/linux fsnotify-fixes
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
dashboard link: https://syzkaller.appspot.com/bug?extid=7229071b47908b19d5b7
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16fe4878580000


