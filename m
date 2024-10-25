Return-Path: <linux-kernel+bounces-382371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CBF9B0CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14541F2244A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535CE18DF91;
	Fri, 25 Oct 2024 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/jUsv7Q"
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50813B5AE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879929; cv=none; b=WJcwGtMenjCEsmXCDUUBPKtrkdCQcXxlaIebOVUq8zrM5Bi7iNRsH0VUQB0ebKtJDbIL+eomgUs0ZF+bgu8rYFIwyq7+bpF/5iH0uTHBkQIpqf+ZKDMlAV2Y0o4B0+Gdo/phaXffBp2FTjLno5jOLhOKJBkn4jkLePePz4aX8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879929; c=relaxed/simple;
	bh=OdDXVlVSuD7bbtK+/LaCQ8JSlo0lFo/SuY3hXdbU+s0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=rSOun8BIHslQMS1WKlFIqX1ectYCX+LLqVWbVFglMpToABBgiXMUFcode7SNDh3nnn/n2veAglyCpGCwhD8RBHTdUYnI/ISv++yPrHZjtI6FzqjPrC9mUW5GWqPbGUy2QrimHmSjkpglzYhA0DXbQ7JU43tzefhJ9wJ+z73dGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/jUsv7Q; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2e2eba31d3aso1652282a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729879927; x=1730484727; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdDXVlVSuD7bbtK+/LaCQ8JSlo0lFo/SuY3hXdbU+s0=;
        b=S/jUsv7Qal4y5jKLCxU76zu5ovmCf77jSuRmctQy4QiL2Zab8V0oonhU47lbi/7ppx
         jxESAcavm2P9q/iw9LBCuOrl+rPEuvT9ZRER9z0BnOsUlzUzrZ6ZbEC7LJSZPvOEOcnT
         CaynohLLybB1jS9397uogvWTbdgnstAoc6LpdXxMNj7lKKCzQ8DrqmCxiOW4G8Bqmfa1
         QbeTd280/VhX8XQi5AUvBAFpVtg7R4hC9OSdY9ENT2ueUdUAyQL7z3U2DWShR5rLhdsh
         0F+0r0mlywbzf32PkoJ5jX/HXVvQ1OTNrcEhJ+/uL0WfgO24qm08pRQXOrxpj6b0wgou
         F6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729879927; x=1730484727;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OdDXVlVSuD7bbtK+/LaCQ8JSlo0lFo/SuY3hXdbU+s0=;
        b=Obtc1R/DFdr4lfVDEDlZiOxUJD58tWz+qySM4smpUY3Ft/yYLUfKPW40avOIKUftjK
         P94YGBo3qapZus+PdoHLkqOIBQxlg6K9P9eGJabQgWBH4nGeSjyxzUUxOupGwTiWFtOg
         A7IcAAzr+lvU8CVMHHFW5hmHZ0PG/8Yb2eR3fcvhVFJvrLjPp76u+QqATnfP7WWX8ONC
         PFzxOsvbB1p198xjpURJbnXHX0FaSRTEMaHQQv+OsFMSENY87EmcChIi8h380UefbQZ+
         ydtbM3f16oWbQm+jZWZpVl1ocvGKO/BEcjws6H1jjHzhejFaD+BoTErRLUBBwCNaB73f
         vyiA==
X-Gm-Message-State: AOJu0YxGExemqygw3Fvlgeok4lEIV891dQdRAlgCp30ggOutGl5cqIkD
	cWWp7QfMkzgdkeGph4lL7uiC4+kgtpdxtMUUzc5bCAgelhtpRSDSQ7A+4z45
X-Google-Smtp-Source: AGHT+IEOwIAaw6poOPMT16hGOiPtEr9ONN0hFA/fR3c+TijzadZsIku2kw3QxkbGTxc8BgQcrdK9Sg==
X-Received: by 2002:a17:90a:e7cd:b0:2e2:c406:ec8d with SMTP id 98e67ed59e1d1-2e8f11b96admr275540a91.31.1729879927260;
        Fri, 25 Oct 2024 11:12:07 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e598473sm3802809a91.50.2024.10.25.11.12.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:12:07 -0700 (PDT)
From: Josey Swihart <nahidhasanapu8729@gmail.com>
X-Google-Original-From: Josey Swihart <joswihart@outlook.com>
Message-ID: <752542d4a8ff0b73a16a92002bae6338eb87d88c385584918bbc005e4e617b10@mx.google.com>
Reply-To: joswihart@outlook.com
To: linux-kernel@vger.kernel.org
Subject: Yamaha Piano!
Date: Fri, 25 Oct 2024 14:12:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I am reaching out once more about my late husband?s Yamaha piano, which i am offering to anyone who would genuinely cherish it. If you or someone you know would be interested in receiving this instrument as a gift, please feel free to get in touch.

Warm regards,
Josey

