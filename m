Return-Path: <linux-kernel+bounces-569277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F169A6A0E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CF23AE236
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B138205AA5;
	Thu, 20 Mar 2025 08:01:48 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1E15A8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457708; cv=none; b=Zngh3zWQ2cJDruRBCiHxSEHut3CtshHC2C2QKWvWL0kBhev9eUQrNyv9Di/U3+kK+ENQbkYQU1YpBOIEbWmg5S/iSI5edzyBVTS6DfrHIIjJmAwB9gU3FEiK3DHl311RYxeaoGZxuky4kER5ov9aq7SSgq3u6YhUw0SLrYqHglA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457708; c=relaxed/simple;
	bh=88bRQ6wqAeT6MxN0t9xtncQL9d1/18HH0SwOFAgjjg0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=liqtdrG2vSMZgAprvK4sQoS7b90Xcak0CcMPbRlnQ8usSObE8FK+iqRpnTcf9ZYBr95JFawNfxwWPVjkJ+LRB2z8t6O85/Jvs3vdmziHzm9k1UnB+wU8roOLAVduLJ7m8uWKSusPPB4auta0VF7eij764QCzzuDkw2ifBvZN254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d44a3882a0so4501935ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742457705; x=1743062505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8is7iFSAmlrM2zAmO2ytfqcGAv9nfj5bb5h7M9lP44I=;
        b=sjq6AG7Ubp7kPaXMy34cMA2LUWAcwgoX9Yjj2ZxzDNEkBUXP9zQfs0aauPQ5dLH86X
         BpyUaNSBJvi+Es0EBtyxs6TsXDdA7J0Suxr827r2kX/LbN8jayFSKO9PWh66zErams3p
         d3iKwzaFqyhuivqtxAkqGANjAgZLL7xewkEKcg50puubZ8PZgA8tU5V11dhri1uBWfNp
         DiUZid1kr2Cw1oBf0jwiU+fUTQXVCSYaPEp0T75oz/QiGLy8tTtKNZ3QZBRkrGwipUxn
         ErpkWN6zBNmc3xlhPqkqiAnUo25ApSzsikS2/EqQpilDFXNQxDvmS2WvqBY45KYWrhbX
         vQkQ==
X-Gm-Message-State: AOJu0Ywoa+HWUMXrVoguiKTfVWXx2eX0g0fX8TSL3ipN68+EOKAz3WBM
	u5KEmxni3562C80ePxJrkZP0TvHON6ldZ7hpbx6HWn8A7/wdl2bEADK2vj05xbC2a8CNDlKEbdH
	X8AYr7TPbYjV1qjP/O1Flw3TFaXXYCW3gXdWfrcD645hYfLFD+82IMNI=
X-Google-Smtp-Source: AGHT+IHOFSEfuj7Jm54TfSF8KmcCdQhQq7rRutZo0kPy2IOoFsvLrrEEaUq2WPBdTSR4iJFxOcAbf7MYbN+BAG8WvtLK9Aw0p1YR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe8:b0:3d3:fa69:6755 with SMTP id
 e9e14a558f8ab-3d58e8596abmr19396385ab.5.1742457705702; Thu, 20 Mar 2025
 01:01:45 -0700 (PDT)
Date: Thu, 20 Mar 2025 01:01:45 -0700
In-Reply-To: <67bab9f0.050a0220.bbfd1.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dbcb69.050a0220.31a16b.0007.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] linux-next build error (20)
From: syzbot <syzbot+06fd1a3613c50d36129e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] linux-next build error (20)
Author: ardb@kernel.org

#syz test

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 993708d11874..7855cdc4e763 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -305,6 +305,7 @@ $(obj)/%.rs: $(obj)/%.rs.S FORCE
 getasmexports =
         \
    { echo "\#include <linux/kernel.h>" ;                               \
      echo "\#include <linux/string.h>" ;                               \
+     echo "\#define  __GENKSYMS__" ;                                   \
      echo "\#include <asm/asm-prototypes.h>" ;                         \
      $(call getexportsymbols,EXPORT_SYMBOL(\1);) ; }

