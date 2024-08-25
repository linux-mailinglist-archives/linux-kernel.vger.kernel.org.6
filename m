Return-Path: <linux-kernel+bounces-300268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F1495E1B6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 06:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9EC81F21D60
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 04:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23D021373;
	Sun, 25 Aug 2024 04:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CK+dlzKo"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EBEBE6F
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724560514; cv=none; b=Siz2gkx+O8sm0ydcuw0swwCxnCqwg1QwCuKQyZ3LekQtwEInAj9F/DaKdA6cB6jBdi+TCtbLvtAKlf5zju+VQMw7HWmXM+a5wFI4ixVBCDWo6k/rG0SaOueTYK2T+0aywvFsBOh/ESM9RfNrNLd4raF7GsJ7Y9wbCDPcV/yrmu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724560514; c=relaxed/simple;
	bh=YqfiVkgCXAF4vDpaemgH1noE7UX36kshipNPJKc8vUU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LphKArMWaK8vWU6pgWztM85GBruTio7vC09TjcJYV9OCm3qBiuYMuEiEg/hRRuVHz9N1yhvrMmzpZ4pDYN97NNy9/b1ygD/dEF14GKuF1jefJqzfWNMi/Aach1D0Y34y9Mf0E1KlUDeHucYvSNL5TH7spHTWM4jzyNP252VxQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CK+dlzKo; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724560506; bh=DKef8wlxJI/dydtA5flD0kPv0oVLFGif+xu0cfjX7/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CK+dlzKoKBV+us5TaxXF94HAQoLMxTiudH6f3/jRq1Fb9kswj85gQY0E5iD8y8cg3
	 CTm/p5Pp027GNgUg776B8nrtDO1IScAWNMsZW/pn3lgzB7DLlCBtp7ekTgG+yyJzSO
	 1Tyzvpg+jVg5z3GFtnLT0uHxHMKs1uUQaY9f5RB8=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 74301EF0; Sun, 25 Aug 2024 12:29:03 +0800
X-QQ-mid: xmsmtpt1724560143tov2dfmqd
Message-ID: <tencent_64FB06448999AEE1EEE50C9927E9C6D15206@qq.com>
X-QQ-XMAILINFO: OdIVOfqOaVcrVz7lZ/6IcCuvW2qOYK4mjAWe1478e0nNy0+APel4rFrezZgPyU
	 wtqK1rNx5QfSMVnxeIC2YsnhvU4LyumcpjIfDHHSYJsLfkSD4Rz0RE9FUUf/n6lG6saodfcNUXF8
	 WGvxBPIp1gMGA2mQyfka0NnvGAfFcbyI2l+vfftJIYZYrfg97KhPZl/FjtA5xiV59ORYawS+lXQ2
	 ZfFo8PDZQ75l/uU/5SZj1JIv+IXtS9aOMIJsweSBv3W7KL93Q96JDbdBJ8BeUyMoT5yOQcgFxAfx
	 Ndu/y/WNnkDJ4qKiPKeyc8p7qIHiy/5uwHoHfF9uSA7YAnnc6qIsiHQiYlkncy5meB0J6+V78k9C
	 fs0wF6WyHwmg3SkUn66F3h9Njb3Puo1E8jhuO+5OB2CO1TN6NUoLatuLo5weVnYwX7kR1rm1cS7U
	 TpXA1W8YYMNfKKcFqRES2pw+oBYMNSjOhYuvt8cHoANf/wjXXXb8w8bf+Kbgdn0yeazPHP+O8m7J
	 cGo6U6xfdLQJaIBFfjqySq0a+l6f4Vxh2lMxKA0Gv0O+//AM2qG4YTSMhPqdepulGMiL3KHTNWrt
	 s5pwckQDUyWJjRPWu48aoFa18vcbn3NxyRFjHRqLEVavRg/+m5/Vpf1HO2BqWxyw7NOW8TOasMse
	 0UOcV3lxZms3pdlwi0ZzFNMfrT53nwBQtePstqYqXykpr5G0ibeCS5dWX4WZ6Zalo2X+xlONHLNl
	 MZRwo6KXRVXJ6Oo5+2tS0Qm7jPcbQQmhKxIHBdm5XsI0Y3ULhg/I1nP5oKHlYKlE2LH14eIYt3Qz
	 hitoaofaHU8wDD8NtYl5L151bSNPX5eQ3wVpgrp+U2QY4ytsezW9TbOXrdalcUe7Zqy0hKdJLIEO
	 OOH8UjrB2YTIHTWui5RE8bX7CUD+gVTD7L/HkTgQWlNix1mSWhvug=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] [usb?] WARNING in ath6kl_bmi_get_target_info (2)
Date: Sun, 25 Aug 2024 12:29:03 +0800
X-OQ-MSGID: <20240825042902.2046699-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <00000000000096ee8f061e991433@google.com>
References: <00000000000096ee8f061e991433@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Actual read the bmi data length is 0 from the device

#syz test: upstream master

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 5220809841a6..2a89bab81b24 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -1034,6 +1034,9 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
 		ath6kl_err("Unable to read the bmi data from the device: %d\n",
 			   ret);
 		return ret;
+	} else {
+		ath6kl_err("Actual read the bmi data length is 0 from the device\n");
+		return -EIO;
 	}
 
 	return 0;


