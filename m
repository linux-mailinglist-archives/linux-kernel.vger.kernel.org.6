Return-Path: <linux-kernel+bounces-386734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61169B4784
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B79D2817C4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0190C20B1F1;
	Tue, 29 Oct 2024 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HxJKNN+8"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521B209F39
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198912; cv=none; b=AbhdSDevdIa6z4+WiAqRtqWK7M2PJfhwXh0jeL9FewhyGNeIMM9ZKgMuS9K7VmLPY5vZLE3vWFXKvv/gHGHSsq+ma3DduNtkX/7GP2NFiH0IaH9ysK7Nrwz0ZY296tkaNXbnZWbZMlyHFCokjlO57iDd1DsKGRwaphkGP5Xub18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198912; c=relaxed/simple;
	bh=aDlod1jXavu2K8KnusK1u2l7VsBsilN0fz8PvjNKPQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mNjG+EqTUSSuaGizfigLJg+nvTyx7Kb5Gnb7k6K26CpKJ8FcWqobCMIdIK3SJx085SvSG2af3oarJTg2Cs4oMdomy/hYXdutev2q7o3wxSJ30ARrQhk3NtG7vfck8px3kwMB5dByn7cdFfPRATilMriaHbUVYWDgCVAnBxRzzY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HxJKNN+8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43193678216so40130195e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730198907; x=1730803707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFaxyOK2oGzKEK+1blmMTfwvFfOfF/h23u+ELvVQAZo=;
        b=HxJKNN+8pBIxJ/sn/weVK+Xhu96/TtuiVqq1T2k7AeuFky9vcXisXR4dddVVzi+FT7
         QzyU10CA2F3NSG9juSfbPVRaPlO9krHiT6LxrRF7q3ReG6pkIMtGPe/RblYMYTIzBd0/
         MxAmxQuGRQYdUzBAHXdv07Ct2kSo+n15FCXzbx7miLyXR3iUKLqHjHPz7l9VIiNKjmKA
         qN3JQqjuhn3p8qpjPwJPRXinCzBdmASyPF+ih28OYuUNDaXgr5uS9D0pR/E189rbVduZ
         eukAtOWkqbuK10SQmhhl157w+2amK2sO0hrGLcwpZMfDiX7XQOcH3E2YPCN7TBssALqO
         Glng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730198907; x=1730803707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFaxyOK2oGzKEK+1blmMTfwvFfOfF/h23u+ELvVQAZo=;
        b=Ab47YMoPeY9veLuhAOWyCxKE/SFAdbGBoab1x0oqcS6xhS+M+TSmvzzrfmCO+nSGXU
         3H22btlhDVj2I9cCOO+2pLBGgM+1z/ei/2JCaPVsX5ohTESy32MpzRe5a6j4WsUwtASV
         dDYWzHm5YWKyDw+7hAm1JU1FfKFETL5OVcZigdKRVYLBnTZkyMi/Ggaeel8YRTgw+3Ay
         avZQZ6xk2BdXSw143mz03RgDpPXjoRl5anCIcBwtUEPB+KfOJDKomM8WdnjmVxW3RSY6
         kHB0wJiAvUQQ7zq8B2J05YQSr02s2nvpgPCQhz6vSMLOYoxOgf6nDrNRC60CRgK5vO++
         ulHw==
X-Forwarded-Encrypted: i=1; AJvYcCWUyMd8DXJ9CB5EheVG1XFY+8J6H/n7rwuuheGcqzNf9YReVZxTGik3XIi5O639W9LAKpzle9G2XhrXfaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAcrUGkNryeQMyVKa8LwgZ9vQGCMBLbXRvZ6HOrJcBuB+kojj1
	yKelxHktFqbWNc8G9gSjzilzGoeqdUCAasOH6KglO33YcurltqBy78ja5Xq9ZpE=
X-Google-Smtp-Source: AGHT+IE3Cs3vBrxGtoeuCXniQn083ShrCkp0qylEHXANn2FPwOBJ3G0Bm2RYydQ6YBTgBc+Plteodw==
X-Received: by 2002:a05:600c:350b:b0:42c:e0da:f15c with SMTP id 5b1f17b1804b1-4319acbb947mr80128605e9.20.1730198906640;
        Tue, 29 Oct 2024 03:48:26 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3dcf:a6cb:47af:d9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431934be328sm141124785e9.0.2024.10.29.03.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:48:26 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 29 Oct 2024 11:47:35 +0100
Subject: [PATCH net-next v11 22/23] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-b4-ovpn-v11-22-de4698c73a25@openvpn.net>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
In-Reply-To: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1706; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=aDlod1jXavu2K8KnusK1u2l7VsBsilN0fz8PvjNKPQ0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnIL1syQRgRfbgx6GAPPm89EXy7dStTiW8zRI21
 jZYFJ4pTS+JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZyC9bAAKCRALcOU6oDjV
 hxoPCACNXmQz3KZDlxcWeQ3dc77a/lv1ZFyB1x5uTaG7waD+X6JV9ssYgOZf/04d9pj89AKFN1i
 NmIsWbfdLdbz0VUrgslHFyWtBTDFIwe/TOQASzrl/awTRvLM0iOkZ1lqTWnGPbBOh3RC4q8RZFq
 NNo+GnNtdf3+13V/rT8W6b0rqnZAgNm3Yw8lwsekB7Gc4BnkSpVXs3Sv4PVpgH7JM/FlZ0s/3zi
 7vDYkmyJPhtmREKiw7ADP1r/UkpsOtIrNeMiixStHE9sX+9jLUmgE736HIvrSWpgTlT1uihgyhB
 Aq5sJTEfmQQWHSc1gOPBmsG8xqvCZoUOQFYMEeFinMAM952x
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Implement support for basic ethtool functionality.

Note that ovpn is a virtual device driver, therefore
various ethtool APIs are just not meaningful and thus
not implemented.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ovpn/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 1bd563e3f16f49dd01c897fbe79cbd90f4b8e9aa..9dcf51ae1497dda17d418b762011b04bfd0521df 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -96,6 +97,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
 }
 
+static void ovpn_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, OVPN_FAMILY_NAME, sizeof(info->driver));
+	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));
+}
+
+static const struct ethtool_ops ovpn_ethtool_ops = {
+	.get_drvinfo		= ovpn_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_ts_info		= ethtool_op_get_ts_info,
+};
+
 static void ovpn_setup(struct net_device *dev)
 {
 	/* compute the overhead considering AEAD encryption */
@@ -111,6 +125,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_struct_free;

-- 
2.45.2


