Return-Path: <linux-kernel+bounces-521848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B57A3C314
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EE2175EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0151F4167;
	Wed, 19 Feb 2025 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="J1SaBKR3"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46C41F3D53
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977605; cv=none; b=a3JhE371Fy1d1cijy7qXimMIaxsv06511tkS302PNcvMYMjzaM3YWEbOhqaDEoKEFzil8XVuv0RI4JhK9dDyIm7uKbvi5NkyRx7KEyvr+NdZvibqIckMki7bu5IXPvyFz/4WVUou1uw0pLi+zsoB0JaM8+MqI4pZgi2L0wJ/iq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977605; c=relaxed/simple;
	bh=RsIgDGy7qZ8B3MBFSHhVZSusxcdoPT4+tAYIqqxrg48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KkLjY1d58z20gvmgTXrcWPYz4aq88yKmrfMR9sHKy5TB3HPhNFrlFgMqjItqNNtA/JeVx6jF6Xu24SMTeubtlY8moaIOKPuIelSomu7eIelQ4w7iTqsWwkJhgdOiBbUsMNUNfV5sC8GO0CKapF8xDsJpacztXhJ0IiTy2ou5zQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=J1SaBKR3; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8559461c2c2so84438639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739977601; x=1740582401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Facg3HecWXCU/JkqnQPL5G/CpP1AOCney8P06Ut0gwc=;
        b=J1SaBKR3DXIo6mmI06ls4yYhyhN5ybupBUGq6q0R5sxOEISJvF9Yuww7eKb48URaFl
         DjzAazQcGhGqc7ErtFVbhwCXiXDFpci59QhaxaDLuqN6xvBMDAPcijv+KdoE4vmwC1OM
         UBDRzR4yQ6NEtHBpHLFC5j3d/AXsapAhcN6ZDM/QKRUgIYCDh4p6vFqPRcOHnbEPlNrO
         ENwo+pDjgeDETgduC+zFwg6UPmWk6OW6iiQI02YLxDL3hNZRzbiq/0jsXgwhNAytBf9b
         idUyIqhApS1g2j4TFuiH/uc9b1xjuqQoGu0zUNuS4Id0Hl508vFkoskD/JfnNnDNq2zm
         lgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977601; x=1740582401;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Facg3HecWXCU/JkqnQPL5G/CpP1AOCney8P06Ut0gwc=;
        b=MciOSNFrfoZ1e9Qi7v3pEF1JKoChS5SulXfzVb0DZSuilF/ZQJvWDfYC0BaDHQI4kJ
         DY4sP7EtvO9BaKV0pT9fpLfRQdBaMxKiQbLcNG5oq/IjjSfGVDjH75l1zTm0gNBn1Wo0
         /OsG0Khdh5ax3R3B0ogvYrb5q589+yIlheDNcVOzY2VI/HIikrH+gKwxJv3meI4rILUX
         Wr9DpS9mcKk4+mZsOFi5i4JPaxYdcLJq8DChl6SgNBavufqCuy7ZUjKSnVAmW41yZtee
         Bo+pXhthNdzM0pE8Eee8LdCrwcdxcqZfIdt7vSvIn863CmCd31QBOGMecoDpeZxTeJFD
         g72w==
X-Forwarded-Encrypted: i=1; AJvYcCVSlLG6JFfM8TNcrakTrv56TrU6qHbT516A+MzUVvyQfaC2+n3hj24d6+1lrlwBzkRocRYQgJr21rLafK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ug8EZraifSaGV5eEKjaGsuZtN2BXYYQ1AWRy8W+aCIl0wfYf
	JHlliMlPgQL8ayO8xFoNBUf6EcMRf5Mq7RNa75FkrWT3j0ZmvWP1zbHRC3OY54M=
X-Gm-Gg: ASbGncu2fv+2Qaf1k+9tt0IL/4LPCMKloBRCH4QUrppSc2VhmZKZ7X7Cdrb6v6I0bSM
	WxzWtiG32UnVQzXrnAgB0z5esvaLclNg8chGTBuNDVNJXZXv/SQeROcArrDRJN/snIRJ3bFoAAK
	1Nc6Bfw9P8UClZDYIZhK6SWAg1m/QQTGbcfjhgpJ0gkKkaGrCp1zRGqQAvP57pQqaXZdYWGTdh5
	00Njxs9oXSfg+TUe2A01TA12UDe4MiMKlrJ72HiL7qbUJIaukxjIpjjmkQ5un99fyow2PafTDqy
	LAXxXA==
X-Google-Smtp-Source: AGHT+IE900lcMYGFzRy4z2mV2nYf+DRnF5ozVCCn29CL/Gd+3WZwyLfLr39McanUqzpQSq2dm5K21w==
X-Received: by 2002:a92:c247:0:b0:3d2:b4b8:bf54 with SMTP id e9e14a558f8ab-3d2b52bc919mr38993545ab.7.1739977601624;
        Wed, 19 Feb 2025 07:06:41 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d2b374de28sm5304345ab.71.2025.02.19.07.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:06:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250219033444.2020136-1-csander@purestorage.com>
References: <20250219033444.2020136-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/rsrc: remove unused constants
Message-Id: <173997760046.1535105.540337617191043636.b4-ty@kernel.dk>
Date: Wed, 19 Feb 2025 08:06:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Tue, 18 Feb 2025 20:34:43 -0700, Caleb Sander Mateos wrote:
> IO_NODE_ALLOC_CACHE_MAX has been unused since commit fbbb8e991d86
> ("io_uring/rsrc: get rid of io_rsrc_node allocation cache") removed the
> rsrc_node_cache.
> 
> IO_RSRC_TAG_TABLE_SHIFT and IO_RSRC_TAG_TABLE_MASK have been unused
> since commit 7029acd8a950 ("io_uring/rsrc: get rid of per-ring
> io_rsrc_node list") removed the separate tag table for registered nodes.
> 
> [...]

Applied, thanks!

[1/1] io_uring/rsrc: remove unused constants
      commit: fb3331f53e3cb1f1505f918f4f33bb0a3a231e4f

Best regards,
-- 
Jens Axboe




