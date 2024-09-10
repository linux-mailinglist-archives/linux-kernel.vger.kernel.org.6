Return-Path: <linux-kernel+bounces-322443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5FB972910
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC12B23E78
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFA2170A01;
	Tue, 10 Sep 2024 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH0UHGeh"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B3213E02C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947781; cv=none; b=DSI9gw7WFHvt9GAYjXzBaPgk1GQ4wfGu5QTpz4VEXjcy0uuOGfk8H0TAZh0ZY1p7a/B8rIsRyjKUlTDOa/fHiL94Y+p8oanNNzx+j4TlGqMzykoAQ114ev06+DO7zXczWqJzm+7+GIHjlgomwYh1D1bYNYJxGG8g0OhE3N23ZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947781; c=relaxed/simple;
	bh=UiEfix7QB4glLlvDKOR5CGUKiUCSA474Yl0Jn5b76Ns=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UUWDJlN4Y37iYbDDgZwQKJf8yJ26MwBAKl1X/GExPxzavqAtcedoXCaaqgLaxrLQ6FuiEcfU5FCzvdfyMttjjmU12Ulq0P3tLn41LuyfeerE3aOEHwYcLHPkOU8SaYY/ac4wCIqgxYdlqxfcTQwrR71Y1l8BH9t12yM+7OMSixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JH0UHGeh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d56155f51so33821366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725947778; x=1726552578; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5BO52+KJ68/Ix4XqJ5qAm5TxRd6ZPYkPcL1mWHiM8g=;
        b=JH0UHGehNhBOAdvCbBk3YQw5YiUJc/OfzOu4i3wZsuRi3S1tIDXC0z4rbKaVg8kHNm
         rmXEqCT6FeV6mgRjj8GTNGx8x3x3g6xLbZYYqWvMGZVHPjIGw5uWVf84tNklSxwdEJj0
         XkZ+57r9JglHAqrhjn3FESoevpjyL+ZDE9ID1z0s9YFMTGGe69OtzRx77u3ALoMsZWxi
         hJkv7Ngh3ie7SH3QF003MwknvUf4OvGM51X3+ogUQOFv5TfMfMAJyHck2+AjbkYoRJey
         7XP6pclmlqalg83b0g/IABT9Dx5lkBpYLT6TwPregIMfUxaVOGur4YzXB2dJqsQhOwZX
         qkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725947778; x=1726552578;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5BO52+KJ68/Ix4XqJ5qAm5TxRd6ZPYkPcL1mWHiM8g=;
        b=fdq2lsQw3dqqEPz1Y8j2+p3F8lQ5KGgmthvm2XjiXN0MlmxGIyvc/ePFW2/UXPthgw
         dMqaz/5JHLo/a2ijZWO9nZsCWCu+cBrTDfkcYBA8X4eZZuby6ppDrD3oCJy7kdrhIbxa
         9vbROhXrSxBs1yx8N/QBZv2I9npAbVUDfvKhdebmLkPJ4sJ3y511w08AXlSu8oUHQrE6
         2E2lgdj2KlfGgtFswySMvhk6mK5ZzLaWjixmCRtS0xSI9fn8yH1Z08sy69IySYg/8ZsI
         FkY+VgeYkALPB1lOxLhSrhuXmayoKTfylJ4/jZp4/rATNmv6YJEBK34I+vI7XnsB+juw
         ecrA==
X-Forwarded-Encrypted: i=1; AJvYcCVgOBn8UV0Aggh8VsoCjfm2wyj7pEppGUk3OYRZY/n0eqQL5vD24U5i7AP1C+aHyTGoray6TjmQJrs2YjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2GXcV9K38uFircrfxCKLmHfvAo1SGqzv7mleDs6/b8e/EpMAv
	YPHelCHXFBs9AZT9KD/mOzPKBRSl9isoraO9xM3WVob9YaEEZ5WHvkFeDHLf
