Return-Path: <linux-kernel+bounces-302849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2282A960430
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47EFE1C22613
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EC6192594;
	Tue, 27 Aug 2024 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYURdzLB"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7CD33999
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746733; cv=none; b=uJ+Wvvkuxlq3koK9AUXQzgEwn7oV8flaFAEU+ce2T26qw0a1TlN/7++k/lSzL13DNkZTqJ8ZBxtxu/XKPs/3ztmhe2aMHqhGxVP/khsa60pt8aZDt5Gjx7RzpcjjZxk12YZVAoO1Q36wFs0rKFUdQJjGVixs6U5zhpI+UGcB94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746733; c=relaxed/simple;
	bh=t9IGVRRdm8rEGT3/Jj7lU+fXIDHmB3sxw1FRiZjk4r8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dmATG4PvHTgO8WkgX3tKX5jGowSnedVShhx5yRHyxJ1CWGrDVOSMQHdB+cO8DY4uAl5OUBW3HQv3+yXkoCtECYifQXApx8+b32VkYCKBePXgPHQIorTS6a5iBwOYq2O9kpxgCI38WqW56uC/S027THsVvNfAks7V2nVZQ7WK3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYURdzLB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8684c31c60so623060366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724746730; x=1725351530; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I70MSYbAc1AGHnHaOGdeVVD6i++V9UU7IxJECcqEc04=;
        b=YYURdzLBU1P9CCtOHGdKDtZA5QHw06jToDt2QMdWFKfk3QiHBSSi9C8i6kMI/b2s++
         Wnvw+n06qZpXqbtlCHMyEo7H8UlFLpgPAE8xzHBQieMRIqnrEJDI5x6UBk/T+G+ESrJl
         usPyrbHWg0ks94E/WMdGlJ4niwb3iNh0jlEKBomRE75Rv3rdFafWsGOOWTc4/YAB71gy
         ozgpHeUIwgkeuVUQM2ZUJ+QrylyvtjV66XKeukqxbtFQj+J1DobFOtOWv5zxmXw3Q4eJ
         W5RPXH4VR4NXzJfFDPOc3HJrWwnnYXGmRaLSoXIZiWMIEEINIaU5Ws6tDnqSSQxVXpxN
         jZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724746730; x=1725351530;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I70MSYbAc1AGHnHaOGdeVVD6i++V9UU7IxJECcqEc04=;
        b=e9Ly3nr1cB7Jpw8nq6X3fpFacXKkRZy2TF0Ry9iuGxpMu0zSwTeAzoVxDfjlpy2xPK
         StOk6fzb3dFHLHqQ8zpRQf7krWCmBx0yRtLWAfHlSdCCRVBmXkkSo7oVRd7ypiXHY4yT
         2DacqJXtxntWewfGivA2DHtIlsymjFdnp8otYioshf0gXRPFUuoLujh5Cm9RpFagGbxS
         oFz4Q9SDjNom4rugWEvi0MgmjFHyJIMkJ9vIatAH+6Ux7B/Sjzux9r+37vnLh4h86Q4t
         8WwzVnDgGyEHyLkkvu73Se+a898+QvbHpfFHngnTXxLjoLLZGd49604uPejgKfwMldf3
         EqFg==
X-Forwarded-Encrypted: i=1; AJvYcCWk+2S8y91zzpYnCDpKeL/orFx/Gsyl+KEh32C+HfUTleqSmSBgnD2NV0yqfOFRtGMn3C0tFM2Eq/HcF00=@vger.kernel.org
X-Gm-Message-State: AOJu0YysG7LyRHRuln5GiLjJs7coZSCYfWKOD0565vWb08NiFtK3rPei
	C+BNBBQjt4I+PPX6ChF3y2oib1ErLn4Yguylrk2pBFahusdsFV+/1i+vQIyG
X-Google-Smtp-Source: AGHT+IEvD+pu/vLKN88m5xfnUGgU9GX0+asJE4mdQmyQ3pZT+JunQfaxXM2+DDLmVKefshg96reEJw==
X-Received: by 2002:a17:907:9689:b0:a86:8ff8:1dd8 with SMTP id a640c23a62f3a-a86a54a9387mr831255366b.46.1724746729544;
        Tue, 27 Aug 2024 01:18:49 -0700 (PDT)
Received: from ubuntu-focal ([197.237.50.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e54875b8sm78601066b.1.2024.08.27.01.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:18:49 -0700 (PDT)
Date: Tue, 27 Aug 2024 08:18:45 +0000
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl87212: Match parenthesis alignment
Message-ID: <20240827081845.GA15504@ubuntu-focal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix the parenthesis alignment in r8712_read_port() function to match
the opening parenthesis

Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
---
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


