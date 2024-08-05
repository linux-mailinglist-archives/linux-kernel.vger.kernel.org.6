Return-Path: <linux-kernel+bounces-274050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7D99471EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 02:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AEA5B20A19
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 00:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1254186A;
	Mon,  5 Aug 2024 00:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya+S6hT6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88910FA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 00:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722817349; cv=none; b=cSsZlaS3ILUtO4qVShM3ePQAKKMURdA0RRbFMA9W9bjc75C7v2QEnsEaZNpmS5s5eaz5luzqRw49AaM6JWt4JusnqR5MYkH2eGV9LVr66CwO3l2M9y0nMSkYxsIE0FqU4pv2IsunvH3ZgBOve9zsUILwKzpRWbbrYAY1Q/s69dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722817349; c=relaxed/simple;
	bh=PQvcQ8t7S1Bi+S4T8EGOEg11/VjbQzVW6VNMnvTl5To=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NBWoid2Po5xgof4fFXBY4L/e/1BGe7EEP1yYHvdABDey3FZnsecsZqhj2LnqSExYE0boPaSc6T1oBML7UYJXceQrEco023+D4STmNO8d19IdJ0KP1fXmWxEtqWa1jt129uQ8MPyvdHyJKyvZvVY0wyx4LlnQok4d4r2EyVIZ1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ya+S6hT6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722817345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oBVCiUmIJ/pcUNh5weJT45NG9FUYmnt3UvfN0Id1eB4=;
	b=Ya+S6hT64YmDU614jXj5FEU9hTfv8zbJ+Zu0IAlF8HBn65Zyt89TxNKO/bzUSBygJYUOW0
	bGDY4amBxDvDxSvStVa70l4+cXHPjQ2BrFsoqAHzTtzuNpQao559PgKnYQK5IvdW1yS5pF
	csPP4oRPPERr6kuIXDJVZhuWn6gYOyg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-Vpd40J7MPnaXbQhANNx8Uw-1; Sun, 04 Aug 2024 20:22:23 -0400
X-MC-Unique: Vpd40J7MPnaXbQhANNx8Uw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fd72932d74so80808345ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 17:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722817342; x=1723422142;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBVCiUmIJ/pcUNh5weJT45NG9FUYmnt3UvfN0Id1eB4=;
        b=bfbeWBLiW0NDBI2jKQKzHYX19Q21bWf7f5J4PvYzqPrvuO2Otc4c9OUMsoTwPvpmtZ
         HNM/RuGi1JWXchC4ujaWuirUpKSvcSdaN8mDc8tt3qmJkoN30GOJNlW2PVHzeQhBuM66
         U/RA4oSJyAQzKnAGcMcVumO8ffhd/0BdISw20qLvpvIl4DmR1bDW7kL+xOgQ+yCbPDo8
         RXGXBwGmWn2IpBy6Z+boYsrZ9YM6rdn5E/H5x3vFePj57AAd9EyeSGmeaEfLUcrAnonZ
         CcV4mKrf+X7R6wfv1HhrgiFlghmphCZbbB5oyZaMxmd5+tmmazm1vkfthG+uI0jtQwVl
         UiFg==
X-Forwarded-Encrypted: i=1; AJvYcCVIbvuX3nqMPaxaS+cppZVxLVLH7/w+V3dT0Aqidi6VaqLQ4kEMASNLwW+m9F5mB5I/1Dj/XMMv/TJltGNDbr2h2lMqDHGSftwcVfoI
X-Gm-Message-State: AOJu0YyyHsZEJYB5l1LM82/fTklmvJFbdqyDlIVj9YBSSKTAqrppO4Qg
	doe3TLsRIG36F3Et8xcTmOrAjlwL7zkOGfhVkuu56GEyDs4j4rzUzSmltcuHiFswzkuNx5nz2RG
	djk7DVVob3jB1weBFI+4UNNXq5jw4rXqaAPGOUE7xLhkkRqagyscAzOa/QHYB5lTr96RN2w==
X-Received: by 2002:a17:902:ecc2:b0:1fb:fc96:757e with SMTP id d9443c01a7336-1ff5730969emr88782165ad.37.1722817342118;
        Sun, 04 Aug 2024 17:22:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4yKMe5je0FqceGU22lDwDuJqaOtMxq2d1pVGzFinAoW5Gy1aEKZ5TnASTwP3+a3ZJ1222TA==
X-Received: by 2002:a17:902:ecc2:b0:1fb:fc96:757e with SMTP id d9443c01a7336-1ff5730969emr88781945ad.37.1722817341453;
        Sun, 04 Aug 2024 17:22:21 -0700 (PDT)
Received: from localhost ([2803:2a00:8:776f:3d96:6be:69c7:46c2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592b5886sm54653605ad.299.2024.08.04.17.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 17:22:21 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: cyttsp4 - remove driver
In-Reply-To: <ZrAZ2cUow_z838tp@google.com>
References: <ZrAZ2cUow_z838tp@google.com>
Date: Mon, 05 Aug 2024 02:22:18 +0200
Message-ID: <87cymn95tx.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

Hello Dmitry,

> The cyttsp4 touchscreen driver was contributed in 2013 and since then
> has seen no updates. The driver uses platform data (no device tree
> support) and there are no users of it in the mainline kernel. There were
> occasional fixes to it for issues either found by static code analysis
> tools or via visual inspection, but otherwise the driver is completely
> untested.
>
> Remove the driver.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


