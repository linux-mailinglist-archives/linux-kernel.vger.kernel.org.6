Return-Path: <linux-kernel+bounces-329972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF97979814
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 20:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF481F2126D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2991C9DDE;
	Sun, 15 Sep 2024 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddWKGAO9"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A156F1C7B83
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726423988; cv=none; b=ZeSfV5iSRzshqg/Ou8775zdYJkmRLyiWR+j6n2a/oRtQrupE6jNLoHMgmHwnv9GC4sfIF2AbrKxyNjVnXVupYMSu12iW6azl28Og9mzFqiehE/VVcxiLWvx6uK5h6GFIqrci+V396RLU6uxQ0DBpqh4oFW2+bpjwxvEKRdSuB14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726423988; c=relaxed/simple;
	bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=huq/xp/5XC1nINES52NcpBeh82cX0GHA7IO8CFNk5Fa2tOcCEJOYk+qdFJnqQWcWSAcSqeuH3VYjlu4rjSgEyu061szyjreoFX/k0tg44foCaUB78S7atQVqjNqqEX3KrN/arhERv77SD0jY5HTNayA+Z8+5qHpibZA75D91Cuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddWKGAO9; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d8815ef6d2so3134062a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726423986; x=1727028786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=ddWKGAO9CUwO4mpk0cvmtIomUzO1fp2R6AnyuTNxWrXj3RZxM4C7YIeURdFc7ZDd87
         eakwI6aI7egBBTN+4pG4WYbNCUh8TaJH7GdoCBX+vqZAVn+wjM7Jj5vSAas7Ue2gXoF9
         7Bd0+ZD6pDRIxQhjvbMihfBGyICnfpEktSdP7Qo/XJkaNaKwNFZPOh4uXOOJCELM7MHF
         u7Y/OzEy0shWwAbEBoArQ5JEh11uQ7wBIfHMMm21T7BhXjh4BhsnyYw/Yp9mHHlHat0v
         TIIbQc8VAuB+VZDfTK5XxcnAmU8+5q3AnZiAxHmkVklHH8hs51O5S7H+aja1IIyrskCv
         E35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726423986; x=1727028786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=OQTgx8QBwgYSsl/1ZI+RkDuSw1m10PdnA6lMNDQjyXLlwFHzBAUAVjfnqnJcu2XRX1
         kzXfofXdv2Kq4vhOkdWexk0A07XWU2zhr4or9qk9MxOD7m5WUws5iE/QhB8nPmOFhxBC
         qX87Wt/wYrsJ7x4SfiWGUlxPTmyk/VfglMB0W1dRpPiAEk5Z9zdL/dXYqbxYIaHMH2Cc
         12h94x06WmTwV8m2iczT1loU+H28S3V18Z+tlCnbfITP6q/gIupoz3rpUQ9ivWFd3o6j
         yAwe9Q2UhA/W+SZ6kwd13371d1r7Bq/Lm75blE6KxoGpgb+yE/bgGv6b7fylpiRI/xwe
         ydTQ==
X-Gm-Message-State: AOJu0YzvU9b+AuYRaa6ya5tNGNpPnBjcqHtVOWGvKwD2MpkEYgSolkxa
	Z9oV3bqypVIkxaAVqL35kRomZE0ZnlUm6+07MzgIhHv6K6QID+nD
X-Google-Smtp-Source: AGHT+IGa6iEp0G9/KFmNd+CMCmFKfUUc7in0b1Ybnp4GCdj97PSuiqvw9uWHmFdrcrx+oG9LIbzM+A==
X-Received: by 2002:a17:90b:3c4d:b0:2d8:7970:726 with SMTP id 98e67ed59e1d1-2db9ffcc5e4mr16762301a91.12.1726423985689;
        Sun, 15 Sep 2024 11:13:05 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd09a72sm3441720a91.23.2024.09.15.11.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:13:05 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-infoleak in iowarrior_read
Date: Mon, 16 Sep 2024 03:13:01 +0900
Message-Id: <20240915181301.18904-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000001fdbd80621e28ae3@google.com>
References: <0000000000001fdbd80621e28ae3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

