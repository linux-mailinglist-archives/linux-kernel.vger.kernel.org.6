Return-Path: <linux-kernel+bounces-188321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53358CE07B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6034F2825E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BDA39FD4;
	Fri, 24 May 2024 04:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBOeNq6E"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691603B2A2
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716526431; cv=none; b=BlG6J49gG06MQyVkrOhb02CyMwfjemo7Rpd7csC4zbV+NM31ZvWV0R3osuqUoNn8wlmSzjOdLzSAv4D3fqrD6I57ALK5veHUF8meDHuu04YrLIKSkcB15mzwNeYb8A42bsOqI7qJf8pB7fV8YlE9MfDuwDtZEB3anKyBcLjzfro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716526431; c=relaxed/simple;
	bh=W4PZRMF3pYw7PfOMVR3ls1tl7pJXZrQ7WZZ1HbnHHuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dXpbAfse7vvqPrsUuUYNqGwglXD8rA6SRR5dSaMgbx66HDgsgnXayEZG+VwpASDeTC0/DhmnJRtgXrkB4Lk9tsoDdmWAeoT0WFGaicz4sX1KcriR2nxw2cDZejm8pNA/yiFXDPDrAtO45Zdma8t0xFYlHAHOJok/CoCyn5nee1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBOeNq6E; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f10092c8c7so4342718a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716526429; x=1717131229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydgCiEw+d7FGMpBEv2whnd2c7uwXHpz0XrQz73hbdYw=;
        b=aBOeNq6EqgHIbU7KtR9jEcqZE+nNd7cun4NQYkMDXc9k71zGumC2nG5z8YFY3cd1LM
         l/1XbrwbyhvMQH8sonzp+PWNJwy9FF6isNI0NmoGBBEk5sJqK6F/w8Pb3d87kB2IsytS
         9iEQF/wQ+TNoUKmSLYaGqPOto/mtiBeWlwU1ZbL+roa7kxGLqc7yj98FkaZ5O++I5vp2
         uG4DIubPd3orbejfTtBWWkCeRoSXiCMUUpUGmFCdxKO0SSBqG6dGLR9vFpqKaMfDmkWX
         NLWd6vkmeEeF77eL7l7PZupYVqB+9vkpXB2bcNwuJBtV1uwS3hMcZjqeg4QwVWAneMjF
         U3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716526429; x=1717131229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydgCiEw+d7FGMpBEv2whnd2c7uwXHpz0XrQz73hbdYw=;
        b=EIOrtb3RXwXuyLA9CyCFf1PuVulXZSGJsftdpT/WJYpuKc4bh+Lo+j0/gUs5Cu8RPn
         crSailgKzec0nHVJF/UwX6v2R/gRWF7vssMyC1UQGNmeYFdCC7qsQkQteRyfhfczuxsu
         4STQqc4JNVQR7JkZ89IdoM9BnlpxF/uSOAOkQWFhlTF/OBlfjoxJUskiOnrxrQn+7dkN
         L6vokWCPUUuhpoRY9C2t/olM5TPUNsvX58XYZRab7oFaKOypqbkOX5a5IUOipjEe1MqI
         5A1JOSp9N63qNORibX/RuoorHoyDs1ljhiFIRyhvTBhj9YzwzIO+k0jOt//J4QjBlbOt
         ewKg==
X-Gm-Message-State: AOJu0YxajT+aXm/+N3CTaJKLRY7hSlHwkmri3GOvaL/1WXkkuNXHR8G6
	u8XXZLHqW9XwyGcZhnFiNg3BhHIMuIIgHXchd6pWYuuPuB92N7uS
X-Google-Smtp-Source: AGHT+IFHl+VU6BlebBwW/umzEPmhSCn8pkh5r06teC6Kxgk1GYsCZ0GArXhRobBoTGeH8vRVeY2bkQ==
X-Received: by 2002:a9d:5d04:0:b0:6f0:6361:2d86 with SMTP id 46e09a7af769-6f8d0939523mr1561590a34.0.1716526429492;
        Thu, 23 May 2024 21:53:49 -0700 (PDT)
Received: from localhost.localdomain ([223.104.43.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682274ba9edsm362179a12.90.2024.05.23.21.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 21:53:49 -0700 (PDT)
From: Xiong Nandi <xndchn@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	quic_bjorande@quicinc.com,
	cmllamas@google.com,
	quic_eberman@quicinc.com,
	Xiong Nandi <xndchn@gmail.com>
Subject: [PATCH v3 1/2] scripts/decode_stacktrace.sh: wrap nm with UTIL_PREFIX and UTIL_SUFFIX
Date: Fri, 24 May 2024 12:25:59 +0800
Message-Id: <20240524042600.14738-2-xndchn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524042600.14738-1-xndchn@gmail.com>
References: <20240524042600.14738-1-xndchn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since System.map is generated by cross-compile nm tool, we should use it here
too. Otherwise host nm may not recognize ARM Thumb-2 instruction address well.

Signed-off-by: Xiong Nandi <xndchn@gmail.com>
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 scripts/decode_stacktrace.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index fa5be6f57..2bc3a54ff 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -30,6 +30,7 @@ fi
 
 READELF=${UTIL_PREFIX}readelf${UTIL_SUFFIX}
 ADDR2LINE=${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
+NM=${UTIL_PREFIX}nm${UTIL_SUFFIX}
 
 if [[ $1 == "-r" ]] ; then
 	vmlinux=""
@@ -158,7 +159,7 @@ parse_symbol() {
 	if [[ $aarray_support == true && "${cache[$module,$name]+isset}" == "isset" ]]; then
 		local base_addr=${cache[$module,$name]}
 	else
-		local base_addr=$(nm "$objfile" 2>/dev/null | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')
+		local base_addr=$(${NM} "$objfile" 2>/dev/null | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')
 		if [[ $base_addr == "" ]] ; then
 			# address not found
 			return
-- 
2.34.1


