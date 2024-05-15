Return-Path: <linux-kernel+bounces-180117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5890E8C6A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE251F233B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C7E15624B;
	Wed, 15 May 2024 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K5Ctx+8x"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC30155A26
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789511; cv=none; b=f/bZO+MGef4kLSbQaRdazLfyHDs2sODCU+9m3s0UANW5f3PzVfTwBJ45DkFZyYC6QcfVyl1UqyeaQDw0hbkdmYxzSnQeBII70m1SW+/+YzoWj7GrcVzC3dZF4KlxE1VxqSTCGlZkNqrUOvky5w21JN+LLIAEacrSSMvIGIVTo0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789511; c=relaxed/simple;
	bh=VyPo9EZPTWGia1hDWfa6Ul+IiF/Q/cUsbeyb7RAuis8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=mOjH6MmIwUnguXm1Dgx0lNQnF2vgRL+HWzAAt7gwruSPaIrV7kjUR2LqXTWtbp6Im0lARtryyntZ100TILCc4O1gZjz5jN5O8OmikS6Q8YipwuNgijBdiWy8qFIYafDlCXPrAgNc6OpJisElWYv9mMJeBZ5c7nyQ+qyStMl4bGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K5Ctx+8x; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e0a34b2899so106503491fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715789507; x=1716394307; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyPo9EZPTWGia1hDWfa6Ul+IiF/Q/cUsbeyb7RAuis8=;
        b=K5Ctx+8x4uvQ2QwXesTElorxXh6gOyfLi5lEemyUsuE/NIgjfcJjTUvFPOA8INWbcM
         TVeR2VZYNayfpJFGXHqH2eLYg5bNJbvw2dr6GFniXH8T5Z9o5mo44i6vetOIPA+PIe1+
         3CQP3vkXu46p35nxxa1umRBTnZ5+XbCpCg94Lz5mWKWsIs/23ZW9qy+ApeUpRQgxOTaJ
         DQcHl5+/WCZ6b/4CtHl41SjkQ8OCy3HpiR07h3dEQ0JET8snLv5J//TsPNPNySymJ0A0
         fv2qXBoRtax4M2duMRzx7cRpMQjTjVRT5T1liTDfKuciS3IYC8udHw6Hjd+dr4sY14qM
         R9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715789507; x=1716394307;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VyPo9EZPTWGia1hDWfa6Ul+IiF/Q/cUsbeyb7RAuis8=;
        b=ucqYqPtoJ8a3joNsFr9IajV6+aV6mvsAYfxqlM/lR8+wYfYHaeklPSj3+xCNW7benS
         T+LWO2VYGGJ/o7e6T01owT0IRntL4hNB2c12/84mgNXmRendK49FKv7d2LPSZFqyEUOZ
         JJY1mLaQokDj9LMjfwwaDFoir/eWu+AJT55dj/M81vNrByavP3peb5rcLPtXoIc3XfOt
         DayrTkjqibfH2ryGAgZ9x8yCEtVIvY+BbwfveZjll3SDah+SECXcpz4TvIaJ75qF06VI
         RMCgSkD37Fyj1Fb5EsXF8rQL7ogz8DsA3jp+OFF7vmE9QXtgnJpKzdM/YzBSD8AaisbA
         FemA==
X-Forwarded-Encrypted: i=1; AJvYcCUo895F0vCSwDQY2Rr3IIzDXpOdCQcbSbzNEnyzIBnmBMccVRMGxCS/O2WcRjLYXzrzvLCQN/jzASOf1yF5suMAGb73x0V3BhIsTN5I
X-Gm-Message-State: AOJu0YxILCMcL8DSIpS+jQZc8GhfAXXJvLpCzbAUICNW204r4U9OYYrE
	oeKyEjfBUZkRuH2rH0E+ePu5HBSJdZjyMogDkty2wG3pADV5QZ4nCX58fN1f70o=
X-Google-Smtp-Source: AGHT+IEj/uLKh1PeNOsv2M6njD+iG6o754ZO04BrFMM5ikkzxMn6kpsym7eV05B7aFuyIhLBxeAXKA==
X-Received: by 2002:a2e:7c0d:0:b0:2e3:7121:aba6 with SMTP id 38308e7fff4ca-2e5205c61a3mr134524761fa.46.1715789506504;
        Wed, 15 May 2024 09:11:46 -0700 (PDT)
Received: from localhost ([2a01:e0a:448:76e0:599c:db2f:fac4:6e1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201088fe8csm157460515e9.32.2024.05.15.09.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 09:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 May 2024 18:11:45 +0200
Message-Id: <D1ACM943BLGZ.1YOGPZ48VVL6V@baylibre.com>
From: "Esteban Blanc" <eblanc@baylibre.com>
To: "Richard Genoud" <richard.genoud@bootlin.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Udit Kumar"
 <u-kumar1@ti.com>, "Thomas Richard" <thomas.richard@bootlin.com>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, <linux-rtc@vger.kernel.org>, "Lee
 Jones" <lee@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] rtc: tps6594: Add power management support
X-Mailer: aerc 0.15.2
References: <20240515152827.80185-1-richard.genoud@bootlin.com>
 <20240515152827.80185-2-richard.genoud@bootlin.com>
In-Reply-To: <20240515152827.80185-2-richard.genoud@bootlin.com>

Hi Richard,

This looks good to me.

Reviewed-by: Esteban Blanc <eblanc@baylibre.com>

Best regards,

--=20
Esteban "Skallwar" Blanc
BayLibre

