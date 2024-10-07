Return-Path: <linux-kernel+bounces-353969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D3B99355D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D899B21E07
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B301DD9A4;
	Mon,  7 Oct 2024 17:50:14 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB6D156E4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323413; cv=none; b=ZPxUi4QzUgPgdHMNK5P35Pi1huhvlGfgZ2QZKgAFx0pE8pSBDyaPmG+TeJmV6bpv08xOXamGY1w9S129YrOjKFoKMBXua+NLiV82F9LwwOhwf4jKivdmuzdS4IOMhgCfibLbmjHAjbLzL8F2tqQ+phkroziBa+LW+J/pYIj8J9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323413; c=relaxed/simple;
	bh=curdASjZoYLYi1tt0TPrnluzDAIdrVYDDgWVF5Txu5Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jHVoQeYo/OdVd2eSuo74/ipPVq92gpHaCfIt+5P4GOvi0EjNNS0vzbFGERglStRs7OZC6V+Bnz69ba0rl88ITMkFsWJ/Ol0nj3C4Dy2G2C3D7t0A/7ePQwyr76br0Riw5DxprtpxHbH/W1DRd5rifZCATe+OHj7jwPGo//Ufqmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0ce8cf657so52508235ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 10:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728323411; x=1728928211;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=curdASjZoYLYi1tt0TPrnluzDAIdrVYDDgWVF5Txu5Y=;
        b=Ha4jXawTY0Mlf2Rn11GyQO+HZQDoPoihypZf9OTEsuVJtS4Ch0pJXp6VSDGbUaT6lD
         5yXBfxd/6EX0IEPLrDRHYH712m1SDqhR0wMowYtOO7zW6thuRUu7xxu9bMwiMdRRSohN
         qz2pd3XP3MVSfxSvVgVCauPwiCJru5/NQeX3V2k0aVyJsV/T50xTY7L0mDtdG2Pr1vwi
         2pAnh2MH7Vh8VSbReL2nYDUc9IKqNxEvjlTBWte1KunubRK83ddEs4xOm0ZiWWcW1buc
         u2tzIprS0lrKWmbcqNb/XMg5cVSxz/la52fpYdnABIgvbiL4mIYCCv5qig+WQNaYbJRI
         xQIw==
X-Gm-Message-State: AOJu0YzLouus7xZK2pwHQrxaDurNkOMNpUGc6JaHxx+zrN0C0W4iCDgL
	t+FEP5tNxCF1OZRLQnrRVJrWMIUQ9y4Jsyx+T5Gs10jXHjtdKm8JxgmJaZqxsdcB3//n5KNs54p
	ce7DphrMMK/Akeixy7GSuCQo+KmpwTPjArPmFFOlIiNsY4hjmgfmZPco=
X-Google-Smtp-Source: AGHT+IGAzgTcScors09RNjP3bLFpznOv7H8I2qUXebguCo5Ql+/uHnlRgZUEyhIXoHj9c6CRDRa8+WGzohDeCbn0bh8T0S2iI0tL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2166:b0:3a0:4c24:7045 with SMTP id
 e9e14a558f8ab-3a375bb2b19mr119834035ab.20.1728323411371; Mon, 07 Oct 2024
 10:50:11 -0700 (PDT)
Date: Mon, 07 Oct 2024 10:50:11 -0700
In-Reply-To: <66f53c38.050a0220.211276.0069.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67041f53.050a0220.49194.0513.GAE@google.com>
Subject: Re: [syzbot] general protection fault in bch2_alloc_read
From: syzbot <syzbot+a1b59c8e1a3f022fd301@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: general protection fault in bch2_alloc_read
Author: pz010001011111@proton.me

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

