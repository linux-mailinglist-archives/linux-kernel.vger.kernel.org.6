Return-Path: <linux-kernel+bounces-272011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C41E09455DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495A5B22418
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C77134AC;
	Fri,  2 Aug 2024 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmBJMwMu"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD0D12E71
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560978; cv=none; b=eENl0YhuIngS+2GZY1B2Q2vXnYkjG6yvyHV+De97x359q7zsFYnNPk1jpY9866aHCIZ4HhnQk1FqurZUlWdvrZ4fqoZ+GU3W31vVCvP7cJg4zItaYR0Hqn41FAYVw2Su+GYND9kEm9XSRgW3jPKuel9picIW7kV4DQRCHKm2jik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560978; c=relaxed/simple;
	bh=ujM1XJIxa/ere7mxRTXOLq9tnMVH6DzADLhZoNYsU94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=APLwe0b25RXEd+00KgP4ABv0jmi61cfbxVoAQYtFuzvHJftbremd2sgoZouHhwbYEX7sue4cbNXWW2CQOxS4pwlXVlaBDDwVMkI9mYBWUC07JHexngYPu0OFRFW+lVw2o46EW2pei3JSRoUW9TcModd0SA0SaCH/xuqaRXnfC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmBJMwMu; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so11099417a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 18:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722560975; x=1723165775; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BbCh2qq+GqJnDj1NLZnr9Rls+DkMZwrRCOx9dR1Do1E=;
        b=nmBJMwMupOCTKPda38GxndjSUTwcRzCJg1B4aHSG8GiV7sSOf6CtU8MvekO3Pe0ds2
         +OJEEN2rjgDwphADOp30+z8z7FHXZzwuSTzD52rQOAX2Uyledw46v9gGGYAsL7gzrIIO
         UBiDjKj+Xcfx2dS4o0BlJgR1tkMP7juMiDC/Wn+r8iyyDn53XQBZtBky4wjnRCFtp15W
         kgrWNFpdFRVFuCnxxvoUF07XxPf8n7CIVnd3lQCk9zxbrOzifPBKNGXrFhRw3Z2h/NHk
         XpINmrzmy813rA1BZWNm4ybzrjxm5qq9oFZqyUxH25N5baqh1k3FRbbQ0bFw7NHIwdSw
         xIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722560975; x=1723165775;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BbCh2qq+GqJnDj1NLZnr9Rls+DkMZwrRCOx9dR1Do1E=;
        b=UuITyOqLwbi6SAqHJAYomXXZu5Ymt4Mg1xHCOHMB9nUlvs3DLxcVRcrPawHoFSARTY
         5oeVELhgh/2BiZx49y5k/LLbBpdSnPp/9BzRqA80CGPURVHf5cgeYqgi/pI0Uaqjp7Xr
         lIia0qeLTraBlHk8geuLYOaYlAzE8hLVag6FrdyMpxrOZI9U8DPzQtvnH0qoykCziCdW
         6RZ9Aa0tO+hKXliN/a69Y6gQXTk7hwXBfAaxmGAJKuuPaUQYe8C+x3Y+nRHBROUdsTXX
         0YjhQjs2GhtzOWyHPWBapfOqr2p/V6na9yGWfLsVdQtfoImox2L5g96dFoZeGTFHjNJj
         fLBg==
X-Gm-Message-State: AOJu0YzRVU+2+93tEusgfALtDHY1YUc1a3lNg+IBwq1mXa2KnS59iPl6
	cm/DdfLHURL+XOU9ijqqgiTSYr22pEngK8AJrphgMp34huZdMyHf
X-Google-Smtp-Source: AGHT+IEWJ/rEpduxi5nKxB1TDcKkBxA4cQbX6nPfFw0nWnayCRn9XuSyJ4S4tCylzwzeT02VOCPEvg==
X-Received: by 2002:a17:907:3e1c:b0:a7d:26ff:aeb0 with SMTP id a640c23a62f3a-a7dc4fa89dfmr115937866b.30.1722560974799;
        Thu, 01 Aug 2024 18:09:34 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c185sm37411466b.61.2024.08.01.18.09.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2024 18:09:34 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 2/5] memblock test: add the definition of __setup()
Date: Fri,  2 Aug 2024 01:09:20 +0000
Message-Id: <20240802010923.15577-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240802010923.15577-1-richard.weiyang@gmail.com>
References: <20240802010923.15577-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 1e4c64b71c9b ("mm/memblock: Add "reserve_mem" to reserved named
memory at boot up") introduce usage of __setup(), which is not defined
in memblock test.

Define it in init.h to fix the build error.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 tools/testing/memblock/linux/init.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/memblock/linux/init.h b/tools/testing/memblock/linux/init.h
index 828e0ee0bc6c..036616a25427 100644
--- a/tools/testing/memblock/linux/init.h
+++ b/tools/testing/memblock/linux/init.h
@@ -28,6 +28,9 @@ struct obs_kernel_param {
 		__aligned(__alignof__(struct obs_kernel_param)) =	\
 		{ __setup_str_##unique_id, fn, early }
 
+#define __setup(str, fn)						\
+	__setup_param(str, fn, fn, 0)
+
 #define early_param(str, fn)						\
 	__setup_param(str, fn, fn, 1)
 
-- 
2.34.1