X-Google-Smtp-Source: AGHT+IGPcg4NsRThfAQEC9mdQMOjTLlR5bm9MR3qaVW22hNI37G+Pd2WccWByjAiQ86qYvfy4QjTHg==
X-Received: by 2002:a17:907:d08:b0:a8a:794b:9888 with SMTP id a640c23a62f3a-a8a88668371mr1043210466b.36.1725947778177;
        Mon, 09 Sep 2024 22:56:18 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f2a8598b80c2d4e9a813f29.dip0.t-ipconnect.de. [2003:c7:8f2a:8598:b80c:2d4e:9a81:3f29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72e71sm428893566b.139.2024.09.09.22.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:56:17 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:56:16 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] staging: rtl8723bs: Remove unused functions starting
 with RTW_DISABLE_FUNC
Message-ID: <cover.1725826273.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove unused functions.

There are some debug functions in between. I assume that those can be
removed as well as due to missing information how to use them and
what the output is those are not useable for developers without
further documentation.

Tested with rtl8723bs in ODYS Trendbook Next 14

MAINTAINERS File does not need to be updated.

Philipp Hortmann (11):
  staging: rtl8723bs: Remove unused function RTW_DISABLE_FUNC
  staging: rtl8723bs: Remove unused function rxmem_to_recvframe
  staging: rtl8723bs: Remove unused function rtw_hal_get_odm_var
  staging: rtl8723bs: Remove unused function rf_reg_dump
  staging: rtl8723bs: Remove unused function dump_4_rf_regs
  staging: rtl8723bs: Remove unused function bb_reg_dump
  staging: rtl8723bs: Remove unused function mac_reg_dump
  staging: rtl8723bs: Remove unused function dump_4_regs
  staging: rtl8723bs: Remove unused files rtw_debug.c and rtw_debug.h
  staging: rtl8723bs: Remove unused function rtw_ch2freq
  staging: rtl8723bs: Remove unused file rtw_rf.c

 drivers/staging/rtl8723bs/Makefile            |  2 -
 drivers/staging/rtl8723bs/core/rtw_ap.c       |  1 -
 drivers/staging/rtl8723bs/core/rtw_btcoex.c   |  1 -
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  4 --
 drivers/staging/rtl8723bs/core/rtw_debug.c    | 68 -------------------
 drivers/staging/rtl8723bs/core/rtw_efuse.c    |  1 -
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  1 -
 drivers/staging/rtl8723bs/core/rtw_io.c       |  1 -
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  1 -
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  1 -
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  1 -
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  1 -
 drivers/staging/rtl8723bs/core/rtw_recv.c     |  1 -
 drivers/staging/rtl8723bs/core/rtw_rf.c       | 34 ----------
 drivers/staging/rtl8723bs/core/rtw_security.c |  1 -
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |  1 -
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  1 -
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |  1 -
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    |  1 -
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c  |  1 -
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    |  1 -
 drivers/staging/rtl8723bs/hal/hal_com.c       |  1 -
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    |  1 -
 drivers/staging/rtl8723bs/hal/hal_intf.c      |  7 --
 drivers/staging/rtl8723bs/hal/hal_sdio.c      |  1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  |  1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |  1 -
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  1 -
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |  1 -
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |  1 -
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  1 -
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  1 -
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  1 -
 drivers/staging/rtl8723bs/include/drv_types.h |  7 --
 drivers/staging/rtl8723bs/include/hal_intf.h  |  1 -
 drivers/staging/rtl8723bs/include/rtw_debug.h | 14 ----
 drivers/staging/rtl8723bs/include/rtw_recv.h  | 10 ---
 drivers/staging/rtl8723bs/include/rtw_rf.h    |  2 -
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  1 -
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |  1 -
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c |  1 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  1 -
 .../staging/rtl8723bs/os_dep/osdep_service.c  |  1 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c |  1 -
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |  1 -
 .../staging/rtl8723bs/os_dep/sdio_ops_linux.c |  1 -
 drivers/staging/rtl8723bs/os_dep/wifi_regd.c  |  1 -
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c |  1 -
 48 files changed, 187 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_debug.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_rf.c
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_debug.h

-- 
2.46.0


