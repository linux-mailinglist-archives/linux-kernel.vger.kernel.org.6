Return-Path: <linux-kernel+bounces-418982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572759D6809
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 08:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66799161213
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 07:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2A5185952;
	Sat, 23 Nov 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cure/U5c"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA474175D39
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732346489; cv=none; b=MTUfgoD1LIBeJMFhww/CNdm05jQKjUAKKZ+a8qIJ06COwWWv1e0HreC2vyCIBZB5O4qq3xzNAaO26sdOqkzmNr9SKIkB0mh2fLo4vCKQgl+k1+S2O+GebtRISyblEbTjfeyW7kQiPenO6YBSmDn2rLCwHKoq3oh4ClzUadeHxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732346489; c=relaxed/simple;
	bh=+z64crTzMeFzmw/jT4jJtpA1lPJMidF5DLwvfUo6cww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSgpom27b9t4Bx49yaxJnbAQHY1AZwB6VXGuU/aXEoeUAl2sdtShYfinT4r26IjLLtci8MyKgqttIvQk4kYz8F3CGTuLmRYk1BOaitKCoPpuR8J5RHsLY3oLLwenh/Xg08hzeY3r95fIdtJ4Gw6t5LHLWdoy/pBgQ0GMCB1z6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cure/U5c; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ed49ec0f1so451500766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 23:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732346485; x=1732951285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9y2CaneH6LYbzywEj7ypEqXyfCm8sgyQdgBr9xERX0c=;
        b=cure/U5cxm5en35gQes3hMT7f/thZI9c1WrzfpucNtjCrKpVKNB+rTvZcBNZj4HxIQ
         v/T41UDX9E3LVHbZpRIyVZBVbwT48LhoApD2TgYPrhoC2rQ9fKnY50Wbw0jtSytTO7Ae
         MBC8a/+hX8aNhfFPKqiVjwfSllJytrlcnwczaI6zLUMgB8UtBP58bBwsS9/0W1LlX5nO
         MP8/ULSCOPCaMxpzf5RfCzUTv0rVaM4XApcnuLxR4xO6glOBlZVhgb1oBex/MCkAyOxs
         MZT1MoqHqkcC06SWjmpa+n3PNj+glel6tPJmEtby5seWdVFL6Xjkl8jLC8RkGve/iIiF
         ZseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732346485; x=1732951285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9y2CaneH6LYbzywEj7ypEqXyfCm8sgyQdgBr9xERX0c=;
        b=soNrdERQVJg2ZlWvNoqukO/p5ftMNx2OPm/hGhJogFjl+OM6XbxWcz4AtN0Nt8oBCn
         xpGpdqw19GoJsVEG1toyInEgfM9pi0s3uVdUWES3whx30pzCCHo+1P5S3zTYSQIhKh0k
         WpK4W+f37Da2b2qE6xc8vptxLdNZg+hyKZCSZBJ5JYeNFnT0BGw4ibREsCAkzHqjIWHe
         4I3ClZSAmHo5NWjKD/hdyQo5TcWbCOa1fqJpC+XzToZ18zVdVxOK0sGjiudA+R1emIYb
         HomGOtkR0U09Qzht5NBN3HcNMc5Yo0lASilf4aZrEpAwZPibvf10Y+pezPGZA0i8wq2i
         0PdA==
X-Forwarded-Encrypted: i=1; AJvYcCXOfcTxQ28WbN9VqjwRPabdi6ZJnIelolo+CKnN4ms1uknZEpeIsHzriMO2+OSBZ5JAyK9Q/EMGg7n7ZYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeY8sU299Q1hQ308qrKjGmTBmsNUUwP/mXDBClJBjbdaWJTx5g
	SIXDEIitoFGhCe9VRXPVcVkA46wM9i9ySXPmVNrEsHH1QZyBVB9un7s3J6AU1aQ=
X-Gm-Gg: ASbGncuaeWgVCnGHEkNzDoqnguIbL4DkFHYEUgKOK7oKnTUGSAUtoLP6UiHjDSY7CUh
	dL4WNM1TiUcSTBxWZcOBl92GMLtYKGevc2JjVxwZIy6CHtqWUzMJJHfja1X2S1yws1vsPNaLtfj
	xmsv5jo5VxVpJi6SuamUt3T7363WfvDRGhuHauZiZvTSneYs5iwelMa4n46mmX/uMiGaCSLb4bb
	0zifq/RjaZBqNWtkzP/BdmcYgWPmOVA8l7ppNofmB8Xq/jNEUN0yCjZH8MwL9YIjrni6SF6jSl9
	cZB9LQMSBiSmqoovB6QPcnqtKmKwXYelO2O6253bS20PwzqgbQ==
X-Google-Smtp-Source: AGHT+IEY8ATKSUaTZnvSh1YYi/SwNKyCxkgCkPA+YBufTqzJcf0vqiSyrwM7memjfbxXU05UWPkOww==
X-Received: by 2002:a17:907:1c8e:b0:a9a:238a:381d with SMTP id a640c23a62f3a-aa509d7c6afmr559551466b.52.1732346485043;
        Fri, 22 Nov 2024 23:21:25 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f12b600023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f12:b600:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01ffd96e4sm1590029a12.60.2024.11.22.23.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 23:21:24 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 2/2] fs/ceph/mds_client: fix cred leak in ceph_mds_check_access()
Date: Sat, 23 Nov 2024 08:21:21 +0100
Message-ID: <20241123072121.1897163-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241123072121.1897163-1-max.kellermann@ionos.com>
References: <20241123072121.1897163-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_current_cred() increments the reference counter, but the
put_cred() call was missing.

Fixes: 596afb0b8933 ("ceph: add ceph_mds_check_access() helper")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index e8a5994de8b6..35d83c8c2874 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5742,6 +5742,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 
 		err = ceph_mds_auth_match(mdsc, s, cred, tpath);
 		if (err < 0) {
+			put_cred(cred);
 			return err;
 		} else if (err > 0) {
 			/* always follow the last auth caps' permision */
@@ -5757,6 +5758,8 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 		}
 	}
 
+	put_cred(cred);
+
 	doutc(cl, "root_squash_perms %d, rw_perms_s %p\n", root_squash_perms,
 	      rw_perms_s);
 	if (root_squash_perms && rw_perms_s == NULL) {
-- 
2.45.2


