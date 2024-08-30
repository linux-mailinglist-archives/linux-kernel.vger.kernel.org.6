Return-Path: <linux-kernel+bounces-309065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5689665C3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C353AB251A9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFA71BDAAE;
	Fri, 30 Aug 2024 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/mGcIBn"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A6A1BD50E;
	Fri, 30 Aug 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032025; cv=none; b=KJmqG4S23w1nQQPFdMEDg+x5XEXpsXZV+bha7I2mfIxrzUoc4pNih/hJ+AgK4+wQXcu/siUk5IMJpGC3ri279UiT6AiVfJLbXQa/+fWhkqPsboNVFir5X77lsn6djDcBEgvGY61EFcUit9Zb4kaC3C1KIdThyIKfSQTQzArPeRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032025; c=relaxed/simple;
	bh=gRLVDlLtYtEHFRW+z5u3RzqQq8Otkw4nKdbnkHz4B9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxB6yhYp0QEQAQcSbbxC05Cp/cMnTXku+vUIrLSwVu1RSGHNbL1X4YXF58ssfvKnKVBmbGGi+JydkMU0iwGU4aQdR+D2etUp9gIYU18ZfihmPy9Q008O9KyM4GV5jipOsNT4H7OeIPArtccyJa0Sm9hZeC37uEylJMEaowwtKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/mGcIBn; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82a29c11e1cso27834639f.0;
        Fri, 30 Aug 2024 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725032023; x=1725636823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRLVDlLtYtEHFRW+z5u3RzqQq8Otkw4nKdbnkHz4B9k=;
        b=a/mGcIBnDw3jiEjfU5gL0G8PtlEu9NIYgDCFDw08EUG+3NnxgjrlduosK041/fax8F
         ytXFONG+TGfapnlJK/Flnr9QVBi+WYnrUhFGpqosFWa9oYxCC1x4YTN9BJonlBKPVvvz
         9p8kO8EvV5aIb/3OAW4YYnEb0F/inG4e8VuO1z4dmDlgH8ILUuAl+7vwIRqSuaJn626F
         Tct2VBpl1pZFSTj9WBib5ujn6YnHW+W2F6ghOjEfcrAYOfaz88WNkEXzHHXT/BVBRNRI
         BL+9LbbnxMTdMSNQRmYvbjP8uTiyoNBaal5c9Z4MM8HkwRvQyMUeNE5EJyc6emvGy8lX
         L5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032023; x=1725636823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRLVDlLtYtEHFRW+z5u3RzqQq8Otkw4nKdbnkHz4B9k=;
        b=t9wbEsugNcuKg0AQuDsBissQ7Ex3hear1KnRE33AnhCParAOqyioyffCuAB7wdAAYz
         y2UgWdxkKU78b5DghCqZtGyj7i3VYZTpRzXPib+w0iv9guZ2zCXTAq5xSuTYMLDGN+Sv
         9SKa/pBJayjFk+ucTTT8nHyfzme+FSLsFQulb99pBzq/1NA/4lldshaW8kkis+qBBhIn
         YWe/psHBbn8wi18lUtKDJTfArGqZUh2g1PQWWMHcgab6auYLNFHEdyWfb68n7wdO7KSJ
         DI6Upb34CW50Kq391nI8W1zkW5bT3UVJGPnEi7RCaOotqKGg93K3Jlcv4BZRcYZ8vd/r
         f9kg==
X-Forwarded-Encrypted: i=1; AJvYcCV1bst4eSmEeaMLcKtexz9XQ2s0LQzJzaF/q/3n9hWd4uUNiynMvYwORVI4q1y1+h+DjV5sNeI/m46+@vger.kernel.org, AJvYcCWe3CPmHVc04V5ee179+b08NnNsA77aP5N8FO2//KrINZ4hVNOaHJ+BfTEETCP+PrYt0PIEDAa+r9Bry36r@vger.kernel.org
X-Gm-Message-State: AOJu0YwHmoj5Pz2oIaCdtnawzGI8mVlK2tnaCpLO7F6jKNwSlZ/9U6nO
	+WYzXmeQl4H4qywE39awMDKDOBrJb+ZpekTVITM2l+6z1QpS66rkw4CJ5AFb
X-Google-Smtp-Source: AGHT+IG2cWkWM/nBFDX7DVTMBeL0INFhcJoxGS1vmbMD0g+wj0qZPDln60G5qlg6TvjRsKkG7WqZgQ==
X-Received: by 2002:a05:6602:6d0f:b0:824:d9d1:e67b with SMTP id ca18e2360f4ac-82a110478d8mr615310639f.8.1725032023266;
        Fri, 30 Aug 2024 08:33:43 -0700 (PDT)
Received: from localhost.localdomain (174-20-195-90.mpls.qwest.net. [174.20.195.90])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2e96209sm781045173.91.2024.08.30.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:33:42 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: shimrrashai@gmail.com
Cc: Laurent.pinchart@ideasonboard.com,
	aarnoud@me.com,
	airlied@gmail.com,
	algea.cao@rock-chips.com,
	andrzej.hajda@intel.com,
	andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	daniel@ffwll.ch,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	ldearquer@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	markyao0591@gmail.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	tzimmermann@suse.de
Subject: Re: [PATCH v5? 0/6] Tweaked basic Synopsys DW HDMI QP TX driver for Rockchip RK3588
Date: Fri, 30 Aug 2024 10:33:29 -0500
Message-ID: <20240830153329.9170-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830152132.8894-1-shimrrashai@gmail.com>
References: <20240830152132.8894-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Geez, my email system seems to have screwed up this submission by
duplicate-sending messages for some reason. Just FYI.

Shimrra

