Return-Path: <linux-kernel+bounces-299274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2452795D237
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F691C22759
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E3F18A94F;
	Fri, 23 Aug 2024 15:59:15 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED91885BE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428755; cv=none; b=Ws1WCV5RE0X3fDCP5zhbtQ3/a3MUr6TJjAYSDzI6Is31pu1M6oLnBDWro82yL0kTdqcQIaiRO7hHbZQfm8bEngx4IywpgeQTnmz35UvOAG81zKl+X7ZBDB8tZ0TsRFow+OgPDXemZBGuAEivAiUtDiuY+ZBSKFc7JqUK8MV+KZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428755; c=relaxed/simple;
	bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=EK0FcH1PEFVVSQDn1Yg2iXaooCZY2ZeOvkpaBrP14ra1bff3mbcloCKWODnuQdGtEsF2MD66709IojK6/pRXKYzibMhXQqTzQWTG+00ncRnugmXNy290jEURgN6X5tvllnu7Uajt0KS4Rqhy11Q9YaN/41RFnvMD65TzUc7qyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d415635e6so23477405ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428753; x=1725033553;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
        b=QBjYKwd5Me0RUmpk1K8KtK0zqKtTPQ17N22CKQOUJi5G3tygATFFfSW3bCBEHEPhMP
         3ngZhY1tAkooHRgxGEDxkV01jJYFfvO2GiHjzkPKvlAoin86ZlqGqO2kUVYsuq626Z8o
         nl8H1dzU2yugtscUaATwmYq65W0uzlduGIcqFczghf5cr3MDzY3Xq4HngkwUpb3JTd3L
         h+RL4Kfx/FQOihVPpgobO+e1VVA8buXjOHbT2Yumb+hAEWBQzo/kXvZn0UM9nvfI5GpA
         ieCYY0SqjtJQkpSLsheIuxW18HOVTMIFFbF5HJBOW80jrbsRO7ym2dEfLvHc+pG7twqa
         dMmA==
X-Forwarded-Encrypted: i=1; AJvYcCXxcO4CNGqz9nLEv8djeYjVTJdXSZE0NdX1OKmHEa+ACCPk38UM8ZCv/sLETDr/woXZuTCyTCd4i1PxOP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG2OmbJnqJ8C3SCrmU2FADPGt2I6Gug5M4S6uyF4rjp9ShkCQC
	iUR8qq6+mrCy6n4oOw1tRyW37nGmnRRRwTYzl1aUkaJJskCQ0w13nzn5IsmyNjX7srZTBPkIEPq
	v4MjLjtxqOFfXjwkqvQ+n/avaD6lH3Le/lHC5PHdBCkz2eUgNUPT3XME=
X-Google-Smtp-Source: AGHT+IHf6pLPbG+UJxqOzrGHUueGILZCUQ1RXkjwiYYOmolk+fgA8xW2Af8zJSuV0X2cHYypY44euO82mlmydc7HHapOw6hGuFfb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d85:b0:383:4db4:cbe0 with SMTP id
 e9e14a558f8ab-39e3ca065e0mr1676055ab.5.1724428752902; Fri, 23 Aug 2024
 08:59:12 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:59:12 -0700
In-Reply-To: <0a06b525402f43298cb3a1c4305cba14@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041ecee06205bdbad@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in attr_make_nonresident
From: syzbot <syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:https://github.com/Paragon-Software-Group/linux-ntfs3.git master

unknown command "test:https://github.com/Paragon-Software-Group/linux-ntfs3.git"

>

