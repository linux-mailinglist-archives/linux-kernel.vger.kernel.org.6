Return-Path: <linux-kernel+bounces-247087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E0492CB00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AB2283A37
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1314784D04;
	Wed, 10 Jul 2024 06:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cAoOEajs"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9C82D94
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592635; cv=none; b=YHFhHz3bIf4EeAmL0rewULlfsF/J7VOuhOHOTCmmlWrXxxjR7eq5nigOiQsKPx8JxsMXE9JdzxBIVKfId65iW3rlrpKT5/Mq25qwqaBG3YCy2iBx95rLCyOaRIGcgbyC2D23BUNz4WoJUjzx4uk3+oiPk1WpMOVhXbvr/ETN+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592635; c=relaxed/simple;
	bh=6s7so5c7HOknihvumh3Haewm4qizE8uH5cVOjlcBNW4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R5BEBkdwV7sIWrAkHdAXGoXhmG9oibbtwnqBTsRy8Hn2VbNFEQp/239yROAnSSCZDO9W0G+bmawg9/x5sRq37quQ8I5WrxKQ/WuGhXpHGfWVP86PVhIVIc6qug/RbyOdwjpCm2/yPYsM7E6kDO4B4gcfX4Pg5nOn/L5/jyL5+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cAoOEajs; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ee9bca8652so3765951fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 23:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720592632; x=1721197432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=assg/spa4cOMqEpYiqy3ecAcAwnhbvPRfb3jWzWA0iQ=;
        b=cAoOEajsdhDU8va5s4PHGyPaNulXDepCAefXzmlZnAWnst8moQ5y7AQaqh1jXiBNp2
         7FOQa29N26sqz2xs3H5NgHjg2EPhZQ5rCO/UDgkpEAoRG2+BH+9K3bMd+qwXNIWgENDq
         9VLav8cwsJSYX/99U7eQ5qR7feS374tthDGjz2/mRzqy+mADE83nrHuBgDu+zurQH8SG
         sopn9KeaOoqC7O1fxdYOJvnz/D/dakD+NPrUeDkxMvF36yLdSEKWZGBHbldggjgbEPWO
         BCmofiytZC/E2Aqy7eoGb7rispIIIHC/XO/N+yi041IBqCLujFD3+1Llrn+ZI/mJ1A0R
         nH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720592632; x=1721197432;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=assg/spa4cOMqEpYiqy3ecAcAwnhbvPRfb3jWzWA0iQ=;
        b=JcTQvMEa7w420krJAu4tpPk81baxPIK/nQK341tSjN4I1GTxYGfcMzVmpBeroWWeDB
         X2SgWwibfRpNTyld3g2Tb5bTaQUenWo4oVql6geTc5swXBdtjBodSwX2D6TKhiyCeWpC
         qITuF24z5Bj99Ife1jDfGKhA2nTcuKYG3ddSHeb8A1Pn7b7vKxBgLKOSC1LJ/EvtO9lJ
         eA8yGeKBlAaAIig3OT8OvOqJjCUIES+C0PxQ0vzu8AZZKefec/jUQmpPfj0CVRAO9hMN
         2YM8HttnuVrPHyvZ3bPWeHgp2FM+j3shATTu4HuKGH2W5rMHQlY0sipqMDHeCKjjXba5
         YbIA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Gil8Rb/t5DZSGcJ9YRrC9Hg5EQL3T6A0zulWAHq6FgWJNNrEbxeCWpQbPIGny63onFeHp61vnUEubxdZxcwrXYkZMwCiP7AcKW5F
X-Gm-Message-State: AOJu0YzVktguAgOKDvpq2RqXVTKA32FB7+DkuwbbwrwzS8yC+GajrQFv
	KB2kZHeMTflr9YG8z0qAmW7bK9kzv6Lcg46KHO4qeBu7Mlntlt+ZOM8ZXvrzOIY=
X-Google-Smtp-Source: AGHT+IFrolNW5lOMuUJhl618lI6yjdNOR6K82mCSLOdcX6udq8FJVW5dASBzQo09mgslsZx9YSpn/g==
X-Received: by 2002:a05:6512:31cc:b0:52c:dd58:1a97 with SMTP id 2adb3069b0e04-52eb9a0498bmr3119303e87.5.1720592632042;
        Tue, 09 Jul 2024 23:23:52 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb90670b6sm463892e87.197.2024.07.09.23.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:23:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Denis Efremov <efremov@linux.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240602-md-block-floppy-v1-1-bc628ea5eb84@quicinc.com>
References: <20240602-md-block-floppy-v1-1-bc628ea5eb84@quicinc.com>
Subject: Re: [PATCH] floppy: add missing MODULE_DESCRIPTION() macro
Message-Id: <172059263066.380385.1122582379768544116.b4-ty@kernel.dk>
Date: Wed, 10 Jul 2024 00:23:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Sun, 02 Jun 2024 17:05:31 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/floppy.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied, thanks!

[1/1] floppy: add missing MODULE_DESCRIPTION() macro
      commit: 3c1743a685b19bc17cf65af4a2eb149fd3b15c50

Best regards,
-- 
Jens Axboe




