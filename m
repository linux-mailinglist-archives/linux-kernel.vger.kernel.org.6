Return-Path: <linux-kernel+bounces-373291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 761C19A54B6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34557282146
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440BA192D66;
	Sun, 20 Oct 2024 15:19:54 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C811DA21
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729437593; cv=none; b=aO1SZbjMV2lJVpt3cXxrgt400dnR+7EzaVDGSM5ks9YcaBobgnurKjDKbHLTSyPONcE8Ufw+3m3urHzKHSCtZh4uaWo4ta0mLAhePkc3R3Li8cJ7q8xsWJMqfiZ3TRy9Nx9lQHG7BjvL5q7/UuPZu+hPhZT1siBORaSStsE2JS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729437593; c=relaxed/simple;
	bh=7BEFaaok169hD29f3U7ZM6kdTNs/02qWrX4flaRMq2s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E01Ejo06bTcl84obigY26xH84eOfy9HcBWk+O8d/XrpYqNZWy5xsEaaB6oQKh3rPlHbvX1NFeXiMpzAAKGPH/DUGO1ceqQFImEKm4BH9gkbjHrWLqBvcQYC38nuhiSH8hfPtHe8PAUFRcz2GhaunNvqLIlzXg/03PIid2CQ63Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c4ed972bso32311975ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 08:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729437591; x=1730042391;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BEFaaok169hD29f3U7ZM6kdTNs/02qWrX4flaRMq2s=;
        b=A9Q+FBM5aEXLqe88M6IrH/B78hKqOT64Ur6cmlBS2gWzKn5Le312qb9f2sfcnk6kmp
         clsvn0w7B84uJdNl6k86u53ZnHmoU0nCmOE2egBbSK5sTZFHDdV6WzOFH4d9gZRyXZkl
         7w+/1RxcTHDAyFJMbU6oUHcIJeypo9h7ggnaUJfXAzMx2sp/M7DCZGTua8eUbfmyXiVc
         KjSHN9OIzxUJ6xIzCGc769eVIeKrIOQ1VSJ0OMepKkrr4JE6CMsXh6H/DjvANk+rZJQz
         yWO1b04sVvK+UHVYQgDNyQJe/xu8cL1cY9ulKdLYxKiVkpcq5mpzc0q54fGOXRuY+YuH
         O8Vg==
X-Gm-Message-State: AOJu0Yy3Hx7PyGSBlrIyKK/OaP8jtIa4tYluzg/vFIaQrBPRmHB+rHOa
	iUlZt2gE3B/WcPnEoBKJR+U/i9DGKuUqneBrlkG0xVEtxZ7LF9CcmhQ8f+ZRGip+4QTjPAXA63e
	ZCwzrJrA00Fp83JJpesLwWGBviMEZ49Mp/wGuxj16llXIER5EpcJLJMM=
X-Google-Smtp-Source: AGHT+IH8aBkMXX5YXk1TdVCeiax2PDXX1C8gPgHtrrSAn9xDSk3cgqqsw/o9ScZxqeCGeLDST4CYD5fe3UiSsvBRTFcyaTqFZ6Wf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2185:b0:3a0:9b27:7d52 with SMTP id
 e9e14a558f8ab-3a3f40a7c7cmr81458235ab.20.1729437590943; Sun, 20 Oct 2024
 08:19:50 -0700 (PDT)
Date: Sun, 20 Oct 2024 08:19:50 -0700
In-Reply-To: <67109a9f.050a0220.d9b66.0182.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67151f96.050a0220.10f4f4.0036.GAE@google.com>
Subject: Re: [syzbot] kernel BUG in bch2_bucket_alloc_trans
From: syzbot <syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in bch2_bucket_alloc_trans
Author: pz010001011111@proton.me

#syz test

