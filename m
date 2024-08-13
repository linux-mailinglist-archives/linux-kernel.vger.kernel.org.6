Return-Path: <linux-kernel+bounces-285118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE8950993
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5491F22FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE621A08AB;
	Tue, 13 Aug 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBya9z8z"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BF41A08A6;
	Tue, 13 Aug 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564613; cv=none; b=ejJcSD+H+QKMEg9lBizwAMoVyXngR7FSkERSIY3nVzWz05vndyzYYnkLOHGOicXFFGQKXGt4yRKeRGVA65dA0i4sGlvzIVmTPGAo8SUjZ/pPF1HqQ+1ueBg87QaTKfH7Kaz7vCcO5EHOekPZk+x8wq4nQKASq9xwiLvDKeQ17ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564613; c=relaxed/simple;
	bh=ngc1hLOMkQFWBcGLsLCn+/86MLQuNCme09RUqmCXKe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=awRzDZnBhe0fSppZYX/iVSPe9pJYrKA7dS6dlWjrBA806oFUUBK61zfMj6Yo1DobJfSQQMkiqcDxLo0DfnOkDx3iclCB16uyBwXjuFxagO5k4QnpAjGlgcA/LX0De0mG8vv+CNNfFEfojLV27P4jefSARiu1lvoMucrQoRN6R38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBya9z8z; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-49294bbd279so2353620137.0;
        Tue, 13 Aug 2024 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723564611; x=1724169411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BIk7K7uDNXRgkjiz9GrUCqEfmLUY/1vRneZ0qMbh0tA=;
        b=EBya9z8zLxyKIhlKpP+spT0t1Xy3NzRIfX9JoRH23/zYiFXawzF/vIDX/W9qQ2qlyP
         Zck08ip2WPYWdLSVBkfpP9V7maNPqu5HJSWR8uonSb9GhLy3g4SpP9ig8mUSxni6ch4Q
         oMCfalYV3exGDyPtBvbg4ZrA7eWonWQfFHZS+KhKKU7QcQVvs9C3/42+2KWVnQpP/oio
         Dwycwl/FPxEtcuToUQa5HukCUNCvqDGG67e6S2Ug8TZUriWGeW8tierCKyWyqSr9u9F0
         JlIfqrbyjzRwXBiYWL//bzyjBJtYLPyvvOd+oxM1yh5sNqqywf96nNWr1xvlturYtcnD
         bOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564611; x=1724169411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIk7K7uDNXRgkjiz9GrUCqEfmLUY/1vRneZ0qMbh0tA=;
        b=aw94IhhL3pCsFV2pKLqSugOtcFfzuXWv+YVwdDAP3pRwlhdfwFA+Y0UYDI3hkZY+Hy
         cdl6q3WlZewPFSEFRFuYxKNH3RXVP/+vfMc0XROQx8ayI6637np36RiCNfjt1LF6Zm/7
         23dVlqalEiEHZ/upkHbMGV6+WpzwsIkLBNZ/+/+4xn4UaWPsIXvMoCQCYyhtWll5CvJp
         tvkdqhttLzJnRKjmvbJP41YzafS32F8ymvFn+JIR2ZTM/hP1l+ytNlXqGB65w38Qwao6
         8DzBYYcx8jjQkQxTR2JJPNnyeX8LwwSAQN1yiEMRHJUqiX7jXsKMA2X0ss4Qo+2y7xqS
         QpPw==
X-Forwarded-Encrypted: i=1; AJvYcCWhrcAGmdufBiI9uWFskbhO/BRllFzpXkZks+YLTHxlg8vPdXTBvfNL/Q9aerlQYcvTOWcoyr8rSHGROb95fY4PX6ee2NlsJ7OB1z3m
X-Gm-Message-State: AOJu0Yw6Ms11kQhSrdpvhIAV3/He9qLMk1d2tf38bepbE6cgPcysrPdu
	KWEPKlBoJsdyyJqU4J1Q/9hc/Okgid1vo7xEal5TcW/M6OytiV+BowOdeSDU
X-Google-Smtp-Source: AGHT+IGNH6iBSXfO0StwAXfg50vBUBsYFAR6PIRZfKq+usqod4RU29+6tWbpTj4SvrdW0RikylD4LA==
X-Received: by 2002:a05:6102:5127:b0:48f:db3d:593e with SMTP id ada2fe7eead31-4975990e708mr168236137.14.1723564611095;
        Tue, 13 Aug 2024 08:56:51 -0700 (PDT)
Received: from fedora.. ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-49709fa31f7sm1089283137.26.2024.08.13.08.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:56:50 -0700 (PDT)
From: =?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	=?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
Subject: [PATCH v2] ALSA: usb-audio: Support Yamaha P-125 quirk entry
Date: Tue, 13 Aug 2024 10:56:53 -0500
Message-ID: <20240813155653.35203-1-soyjuanarbol@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds a USB quirk for the Yamaha P-125 digital piano.

Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
---
Hey! Thanks for taking the time to review my patch.

Attending your sorting by id suggestion, I've moved the P-125 to the
bottom.

Regards,
-Juan
---
 sound/usb/quirks-table.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index f13a8d63a019..24e6f68e2f1e 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -239,6 +239,7 @@ YAMAHA_DEVICE(0x1030, "PSR-295/293"),
 YAMAHA_DEVICE(0x1031, "DGX-205/203"),
 YAMAHA_DEVICE(0x1032, "DGX-305"),
 YAMAHA_DEVICE(0x1033, "DGX-505"),
+YAMAHA_DEVICE(0x1718, "P-125"),
 YAMAHA_DEVICE(0x1034, NULL),
 YAMAHA_DEVICE(0x1035, NULL),
 YAMAHA_DEVICE(0x1036, NULL),
-- 
2.46.0


