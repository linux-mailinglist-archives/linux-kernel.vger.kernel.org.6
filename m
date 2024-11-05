Return-Path: <linux-kernel+bounces-397146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2388F9BD750
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A149FB23174
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D804E215C5D;
	Tue,  5 Nov 2024 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REPp3Wbz"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A981D88DC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840333; cv=none; b=XO/xZViSLMzzIVFgGeNRNXsnGB/mpTxm/N7acPs+8fCiWlCeb7tgBIzAaWzK5WMgkWxz1MSepxTSga23YfMAVTvCaQOtkIE+2Wkie/HpME4vyE0HPDlAcRSkeV/Yc9tNk4U2kYq+Cp9onTPY8PThIjwvTaFi4vy46Dlzq5HcIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840333; c=relaxed/simple;
	bh=kTrZ23ZN/z/dNF0r5uBHslkTKc8atg+bkgoNPGdUYMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd5PScxC+kYnUhgVeRxch6nm8bGmsgE5aKftGO8l7sNxHS35jNLD/vLeqR/M5U2N1qImp2r03s1mkmHWF9zGoiXs3vOjE4/fCbrqsnz7Xpe7KTcCqDNHBxrIVkz1LKUIV7u2IJauG7exRwlJ01m6I9TxRinhlPoq3ojO9RSoEOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REPp3Wbz; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-50d57c109d5so1911854e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730840331; x=1731445131; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kTrZ23ZN/z/dNF0r5uBHslkTKc8atg+bkgoNPGdUYMo=;
        b=REPp3WbzsOZBk+shsjTpEN+bsf8xV3VFvatL+i9A3NexnRJ6+pdrAXqncKfIzLVSBu
         vhgc2PSeacAv9GH463aQWCV8vlZz7D0qGVW6UZkMAzUQAICtVqRSu67lH3g6VpZQZnC/
         zL3SSbGCWbodz/DPDP3Vcv0tye5vGj7Qul0HyPgAF+ilon9To05UgOeoZM3na7okolF0
         liiH8xkB4Hgw0XoM4a81VCXpJaET/i5rlt75JDskXOUVObTMHGF+uZRgjhhQtCI1xOPR
         XZZ2l9VpLQfF0xbqEh0bPRp7gupuWNckQ9hbEWqDh0BcYFFpYlC2UwXYayhGUNU7Jfyj
         ynxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730840331; x=1731445131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTrZ23ZN/z/dNF0r5uBHslkTKc8atg+bkgoNPGdUYMo=;
        b=Gdp03S6e4K7H1QFMonap5ux0Z5sqMUrPnbx5DFrenaXmeVs3LYqkqqqiV9JDdb1eaN
         9zgP/Z1s1ufhH6+vX9ZE4+01VVvRzvxjlP6NVQAnr/Y8zEGGvGWAbXP5r+0GwJMypcWt
         vgGkklzgt+qLRtlsstK16aOeJ0jGZ7aRvBHVGOPmDBBMnM4LRd8gCbAUYGTOOqYJMfzE
         bxR8xtCXkezG7nP8mvSRaTbKSJtHrhdZJ4JaN2ltuT/75Bn7sqU3ufLA6vlV3oNjHhep
         DPcnXAu2z5EJu1My5ApVKezK6ECb92eqHUAldlaI7TWzouqszntTal4z5aRV21as3g1W
         cVNA==
X-Forwarded-Encrypted: i=1; AJvYcCWnwB+rNl6lBmaYZ+m9H/OpjV0FOMttKZC51HAX0EpfQW51FO4gSPySTIyzKtp9pmNl4mkh+aEqcvl4h14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Gmyx/kDJ7ErYIxtH4p47tcN55CvVALiXOqMqgM9vCSPJ9zGV
	VFOpKrjj6N/Mz97jk2p+/OdrQLZp3DPWMue4ZtlCBotdY3UJlukQcc80oGWpFU4bcIFGr548SHa
	O0RasqMXwQly3oTJfQF4Fm2JCrJ8=
X-Google-Smtp-Source: AGHT+IFXnwefW07oXVzpuW4z07lz6ZhGUwzk3Eyj8AMF+h/Xo9djR6GAj2QVFEFzWKaTsqk8vNDVXI1nBnA7kkLoH1I=
X-Received: by 2002:a05:6122:659f:b0:50c:a762:8f95 with SMTP id
 71dfb90a1353d-51227346c6amr13981212e0c.10.1730840330681; Tue, 05 Nov 2024
 12:58:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102191436.23177-1-philipp.g.hortmann@gmail.com>
In-Reply-To: <20241102191436.23177-1-philipp.g.hortmann@gmail.com>
From: Sven Van Asbroeck <thesven73@gmail.com>
Date: Tue, 5 Nov 2024 15:58:39 -0500
Message-ID: <CAGngYiU=aP4FG_3R1f13n7u5o6L7S80HqnYbSTDCgK_NjgNCGQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: Delete unused driver
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Ricardo B . Marliere" <ricardo@marliere.net>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Ruan Jinjie <ruanjinjie@huawei.com>, 
	Zhu Wang <wangzhu9@huawei.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Deepak R Varma <drv@mailo.com>, Ajith P V <ajithpv.linux@gmail.com>, 
	Tian Tao <tiantao6@hisilicon.com>, Rikard Falkeborn <rikard.falkeborn@gmail.com>, 
	Ding Xiang <dingxiang@cmss.chinamobile.com>, Jing Xiangfeng <jingxiangfeng@huawei.com>, 
	Cristiane Naves <cristianenavescardoso09@gmail.com>, YueHaibing <yuehaibing@huawei.com>, 
	Oscar Gomez Fuente <oscargomezf@gmail.com>, Nicholas Mc Guire <hofrat@osadl.org>
Content-Type: text/plain; charset="UTF-8"

This is no longer part of any working product that I know of, so:

Acked-by: Sven Van Asbroeck <TheSven73@gmail.com>

