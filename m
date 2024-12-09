Return-Path: <linux-kernel+bounces-438135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AEC9E9D51
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1CA188861B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F361B4256;
	Mon,  9 Dec 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kZw4Wtol"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED13143C72
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766330; cv=none; b=gZgLprMVtC7m9xMUckSXD0pXJLkLzPnbqC5CrWn/2V5CbK/GnLITKD7UIdUya5Ld4T6w3KOcDmrrglpPzL8WWCIZoqL3+8+RyRbD2qWPV9RBU1hEBGQC9GXeGayTiuaqWryowtSLW9sBpcCSNPeL2eNMxSC8+1spnpFLdsvOn4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766330; c=relaxed/simple;
	bh=EFAjM7mDBisulQfKuxbXf4OGWVGV/SLLmMrXbHhA+MI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNjy3EjTh9+9zQ6LLpdM5H471wt7xFjZJACmPk8pCY7lw0uwqMQ7By1RUKmyEy30etTQ54vEhOk0ACr3OfxL7nmqrO1lt8f/goksc/eASS02+p9Ayy0MTh0LnYClpr52k8+qnIUQkUkL9laPniaNaivgsZv2VGF1SwbYaUcZbyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kZw4Wtol; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so1097172b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733766325; x=1734371125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7t8tuWm57sLbbvF9Is8tIuafHTVg4xWgJ7ckN7IcKD8=;
        b=kZw4WtolMyeon15XUATL+v02c7cxzJJvW8lTWyD+9IIqTdRl806308e2jCbqo7id71
         PNwPSAwiWOyfIrZY/sS4CWWSCp9jsUny7sSE3VsyNQOmy4MOTp2zsuuviusbf7SZSVLi
         x32Uk992Rv7m5J3W+26ohHSEsQn2f7CxNi6D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733766325; x=1734371125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7t8tuWm57sLbbvF9Is8tIuafHTVg4xWgJ7ckN7IcKD8=;
        b=EG9ox0TYbCziZe1Ay6j4eO+H5SZQ8ga3GWi//2C4IcwUmKzPH/OYh1s1JUtgVLIx/D
         NidcAm4ks0IkP4n7upW5+gbieOgBdFUhmcOtzBICzXDYdAPhQQwvu/tp/jnxANXlzYpS
         lvu8FCwP6lrCzWHSw0Oo+fH21ZCPqPHs6JdPqPR8roP+iylTYEY/T6MqLhM/uHkeMo7n
         xU2FI9gVOXg/22172WVDSxDTaSOghL8Rytuh4/dQRf7Ig2btphEmgJokQuotEMBjGoRf
         WwzaZk9PX/+8L3tKbuWN6TFP4mfDFtMGn5uv6XjMXo7Iuc4zIu36UuwXAmvzPsHYxYqo
         QzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwKi0FthnStY+Oaex2GV0UzTzDbapsTlnehbG0N9cx5RE6UDzsLu1dqtT+/+POxmOp9xw7rrH6KtpRfNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6mEMuL4Bb8JTZCDw+Nl3KQESpBVNiApImeH2e7iG5sMRIRVs
	PwlUKQMeUYUthd2knAXLkKZ8L2L3dL1fvFpAEsWhIErQUI55Xuj5bs6hW0af+g==
X-Gm-Gg: ASbGncvmTR8DDyCfSn1Cu7lxddhWqh1otbSQMKroqocyG1aWBd1uRJjFWefQvecnkDw
	jcGjUPlFs1Ozcui552iM9Dn9SR+SMYUxkd787XjHFUKHPU7649DJ6A27ykqzNvfd0dvLxQpJbG0
	cdUo5HJJNjVSIhUnEnft0casfJl/tk+kNgLuVX7L6aU/6hymfluQLZkfewpTNmbNqpw3z9vK3x5
	SVRbrxUjRmj9Mpv1VwrbXaz44Pwx+dsbBlJCOyI+uEaT/7AF0cGO7a1okB8yu0ntXybExdMow==
X-Google-Smtp-Source: AGHT+IG6QqGCciHu5uQwZvPGklBSE2Qs6v3qJYcrRCySA8PDMw81hd4m8jVC00rw+U2ObdTU7EE9Fg==
X-Received: by 2002:a05:6a21:6d98:b0:1e1:ae4a:1d48 with SMTP id adf61e73a8af0-1e1ae4a217dmr3942870637.40.1733766325252;
        Mon, 09 Dec 2024 09:45:25 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:5dfc:4b08:57c5:2948])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd53ff4900sm1397667a12.50.2024.12.09.09.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 09:45:24 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Julius Werner <jwerner@chromium.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Roxana Bradescu <roxabee@google.com>,
	bjorn.andersson@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	Trilok Soni <quic_tsoni@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] arm64: errata: Add Qualcomm CPUs to the Spectre mitigation lists
Date: Mon,  9 Dec 2024 09:43:10 -0800
Message-ID: <20241209174430.2904353-1-dianders@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Since Qualcomm CPUs are all derivatives of ARM cores they all have
unique MIDR values. This means that the tables listing necessary
Spectre mitigations need special entries for them. However, those
entries are not present and that means that some Spectre mitigations
are lacking for Qualcomm CPUs.

I've made an attempt at **GUESSING** what the right patches should be
to enable mitigations for Qualcomm CPUs. This is mostly me searching
the web to figure out what ARM cores various Qualcomm cores are based
off of.

These patches get more and more sketchy as the series progresses and I
have noted that the later patces DON'T EVEN COMPILE. I have included
them to make it obvious that I think these cores are affected even if
I don't have all the right information to mitigate them. Hopefully
Qualcomm can come and fix this mess for me.

I'll note that I am certainly no expert on Spectre. Mostly I ended up
here running `lscpu` on a device and noticing that it thought that it
wasn't affected by Spectre v2 when I thought it was.


Douglas Anderson (6):
  arm64: errata: Add QCOM_KRYO_4XX_GOLD to the spectre_bhb_k24_list
  arm64: errata: Add QCOM_KRYO_2XX_GOLD to the
    spectre_bhb_firmware_mitigated_list
  arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
  arm64: errata: Add QCOM_KRYO_3XX_GOLD to the
    spectre_bhb_firmware_mitigated_list
  arm64: errata: Add QCOM_KRYO_5XX_GOLD to the spectre_bhb_k24_list
  arm64: errata: Add QCOM_KRYO_6XX_GOLD/PRIME to the
    spectre_bhb_k32_list

 arch/arm64/include/asm/cputype.h | 2 ++
 arch/arm64/kernel/proton-pack.c  | 6 ++++++
 2 files changed, 8 insertions(+)

-- 
2.47.0.338.g60cca15819-goog


