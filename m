Return-Path: <linux-kernel+bounces-563351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B218DA63F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB182188D0DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CAD218AAD;
	Mon, 17 Mar 2025 05:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0UHhTF2"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B751DA61D;
	Mon, 17 Mar 2025 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742188642; cv=none; b=MSS3GxNL4DK600BauPy3shDCPsHeD7RwiM6L+hTeXOPQOzPHxOyKht/98AXTI2c8MQDAR9hoVmPb3fta7nMDWbxHYfulNfjgYcnO9yqk8jqse01pK1xAiFyRgkuu176Pk5UME50DJ69OK8QA24AFEGOVoKVXJKe06Ts8H2gdJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742188642; c=relaxed/simple;
	bh=vLi1Y671MAsh1r15QlDQ4G8er01KxAKWFFKOKWwZTso=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XKQyW+U7RIfj1vrOBTX81E6VWdycQLhNL5VOniuy0utBSeWeWJFZe7iNST9OTLrMvLrnhRWNBLIstUgdECrrARAtY/dm0rhBvE/J8VWq381hcAbq25OqLqI5HaewoWVzy85YBbdUyBIqdux7yvI5fGuumxEeDsTagTehs/AuvbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0UHhTF2; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so5531825a12.0;
        Sun, 16 Mar 2025 22:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742188639; x=1742793439; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FviiEizNsPrswvoF1WtZ4IxURDJ9d85H3lSIXGoQ6I0=;
        b=c0UHhTF28rfg+cesuXkc9aGl/1cCO/Htduy2AQKZtFKrWl/GBNCWC9pkooDSkEHB2N
         A/Phko2MKWzO9ENNR10ajDy1+a6zagVjoLfJ+62aJNQqN8yCQqooGAS0ceMh5YqajMO9
         nY87TKK3TpTQSmrez/JGU69iBQj05Jy7NcMX6a+HWTXNjit3iDNuc8BM1roOuZNhKtdW
         EWWSXvcPdBzWuguXAPgAEu2WjDF55SFmu+jn5yMCoada6bhZp5MIsvSwbKZr0rQ8/Opg
         QkuWNAjS/fjRdLmNh3mNOLwDmqViaFYQcJh5DR3exUCYPED73nmsMqjNjz73XP/J+Nh9
         MTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742188639; x=1742793439;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FviiEizNsPrswvoF1WtZ4IxURDJ9d85H3lSIXGoQ6I0=;
        b=Vx3L49zbDjtPViAFzfuXV42sxsWw1EfZpXu/9JeJnHJmzWOkzMBFVxvlyI2DhtIN5R
         YcEYIXYRScMg4vbEaEgPIhadChTqBgi8rmOh+qQxHTTgFfUVqu7E+y54T8mXFwTpFr/A
         dsi7yvaEMTQ724XsKM+hAvAtNSUjuef+jVt/Z6jA83g2ho7qKXIQGHLSkXEFAKFUENEh
         uhpYfa8DNENElsOiE9PRWtU1/1yhelASMLU0LPlISxkncaWVc9ZW1+SVvyEv3qiliBZN
         +Z2MzJzJD4JvF0uRs0CIiypdJYlP/3pyqUnx8F8oFz8XmKB7r8f3GX9yK0PPCXdD4L85
         ovlw==
X-Forwarded-Encrypted: i=1; AJvYcCU56WgsGj8aGZ8E7JMXSSi9zmvCkLWA32RjisWbavoDiH3P+nLP7+oRP+9rfjnOYWYOqfLL4uTROb6W@vger.kernel.org, AJvYcCWWRyq4SA8X+2uLbX+muAr73ODAfrNLikKXbXuWNDlFs3tW91jjFlOpOJ5DDHzoy4CoMczRdjW2aqRRFs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTTP6p86xk9T4krSsA6E11C3MaZ/CgEBSEQrx/nr9FSdJRR2gY
	fjStJDdNfbb++nuuquAZ8J8nHpFeInAbDT6Ky3miKE2c4H3szbft
X-Gm-Gg: ASbGncutnwg1Bpgz7c4vU5kaIXWAMVWiuQlOyRj+EIPugQ7nLpUIpnL5NY+ZBFCXji4
	lDNGOjPMJk9FHxmkyz04t5uTqT+Y25oBVgsusIbb2hgKoUBkRX2+Q3aABWFf1hsO+uKTR/8JMcQ
	dwCAxrg+ppxQwKisTpLWctLnoghXbNv5fbRfb6umsI54ZXRnYM54tfWtqYtQRLF+BO9sTpF3vSx
	sDnsbNbJePrIAXL7EZ7OGcRp0P8Rmjcq14h37CLGiDxmzvwm2JnFFkQ1lR2vo7YO+4twCXe5aj4
	k5yGEG2hDZyuFkIa1ZAMF6A8VhBme6GFzdJJaswqcA2w2Oe5NXt8Td+06F+Lvd4nztYR4rnk1eb
	hhwSESIGzOWhbOvMkWHP5O/KwxA==
X-Google-Smtp-Source: AGHT+IHCJDbslQRk+xyipAV1mKRrF+/+NV16nsiZd9UURhUECsvo0H8J4RQvmsaDs2dCB74Kirz0ZQ==
X-Received: by 2002:a05:6402:4405:b0:5e7:8503:1a4b with SMTP id 4fb4d7f45d1cf-5e89f6430b1mr12304682a12.18.1742188639269;
        Sun, 16 Mar 2025 22:17:19 -0700 (PDT)
Received: from veno.localdomain (213-47-47-110.cable.dynamic.surfer.at. [213.47.47.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816b2a683sm5253103a12.81.2025.03.16.22.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 22:17:18 -0700 (PDT)
Date: Mon, 17 Mar 2025 06:17:15 +0100
From: Michael Ehrenreich <michideep@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: ftdi_sio: add support for Abacus Electrics
 Optical Probe
Message-ID: <Z9ewW-63F212DcV7@veno.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Abacus Electrics makes optical probes for interacting with smart meters
over an optical interface.

At least one version uses an FT232B chip (as detected by ftdi_sio) with
a custom USB PID, which needs to be added to the list to make the device
work in a plug-and-play fashion.

Signed-off-by: Michael Ehrenreich <michideep@gmail.com>
---
 drivers/usb/serial/ftdi_sio.c     | 2 ++
 drivers/usb/serial/ftdi_sio_ids.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index e07c5e3eb..7bf46104e 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1079,6 +1079,8 @@ static const struct usb_device_id id_table_combined[] = {
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	/* GMC devices */
 	{ USB_DEVICE(GMC_VID, GMC_Z216C_PID) },
+	/* Abacus Electrics */
+	{ USB_DEVICE(FTDI_VID, ABACUS_OPTICAL_PROBE_PID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 5ee60ba2a..5de8067be 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1612,3 +1612,8 @@
  */
 #define GMC_VID				0x1cd7
 #define GMC_Z216C_PID			0x0217 /* GMC Z216C Adapter IR-USB */
+
+/*
+ * Abacus Electrics
+ */
+#define ABACUS_OPTICAL_PROBE_PID	0xf458 /* ABACUS ELECTRICS Optical Probe */
-- 
2.48.1


