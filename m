Return-Path: <linux-kernel+bounces-245138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728D592AEDD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3C21F21D32
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A180D487BF;
	Tue,  9 Jul 2024 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNabhPUV"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960C4A0C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 03:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720496813; cv=none; b=Uv66TQn+ck+UXtnQ3tKrICrnZv8q7z2rn9AtNGeago+kErZPBYNJoD9nlgbrchC2apmG7Ug6PXTyXPKbZqjGCSp52yJu9Yh6nSCRR53Iyu3YVdPCed3uJ/O5jnWJmZQ8GW1MktFrWokqKiIUrzWv5bSyx5e+33PQB4VxBEwKmuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720496813; c=relaxed/simple;
	bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3ORKGiOpVHlaVGP5AYYoAt5srcntuWOLxxd2rNUzqiTq+T+Si25QRZuI1ZatV6aHzp3+rqPsyvLzKrJCtHpijY5UO8HVcafAQ5gwMBADfZl+YrS/Oe56XA39CDvpamXm1ITWsiSDt818SjM5P40jOLiIZYbMpuPK1Zpmj7B+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNabhPUV; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d92aa0ade0so1133762b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 20:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720496810; x=1721101610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=FNabhPUVc0VjWMqtmcyhoG4tHjTcm/7Ys+pODmut1YRYgS5m2tp9PlRd0b81mmj6aH
         exSN0+KEotJrkOHdzctFudEF/svKiCL0kNBcQy9psjpvP3vJf0R3GpmL45MQXWUtZZw3
         e8kNsMGHU0w4P8fZwJg1UjvSl8DaVtkmpclH9rBf4/VbdEzIosD+jnIIhZWGPS5SE7NC
         pHzQHFqQ/QvZptOpXxpbr0bcTQ2PPlRQpXthR4crNUdq/McAdB/vB29p4BEIRk1e4cNI
         wvMX8fF/JScMqFkwx2uyxCyXLuGKPwu5HXVt6Jd9LjMirN88w/h8QpW5So9qOv6wSFlQ
         84Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720496810; x=1721101610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=IvJaEBWogSqLpbvyVl/cSjsjw5fOY2RJLkb1+BybVyv9RXthhL0/jcZ8ngKhbeLQAC
         2h3TrTy2KmDb43QTGGJlgj99JEA18L8blZEVrwAmoySBuaAEI+kafkGSAsnaNe4Ua0ur
         fc6Q3sSpFXIgRmF0j+iFX62IIbyF7NzFwNVZusctj7pmV/GPtm0YkOitPnkotVdpk16k
         1pcGX2sKQizBM+4zwzMIg2rQwWc2xC/45441RnEYtzH9TSISV/7IxslC+sbCsTE3bjId
         HUN3aqSxPSh1cHdH6Y1b5iId2VD9+g7rsSDZo5WXIqRy36Igia4XvUwkNfu33jcvWTqC
         R5Eg==
X-Gm-Message-State: AOJu0YyPEXtg/mG6zJvqDIEPIh0I0cN5kRCRu4BABv5hIgsWgeeEXzL8
	u+Nzz9Boz+6pScseJ/bof/byvvziGSMtlouaS0ZeSNDtZUicEhYu
X-Google-Smtp-Source: AGHT+IE9N17vlSaS79BM/R6jMysvpFVteS3Db33lghWfVSGPA5Sk+P3YCpeU665VP45Iarm3XMc7Rw==
X-Received: by 2002:a05:6808:1289:b0:3d9:197e:696e with SMTP id 5614622812f47-3d93c0ad054mr1679660b6e.50.1720496810236;
        Mon, 08 Jul 2024 20:46:50 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4398039csm668442b3a.154.2024.07.08.20.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 20:46:49 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+621fd56ba002faba6392@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [net?] [s390?] possible deadlock in smc_release
Date: Tue,  9 Jul 2024 12:46:44 +0900
Message-Id: <20240709034644.8243-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000031c6c50610660f17@google.com>
References: <00000000000031c6c50610660f17@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

