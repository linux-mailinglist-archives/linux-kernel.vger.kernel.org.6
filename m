Return-Path: <linux-kernel+bounces-303622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AAC961168
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF02E1F23488
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015A81C6F5A;
	Tue, 27 Aug 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kP3YyR7y"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E5C1C9458
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771925; cv=none; b=JJfBSHpDNDq70rQ26gho8+FKkU9jJ1reVBNnkWV4cVa8YITDX0HOsXpC2Kj82JFe+20pvnWunSanKUhJn3Fp6jA90Su22cBE+mrHsPqFOYS19y14HPxp67TYbaIwTeoWj9Qewc9vJ8X+hPhjNRpqwQjc5F/m7Uf/XgKtVqhHB8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771925; c=relaxed/simple;
	bh=FWrbAG6P0brsbGn9M+o5zlQjAT9566YEYTljPVMRvw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h0uzaQretnFLM1HZ5LhH7lz/mDW1hs1fe7A53BchBCGhd8eRsVAlfqpxqGDkvY5r/JXSmPB5MDNj/aBeKMbOdStJdDd9UP6aCYTL6raN/Bgc4f4tWGnfFtvkZ67Y2xbzMWrFSJ7nNHOp1iPjNbw/Hko9deWL6zYJIO5Bk+h8uYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kP3YyR7y; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39d4a4e4931so18293275ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724771921; x=1725376721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3sz91txppRRQol2u4InUNml7heTRN8PJYStXnuBzvI=;
        b=kP3YyR7y+7NCLk2rtx/assH1rpSQhu4URr5cV0zDDPiXN2VHQUHipmz8D4MP7K0wiO
         SSrAZjHmcPfvnOUiWDEuyIyB0yCLKL0imCsofdGb19zlhHzZR02cf+/vys4mrwXruSwz
         erDGuo3qJIeMrUaE4kkzOusBrhcs2RSLr6nKYNPM4F+zutjrSr05psBa1Z8ErigXzDp8
         VoazsmtS6n1n8it9zO5C7dGlvhpb0WYpsvW1VlcRUpcN5vNOfrXSrrJWcjvJHWKQ4j+Y
         XqYn4ltnJEyX9tOcKfgubYgk6VMjAoUcqfKbypVUQktW9wmD89lYnOizE+0U0xgM0AaX
         afCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724771921; x=1725376721;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3sz91txppRRQol2u4InUNml7heTRN8PJYStXnuBzvI=;
        b=ZKQ7YYoKopol3Q+LkO6ZV1qz12RQ0+n0NX4MP53NdJfkYtiZciQwCf5DAQ6c89xYl7
         8/kW6sdeMAt2YsksR45xyKSZOGKHj3GX+sCaThvmZan/BJZh7d2h7I26Z+/OcjIL0iXv
         h3Y13hGBc9nty79wJvNxdpqeHdJqa66LLGPef/f4aefnIgpuyYkqZ28ZorgAWIR9JA+U
         g59dPuRo9nrYufKKmp8Zm1TlvuyuFSteWTq1X4z3Y1duSjCWOLqQYW8wFI6GNY6uA+cW
         4ohZuTFALLa9harIAN1elvdkR9FPfqsWzccnrW/RwisEcMH3wtOsrSZ4MpE9aDzrWOPb
         9XBg==
X-Forwarded-Encrypted: i=1; AJvYcCVW8SGsDhbPpP6QOcCWYpwuOHPYTkPllCnOdt0OcnOA7Xgm5dx2udsrGMaURQNIubIpRUWnxW5Pw3A/0w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKGCaS9Mp5A9zPWv5bPadTF5G7CQm3mM5h2wVLgVW/6Fc/8Dk
	hHsWTtKkPjOL1iazfAnwpC/GJtIIL+QRw/CJi1Ve5eYN+IGe4RJNFvfowLOeCdSm77VyELS7zk+
	1
X-Google-Smtp-Source: AGHT+IGNdx3hQSl4CkHtRMaYkJu09zBIn48d6ju/aGa6VCD7Sery0aqS73SHIK0b0MExvGSMVChjYw==
X-Received: by 2002:a05:6e02:1749:b0:375:deb0:4c28 with SMTP id e9e14a558f8ab-39e3c9757f5mr159333585ab.6.1724771921413;
        Tue, 27 Aug 2024 08:18:41 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d73e67af3sm40028295ab.16.2024.08.27.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:18:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Ruibin <11162571@vivo.com>
Cc: opensource.kernel@vivo.com
In-Reply-To: <20240827022741.3410294-1-11162571@vivo.com>
References: <20240827022741.3410294-1-11162571@vivo.com>
Subject: Re: [PATCH v7] pktcdvd: Remove unnecessary debugfs_create_dir()
 error check in pkt_debugfs_dev_new()
Message-Id: <172477192076.295209.520219847740395596.b4-ty@kernel.dk>
Date: Tue, 27 Aug 2024 09:18:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Tue, 27 Aug 2024 10:27:40 +0800, Yang Ruibin wrote:
> Remove the debugfs_create_dir() error check. It's safe to pass in error
> pointers to the debugfs API, hence the user isn't supposed to include
> error checking of the return values.
> 
> 

Applied, thanks!

[1/1] pktcdvd: Remove unnecessary debugfs_create_dir() error check in pkt_debugfs_dev_new()
      commit: 752a59298ea9c695ec966fc5ba7173897a1ef361

Best regards,
-- 
Jens Axboe




