Return-Path: <linux-kernel+bounces-419053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979319D68F3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11269B218CE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04B17A583;
	Sat, 23 Nov 2024 11:55:55 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF705A95C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732362955; cv=none; b=Ch/T03xGrzSbo1Qp74QhkLeXcXXZ88uLEoJ0xZ1rfC96WjNjNFPmnwBUsP5uuP4Qu+y15/dGvWn1gjt1cCwCrepHr4oTc65+XVNZcIKBHGkNZhoj8/AooxaksPpyMX5cdU0fhlJJ2TJeEmGwzPj6MqetnPQtoufSGP9Tm6UDMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732362955; c=relaxed/simple;
	bh=BilQArbDi6vR3IP9fsFW6JRzfV6qc3Likfim/Q/p3uo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=gR7CJ01IIBi/FyuWRC6b43NDqEWE2ctx9JlK0Zl0KmkmFamQfT0ENkWWYmLTKMumn/wRmyrlewwUL4ADmwrsjUuDaOe2b6RAf2v+wMOJkRHr8wv98jFXX0v4U+CdZtUIYL2zWpalnE+rMc1NylPdpRs3uJ5tJPbXgcwqw9mDPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4ANBtjXv046768;
	Sat, 23 Nov 2024 20:55:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4ANBtiI4046760
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 23 Nov 2024 20:55:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4fa33a28-7cda-47d8-be4c-238e022406e9@I-love.SAKURA.ne.jp>
Date: Sat, 23 Nov 2024 20:55:45 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: kernel BUG in hfs_write_inode
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp
X-Virus-Status: clean

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.12

 fs/hfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index a81ce7a740b9..794d710c3ae0 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -81,7 +81,7 @@ static bool hfs_release_folio(struct folio *folio, gfp_t mask)
 		tree = HFS_SB(sb)->cat_tree;
 		break;
 	default:
-		BUG();
+		pr_warn("unexpected inode %lu at %s()\n", inode->i_ino, __func__);
 		return false;
 	}
 
@@ -305,7 +305,7 @@ static int hfs_test_inode(struct inode *inode, void *data)
 	case HFS_CDR_FIL:
 		return inode->i_ino == be32_to_cpu(rec->file.FlNum);
 	default:
-		BUG();
+		pr_warn("unexpected type %u at %s()\n", rec->type, __func__);
 		return 1;
 	}
 }
@@ -441,7 +441,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
 			return 0;
 		default:
-			BUG();
+			pr_warn("unexpected inode %lu at %s()\n", inode->i_ino, __func__);
 			return -EIO;
 		}
 	}
-- 
2.47.0

