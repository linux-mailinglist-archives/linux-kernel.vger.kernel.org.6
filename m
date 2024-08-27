Return-Path: <linux-kernel+bounces-303254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E21A9609BD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D73E284575
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932C31A08DF;
	Tue, 27 Aug 2024 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1n5fPse"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4B1A072B;
	Tue, 27 Aug 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760649; cv=none; b=aT/3XooHt60Y0Qd9Gykp+0brn58OnCfQ0G+EtZKio7umbL7uLJMG5W5Ud4XBACClkeI+KPRU8KH7q9thRAhcuxv7juDRCdQ8GvpfSeDhwXUDnPXSbb0G9VvWLzDtucbViR8ZZ7DXPp5v1poM8AH1ren/AVjRgBpC0sDEWznRfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760649; c=relaxed/simple;
	bh=AQQY0+eCtpauFdwfMB/DPq7vz6WsH8SVHCLuIW7R2r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaR8+bmE1Bi9iIKZ3iA3DdeM1JaqKLqZrV5n9ni89lyh+yELTrHoEKevB/xefL+leyJyt/Xbw5HDpI3CyQkpapP31rOCsv0ysEhICS+ZEkVmjdTjQ+ZJDr5NXE+fMdzq5NETYAJSAW1v7/noPm7M/UyztKAKq/8AtCAccJMj+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1n5fPse; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-533488ffaf7so7273574e87.0;
        Tue, 27 Aug 2024 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724760646; x=1725365446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocWvo9DzoExmIHq9UIiaFosa4hw3n9psCH8ZfRs9xow=;
        b=l1n5fPseKKnSQT/zheLDx/TUHIq5vDPpdOVeC4o3ABvDqb3PBJMH22aBKOfA67k2Y4
         Vy+1I44OuelJ+6T5xFPYqN0uazVBYM4bQxBfvbWc0xFRvySuhoyqxFtgYm9tdU7EI/1z
         +bmHTOHE7aBvHZnEyedsz9trOW1KpYyx9KVzZ2v7m7m9im0hXZZDZF5qK/m9BPnBGFrz
         xsb8RAiphKDMYD2PyX0TmRV2NJQY+0ST/QIc8GLYQzALz4UIJFlDRd9q4AufMY/E9dip
         m2nLYTRgRn61HEGbj9AdTOg4wWO7mzbss9g0RoCGiYb5Ilmz8r+oGOgTOXCWPUk0ATmE
         5g4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760646; x=1725365446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocWvo9DzoExmIHq9UIiaFosa4hw3n9psCH8ZfRs9xow=;
        b=saadsdgmMXohMYlZYw/S8X2ZCIXMLuxqAIf1NBuT8R+6M6a40qDA0mYA6rwayQoo5q
         hx21DuwqSZVeOwqHKkpJ+8Ta/EtNdPoRIOEuLrPIumj+0lXcJX+4QDSsbxJHd8kZssfd
         q3Zrn4lmPUGSNIyKp1eXENst3eLUwFGuYH+sUduP1p5LgK+gJbawXpLVLB0broMOrBwm
         KV8yAMJJYkferz20PC5Pa+31o3zBo9Q3zTsh1V9WXOLulqOyDlxCZ6OSvyXMHGq945TP
         8x6yg32rBWTaa/Ff48LeRxQNDdXb9Y7nlQ6//Wb861OCh62Y2IIrJ0WYVfQjaODUlNm+
         EY/A==
X-Forwarded-Encrypted: i=1; AJvYcCUkLYBZsLbd6pP7VGmlcwO89Cqumhmpi0KIOW2VK3bcXk3JCbrYeHqlvPDak7XwaNf5DyoHUJh8+aPX@vger.kernel.org, AJvYcCXxommqoh0jBdAMmPTacA0BbylgmR85G5WptzJN9YpFqk03GS4iwSGOYOsL8b3pm6tcRnzjjFAR5DAJkroi@vger.kernel.org
X-Gm-Message-State: AOJu0YyEecIZ191SVI5V2395lt0NpUYNtBBCoKovrCgjz6TEy+4JT+dp
	Ek6Cdr6kn9UEmhNcM999p46jhm2/0MmrDYdjanWjbbUwp2SZ1j5Vn6DTy4YaIOIQsUCsAZ+u999
	Susr5DLCn2MToyd/FYP8w6uQVq9M=
X-Google-Smtp-Source: AGHT+IEh5psS72JM5hvNRaxVWHrg402o8pnzLlLRh3KcneC/lRx90ichG0VNgnlvvr66dtMljeyh19iUph+sTp2ULkA=
X-Received: by 2002:a05:6512:6d2:b0:530:b871:eb9a with SMTP id
 2adb3069b0e04-5344e4faf07mr1737573e87.47.1724760646028; Tue, 27 Aug 2024
 05:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823120158.19294-1-tarang.raval@siliconsignals.io>
 <20240823-demonic-jolly-chital-fb4d61-mkl@pengutronix.de> <PN3P287MB1829E68257FC17F8ADA725028B942@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <PN3P287MB1829E68257FC17F8ADA725028B942@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Aug 2024 09:10:34 -0300
Message-ID: <CAOMZO5BUrJBo5+bEyBA3i7q9Kb0HXgRwu8J-kV9JbDMFcx-WGg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals Support
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tarang,

On Tue, Aug 27, 2024 at 8:16=E2=80=AFAM Tarang Raval
<tarang.raval@siliconsignals.io> wrote:

> [    8.639860] fec 30be0000.ethernet eth0: Unable to connect to phy
> [    8.708452] fec 30be0000.ethernet eth0: Unable to connect to phy

What about this network issue?

