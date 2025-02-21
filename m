Return-Path: <linux-kernel+bounces-524944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50001A3E902
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F03617DA75
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0019A1876;
	Fri, 21 Feb 2025 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="LpzWX2Gx"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6254CA31
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740096569; cv=none; b=SlayWYo/bbrZmeQONXUcYpIZhRJXiAIJgIDAnjI1tO5WbxuffIQSP1SYnNxeHttqBhk1M/yWtz6l8bTH1v122VRzi9Pq2oTKV5PpjTBmve4FNRg67C76w5hZz/e7eqvXjbzrewil19DqiwU4M9n+H+XwB75yEiQOwMbyOLG6GYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740096569; c=relaxed/simple;
	bh=/K7dnnSV2000TsDSh46XoDrYyzMYikcQMryVPchPHAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B4TwCoi4UNB7xmkAQ0FkuIxuhrQPSOil2chhNY0QawR4ZczYDdElbjrWIMw5Prs9fIxzW83RlDh34cOVBUWZut2CDGpGqYUHXe14nsR1W8iItwkL3/Y1YzG7atVeT+VEIakgnNh9fTNBFnCj5dvRfGiXn5gbe5jTSYwyqJQudDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=LpzWX2Gx; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2b199bb8af9so1588905fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1740096566; x=1740701366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5RHohY8rfSaMQdVznrllxN3pGVzi32rdYlqu3XuSUA=;
        b=LpzWX2GxINLPD81TyU/1Y6H5OxKw8d5D1n4nA79xYfMNNdQrgsDvF63+wObO/pckCA
         7L+JW7wu+IhAl3xw0dgrblBO2W+WNfn3uZhTul2oAmfNH1GrhUSutCxZecU00H/KLyuu
         nD5u8GyfF1SlZXWquVt8Im64Udobhro5ejbFM+23n44N8rGHDRniWXCN14/GPo8nyqBw
         V3AJb1jceiLJqrWt0A7HxGFEvoIqqMaUTOHuCt6w+oj6sQV9MJ0uWZEGR1FCDVnXW1t2
         KaI0Xot3lb7ryMAXb/xx0FQ88kWNQPvhMWO2MlkiGe50aWJyH70lb4kwbWxeysBe9a/8
         2AQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740096566; x=1740701366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5RHohY8rfSaMQdVznrllxN3pGVzi32rdYlqu3XuSUA=;
        b=VdbBiaZU6mFeXBRK0jHFpDS8uetIL9NCG6GyMayxslF8HPDX4jfaZkQR0x6kaoeWXw
         iMjrvIv//QN3UVq/M6Of65je+cN3J2R9XHaYkBkrrtlIYaTL8WLeDFQC0jsVpzm0anyk
         3ee2fyjGui9zHQ5js/RJhYNtA6I6VdgfNDTpc0/a6jLNKfFMHmjlCe7sq9mcA3QqMROc
         bnN3sbA1/3i1Ji+3U3uDnXedrVxHSjM9yj3e/nygdsyBkT0WpoZTzTh3qElYjrvdDaIF
         V5kOWu9OnONt7naH5r5l2ykNoeglwl11sbwQ5ZLFH7ggcD9RS6iVQrOwT4Ms1IIjqwgx
         jxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgtzPcuRWWSzsYJBDOeP5cg1dOsdv3RmgjQkDzGtx5NuTItGkDv8X68YzM1EbkoTUSePEyZ6fYBQOpVLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDow9Zp76c4Gjb6udMumT7Zz/QvbpzeEANvoaXlB7WqfmHCCd
	4d4Nxab9LBdGlpEdvWu7BcubDR8kqmiwu6uu4XiNmq+5PIQGao9SvZVnJh+JiQ==
X-Gm-Gg: ASbGncttvox+N2ljZRJDB32uk0eVw0igp0NUYUx/mDYT4Em/7WlonBfcgORSyf8KCWD
	63Ey3yKnMVrIJpdn2czfNxJt5sTrNHM8uU0hpmg8VbiYnNM51tIPQ0FjrnYEiJnRHfNHFz+jXae
	NvYf1QHBbTq/4oUFwW5oo0RVTpe0lljT3FOBkVLiMn5XxCRQkoC+QrXMII5X1G3lv9+EFs/zPRL
	CxJoMZhTip+uKtiq1fFDLqfM5/HmQ9ExbpDKbpkmEHFgHaWMf2LSB2Vs5wkqWUrm+bUyqBRhOvO
	Yf6VIGfSgkHVtIAgjhKojZt0CYqPm0O2tQ==
X-Google-Smtp-Source: AGHT+IFLLufz7FCvALtBDLCNlSBShOP+uObi95wVRF1EC3vzov2bGxRF1xe20tQaoGmGTc5DR9TQmw==
X-Received: by 2002:a05:6808:3987:b0:3f4:9e6:fb7 with SMTP id 5614622812f47-3f424c163c7mr1180195b6e.1.1740096566280;
        Thu, 20 Feb 2025 16:09:26 -0800 (PST)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f40b027906sm1573401b6e.42.2025.02.20.16.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 16:09:25 -0800 (PST)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com,
	charlie@rivosinc.com,
	jrtc27@jrtc27.com,
	ben.dooks@codethink.co.uk
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jszhang@kernel.org
Subject: [PATCH v3 0/4] riscv: uaccess: optimizations
Date: Fri, 21 Feb 2025 00:09:20 +0000
Message-Id: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series tries to optimize riscv uaccess by allowing the use of
user_access_begin() and user_access_end() which permits grouping user accesses
and avoiding the CSR write penalty for each access.

The error path can also be optimised using asm goto which patches 3 and 4
achieve. This will speed up jumping to labels by avoiding the need of an
intermediary error type variable within the uaccess macros

I did read the discussion this series generated. It isn't clear to me
which direction to take the patches, if any.

V2:
I've taken on this series as there isn't any response from Jisheng. No
significant changes other than build fixes.
- Fixes build breakage in patch 3 to do with not having used 'goto' keyword.
- Fixes build breakage in patch 4 on 32bit not having delcared __ptr in the
  macro.

V3:
Significant commit message rewrites.
 - Corrected the justification for patch 2
 - Better explained/justified patches 3 and 4
Minor code changes for legibility and more comments.

Jisheng Zhang (4):
  riscv: implement user_access_begin() and families
  riscv: uaccess: use input constraints for ptr of __put_user()
  riscv: uaccess: use 'asm goto' for put_user()
  riscv: uaccess: use 'asm_goto_output' for get_user()

 arch/riscv/include/asm/uaccess.h | 205 +++++++++++++++++++++++--------
 1 file changed, 152 insertions(+), 53 deletions(-)

-- 
2.34.1


