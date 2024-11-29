Return-Path: <linux-kernel+bounces-425153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F5D9DBE3F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 01:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F98C164B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 00:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3D9AD27;
	Fri, 29 Nov 2024 00:32:28 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB279CD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732840347; cv=none; b=TDSb23jK0t2X3JI/dOTE4ACvVy0NwuVtaqXxmsVdgzbPDb0zdEqqdo/jq6OQfdSYtR5PWYnUf5PtZOgebrppedi4eLHmuHSx/1nqBtVZr+iUNU2goHSk0fUDVr3Pkm3YX0tK1MSenjxJzP9YTaxsvx5cmCBMt94oa7T3Wn52OK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732840347; c=relaxed/simple;
	bh=8FsWe91CcCnjo+wKt7cuZTcxSs3Tvur+INev/YXAe0g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pXJKca4mPvIdbPw8hdKBGTSd8f0gfl4RwfNw8dQ/W890QTUK/mGa61JkcIuA35zYznCrTZ6Vtus50X1PXxH+qyTUdw5m0n9cK+AoVI7ysOZGlHbZdzVtVtGcWjyr/jgQbvlYhxKyRppS8BoECJ5uq+uTXh5ioj/5nPO0FTLDGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-843dd952aa7so118359039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 16:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732840345; x=1733445145;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HLQeYNpNlqG5w8DRysMt/9LQT67Z544iCUDI3OaAVo=;
        b=oqummbthNwTosUwAH7cb693me5sLEr/ogvkFj4RjOWACbvn67W4HkJUzW7QwyGY1G5
         5kkObjBPkPmEVWEtm1qTUx8uKVaysT+MdjIslW0VmjluPeayU6lLKF0in+Os8Wjg/IhR
         vQCiP+Z/F6gK4qqsqz2tk4pq24VQXeu6UYbAvkKb8u8WIt5qCIYSOGZymoQ6yjNo5CbO
         tXwHrheZg6YDqOmnXezD6sEHlsOZZ1rtoV0N8mV4Hg1euTZJXpI1nu192SPMG5HYfZxY
         9ze//S6Zb7EPogmNGjueKr25zzNteJ9JSfU0TPgPULDNqtQwNnzjSm89qbPCW49rlVvL
         z62Q==
X-Gm-Message-State: AOJu0Yw4gI+0WzsoBOrX6dau72q8gX/vPrEPRHt3N/jgEl9P90PUynYr
	h11giu+pb3XKLo46i5T1ILONnei0D+I65a4J+kJYoQhUs0+kPZIu+o5KFcFwgFWdzt5fKcVPPDI
	qH24OKwfkqAEo3S3su8Ngwps8SPQKwF7E5BlEMwqt0kGCV4GZYRPsDw0=
X-Google-Smtp-Source: AGHT+IFfpRZ0R2Y4MU6xzOZxmA/5KPwqVsgDYrSnYujaw5FHN/Sr1X3mjirJwNsE3mox61y7eGDq75ldCh+hE+to0erhRoV1pzl8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3312:b0:3a7:c5b1:a55f with SMTP id
 e9e14a558f8ab-3a7c5b1a78bmr88865765ab.0.1732840345404; Thu, 28 Nov 2024
 16:32:25 -0800 (PST)
Date: Thu, 28 Nov 2024 16:32:25 -0800
In-Reply-To: <672e34df.050a0220.69fce.001a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67490b99.050a0220.253251.009a.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+50d3544c9b8db9c99fd2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Check for extent crc uncompressed/compressed size mismatch

