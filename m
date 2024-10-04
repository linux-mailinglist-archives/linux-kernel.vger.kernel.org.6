Return-Path: <linux-kernel+bounces-351474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7F69911A6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B871B1C223C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450BA1465BD;
	Fri,  4 Oct 2024 21:48:55 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B51C3037
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728078534; cv=none; b=L8M6FILnohjJTjfOt7VUl4o6gkIuyU/TmHr+IRictBd4H8P/aJyqCnNsmtw9J5DpSMfw59icb4g50JsZ9V+iIAziTaesZVgf3MGkqvD7s20Hv5WPO1wcqBbONlHwW4OWo44s0q7bHxJ+54gmeHhn/5wxUc2EgW5r5JvBYSU97yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728078534; c=relaxed/simple;
	bh=jccwev5i7Ky2EVWCY2hPTRFIWqW4xoaP7Q+TcriIPWo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TqCeEfkPBZ0aTxMhXpt+tZbkO6Q6AjMXkzpS/ZzZGSuA+P8M2jtBYXlcUar1VL3Nx6wzO9q7mpwSguwOJhUnKWSKwWAjrT1HbunBYoz6AKZbbOgSz9o0/Wt83hqzxQxqDCZNQS8WVkesr5Qd7P9UK+fp/9B9pLCSmXqvjPP6FjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cdb4971b9so264265539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 14:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728078532; x=1728683332;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jccwev5i7Ky2EVWCY2hPTRFIWqW4xoaP7Q+TcriIPWo=;
        b=fU8G1mQL+3sc4+rFZcqxfgs38V959NUxrwzPbVITEzYhjISXAE3/M13RJv2XQLdsZ9
         aiT/kwBhQSyx1KJolTC4aHolyKdafBO86Gyb5arePKXSdkKsnQ5qzmlKEb5w9VFxfvzt
         OStZtmdhvsFpcMkpRBU9FJwqebYOskhkcg2QrsVr2w4zKuOGL7hTkC4jUGW7oPcMdom8
         ACIMtHuPWZkPioZ7mbzSaWNg2L2UWhJUychMtwv4v71NLO+858kV/ZiO8fBGVDLCZAE5
         gAgbckhMlrmPOOpx7OBvnmjZbP+LHsGeRpGy0IRWi7BVPWYm3YGpYLeKOzNWJovbBTk5
         N0GA==
X-Gm-Message-State: AOJu0YxHncJRRgjXFILLlRggpBzgoSgPXNYGjeprrAyVfQqFtGMvL6i5
	t/N+VutTMQ+6EKQeHnvGoyaiJKDE/twtLu3PAn0po0QUi2maveLDa5Ce62S0SWu63nTVHgm3or+
	UVeQdXi4GapR3Z8x7W6Rnk10pa8Oa4qaII1p0CSt9EmCDx7rFE6DPMxo=
X-Google-Smtp-Source: AGHT+IEIU7FZzXVh5WUf18u2sK/jerVjY6HiPvodmebITxctxhyX5bQYTvZxdN0/x+EsEV9mi5jiSFKaU6sCpRGBKfZ4JmIfccKj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc8:b0:3a0:aa15:3497 with SMTP id
 e9e14a558f8ab-3a375976e55mr43004555ab.1.1728078532105; Fri, 04 Oct 2024
 14:48:52 -0700 (PDT)
Date: Fri, 04 Oct 2024 14:48:52 -0700
In-Reply-To: <66fd2663.050a0220.f28ec.0510.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670062c4.050a0220.49194.04a2.GAE@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in __btree_node_pinned
From: syzbot <syzbot+9f41e4b255897d99d4e9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: UBSAN: shift-out-of-bounds in __btree_node_pinned
Author: niharchaithanya@gmail.com

#syz test

