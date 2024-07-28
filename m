Return-Path: <linux-kernel+bounces-264560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA60893E517
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0C81C20D90
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B2E3D96D;
	Sun, 28 Jul 2024 12:37:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A30208C4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722170225; cv=none; b=YNd7aKAmm7c5Jbp6UlU40arCrxgyYFC9G8TrjSbgrC08FnXjjgsdmMaCvHIj6W85as3wHm573hOEpt4vQoC5ZbfwxzsXhnTr2PY5DVwOfT+ekyHzjgd58XVKIE8p4W/C6qM/KWnFgUpRA/+3Yw/rKqAmjyyiSZu0BkuDob/HRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722170225; c=relaxed/simple;
	bh=Ypm+xAjfROqu86gSEDCwJI/AmIJDYClvXZdaQgIJHVs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XGDdxwQYf0wPiYGVaQkVOiqGn4wxFJ0G/MB1A125ZMqIKHKRDs6Bx2yiPLwBTwpD7Rt8jX0wWmapNASS0IV8vVZ6+MXrnRABc7UCi8OJNUWYfieI16sslepIQHYnwI4rU893b0P3hHWW2lOL5WxwOIAY2ELBfJWYAuhSflkQlPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39a29e7099dso44118955ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 05:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722170223; x=1722775023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ypm+xAjfROqu86gSEDCwJI/AmIJDYClvXZdaQgIJHVs=;
        b=h3c+gTdLRxSlsLwbnFPMyaTlgv3fqahOabCBZ7FfXdM2e/QwACkbJ08cVOEisgpb+x
         cuLIYBzgw1vgGzBdDHPkrlyU37cB3C4AVkWDPRU33FJfkgV/lioxPfvYvONnL4+m2y6H
         W/ibZYnwxVQBc8MhtS2f3/AAwpV28f2Q6wVxRbnXIATyq/0Z+7ORXuaZk6SJolrk2ktG
         hYAa9mmqXgjC7EL4WfYsAscpccUvXMhDvGnv5oXZ0uXxq3fQbxc1Unyq7+an/XIayKEO
         ceW6jQB2rxFwStEbYx8uEpUeUe3895LI+e222wpaCZaQ+ai/L9FTGjtVJHmp5pBQupNa
         +q5Q==
X-Gm-Message-State: AOJu0YxHVAA2usHuCdp2Jf/Xs54YEdNqLiaR44xntBmiq/PxwlBN5yZd
	yZ9YbXdft02CxdrjY0rNhHwW+Kx9Q84E0LqTfnrVrpFSfFV8Z/nrBcTQ51YTgx60B+5IHgvVa9r
	z4ljuKmYPmner112faWbR6ADDzYeU398MWGNmKd8tTP7CoA1y5dycZ3M=
X-Google-Smtp-Source: AGHT+IGdEMNrAHp0prNLRy5rJhjh6+l8ES+5yJ85hSlB3Yudt4htPuS21tnAH8twc902tT9P+f1MG6Ch870FZ4TWm3CUm+Ro5o9p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26d:0:b0:39a:ea21:1202 with SMTP id
 e9e14a558f8ab-39aec42c56fmr4544795ab.5.1722170223643; Sun, 28 Jul 2024
 05:37:03 -0700 (PDT)
Date: Sun, 28 Jul 2024 05:37:03 -0700
In-Reply-To: <000000000000c396f805ef112fd3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c60f9061e4e00f2@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in hfsplus_delete_cat
From: syzbot <syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KMSAN: uninit-value in hfsplus_delete_cat
Author: simeddon@gmail.com

#syz test

