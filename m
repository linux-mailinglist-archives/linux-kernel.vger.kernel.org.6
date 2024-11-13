Return-Path: <linux-kernel+bounces-407485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C950A9C6E19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BBEEB24A70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA31F80AF;
	Wed, 13 Nov 2024 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgmjY5c9"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF691FF7D4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498250; cv=none; b=dDCvJszlT+Z5dLWEWQjc+pcbYYOyGun95TUlYMFqrzaEXLKkJMqL5/72H7WtapWCtCNbwb4dDYJRQabJAiLWo4RcM268ew9Dkvo/LbX7i+eXEgAsMy/JbIfhUlzmtQkgn2wVdQWkVkfcnoYsq/EcRtFYCBtn+cNyNvLTv7Y5Kko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498250; c=relaxed/simple;
	bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=TKPIWOwKzNCj9Ee4pSy5mVPutTlXUnq+PMAVJ18kEGQErzXobrsg3RgtHBhuhoHKt50yeJulUY/ZB7HWm/rnbPwocsQ2vUjcVaxxnvOYKt53lxV3yHeqRwbxMsc+dgwx5rRBBc06XPPJT5TSki+ZXiLSKmAI2bkHg3tVpTIk5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgmjY5c9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so55373475e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731498247; x=1732103047; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=DgmjY5c9U23S7X9i7P+Ra23NZu9wF86vkw5HbE8p5+iefGTdO87zrXe86k4UJ9eaXb
         uUIHz/jwPOBZP8xtxSqgNc1ih35Q8+3Xna16v4zsgyBanOFhPJYZG/OlJMf1FVDTM8WI
         y4tdUeXjenDxTHnc13bxJbnpmBgVlOr/aGp9VNwKMtXBjwDdVQBcm56RPH4A1vrScfFY
         BihrsraFrvjCqVEze3iIl2xrRFzNkLa7JSaS4hWbWJQndUQ2BjAgiRAyyjVpMMbcTRgk
         0Ixx6RCRnJ62c8xeNtYeBuDYdCR2HRq6mE0M031fqQaHtuhiFVyuJnEKtcYF7KoTecQq
         XyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731498247; x=1732103047;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=rH5yJsOmDtR0DZmcN86YxZFIQFU8ZfMbeVyh9KVi4nOGZ1Fqhapq0nmz6tLVkTtuW8
         VUVDWK0CMwOhIRbAy22ieAejRzjXLKYd1bVmGrgyC/R+OpM8X28O+2lF0P4EZJucvr8q
         wUTrIUeP82byp1132taFO1i+PhwHOrUPPQxVN/ARZ4C31zFxWntlnCRoL8Z+sluMHugH
         rxIgvKumgc5u4YeldXqQHIYw2x2crK8BkIUObXrzRktmlGF2ZKNPiqI0inXb68k6W8CL
         roYlnrQTlJsB4gm5zlAz1cI9M8MbIvWBG4ZYy9J3bfiCqVdcIVaz/xTx44AFfTOU6Su4
         PVLQ==
X-Gm-Message-State: AOJu0YwgqEuK3xu2rtvp56LNNp9TyJh4FQnSZSelFHjxfUhomRKWUPqm
	dx9DS73Og5xGJZvr7jbhI/edxjwu57D35emhZRt/gUXv5CMpBLuqn+zvzg==
X-Google-Smtp-Source: AGHT+IG/VzJsOAjy0F+7joOa6xxjCOobrnDUIZfYGALNQzNGfMu6DJLlLSYGgiJzO12mbBLrwpxHUw==
X-Received: by 2002:a05:600c:4e8b:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-432ccdff4bamr57197215e9.0.1731498246932;
        Wed, 13 Nov 2024 03:44:06 -0800 (PST)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea4ebsm18176717f8f.69.2024.11.13.03.44.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2024 03:44:06 -0800 (PST)
From: William Cheung <rachelortiz243@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <db96b1921488e16f28b9b435830550d5ea21f907d546dd7e11d2492cd460b28c@mx.google.com>
Reply-To: willchg@hotmail.com
To: linux-kernel@vger.kernel.org
Subject: Lucrative Proposal
Date: Wed, 13 Nov 2024 03:43:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

I have a lucratuve proposal for you, reply for more info.

