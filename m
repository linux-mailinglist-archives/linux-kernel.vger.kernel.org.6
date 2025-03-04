Return-Path: <linux-kernel+bounces-544819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA4AA4E59C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AF242524F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049C72D1F5E;
	Tue,  4 Mar 2025 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="THG01Q3O"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201632D1F43
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103513; cv=none; b=hcVdxYHla+KLPLeET0tNughvUpWEDzKtCrxCz3CxtCLqDMKE+yRIBE9AgZ29t2jR3WBXfGFFYatb3oB8ydZwLIKddVJ1tolAXw7AQZVfp4g2SPIJSTWnLxC1/WDEG20FgLX4QiPHMCtkG5roKsVCtNfhg1AIHWXxO4DgYy+uFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103513; c=relaxed/simple;
	bh=X+XCBeSIDHPIeicCGaDtCadLLD6HqOF9CTWAmKROFnE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CDQ4tQKhj4KJ2SHJLY0aqKWOz6WTORFco6yI8LR+t0BEVx3exGDGdu7zLoc55L7DMwIjDGwZMO9a/DuIgdaZg/56DcnqeOrQXKMwL0pZctd1oi8+XfG9thOgkeuS316XpZyMbrn0467DxN62NQ8OJCtoEO0OzWiBQdiGjIG6X+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=THG01Q3O; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-855fc51bdfcso209979639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741103510; x=1741708310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m539ACqsgOp6qLGqhafeXxINycqUDx01HHcbsWWCpN0=;
        b=THG01Q3O1MS3xmQRbZgGtkdRKbEQ7075B0MCG+FKT7J1kaszb0RpZa/QcU63oEDzs2
         VzOp/fDoXqcJzD9HFS7Yghe8ebyHrsvg4YL4SV3Rm0kbcjSjK5pDMGAq19W5Qf49/2Vo
         SjO+IGseiHHavuS58L56M1aIc5XMFMr6wYECWfd7KBQ87oOfRFwZz3TBbDhKrMQJ6wG3
         bs/wOENeTZoXCpasL3Vep50Cpk8UxBHdxVCFvNkCbQlIhB0W2c0s1MbihQjOvWd3R69L
         Gw436LKmZ94ywT18tHbCEA1VNOHL5anI9QENS67desOF9UI+1aOkCDIwNDoN8Kb3T4vX
         Tl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103510; x=1741708310;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m539ACqsgOp6qLGqhafeXxINycqUDx01HHcbsWWCpN0=;
        b=B9yKA1S/iRs8v6wosXTdUJ+21SArKxQBrmO5FARevjGuwXiJE2D53dIKdo3j45InKD
         d2VoRiitLZjJIc1RSdq5Uu0xKkgkbM5bjkQahjO125f6q9Q1Bz3W7sWrWCGzrJIQvbs6
         KsrJAZ+1bo3Xd8Ox18tL7ewegEAPzNm+Wo2MhrxQ4CQkdJXorED2npkOIV56PgDB7bBS
         iSlCUrMWGpE5bgVZHpioibrDaTlPvB+Ar4+eVY5ADrhWTFpjDQRiAi/GBs2qrqO4DUxP
         g9kptC1X7QLlpHhnprkTfmpRCNBy6ZgjVHIKV5aReggRrIeNrAfvJJiJZp5DsLusY9ER
         S+4A==
X-Forwarded-Encrypted: i=1; AJvYcCWoubj6YbyJ3vvKY806UuZRHpuiz/Z1mybwbXoPf4c4llepQ8aint0X7+2t2izt0j+eiMTWqRndHapyzKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZjN4ZwhI04aYEFxz0OxtAfRff14tZTeLiFXj1dMHs1Js9VwZw
	l8zowgyHxBRsUPCbDCjTVSBia5npzcnC0nWBBBoUArlfLUhoVWLbiA347RiHL5A=
X-Gm-Gg: ASbGncswBjCvc90RDRgdPuefnWl5MwHXO0pAx1oKSUj8kTRvWzFIsfqKUjptCqRACeh
	DeeEQhgNm+O763/CQEHEAKW7bRTJVXGMZ/OUXxMAZgNltTizZSQJc15XjqxeOk/WcVdu3Wy62RQ
	mAweaM1eIiAEXTf0vqeqnCaMsAXzj2CjIQb3q3Ib9Is1kyhKthhbniL57a+su1tDQXW/iL/eEBu
	DlzzxFu3JJ/E0Rlk/tjxPeMNz5yy3NcKDb1tnb44/bNsB8NybchPTBUmciJ76lnF3GirzGeQ0gN
	2+TEqq8y3oMDMyx9RzyVwXUY7Nz1lLwr7C8=
X-Google-Smtp-Source: AGHT+IF0wWLBbAxhxKj5bLP1IjjSMX3uWB02Y7KWw6UiFsAcBjCRxSZLldeqUX5fjfa29Md2LX0dyg==
X-Received: by 2002:a92:ca85:0:b0:3d2:ed3c:67a8 with SMTP id e9e14a558f8ab-3d41dbcd8f7mr27282025ab.4.1741103510181;
        Tue, 04 Mar 2025 07:51:50 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f0828fd7e3sm2010684173.1.2025.03.04.07.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:51:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Mike Christie <michael.christie@oracle.com>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250228-ublks_max-v1-1-04b7379190c0@purestorage.com>
References: <20250228-ublks_max-v1-1-04b7379190c0@purestorage.com>
Subject: Re: [PATCH] ublk: enforce ublks_max only for unprivileged devices
Message-Id: <174110350954.2748539.4977974596669256506.b4-ty@kernel.dk>
Date: Tue, 04 Mar 2025 08:51:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Fri, 28 Feb 2025 21:31:48 -0700, Uday Shankar wrote:
> Commit 403ebc877832 ("ublk_drv: add module parameter of ublks_max for
> limiting max allowed ublk dev"), claimed ublks_max was added to prevent
> a DoS situation with an untrusted user creating too many ublk devices.
> If that's the case, ublks_max should only restrict the number of
> unprivileged ublk devices in the system. Enforce the limit only for
> unprivileged ublk devices, and rename variables accordingly. Leave the
> external-facing parameter name unchanged, since changing it may break
> systems which use it (but still update its documentation to reflect its
> new meaning).
> 
> [...]

Applied, thanks!

[1/1] ublk: enforce ublks_max only for unprivileged devices
      commit: 80bdfbb3545b6f16680a72c825063d08a6b44c7a

Best regards,
-- 
Jens Axboe




