Return-Path: <linux-kernel+bounces-367849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5332F9A078D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A618283D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B901420695C;
	Wed, 16 Oct 2024 10:38:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AF31DE3C9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075088; cv=none; b=o9Cy108J6PfA+9tp1UvA1VKoP6xWBfnGsomvSE/hkFQ9hGeZHkqKfkh3qpqB/BWXmF/+B5bZI6EarwOIEAPP44/ji/9F6UrVPh7xy49GbMyofXwsbg5KPlt6YHAKemKeuQ8VCebLtPBibxugDCP2nVCSia3NtBLiPO04WDZ4nP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075088; c=relaxed/simple;
	bh=7r3qC+60OPs6ZIgVFOVxJy5T76ftBqUdczLtTTUtPKM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EXZe5F2WTzT7bXzjIK4Q6igk9SgcshS3qGZWxKT/YWno8oTTtKodFqtr/SaH8vMZYv7jD8vCL9oDeVzGGi7tI0WSlBTts2ND39hEjDugooSMAblGxWmo8YWifZ4uB/OBSa5UUjZnHaisxqKIo21TJ/tlPV0UWtqKWOSHs+O7DKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so49526155ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 03:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729075086; x=1729679886;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7r3qC+60OPs6ZIgVFOVxJy5T76ftBqUdczLtTTUtPKM=;
        b=DubedfH15pRbtjKqUElsYqjez0XwP8dfPpfXy6mQeh8m5EEJONgUg++UngCUsXxEzf
         avLlm0pWr8D/bbH96DkVhokpuu9yHPgSVz43GpljdvSmVILwtHKNzyEYrM6WmMw+mdGF
         ou1wW4JxdfmjCXyjwMSjmjAKb3SXz0zWhaR4ycquSBk6DowGulG4yAvOZnHbiZCyNMyW
         aanlxaFIgFqOzUKunNFU7z7miENJ2/69YtX9OMRzN0/aGkJRAlBQFyfPeDnYisuliZE5
         2zVkeYC4QMUxpE3PaQnmkjOYHO5rDQN3XsFovPkyKNw6Ei1xB4F0sh9K6aW0EMPwzgNS
         5NKQ==
X-Gm-Message-State: AOJu0Yy+4BBBfOR9dOVltcwjwnIUlMoACPfeC8M/FsamKDnpwP0NqmO8
	WNUfgUzjauPttkm+ukeXH5zrSZw9gimO9IeNFykgjfJiwzR4N1VwN0FlPzWd7g20IpaLpT8qVvi
	x48B209rxM8yDx0ykFfixKPP5lNS3am4N3s7n9tVRJoQH67YyiVKTc64=
X-Google-Smtp-Source: AGHT+IEelN72x1xBD1JHx+F98siSnhgTutrbyQ47zpOMtA6+oFJRWyO2YIQ8jsyLAEGtL7h6zscyBfhVAnNGiEnQezPlMDpQRSxR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6d:b0:3a3:a3a9:c1ae with SMTP id
 e9e14a558f8ab-3a3b6020fbcmr150100915ab.20.1729075086017; Wed, 16 Oct 2024
 03:38:06 -0700 (PDT)
Date: Wed, 16 Oct 2024 03:38:05 -0700
In-Reply-To: <000000000000b6f58d05e9f95a0c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670f978d.050a0220.d9b66.0165.GAE@google.com>
Subject: Re: [syzbot] check upstream
From: syzbot <syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: check upstream
Author: almaz.alexandrovich@paragon-software.com

#syz test

