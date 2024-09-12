Return-Path: <linux-kernel+bounces-326286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B539765E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8DF1F24CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5035319307E;
	Thu, 12 Sep 2024 09:41:51 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF44F6F2E8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134111; cv=none; b=qmPnC503Ismyn7LN96P8f/6jCb2YCaIhioSZsykkBF+FrGJ4mvvRtuPHWneZpHJsfFYg6u40WZkXxWXZ9A/eF/zLsTKJ78RjLhOMmbNSQtTs0sQ1QIepmcH/VYIPHF9qiY/soBET/FdBL7s4RT/aWnBTuhNqUKkonjNKe6dST4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134111; c=relaxed/simple;
	bh=f3GXiWsYvAV48N7PLUMYc3lgNUpwG0uh7ZsslRjW040=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=I+EkwCy2R3FdO+iRBt8UtxrH+TuAt1xSxlslOwaKJ5rgOC7LzPy/6/xKwKMBybbCSed+AYMVIOZL8my/EDSuI+HkgR1PFf+5KM9ZWcp5PItYiaiDkI8xEd3ff/dJ0oIQuumVZj6KLljEGDKASCfrHB/1Sk14fgKMQFnAIAYZfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a04af50632so11298855ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726134109; x=1726738909;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3GXiWsYvAV48N7PLUMYc3lgNUpwG0uh7ZsslRjW040=;
        b=XUVK8eh2C0hD+44UTMs9ZPl+pi8xe/KQ7Ev4i1pN2reKFZBfCdR8D4Jq2wKzI11erW
         ZVxDCTG8vX/QVZi8eumYfpIK3JehcVKoBCqbwP5BELMaeYhX5QIbHvFwjzdzhaU6OfhQ
         zSfL78gjBuZOkD9e6Wu5tzGUmJehZ2VrLJv0tn9/jouwcV6o5nQIjNxQLjAbYBJrRWIG
         KVq27tix9WMnMG65HLb1ukuBepIg6P/sjYO8rKj3fqy3l0GmvKEuQ/xv+ihYi7Nqb8eZ
         441vdEtbTIORXUTfIKkbukMhrCcxju9WtWJl6KHBfSQ6fAGUF3UHjCcrrk9Y6u3N1XaN
         MRdA==
X-Forwarded-Encrypted: i=1; AJvYcCWyyb45VfWghxe94ZbbQB17rvN/9YCD8p+gjjm6gzO3AmJktmgpS/q60OcFfUL9QsGzbk4ntYwHyUARQmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvhPrJlNuaLjGuK/Ls58yzeNlZkva4O+8Z3pvY1dKkSc0vcSLm
	89TKM/4u8Iugcmx+QeB1LlIxfeRDqkilwU13GM1mLFSj9zMW4XUhxKhg9D+R3C5FXF3RK0OZbMD
	ZbdKg9cKqRFItHYcvJVV+WQ06ehPzULWi5djmGxxqMvig7gK1Ldgaa3c=
X-Google-Smtp-Source: AGHT+IGcwerjzusQhPkfTd9sGta2ECNfNJJVkkw+M0we2hDUUcq/CWadzUJVUZ/7vtBUiEe3x8OxnuVqRdGSDDXvnUL3jlC1S6s+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198b:b0:39e:68f8:43e5 with SMTP id
 e9e14a558f8ab-3a0848cb45cmr22228155ab.9.1726134108904; Thu, 12 Sep 2024
 02:41:48 -0700 (PDT)
Date: Thu, 12 Sep 2024 02:41:48 -0700
In-Reply-To: <CACb6ct0LWnXzbEyFYL4dBMZX8m8xZD3Yc5JOtKJhK=Sj306Wzg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000656f870621e8eae7@google.com>
Subject: Re: KMSAN: uninit-value in mii_nway_restart
From: syzbot <syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com>
To: ksjoe30@gmail.com
Cc: ksjoe30@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test

This bug is already marked as fixed. No point in testing.


