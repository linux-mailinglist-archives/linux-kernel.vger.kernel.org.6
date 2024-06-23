Return-Path: <linux-kernel+bounces-226369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50568913D7B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6781C2119C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5221849F5;
	Sun, 23 Jun 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyP+wQD5"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EFC1849C0
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165469; cv=none; b=ZGbe2KeWgjd2H4+ZrZGsLCtklEIvQOsS4mhrRzgOx9Wm01RMRxYAvTOM5iKuEaV2INvuiIrfaCA1TAVASDsgYlhJmOkxdfKszjzykt9wfRdMyir8PaOZZ6szQ01RpiE3pFmvmYSHnsclBthwHvpBht/5nxRNPXRt8Nyf+bso/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165469; c=relaxed/simple;
	bh=NTLc4h+KThzf9mFv6Fg5yEB7AruJUtNcLCpsMeAq2oA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTPqKIftYb098HL0Yqbu4MvzIykfjysutXgX9geiQwwCBomXsYb69nOr8AiPwOGqDSNSOhh4PWjODa3cHZRG43OxkVm2UhGlFqFalhnQmVNFmV1E76tfdZOMOw9IvMoi3isExt/n4Y4mNmLOzjmWrqmoXIINQJzZhuTU0+Ff3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyP+wQD5; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57cc310bca3so493252a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165466; x=1719770266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb4kTu6hNN/Hzk3FHpOo3xTLDzrXJVku+1K6/EnMaMo=;
        b=FyP+wQD5MpFWy7wkOk6LxKw183pRZXIZ93/c9Yj3k0t9//+lCh5guL+qX4PtEv6tMz
         CAVPJWJOAUD9Gtd+bOx8h8PTABJo9O8ebNtKkeDAvEbQU1RHXePOSBoD745iD1oKlsZy
         Nf3EnnwaXGDnaDPUPlGWeiPm/51iv+c3Ca4zbOiuy3JJ0QvseQLmBKX+hQHHpDbC3xgY
         lh+NI4X1PcG3dIJw6VeV45qr+4dojEZG/znIy4ebP30KFJLcgG25F6BXkXv5YezqFB82
         rKP1LoyD894Lm+fDnEnMVOmFjE9Q7pZOb6iCN1RJZ7LlLRYgDn1cY9+wybXp41WXaDEI
         VBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165466; x=1719770266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb4kTu6hNN/Hzk3FHpOo3xTLDzrXJVku+1K6/EnMaMo=;
        b=G2iavqETgjDVFOARzHPnI9J3f+6fJOloARCSZh4M+0EwMuPfxVPYy/BRjK5liD+KgV
         XrlkKX7JLmAnaLnAkS7LFOnSB6tzl6mpnLe/ftmCjc1FJ2zFtdmVYOVn9oo5tQOgVXu1
         +WDkjHFXbszvDdQIZK3AJPNKZkhy3fTRVUJz6tMZ0DZhdbtRvZ1KRAbiwA5Zc+6JZYYu
         OkJZRYKRUFYXhvvokLCpKta94OSb84QXWYKsZycAqBC9e3YIWBK1wA/SSc5+gQtSdSwg
         ZxG2Nosb6uXFbm79L+h49Xnh1GaymtrlNhfX4p1y4gyAyynC2es/RBrBpC2LEbM8Bh7T
         q5dA==
X-Forwarded-Encrypted: i=1; AJvYcCVLXJxnUbnWLLlU/gJwaKEtsbbGCFv08JrBGpEHsd8vMhTEgycgmeDvVxD22ZgS9Iul4Jr4oafDIZ2W56xr50iVuZ/WqJ3eOjtGQCzo
X-Gm-Message-State: AOJu0YxZiymtJVHeGPNf+DGp/YHVr6qqeR8Ig8Fh5oyj9T9ETs2b3/0N
	7TUhD90/UO5Gtjd6ir0UmojdfiwgpQXQwuJvBA6VizgBKf4GxbvLKKVaPw==
X-Google-Smtp-Source: AGHT+IGMYD9SWxkwppWarlKxotv+gbDdJdqHKHIfqXILS+8v8mWYQUIxFgpQJqxvm5ZlihYheOX4Sw==
X-Received: by 2002:a05:6402:51d4:b0:57d:43c3:842b with SMTP id 4fb4d7f45d1cf-57d43c3853fmr3074243a12.2.1719165465958;
        Sun, 23 Jun 2024 10:57:45 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30536dcesm3719483a12.63.2024.06.23.10.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:57:45 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:57:44 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] staging: rtl8723bs: Remove unused macros in
 rtw_security.h
Message-ID: <59d13806a66afc571c9a7082f9436439113d3231.1719155208.git.philipp.g.hortmann@gmail.com>
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

Remove unused macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_security.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 7587fa888527..98afbd3054a4 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -22,14 +22,9 @@
 
 const char *security_type_str(u8 value);
 
-#define SHA256_MAC_LEN 32
 #define AES_BLOCK_SIZE 16
 #define AES_PRIV_SIZE (4 * 44)
 
-#define RTW_KEK_LEN 16
-#define RTW_KCK_LEN 16
-#define RTW_REPLAY_CTR_LEN 8
-
 enum {
 	ENCRYP_PROTOCOL_OPENSYS,   /* open system */
 	ENCRYP_PROTOCOL_WEP,       /* WEP */
-- 
2.45.2


