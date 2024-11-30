Return-Path: <linux-kernel+bounces-426118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B12F9DEF33
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EFBDB215D4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 07:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B620142659;
	Sat, 30 Nov 2024 07:02:56 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ECB1FB3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732950176; cv=none; b=Sp6SdEY9Y9ziYh+nzEBALeIKYm0qaXG8dgqseUZ5hJoOxWhaEsLL8V2cEsHxUo5k3j1uE57q5A6H1OTYaGhgTDImz476I7BBem3k4T/iASjwW6eH5UuX+BxxO4hRuQPy+4AZX/oqwKyQ3ttluB9WD9kFNjGiuG736Pe/dm8YTyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732950176; c=relaxed/simple;
	bh=kjRDG8WtbeouequKvj/UVCrYwsbfhnEMa1rqxfGhPlA=;
	h=From:To:Subject:Cc:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsOaJDYourWJXF5395qI9BuFOBABiZ4oupsM9d8FPRtGBfT/EGC3/2RuLYFYesN8+EMEvxBIdUbq2hczKXbjX/3zLTtWYwBl65+8DDfUEXzeS1IrxF8cCIMQxjvSkTk9zMxx2MqxlSt/N3AwUwFaVpTv7GhQBUhDP8AmdchYph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kiloview.com; spf=pass smtp.mailfrom=kiloview.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kiloview.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kiloview.com
