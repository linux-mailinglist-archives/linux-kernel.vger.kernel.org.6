Return-Path: <linux-kernel+bounces-433046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A25D9E5359
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238E818823C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7C51DDA36;
	Thu,  5 Dec 2024 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWVRBTXM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F48A1DC182
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396837; cv=none; b=U5sFg3p+KjhOIyyPyJUnLbUsTKaQ9VRatPTyQTA5CXHwDr/pz0qgrRFTX0X6HKyAE/KrMNcmM5m23JOEq16fwrJd19n1WJxI++/+fQpDytznzpEImDDGkAhdy/1ipXnU8sCrktQByOsC6gUVxwPHsvAcdtA1P9s/rfhZGLtZ8nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396837; c=relaxed/simple;
	bh=N8V5pPraudmb9UYYMzMET/ZOntl/aHfXk5dIlWeZm3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPgnjIvT5YErUDbTIUfIr5hrZ+x2NUibRSPsVhFNL8q6Sl3DWDnq9o8+uQ/HoUp+6X3QvF9RV+kroL4SkDl8rHTomyEfWIAjqkgLZff+G3szc6Zamfo/DgrXkBhLH5vEhnaXPD8cu44Of7RtnZ0h0RFlWkF+WQIsuLfA1OC1rro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWVRBTXM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733396834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCjNRJrSktMlDO/Ks0uxEWXTnrnlOc73abdK3jrL0nE=;
	b=XWVRBTXMQraEL/rTC+yniLdFOzFUrb183yEV7WKvwJkZtddVzmBXBlc/xl/t2Bbz1Mxqph
	lu/lfx1d0IMoSzpCb2ffkx0UkAoCWyiyK4svJCVt4fvAyh+hwXbndcbczZzCPeKh9KxYTM
	XuMvuSHrZBJutWAFhRsfJZrOLrbsaJ8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-5YFsSwcCNGO14L4FqOgbuQ-1; Thu,
 05 Dec 2024 06:07:11 -0500
X-MC-Unique: 5YFsSwcCNGO14L4FqOgbuQ-1
X-Mimecast-MFC-AGG-ID: 5YFsSwcCNGO14L4FqOgbuQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ADB31956087;
	Thu,  5 Dec 2024 11:07:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3D6E3000197;
	Thu,  5 Dec 2024 11:07:05 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_yuzha@quicinc.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	quic_cjhuang@quicinc.com,
	vbenes@redhat.com
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations are supported
Date: Thu,  5 Dec 2024 12:07:02 +0100
Message-ID: <20241205110704.232725-1-jtornosm@redhat.com>
In-Reply-To: <f75a1655-fa5d-4675-85d0-b9b97dceba6f@quicinc.com>
References: <f75a1655-fa5d-4675-85d0-b9b97dceba6f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

> But I see your interfaces all be added with managed， right?
Yes

> Test steps:
> ...
Ok, I am using a bridge with the AP interfaces in addition but it is
the same.
Indeed I have tested in the same way as you too (even using your
hostapd.conf with the suitable name for the interfaces).
So I have started to debug (current upstream linux +
https://lore.kernel.org/all/20241127022742.4016870-1-quic_yuzha@quicinc.com/ +
dump_stack() in ath11k_mac_op_add_interface, enabling ath11k_dbg),
let me show you this:
[    5.703295] ath11k_pci 0000:01:00.0: vdev a2:d8:da:c5:7b:79 created, vdev_id 0
[    5.703304] CPU: 4 UID: 0 PID: 945 Comm: NetworkManager Tainted: G        W          6.12.0+ #104
[    5.703315] Tainted: [W]=WARN
[    5.703317] Hardware name: ASUS System Product Name/PRIME B660-PLUS D4, BIOS 1620 08/12/2022
[    5.703320] Call Trace:
[    5.703325]  <TASK>
[    5.703330]  dump_stack_lvl+0x5d/0x80
[    5.703344]  ath11k_mac_op_add_interface.cold+0x4ed/0xa92 [ath11k]
[    5.703399]  drv_add_interface+0x4f/0x230 [mac80211]
[    5.703512]  ieee80211_do_open+0x4b3/0x770 [mac80211]
[    5.703669]  ieee80211_open+0x8a/0x90 [mac80211]
...
[    5.804755] ath11k_pci 0000:01:00.0: vdev c8:94:02:b5:fe:fb created, vdev_id 1
[    5.804759] CPU: 1 UID: 0 PID: 1011 Comm: wpa_supplicant Tainted: G        W          6.12.0+ #104
[    5.804763] Tainted: [W]=WARN
[    5.804765] Hardware name: ASUS System Product Name/PRIME B660-PLUS D4, BIOS 1620 08/12/2022
[    5.804766] Call Trace:
[    5.804770]  <TASK>
[    5.804773]  dump_stack_lvl+0x5d/0x80
[    5.804783]  ath11k_mac_op_add_interface.cold+0x4ed/0xa92 [ath11k]
[    5.804809]  drv_add_interface+0x4f/0x230 [mac80211]
[    5.804868]  ieee80211_do_open+0x4b3/0x770 [mac80211]
[    5.804934]  nl80211_start_p2p_device+0x8b/0x160 [cfg80211]
...
So, since the normal sta interface and p2p interface are initialized,
with your proposed interface combination, only one AP interface can be
added for me (vdev limit is 3).
I like your idea to have a common interface combination set for everything,
but I think it is not possible here.
My patch with the new parameter at least allow to select what to do, dual
stations support or APs support for all the cases.

Thanks

Best regards
Jose Ignacio


