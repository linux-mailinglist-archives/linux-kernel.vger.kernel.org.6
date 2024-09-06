Return-Path: <linux-kernel+bounces-319040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A03E496F6DD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C64285E0A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DDA1D27AD;
	Fri,  6 Sep 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AJDV5vrG"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4F1D0494
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633122; cv=none; b=Am1BAVFz1masqf9+4QnNr/NdSf2bEAQNPSe92OcuovVXZfBBKxzs56w02CiGWRUPnVMt0LP9Xasfw1vCSYVqwAdcs7NqHNRiyr6XIHIesFkMgNkGRLpfpDoER4S39kGAI7kxxnsA8uxShpzl6Hmj/LDBAOgG645KoMvnEvWHuWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633122; c=relaxed/simple;
	bh=od53PKb7drv/B0Nw08nf27stwFA9yWQv0X6TdGXj7xE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oKR4Q022LFI+0y1VoJvNbeUK9Uw6ipIBldXCYQyG1abdcGIM3RPK1+3C9kVeziNW6TugTq+OA4k7mbsOj+Tgh6bhQcV6Ivh7RlraB3Vb0QagZ0Gk7evf8ZjJpZyTOhRAg1iK1d6sVoWfmefydKVAS17JhbIL1FIpnkmAP4vb+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AJDV5vrG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20536dcc6e9so14922265ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725633120; x=1726237920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22o0ZzyLZEiafCqX5cQ+ZMjMs0v61dURGbb/IDBuD18=;
        b=AJDV5vrG/hDhiDP/SocPWZ8G6zaXZGXtGkzV8kNUn5Po2HSy72d6sFMCyYqq6PZIWY
         mnSxMnaPWi7P8yjP7jGD6ypkyP6Uuzctj3NRNeE7nAO1NMoL76ZDrhrKLOdS9/lqJ070
         iCj0/ruKIPVaZlaV12q3iannjiRfNAtoBdhj7hwy5+NZk/RTgxCe6EHwUGamDPeU4dYG
         Jr7Z356yst29d3agvodwVsL866VnQbofjYjcMT5Xng9q+XkjJcr2UH0AA0DCAXmB7HVJ
         SwNP5TRGQ/eVJhPhFmFZjA1rt2KPNgf5lmOp7Ek2aXP53FX+9TldGP1s3KMZQBCYUueB
         SDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633120; x=1726237920;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22o0ZzyLZEiafCqX5cQ+ZMjMs0v61dURGbb/IDBuD18=;
        b=qcyoSf5Ho+1x/tjPsb46S52DTc20ed5Mijo46pEciOTR4qTqFnHad72w8q+MeB+OvI
         YhvGvJgD7dF0NOTuF7NO6QnyiblIMqDEK7qccbnqgm5i+b9Jdnl3HrcbnXE28ZfRvVzv
         EKi7U4y5NxLamYshQb7h0LPOJ1+ffGztFNGDBht3id6m2rfDhlYS8QNgjA9Y74moWHOl
         bWtCQ7+qOpKb5rCKvlb/d+38b9ZLoTcio8Xts6Osm7F+zrqMt79rP/FZRPbC3r3XTYvz
         0kSgIeJpivutsH7Y0d/q0KC7ub3RJDnWgbO+HDiEDle0cMglFG3DI/+/7uNAcbstzYL6
         erIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv5hJYGpsxEBxtnvfyRP8U82UpGCCgKZjh1uJWq3UO4bFuWoN2jDPk71Y84vptssnU+UDQOmMGvo2/buE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2nqYoZBcGy4gPEs8l9l06Q3nzbNfDNBVB4IMb8qxDS1Xaqug
	N39jZveLKuWrgGl+SDf2ld1SZJ59ReYtHPoP9A8fxbA9vWNFHXsQUreO+OBRc2A=
X-Google-Smtp-Source: AGHT+IGp6TA5jS245vevFKjB8AnYfnX/DyCCBJVnGWu7AhC5Ng41koXdz2LEtkmRWnVak5lHk9zdFA==
X-Received: by 2002:a17:902:ce0b:b0:206:96ae:dc57 with SMTP id d9443c01a7336-20707001917mr363995ad.48.1725633120088;
        Fri, 06 Sep 2024 07:32:00 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea38539sm43951255ad.130.2024.09.06.07.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:31:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, Wouter Verhelst <w@uter.be>
Cc: Eric Blake <eblake@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
 linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240812133032.115134-1-w@uter.be>
References: <20240812133032.115134-1-w@uter.be>
Subject: Re: [PATCH v4 0/3] nbd: WRITE_ZEROES and a few fixes
Message-Id: <172563311875.172223.11600465596358728901.b4-ty@kernel.dk>
Date: Fri, 06 Sep 2024 08:31:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 12 Aug 2024 15:20:35 +0200, Wouter Verhelst wrote:
> Implement the WRITE_ZEROES command for the NBD kernel driver. While
> here, add NBD_FLAG_ROTATIONAL to the function that decodes our flags for
> debugfs.
> 

Applied, thanks!

[1/3] nbd: implement the WRITE_ZEROES command
      commit: e49dacc71ec2621ce4c422cd5605d4d06f7807b0
[2/3] nbd: nbd_bg_flags_show: add NBD_FLAG_ROTATIONAL
      commit: 41372f5c9a866365e212809b3543ae8cb5b2542b
[3/3] nbd: correct the maximum value for discard sectors
      commit: 296dbc72d29085d5fc34430d0760423071e9e81d

Best regards,
-- 
Jens Axboe




