Return-Path: <linux-kernel+bounces-226375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F171913D82
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD2B1F21307
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 18:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D71849C7;
	Sun, 23 Jun 2024 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL6OermB"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69950184139
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165508; cv=none; b=OU2t5B/RDVd8fgHXoH8WwWrpVnshV3Gk82LaWzSppYXOn3YJCQDJn/IdRYYwfXmyERmi2741SzEh6BTCs3Sg/3YmWk6w8kJglK54SaYfMDphpjygcrBGCaooCb25rrmB9I4oFgmkPue52IhOR71E6CMVZWzCQKzYvzQ4NCoK084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165508; c=relaxed/simple;
	bh=c0a3Pr0ZOQG6hRnnht8gNUqkLt66dO4HBllllz7OIIU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLbRgDzWjPipXyyIUmKo71N3OeWqhHZvPG1RvLF7J9H563ydYfbxVXAdRjtJTGrlq0nlOt5xMGtnM1J5+kKgqMks55GLRIXuAoc1F/NupZEpw5T7tK9V8krQk1Z4RYZKaDE2DTBxh8YbtNuZlS4oGwFI5DW8KwUT6RUNJkjK3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dL6OermB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7250bad44dso819766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165505; x=1719770305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=axOwCCFkiHXRQoWrBYOvBy8/Yk0F9t8t/fQByhrED9E=;
        b=dL6OermBy4PefneQ/L9T1NzsFZEKayldLyimgNhCcJuveEhjYYv6CtGthjmtU85W73
         YZ8zhQ7ymUsk7/N0TLXaiXbwawfhuiQG7ITzrAFX50zJ3fV8tQcNRDkMUOcd3t0Vj7D2
         f8T9YACzvPJuXuVOiZWtUOVBsr2ZyvUAvfRiUa8bmogNMlRrIZBGqAYVhry1DQj5hpRM
         zmLXq3030kZi489dTSxP8Ykjev6w+R0SFVgJpk2vZzsn4mgR/Y4r45KpbBWeyVPI0bNp
         tqoN7Vl5X090b8dM4nOJGPsSwn4y116a/pz/AYJKgiCL487HWUaWspf9cSHDijqKUFA1
         7Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165505; x=1719770305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axOwCCFkiHXRQoWrBYOvBy8/Yk0F9t8t/fQByhrED9E=;
        b=gaxvxXOISP5wCmR/a+DBcRKgaz1CbywOTbO9bNkB/chA7IlijVnzQP1MnRQTmEeFjw
         bUuqeaI8o6bHCXbrkNmNQNZjnZMvLmdKaqy5j+L33eRvnvKUFNuauMsx/sctamCns5Tc
         cEsyWJPu7wXm9CVv81zmFRSzEl+PSTkJKEjr6nNJGkQzBqmdv9Tbz5LjVTEESINNtRjb
         XKEkzYNWYruxmmZ9Q1LMSqhFx+lsZoCotuQvMLSnxwVA8iwO/ioofV3fvv+vLUpJ/ji9
         +ad6zDtqajNse6SA+xrpc+sR+AqWwy09IslC7H4IkSPkjNC03S4vEqfNM5qJIopl4uV/
         hgag==
X-Forwarded-Encrypted: i=1; AJvYcCW9reGkVenbn8xCcnR1Yzb1Mg0Gn458mIG9FSbHAdcmV1/xQQYsfq/xiPiilE1e/dVJqhqV+d89+mWvApRyMPA7XQeuxCq4O01HkekP
X-Gm-Message-State: AOJu0Yxj3O9koSbSYPyksOXWT7FMSHZbTaI6mXzz9Le5vCbdqdxLb/h4
	21EAZKF7RvkmyJkDd3rRGwKQzju/IlFI63sc5eRsQfKRX5k+S5bh
X-Google-Smtp-Source: AGHT+IENE7Gapd83HNRZmNE/54dQQ4aIVciES6cnxcJVr6P3l8hZt++p9nvFw+N6HFqqAxkG9r34Qg==
X-Received: by 2002:a17:906:258a:b0:a72:51d8:bf30 with SMTP id a640c23a62f3a-a7251d8c3d0mr59225166b.0.1719165505554;
        Sun, 23 Jun 2024 10:58:25 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf549385sm325730566b.105.2024.06.23.10.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:58:25 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:58:23 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] staging: rtl8723bs: Remove unused macro in
 ioctl_cfg80211.c
Message-ID: <0a33ebb3e11558f41dc847dcaa9733bfe1cf4ba6.1719155208.git.philipp.g.hortmann@gmail.com>
References: <cover.1719155208.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719155208.git.philipp.g.hortmann@gmail.com>

Remove unused macro.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 82722897d6cc..2bd8b1447698 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2588,7 +2588,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum nl80211_band band)
 {
-#define MAX_BIT_RATE_40MHZ_MCS15	300	/* Mbps */
 #define MAX_BIT_RATE_40MHZ_MCS7		150	/* Mbps */
 
 	ht_cap->ht_supported = true;
-- 
2.45.2


