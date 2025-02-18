Return-Path: <linux-kernel+bounces-519855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02612A3A2D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6892C1615D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A78126E622;
	Tue, 18 Feb 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GhmZXsNZ"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB2269AFF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896138; cv=none; b=clJ2YlQKOZH6EfzRkZdlRQTp6Em1TdDPnZddMoK8AzlxNLo4xuG6Pp0h2lVCv8EF16Ly3kcYmZQGEBDpIeW8bF/nQRDjBcKMgZwT4V/RDOPTECt5ZfEGwrOFh4NZlak7tHzh2QrXsDB+eff7qdwN3isyBch2ZQkiyZWOH9MSqdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896138; c=relaxed/simple;
	bh=ZLqIegwy/9OPkRJFz9LymatoR8kXczOAXBYPAKt34o4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z/f+PF9Wd69xC8TKyu0LwbUfDWr7mXE0mCQIq2HtVVkyYaJMT/Yx2vZWKKTpPyBTEQReVG1O6lzA7ML3YQKjqi4sTyOUztkiq5nGvJFtFsrJryBN2/obktN3smZoRjXK1P27MsyXr+9rcXqHEuXdHORlz1ZuBPrCi2s/68wXlRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GhmZXsNZ; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso17301955ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739896135; x=1740500935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZSFheZSQhhD9BZXFMBQVD0TW1CBXyU0mBPRkFUDMV8=;
        b=GhmZXsNZb/zuvVBqj8z3udk6yxnzpr0z51JAWAZWUgah1OMpyMuUp5O+cxnLPj0IUA
         1VY0h2t5q6mu3xM31cdhRr8Uul54gKUgiFm+M92aDgdYV36r6b98mh1OEUO8Mi2YJWBh
         K3MdLPG25wwwH8eAkvGDycb6USnzwrV8FxCJaLyi8xMCmdkcOSDXArfPq3+UxBDhiOOu
         Embpmu57d49VSBj5dfnBzFhCGPEy+VhKNcRsLeiZ/WSyIxzMwA9U+OsINBhVjI+erUbj
         jwVkBFLdEtvi+q583DR+pl1wgO7X1cyJ68qQsX/q/zbl7Gr0RcrhO6Z2IcIvl71xHqxc
         /zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739896135; x=1740500935;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZSFheZSQhhD9BZXFMBQVD0TW1CBXyU0mBPRkFUDMV8=;
        b=A8x22DFwtIq64nAXWiT7IvyLTNCkgFV1PwfwIV/DrpgZW/ZuqHpER5b8vR0Lvy4CLi
         VbXOmaC6Z/DyZdb16/VfBTm6a2vjaTSj9yR4o02H55SvgDzGXo6FCur7NRZDMnyDMjSs
         z9dPjfyR6OuSXv2hv+vqzx9iSLWhaV252aAffwxN+i3tO7komK8k6aztVMdUyTmICf1C
         x44BYJeAV5qZhkId1GkW0O2elwk4rR67yJFN7pENTJUyxLoE/ufmQzmMjbcMMbvCQbx+
         O6e1zY9SKNykxi47Bfxh1RHhSF4UZTpEs5F8HEnFbJORV4PPOpMS/cVSvgZOC5BjO/8o
         pDVA==
X-Forwarded-Encrypted: i=1; AJvYcCX06m9Ov0O2CdTZdmA+nlt7sE67dZJKvNy0gtGPbUw2fsSj+OAHXq1eXffDpoET8n3D7EKlAn4f0jUvIqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygbfsEwK1KfXPB2aFBOJNJ0ui6nqFu1xOvynrW4LTYsEie3Qc7
	uuil5k6WiJialQO7N6wZkHYbu3CyrEAn1Avs9oEslglHVFjW38Xskk+8ZlxSUmv9zdW+rm6UXjU
	n
X-Gm-Gg: ASbGncu9NJfjJkx4N5FQXD5K414m1/zGhaXR1nhQpQBqBVrEW29T87ZLh/C47R8k1/j
	y3DxJINOaqz7J6VezpufwH57Mo3SCpODIxTz5PLxGmVm7NFzecM8G/QDq4UHMURzruhIhNXH80+
	OMOjFTG9vW3D8okDKZ+imRyERkW+zH0fm6f6+QQNX+Q5mlBDuM1xyHFaElFuIfZVFv4c3R8eK/w
	XjBsJmE+r33GjJGw/rUSzlg4pCGhmlEBE+Q2AalobQrV562Aevk5tDPhYfXzmB6RrTolMb885h8
	t7k7lSk=
X-Google-Smtp-Source: AGHT+IFxS7BlF0CZIeMaviLLRr7C3mH9hEBNvjEDhDAhT5him999heZnOoe+++OGaPF1UldwWm0gGA==
X-Received: by 2002:a05:6e02:3103:b0:3d0:443d:a5ad with SMTP id e9e14a558f8ab-3d280771825mr144713065ab.2.1739896135029;
        Tue, 18 Feb 2025 08:28:55 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eea175b566sm827823173.137.2025.02.18.08.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:28:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Dan Schatzberg <schatzberg.dan@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>, 
 steve.kang@unisoc.com, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
In-Reply-To: <20250218065835.19503-1-zhaoyang.huang@unisoc.com>
References: <20250218065835.19503-1-zhaoyang.huang@unisoc.com>
Subject: Re: [PATCH] Revert "driver: block: release the lo_work_lock before
 queue_work"
Message-Id: <173989613412.1451056.13330550436881172975.b4-ty@kernel.dk>
Date: Tue, 18 Feb 2025 09:28:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Tue, 18 Feb 2025 14:58:35 +0800, zhaoyang.huang wrote:
> This reverts commit ad934fc1784802fd1408224474b25ee5289fadfc.
> 
> loop_queue_work should be strictly serialized to loop_process_work since
> the lo_worker could be freed without noticing new work has been queued
> again.
> 
> 
> [...]

Applied, thanks!

[1/1] Revert "driver: block: release the lo_work_lock before queue_work"
      commit: 02b3c61aab443d8c1cc7d7eb0ae0a8d86b547224

Best regards,
-- 
Jens Axboe




