Return-Path: <linux-kernel+bounces-322446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DF0972919
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD6528596F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CF1174EFC;
	Tue, 10 Sep 2024 05:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRkbGaqi"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D317175568
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947814; cv=none; b=p+m1tq6mHPcTPDjF88zzF52YIwR//pyh92pf5QFjDZLVp+mph8gXZ0YX1m27Xv4p4iW5ZdzIzL0UKkjd7NQiul1iNEdt/+ofxAO6aVFkPseEe0XroMdfprheie9VceOBBu3WiMb/Exaw5Q231PrkNWRumN/Exh5nJrk5bAoh8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947814; c=relaxed/simple;
	bh=ES4IlmV1I8qJ0umpHm9D3Om6YbnfFnqjgqdFRo+/ds8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iu/0/cnwRG2PHnoEmPX8taklAEFs7x1DIPWzliSucQ2uwkRbAXPcGIrX4NRZxFiDu49t2Qbn2ii6bhq4/cbsp606v99OVaOMEB2Mp+N1/5cv663CsBXFflKbIsAomGawv15ObCaB1qQh+1HUSKLU5mARB3IaTyX43XeOH7TfYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRkbGaqi; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c3c30e6649so267741a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725947811; x=1726552611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kTuEPCsEvs5kLo9QXLzwPbMasTm4z0Tp5r0GXCVgC5w=;
        b=eRkbGaqiVxTmKV0VnXdjeagP7LTNDGwtPML6ZZ8Rjoh/9y++GcqS5r435U5XQkV3xx
         wWi3SuzIO/qbdMLih7PhdS8e5ICWINZDn5W9C8JC55u6UP2ttDB/0VAlr9Zm96oTw+fe
         zGROems9QozgdIpOTrjtOGhrGBndg5ZVkV2fjtdF6hUfcXRf++necW8wkwDW614pQoQ7
         c2g8bDym7m+Fgd7zX/zBCwZ3Gl2+bJJp+kK/MCs3vDQK25rLAxyKPN/RIaiwAsejDONS
         mg/Ynarxb5wYMlUKJ5+VTeTp/eZxuABKXc8kgUjhBHrFnZHSqxhN9mtz7emukCD/4vt/
         pwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725947811; x=1726552611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTuEPCsEvs5kLo9QXLzwPbMasTm4z0Tp5r0GXCVgC5w=;
        b=aSPJFpT2Pt+zgAA+QhdiB/nm4ckAwjRfy/Gh3ZIX1l0Z7fb5kj+u6inMrMwPfcKFLj
         hOSORNJDzCMp4dJsshAtszuGVpDv8wVUX7VlCQTyN2/gtla4yW6QhQZZ6T1QeKpXXPxj
         bb6SMzVeEqaZTTWZxZrADLaOhhFomOSxcsqOFaHe3bIRt4OFWcVt14u3StqFOZciEJOH
         rQYAGllvudCScg/JBqCr/6wprBVjmmF5zbip7o/uPcTHucG4mEAACWX2a6SZVQEr83xc
         7FNL2HQ/CwZ9d2T33vsuEpntEG6XdtdDj637aulP6vK1yJ572+ov+mtxbHeaJI3DHQtT
         kc+g==
X-Forwarded-Encrypted: i=1; AJvYcCXrf1MAPzlXHpJ3t1wQqJgqe2gkpxkdpUmr5r1dv9LLgTUbSfqG1kdKFfiT80zd19A0DvPneofLMzoeB8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfW9XgqvyEZSCg1QFSnKfO3L80ct5kwUIgQBVgeydEyBUfyrTv
	Rpop1fDoqdWhUCfTyx8nkBNp62jlc29xoGM0+yAqX02Bka/azzHE62Ea0e5Q
X-Google-Smtp-Source: AGHT+IEd1VeuG+3jd8pYxy3zXrLRd9/TYTG51IqxtY9M54Ar+hVZU8DUNEVXhmTzAFlKoegFm+dXAA==
X-Received: by 2002:a05:6402:2747:b0:5c3:c254:fcbf with SMTP id 4fb4d7f45d1cf-5c3dc785e76mr10741639a12.4.1725947810386;
        Mon, 09 Sep 2024 22:56:50 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f2a8598b80c2d4e9a813f29.dip0.t-ipconnect.de. [2003:c7:8f2a:8598:b80c:2d4e:9a81:3f29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76efbsm3822547a12.67.2024.09.09.22.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:56:50 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:56:48 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] staging: rtl8723bs: Remove unused function
 rxmem_to_recvframe
Message-ID: <1016603607501abe08334f9577728dd3c4209572.1725826273.git.philipp.g.hortmann@gmail.com>
References: <cover.1725826273.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725826273.git.philipp.g.hortmann@gmail.com>

Remove unused function rxmem_to_recvframe and its comment.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_recv.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index c93594f75436..18dd1464e0c2 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -444,16 +444,6 @@ static inline u8 *recvframe_pull_tail(union recv_frame *precvframe, signed int s
 
 }
 
-static inline union recv_frame *rxmem_to_recvframe(u8 *rxmem)
-{
-	/* due to the design of 2048 bytes alignment of recv_frame, we can reference the union recv_frame */
-	/* from any given member of recv_frame. */
-	/*  rxmem indicates the any member/address in recv_frame */
-
-	return (union recv_frame *)(((SIZE_PTR)rxmem >> RXFRAME_ALIGN) << RXFRAME_ALIGN);
-
-}
-
 static inline signed int get_recvframe_len(union recv_frame *precvframe)
 {
 	return precvframe->u.hdr.len;
-- 
2.46.0


