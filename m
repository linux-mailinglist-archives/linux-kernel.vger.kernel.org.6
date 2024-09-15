Return-Path: <linux-kernel+bounces-329698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A639794C9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F198B21D46
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB3D4965C;
	Sun, 15 Sep 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY14MR6T"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348D034CC4
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382465; cv=none; b=OKk4fT438hEczzKTKh+djMdkg2szZa67gzMT/dGdb4T07tBRR9AgZO0UnR6/Liqw1yi/vyUW9u/WXGQH+Y+t03UmPpOWWp5JEy8UB10bBGL8crtBPvzTEatoAGV0TRHKGOIXaKESm4IWkurBYxKGAHcCs9A9kGafSx1AvIIh3UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382465; c=relaxed/simple;
	bh=iIJHHvD6hIi5F9NhuzxcrKHikYBlB626qDKDva4Vs+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVKvt1vlNSTmgeQY7zbQ/Rydl+wx4FA72shmhsYGaehNfusqs31t5ALJozUEtj4KR8H8CZ3KlTxzMn2EG6IEwMnWRuIO89KpWZczLPBjiORgo3oEh7Hk2iGr3Zv129iM5UC7xsv3uqGVELY7o+OXZseh8BIgaNmfuBCCgsPW9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY14MR6T; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c42bda005eso1264623a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382461; x=1726987261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPmn81t7YtWekA4/H4IxuxrNCjYcPu5ddDUh0iFq82M=;
        b=nY14MR6TSCmXqq6C66wM2tiJCGhHoMEJV+wmPldIJYlf+OScOfEuMcygvMh6b8UeUE
         Ek8Jga9Sa3N4SpLo7KSwwzn+ToH9m1/2Ps5gO+wXkIyCUWspyfJywcpWwAXmTqEXLBmG
         fCf3uyl6Wvk9DIiQ++MuPtaWGEpzpWCIlLdJMcJfDFuRbj0ZQF0gWqgDXH101MyX9qE+
         Y8mifRoUAaYrma3m+38/pwfSywg1zPbfm5vRY8BYqUANC1GDPsRQDMCHQbQ0+PsYpeYs
         bKvu8WSVrIZ0t6JJ+7vPwQCRN6w0LCrNc0cmeUK9wwc21VLgcd8FLIbvsnE/NVh0pJQP
         vgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382461; x=1726987261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPmn81t7YtWekA4/H4IxuxrNCjYcPu5ddDUh0iFq82M=;
        b=ZcpIQQqZYgoLIU36KFDR2RPpSYXNTcoUWgqGBTcsmMIMrZgy8io/vdaALUYEKEVuB2
         UKMdpWEi+6P/yhm0vsY72a9yOCQXinIyrVBOoHGFd+HaE5AkOHERExXW3EiBTRfpnsUN
         yMzmpfX+v7uGQ01hTss9X19Pat0pF2DD64RlDzALiKouw+XEkhFZTuuJ/H9HrFCuFP37
         b28O9aZ4lKFFelcA/ZCMtxzOwO2gHDaS4VwhtHg/vKqvNgozSpLoaVTI0Cc8QIYsh+FU
         oT8BgLp00pOyZJXbYXfxIcghlNzx8cgoqMQ0a8bC9MIjs4TV/vf2vecVYLeKJD6ZUgGX
         ENHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGEJIiGN5F1hnzJwCtKLKsTn7uPIC8j9S+LAI3pq0FmbO/5NACepSpfyYCZp88Gh+808cOqe/vxdWZvQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8w4MxaWt+tYtqGhWzhaY4Bzek/Lu8xcUGczfCxAwpgzgao3o
	bXDbr7nqfLFWHY7+U7zFj4l0jXlQnW4t7QCsvVWvcZ0ql9Vl1p41JIVcCQ==
X-Google-Smtp-Source: AGHT+IGIPMBHHwl+qqJdNNx5j3unKolOg43JEhn416q+U6DhqpT5ZNykHewg7J6H35cxRA7qiM8JxA==
X-Received: by 2002:a17:907:7ea1:b0:a86:ae95:eba3 with SMTP id a640c23a62f3a-a9029690d69mr1124959266b.62.1726382461511;
        Sat, 14 Sep 2024 23:41:01 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:41:01 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 07/17] staging: rtl8723bs: Remove unused entries from struct hal_ops
Date: Sun, 15 Sep 2024 08:38:21 +0200
Message-ID: <d4c1f7b6765ec246c797f4d0ac4d429fe6826180.1726339782.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
References: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function pointers from struct hal_ops.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_intf.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index efdd1f912b5d..f559a5c1fd16 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,8 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	u32 (*hal_power_on)(struct adapter *padapter);
-	void (*hal_power_off)(struct adapter *padapter);
 	u32 (*hal_init)(struct adapter *padapter);
 	u32 (*hal_deinit)(struct adapter *padapter);
 
@@ -171,7 +169,6 @@ struct hal_ops {
 
 	u32 (*inirp_init)(struct adapter *padapter);
 	u32 (*inirp_deinit)(struct adapter *padapter);
-	void (*irp_reset)(struct adapter *padapter);
 
 	s32	(*init_xmit_priv)(struct adapter *padapter);
 	void (*free_xmit_priv)(struct adapter *padapter);
@@ -192,8 +189,6 @@ struct hal_ops {
 	void (*enable_interrupt)(struct adapter *padapter);
 	void (*disable_interrupt)(struct adapter *padapter);
 	u8 (*check_ips_status)(struct adapter *padapter);
-	s32		(*interrupt_handler)(struct adapter *padapter);
-	void    (*clear_interrupt)(struct adapter *padapter);
 	void (*set_bwmode_handler)(struct adapter *padapter, enum channel_width Bandwidth, u8 Offset);
 	void (*set_channel_handler)(struct adapter *padapter, u8 channel);
 	void (*set_chnl_bw_handler)(struct adapter *padapter, u8 channel, enum channel_width Bandwidth, u8 Offset40, u8 Offset80);
@@ -224,8 +219,6 @@ struct hal_ops {
 	void (*run_thread)(struct adapter *padapter);
 	void (*cancel_thread)(struct adapter *padapter);
 
-	u8 (*interface_ps_func)(struct adapter *padapter, enum hal_intf_ps_func efunc_id, u8 *val);
-
 	s32	(*hal_xmit)(struct adapter *padapter, struct xmit_frame *pxmitframe);
 	/*
 	 * mgnt_xmit should be implemented to run in interrupt context
-- 
2.43.0


