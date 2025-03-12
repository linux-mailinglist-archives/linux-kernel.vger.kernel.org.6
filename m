Return-Path: <linux-kernel+bounces-557410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E90A5D890
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9625A189D52D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ACA235368;
	Wed, 12 Mar 2025 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcZ09nNM"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8CE156F3C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769227; cv=none; b=hkad0abEq7nc0rz9WsucbT0Ccsd1bi9i6a6ZF9bCKVmsp/zPwDPQ/5MbQJpDAesJmUtxawsTuoKJ1wCCO2oqdetO7NRyGByatWWh+kTeeaEXgmLlynluRRelvWmAGwB3V/XoJNWRR45eRxBq5f++U26k59PUat1qdvb00o0/tsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769227; c=relaxed/simple;
	bh=cboWh7VbAPzsBQYxskHVNAVDvc1UvB0tBOUhT10tT7k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=d0Pe1qCMRhxVW2Xb1FdlenK6aJT3Q7pfJ0ReH23+4x318CXCj9dVfU+lByqNGt4AQzmaAKx6sOiai6y+ZKvWhE2/hybitt+DR+jg60GZmPxt6Xj+tgmGeXdSv7DjltewLBCQJTaaTYky/yTOXhVlCvRGVvh/TfBTN/3C1RBjJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcZ09nNM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so187949466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 01:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741769224; x=1742374024; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cboWh7VbAPzsBQYxskHVNAVDvc1UvB0tBOUhT10tT7k=;
        b=YcZ09nNMyG9STYmBclGCdrJB6bwR+r3I8IBF8SM6RS16A4DknnvQGzVo5WRzsgzM61
         VmrBU4XUFIuNS+Veela1Bp/gnEiTc6ORyFXjuc1hsPRQuUEsjRb+LDf6zkURVYLgihh/
         i1eMp2LS0Sn050y/ANTfTfZdYQXxCFz+rH7ycKI/V/YSgtXbY/5EQRzQWdPUM4lJxfJn
         JP/61sZSU+cfWFm5X1Y9c28LBUERl4Q9zJfvTrMKxWq48vOU33ZXCyDf2eI0qCxT27L5
         lvvsmPtXFO50pRozRsMB1lwbzJ1Zjgefw1TGf09kFb0dTxDVjbl4wLaFnuzNxEIdsRvZ
         UYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741769224; x=1742374024;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cboWh7VbAPzsBQYxskHVNAVDvc1UvB0tBOUhT10tT7k=;
        b=PpM2nvNiED68GYEmpKXACZiNPkNXl22tMAhy/QWw8H0a4jE5fy6b9TrU4Sn2hJm062
         4xyorRN+y0j9OqYZd+g8j8VN7LnC4eBEqa/0J9ayRD7DU9oe4efX0oWv80Zt7ANTeT7h
         OM2cCi+fxdauKjgc/l2dkMepPNoCqTPFDLECnX/TcewfjgKhENyjzlnmENMhf8BPr3NZ
         E3nebhiEkva1CRfaPfOi/3OI1kJFLBOfHiduqQQQ2ggUKTucpbKohXB1hyn7ocKyz/5K
         VAyxtyzAlXc6Y52VPRjymkwgLwWtCWFxvWBkSgFi3ntBadRU/3StLqH/KrMFaDzGlfXP
         teJg==
X-Forwarded-Encrypted: i=1; AJvYcCUKlLeY3AxBhsHSwPx/sNKl1F2VPSedhQQt81Zfmcf+72RGu012YhbyCLBqG361k4qJnw+MIYsctseuQsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylRfZSCRPhu7IO0x36eP8A3PLljkLKw7HeazwoEeL6w0Efuh9V
	PAedzjQCoOA3zDgC0dY6dIA0Ca8P3YMKWbBoo5fdMcXwmMSICU+D
X-Gm-Gg: ASbGncvs0UmSWWBtvxwvA7QlmZrRGc/IQxtYaFy509tKKSn/1pGt7aV8h7S+OdJu8yW
	MCt5ZzYVhRXutJXQR5RK7kzXN8gH9dpJAxY4qqjaSq3J90yric3BwgDNIIToxFYJemeYt2nAyhj
	ZbVnV5i6o7esBS6EQ1lzdin+uRFhhE2CqmKYTVlm4L+Cd/RZAgrPl7sIFVHT/CpsmooYBvNpCDG
	2Qm1TM8d7v0fuhfPDra638M3pOR6w8vwbtVNL6EmdxWjGuU9FZSqUgjzlU9BRHoMQRvSI8awkX3
	R9ThFGsjbtGM1NbJIqjSuVDHjmmNiIr2itEkrNeoYUoNzzEzK3Cg5Aiypq4vkqXPnNeR8b95tSx
	RSIgDN44cEDngQba49jHmSKQ0JA==
X-Google-Smtp-Source: AGHT+IEAytC6C4YIEA0wGggBQ8yJVqTmWPsicgMCpcYRy5dK3ShRtq/kfhiIN8zCf2YzKqtUcKA+Bg==
X-Received: by 2002:a17:907:97ca:b0:abf:5fa3:cf94 with SMTP id a640c23a62f3a-ac25263c78bmr366389066b.22.1741769223745;
        Wed, 12 Mar 2025 01:47:03 -0700 (PDT)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2865fd7fasm609864366b.29.2025.03.12.01.47.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Mar 2025 01:47:03 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] drm/rockchip: vop2: Fix interface enable/mux setting of
 DP1 on rk3588
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20250312064218.524143-1-andyshrk@163.com>
Date: Wed, 12 Mar 2025 09:46:51 +0100
Cc: heiko@sntech.de,
 hjc@rock-chips.com,
 dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Andy Yan <andy.yan@rock-chips.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <695656A7-BF2A-4031-A9BE-659C27F311DE@gmail.com>
References: <20250312064218.524143-1-andyshrk@163.com>
To: Andy Yan <andyshrk@163.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Andy Yan <andyshrk@163.com> w dniu =
12 mar 2025, o godz. 07:42:
>=20
> copy-paste error, which affects DP1 usage


Andy,

Great finding.
Now i see nice screen on rock5itx on dpi1 out :-)

With this: my users are politely asking: when we wili have audio (and =
cec) support on dpi1?=20



