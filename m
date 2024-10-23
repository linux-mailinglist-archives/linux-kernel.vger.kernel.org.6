Return-Path: <linux-kernel+bounces-378283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3D99ACD8C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0A91F20226
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5541CC158;
	Wed, 23 Oct 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtMRON+L"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5C41C304F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694495; cv=none; b=upmQ0PUKxK1GGymcn8qHwn2ofJU9YUfqblba+D4YWIkdRg7xFRRa4Q5ZEH0tKLoCgo5y3xTMobXcKvUhFaasNA/zApOtFAbBhFWq9TXJ5vwLpvPBwQkGhB52YhCgsXLyifyOio6OgtVX8gtM6abpXu0v0u5SHgl65gkDEhC/K3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694495; c=relaxed/simple;
	bh=RjdYt/32jmLgVn4qtdfNuia8kSQWHlbmaj98vKSNZUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i3ylsVO1KhfmE1OMRX/IxlW3axLSJpyYLAH1LGQ7D+rIZwHB9rXCJgsVNOK5/7QIUb2WytOoPFplQFFuBYc+HeEUpoXRPrI18hp2D9AFQJ/vdf2ReKk32GnTzsHYmXMiNr1z/BAZ1gXhGULMQ+pFnUAXB33Jb9R7I7ouNk5W5X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtMRON+L; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c767a9c50so65071305ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729694494; x=1730299294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjdYt/32jmLgVn4qtdfNuia8kSQWHlbmaj98vKSNZUU=;
        b=mtMRON+LyOd/AyHkXzhQrGQMztGs4EkrEbQsrqEDcOAfjBlVsplRVZwtC9ZsL0srHp
         FIQ9Ujt4Ap2/VrWgF0itoQNlg5FhbqX011JN2Fh8W8R5Ff1tKrBW/qvOHnjLIzJXXt/e
         NRd/8yctOJsxMxieFfesokm6sIB+OS7b+vZ0AZqKC/d7RlyX4r4lFHRQlcL8E0DgA9Ub
         oFKTCvOG9oPo1YMOpz9YSWuzyjbM1SPFDqTAYwG0LewbXtxTM3c1of6Ch9CORoPLpk4A
         q992dk8li9LB6P5uhVJeaqDvlztxJKxicKVkZmtbTe7HUpcDpWj5qUy2qULxjHnend+I
         C+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729694494; x=1730299294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjdYt/32jmLgVn4qtdfNuia8kSQWHlbmaj98vKSNZUU=;
        b=V76A80CckdSsAFn62x3zwmFAMDXY6uzKBDbI6VA3f96wAw6jjODxeZmKo1D/OVDIL7
         85+cJi+7sFI5UBAZW4Tb8WhA3tbcy19xbR9LPG+VXE6/txazOW3BeorDZ/B27AMBFPSy
         iKJg6FfzXgyTbhxNlwOOzYaxwN+c4UM/t7mU1/AhsxwmAPp3uxhh62y3AXf6ZZdifVFr
         p+92EnRNjzwKIEDLfO49k3g1HTzLhoyTTPUbn+6d+8H06Qxc1L7rhFmbG5JSgkbDM9Bv
         JCAXkp4SwEzNuNrBaSZLzAQp+v9Y0FRfX6sgZ5w01OoGy5M9fTot6tyD8m5yT4Fk0Hrl
         dttA==
X-Gm-Message-State: AOJu0YxuZmHm0x4mZPSUKvPQ6fMiF54L07TBiO+0keb5F8wYK/nxtsUv
	I/Mdb5BLYiFa0hPQ1ZDPF3ue6U4KSkhbOLd79R3M7w/IvDxQdRt7
X-Google-Smtp-Source: AGHT+IHEwHNdJqh7K0iM05tvn9rp8o+iVKv7Kz8rpkAwioDB6XIZo4/tuM8417RbWNDeE06XkB3Hsg==
X-Received: by 2002:a17:902:e5c5:b0:1fa:1dd8:947a with SMTP id d9443c01a7336-20fab2e0e03mr38655145ad.46.1729694493789;
        Wed, 23 Oct 2024 07:41:33 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0de4b2sm58193215ad.217.2024.10.23.07.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 07:41:32 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+b468b9fef56949c3b528@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [bcachefs?] KASAN: null-ptr-deref Read in bch2_sb_set_upgrade_extra
Date: Wed, 23 Oct 2024 23:41:29 +0900
Message-Id: <20241023144129.39005-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6718a343.050a0220.10f4f4.019d.GAE@google.com>
References: <6718a343.050a0220.10f4f4.019d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master