X-QQ-mid: bizesmtpsz9t1732950142tnpjxr2
X-QQ-Originating-IP: 0g6bZfZ0ltr5uNCgu700GvvUu30xhMU5fM0jgkGFeyE=
Received: from [IPv6:::ffff:192.168.40.115] ( [113.240.218.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 30 Nov 2024 15:02:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14619738396533929951
From: Luoxi <kaixa@kiloview.com>
To: Jerry <jerrydeng079@163.com>
Subject: Re: [PATCH] Fix issue: Writing a block devices case dead loop.
 generic_perform_write()-> balance_dirty_pages_ratelimited()->
 balance_dirty_pages() At this point, if the block device removed, the process
 may trapped in a dead loop. and the memory of the bdi device hass also been
 released. I found this issue through SCSI devices
Cc: linux-mm@kvack.org, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Jerry <jerrydeng079@163.com>
Date: Sat, 30 Nov 2024 07:02:20 +0000
Message-Id: <em69028b68-d2c5-485d-a2ec-463c4673e723@f742d22a.com>
In-Reply-To: <20241130063431.79079-1-jerrydeng079@163.com>
References: <20241130063431.79079-1-jerrydeng079@163.com>
Reply-To: Luoxi <kaixa@kiloview.com>
User-Agent: eM_Client/10.1.4588.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:kiloview.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: ODfrXIp+dl2w0Tx+qK+NAOe8j3Owh+ScZGRJlcaB6u+b/sDg1J9lZ+Kf
	QEbg6XInsxzt+/mb7EDhlF3Ks76FAJy2rv/+cBDU6OiaoxfU2LV69mu6xhRBzwYI8Zly/sk
	CKORoKhqtmT1jwfV+4xKyNgdZWpGRm/BHlyaeLhE+XtXbrUI67Qvdcvz/OSl79bcEJUGAhI
	2DFLWXlkzYvkVhpEd5Xd2ckbQ5rCEeAFdjscOfavThfhRcdgtL0W32TllYnuCA4gkMp2y6a
	WrD0tSkkN2q7R8go/Yghk3s1+3qn8lsxO6nXQhjOsKIBEcefg7DX4FsHb+cRyRgGZTChCM2
	LgqHSSv/sRoiP937+HdPjWeDmo9phiQPb/jvHrMXpce+MfnUD2y9nWi8eqBt6Obvd4ax+2a
	ranlf+L/cEeMBNk0j1FVhBwcWQWdEaldTxZ+c4J8IXZdZGb2KwHKFeO72YQU1MsSx0ecrGI
	x3bghbMTvg78WqI4upqk281fn4+CPNAAde16pehQlWuL1emF/KILedlRLpvmSEmpoKZveNk
	USxu6IibPr1MO8PmWFJfP2MYsxGBV1iu4alQYoNv82g2CDQjnDQo/npJBzk2GDN4yxpb8FK
	YEavjZGpo0HIW/bgk3UU5GPka1Gm8lMijAVgDvhZJ/J6vbaMVrD5TxVfm8Cbxm/XgnbD42C
	jVk2e2ou2kvqhqSurCu98YcWPrr6Jtzdxi7+2upocEf5XAQ48+EWJT0asu05sp1deCTvZSw
	jQ94qTF74scKMNjcoGUf45+cn+iwtc81xVtPXqO72StN1Zv9gJvDuV+qSLxZv9cydVZZgPA
	g7+r/WoRS4dsWaae1tU2io2uaGmh+J34ZMp47CFmZg/qq9tAZbnkUPlR9LQq+Rw1Ovlq1ST
	q6ZkDfIAJn7ipijgFnHfpiW7ZpJdJjDYx2+J/B5zoi1H+kwVDRhBOMxMXQoLLpSWG5w2KRa
	PC3eF+aXNUxRvzer/BBAJN3T0
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Hi, Jerry

On 2024/11/30 14:34:31 +0800=EF=BC=8C"Jerry" <jerrydeng079@163.com> wrote:

>Signed-off-by: Jerry <jerrydeng079@163.com>
>---
>  mm/backing-dev.c    |  1 +
>  mm/filemap.c        |  6 ++++-
>  mm/page-writeback.c | 61 +++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 62 insertions(+), 6 deletions(-)
>
>diff --git a/mm/backing-dev.c b/mm/backing-dev.c
>index dd08ab928..0b86bd980 100755
>--- a/mm/backing-dev.c
>+++ b/mm/backing-dev.c
>@@ -878,6 +878,7 @@ void bdi_unregister(struct backing_dev_info *bdi)
>  	/* make sure nobody finds us on the bdi_list anymore */
>  	bdi_remove_from_list(bdi);
>  	wb_shutdown(&bdi->wb);
>+	wake_up(&(bdi->wb_waitq));
>  	cgwb_bdi_unregister(bdi);
>
>  	/*
>diff --git a/mm/filemap.c b/mm/filemap.c
>index 3b0d8c6dd..3282840f0 100755
>--- a/mm/filemap.c
>+++ b/mm/filemap.c
>@@ -3300,6 +3300,7 @@ ssize_t generic_perform_write(struct file *file,
>  	long status =3D 0;
>  	ssize_t written =3D 0;
>  	unsigned int flags =3D 0;
>+	errseq_t err =3D 0;
>
>  	do {
>  		struct page *page;
>@@ -3368,8 +3369,11 @@ ssize_t generic_perform_write(struct file *file,
>  		}
>  		pos +=3D copied;
>  		written +=3D copied;
>-
>  		balance_dirty_pages_ratelimited(mapping);
>+		err =3D errseq_check(&mapping->wb_err, 0);
>+		if (err)
>+			return err;
>+
>  	} while (iov_iter_count(i));
>
>  	return written ? written : status;
>diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>index b2c916474..e013a6d01 100755
>--- a/mm/page-writeback.c
>+++ b/mm/page-writeback.c
>@@ -146,6 +146,16 @@ struct dirty_throttle_control {
>  	unsigned long		pos_ratio;
>  };
>
>+
>+
>+struct bdi_wq_callback_entry {
>+
>+	struct task_struct *tsk;
>+	struct wait_queue_entry  wq_entry;
>+	int bdi_unregister;
>+};
>+
>+
>  /*
>   * Length of period for aging writeout fractions of bdis. This is an
>   * arbitrarily chosen number. The longer the period, the slower fraction=
s will
>@@ -1567,6 +1577,22 @@ static inline void wb_dirty_limits(struct dirty_thr=
ottle_control *dtc)
>  	}
>  }
>
>+
>+static int wake_up_bdi_waitq(wait_queue_entry_t *wait, unsigned int mode,
>+				int sync, void *key)
>+{
>+
>+	struct bdi_wq_callback_entry *bwce =3D
>+		container_of(wait, struct bdi_wq_callback_entry, wq_entry);
>+
>+	bwce->bdi_unregister =3D 1;
>+	if (bwce->tsk)
>+		wake_up_process(bwce->tsk);
>+
>+	return 0;
>+}
>+
>+
>  /*
>   * balance_dirty_pages() must be called by processes which are generatin=
g dirty
>   * data.  It looks at the number of dirty pages in the machine and will=
 force
>@@ -1574,7 +1600,7 @@ static inline void wb_dirty_limits(struct dirty_thro=
ttle_control *dtc)
>   * If we're over `background_thresh' then the writeback threads are woke=
n to
>   * perform some writeout.
>   */
>-static void balance_dirty_pages(struct bdi_writeback *wb,
>+static int balance_dirty_pages(struct bdi_writeback *wb,
>  				unsigned long pages_dirtied)
>  {
>  	struct dirty_throttle_control gdtc_stor =3D { GDTC_INIT(wb) };
>@@ -1595,6 +1621,16 @@ static void balance_dirty_pages(struct bdi_writebac=
k *wb,
>  	struct backing_dev_info *bdi =3D wb->bdi;
>  	bool strictlimit =3D bdi->capabilities & BDI_CAP_STRICTLIMIT;
>  	unsigned long start_time =3D jiffies;
>+	struct bdi_wq_callback_entry bwce =3D {NULL};
>+	int ret =3D 0;
>+
>+
>+	if (!test_bit(WB_registered, &wb->state))
>+		return -EIO;
>+
>+	init_waitqueue_func_entry(&(bwce.wq_entry), wake_up_bdi_waitq);
>+	bwce.tsk =3D current;
>+	add_wait_queue(&(bdi->wb_waitq), &(bwce.wq_entry));
>
>  	for (;;) {
>  		unsigned long now =3D jiffies;
>@@ -1816,6 +1852,12 @@ static void balance_dirty_pages(struct bdi_writebac=
k *wb,
>  		wb->dirty_sleep =3D now;
>  		io_schedule_timeout(pause);
>
>+		/* bid is unregister NULL, all bdi memory is illegal */
>+		if (bwce.bdi_unregister) {
>+			ret =3D -EIO;
>+			break;
>+		}
>+
>  		current->dirty_paused_when =3D now + pause;
>  		current->nr_dirtied =3D 0;
>  		current->nr_dirtied_pause =3D nr_dirtied_pause;
>@@ -1843,12 +1885,15 @@ static void balance_dirty_pages(struct bdi_writeba=
ck *wb,
>  		if (fatal_signal_pending(current))
>  			break;
>  	}
>+
>+	if (bwce.bdi_unregister =3D=3D 0)
>+		remove_wait_queue(&(bdi->wb_waitq), &(bwce.wq_entry));
>
>  	if (!dirty_exceeded && wb->dirty_exceeded)
>  		wb->dirty_exceeded =3D 0;
>
>  	if (writeback_in_progress(wb))
>-		return;
>+		return ret;
>
>  	/*
>  	 * In laptop mode, we wait until hitting the higher threshold before
>@@ -1859,10 +1904,12 @@ static void balance_dirty_pages(struct bdi_writeba=
ck *wb,
>  	 * background_thresh, to keep the amount of dirty memory low.
>  	 */
>  	if (laptop_mode)
>-		return;
>+		return ret;
>
>  	if (nr_reclaimable > gdtc->bg_thresh)
>  		wb_start_background_writeback(wb);
>+
>+	return ret;
>  }
>
>  static DEFINE_PER_CPU(int, bdp_ratelimits);
>@@ -1944,8 +1991,12 @@ void balance_dirty_pages_ratelimited(struct address=
_space *mapping)
>  	}
>  	preempt_enable();
>
>-	if (unlikely(current->nr_dirtied >=3D ratelimit))
>-		balance_dirty_pages(wb, current->nr_dirtied);
>+	if (unlikely(current->nr_dirtied >=3D ratelimit)) {
>+
>+		if (balance_dirty_pages(wb, current->nr_dirtied) < 0)
>+			errseq_set(&(mapping->wb_err), -EIO);
>+
>+	}
>
>  	wb_put(wb);
>  }
>--
>2.43.0
>
>
I think the title may be misplaced and needs to be described in concise=20
sentences. :)
For detailed process, please refer to this link:=20
https://docs.kernel.org/process/submitting-patches.html

Regards,
Luoxi


