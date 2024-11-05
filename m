Return-Path: <linux-kernel+bounces-396235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF2B9BC9C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95871F23433
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971C71D172A;
	Tue,  5 Nov 2024 09:57:30 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128F18BC37
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800650; cv=none; b=Nn2QDgRDnyGCoIv1eBjj3LO6yFsZuDBCt1ADWwirehtKWMo0TFC0TmJPbGrnNx0t8P6cOU0GvXgQdzcJuL4BiQtJ4MMbHgPOVSuwfi1CisrfG09v9dj7WO1i1SpbjTuXf45I0BXugKQzH/L2RtiSRJx7V9nV6VAEXO8ZmhptxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800650; c=relaxed/simple;
	bh=byOTkx0EzEdEdJZKhHGuvPX2Q0X4ki1yRyF+JES6A/8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Prp+61V8vvZFJ6kZAnf8sDzR9RhEzmuJ8XQ/wiGK0T7wZcpBvcjwY2GTlsrQxO5INB3qyE3Jfo1pZJrM0D9o7dAHgMN1eWdt2+fbbWFOvuyZ1UTTx1CD51R+NE0CStyJ30IUCzy0CAX2nTP0D82Vi3/swnE0bjXjZAdiOD9FeO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e59dadebso6396248e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730800647; x=1731405447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCnWayl5HDnsPKSwm5NjskvN9C+Ia9MDbyOBMDXho34=;
        b=O/pyFvVmTYNbX8xt/U2GEqweM2HppGRHqdfVKoYtaEUmRtviikwYYEIorjcuCh5pKX
         2koIrmX2Ene7beTnOetuqYiMAj9t5lZf6/eqJP/c/aRWBGu2pmdjDLezRcio0PqyR2+N
         RpuFXq5mIu7rbdqQAzb1ojVFBLno+feizlfXS0+iRQWIueRgCPmQkQ5yb2elEr4+dwtB
         b4g4s4ujfLpU8KHevQkYzZbxOQqKKeQB4AAV+iJxhjhaw2iJ5pFFJNo6IsFbqnLj5WVA
         18fSS3iZsAN4Cl2w9TnXfmYKvA1XICGXekWQWrZKGSlRiT64OrVCbmq586fNXKHx0p7h
         t28g==
X-Forwarded-Encrypted: i=1; AJvYcCX4HCczxy8ljMqx2zheEe4O1xbUiMoxKVRtQUlyGEfQvkQqlRWd33NfVlJj2Gjd5nFV0AJsOfL6eecj15Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW17L+MYYKdHpjrquFgnKQzfWkV6PGHKihckJh4eb6zDN00IFG
	h6F6r3U0aZc7uPJtZK1eYNoGOu6BWqnTyBHJe1V5mQ2AGMEWSZcf
X-Google-Smtp-Source: AGHT+IH+NB2SEGxay3YHCWsNeRNczqh5b+dl1BP+E73wOOU0kFlOG9dDMq5VmtsHrMQK1TsBs+F15Q==
X-Received: by 2002:a05:6512:b14:b0:539:96a1:e4cf with SMTP id 2adb3069b0e04-53b3490f291mr17818650e87.32.1730800646380;
        Tue, 05 Nov 2024 01:57:26 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e771sm15700812f8f.81.2024.11.05.01.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 01:57:25 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	=?UTF-8?q?Ren=C3=A9=20Nyffenegger?= <mail@renenyffenegger.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/tags.sh: Don't tag usages of DEFINE_MUTEX
Date: Tue,  5 Nov 2024 11:56:37 +0200
Message-ID: <20241105095648.1472862-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Curly braces expression expands to "DEFINE_TRACE DEFINE_MUTEX".

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 scripts/tags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index db7972b6109e8..b212363779980 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -260,7 +260,7 @@ exuberant()
 	# identifiers to ignore by ctags
 	local ign=(
 		ACPI_EXPORT_SYMBOL
-		DEFINE_TRACE
+		DEFINE_{TRACE,MUTEX}
 		EXPORT_SYMBOL EXPORT_SYMBOL_GPL
 		EXPORT_TRACEPOINT_SYMBOL EXPORT_TRACEPOINT_SYMBOL_GPL
 		____cacheline_aligned ____cacheline_aligned_in_smp
-- 
2.47.0


