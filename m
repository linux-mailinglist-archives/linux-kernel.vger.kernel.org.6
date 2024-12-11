Return-Path: <linux-kernel+bounces-440545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8432B9EC09D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1E1169534
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAF0125B9;
	Wed, 11 Dec 2024 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0lGhSeCB"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7375B65C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876407; cv=none; b=MUlbzdAUrvutAH/uLW0EkdXKpHFxhMfwPukalfRAWTcldja/DBM1AI2l9iLUe2gZmfth+3UDhIG1dmIMdvHonlzTYVW0J2etp0Z5YuDEuimm1covcQe8odXuAfA05DyWLZ7fGNn7KtGqSqK/kk7JqjfNh2klcHX68zBjSRJ8X7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876407; c=relaxed/simple;
	bh=FJNDkRivl5n3c3f0lOliUISNZyJAuRgGaTVNaOSMOMc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FhdiMX2O5SJwIq3efcUl5U9E18ZzFZP2M+j0UWpOWIE/7KOduOBks4mzWLYqb2Qk4aMFpi9gcPDpusRQ51nib3LT9aIFUZQyzRerAYnber9MRA/twwLTbdidpGb6aDi08UeIw4d/WSY87AHVMeAcLx45qh+MOYn8NiCOBpCUP3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0lGhSeCB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21619108a6bso35339945ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733876405; x=1734481205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRC9yEkE9g7vVhAefcxCRjeWRe/ODE9AB6GWqjMTtzM=;
        b=0lGhSeCBL1rZ1VXzTQyVZl+BJk5Is6MUziDctBUR2/Dpf7XQLAHunh70K3Ho7A6ROR
         R2QlhgxkRbkV6+FMCzvESc92QC8S1R55jgyMV8BkZiqgdq4KdTMFFGsRzpCJZ6G5SGWh
         TcaqwWK1DEXMignO5Zm7FI2P/0iz3M8auXZ9YL53R30HYrylr5lD5sRVX7cCeUgo4JiW
         L6Sf2Sodfe0NQtquFBFaxrAYQdTyuit58iPn3EyvtFb1ShQ+ZHGYsUViIwgJuEZz17U7
         4R2CyDIFjOfA6UAgpXrAzNPKbquDPbFWTpE7IjNmD/lWUXo7q5x31m8/D28JPwjmyUv6
         NpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733876405; x=1734481205;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRC9yEkE9g7vVhAefcxCRjeWRe/ODE9AB6GWqjMTtzM=;
        b=uuBKN6PbNSri/HhSQVgivF3927uKVSQQzAJq7qg4z6QwgrDxnv1CZBhCZSqw84HiOZ
         lIfT235zvfC8pq8sPer3irhtVmaqUrUPh5OTjm5j+3OggWiYXN2HI0bREkgAS4pocQMr
         ZgWbUpT7Cp3fbW3N1TP00zMuPVojjRmT8rNWd6HJAVlg5RdVcb4pIKo2D3O5rAzfhMda
         BJ4SrR8SFjnVjjYS3Fi1eJStvpCnDolMxbBWJ2gGlbXHsFphc1WHg+CKxJdkoGwwIfdu
         bCPFlfQbS+5L5IsaFM90OFgVn/mW2ncS6T3rjqicBC/4alz6r8Z77FIKlZHrbDzBBgiE
         kaaA==
X-Forwarded-Encrypted: i=1; AJvYcCWzdTCAhF5CkPzZg+eKvJduYV44ZNszYqieGhYPUcMSM/z2yb/T2ZA4YM6V809Xnvebl6Iu43587capoBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNxUlvTDrw/ae+ZKqWGHbqm8Y/JfdQHyBtrO4W/WugNUDgEmAR
	kXQTSooC0YiEtXOOhIsAOvfiIo2xr/ROucIxiqP3LN9AM8a2DgxbK+usz0Rat9U=
X-Gm-Gg: ASbGnctgTxx6XaAzDtvxuLPlEy1/xXRUKcRWcvrBCmOidxRTZlqguXMp6BzgSOczSAY
	GCkHtXZShb7LZcs472atDAHKpeqFSu45S6Mc+lV6jbfBO6XlzeJFQNNKiV2l9T94UXmHV8Le5Z9
	wuOmGAD95zUL7ARLSK3pIZlUPgIGBpgJ+x91WpMLX6V5jAb5fMcOUDJ8bL35rv0xiCU1rKb7Rvb
	71KcAHeCNjbMBEBOn98OtCS4Rz7CiYzQLDyY0JVgsDW6yEtAGlx
X-Google-Smtp-Source: AGHT+IFmcRdR0HCB2a3gaNUahUkUF+BtT/p6ITp1NBqQs83IckQiXsxBMl0idj1mc28sf0T45oP52Q==
X-Received: by 2002:a17:902:db0b:b0:212:6187:6a76 with SMTP id d9443c01a7336-2177851fac3mr15669435ad.14.1733876405035;
        Tue, 10 Dec 2024 16:20:05 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216364e471asm54499955ad.92.2024.12.10.16.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 16:20:04 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Andreas Kemnade <andreas@kemnade.info>, Tony Lindgren <tony@atomide.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 akemnade@kernel.org
In-Reply-To: <20241205204413.2466775-1-akemnade@kernel.org>
References: <20241205204413.2466775-1-akemnade@kernel.org>
Subject: Re: [PATCH RESEND 0/2] ARM: ti/omap: gta04: properly specify GTA04
 touchscreen properties
Message-Id: <173387640426.1968502.1994971041924318982.b4-ty@baylibre.com>
Date: Tue, 10 Dec 2024 16:20:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8


On Thu, 05 Dec 2024 21:44:11 +0100, akemnade@kernel.org wrote:
> From: Andreas Kemnade <akemnade@kernel.org>
> 
> Specify touchscreen in a way that no userspace configuration is needed.
> 
> Note: if the devicetree patch is in without the input patch, things
> will be broken in a different way.
> 
> [...]

Applied, thanks!

[1/2] Input: tsc2007 - accept standard properties
      commit: 6ef4ea3c944b9fc5d78317d1172cdcd10f9724f1
[2/2] ARM: dts: ti/omap: omap3-gta04: use proper touchscreen properties
      commit: 77f40f1983c40f6dba0a5eef125a037498de8268

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


