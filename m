Return-Path: <linux-kernel+bounces-416151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E569D40F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCB7283620
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D907119CCFC;
	Wed, 20 Nov 2024 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vWXQOpo2"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C87013D520
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123120; cv=none; b=g4rZXPyU8FnjKH71wg8DGVV1q5VTeOBjWWkIGglAHDa5z182izfd4RFfxF98WQmMWFhV/7jfec1tzQBpbYAlRwLMDWHQ5ytZ/+v46V6lnO1I22SU5fpn6DKBuEr/OPSgd08sa7Nssky+b72LAeyzfs1gryGGGXD5gWVA2BkydbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123120; c=relaxed/simple;
	bh=i9lBSWFYP6iGVF9K57CJ12bcNiGVIPE6WKd4wy5FNvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wsp7aUxFZyBFPtekSpCUGLi7ArTnb14BogpNkBoGY3GP8RQPchY0bYiY8YuYQaKfFLH73rXmzBTfCDLecJ7R3limnE919iTtjh8NFytC5fnzGDlWt+nET3mGxjcVbHFG8mjEU0n1J1ec8WhKA7bqSWYcI3PFYBO8RGcgsZW99BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vWXQOpo2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43163667f0eso41196585e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732123115; x=1732727915; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BrN4jnx/DXfC0UwxYbDC3cvmXnvAO37Xv/dCbsQ/GeY=;
        b=vWXQOpo2XUhZ+fXAQO4rZCblnLrUgkrSQi+LH+wmkB6GOMr6c/dAgajyeCIK7RHgjR
         5kfYcPbICuVrYDurybC9AnirbdK+MVQ2CCu/1MMcGd5mJpNitYx3pYwgC3fHEQtLy3jI
         4rEy2UvFF0R55aTJjpjgoAA5jhhieKxrcn5A4ST/ZQQsck394oSVBP8XJ+TMWN2wOSUk
         bBPN34c3yXTh4pEailHi9d2Cdh+BbRSHBQTQPp0BaXg7k7DMEkVHGr/MsgJ6EgpHJDCu
         fGaXARzaigh1pL2CRLoFj3e05uMtiAZ8gafoxJXZm7iEkCmP8IUagn63om+rhdjDs/hZ
         cZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732123115; x=1732727915;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrN4jnx/DXfC0UwxYbDC3cvmXnvAO37Xv/dCbsQ/GeY=;
        b=YZ9ulbNlAS4E1NH7I1UI8VfpAemj9/QItmIAKNzWvC7ySwuCtAOV3QJfQgDrsGJZhI
         Yhv1MazyKW5JpgbtRCy4NAqsadB8lex98KixTdTl2kDN0uxNeeZPYm6nTxx4Rg/BO07B
         ap/CN0utwl7IGflZDlJiVc/u40QlDGMAhGL5qSeMV+245khgoxwsTSghptuKmP4trr+j
         TxdeMuxe09JM+F+ug1q4vnik6rFpU6i2ZnSE5V4SV1BaPbCm6GUXfm8GnJriBSQsrfQl
         2F8SOQ0rWKGJS5PCCzA8h5hbX4WHCZVc/Zhu7KHfv3n4SaFFaPLqK48qiQ5gaBNNu/5u
         +k9A==
X-Forwarded-Encrypted: i=1; AJvYcCXUEVO8n5NmbRl8DBCUB31ex0esbBZe2k6w4HuBZ9k3I6aPJp3vAJU/eSG0qj9hgB1LS0oSG2Ot0L1A7zA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4jsJEVxiC9tX0aQZ3Y1yCVL8foG0DzyTTfmHY0UQMPDM6eaaD
	CTeKt6dMacjry0eh8vqvYogwGCDU6+6Tg+7d9xERCea01ls9nxMvn0Dvh3RTNqk=
X-Google-Smtp-Source: AGHT+IEMl+Umzt9pfPJny9A4FApXoCusklewOWpxImV08bteT+GtUrMqokXLGrs0BQncUmJ0q6YgKA==
X-Received: by 2002:a05:6000:4029:b0:382:4978:2aaf with SMTP id ffacd0b85a97d-38254b259f0mr3136310f8f.57.1732123115553;
        Wed, 20 Nov 2024 09:18:35 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493ee14sm2541451f8f.99.2024.11.20.09.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:18:34 -0800 (PST)
Date: Wed, 20 Nov 2024 20:18:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ralph Boehme <slow@samba.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] smb/client: Prevent error pointer dereference
Message-ID: <e0addd3d-2687-4619-8f47-4d8ff13950a7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The cifs_sb_tlink() function can return error pointers, but this code
dereferences it before checking for error pointers.  Re-order the code
to fix that.

Fixes: 0f9b6b045bb2 ("fs/smb/client: implement chmod() for SMB3 POSIX Extensions")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/smb/client/cifsacl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index c68ad526a4de..ba79aa2107cc 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1592,14 +1592,16 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	struct smb_ntsd *pntsd = NULL; /* acl obtained from server */
 	struct smb_ntsd *pnntsd = NULL; /* modified acl to be sent to server */
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
-	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
+	struct tcon_link *tlink;
 	struct smb_version_operations *ops;
 	bool mode_from_sid, id_from_sid;
-	bool posix = tlink_tcon(tlink)->posix_extensions;
 	const u32 info = 0;
+	bool posix;
 
+	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
+	posix = tlink_tcon(tlink)->posix_extensions;
 
 	ops = tlink_tcon(tlink)->ses->server->ops;
 
-- 
2.45.2


