Return-Path: <linux-kernel+bounces-317308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3704996DC28
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21B81F2783D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0D319E7F8;
	Thu,  5 Sep 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhrGutpJ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D958FD528;
	Thu,  5 Sep 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547242; cv=none; b=JRWNj4rVGnH2i5kopxA37pbuZtZ1z0Pm6nYkronliBoZMFp4uUCLv9IYVSsc2JhZ1P3oUb7pI6EzBMYEmYe1/8fFo9S+SLMFIsW16BUOOVU6cU7BeKXwSRG027VCrNNXdSJ90WxWUKhMQhFC0DHSVoHGC2nschJelOzqZEXcvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547242; c=relaxed/simple;
	bh=BDdDoZl4AHdunDtnZ1j+D0WS6pyG58ZQ5yjOKLfNmFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNskmOb/VsSHpST1jiK3QPJFah812Y/Bzowpy6rUKe5uDMJv2nobtM/HvtE+4zb3mlEB6e2jEkxmGc2rzlN/+lQ2nqORA2Q6GDWESBQBmv0TzX/GbBEBPsbJzfX1f39uhry+AZNhJ09TPxeyWITcj3JZ7TzbNKWFTqc3XZ+LJ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhrGutpJ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-533521cd1c3so1126101e87.1;
        Thu, 05 Sep 2024 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725547239; x=1726152039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDdDoZl4AHdunDtnZ1j+D0WS6pyG58ZQ5yjOKLfNmFM=;
        b=NhrGutpJFZjGPTOYuBObU+KLjvjo+gSDi7JUleRcnHkCQpvbkKtxeI5xgVfjHSlDxO
         aG/3M4QnXmHrj681LozJ08aHQaKET5I9j/bFXv6LA4DYU/e8/IdQZQhQ/SJSWn21y5al
         c/3o4o6E+Z+8+CO2DQxUnY3MYIg1G7wrc3k190uhsjTL0gUCdwD3CDRduDM1uu0TgsoH
         3W27nMOcCuUhZKgBR6H6lgyXY1PnW3Kg074HLBtSLrdFK9bLnu8vS58Vq+hzrTYao7E7
         RgTlWwRYcLvZVXm7xkhpPLymZ5Sb3WDKD3CBvhYddCAWwqnWvHBupa5G6PTnhNnAYAr7
         I1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725547239; x=1726152039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDdDoZl4AHdunDtnZ1j+D0WS6pyG58ZQ5yjOKLfNmFM=;
        b=j5uAsydlaalsPLznIxwZJqxYhutPKF/5uwJANN/7IYW1BRo74H9jJLBj9YAp9fOhhE
         8S1Uw9tPXFYRdFLP3/oTspHhFNg5RmQfI5OlYKPePb2YN16jRKqsmbIIr2Id7fboJBcO
         J6SYwmovUCOZexy1L4lP5yyXdt1Vp4glnXrxRjgRaPE35k2ANMM0iDszOTNIR6jwSbDK
         D2C1+qFLfJEz1cO90n1MCHIGp6TsuoeO7dCUoLMMEftq1aTLFoOUnzBlP05EMCdvzNEp
         EU3UUkJwvYgJX3ukI8hh/DM3rL9BMVUHhjTIJzhUC+0Rp1/o2GvDIwLa+T7IKKlx8bfd
         W99g==
X-Forwarded-Encrypted: i=1; AJvYcCV0gymFs5j9dGmBc0t9DR3uy9djF010ZSUU9uykwjq5ced7QkcHL85H6WKtG5wx1VXMEip/WXklIy6oOLTh@vger.kernel.org, AJvYcCX9rJd5PnLXPHxBHqvKc2brrLSF1zNnAyz7isbTQsBZCkB6sulEW6tbNjsALhIDKY6tqDACHUOj3bZ8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mBV2+zxowFBvivJGoMAq+Z2RShZaUPsYEKLzFf3oVofHkQAz
	YJXy6X8x81Zw1RB+HSF2+900ue0lUVFFGropsjkQ9jvjpUeNivdKXYuovHs7owIoQ5qD7VJi93h
	1b1+9z/E5+G6HSMzYas3bPZ04yKA=
X-Google-Smtp-Source: AGHT+IGrlm2ln9ylu1HuPn482cMUOC7w/cXA84XslGGRasYCJjl4YVv0SyNzYmSygy8l9Glkzk7qlAzd4V/Al6Upcng=
X-Received: by 2002:a05:6512:6c4:b0:536:555d:11ed with SMTP id
 2adb3069b0e04-536555d129cmr743361e87.12.1725547238248; Thu, 05 Sep 2024
 07:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830085441.3589713-1-lukma@denx.de> <20240905143645.7946fb0e@wsk>
In-Reply-To: <20240905143645.7946fb0e@wsk>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 5 Sep 2024 11:40:26 -0300
Message-ID: <CAOMZO5D3y1_-_TX_a7zuYPxdRKGHGN7JFwWMNe_dtS6i0Rx2jw@mail.gmail.com>
Subject: Re: [PATCH v3] dts: nxp: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Thu, Sep 5, 2024 at 9:36=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wrot=
e:

> Fabio, do you have more comments for this patch set?

The new boards compatible strings must be documented in
Documentation/devicetree/bindings/arm/fsl.yaml.
Otherwise, many warnings as shown as per Rob's bot email.

