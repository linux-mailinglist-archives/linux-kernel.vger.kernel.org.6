Return-Path: <linux-kernel+bounces-335775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DA297EA7A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A442820B5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6037A198822;
	Mon, 23 Sep 2024 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiE6Iz7o"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599737DA95
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089757; cv=none; b=NXCF03waSRlUkKNRBNkPwJOoDzZPNE1dnBHUvtdWz8qDRHoMqydA3HIv1nLQdHK6g711r9eCIIMXh/hRZ2heWP75QYZsaGFISknKj6bW5P8dDn086HJnVpg0+cHQ2j501mo9bXxep6Hw0CYtOQpdBH++UDl/se00H9pUi4V/+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089757; c=relaxed/simple;
	bh=sxnysFuVqBTITzLmEYuw7VJ84zfsd1/erwPmmtuD5cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Tqvuw5GWzYC9tBEyd1sM/LeYcnJDyD+R9huBZZ9tzYvmTD3dKzCcgPYO4nHRSZFwKfETxfSWy4Zy5grAXIziSpnk00ESNxb1otS3yiTiMGjr+tQVyJlNlHke2mFvMyAWJK8x05haoxTrzXvONhylsfOFwuaKK+AQwmSKjea+qqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiE6Iz7o; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-846c0a741cbso959154241.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 04:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727089755; x=1727694555; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDpgRW4r3oPVYUmU3Ej3l5OTRdoiDgl5JRjG4zr2K3c=;
        b=LiE6Iz7oxjr0wT73G5408ZgTtLm5Thg2+Uc/+SakTel+qDaFdahSH767OY3UNCHQh8
         68DhewBm1nCtoznI3UikYAsCpnMVAXWCValFu9T9G8qo5zwwArj7PsFA7e+iDf/7UKwX
         /mB88mkzexfIbU+etVHXIfIFmmh4yOGDtAWHEjUbgrOpLc/nuzd2p9G/QWwDPVIU1qhr
         t7B99vJbFT7Mh3N5lklAu5fC9VjeIw0oLXfeuN6aiJ2CJ0jQZfScfY/XnWk5iLDG67nW
         FjRP6MPIemHmtc4QiC0HMQb05vmVqk/T1dV0U9LWbuD/xiDAyXFu1a6yYcI9f5iZjwj7
         fYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727089755; x=1727694555;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDpgRW4r3oPVYUmU3Ej3l5OTRdoiDgl5JRjG4zr2K3c=;
        b=U/FUwoywECv3NZVHAjDz2AH1thVwq5B2hiNWlku7YpSLGXFIL+RcoyCR83F6U+ZgHa
         jCe20XBt6t0o84o6vC84pQutuCnpu7EOX98MGTLiX1U1z6vkdKhgZxozHVGulDWo05zu
         /VJgk6wLG+ca74oTOypZ2UZap2fCTJkPJ8/68qZYS8uYsPYnwyliSZ0v6ofEB3Fc+l/n
         yf5xF48swOyHNRddCeDew6dCwYia4iMxElXYr0oLcV91d7bzNR7o2urcti4vnc76eeQA
         0u1ZDFe9xXMURkTUGtsDOuO1uTGW6y4rphft3zeUi+K4VqazYSZWnIGyaunnBTkRLqih
         JpTg==
X-Gm-Message-State: AOJu0Yw/Qn5Vjc0VlLmNz1N8/rpkjXs3JicYplKzbOBr1lPrebxHeVPV
	jH4WzvNOyF2DWo6Lh17cIgVHy4cdkJMf6FxVyrDCP+7hq40BMXJjRVzkAlrleS8dVu7Rgx238RI
	3PV6l6acS4FpfsFLOmQB7ap5NLaXn8vsy
X-Google-Smtp-Source: AGHT+IHlVdsS5zGkjR4wrxpC1b7Ny9k3zPAoVhQ56XB3Dc+2buYhcEOF/5IC6Bu+Wml/CsFFucAKdOSC5jB2s618SrA=
X-Received: by 2002:a05:6122:1d03:b0:4ef:6870:ff5 with SMTP id
 71dfb90a1353d-503e045e1a4mr5950807e0c.5.1727089754880; Mon, 23 Sep 2024
 04:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923110633.3782-1-kdipendra88@gmail.com>
In-Reply-To: <20240923110633.3782-1-kdipendra88@gmail.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Mon, 23 Sep 2024 16:54:03 +0545
Message-ID: <CAEKBCKONZ5z80P72yPpFnO1s3i_U_OW3Xd=HFOkB647dOk0JoA@mail.gmail.com>
Subject: Fwd: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error
 pointer check in otx2_common.c
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

---------- Forwarded message ---------
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Mon, 23 Sept 2024 at 16:51
Subject: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error
pointer check in otx2_common.c
To: <sgoutham@marvell.com>, <gakula@marvell.com>,
<sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
Cc: Dipendra Khadka <kdipendra88@gmail.com>, <netdev@vger.kernel.org>,
<cc=linux-kernel@vger.kernel.org>


Add error pointer check after calling otx2_mbox_get_rsp().

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 87d5776e3b88..6e5f1b2e8c52 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1838,6 +1838,11 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
                rsp = (struct nix_hw_info *)
                       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);

+               if (IS_ERR(rsp)) {
+                       mutex_unlock(&pfvf->mbox.lock);
+                       return PTR_ERR(rsp);
+               }
+
                /* HW counts VLAN insertion bytes (8 for double tag)
                 * irrespective of whether SQE is requesting to insert VLAN
                 * in the packet or not. Hence these 8 bytes have to be
--
2.43.0

