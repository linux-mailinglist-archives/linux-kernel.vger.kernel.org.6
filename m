Return-Path: <linux-kernel+bounces-356993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5768D996A05
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898231C21CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D007192580;
	Wed,  9 Oct 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSFqksSL"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B7B1E4AE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477070; cv=none; b=cSpcA4KUKLlc5kej8sfO0sefJnhvNs0S2L425o+mXKUXeWlQuL72WOVfPQu+ywXj+ryyGGeaZXqfUAaB8Ne0xuxbknKzFF0QeTFAY41zbYlDsj4uqC3gPjMlddS/9xA4gHeJEcxasq4vSAdTWRg3C0+3+GEnASn92Pd5ZYI73SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477070; c=relaxed/simple;
	bh=BoXo3f7Y68PvCPMCc0T9YZbtyt8gkr+wUJb37wXCOZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5w7DUauW4mf3/9uEW4tDq9vICxXmf/lWynqrIRz2yFOfaaWPKVW3H9MCUplm1So8cQ1H/PNKMELvZeR6X2QjdEt0Boe+pIi+V5riTF7i0fjABX4VLHDAXbbQGlxETIE8w09g9EnnIS/BTi7Eb18irluqjhJN8HP4H6bFO2dKhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSFqksSL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71dfc1124cdso685700b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 05:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728477069; x=1729081869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoXo3f7Y68PvCPMCc0T9YZbtyt8gkr+wUJb37wXCOZc=;
        b=QSFqksSL0g1Bmlsup52NbOiIIT90DOLouDKART650aB41rdOyMDWM3ABwAuiJ2h4Gs
         wc/uxu1tvHrkbZB5djnTOfXu2VOD1r2yf9FD4Xm2jaRLQyMl+LRILN5+wOkZQ/4xePW2
         DSAfub8K0tvkA03TbR8lwVUC6sKp15cBAtGz4Yv8Ixet89UnCljM7QS9PXfAHcphlaip
         w14NHAsMKUxdf9ltfvSoT7HYwCfriw7pIoO9LRHtp+NuKEu9N1Dlhg7LUBOcU946w9f1
         gAOkOY4Y2W8dM2dlDFDyv9lrEfMTTYnVvCGT8+3UEiIRd81Wk52SvfuwZhCp2poHTFHj
         s6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728477069; x=1729081869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoXo3f7Y68PvCPMCc0T9YZbtyt8gkr+wUJb37wXCOZc=;
        b=YvGNwkCVt885REtvKPr4jNxgEYtg9UT4nn+z6ozjxhK4MrWAbx5EoS8ziCRy9WKpCd
         QmB7/t+46WUYVnCSnwxBmcfy4a/aHWsB3pZGml9EMJEuw410GOQXIvBHfARPVEQiBelN
         YgkAOL+opkRFcQj+l8gqudjwb8tzXEIxfKza97+5TOZQqHeB3KRVeJlt/z9bEGMhaSCV
         DINzbsfAcww1aUiA0xwTO7Z5yE6kBSKgu9GTaF9v9soGY6NR3kKJSw3350YZsHQ9gI56
         fyAs/u0WJjpBk2YKjUtkd7KHqGRiZA40Vcyj6eKAjALl0kZ80rCrJ5iECWSMPdhP8AyO
         0atA==
X-Forwarded-Encrypted: i=1; AJvYcCVrd6yKZqEjCEliEkCF/2vhw2HZPGfNo1mzjN2hwr090dyYh859jZTHvd9OBwj78aSiN75EoB06Bi4v1Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz12UndJsX8Q1skijh8rhJqru2bTG3XYHwGQSq7ubFvY2QAszLB
	QFTl7S2Lo8IBwemkQmZR5fwEPmpnmZmYxXdgd/quz0b04oEDBuHo
X-Google-Smtp-Source: AGHT+IFfJ68/5foHByY+8GSZiuoecJs1L1P//p1m0klDWr3726ikTXNGjwCHw3o52TJ577X/xbO0cA==
X-Received: by 2002:aa7:92c9:0:b0:71d:ea34:977d with SMTP id d2e1a72fcca58-71e104d949bmr9104538b3a.8.1728477068657;
        Wed, 09 Oct 2024 05:31:08 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71df0d7cf42sm7699558b3a.193.2024.10.09.05.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:31:08 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: pierre-eric@damsy.net
Cc: David.Wu3@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	felix.kuehling@amd.com,
	linux-kernel@vger.kernel.org,
	pvmohammedanees2003@gmail.com,
	simona@ffwll.ch,
	srinivasan.shanmugam@amd.com
Subject: Re: [PATCH] drm/amdgpu: prevent BO_HANDLES error from being overwritten
Date: Wed,  9 Oct 2024 18:00:44 +0530
Message-ID: <20241009123044.109909-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <d9a3fee4-bb14-4162-95b1-06177d0a9949@damsy.net>
References: <d9a3fee4-bb14-4162-95b1-06177d0a9949@damsy.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I have sent the v2 Patch reflecting these changes along with
the Cc tag as suggested by Christian.

Thanks

