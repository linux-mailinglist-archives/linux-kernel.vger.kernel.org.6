Return-Path: <linux-kernel+bounces-226374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B2B913D80
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E086D1C21157
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DAD186E5C;
	Sun, 23 Jun 2024 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA9HTP83"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E978184130
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165499; cv=none; b=fxkUdeO+GW2vbtHOUK2Kn6jiCi0STKk4fI37TrcyJ9aCrQygJZ2gLpZv75SgciYufr6oOwnmtjwBO+iLhTNBr6qf4LKRZ/nS468ietIRlGFpgiuhAI+y7nNxA/e/HFReXQOa/0Uf1f8BGfrbBJHkbFcGEbcjfNYS81uaoMWXnNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165499; c=relaxed/simple;
	bh=qyGIc+oIfQgy5MKT2F+qVfi3DUjrNkAKWv5yBxbxNEY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQSyUnAKSDbSPqT9XVZfOlT/oyWax7JHLpT11I+e396FOGa0lRpMU2kzFI+hGmmnlxN+fRTeWEYC4oPu+pS2k308pZxmCpZb51DcSZ/Dfwo8hN5ek4RKyeKMSEXLvI7ljOPJdj1RUMtjYwVPh0FdZFzzw1BfkVp8zu6rcTcfv20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AA9HTP83; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d16069321so374240a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165497; x=1719770297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0AO01oKOA3xCjs8tyAcfStxUCftobcQ/yCAcPc0dY2I=;
        b=AA9HTP83wv8wOfTuKvE5irTYvvaPZyKKbqN2Rx3HkcV71N7JEqp227U/HV30wKjjRk
         FzZpaEmz9MY9hjCcgLbUvr5KPCtoO6tIqOvDieaji6jsJCvHpM5HarUOTZcTB2YjP/Zl
         9eNBMczz/X7F4a1PeJgAm3fBKcvIdGQ87eNuOvC8sMPzyDn7Lr54aFVxtYoTGzvaHQko
         UUIYj2FOzmGEpuXDP+dMKZpS+981mNWcO6ZXnWlOBpEKCOsACilDkUsJ0vuVOfRr8tAQ
         YC6/8gck0w3L0ywr9NFA16rB0wdGUTZs9/dAiq3c5SKVHa8KIF63hH1HwwKRMUIyPYYP
         SnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165497; x=1719770297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AO01oKOA3xCjs8tyAcfStxUCftobcQ/yCAcPc0dY2I=;
        b=JDkrb3w68Nu6OQhHcIZ4gsDTCUwce87GNquHH2y+avnVtk4GH+xSniulBL5m9usjSB
         SGN73vQhy64ZlaYb6qb9nJuK/Zjcvg5NEhr/Zdn9def1oKXpLjtJ+NJm36kR4fZuxg1N
         nYkx/5icc2rUJ1EDApqS9qP8mLoTeVzWtk4Gc0TnRS/WzsxX0LpIIw1M+kQ39HwT8Ldi
         F1Za0wZohM660up1t3xPhDPEkuaRJmfZ+whN868BrlArX1n+5Xlg13BtiGEMNXNZMOHz
         sbbfkC7dKeQ5ZYjLv6dlrzj/rpWh9xK231xBtNnQr3/cJsBSS4hY92aYf+Y8fzWXb+/X
         +SYA==
X-Forwarded-Encrypted: i=1; AJvYcCWjeXY86lOl6m61P4F3V7XE/YvtWqnWbqaJcYIcnHR3aP5MBMHsqVK1T24z7yyrYfjAyrG10XIFy5A8RW0WzCjIwlQGLGUCCAOVW23v
X-Gm-Message-State: AOJu0YwlArfaWC7Ck5I+RVoeb90preWGFPei9SnDMVHglPBeQU84n+qc
	j06mud9Plsww/RMjKLyOoFjznLfkczLvG/0zBP8nIqEPAUW95ipj
