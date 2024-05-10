Return-Path: <linux-kernel+bounces-176012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A528C28B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B196E1C22041
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB89F17556F;
	Fri, 10 May 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="bT+yulIP"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1225A175558
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358374; cv=none; b=lvXLxn2fSX9GnWIbVJjf+7gJw39n47O6NSY3wtO45rc2I+rOB8yNhALzt1sAqLSJjHoMA1IYVT6vuPQmjm3ZGVDvdgGKfes2gm+NstTql8acPwkT9nYHhu5b76bhdV1azF2guDe4VCyzxcidhI1GNt0JySAh5MnfLem1CGFtLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358374; c=relaxed/simple;
	bh=bxaYAw3KFAukICHyA8ZADUCzO0ruG6dtxRHo2LheGEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E+HPGWzo7X/7iaB/uC9jFtzyah7KvL3lYcm5ONK6Opp5jPr+iqPThBAhnnxECz0S0pscMUE7rcX7k9sQOC/qtqDcia/nUedIM4Iz70/wwHcIVsWjUW88PZCLDk5W3dsZV38oC8n1EgxVoVSNTbJfPpBD0MFbuT7NAscYQokwmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=bT+yulIP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3504ad82a64so872842f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1715358368; x=1715963168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/c8R+r2wKwqushYa97j544g6TTlix/kEzEOUalKigY=;
        b=bT+yulIPfBuCmhrwbOs9fec9hlm51bL2/87avoYVDjJOFGhlruSrobDTYJ2IA0a9XZ
         NDANS6WRU/yKQgWscuS8XwvLoWO+FPJ/m9MBqwiftXU69J4myWYoQoxi5llxBMQDs4gT
         tT6SVkGVZhEkmZQ7RbxneYW4pVFeVU4FirAxWSjmqWdnBsmXR4tkUWBgXCJTRZuUHx5q
         xK3sEB7iKV93AAuJtbkNS6HnLmya24Bs3S7hPP0XGU5Ins+Ol7gvBbkY//sNih+kJUTL
         ytRjLAJKVXiDAibG3t4Z6rPLfWUN0igihHI/09iwt5QU6mNp0iBxeMuc0lovMIWIdXu1
         DWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715358368; x=1715963168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/c8R+r2wKwqushYa97j544g6TTlix/kEzEOUalKigY=;
        b=g43B5YJvt4+y6zKZoVjknHrObDD566vKOeP5aplQo/5aFKWC2qElp8+bHb4FLbys1E
         wWw+gvFwDZTUzumKVAwyw9WY6reSEhNFGMVTg2QsWuzC+n96EsrRfQWthr+WI+YVGwfK
         eaM1FipLCiMqwA2LdVxyFmBapaefMgPNTI391t9F7bRTRyyyoCNyuyd4n9Gc0n5iCUpG
         m/vcQzlfYQSqyqOfXq76N/y9K3IU85uAd65+n2CctaAj/wg9pKibJr8xIHcheiYi/O63
         mEjFIUVutdaSqaOT8epZpNC5G9gAG46xZ6xp/OEHb5yClqRAjTASMFAbMBeZJi50Ncca
         duRg==
X-Forwarded-Encrypted: i=1; AJvYcCWwoCTOlZx/t+4IdxLxIG/GadDVVHn0C+GR2O9y27qYzMiJa2N/vk0RX0kMfi7sN1GrTlYLVMTwzHZ06PM6jipFzwKpQC59Fr015qsd
X-Gm-Message-State: AOJu0YxpjwNv51eJzq6nfJnBLm1itkiVf+NKy4lIuPTDBqp5XagkmY5b
	j+b4ju0URHxgnKoI/aGXgQj9BnoJo/JDoHUmpgp4GrCkvPuBHwflAitcuIaJBKY=
X-Google-Smtp-Source: AGHT+IFqMc0sFti2/1u4QVjRR44zxDuQymS4K5HaIca7tQzr22CmfzsY/kBGySUABOBPgaGAYLB/TQ==
X-Received: by 2002:a5d:4483:0:b0:34d:7d03:45fe with SMTP id ffacd0b85a97d-3504a632fd3mr2132265f8f.23.1715358368252;
        Fri, 10 May 2024 09:26:08 -0700 (PDT)
Received: from fbxleo.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896aa5sm4952206f8f.34.2024.05.10.09.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 09:26:08 -0700 (PDT)
From: =?UTF-8?q?L=C3=A9o=20DUBOIN?= <lduboin@freebox.fr>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?L=C3=A9o=20DUBOIN?= <lduboin@freebox.fr>
Subject: [PATCH RESEND 0/2] pinctrl: core: fix untreated named gpio ranges in pinctrl_pins_show()
Date: Fri, 10 May 2024 18:25:37 +0200
Message-ID: <cover.1714049455.git.lduboin@freebox.fr>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series covers errors I encountered with the pinctrl_pins_show()
function when dealing with named gpio ranges generated through the
device tree using 'gpio-ranges-group-names'.

These errors were introduced with the original implementation in 
f1b206cf7c57561ea156798f323b0541a783bd2f.

Léo DUBOIN (2):
  pinctrl: core: take into account the pins array in pinctrl_pins_show()
  pinctrl: core: reset gpio_device in loop in pinctrl_pins_show()

 drivers/pinctrl/core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.42.0


