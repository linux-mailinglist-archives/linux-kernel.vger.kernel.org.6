Return-Path: <linux-kernel+bounces-237125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53FB91EBBA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 02:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EB228431F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 00:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8125B1C3D;
	Tue,  2 Jul 2024 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzWYD069"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D0263B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719879475; cv=none; b=NZ05/YTcVJquXvOPFCfdmpvv9xx2LjuurECyua4VMnTa37U3NAxGptqCS8CluXc6m1IvuAGmUGEXXJFFlA2VEJG3CdeOfZN7XDd5wBbeIF6d4hDAfkf5fEjAZdklyMPqCGGQ020MnKNEYed0TizGkrVAt54otSORzCVHEsohHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719879475; c=relaxed/simple;
	bh=seMgPVF7bivcnLBRRjop74HO7XyFxJa8L7ZsnGeuW8g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XcEqgdUBaWfGtmY7NCr8zhG4JveLhtHiXkI/ReDWuf3kmYdTDZhx58nlRRoLUEeLqrT4TOOFDQypF3aFCI3RjadPidBhCPejWOgJ7UZJP/qWS+MqpxNdxFWBS+pcinVnWg6HTEmo/jjZlFvSSYP7jVEq4rvJUktpnZ3cYeDlhxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzWYD069; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso2947242a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 17:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719879474; x=1720484274; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCOq0IehP++4h3yKaJ0dKMks8090X5zka1SBb8qbre4=;
        b=IzWYD069KFt0IszBpY8MOn/26d5CjaAZe1OIKZ6PHEj0olXa1P+fbT+77CmLIk/AOU
         kn5eOTILV+k3/I0ZnpWkMa8tO8+Gr90Uc/actNQ/l+Wh2UIJd6sZKlXE/4lKtLOktJTN
         R9P2YnlS4bbi3YBzt4gwEumn48E+vTfkKwykEt4ZsL+SGisFzHf+K+3kBl1ucOoT5Bsk
         wFmAw8qOaw3Kh10qRBNEMpTW9uMWoZPhk0XaFDvfgeynTrIK5NbzxZPEIkaliqXixpC0
         hRdyxl45c5DpCFMcoQKVGLBntHQb+U9tIMKGaOHi/a467Qi5w+u06mkHIkYLUzdYUR+A
         DXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719879474; x=1720484274;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCOq0IehP++4h3yKaJ0dKMks8090X5zka1SBb8qbre4=;
        b=rA1mcKTcGUc870eaGcK+yvF27Q9I98sBVoV5EMpu390rRl52WbNpU3RNVi1RcTCGUQ
         9ANasE+dX/VmVKq41wnGo2AVURDALBU3A644rVUNptKj0Sd3igrYWtgOcW0nPuICCkAW
         UTwuzjxRImsierR96RMqAEvvkIiXdvMqBormkyRt/ASjSEMznTwaAkARkeB214V8Op4U
         sAd9eNzX7jMK8yzzJgv/XPgyPxH92xFBLFKpF0+hhLmiQmmn4Y9XFS9a6z3WboyWzA9I
         aTLQucMiSSBJoBvgCg745U5Bkv/0hyVSFlkIiCSXjRVnahzUIEStRsVaj1L9mu442uNf
         xT5w==
X-Forwarded-Encrypted: i=1; AJvYcCU5QyyLAcLWzRSPWWa08yX7DFWpdL4PiO077yT8+5skB5EWmQ24yxTc+0TAeLggkGpUDm+ZNWuQr8+onGdcTeIqkqKfBm2oKdvNP2OJ
X-Gm-Message-State: AOJu0Yz5VNSqxjZyvZbz5AAaziDoWagkOnAMlhb3oRkmb37EGFH1yNw8
	awmNpK/1q++n5b8Q9dRc1ZfKybr+oVfr1nRRWB25YHp01dFdmTlG4+60vA==
X-Google-Smtp-Source: AGHT+IFHDRZ1ur4V+gII603Usz1F/TVAyeBY5KOtBX9lQy03gQgBRMFi3LPkBb3S5m3BNawgHIickQ==
X-Received: by 2002:a05:6a20:12c9:b0:1be:d0c8:d562 with SMTP id adf61e73a8af0-1bef6140787mr9222274637.37.1719879473699;
        Mon, 01 Jul 2024 17:17:53 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:97a3:bdcc:1a3b:f207])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bc723sm7442256a91.46.2024.07.01.17.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 17:17:53 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:17:50 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Anatolij Gustschin <agust@denx.de>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: pdm360ng and touchscreen set up
Message-ID: <ZoNHLjmSvCN12vU5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Anatolij, Michael,

I hope you can shed some light for me: why does pdm360ng have very
elaborate set up for the "pendown" GPIO of the touchscreen? Can we
simply fix the DTS in arch/powerpc/boot/dts/pdm360ng.dts and specify
correct pendown GPIO there, as well as correct interrupt trigger,
and remove most of arch/powerpc/platforms/512x/pdm360ng.c ?

Something like this:

diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
index 67c3b9db75d7..5651bd9d9db3 100644
--- a/arch/powerpc/boot/dts/pdm360ng.dts
+++ b/arch/powerpc/boot/dts/pdm360ng.dts
@@ -176,11 +176,12 @@ psc@11900 {
 
 			/* ADS7845 touch screen controller */
 			ts@0 {
-				compatible = "ti,ads7846";
+				compatible = "ti,ads7845";
 				reg = <0x0>;
 				spi-max-frequency = <3000000>;
 				/* pen irq is GPIO25 */
-				interrupts = <78 0x8>;
+				interrupts = <78 IRQ_TYPE_LEVEL_LOW>;
+				pendown-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
 			};
 		};
 


The reason I'm asking is that I want to remove support for platform
data in ads7846 driver and pdm360ng is one of the last 3 users of it in
the kernel.

Thanks.

-- 
Dmitry

