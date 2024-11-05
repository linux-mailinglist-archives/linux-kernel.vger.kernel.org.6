Return-Path: <linux-kernel+bounces-396313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A079BCB60
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF7C1C21630
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E41D358D;
	Tue,  5 Nov 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StoAN0Jo"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05B21CB53F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805288; cv=none; b=j7cwylOUZxUjjvh2GByIzW6ewAFaGUnKSPGEg5M3f7F0vz1XjqfDbtRWik+03xFzPZ6HlxMWnTakvIXRtSNMfCEFpSC+/h6/98wwkveDW7SHDcTFOFwq9YZHjgoBIcZRWN3BrNHaISueCNnVl3WY240fq+X/dVO1/bUtBOuDke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805288; c=relaxed/simple;
	bh=0JOw5uEvPR6a8QkhgQzDXycqZ5MmRpajBRDuZBG/wFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bye41wlVm5aGhLEzuhk6lKQNj9ilYoghgK1T38emyltOCihFwzzNBkgcXxUX5GaRGFA2HxUQ+RnJw9tTWPKr9rmSHKcVEPYfzFbPNS3uSAGGJ+ysV8a5u2+N/3kzwfYNAU8fF3WiRZa/cns6pPPUVxr32lVmlizDVXIOky0+uro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StoAN0Jo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c714cd9c8so53832015ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730805287; x=1731410087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JOw5uEvPR6a8QkhgQzDXycqZ5MmRpajBRDuZBG/wFA=;
        b=StoAN0Jor61V6IANyA2RhzVoInAucELW4ZmNSzbIgKymXMlOUJ0n9wjr1mEEQ5JIz4
         ctuWc2LVnptpivUSu0Cl8wq7RM4hLmHQCcRN2niSAdA8AsUZll0vh8QqXuEDBvlXWvJo
         9CnSqM5NzKCxGJeAHzkgVkE2/2gxq+f7/jDSLsxxmPCNaxSy18P2aCwrwHyWM8wxpeso
         5xx3UGYC2KSmElEEkId2hAhcZTKHqvJ42ozxWsV0R0dG75VGaNA/JCcBIn+NvGvk8Nk9
         Ovr+SXbLtGV3MsU6sUSej8J89TCCC5jnlmSN8b6z/5HT0IE31JRAuo2x7gQ4jHkpyztf
         i1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805287; x=1731410087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JOw5uEvPR6a8QkhgQzDXycqZ5MmRpajBRDuZBG/wFA=;
        b=viLaKrEeq8kQ00dGAmUKTjlGS3dRRve8EhFPRr1MZFinoBWk+ad3GQcV59ZxShqCp0
         aDlyqEbEKKV3ouESq0WdNEJJDGjsrwm34BBf7ITObKfUR5Hnq/TMESPWX1p6OJdCV6FD
         pFJZ4SguvZyWbL6bPF4ZSmkDRWaQv9P4zJgUvgh8mHSU06G+qerpU0KN55UBidRqc0NB
         3mt6zg4QboRWwLiSWr13GlgTqIhJddozEn0u53Y/K7Ll2543MwTi1QXRhE9GM+YpONOH
         u5YNHmuPIty8ycucF0gssCHjUdsLiQWJlnpGuDP/3z0gbmTFRDXA7h5kYV/7m66dvPs2
         fbMw==
X-Gm-Message-State: AOJu0Yx6JOOrI27R1UuK7Jj/OZKU/YDUgueJ99uQbPkzsj5YRW1It9v8
	1O7cBWdsgTfWI9h8/FPVEWJY/jpDiF1VFaAqin2EGVFFU3q1daOVKqRBfuyS
X-Google-Smtp-Source: AGHT+IEy2443MDdlCWLegjXmp7neEaZjgKTMsMv3CtHhWbTprCQBGFXPUMrdMwLIFRI3Jz7SgN/98Q==
X-Received: by 2002:a17:902:da91:b0:20c:89b1:e76c with SMTP id d9443c01a7336-2111af6c539mr197032845ad.30.1730805286729;
        Tue, 05 Nov 2024 03:14:46 -0800 (PST)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3c3esm75928845ad.245.2024.11.05.03.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 03:14:46 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+d4d8c0fd15a0abe39bcf@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in taprio_dump
Date: Tue,  5 Nov 2024 20:14:42 +0900
Message-Id: <20241105111442.864442-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000000467ea060cc9a24b@google.com>
References: <0000000000000467ea060cc9a24b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 8a7d12d674ac6f2147c18f36d1e15f1a48060edf

