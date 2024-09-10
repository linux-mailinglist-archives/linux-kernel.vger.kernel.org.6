Return-Path: <linux-kernel+bounces-322447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C197291C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B46B1C23C89
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6546178384;
	Tue, 10 Sep 2024 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghmOzMUI"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFF16DEA7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947820; cv=none; b=i2GC+62xvh3Y1LsCag53blLUppXL5zTcLLVt1+DYUEf0aWSWALbwAEsbfF2gqzXFGKSfCJsOfCbZw3ZajcWV+DfCBy/wTlfLVTXro8VwZV2r/yCmPqXT22JNDT+SuuckhlMe7vEgS9tepMS0UcEivLCMOm8A0CHxiVuj6lV38sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947820; c=relaxed/simple;
	bh=IaP9rFQ/bolbuckaldqglihw4sOfdbU6LO82Iy93xPM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mrv92N3PlAELchfz7HSnvWZhSib4GYFA//uRUo8S3rZdSdayjRU4i2THLGoP/UVwR9fn5w2nvoDNaVTdq56ZIlV4yrZLkOkpOqLMOKAyMiXxFWq62vJnBtRhDSVsUmhln67PfdUOg8ebaGWHEL7o7arq9FPjoqtpamBl3x92LzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghmOzMUI; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c263118780so465226a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725947817; x=1726552617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YbgCb22kbv4qLXX4/sAXCT5ymhU0wUo6KWoE+VslriY=;
        b=ghmOzMUI31Z4JVKECnqevM3EBNDVl384QIEBLRxNgydfHhNRC74OKOL8SNGaKimIIu
         FKBtC7i02JUUHojFvoDqZ6DRDpasXZTqKbwsV+36IbHMnCFpCMnw6BGZFpRbiueAKEXn
         +CpXowh57kazwsHc1jZS+6jMooQRplP5/usYVJ+L20Hjg+NQxb+iamtFBe+9SU8z75bA
         +kdGse4cY4V7jZXSriZySzaaZwFAezlkCrGKhZuwhAO9qMLArtLRu36/Jjau1bMRzYK2
         JSEFLceI5evo+tLgsj6wnfAnIqGJhY2kkUrPahtLzfNrNjGYgeXWFEmcdpUjLZR5JOTA
         lDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725947817; x=1726552617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbgCb22kbv4qLXX4/sAXCT5ymhU0wUo6KWoE+VslriY=;
        b=RgFZanHQjWgmHExyLSJ0FCXMBjrKcQdveBs5ufKjm218IAuFHi0kdfR1bnCJbSxDpZ
         yMV5B8EXKRBCpS9J1CzmwmUgwrmr6ll1kITvucVx8c+NdQp/oWcDzoB108bkID095mH6
         YWPOr5Kb5MqjdXJnGh5CCmdvlK0xb1iSmiQmM1pqZaBQJwEZBVhA66CgCI5EFh4qbkx3
         YXZSNA6w3b08Ch45mL17iDF0P/cTWpgPvcRWfUHheZZ1Ka5lfoRWGOS02HeTbK09Hsif
         NpDrakG3bD6ly0jiDoXxYt2Q/86A6SE0xMVpBvuN78hcEARRCAD73ro97M0sLAfaiApX
         mj1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBbqiUyTfvwj7r1nZQI0GNjF8woKsIKr8jdM57xdMR6n6jJ5nYl9pZfQR3jD4DztMWeYcYm6Dtazaa7+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCImnXbjdjx269mMrmJPv5ZLUvM8HZGRI8dvGbSNKOLMDxPtqp
	McRhUyMAhyYDyZQeipDSZ4hb5PfdFdNkB60ASYImkbvEfcA2ved8AWJ2rrLB
X-Google-Smtp-Source: AGHT+IH7qXddiqCgKss0Z6iVsTYJRLpkuqBq5dOErR5g9io/RRsaWo1dBSyE5hmBP+2L1OzxFUMBNw==
X-Received: by 2002:a05:6402:5108:b0:5c0:903e:963a with SMTP id 4fb4d7f45d1cf-5c3dc7c0012mr8703846a12.29.1725947816924;
        Mon, 09 Sep 2024 22:56:56 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f2a8598b80c2d4e9a813f29.dip0.t-ipconnect.de. [2003:c7:8f2a:8598:b80c:2d4e:9a81:3f29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76f96sm3777102a12.74.2024.09.09.22.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:56:56 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:56:55 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] staging: rtl8723bs: Remove unused function
 rtw_hal_get_odm_var
Message-ID: <adbeaac00054c87e4c55714817ffb85f68d37c4a.1725826273.git.philipp.g.hortmann@gmail.com>
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

Remove unused function rtw_hal_get_odm_var.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 6 ------
 drivers/staging/rtl8723bs/include/hal_intf.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 7e3db8d3c910..b66c02cd1c82 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -160,12 +160,6 @@ void rtw_hal_set_odm_var(struct adapter *padapter, enum hal_odm_variable eVariab
 		padapter->HalFunc.SetHalODMVarHandler(padapter, eVariable, pValue1, bSet);
 }
 
-void rtw_hal_get_odm_var(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, void *pValue2)
-{
-	if (padapter->HalFunc.GetHalODMVarHandler)
-		padapter->HalFunc.GetHalODMVarHandler(padapter, eVariable, pValue1, pValue2);
-}
-
 void rtw_hal_enable_interrupt(struct adapter *padapter)
 {
 	if (padapter->HalFunc.enable_interrupt)
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 5cffab2d06ff..efdd1f912b5d 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -301,7 +301,6 @@ u8 rtw_hal_set_def_var(struct adapter *padapter, enum hal_def_variable eVariable
 u8 rtw_hal_get_def_var(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue);
 
 void rtw_hal_set_odm_var(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
-void rtw_hal_get_odm_var(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, void *pValue2);
 
 void rtw_hal_enable_interrupt(struct adapter *padapter);
 void rtw_hal_disable_interrupt(struct adapter *padapter);
-- 
2.46.0


