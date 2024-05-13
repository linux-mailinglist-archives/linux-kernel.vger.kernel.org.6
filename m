Return-Path: <linux-kernel+bounces-177488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8808C3F7A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D179B1F21961
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E8114B098;
	Mon, 13 May 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Zv2Oz6W4"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D61C683
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715598692; cv=none; b=Dkl3qEwwdOSLRtxa09On0YxTsADSCBd0S1bWrziF8ngelTfriDe09sWavbTDioLxbkpas7CjSF8IG9g1hXFXnROcxNoRcyPWiRE0IX1Vr+Q8of8U2W1wWWGMtb9LBeclSvu9IgYheSUAG37YNmdduOV4D7HKJh8m0fQy/42QLMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715598692; c=relaxed/simple;
	bh=U+YaqH6u95D5uF12y/APAKShPk4UWSg2TpOgPH54Zyc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Lf+swNy6bHGkBpkgFdnrEoYuzwcXfXJGBCnffmxx9lqE3OJ4sVA9n1X0AD0qr+yGOQ2LuRgMFZUftXCKe0OHBEIh5T3EnBuomHiNr2On8zf36eLy2Iqj5eiaj8m1WCeBmyw5ooTx4NiDfPLZsPLVx3NG5PmjsExRO+lzBjQuuqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Zv2Oz6W4; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1715598679; bh=6GVfjJXD6j1M8r8F3XLriB0pU/GGSCO1tRe/La/6bzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zv2Oz6W45BUPPWjamM2RnLzlAmjVqp4L4quqS5dQIGI5Vz6Oafb5Hg2jazhhf74qq
	 3vZHMmzoF6gm/l0xqWQdltsC28M03uLgAIFj5xxmYf8QaKAGF7bG+xeAnfqmx3dZsC
	 Dr9Vv/3nxcuBT1dxC47hIVR7XJRMNjOeHY+6i338=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 14E25A3C; Mon, 13 May 2024 19:05:14 +0800
X-QQ-mid: xmsmtpt1715598314tpl5kyix0
Message-ID: <tencent_3966EDCECDA47B8A6C302F696D8C95DCE90A@qq.com>
X-QQ-XMAILINFO: NGX5+lQVxpC+wDGYtpk5c91FahQWw2mR49kAi3AsWwG0igWeMEqkrA73C2SVC7
	 M1mwvhIVZNY5QMTwHCudkjND1vwptDjR/WxaR9fzI9FJq3UatwOf/glxLVLEvYbl8DLVGmghBWq5
	 OJplN1zNDKSFUL/iIpyjqwsX+5KJ7+XJdKyqzzVxtHtTu1NJs01K8jNWa5yWhE9XBk42qB4wXTru
	 FZXZey4RPBpMU5k/a4G31dTynejy+fBk1M5hN/yD10+Gpw03O8ZkkrKj6n1F84fu1quuKy1rkNcz
	 jiZ2zd2yp0ZRsDXhxAmXo/vBvReMNkEBAq41gqpos6XV+QHRE9Po2yqgYM9u7a5fZfGhS6ayTRBa
	 OxVuRRjpDBB1eHfhRmd0sXNEGAXF8fQnDzYaNHn7HOxStpud9REgBvpWEpl7NFuQpaBDLGBRWo3G
	 /wnpEI+4tcUnlh6LVms4LhMLoJXoDe1ocsdQ6aQ1Ad10t9BKfs0NLhy2x2pOdhYZL0FD+2l9BdXo
	 krQShwaw07SPVFXZCXjfTOmrRDvXHa+vnMsMe95qmdfTDfkc+SUonDTER7vgIiQB3rAiVGJ0FRqI
	 5dPl8GZy0Ab+b4t91yxRf0myFcL2uJVXioJU+iD2IbS4bDvFtFnFbCga4qdvGfG9p2o1ZWqf5tSc
	 LbKo8Rj4DW9nrfhtGeabTwFh5mxumHzVKOVI2dxz6I0+s/zxT5AIuiG4lbsSwar1PLyi2sCzELE1
	 6Z9fLY4LOF8hWrnyfcqD5M5iWKfTWUTnQeikhZPb0m4bmsnCyhn/zMqddZy0SsMueKJqd6rmcOgf
	 h1LoZWz0xakEDFb5e/h3g9WxSVJ1KTY87sJUtk/sCqOdw45ICLGjsQPt3tmnip7ut1noUvAAcRur
	 Hl9gk+LwiJWOuhD0DSJxJRGgzfrmiFEkdbj1a9pYwsTojz+yBOATu7C2B0Z2cygw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+73414091bd382684ee2b@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in cpu_replicas_add_entry
Date: Mon, 13 May 2024 19:05:13 +0800
X-OQ-MSGID: <20240513110512.3275990-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000001e59c20618455922@google.com>
References: <0000000000001e59c20618455922@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test kb in cpu_replicas_add_entry

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git cf87f46fd34d

diff --git a/fs/bcachefs/opts.c b/fs/bcachefs/opts.c
index e1800c4119b5..2fc59b8aa32d 100644
--- a/fs/bcachefs/opts.c
+++ b/fs/bcachefs/opts.c
@@ -443,7 +443,7 @@ int bch2_parse_mount_opts(struct bch_fs *c, struct bch_opts *opts,
 			  char *options)
 {
 	char *copied_opts, *copied_opts_start;
-	char *opt, *name, *val;
+	char *opt, *name, *val, opts_set = 0;
 	int ret, id;
 	struct printbuf err = PRINTBUF;
 	u64 v;
@@ -498,8 +498,11 @@ int bch2_parse_mount_opts(struct bch_fs *c, struct bch_opts *opts,
 			goto bad_val;
 
 		bch2_opt_set_by_id(opts, id, v);
+		opts_set = 1;
 	}
 
+	if (!opts_set)
+		goto bad_opt;
 	ret = 0;
 	goto out;
 


