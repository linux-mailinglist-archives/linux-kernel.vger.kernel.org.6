Return-Path: <linux-kernel+bounces-236582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33E891E46D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46982B25C2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C1016D308;
	Mon,  1 Jul 2024 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ngd84U3V"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9816CD03
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848333; cv=none; b=ZDJj9Qvy+e48+RP/NWvlArF3D+35o8IXhS9kzDrKGg60f5GPKWeyRbZMHRGCCneLd9C9EmplOxpizHrfffou3pMQDvAtXnej+J6hC2EK4mJzjgt43OIGD9628E3DQQD0gyeBFuf1woxoLz5WqiyryNFCbsdDq3as/q9i8y/hpC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848333; c=relaxed/simple;
	bh=pbAYGwLE28gr9TrbbRP3f1it1/8qq5WYo0QBVGXRCWM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lOqgjN9eBCNcyS5YqsukviTE+6wrBL5p/K9eo3IWx7VsToTfOiYIttW2oNUhta2xhQMZd2b4/GDiWrffL5+0BWrqUxi1W1tNKey+KgjW0dT6MJNtftxfdqD5YIwrLzsGTSlLsTfhL8k0FiVv49pALeYo0FmtkkTMj3TLoOR1k1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ngd84U3V; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-702003e213eso1487352a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 08:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719848330; x=1720453130; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXUwAGiGhOwC1MFGaBHZYnH2eCKcomc9xabHa+31ciY=;
        b=ngd84U3V0L/S2O2uqDaXu0SBCL485+E27oXIfu5zB6sy50qf1oOBijBlQYSrQjInGH
         4jOqk1iPFnYyiwrNwnvx5K6fXUZsPDfFbxH2F9yBWwFXCZ+JDV0GnrfU4I7ZulUwbYM5
         tJa5vDkwVYM1BpmPAk+32Rg1+KxB0HEBBr/Yach8G4ppQFNEROpaOGbLTzAbHIGPYar9
         hjyT84yyvIL++mYG+EdwdpQEv94xE5IvDy77uBXtXPBeoNFVjkIc3mwEwpO+UD+4r3XE
         QvCE+6FOWvHqOQpHPY9j71poEPK8a7I/UIuhLv/PaarAZ9lYPt9/4TxSksl2je7QiioE
         8XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719848330; x=1720453130;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXUwAGiGhOwC1MFGaBHZYnH2eCKcomc9xabHa+31ciY=;
        b=JOm6m2wQZr46AvJQfP7A3sOkbgp55vhoWZo6hTCXP9w/u+y8lrkdXJO5nwSBrWABI1
         4GG5UVEKIAtUMp3L05Sf014B4MWI59tljG6AoTvZaGLlTCeXvA9twYGfrjDEUDqlqa76
         q2HCe/xtel21TX1QxVf4cWHXbe3BElzdd7BVp+MBJyY4uNWEkeCfxY48iRTYkUIOL1Zi
         vYaQEhg4fEyBinBTp2BwqNnx+Xj33V72jd+CoDYoDsco5PyoUyapkekEK4/0YW8IU+aN
         u8wmiT92owpdHYrhr5ohhLXOQJ7+cPbVYv2v7tVUuz4vINWTFxXRiCMWV3CYAe5u+f44
         0agw==
X-Forwarded-Encrypted: i=1; AJvYcCXaIHVg/qXYLAZ1p/tvwj1xe36ailQKyxwK9n8cShsPsCbq/0dreXFw0ypSzoXZTsFiHosgP61ojTb3Lqsui5aWaG3cBZ03mtz4lKpA
X-Gm-Message-State: AOJu0YyJkvNgonfm3wEINIjTki6ZTb1kj4iMs7eF0dno+sozEWEsQJEy
	jIisDFB6Bpg0a05sZSneRSlEOIUu+Gl4ZOrMmDIJTyjsmpRu6IkSp5bdBUf+53A=