X-Google-Smtp-Source: AGHT+IFvvdMNsYHLTJeHDtdF6kgpyqtgEbCpVNVhVf/84J4lSYrjGv64FjYJ8nQzXE5Nhx9x1e2prA==
X-Received: by 2002:a50:d61d:0:b0:57c:6d24:26e8 with SMTP id 4fb4d7f45d1cf-57d43b68d3dmr2167140a12.4.1719165496696;
        Sun, 23 Jun 2024 10:58:16 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3041208esm3743177a12.30.2024.06.23.10.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:58:16 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:58:15 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] staging: rtl8723bs: Remove unused macros in rtw_io.h
Message-ID: <91e79b32292ba567c2ec624e130350a40a7866b5.1719155208.git.philipp.g.hortmann@gmail.com>
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
 drivers/staging/rtl8723bs/include/rtw_io.h | 57 ----------------------
 1 file changed, 57 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/rtl8723bs/include/rtw_io.h
index e98083a07a66..be9741a056e5 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -8,70 +8,13 @@
 #ifndef _RTW_IO_H_
 #define _RTW_IO_H_
 
-#define NUM_IOREQ		8
-
-#define MAX_PROT_SZ	(64-16)
-
-#define _IOREADY			0
-#define _IO_WAIT_COMPLETE   1
-#define _IO_WAIT_RSP        2
-
-/*  IO COMMAND TYPE */
-#define _IOSZ_MASK_		(0x7F)
-#define _IO_WRITE_		BIT(7)
-#define _IO_FIXED_		BIT(8)
-#define _IO_BURST_		BIT(9)
-#define _IO_BYTE_		BIT(10)
-#define _IO_HW_			BIT(11)
-#define _IO_WORD_		BIT(12)
-#define _IO_SYNC_		BIT(13)
-#define _IO_CMDMASK_	(0x1F80)
-
-
 /*
 	For prompt mode accessing, caller shall free io_req
 	Otherwise, io_handler will free io_req
 */
 
-
-
-/*  IO STATUS TYPE */
-#define _IO_ERR_		BIT(2)
-#define _IO_SUCCESS_	BIT(1)
-#define _IO_DONE_		BIT(0)
-
-
-#define IO_RD32			(_IO_SYNC_ | _IO_WORD_)
-#define IO_RD16			(_IO_SYNC_ | _IO_HW_)
-#define IO_RD8			(_IO_SYNC_ | _IO_BYTE_)
-
-#define IO_RD32_ASYNC	(_IO_WORD_)
-#define IO_RD16_ASYNC	(_IO_HW_)
-#define IO_RD8_ASYNC	(_IO_BYTE_)
-
-#define IO_WR32			(_IO_WRITE_ | _IO_SYNC_ | _IO_WORD_)
-#define IO_WR16			(_IO_WRITE_ | _IO_SYNC_ | _IO_HW_)
-#define IO_WR8			(_IO_WRITE_ | _IO_SYNC_ | _IO_BYTE_)
-
-#define IO_WR32_ASYNC	(_IO_WRITE_ | _IO_WORD_)
-#define IO_WR16_ASYNC	(_IO_WRITE_ | _IO_HW_)
-#define IO_WR8_ASYNC	(_IO_WRITE_ | _IO_BYTE_)
-
-/*
-
-	Only Sync. burst accessing is provided.
-
-*/
-
-#define IO_WR_BURST(x)		(_IO_WRITE_ | _IO_SYNC_ | _IO_BURST_ | ((x) & _IOSZ_MASK_))
-#define IO_RD_BURST(x)		(_IO_SYNC_ | _IO_BURST_ | ((x) & _IOSZ_MASK_))
-
-
-
 /* below is for the intf_option bit defition... */
 
-#define _INTF_ASYNC_	BIT(0)	/* support async io */
-
 struct intf_priv;
 struct intf_hdl;
 struct io_queue;
-- 
2.45.2


