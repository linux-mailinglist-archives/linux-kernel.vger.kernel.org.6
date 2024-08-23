Return-Path: <linux-kernel+bounces-298167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7946A95C350
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 04:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3581C224AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A0C381BE;
	Fri, 23 Aug 2024 02:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2XUVEQG"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3AD36AEC;
	Fri, 23 Aug 2024 02:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724380440; cv=none; b=DGgY0EwbcQ03uZrtyMGWk3jpDYJ+MWezLT/OVqCGOwFOdplwCRbLeFANydbN4culVfs5OoTuT33b1RDbmZ+heE8iENxm+linR/2FXKyjFCNqDfwY+AmxoOK2Klz8oY9r6Fa6K+rnRTOHoye3FdHTf0jhqda7f74FDv2Rr0O/d3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724380440; c=relaxed/simple;
	bh=0drhQ3ovFRKNzIjwdaG614SuVDwFNryZz/8uyTNn6cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmZAaxL8WdUk43cRyURdiCaSJt4GQAF1eoGJc8a0cgSSgE3M2Oy1T6x8BvfaNlQ9BjLIgqK/5ZBwDMcT4dccgXgdpedqtD52B9CsFoiBP0WwdzNIgCRvbm8n4FJlKGAQOTAmI5H0jV0wSvPSqZsLE6CWhJLzEFL36dxQ8yxkGic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2XUVEQG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5334fdabefbso1235872e87.1;
        Thu, 22 Aug 2024 19:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724380437; x=1724985237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrIprG6+971o247HqoCovPo3X7CWv5qYe+EIwKsAYaM=;
        b=H2XUVEQGtWdEv0fmdNy0zi4IjcKl3dhNjiuQqH0mwKP+sPqMegWwBprh1vTSHm/NSM
         x0g7JlGHlyooft9TUQeurEWvEdPhZtFcsuHxqMN7+HAmVb2IKr+BbGxJyh91lM0vqrDw
         kCsDCF7X3Z60y9l6NhSdkv9QPPu0AdaYBIsSMzUU7tQy6Rg8Nx5BYmLgVcdbuKQ+7H8H
         uIeavHpXRBSEbYE4ymAHO1PljCDYu062ZMFDU2f6YmNLruyyqjvmZL2iseNTBvjx9dZv
         LRbPA2TE93IufqMuTXEmAfQp5j86kdH4hOg8SHjQpbOcXXd1gAsBglT/EuXhDeUbDUuL
         KCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724380437; x=1724985237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrIprG6+971o247HqoCovPo3X7CWv5qYe+EIwKsAYaM=;
        b=MQ6Vo8yuVB3rv/54L8CJqhgl7IkYWE6+vPccUcPoTGSmT3lfoHLZ8LEjMYS8WyZlGH
         yYytHsMZ+aCFyEaSOSJX2ks+z+9eKcY2QkQLXaGpdAOcVmD7dfkFz9SiTTsSmkAdjjjw
         58HK4E3Lv+wNau7twRSjQv4IRU7rwvYYFKlt/p56WXNo0RHfK1ipew7/5rsFKHqK5TVv
         +SgQ+DpUiNfXvtEbSkHgkWRFvUqqQWmlyt31TEtxuFMgMthnjL5ZjPk5Zg7QhWVWleJw
         itd5MPNwnIclLiJT7R1ryn0PTXaO71b41yX1lIUZPJdHkxSOJqCzTsghl/sU+xYw5rdK
         1/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXP0y/SxVsEjhZw/YfgCNb5buH3cpVDO5hdIZBrp1sxSCViHl3YE7tNOOrhqyh1kaRCoZYgt3Z03RMBGQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0XmIXcB98uZlxjCQFrEjBQ4dKdimcVZgCdNXaJXVT4Dcd2fKv
	TVOX3xRZEMNi90zg5cxQw5nr9M+FzFXXmjfBafBMcMPBrBLinnNVWQazBsoVkDIryHNXkESQ1tX
	vgkPnyRa4jJ+p5xgOhSEo7ioHD14eWw==
X-Google-Smtp-Source: AGHT+IHYduY6Bb01ov6m1nK+wYU1FRksz0uASiRqqi5faWdM3/F/fu+SSoDtEhkO06XirtE29Ltt+Ug34PCTBcV3qz8=
X-Received: by 2002:a05:6512:e96:b0:52e:fa78:63c0 with SMTP id
 2adb3069b0e04-5334ca84c6fmr1701817e87.13.1724380436483; Thu, 22 Aug 2024
 19:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823021257.1067054-1-victor.liu@nxp.com>
In-Reply-To: <20240823021257.1067054-1-victor.liu@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Aug 2024 23:33:45 -0300
Message-ID: <CAOMZO5AN=yx5RSkVuMrym1QF7s622gm8+Qnf09r9mgZKr5sypQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mp-evk: Add native HDMI output
To: Liu Ying <victor.liu@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, 
	alexander.stein@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 11:12=E2=80=AFPM Liu Ying <victor.liu@nxp.com> wrot=
e:

> +       ports {
> +               port@1 {

@1 without reg =3D <1>; will cause a warning.

