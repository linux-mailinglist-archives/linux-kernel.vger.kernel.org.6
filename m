Return-Path: <linux-kernel+bounces-265376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C39093F047
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB9C2821A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE15613D262;
	Mon, 29 Jul 2024 08:52:25 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11DB139D12
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243145; cv=none; b=B3/jZsZTDKdF65HE2V7q08esNZKmHjSHzUuDM47JhEWEcDfmRx5Q3w/Pg1BU+Mpogic/ZAGL2nEubyHPDzUTuihFlLjo/hekGlH48jB8qI5oeZekrEiDiNtGaTm54wtiE3+1ioFn8iuOqIql4AUV7szHzcPsCTGTEaqAUfpEXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243145; c=relaxed/simple;
	bh=PAyLESBbKix0qEIp9rSTRPzdKO+sowkieH9xlGhuq0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ii2qW0PvQN1g9IiY71kM0v3+AnOlo1/ysYqLAj3iqxGRZnEAFJeDM7yGl4FUMiog1WPC09DMl3CdW9PB/nmEy77QjkVdKWgahZcrnWSQ8KWtrVcyqSEmrYwCq1xlU9AJ3UrzhErERRYhNXLns2cOwmpe0/9MIPrV07YQy+9iN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso426814866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722243142; x=1722847942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHpRdMquexYL0XNnvqraXblRy2YPPyiTKyrHu9LJ4lg=;
        b=fKe1ASB6TLv0O+AMEHkYLeJkdumwav2qeEirxkqabWot3Nfa5JF4VZqQNnpUzzsVQk
         dvhSTROQJ4bMecGQ1HSvUD8Qwcd7CwRX0OtpRP8AgTbxZBDYOYmBcmqtx5W6vq5zOzX/
         6Mho/TWjlKqrEL2Z05yv9DF4tUR3sYcZM16CcbaNCSvPmuLGdQTFmK64GkUS0LVA785v
         WiVvsTfJCMP1FbrACxXvsLNGzUMeE0AhGIF65eRPDYYBBPbJ4fB7AmPcpePnk17CpGOa
         V4nxc4pLpqm8w4+47TGbPuI8FI/pKipHMWQd20LjeLN2/GPgyG4m+MSNBjofw+O2+icd
         OurA==
X-Forwarded-Encrypted: i=1; AJvYcCVplUX9l3V1q6MkTBZtwoRSztmtTkL06fhaSZVgRdalCX+SQuyCDv0gQn3ZQI72Mvk/cp5au8ML/TkKw9EAcAspoaHY0OhgeBflSMVu
X-Gm-Message-State: AOJu0YxAa4w0/M6e2+GYYRYPuWd5zsJ7psj4gNBTZy4eeazBuRpj25se
	hNzDW4GBJnX47JkilSSnO3Pjy1Z9ZT3gwyseDzyhKv58pneErNub
X-Google-Smtp-Source: AGHT+IFEplYSUm9mc/rcfWZBMVPW35vlqJqabXjXoKKlwkATpdqhY9CG6bmyA+0dUjeOw5FQVo8DkQ==
X-Received: by 2002:a17:907:9705:b0:a7a:9144:e24c with SMTP id a640c23a62f3a-a7d3ff7cb59mr318541566b.9.1722243141738;
        Mon, 29 Jul 2024 01:52:21 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad92ffbsm483793966b.171.2024.07.29.01.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:52:21 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: akinobu.mita@gmail.com,
	akpm@linux-foundation.org
Cc: leit@meta.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] failcmd: Make failcmd.sh executable
Date: Mon, 29 Jul 2024 01:52:11 -0700
Message-ID: <20240729085215.3403417-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the file permissions of tools/testing/fault-injection/failcmd.sh
to allow execution. This ensures the script can be run directly without
explicitly invoking a shell.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/fault-injection/failcmd.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/fault-injection/failcmd.sh

diff --git a/tools/testing/fault-injection/failcmd.sh b/tools/testing/fault-injection/failcmd.sh
old mode 100644
new mode 100755
-- 
2.43.0


