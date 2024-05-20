Return-Path: <linux-kernel+bounces-183822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F134B8C9E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E13A1C22F81
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD2A13666F;
	Mon, 20 May 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q1rmb1I3"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290CF13664B
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716214086; cv=none; b=rVlY3D/91iGoLp/PAvdqRn93aThQokeXeCFyp4n1AwDeaIPKOfFeu4V6TyJeVGxLxaGRdILDlWhTbXqwB6PbHGrI8CaClr3Fn/BEcaJ4BtNeBi6X8fHozaG62r5Xkgd3VRMh8zqlcV6wxSSesURt9voD6SEP5ujVBiTtDPNUAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716214086; c=relaxed/simple;
	bh=jejequIZLQUkXoRwRN38Pai8FJ1AhPODk6cIdwLFiZs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UDH8SkIYr+vUotWq/zWX9A29eqNRoJRlrUHwHvX/HKJVZUzteXxkIBLhulliURCISEGqzfsxnC9FcKypjakXvRVzfnxHCuBbgY6e3zS4453SrjqZsDdLmghvgVorbbZlsufjgqg9WJtBbdwrzh4Coys+yaeUZWrfS66p+NPSDX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q1rmb1I3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f2e3249d5eso10156025ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716214083; x=1716818883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUPDjNArKJ3mfUMSjW2yhq61IQlP1POL1CAjSweGz24=;
        b=q1rmb1I3UB2MCbhXDTl8HJk+JlONBra45FPlNABo4ewLHWHA8JXEGtzcm6JDV/G5Z3
         3fqtG9AJA1wtzwXgSg7u2uqyrKK0NcDIqs23OIcYXFnmAE8p1vzcyw/RRnq3R2w29PPf
         3gRxtUNYEzUCgmDLwK9Dm5f40o27bx+GDp7QOVSk4ctmu5imbWMJ98Vb70N4b5SySZ/L
         h3W+CCbHKMwFId+2iQrP/iPZQJDHdKAUjxlCkPdARia5DYqDHKH90faKzgEB/o87W62x
         NxUKgdIAYdU0+kgpLgykcF5eJSfRiF/i0nb5yrbYE1GprVK2ZKNwyT760abN44mcgYnK
         J5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716214083; x=1716818883;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUPDjNArKJ3mfUMSjW2yhq61IQlP1POL1CAjSweGz24=;
        b=ClGWYx+Qo39JMfC6r8ct0lbMTZTdfoRhlzaE2ognuCL+O9ScutKZks02UucND3GAxc
         f8uv01yI17vNM/ztA9+zZDDaJHivUJ/skI5IiIJtTazBeb5RWoOoCre7c4nkWWkw0Lmn
         my3td4dnmDTMgr6cCrNokoI2tHqjW3UUTSyeMS5I3LrxClZTz1T5/V8+J1UcBU1XmRg9
         ezJl/xb6+pMIBU/A0VPdDTOgwiw3f6lnDPNjryyijXm+vUjavWIQQNshyPPYWYnCsXNH
         AjECyAPPzM22YyrpIouu1V+Cf20C+Oq6/+l7ivwm//yYz8nvV497MF2ym2V+o08tQtbF
         wOdw==
X-Forwarded-Encrypted: i=1; AJvYcCUbP/InytYoMZOgA5Vc4VIpA/oC2PHQwwa5qzIk0MxBVucPK1OT2HYGuwqicjhVN7vi59bolGPuBVT2lUW0/Vj0NkMIZtDq4TZFANwv
X-Gm-Message-State: AOJu0YwyzPFUXQARJOtttFVqLeyZ7kAb9Dj7xIYYkGtsB9B2drbYe79Z
	7n2xuX/zqyDSfkXT2Ubs2OolfPHDJxniv64p6coKJCpt7yBc+sN0gE/HyehINYyQOREWzQPR0Ya
	c
X-Google-Smtp-Source: AGHT+IFRAVhTX6eDNJiRwOPpKgGY/dBfWAVh7Azrv4tnNy307MGqgnnXihGSFJR0EEXwooshsV6e2g==
X-Received: by 2002:a17:902:d508:b0:1f3:358:cc30 with SMTP id d9443c01a7336-1f30358e620mr23191555ad.2.1716214083522;
        Mon, 20 May 2024 07:08:03 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bada431sm203721085ad.100.2024.05.20.07.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 07:08:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240516-md-t10-pi-v1-1-44a3469374aa@quicinc.com>
References: <20240516-md-t10-pi-v1-1-44a3469374aa@quicinc.com>
Subject: Re: [PATCH] block: t10-pi: add MODULE_DESCRIPTION()
Message-Id: <171621408252.12318.1975684366197625365.b4-ty@kernel.dk>
Date: Mon, 20 May 2024 08:08:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 16 May 2024 17:15:06 -0700, Jeff Johnson wrote:
> Fix the allmodconfig 'make W=1' issue:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in block/t10-pi.o
> 
> 

Applied, thanks!

[1/1] block: t10-pi: add MODULE_DESCRIPTION()
      commit: f0eab3e8d1530b87f3523cee060004dd513a6d2b

Best regards,
-- 
Jens Axboe




