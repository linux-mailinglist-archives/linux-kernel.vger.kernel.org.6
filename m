Return-Path: <linux-kernel+bounces-328896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209FF978A92
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A2F1F247CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05975154C04;
	Fri, 13 Sep 2024 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4VRk/bV"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE21126BFE
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726262892; cv=none; b=lnFWlS+1XhuDpsLaoOS2q/AlhIY/CUb7+6HtPXwOYpWz13fyZmLrhQV10NdWgJVoVkuKb1Xu9vVRuIkW5tpHpe1EM4Hh3jyPMCYxcrUswHaUCzPD/IfdkuP63lNfogkeWvg+qS1SHCaEO5lD0cTiVUYTUxs9az+uK0/WlSYiWHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726262892; c=relaxed/simple;
	bh=ZMl7vUoztAbjdUZRxOYMKtukZUb6V244faNWg/3AvyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3dQuhhSbNObegZbV0QSnpHhnNFuTaJhUl1xqCA2o7eos5a+3poIbeJ4Tmv26MR8EEEeXrV1KwhJF/+KF4AL38PPs7Y3J+b7Vhwsdl0cDhVVWtKX3DA2XnoeMDNbWF3ODeN/UoFb734o2g8Z/qt8P0cFsUk3w8zV5e9EH39E9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4VRk/bV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718e6299191so1560153b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726262889; x=1726867689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qCOzp6QHBfvs6xs4vpuMqr/hEn/jvY9MoT1Ovg5yP4w=;
        b=U4VRk/bV2vXnANQacnpuMT5AAQ7aMvp0eGd2OCTzrzWqj4Fl8Otcf4EvHwZnQ0FBeu
         t/ueYLbNy4IDLNVvynJZyF2RkIRGMAw8qrFm4+EOU7SQwq84iQvYEFgU6jaEw9/rvip+
         2WCwXglhGeJ56PnAjxXF4+aVuZHZ415RosIlieZprF2zfeA+WSy1b8jG/I0GYe35ZSuw
         m+ufDx6kgEBuFinXfAMmrjwPAhzQkCfrmTl/B1EEEmwfMGIiQd24pJN/jioPQs2DIY3z
         mic2FioTd/NS1fFS/8MFiHX+D6yT5tIBLEcbzMqKLwlffeuYwQkgSqWJJ5Z9uvfLfZwD
         LJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726262889; x=1726867689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCOzp6QHBfvs6xs4vpuMqr/hEn/jvY9MoT1Ovg5yP4w=;
        b=ig8xf+wwPXpSFKBsLUTgWllGkFmCBzcxrq3XibBPI5q3wwWEctWyczBqVv8KEop1qI
         gsbE7JJrsKvCCwtZZwpmqbACwxSI+uwPtmrNpW88FUC2aEJ8nJfekm1JlI2fmrJTmVSQ
         Nfpe3Wb7owM+ouir9ajsFqXttvA8Qrfe/SvcJlTg95DOm3FOunONVv63gql7Vf13ISs4
         X0RUjJv+WLfmmK98cbg4hRI+NVSmhZTwuSlG9TtMasP3OmrINSQ6WnOgN2LnwU2nTtpf
         L2rbZLtI5KaYhYVp6WliJbxqQ+ZULev8/oCO3uO33aH+DQyiUs9PkbudTmbURFWkN6AW
         2bBQ==
X-Gm-Message-State: AOJu0YwESUZ/i9CUYWK8KTkuhPsKubaNWq7oIHHYqJiDiDIE7wgAFAOl
	XaDRLZI5r7NUZ3qhG70AnxTNqEA7iPyhsdeF8N8Yt4m/hBx7qGWpGqLxfw==
X-Google-Smtp-Source: AGHT+IHoIc+VzmKtdSdpfYPMtlZ6TXSlAIedYL7M5X4chvT4UMYPF2rezcdIcQH4wFe0atzcT05fjA==
X-Received: by 2002:a05:6a20:d80b:b0:1c4:dfa7:d3b9 with SMTP id adf61e73a8af0-1cf75f0051bmr12320667637.28.1726262888631;
        Fri, 13 Sep 2024 14:28:08 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:aed:aa32:e7d7:7fa9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498de2d5sm89070a12.15.2024.09.13.14.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 14:28:08 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 1/2] mkfs.f2fs: change -c option description
Date: Fri, 13 Sep 2024 14:28:01 -0700
Message-ID: <20240913212802.912131-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Current description confuses users like they can add addtional devices
with one -c option using commas(,) at the same time.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 mkfs/f2fs_format_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index c98e73c..2ba1c21 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -50,7 +50,7 @@ static void mkfs_usage()
 	MSG(0, "\nUsage: mkfs.f2fs [options] device [sectors]\n");
 	MSG(0, "[options]:\n");
 	MSG(0, "  -b filesystem block size [default:4096]\n");
-	MSG(0, "  -c device1[,device2,...] up to 7 additional devices, except meta device\n");
+	MSG(0, "  -c [device_name] up to 7 additional devices, except meta device\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -e [cold file ext list] e.g. \"mp3,gif,mov\"\n");
 	MSG(0, "  -E [hot file ext list] e.g. \"db\"\n");
-- 
2.46.0.662.g92d0881bb0-goog


