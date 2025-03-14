Return-Path: <linux-kernel+bounces-561802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F6AA61667
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2B03BDE08
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA8D204C1D;
	Fri, 14 Mar 2025 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1R4mrCy"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259892046A9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970190; cv=none; b=btnd4WdDa3cp9aWZdiAjBmbrq+lwex0jh5BOWgC1nL+4pTY3r+sW0cIxNulUae0HybHa0tMz+7C6qHGkFmrC6c2LrGVg4DEKcpCg/DI4QKZwD1RgFyMLb7s7mHgpJiHsApY/x06HKH7yek57DSkVl1Ozct8gogUFuiwUP5GLCp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970190; c=relaxed/simple;
	bh=tf8viaA8TSt7KEXF0YCkxqhusUddFUMNOwh9LfMwBVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oI3bVz/IKTfiavqCfDQ+H2qH7WwBmdNdHC12PNTdpfIE3GQcRPicQ1PXqKlxc/i1uLFhGL/gv7uiEbuvoZIRhWGmDGOUxco4hf3pgFfYTxS8jfcOMH10M1qtXf7UyLtvzHKRFET9Ic7a0J9GVoi+OciimMNXwBQp0PoSvrFvoVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K1R4mrCy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so21595295e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741970187; x=1742574987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFQ2HcBNdMgNlOvbPjBVDvOsboRXSnkDaPC5bffTGtU=;
        b=K1R4mrCybQlJ9n2cSasIPHwIq2V1MAK4I3mjyuTKtGSIDY39cqd166PKMmMnT8tu+m
         /sPoveNiPVRkXuuhoQVewFU0fmiGVWfsYdv0X7E+IOtHnYHWslAsK/68Rq1ygsxyedx+
         WEwCzd3Bdbj0PwpAO9o+zFBd4VV0pQ0uN8IBBaY04J7U/2RKKOWlOqX0lpqxJynTXmyE
         8ocqsFzAGLpbk9f1iBmLsmOxlEJWrg2CO+Dw4PiIG6cWKpS0nTxyFXY9dObfVacXW66M
         WbJ1aNAaPk1bwfvVEEYN4mTjh9RIqCYyM7oFddTq90hFqYnAfNVoqicXhnkOD5MMGQ4M
         ZBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741970187; x=1742574987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFQ2HcBNdMgNlOvbPjBVDvOsboRXSnkDaPC5bffTGtU=;
        b=lmDMEhoNmY9C114rzeLa5oQHZwURvuOiedoHk4UZtC2QKCCHZruB4AW3Vw3CN//EcY
         fhAjMwdN2HPuaXZQ74Pcppd9m+NPchitlJerG1JGQRIzb63w1kXcjpoxxIWNpwgBULPd
         SZ31RGWom0GkL8+5xWPdNOykbypTAkxj0FnatG9vOU6mDpBRnO28FcDyLEszohEMKIKC
         cNyCkDTqQTwzHcw458MLobP2/AmHoOxD67PECL9xyKsSLmCANsNeew4HF3YvrEw5xbLE
         9Efj+1Dv+AfaafNrUz3/m0JunztTprQyXhIfHtovPnxdLWUgfrSjAoPdhNAjBHTg95QF
         86Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWn60X3obGMjFqHZpFVnolPKvaXGA41kCXU9btiNHZ7ODyfMy0nbpwb4vq5keBqEb/LKLS7GhYCQ7Q/jac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAqaj0DsV114iCy8dOi2LcEIJraelF+5ONR/YFLEJnjBesBad2
	+t96aLvqf9H8EyRHDPZJNvwfH8cg1CKYsBsLJGxNBaUwbl5v6zRw4XGtnyaN4Tw=
X-Gm-Gg: ASbGncv8FhwYv486TwvxK2cWz1OUkfOto1wL2TRere0TH7BLNsSSusy4QU921J1zPgZ
	X1kWbdawBhNRaHM7jyj468UuONt4z1FiZ96+iDnKzfHWuViPaWLEH59WC/zkN8WgMlbqM9geA3I
	pSmpwZcQV6nRYAanH/RwSMFkvMwZQFGmy0zCJ1rtgYb6CKfEv+NBz8/UxyzaYkkBR+BF3YtA6zV
	Omh7vlnif2pG6KESJE1hTSD2p1zog4m0miBv1QoeS4UrjFwea4jb8Y05/Zvx/a3tnROkHuf2bS8
	Rk99VxTyWwb6YOHPKVvpoOwwYY+1tHakkts2POqaQ4qTpS2cRvdp
X-Google-Smtp-Source: AGHT+IHwqqbH2KKThrp6aGD27BgSua0fDndi+WcuANf1Nfq957/kPQaVHQrKzQn6hgjv6J0UTw96fQ==
X-Received: by 2002:adf:ab0b:0:b0:390:d990:823 with SMTP id ffacd0b85a97d-3971d236f2bmr4341287f8f.13.1741970187365;
        Fri, 14 Mar 2025 09:36:27 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:329b:9a6:20f4:3754])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cd78sm6072925f8f.78.2025.03.14.09.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:36:26 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com,
	pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	christian.loehle@arm.com,
	luis.machado@arm.com,
	qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 7/7 v6] sched/fair: Update overutilized detection
Date: Fri, 14 Mar 2025 17:36:14 +0100
Message-ID: <20250314163614.1356125-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314163614.1356125-1-vincent.guittot@linaro.org>
References: <20250314163614.1356125-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checking uclamp_min is useless and counterproductive for overutilized state
as misfit can now happen without being in overutilized state

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 81b4d09c6c5b..761543a45510 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6833,16 +6833,15 @@ static inline void hrtick_update(struct rq *rq)
 #ifdef CONFIG_SMP
 static inline bool cpu_overutilized(int cpu)
 {
-	unsigned long  rq_util_min, rq_util_max;
+	unsigned long rq_util_max;
 
 	if (!sched_energy_enabled())
 		return false;
 
-	rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
 	rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
 
 	/* Return true only if the utilization doesn't fit CPU's capacity */
-	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
+	return !util_fits_cpu(cpu_util_cfs(cpu), 0, rq_util_max, cpu);
 }
 
 /*
-- 
2.43.0


