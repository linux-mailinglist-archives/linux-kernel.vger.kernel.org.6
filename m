Return-Path: <linux-kernel+bounces-543293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B95C9A4D3EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65FC172F9F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF9B481C4;
	Tue,  4 Mar 2025 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="bnqZxSVb"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591791DCB24
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070013; cv=none; b=pEQ8CCkxRbVQoDHsZenfdYvPUPF0UxX8Y32orKueQjUscwGIHHGPnAajS70tLSFECslgM4imNBOFwwehpl1AUbI+qvrBK1mJ2nAnEn/FS+VeCoCCIrTNq6DZRHYOgh+VcBP39pRmqiXX4r4Fq7YHnVv0G4u6Y4HH9ryjR/QeIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070013; c=relaxed/simple;
	bh=0L9jk7jDl4R7Tch+PFoZUAPpOUQGpTxhl+ZUFKtbat4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YH1T7gXHs4y0wpeQfnY09fD6RIZNXQPSPQ/HEVA6OoTmhsCjHrDBUm0seN4U2DULmhc0Ogcx+AfNfsch6JEeL4E1IUfmvpItszHqgnFEjKWeky+jHAphql3mPjT2jTzrJ7i4OV18a85dPwG14WH6V9zhCwSoK4D5rK3oxEl1VEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=bnqZxSVb; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f5507a09e6so2593264b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 22:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1741070011; x=1741674811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L9jk7jDl4R7Tch+PFoZUAPpOUQGpTxhl+ZUFKtbat4=;
        b=bnqZxSVbDFqNV6psdfJMuqY7320OSzHiUmp+C+40y9qH6vFrEW1Ssl2+cLGfQrGruR
         PUFWUTx/EEsgrFP60M4b8YzeoNqeiOM4bbc0OO2GdNQzkyKA8DhXKNK6DlVcPl7TtT9v
         fMdX14sFXve2KCPt5IMx/aa+EGDgyDX3zAETAScAT7miq97JiFTqVAxQ05Lvm/+LQ2Vj
         kDL7Fru70kaDNczmGIjVDFLa7Mkh4xrg5IVn1QMP9MS1H+xaVGv9jcbaeYZSAELWHVUu
         mQBwfJ4v6jtcO+OdErZExycent1d0c15q5JkyPUomkW7u7GVzPuRVOO6nFR3GUUga5uS
         I0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741070011; x=1741674811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0L9jk7jDl4R7Tch+PFoZUAPpOUQGpTxhl+ZUFKtbat4=;
        b=mJjvamq4zEHYBkIYCDSxWMbIqPF4H9NM1l45goXs3O8rndCgOFJ/hVnzu8/GWaXPzF
         TKB1Yrn6J9EiB3WT62MxbiI/l001yEgGpFf+FM/eVoNRejvpJnFWEnQvb/Qk9zc6j0AC
         888rKypqdb2XhWKCL3uPH1XzkAPm6m7qHXEETW6aaYTKlOB9GQiHP0DH6cRhZrWoSxKU
         fy9vXZPgSYZALkHkHKBKT1qpY7K3wqAwE5GQc71yjOq5x+mUaR7Q5LRNRlBgVmA39HAX
         Lto/ARSvvU/XbgHdvJy65Ks+GpMrCQO1Sj6M2LJrH2FqlKZzdi5QV+thud5czp6M4dow
         4aJw==
X-Forwarded-Encrypted: i=1; AJvYcCV7DJqWM86I6DXtOxYwgEL6CTm3COqYUneT9MVpbY8kiv9eTUBq44+zSLPFUnnFfaQvbHnZjzAOUcVn47w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wiacjrIgfR5+5VQ3p4DtPjMSw4HozpaDVhFx7y902FwuklOF
	rUwAz2FpcCapQMo3f9LoJih5mHfGK9XJMJv6C7jv1NlwJgLYHluuL2F0Hf00Ov4=
X-Gm-Gg: ASbGncswlqmIBsUh4R42QKx3fXzxrZi5KUDM5vDRkfJnGbG0BrqXCaVJt3l6BitXHMq
	eh5JW7p+H2V8R9BdCLIr6mSne4JZvSDGfIknh/Yq3ZJ3trasePEMrbdyI0GR2tTgglzJc4C62n+
	TNdLtdmic5dqgq2gcDcuFonN4wrDXfVBrVRXyViPwNvQxDkZnBJJHSnqd9Pfp6KrKTMF2uqq162
	0KTY7w6/x/lm1ErQgjf5ZzvwnANd+PV7yIJB+4vx1iZ9J9EZIM9JJL1GgJMl9X9pe100Lf2cCoz
	uTAA1UJMbOS7VJ5LxuNAhnCozhzrpYFV7vDb4icL47hrLNes2YRgrEvl+x7p5JRNK14GgELV1CM
	WiCQMZW9nshgj
X-Google-Smtp-Source: AGHT+IF836u3HRurnaD3JNQQMkTOVJFkdb7saaYaAdjJKb8CcB9Uh6cD4rojnwwaZzpJu95yORRjaw==
X-Received: by 2002:a05:6808:2e96:b0:3eb:3b69:8ff4 with SMTP id 5614622812f47-3f5585254ffmr10749480b6e.15.1741070011245;
        Mon, 03 Mar 2025 22:33:31 -0800 (PST)
Received: from localhost (104-48-214-220.lightspeed.snantx.sbcglobal.net. [104.48.214.220])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3f66e8449f6sm539684b6e.1.2025.03.03.22.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:33:29 -0800 (PST)
From: Steev Klimaszewski <steev@kali.org>
To: hzyitc@outlook.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/1] wifi: ath11k: pcic: make memory access more readable
Date: Tue,  4 Mar 2025 00:33:28 -0600
Message-ID: <20250304063328.33762-1-steev@kali.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <TYZPR01MB55566065525ADA7F71F516D4C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
References: <TYZPR01MB55566065525ADA7F71F516D4C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ziyang,

With this patch applied, on the Thinkpad X13s which has an ath11k, I am seeing
the following:

 ath11k_pci 0006:01:00.0: chip_id 0x2 chip_family 0xb board_id 0x8c soc_id 0x400c0210
 ath11k_pci 0006:01:00.0: fw_version 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
 ath11k_pci 0006:01:00.0: firmware crashed: MHI_CB_EE_RDDM
 ath11k_pci 0006:01:00.0: ignore reset dev flags 0xc800
 ath11k_pci 0006:01:00.0: failed to receive control response completion, polling..
 ath11k_pci 0006:01:00.0: ctl_resp never came in (-110)
 ath11k_pci 0006:01:00.0: failed to connect to HTC: -110
 ath11k_pci 0006:01:00.0: failed to start core: -110
 failed to send QMI message
 ath11k_pci 0006:01:00.0: failed to send wlan mode request (mode 4): -5
 ath11k_pci 0006:01:00.0: qmi failed to send wlan mode off: -5

I'm pretty sure this isn't supposed to happen?

--steev

