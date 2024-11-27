Return-Path: <linux-kernel+bounces-423544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1809DA96A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74257281A82
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973A21FCFCC;
	Wed, 27 Nov 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ec4kS6CS"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E029463
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715696; cv=none; b=FS5qgxQXvy9kdYENJniHIOPAqICil78jhfZspnApEQuU1lEf5OpKYFRBD2q5kqJpppb1ajA8j4tFKpG8MYJhdo4ZQTl2T0YkhxLWdBZaJKPbcw2Of5Dwq+sZUNXOyWprxtefeLvCWQ8hJBc8mqA35uylLAZLZmyxqjWKkcih/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715696; c=relaxed/simple;
	bh=3pCxp2sEmnnhOYPG20VPBl+5c6731r2cYH09wiJt4+Q=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DoW5ms1TVkfIRCJz1KqHQ5hLk3/AzXLwqQoKk80EPANVv4T/nH/jjYRYEvfNUo5M4itBekDxC9SHqfHaM2OWBT3H4d2z6PjKerOf1b96iY842KAYhl5o9dPxSOB0drCvGMgPiFu4C2/wbff0HZecXbud7CQ6ATTCjBc3WqcTB2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ec4kS6CS; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732715381; bh=3pCxp2sEmnnhOYPG20VPBl+5c6731r2cYH09wiJt4+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ec4kS6CSjMa19t+ALCJH1hUH3QRLPVEoFos8I1v3agmDeVU1DnSyJVO4f33Ca2BZ+
	 EbwTF24K2qaqE7+BQKoC0T5zZY4y8oUll5rVsKfOFT/Jfj+UpmW5kAXQzdFvJUG+qF
	 Z4Ym5eCuJVVvzhFGUGhIpvGhUIECgQzZNEsxdd6s=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id C67B4889; Wed, 27 Nov 2024 21:49:39 +0800
X-QQ-mid: xmsmtpt1732715379tnuoag1v7
Message-ID: <tencent_30014B511B63257EBA56BB6633809E931B08@qq.com>
X-QQ-XMAILINFO: MvM61XSVXCtDOWupGBpF2hSNih6RCWvM5Lv7YXS6Z1RL7GBjNDlxb6FLapdIuz
	 +mwfCrT0h6SKA5xmczleK6O+bCZDqPQD9McA69St7P6Ekgzp1HJtDDKuic/8Cu5ugSP6KDTea9GN
	 p5oRiVdjbw7ERJaQFrg0Cu2XCZvrgdLhaC4aOvzIYbQi3n9jJnGyVnyTAqqOOtb9qf/Pc9tzbzwc
	 +NJixrpt3tlm908tlYX+YtqyIWcIyq9beoIAxMW+DH6Wk3eSJwhnqB8z+9RDgHOsAD7yMPWmBuhu
	 FY+1iYnoQ/RomWfPWdIPHx0GgsHtgiqwr6wdNIOPtvtRlUtHF6O9X6hc+0M8d6kidyc82MQqE8G+
	 Iw3sAkiUZW411nY5BVNdPebalrHwOZJ3TRSab3D2ULSSi8JRrlajXIGtC0p2bSF+Zj5SNUu1kxD1
	 EaWHLo79CJpqtM/KXiTe/zbfNclz2A+J4JGNGED0/xUrFW8xfSUGPkoQXc2ynVcQ0Wv2yuOTFXn0
	 +FLeMpG6maznOLdSdG9SHazdAyTF6dQOV0mGCIaU1MTu9qJ/WY1gV6aD+4rlnaji/0Vya+8OU0bY
	 ccmsNcnLBU8QTzRPkTgDt9r0P4uTZdJ2Xf7CZ7xHBjlt40XJIVCHVcX6GN13Ws438nno8fpp7nYb
	 RAZFL36BnQ6DdjgFL1lghGEiRc5E/Ql8AHN+hkRWg2kHee5qV16Qi1YwDPks9lU/mo4fiYAeFhQq
	 Fq59VQr/FWdjKy2LMYrl01kpes8ueZBTsSN7YmCEayeOnvWkD6LNCjIT2c1CsbEihmFdTT8V0tdO
	 g9dBpR8h33WlPYqPfKpawCesxdiyuQKil+GRVY/NFMEq3WnLOFl/J05wDu4JhDh5EFa8cuhDZ2gi
	 bApYqLqjBcrrvfR92zJTg=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c6811fc2262cec1e6266@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KASAN: slab-out-of-bounds Write in hfs_bnode_read
Date: Wed, 27 Nov 2024 21:49:40 +0800
X-OQ-MSGID: <20241127134939.1319362-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6746eaef.050a0220.21d33d.0020.GAE@google.com>
References: <6746eaef.050a0220.21d33d.0020.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

key length is too big, add a check for it before reading

#syz test: https://github.com/ea1davis/linux hfs/syz


