Return-Path: <linux-kernel+bounces-274626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D670F947AE6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B8C1C20F98
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065FA155C83;
	Mon,  5 Aug 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lkem5qvh"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129B13634B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859950; cv=none; b=dKe4OlFCKEm8+Rz9pirmIDyaea4Uewzo9ks5hxqTq6CGhJoRq/OIjZ/hntF5ADHrRO0L55Ulx7JAq91ZL9ibOUXjeFE9vh/DKadnSEEvn72G3wgqpuurXc/CnIx+mf/wxb1mwaoxpChJ2adJhNZgBrYhZLQz41EW6UXV8kUunXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859950; c=relaxed/simple;
	bh=5+12dyDflTzGewtYYnJxjMJLjYh6Wxpmke2KhzEkNpk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=PiSBA+6W75SjOAikprw/S7UBjnKAF6uOKbLjFyFKBa4LlLdJAuIXiyd8D37RJtqUlel2iMEe0ROqyzHVVMdH2PSphcIs3hY+ewf0Th1QPYDJqK/GoCg8DTt1vEbvp8jESiMGd3qBf6XJACsHl1he7uK8tgB0KkiY5gwqbhh8E3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lkem5qvh; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722859943; bh=rCPn7+aV5iIRERkizVNVdo//iYGK2bevx+9SMuF8TxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lkem5qvhSWcm3wwKi3OJDJnYfsEqNqfuO2ZeyM2l7Quvwxw6MewjkIOX6vN5J/fEG
	 QyNeVyeSqPBF7A/DllQ5MPmcy8o0qmEvEkSIQ9XFZEOLUo14ARs5isYJ/wqKF5HW/P
	 QkHaWuc/TaD+Iqj3Rs/Lvw6QHw/DnEIn3BxE0yIk=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id BACB42DF; Mon, 05 Aug 2024 19:46:44 +0800
X-QQ-mid: xmsmtpt1722858404tu8i96wdv
Message-ID: <tencent_48AA749F76BD66F03C5F3724972036684A09@qq.com>
X-QQ-XMAILINFO: NhpLzBn2I3Xw0QeAj7A6LJ8DAPNhvQ9ap0cc+sTnIPIfI0hnsbaxzoDzSW2eUs
	 1rWlV+2bmwKI2Qxr3vmInktgtnJnekQUCnyRs9IMbdJwqgmWUEqikK2lWuUKKFDcIUC7kzpFqTf+
	 UNm2iobSf+pBGHou0u/Akaos0b/yC0tQfM/5VE9pgMm5V1GQfCc10H55hlefOEE2fHLFdj5rDhOo
	 vsKN4cmLw+6AA7mHgxWs6yw+l7zTkvVp2IkjuASJD+WQng+aKh2sQOJmm+loU8JQZ4Q3q4dA/JJL
	 NYjLhTsH7hpKGtVX71LZT0ODIUv8hF+8WxOlt0BrNkQzoLeuTm/PQcjSDSe8R5/JOt7OCWc7JSV8
	 mMb7UzbiRLiTslmys7S9gUq8vGK+IGPIhXph46dwPAzBUpe6BG4wiiszm6PTNsxqMKCtb+n78/n/
	 tB5SUJ4EEUx2TtU0ixSh68besZQZ7+xtpDnmIdteA9CY/DLWsgfmm1PN6TRIxlpTy8cvBKoXhw4/
	 Uu2mpcAyPauQmjibkd0DqZZ5QsMgnnhPPmXk9xsqrQpRpQhWPqnplPw+AQyEUxojDNRmYWuy7WZg
	 JR3eig6sx+/nqdXaseRqwu1bpgqMl3dyIduzGjmd4IyLcdf5x/CZeLloNVhZJPK6mBpeqU3bP4D4
	 vzqpDlOfpEFk38R9PaDMcZYqdpp+Nu1IKFpaiavOcFCpTWY3lQF/0mg5zu2YqBG7gy6fvwZcuWCn
	 2p2iDcf/W1pMZk54gdlJQKGTvCZfw1Db6Pv7mIlZT1upl0DC/k+gXYa3sj0ZAUv3fmQin5VnA81U
	 Qwu8afWLEjTTrhIb+Wp9eJ7Zex9z2/n968v8on9kLK0iRp0eYSJb0Miypu3TwQszWYPKMapceQlB
	 fbLcXFH+nlhslb5cFgjtW0ekxkPtAdHsuQLyOIb6QbMdln+n3kxl8=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+eda89a33c5856f66f823@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] INFO: task hung in txBegin
Date: Mon,  5 Aug 2024 19:46:43 +0800
X-OQ-MSGID: <20240805114642.2900495-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000001f253b061bb8a953@google.com>
References: <0000000000001f253b061bb8a953@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

with sb rwsem lock to order syncfs and wb worker

#syz test: upstream 50736169ecc8

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index b865a3fa52f3..682c5a237edc 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -985,6 +985,7 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 	struct bdi_writeback *last_wb = NULL;
 	struct bdi_writeback *wb = list_entry(&bdi->wb_list,
 					      struct bdi_writeback, bdi_node);
+	bool no_queue = true;
 
 	might_sleep();
 restart:
@@ -1015,6 +1016,7 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 			*work = *base_work;
 			work->nr_pages = nr_pages;
 			work->auto_free = 1;
+			no_queue = false;
 			wb_queue_work(wb, work);
 			continue;
 		}
@@ -1043,6 +1045,12 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 		wb_wait_for_completion(&fallback_work_done);
 		goto restart;
 	}
+
+	if (no_queue) {
+		printk("no queue\n");
+		base_work->auto_free = 1;
+		finish_writeback_work(base_work);
+	}
 	rcu_read_unlock();
 
 	if (last_wb)


