Return-Path: <linux-kernel+bounces-393066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DFB9B9B81
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3616FB229D3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F308442F;
	Sat,  2 Nov 2024 00:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/VM96iG"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D38C1F5F6
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506202; cv=none; b=mPUS9WpK1uZJcc0xEQNHi4fa2Cq2OyYpoQReAZypakmWmgAT3UiRtvGQIAST0bvoOUfXkfPOzVUL2h9ScLlumjPv1EKMHcJc6waq8HCjOoc/fUkFEf6JRchuLBUwZq2PE9j+vPevzb6wvbewvqWmuWIu7EwlDSpz5mCo7vtr/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506202; c=relaxed/simple;
	bh=B7yrHSjlVWujg+44MuHc0OAW1FOOtWWFTp3LUWBjuxw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=td95jgD8t1Uk/DwwNrgvtuVdPx8o3aELD2I7Pc32z4MxJGsUAoFPULEcUo57aKj2G/4l0gR7u2wljrPfJ5L/6Ls1Hh/sQRPDYx9yxDIN/jbe+QlyWnjjj49VaTPee2KHu/D66Y+s5ga0ktw8EjPTC5td4uGGJD+jtW51IwKoIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/VM96iG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71ec997ad06so2113116b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730506200; x=1731111000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3NVNQIchibySQOUv0YWwmxPRb985DT6vy5pdMfNDxk=;
        b=c/VM96iGsbWp9oW2upGEeu+3SeS4T7f0G3+q77/eRlcPiFquYC8/UDLHxeN2EWKjjb
         o0GeF/aWnFU2X//0o9s4dvFEfyc0Ts+3n6WYCJ/HlPE/SZxEwIuU8EQKjEwi4ulNZOZ5
         w+HlarEWv6Hf5up3AIObGkbogtm2Hr9BdpHGZA0m0BQ5Kx8OoezXAoNZATqK+YUvcbii
         y8I2JA5PRdqUdWAzqdzQ75/Mx3v77FqLfX7ugDVLtd+8B7ErXjYzUURw4I3XwV1zHnGI
         cwBQ8DaPiHLrpMCMXKGAUBMIRFyU1n6xchTOBx7Esnq8nrM6Gs5eSu2n99XVE4R3zZF/
         lnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506200; x=1731111000;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k3NVNQIchibySQOUv0YWwmxPRb985DT6vy5pdMfNDxk=;
        b=RO2JC65Ng8OVpknjAHA8QQ1qRBKmBZG5vlxgIMjNPHpr7CIpZaYZTXOuIVivWeYzgN
         TeclVyzw2wgs1YMlJJPSx/uqrkmaUWOshDofu7UTG7S8dlRYdczwr0up70bHghB9FI51
         IhjqpoyimTVHcCZq1CkRNGBznrvoKYrbURdLe+N08kIsV2Wy1bS+7OM/nq1Wur8uYs/I
         I3DXuxA1QB9UU2wIxPnvFBLwZjfxbbocwCXsdl5Mb9dIsnuJZM3lsiIMSckHiafRVMj0
         eOP2wHFoatMOJH/DfW4r1URbcTJqQ9uhtWTx8QVC1Rf6t/XS+7e9VpeujJtx+RnBiN4N
         P1IA==
X-Gm-Message-State: AOJu0YwstT8yFhgN6Jr/WWpwAgYIjf17cEwcYkR7D2NXlAm3RsVP2TlB
	DQKX5nYMUMZouC4KCi4EwGKSGuhZur4NxMUYB1cDkCz++ZGEM+E5
X-Google-Smtp-Source: AGHT+IHpOgwNvGilZtvp0W9Ya0wqe3A+29sE4AfsAQ2K32e4wV5QFjkK1JKVgvldAZicTTVvtjNHLg==
X-Received: by 2002:a05:6a20:6f87:b0:1d9:4837:ad7c with SMTP id adf61e73a8af0-1d9eeb8321bmr18263939637.12.1730506199842;
        Fri, 01 Nov 2024 17:09:59 -0700 (PDT)
Received: from localhost (i114-180-55-233.s42.a014.ap.plala.or.jp. [114.180.55.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee455a776dsm3083057a12.47.2024.11.01.17.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:09:58 -0700 (PDT)
Date: Sat, 02 Nov 2024 09:08:20 +0900 (JST)
Message-Id: <20241102.090820.1442069226259701918.konishi.ryusuke@gmail.com>
To: syzbot+9982fb8d18eba905abe2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] general protection fault in touch_buffer
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
In-Reply-To: <672270b5.050a0220.3c8d68.052a.GAE@google.com>
References: <672270b5.050a0220.3c8d68.052a.GAE@google.com>
X-Mailer: Mew version 6.8 on Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The cause of this problem seems to be that bh->b_bdev is not set when
touch_buffer() is called (it is set later by the calling functions).

This causes a general protection fault when the trace point
trace_block_touch_buffer() in touch_buffer() references
bh->b_bdev->bd_dev.

touch_buffer() mark the folio owned by the buffer as accessed by
calling folio_mark_accessed(), but nilfs_grab_buffer(), the only
caller of __nilfs_get_folio_block(), acquires the folio through
filemap_grab_folio(), which sets the folio as accessed by specifying
the FGP_ACCESSED flag, so there is not need to call touch_buffer() in
the first place.

Once I have confirmed that there is not problem, including the past
history, I will turn this into a formal bug fix patch.

Ryusuke Konishi


#syz test

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 10def4b55995..296dbf9cca22 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -39,7 +39,6 @@ static struct buffer_head *__nilfs_get_folio_block(struct folio *folio,
 	first_block = (unsigned long)index << (PAGE_SHIFT - blkbits);
 	bh = get_nth_bh(bh, block - first_block);
 
-	touch_buffer(bh);
 	wait_on_buffer(bh);
 	return bh;
 }
-- 
2.43.0

