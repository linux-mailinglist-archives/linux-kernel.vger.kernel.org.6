Return-Path: <linux-kernel+bounces-304598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E61A96224F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE5DB23A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9F415B99F;
	Wed, 28 Aug 2024 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAxGoh5Y"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D615B55D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833784; cv=none; b=YYIlc4xlvOxafOnezmNf9kebdFeUIPar6USOtSCCXGJIdTTAiptYey5ABxdoUXEuzKHJxHxcjw7oweTXLLZ0AWnT2F+UQJLLFGpwAbkPP99FlO5FuFPBnfUtDB1F/lXdAnILeCbW5wkXfvxZdL0f+BX/MO5qz6YukrSAeagCYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833784; c=relaxed/simple;
	bh=uhNkZ0lBAsyc3cDOoyPo/F8QbUBatGwuGsnXbGzykXc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L0ssKSbhtd+eP6V8BB+lLcXLu3t0GG4G8aBGf9sXrw+iN0eS2EWRfajzf/SuoobHFaVpo9gP3IjVGnLkqzb7TvVHLfOslk+BlQ+Sh63vdqAsMigvS42SS1abX+O39aUrYXCNBylkZB1X1srhaQK7BWJYI+f+9nWgcwitZxY/sQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAxGoh5Y; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-371aa511609so3212630f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724833780; x=1725438580; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvcMeJFbKMuFZL3nXutoA4s2bfUVybdtDR/sWYvStTc=;
        b=TAxGoh5Y+hqv2mtu8hKBzN1dYMjZEcpLGz1pArnUSlawDT7uo76b8Pbl9E04ZE3ums
         7q+iXw6NSB7FkyCpWYuH0yPOhvrudXwlzlOTb4rweCPAyBiqV+iSFGaUpewL3DADzSv0
         DLdngWUL2+MoqiOus0iFcPJlHtaqUmCpXlQ8hUO6PSk2wNfJzrnwzn+pIyGwG5IvvXLk
         RpKBeg36AJQVbvIlg2ZpqXo34Lwd3X/a9vsb/Lu1mdkTAE0KAN7fTi3w0kj0iVxrP9vq
         C6rhpv6HYvJ4Jst60OdmjNl4O1F0hOt/j3gjZH/4wS5UMhY/o/R/xXGXyVIJ9omKOEPn
         yINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724833780; x=1725438580;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvcMeJFbKMuFZL3nXutoA4s2bfUVybdtDR/sWYvStTc=;
        b=A0uqBzdnIHC63HKtJyrIhIZv5wy5ifTenbqXdg7Z1oSkX9GF70RuQ7R41QRjJuJ4ku
         kKh7+wzF/w9biIneNe20mkPFibnY9jwzPfQZ2HFTMmQiMNMJvQ95zOA8Q/fHHifmoibE
         iDuVTCToSNZnB2Pswr4GmpJpxQE8NfRKOQCWZAraciWsVokxnbhBvi3/Q+bCgul/8iWL
         NXhV3c+tfVKeGT4JMGcOaMvrgEJ6UqB3aTaBT3/tiBuFfb4Yg4bLRrePijAZoQB3sBGT
         LbpetC2+2U+ZGdZJp5Yf+6iYPaYkWwzqtOUnVnIEBdjJrjB4mcqWPF/3q0rznUbCZQ2K
         SSiA==
X-Forwarded-Encrypted: i=1; AJvYcCUwNuXmlWp4jeVWsBo8GT15eUfe7lg5T4cxR/nwInmpg5C3nCpVWuLiVOJVcrUzKWM9igYeWlO5x2gfZjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyclmT3GQt5JtvgYVOhZDu/5RNeYvPiklygC0MYabjKMY2Isynz
	eB1iCnYmR3RJO7P+ghExPFScBIK5StBrmJeJ+iPGkdzg6bz4lpzE
X-Google-Smtp-Source: AGHT+IHVVH9UifSJuuuzModwoYJ0FaxTRNIZhkKgKp+ZN08nuyWn/uBexI6EOZZh9tWjpN0i7avN8Q==
X-Received: by 2002:adf:f046:0:b0:373:549:bf4 with SMTP id ffacd0b85a97d-3749685ba5amr716206f8f.63.1724833779726;
        Wed, 28 Aug 2024 01:29:39 -0700 (PDT)
Received: from ubuntu-focal ([197.237.50.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730814602asm14991263f8f.44.2024.08.28.01.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 01:29:39 -0700 (PDT)
Date: Wed, 28 Aug 2024 08:29:35 +0000
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH v2] staging: rtl8712: Align parenthesis in usb_ops_linux.c
Message-ID: <20240828082935.GA3815@ubuntu-focal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix the parenthesis alignment in r8712_read_port() function to match
the opening parenthesis.
This improves code readability and adheres to the kernel coding style.

Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
---
Changelog:
V2: Edited the subject line to fix a typo and make it more unique as
    suggested by Philipp.
    Edited the description to include the reason for the change.

 drivers/staging/rtl8712/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
index 0a3451cdc8a1..4a34824830e3 100644
--- a/drivers/staging/rtl8712/usb_ops_linux.c
+++ b/drivers/staging/rtl8712/usb_ops_linux.c
@@ -221,7 +221,7 @@ static void r8712_usb_read_port_complete(struct urb *purb)
 			fallthrough;
 		case -EPROTO:
 			r8712_read_port(padapter, precvpriv->ff_hwaddr, 0,
-				  (unsigned char *)precvbuf);
+					(unsigned char *)precvbuf);
 			break;
 		case -EINPROGRESS:
 			netdev_err(padapter->pnetdev, "ERROR: URB IS IN PROGRESS!\n");
--
2.25.1


