Return-Path: <linux-kernel+bounces-208092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A10902084
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCF1B2119C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723E67F470;
	Mon, 10 Jun 2024 11:39:55 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852117E11E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718019595; cv=none; b=kwrvgOKu4x7ZC5+eNGM4jKYWbyFx8rGn7raqi40JWPCMkEa98r9O9AwrMjtJMUm7MNc+S837Suw76gadAjeHGFLFeAyg86DFnTRzIc8AiSl5wcDVGS1BPn+XTV/FMqGceVnMFjKOrSvEj2JNqZiYLKwlwKtePKARDSgK8U3eGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718019595; c=relaxed/simple;
	bh=3t1zH8lWA6hAOLQwdM5tCL2gpZqqPqfReHV1J9dY840=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8mhCqe/aToTkLD7IgoaHZFfDKu21UZXXk06Zran66Xrk4EuvEdP2kK5oTBAhRA6AvLqdJVt+HPDlRA6PG6wYsfQC3sZepwbm2c4DpC9xl7+WMBd0rmTwxsRtAxHKLHViN6FTpWRrkUzhqJhyavIW7zRID2pG1ksnUO2I4MbUeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso6292182a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 04:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718019592; x=1718624392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fn34km5UaNBjNBAmsFz5GWZ1ooBH26HA5g5UuzpgHTQ=;
        b=UJYFQZ7mwSIP5M5n7O6AXh2nBcawkIGKGwpJDO8o+0R4kd8f52kNMzkyNPV6eOKQSn
         MG/JamZP8bUrwvRO6rWYkJUr2ncGOHMRK1blyM/Ao5MiWq/rL1FklUYmKni7WRs1wyE8
         K/f/eeVypyblxD130uiE0j3u1y5KoJ2Ujqiudv+qfhlDsKgIh/u4IDh/vkEXaUgdlSKd
         DrJ4Nk7OL68YalRcIO4twmAKm7Ttqc/BfULHUCLWmezYV9/XdrDFcHnccHhTK3+VXyCX
         Lj4+BYuS77sLjPIXngD5tYgy1hejKAsEd4NbTWSDZp7FML8KKAJrq0FPvJdN5AnGfjJM
         DPkA==
X-Forwarded-Encrypted: i=1; AJvYcCXkcEK9eCMV4dgfybzljwWrV49QeeHVc0yUFKm6Kwk5b49y1G4CdhX4Lv7iq3o/Xz2UY2chRF7PhSF52e3MKyp1G6N2a2qsAYGZraKw
X-Gm-Message-State: AOJu0Yy4cN/cxyqcDsRwHY9L2gwhYQLOSUTjd68wm7ARRGMhKD054O/V
	d0VO+pCUXsX8UEMAV97iutUCHIwYoW83zpkr5QUSqtz0I8KDGTY0
X-Google-Smtp-Source: AGHT+IHHWvddDK/61Te74ZGcqqgHF9vLhoVZLaoH5cZ5OA/L/jUM9+dBbMHQtYX9FsAphp1eTVGyKA==
X-Received: by 2002:a50:9b57:0:b0:57c:7f3a:6c81 with SMTP id 4fb4d7f45d1cf-57c7f3ac25amr1941107a12.8.1718019591640;
        Mon, 10 Jun 2024 04:39:51 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c8c1821bbsm632922a12.52.2024.06.10.04.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 04:39:51 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: morbidrsa@gmail.com,
	linux@treblig.org
Cc: Johannes Thumshirn <jth@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mcb: remove unused struct 'mcb_parse_priv'
Date: Mon, 10 Jun 2024 13:39:41 +0200
Message-ID: <171801953563.18763.5887920314358774645.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523204921.235746-1-linux@treblig.org>
References: <20240523204921.235746-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 23 May 2024 21:49:21 +0100, linux@treblig.org wrote:
> 'mcb_parse_priv' has been unused since the initial
> commit 3764e82e5150 ("drivers: Introduce MEN Chameleon Bus").
> 
> Remove it.
> 
> 

Applied, thanks!

[1/1] mcb: remove unused struct 'mcb_parse_priv'
      commit: 1789f119d54ad866fe8bb74657ebedd08b421f77

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>

