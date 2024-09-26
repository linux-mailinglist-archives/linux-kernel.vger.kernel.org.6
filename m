Return-Path: <linux-kernel+bounces-340392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 946979872B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B2B1C22DC7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A8C18EFD0;
	Thu, 26 Sep 2024 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QntDWOam"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43EF171675;
	Thu, 26 Sep 2024 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727349487; cv=none; b=MH7qJG3z+TEY+vW8CpLu5wXqfAoFKtMJZ8biP8n+XuA8A0gd58gPgD/kX6pj72BEs4PMWcEbrl9N5gSWUljnqImCtdkNrz44oW/lgpspS6RNV2Ytdr+CkYHOxVgwUD/+l7oyV4JMZsKcpr6hc3NbztVafBmfvp6kk71DOcWixeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727349487; c=relaxed/simple;
	bh=Va9TLPbDkDpIMZW36nzPnHJ5cnNZE++54X9BH+sCIoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diGC1WXtaRIP07h0gc3MDaGFRbZs0PkUGJAx2cX1Qi2Reufl6US3+i9u7PXvZ4BTaqxeXdF6lP1svRYdAlO1SXzi9He4HWmdffC8Jevra90Df/o3IlI52IY/3aV0wJHYSxygnj266o9Z2avMQhtrU2DxTJmdxb1mc9j5OBwt5oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QntDWOam; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-84ea1e5e964so294170241.0;
        Thu, 26 Sep 2024 04:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727349484; x=1727954284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Va9TLPbDkDpIMZW36nzPnHJ5cnNZE++54X9BH+sCIoI=;
        b=QntDWOampSBuReBA2pRL8q+pOgCnXkv2CmUpZwkQJbSul3d1MzyQ01gIqW6VnyO3Qm
         gbsljX56p+cF2IsNHZAaPT7Jh2QYD5/RPHblZ3u9aHxGVTQJz1aIy7fO6/UUl7cHyk0E
         ZBqubbGSDdlfE/RIF3hUzPxrqLNFlY+WEgcSrsDCVeWTZfg2t+suj+3BRLuKRmaZ3hMt
         E62LwD361b2S2/HzgNVdfgWIFy1QDqlYwBNnMs2+l4MmWRV1G36MaYHvYHnaKzaP3NkJ
         EF60ErPegDclhrcoLv1Nt+BQxmbq4SCZDbQYNQU1de5Vvtcog6aHA4GmPTdp8KX1+DhG
         YAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727349484; x=1727954284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Va9TLPbDkDpIMZW36nzPnHJ5cnNZE++54X9BH+sCIoI=;
        b=Gto+Cz7bCl8qR/2JEmixYZ+saYdYl/b9D4/xY6qcN8HlStzoKigVVlZ6Kq7E6LAe5S
         0UCkaY0yPxmwDUYwLIDEDNGPnZBe1ew0kOJ4Dj20HUVZlZDzFFyrnaOW7v1MFj4KxMBZ
         kYajhzws527vKKiGJtuO/b4aLEqunho3+gzdY8fX3scxCiTa3EZGG3vf7vxooRF/x5Gg
         fiisU9y3gw0S7kyNQ0m4EHkCFrWny7vKR4lf+GUnUCfYgNVI1GM3fLu0Wvi4mKLj0ES6
         KMZZGkqn8EHtO4y3MqSzDcTGz7ZDuZWdKlQYtKRUS3aDVVrBDC3dR/LrmFAAvglAtQH8
         uC4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV08IXdO4k4gFm2AYMK323UQGxA6KDMDwrgHnEyM1DcZKFjORCsLu2WgGgf9bW+UsyS+/AhLmrBjmtk@vger.kernel.org, AJvYcCXfWnPxclZJeA2AuDbl4xG9XxNkxX5JG9brKE8XfvrgYvyiikEy0DDCA8unnxpCTDJU4Bu/HzGy6OVcXJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBxybA7x57ed0mF5QLBcBQhpOZz3bu6TomZc0EqXiyYHbjAVgN
	NDJyXw8tvUlIskZ2hq8xca5AvD51QJ6/sUv2ZCMA6M5w+V51iyRsM2Q1+45teJy+pOW8sPfp0Qr
	AkdK//9ga2RFre3bYkK7LUUVJFWU=
X-Google-Smtp-Source: AGHT+IEOmvguJqT35U5zy7I0t+U+ujuM7WdKorBYOvZNAcXgqarn0kPmdq01T3AhX/8/OzG1YjzeecAC08OQJnmAYB0=
X-Received: by 2002:a05:6122:a0e:b0:4f5:312a:6573 with SMTP id
 71dfb90a1353d-5074b77c4f8mr2127415e0c.5.1727349484616; Thu, 26 Sep 2024
 04:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926064910.17429-1-hubert.buczynski94@gmail.com> <47689c2e-505e-461c-88dd-d178a7fdd087@quicinc.com>
In-Reply-To: <47689c2e-505e-461c-88dd-d178a7fdd087@quicinc.com>
From: =?UTF-8?Q?Hubert_Buczy=C5=84ski?= <hubert.buczynski94@gmail.com>
Date: Thu, 26 Sep 2024 13:17:53 +0200
Message-ID: <CAJUMw3uOsSQfiPfn8iW-+TkbcsN21fpM0WNp_xy-6QJPktf4sg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: u_serial: fix null-ptr-deref in gs_start_io
To: Prashanth K <quic_prashk@quicinc.com>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"hubert.buczynski" <Hubert.Buczynski.ext@feig.de>
Content-Type: text/plain; charset="UTF-8"

> Commit ffd603f21423 ("usb: gadget: u_serial: Add null pointer check in
> gs_start_io") fixed this issue. Please try adding it into your builds.
>
> Regards,
> Prashanth K

Thanks for the quick response. Indeed, the commit ffd603f21423
("usb: gadget: u_serial: Add null pointer check in gs_start_io")
solves the problem. Sorry for not checking the newest version.

I wonder whether it should also be applied to the LTS v5.15.167.
The bug is still present there.

Best Regards
Hubert

