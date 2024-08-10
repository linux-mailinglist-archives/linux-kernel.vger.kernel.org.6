Return-Path: <linux-kernel+bounces-281659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA7694D992
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 02:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8BE283756
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADBD1B969;
	Sat, 10 Aug 2024 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="OB+JvSWk"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA8624
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723250086; cv=none; b=DTf2JSX2gs4j0GfST6r7WGCAyaIfBQ7Vp9DP8DI3z7Dc+n50RY/+mWViG+Y1LcFyCfUDpHjQLxZkFMzxDTREWGKVxW48wPIJoT1NFH5FDlBLRgpPTK33fnn1iK0UDcrcP0ZTpC7iI8WKcP91X6sWOc044YwZF/TjYox0UsGCEzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723250086; c=relaxed/simple;
	bh=oSHrVPTVyklLnpD7FP4CqUxmFTVvNZMZ/lHd7SK2dfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=L9PEy0kQcU9IJE9sNLf+V9SKiJet0eiWsgaB1AmJeTS8BAjb8ddS1nomIVnwSUZ2mwpFtFZmyle2+9cyBA6KzaWr2Bo3LCEudToXkxKqBB12iQohG2iSK69YDz/eKbVR6A7FdFDtGrSqUM+peMxMMX9lV0iKBlJ7rN/8OuHL59M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=OB+JvSWk; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b797a2384cso13973216d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 17:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1723250084; x=1723854884; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oSHrVPTVyklLnpD7FP4CqUxmFTVvNZMZ/lHd7SK2dfo=;
        b=OB+JvSWkbGl+7y+bxnsBCntJJ9Wbjvp9rYcVjn5VetFDv/2sUrtT7fEqVlc1F6QyqF
         PM4d5Ggy+h4iPRJld6IVMw0psZfiNmMHZyfTbiOSHif32pIBuoqgRj108jgzI9frXWM/
         kg7JgQ4uRMwjQ5g1tTVS1SwBKzIMn+44DUkNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723250084; x=1723854884;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSHrVPTVyklLnpD7FP4CqUxmFTVvNZMZ/lHd7SK2dfo=;
        b=WqkR1gHmU9kBoogN/2dMpfGRTAymLrBQ1BDUNyks2MiNH/unKkyqEUalBgy1bLkb+3
         1BBfprpVCkh0cag67nFnc+q1cXbFhzylQ8RTiYKx+PWMTC38/HxpxTm53W2al4s87gUE
         q3F4+EqCQt7lDSA/RdWmwUA1MA1HALVz/xReiqlmZYeYF5F0OsCkmQy0GZiH7P3iO95o
         GyILkJypFvPGBqXrrDBmOneCj3S8f7dfEdDPA/k0zxykB4BUCXgXGFR3CVwFRZCJR5rs
         0dXZrBLxkTPnmHwQNIP8B0/zSwpjpzhhXRYcAeVXmYlGgA+bRjXoi9dP+zhSjGexKwys
         QDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfmWCSvB4ocZnQYjjQNzRGrTxeGp33O+wfgRfkNrvG+IlgdVg5TvoIolZxcVL+Z9kl0TaNhxVPxXSGRhF/BRypqZkldsWm1IBVlalr
X-Gm-Message-State: AOJu0Yy/SnF2r0cZq9PTSBaNBWGYQct+/XekDcKkK5tVF56ABYySX0lF
	af3oCQfGF6Kj+zoGpUxGbxD7uD16sV5wGr1ssHq1+MZAp816p149ywSVLYRIp/9SzBxg1kG+mYQ
	k
X-Google-Smtp-Source: AGHT+IGLYIiSBYXL7L13kFVDwOYWS4+0ru5AwylZmzY3NHi4+KAgDtksYaNenf3nZLTIuGRZOXWeqA==
X-Received: by 2002:a05:6214:440d:b0:6b7:a3f1:3251 with SMTP id 6a1803df08f44-6bd78f079e2mr35735196d6.51.1723250083657;
        Fri, 09 Aug 2024 17:34:43 -0700 (PDT)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e54586sm2703456d6.109.2024.08.09.17.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 17:34:42 -0700 (PDT)
From: Ivor Wanders <ivor@iwanders.net>
To: konradybcio@kernel.org
Cc: hdegoede@redhat.com,
	ivor@iwanders.net,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luzmaximilian@gmail.com
Subject: Re: [PATCH v2] hwmon: Add thermal sensor driver for Surface Aggregator Module
Date: Fri,  9 Aug 2024 20:34:35 -0400
Message-Id: <20240810003435.10539-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <6027d9db-b1a8-4eb0-a0b7-451f1524834c@kernel.org>
References: <6027d9db-b1a8-4eb0-a0b7-451f1524834c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> Gave it a shot on SL7, some names are repeated and one sensor is totally busted

Interesting, thanks for testing. I'm not sure if this is the right place for discussing this, or
whether we should take this to the downstream thread (link in cover letter or in [2]).

I have duplicates for RTS{1..3} as well, so you're not alone there, for me it's also sensor 1 and 9
forming a duplicated name pair [1], this makes me wonder if the names are always of the form
`I_RTS#` where # is (id % 8 + 1), if that is the case for all surface models the names may not be
that much of a value add?

The surface diagnostics tool actually doesn't request these names: it has hardcoded names for just
three sensor ids that are part of the diagnostics [2], but I don't know if those three id's are
stable across the various devices though.

~Ivor

[1]: https://github.com/linux-surface/surface-aggregator-module/pull/68#issue-2054614428
[2]: https://github.com/linux-surface/surface-aggregator-module/issues/59#issuecomment-1974827016

