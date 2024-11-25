Return-Path: <linux-kernel+bounces-421244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C20E9D889C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F0FB438BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB651B2194;
	Mon, 25 Nov 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="q4ssgh6G"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6901B0F30
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546555; cv=none; b=AZtXQI8DomoMz0sDglOfWv5eqd6nJ/9eqF7YRokylJydcKzLhOVi7F1k+R8oFQBdYyDT+zIwBIpBPHUfuz8a1y9klZYTZdkaNei7nzuXK+G+wvkgIbWy03MbhoPGf3aiHKAOiBQuI0v1Qf1Zc3fgtf8cPl5uURGGIUzCAS28WWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546555; c=relaxed/simple;
	bh=GunFkVqsk6AZag4xW54NaCZhfXdukTjYnDQLy6bi5aQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=H/dmBu3ZnpZ9H4DkRG0ES1KYV6i3vSs55tR/H3OObqCgeXBr+Jkpy6pf4WkhVxgtpVBXnHijKf4BBIUkLHX8LyQ0sbUMKjUJr/Ler6mvASomWV9GnRoVyb1o9wuToP3Yde3ViqUrQ5V9dFAHeF7i8qjHZ5ttsNo8DwxaXsFkgh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=q4ssgh6G; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732546237; bh=HQuH7MrwMz12ht/cdRhFwy3ucGjGwmSPvp8fxHTW85s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q4ssgh6GflwxeBIcpb3JoHMHH5xliq7dMeyul5kPSqZiN75yiw5xKCBIyosAKOgIW
	 587JdvLT8Yi+aceSqkH3RfeSHF8yy8ps8ODk42/OcIC6ntO82fT4FeSgYEAYLy1DBL
	 c74YPvgVTzzk3W9qT72UYeUJ7XclzQ60k5LsgvBg=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id CA4240EC; Mon, 25 Nov 2024 22:50:36 +0800
X-QQ-mid: xmsmtpt1732546236tlrap8c46
Message-ID: <tencent_C397C636464B74750D76ED66983D37374209@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBn0GwVGm3wq+7FJdu8TYpX7FWjJIwal5Zn0tGg0t3XF2y+nZ9AOB
	 3WwJN6PNLELP1oa1r3nuu8AXYytHicAdCGcUrXqrgypP1YVr+cDh4dHXvb1t4lpe+8AqXHbp3qSZ
	 6ggVbDvLwNirq/N2SQmNI3WMByVPT8v37v3A5HfsyjtTg8S0AF6NSFhlyV2dlTZEQxLLKKNcwJjo
	 ewLKPCIQ6Vuj4rQ73FkipY4V+Se3PI5q4JY4PHNXorJrOpk/oIfIvm8nOMEqQVK4XtNCiDUoWj8N
	 hDwFnd3my6/8afNhdoV/MOjlSQ5f7Fqtpt2c+LTGmBuFxgSWo5GxXzFOmX9P+WHgavxP61aPf6Rg
	 fQhH1JbG5H+zHgzEm1Qs+6hWx02iI3HvdbrUMv9DMHSfpyE4k0Elrgma9+OIpEfhO4dOVcCX7+kG
	 o8lncr+zx7QT21k4xwr56xh9Whv3r2qlbOHCVbVUrcZEVAVaqCRsUSlBVHJINPg35pBc2eYOCp1T
	 hy0VtRbUzL3+RzbjGIckHbGT+3r2Yq6jtp4evnnRDrFGYmOzSeFW7u7TAJT3Y4Sv23xbVg9LI43P
	 Wy6XP3AFpt2MgD7i82unzNoJB/FNOmscVVFVK++Ih/NZuYNokgXMe/xDDvOqOuDVtzlU0t4oUZTS
	 +TK7eue63e4adNl9/UCVXZlvs+kohjMHwY/gPr4lknhsbcta28lWW1F/QcjmaWQ83PJM0C3BaazN
	 hijX0sUdtqGRD7vJOIInkfkSP0lBoUXeOSTlKwM0eH5Qu2iSzTzpQC7IG9HMuaWE8M/30Oa+ZrSD
	 WgDliCRR50rHej8ylcmZO5EdUVYHlUm2hpbl9qooo0q4R+HgSFVjWvGmnTGjTQoO5XuTKGaiLpsK
	 +hxRtXphgPCb0lDbxs6tu5TMLF0MfMWQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+489f78df4709ac2bfdd3@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in sco_sock_connect
Date: Mon, 25 Nov 2024 22:50:36 +0800
X-OQ-MSGID: <20241125145035.3872817-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <674478a5.050a0220.1cc393.0080.GAE@google.com>
References: <674478a5.050a0220.1cc393.0080.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add conn should not put. timeout handler miss a put when !hcon.

#syz test

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 1b8e468d24cf..78f7bca24487 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -143,6 +143,7 @@ static void sco_sock_timeout(struct work_struct *work)
 	sco_conn_lock(conn);
 	if (!conn->hcon) {
 		sco_conn_unlock(conn);
+		sco_conn_put(conn);
 		return;
 	}
 	sk = sco_sock_hold(conn);
@@ -192,7 +193,6 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 			conn->hcon = hcon;
 			sco_conn_unlock(conn);
 		}
-		sco_conn_put(conn);
 		return conn;
 	}
 


