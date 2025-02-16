Return-Path: <linux-kernel+bounces-516818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B7EA377D4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954EF189195D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E1D1A5B8A;
	Sun, 16 Feb 2025 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFYRsAC8"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B991A3166;
	Sun, 16 Feb 2025 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739741887; cv=none; b=ggGNQFMCHAlmw4nILxtopJIzZS0nEzOcrPedQwp6D6nwPGpZ/IhkAx3o7nb/gNpD+T37dj/F3SzPjTvMMfebkugKxXRtVqZzotT5eDLv9dRmuhUaotF0N3igJp6J42h2sMkdPjWJGtnUehPt5eyyNMosDIwZeAUkwoxxkJ61X5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739741887; c=relaxed/simple;
	bh=IF6pVl4zQizxYn5QlEcFpICPjqhGa5hULzQnER5lP8w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=EmZRpPcNFECrHFtK4p//RUH8SPobgkIiPmNy6yqCSv8d20zC37P1i0TF7UCn9Gywvy3xC1sarfOetsJ/LwbqYin+0FZirhbsbng5NtYqKJ46d1SJSfqFgXRwYukDKPGsKaQzQc7UrcnzZ+xCw+2+PsWucNhklEDYf4H0nT/FFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFYRsAC8; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5dab3f3880so2829253276.0;
        Sun, 16 Feb 2025 13:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739741884; x=1740346684; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IF6pVl4zQizxYn5QlEcFpICPjqhGa5hULzQnER5lP8w=;
        b=gFYRsAC8EFh5UIDZvcMMohImVXa42fcFWtk7PzIQ92wjuBHdyZ5Eodw7ijkiX1wEMi
         KKle10DgNLi8iS4IWgTMnc+qoKLRtYzYG8ybDaaoBKOOSqxg0jPuXAm0ahmAswDA5lXO
         ljYYhCOf34/p2YNw/08Ne49t1923u79c7G+cgJJLZ/FF8N6VSXIrcBAyECkVtvyWSL4B
         Fauku3EARwLrTFuqX5DWKuD21RehiGhqJNdc48iwdUafoK36JyriuLrAB9ZrPCLrqDUB
         21qlnCgSMU6M1+KXQo1Kq5/1FvPE+bzYpkDbXsZyZeoepgU3Yuv+2V1wEe6lkrhD0ALK
         +ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739741884; x=1740346684;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IF6pVl4zQizxYn5QlEcFpICPjqhGa5hULzQnER5lP8w=;
        b=ecckih+5YoD3ICcPQqCZmxl0h1uh2D6m9hB6kmf3dyT3Bk4Gdw1Ek1vF2zPRPVR25Z
         tVyxfKm6pPxTmurrFHLUvVvj9DW9dUSAWqDeHjvyy7nnT5jfiXzoCafU93upPZn/QLjr
         dcDlIYq91u1iTaTCU6S9R9a3SIC50wlQ3NTWYwJlwekatwzHQNEgM3wpEdnWenZx0uat
         a44Wz3J1RRINBOw53UP7fMutNpr9MRfv5nKhjti+1h2YT/1s/5wlXp93n9AiZ7c/upWB
         h73tSPX7A4G5ioq3cLdSdgRTgh1UkKIiSflS1Q1K54zug9JmAZRS8ek4ShkrrttXQGKP
         yHxA==
X-Forwarded-Encrypted: i=1; AJvYcCVHNvhjMR5iO2ZtEAAR86L/o0IBgB4/gt3Mn6Xn88omYWGfNrToK+MRM0ssROeh7ymKhgHsVb7miMYPd74=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa3vH9CeE4lqyiwPuOIL5RmpFMoLWAEyobrHwhFdorBcvpsfZP
	uq8IlLX6MXc6bkED4iz22LRZAkqwt3RN+adbFAhX+y5ApoTGHPQn
X-Gm-Gg: ASbGncuCjAIgaLuPD7PKT0G3q3QAnXJtxx89AXieyG4SLDiOJESGTW/aVtlFH1vKsrt
	s8OK6+KStTeoZAarNyJcsziij9qmQJbMROO5QOvTxLzlXYCub6Qxk3xMWdYUArNwmQsP2g+o1rB
	Hp6zvFUgjGvN1TFQZvgPuf4W7P2Tojld0SwUcoHB4Y/CjGrlxnI9TWbePyLvOgqswqRr2IBh8v5
	QViNJyWoe+rr/qghW2wHG2UG5w+V5F6J6mvu//keN5QQeve6CxgzQAGS3mRoGe3T6nxdm0NUEpX
	NNezuN8=
X-Google-Smtp-Source: AGHT+IHvGesQUS9nPKj/egH0V2uzwj8cYBdhnXi3RNtWhGfhqO4tpeSImuJ28eXWm7fe38Ruh7Zi7Q==
X-Received: by 2002:a05:6902:160c:b0:e5b:1389:bbd4 with SMTP id 3f1490d57ef6-e5dc9043e20mr6179617276.17.1739741884596;
        Sun, 16 Feb 2025 13:38:04 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dae0da252sm2310431276.43.2025.02.16.13.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 13:38:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Feb 2025 16:38:01 -0500
Message-Id: <D7U70YVABPR6.SGRKVTITDNDI@gmail.com>
Subject: Re: [PATCH 10/10] platform/x86: alienware-wmi: Improve and update
 documentation
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: <platform-driver-x86@vger.kernel.org>, "Hans de Goede"
 <hdegoede@redhat.com>, <Dell.Client.Kernel@dell.com>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250208051614.10644-1-kuurtb@gmail.com>
 <20250208051614.10644-11-kuurtb@gmail.com>
 <b65ffe38-78a3-4d37-b1d1-366bc6870665@gmx.de>
 <D7U61KGOZE98.1M14RIIPBVFNC@gmail.com>
 <198a578f-99d6-4d98-8186-eab141a2550d@gmx.de>
In-Reply-To: <198a578f-99d6-4d98-8186-eab141a2550d@gmx.de>

On Sun Feb 16, 2025 at 4:29 PM -05, Armin Wolf wrote:
> Maybe you can use the "pwmX_auto_channels_temp" attribute to expose this =
information
> to userspace?

I like this approach.

>
> Anyway i attached the acpidump you requested. Sadly i cannot remember fro=
m which device
> i got it from.

Thanks!

Also thank you for reviewing this set :) I'll implement the changes and
send a new version by tomorrow.

>
> Thanks,
> Armin Wolf
>