X-Google-Smtp-Source: AGHT+IH2RZ/mNHf0OSJ/upQaUsA6zNyNbfJvqFRCnyP+riRpPNyhbZZNFy45+vCDbGN1vOGnwT6Y8g==
X-Received: by 2002:a9d:6956:0:b0:700:d3ec:3633 with SMTP id 46e09a7af769-70207650f3emr7791302a34.8.1719848329647;
        Mon, 01 Jul 2024 08:38:49 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e8c6:2364:637f:c70e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7a98ab2sm1292101a34.9.2024.07.01.08.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:38:48 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:38:47 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Andreas Gruenbacher <agruenba@redhat.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: fs/gfs2/log.c:1158 gfs2_log_flush() error: we previously assumed
 'sdp->sd_jdesc' could be null (see line 1111)
Message-ID: <151ef3e4-abee-4627-9669-038b1d95c2d3@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   55027e689933ba2e64f3d245fb1ff185b3e7fc81
commit: 35264909e9d1973ab9aaa2a1b07cda70f12bb828 gfs2: Fix NULL pointer dereference in gfs2_log_flush
config: um-randconfig-r071-20240623 (https://download.01.org/0day-ci/archive/20240625/202406250943.QhOuua0F-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad79a14c9e5ec4a369eed4adf567c22cc029863f)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406250943.QhOuua0F-lkp@intel.com/

smatch warnings:
fs/gfs2/log.c:1158 gfs2_log_flush() error: we previously assumed 'sdp->sd_jdesc' could be null (see line 1111)

vim +1158 fs/gfs2/log.c

c1696fb85d3319 Bob Peterson        2018-01-17  1040  void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
b3b94faa5fe596 David Teigland      2006-01-16  1041  {
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1042  	struct gfs2_trans *tr = NULL;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1043  	unsigned int reserved_blocks = 0, used_blocks = 0;
5432af15f8772d Andreas Gruenbacher 2022-08-18  1044  	bool frozen = test_bit(SDF_FROZEN, &sdp->sd_flags);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1045  	unsigned int first_log_head;
2129b4288852cf Andreas Gruenbacher 2020-12-17  1046  	unsigned int reserved_revokes = 0;
b3b94faa5fe596 David Teigland      2006-01-16  1047  
484adff8a06cb5 Steven Whitehouse   2006-03-29  1048  	down_write(&sdp->sd_log_flush_lock);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1049  	trace_gfs2_log_flush(sdp, 1, flags);
b3b94faa5fe596 David Teigland      2006-01-16  1050  
fe3e397668775e Andreas Gruenbacher 2020-12-10  1051  repeat:
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1052  	/*
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1053  	 * Do this check while holding the log_flush_lock to prevent new
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1054  	 * buffers from being added to the ail via gfs2_pin()
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1055  	 */
4d927b03a68846 Andreas Gruenbacher 2023-12-20  1056  	if (gfs2_withdrawing_or_withdrawn(sdp) ||
4d927b03a68846 Andreas Gruenbacher 2023-12-20  1057  	    !test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1058  		goto out;
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1059  
2bcd610d2fdea6 Steven Whitehouse   2007-11-08  1060  	/* Log might have been flushed while we waited for the flush lock */
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1061  	if (gl && !test_bit(GLF_LFLUSH, &gl->gl_flags))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1062  		goto out;
f55ab26a8f92a2 Steven Whitehouse   2006-02-21  1063  
fe3e397668775e Andreas Gruenbacher 2020-12-10  1064  	first_log_head = sdp->sd_log_head;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1065  	sdp->sd_log_flush_head = first_log_head;
400ac52e805bb6 Benjamin Marzinski  2015-12-09  1066  
16ca9412d80181 Benjamin Marzinski  2013-04-05  1067  	tr = sdp->sd_log_tr;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1068  	if (tr || sdp->sd_log_num_revoke) {
fe3e397668775e Andreas Gruenbacher 2020-12-10  1069  		if (reserved_blocks)
fe3e397668775e Andreas Gruenbacher 2020-12-10  1070  			gfs2_log_release(sdp, reserved_blocks);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1071  		reserved_blocks = sdp->sd_log_blks_reserved;
2129b4288852cf Andreas Gruenbacher 2020-12-17  1072  		reserved_revokes = sdp->sd_log_num_revoke;
16ca9412d80181 Benjamin Marzinski  2013-04-05  1073  		if (tr) {
16ca9412d80181 Benjamin Marzinski  2013-04-05  1074  			sdp->sd_log_tr = NULL;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1075  			tr->tr_first = first_log_head;
5432af15f8772d Andreas Gruenbacher 2022-08-18  1076  			if (unlikely(frozen)) {
ca399c96e96e3f Bob Peterson        2020-01-08  1077  				if (gfs2_assert_withdraw_delayed(sdp,
ca399c96e96e3f Bob Peterson        2020-01-08  1078  				       !tr->tr_num_buf_new && !tr->tr_num_databuf_new))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1079  					goto out_withdraw;
16ca9412d80181 Benjamin Marzinski  2013-04-05  1080  			}
2129b4288852cf Andreas Gruenbacher 2020-12-17  1081  		}
fe3e397668775e Andreas Gruenbacher 2020-12-10  1082  	} else if (!reserved_blocks) {
fe3e397668775e Andreas Gruenbacher 2020-12-10  1083  		unsigned int taboo_blocks = GFS2_LOG_FLUSH_MIN_BLOCKS;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1084  
fe3e397668775e Andreas Gruenbacher 2020-12-10  1085  		reserved_blocks = GFS2_LOG_FLUSH_MIN_BLOCKS;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1086  		if (current == sdp->sd_logd_process)
fe3e397668775e Andreas Gruenbacher 2020-12-10  1087  			taboo_blocks = 0;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1088  
fe3e397668775e Andreas Gruenbacher 2020-12-10  1089  		if (!__gfs2_log_try_reserve(sdp, reserved_blocks, taboo_blocks)) {
fe3e397668775e Andreas Gruenbacher 2020-12-10  1090  			up_write(&sdp->sd_log_flush_lock);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1091  			__gfs2_log_reserve(sdp, reserved_blocks, taboo_blocks);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1092  			down_write(&sdp->sd_log_flush_lock);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1093  			goto repeat;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1094  		}
2129b4288852cf Andreas Gruenbacher 2020-12-17  1095  		BUG_ON(sdp->sd_log_num_revoke);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1096  	}
fe3e397668775e Andreas Gruenbacher 2020-12-10  1097  
fe3e397668775e Andreas Gruenbacher 2020-12-10  1098  	if (flags & GFS2_LOG_HEAD_FLUSH_SHUTDOWN)
fe3e397668775e Andreas Gruenbacher 2020-12-10  1099  		clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
f55ab26a8f92a2 Steven Whitehouse   2006-02-21  1100  
5432af15f8772d Andreas Gruenbacher 2022-08-18  1101  	if (unlikely(frozen))
2129b4288852cf Andreas Gruenbacher 2020-12-17  1102  		if (gfs2_assert_withdraw_delayed(sdp, !reserved_revokes))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1103  			goto out_withdraw;
b3b94faa5fe596 David Teigland      2006-01-16  1104  
d7b616e252b125 Steven Whitehouse   2007-09-02  1105  	gfs2_ordered_write(sdp);
4d927b03a68846 Andreas Gruenbacher 2023-12-20  1106  	if (gfs2_withdrawing_or_withdrawn(sdp))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1107  		goto out_withdraw;
d69a3c6561362a Steven Whitehouse   2014-02-21  1108  	lops_before_commit(sdp, tr);
4d927b03a68846 Andreas Gruenbacher 2023-12-20  1109  	if (gfs2_withdrawing_or_withdrawn(sdp))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1110  		goto out_withdraw;
35264909e9d197 Andreas Gruenbacher 2024-03-11 @1111  	if (sdp->sd_jdesc)

Is this check really required?

82218943058d5e Bob Peterson        2021-01-21  1112  		gfs2_log_submit_bio(&sdp->sd_jdesc->jd_log_bio, REQ_OP_WRITE);
4d927b03a68846 Andreas Gruenbacher 2023-12-20  1113  	if (gfs2_withdrawing_or_withdrawn(sdp))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1114  		goto out_withdraw;
d7b616e252b125 Steven Whitehouse   2007-09-02  1115  
34cc1781c2ae92 Steven Whitehouse   2012-03-09  1116  	if (sdp->sd_log_head != sdp->sd_log_flush_head) {
c1696fb85d3319 Bob Peterson        2018-01-17  1117  		log_write_header(sdp, flags);
5cb738b5fbd2f3 Andreas Gruenbacher 2020-12-19  1118  	} else if (sdp->sd_log_tail != sdp->sd_log_flush_tail && !sdp->sd_log_idle) {
c1696fb85d3319 Bob Peterson        2018-01-17  1119  		log_write_header(sdp, flags);
2332c4435bb733 Robert Peterson     2007-06-18  1120  	}
4d927b03a68846 Andreas Gruenbacher 2023-12-20  1121  	if (gfs2_withdrawing_or_withdrawn(sdp))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1122  		goto out_withdraw;
16ca9412d80181 Benjamin Marzinski  2013-04-05  1123  	lops_after_commit(sdp, tr);
b09e593d799560 Steven Whitehouse   2006-04-07  1124  
fe1a698ffef5af Steven Whitehouse   2006-10-11  1125  	gfs2_log_lock(sdp);
faa31ce85f626d Steven Whitehouse   2006-09-13  1126  	sdp->sd_log_blks_reserved = 0;
b3b94faa5fe596 David Teigland      2006-01-16  1127  
d6a079e82efd5f Dave Chinner        2011-03-11  1128  	spin_lock(&sdp->sd_ail_lock);
16ca9412d80181 Benjamin Marzinski  2013-04-05  1129  	if (tr && !list_empty(&tr->tr_ail1_list)) {
16ca9412d80181 Benjamin Marzinski  2013-04-05  1130  		list_add(&tr->tr_list, &sdp->sd_ail1_list);
16ca9412d80181 Benjamin Marzinski  2013-04-05  1131  		tr = NULL;
b3b94faa5fe596 David Teigland      2006-01-16  1132  	}
d6a079e82efd5f Dave Chinner        2011-03-11  1133  	spin_unlock(&sdp->sd_ail_lock);
b3b94faa5fe596 David Teigland      2006-01-16  1134  	gfs2_log_unlock(sdp);
24972557b12ce8 Benjamin Marzinski  2014-05-01  1135  
c1696fb85d3319 Bob Peterson        2018-01-17  1136  	if (!(flags & GFS2_LOG_HEAD_FLUSH_NORMAL)) {
24972557b12ce8 Benjamin Marzinski  2014-05-01  1137  		if (!sdp->sd_log_idle) {
d5dc3d9677394d Bob Peterson        2020-05-22  1138  			empty_ail1_list(sdp);
4d927b03a68846 Andreas Gruenbacher 2023-12-20  1139  			if (gfs2_withdrawing_or_withdrawn(sdp))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1140  				goto out_withdraw;
c1696fb85d3319 Bob Peterson        2018-01-17  1141  			log_write_header(sdp, flags);
24972557b12ce8 Benjamin Marzinski  2014-05-01  1142  		}
c1696fb85d3319 Bob Peterson        2018-01-17  1143  		if (flags & (GFS2_LOG_HEAD_FLUSH_SHUTDOWN |
c1696fb85d3319 Bob Peterson        2018-01-17  1144  			     GFS2_LOG_HEAD_FLUSH_FREEZE))
24972557b12ce8 Benjamin Marzinski  2014-05-01  1145  			gfs2_log_shutdown(sdp);
24972557b12ce8 Benjamin Marzinski  2014-05-01  1146  	}
24972557b12ce8 Benjamin Marzinski  2014-05-01  1147  
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1148  out_end:
fe3e397668775e Andreas Gruenbacher 2020-12-10  1149  	used_blocks = log_distance(sdp, sdp->sd_log_flush_head, first_log_head);
2129b4288852cf Andreas Gruenbacher 2020-12-17  1150  	reserved_revokes += atomic_read(&sdp->sd_log_revokes_available);
2129b4288852cf Andreas Gruenbacher 2020-12-17  1151  	atomic_set(&sdp->sd_log_revokes_available, sdp->sd_ldptrs);
2129b4288852cf Andreas Gruenbacher 2020-12-17  1152  	gfs2_assert_withdraw(sdp, reserved_revokes % sdp->sd_inptrs == sdp->sd_ldptrs);
2129b4288852cf Andreas Gruenbacher 2020-12-17  1153  	if (reserved_revokes > sdp->sd_ldptrs)
2129b4288852cf Andreas Gruenbacher 2020-12-17  1154  		reserved_blocks += (reserved_revokes - sdp->sd_ldptrs) / sdp->sd_inptrs;
30fe70a85a909a Bob Peterson        2019-11-13  1155  out:
2129b4288852cf Andreas Gruenbacher 2020-12-17  1156  	if (used_blocks != reserved_blocks) {
2129b4288852cf Andreas Gruenbacher 2020-12-17  1157  		gfs2_assert_withdraw_delayed(sdp, used_blocks < reserved_blocks);
fe3e397668775e Andreas Gruenbacher 2020-12-10 @1158  		gfs2_log_release(sdp, reserved_blocks - used_blocks);
                                                                                 ^^^
Because gfs2_log_release() dereferences sdp->sd_jdesc without checking.

2129b4288852cf Andreas Gruenbacher 2020-12-17  1159  	}
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1160  	up_write(&sdp->sd_log_flush_lock);
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1161  	gfs2_trans_free(sdp, tr);
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1162  	if (gfs2_withdrawing(sdp))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1163  		gfs2_withdraw(sdp);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1164  	trace_gfs2_log_flush(sdp, 0, flags);
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1165  	return;
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1166  
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1167  out_withdraw:
462582b99b6079 Bob Peterson        2020-08-21  1168  	trans_drain(tr);
58e08e8d83ab03 Bob Peterson        2020-06-09  1169  	/**
58e08e8d83ab03 Bob Peterson        2020-06-09  1170  	 * If the tr_list is empty, we're withdrawing during a log
58e08e8d83ab03 Bob Peterson        2020-06-09  1171  	 * flush that targets a transaction, but the transaction was
58e08e8d83ab03 Bob Peterson        2020-06-09  1172  	 * never queued onto any of the ail lists. Here we add it to
58e08e8d83ab03 Bob Peterson        2020-06-09  1173  	 * ail1 just so that ail_drain() will find and free it.
58e08e8d83ab03 Bob Peterson        2020-06-09  1174  	 */
58e08e8d83ab03 Bob Peterson        2020-06-09  1175  	spin_lock(&sdp->sd_ail_lock);
58e08e8d83ab03 Bob Peterson        2020-06-09  1176  	if (tr && list_empty(&tr->tr_list))
58e08e8d83ab03 Bob Peterson        2020-06-09  1177  		list_add(&tr->tr_list, &sdp->sd_ail1_list);
58e08e8d83ab03 Bob Peterson        2020-06-09  1178  	spin_unlock(&sdp->sd_ail_lock);
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1179  	tr = NULL;
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1180  	goto out_end;
b3b94faa5fe596 David Teigland      2006-01-16  1181  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


