Return-Path: <linux-kernel+bounces-359200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A9499889B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5B11F27660
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01CC1C9EC6;
	Thu, 10 Oct 2024 14:01:55 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF31BFDF7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568915; cv=none; b=N88PY2nn0Y2aFBf0tYG+5nhrvc/Ru3gfav/vED5PwzlZM92DQH9/VuKQD7TWUQkjNM8/5IvHYWc1qDfZgOx7tkz+Y2nUTi9Lf/JrxXQLn4026mu2A2L8fbUGfXwpBbR5eiiNuhq0hxxbHG8M6nhRlK6spFMg4IXzE5WcbPVZoG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568915; c=relaxed/simple;
	bh=uJgwS+EYHWGuZMYuGhsSHk/r40QmgerLLW822ZRQwaY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pIJ7APuM72hez3HERTQedw7UoVXgIbwL3rolaK5ikBDgx6YwnFYXXmYZe4SHSjkyuAMiPiwqBLSGawzkbLsFMENxCICrvPbztd4mUuc9XiMSLQLCZCSVmrxHeR1Bt9gAwUpq4D5ZRpVokPYMLIJluUOyCOZsWHuO6dUzcEg+0Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3972c435dso10047405ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568913; x=1729173713;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJgwS+EYHWGuZMYuGhsSHk/r40QmgerLLW822ZRQwaY=;
        b=bTPf2UJDlLscOfPPMJpEZ/YCttDIYG/uj+Yo04Zl/5qfGcq5aG/CR9i0OXMEaahiyv
         fOTNbXKQN1HpJk9nDvF7vc8a+/QiOjuDEKLSgFIv1NjqjgFFC78I20ifUggMbLsILZ95
         PfC/sACAe/h4pfHp9HYkqQvF+QJeZ41fvLSNfN2NeGqdUTft/R6XeORRM1P18pTCCbrv
         sM/dH1qhkMibeNH0MKod1oTheGOAi9muTVgRrdbSBpNa300RY7XSbBxRJrklQ1H6ps7p
         bdZQ97djHxAlKPolmb6NYhx31ujh/hbqao1CQLYMETmn8ptmpDWlbHAp0Gg4TnOBzbzE
         dk/Q==
X-Gm-Message-State: AOJu0YxK5JDmXu6Qg6dGerNU0vj+pD+TkrB9nFDxCHSQGmPoAotQ8Py8
	oYPH3FcoEvpd6I8eg5tQaIHBnjwA4NLx9NdhFAttpj/M9cZOAvZTyLUiVORJSgjqAUj2odM54lu
	LAlAFjrpIzWhdN7IfZb+O7dnPzY8AZ+7bjXUKBO1s1n/zf1Q+K/LzLM8=
X-Google-Smtp-Source: AGHT+IH2YuFMkRpZ+RyOA6lFkkX9J0pQTFxscBsuTmh7cv+WeZrq75DxiaXI4IJjBDB7QT+6mvyE3rueNymcmXGOBN9RQa0s08Hc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe5:b0:3a2:aed1:12a6 with SMTP id
 e9e14a558f8ab-3a397ce687emr61777915ab.6.1728568912122; Thu, 10 Oct 2024
 07:01:52 -0700 (PDT)
Date: Thu, 10 Oct 2024 07:01:52 -0700
In-Reply-To: <67014df7.050a0220.49194.04c0.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707de50.050a0220.8109b.000e.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in __exfat_get_dentry_set
From: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in __exfat_get_dentry_set
Author: niharchaithanya@gmail.com

#syz test

