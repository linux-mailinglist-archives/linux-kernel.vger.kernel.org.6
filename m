Return-Path: <linux-kernel+bounces-382175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F689B0A68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442F71C22CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212311F754F;
	Fri, 25 Oct 2024 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TUguwDnN"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4815ADAB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875424; cv=none; b=e+4q5VQ2cK7iFY43hsrAO6ogSOChBjbqhhmeOF1K//ToyfC8jQOaq3DnmTbfkWlZLDiA4NfxhIF2/cQpmz+mR+kDV5eKA0GRJh+q7cRMxUTF2kc/KRdtFrxhcrTm7wOqsISlI1kdr+WDjLql7cFmSiIY1supjXPdTfKzmfhQwGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875424; c=relaxed/simple;
	bh=sbGml+z/Q0kys5p+09/O4MpYM++Uqtf9D6AEWOY1Zuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a9pytZxW6pFYhN++lF2nNwz45UY3vb0q4cgpdX/mOdp2pLrPNpnyKctOTQ5y3v8uthIKwOoPxJf+8tyrd+lXrJnS6w0N2bboEENlrBvPYI2UDa7/ycs50KTIA06B/X1vFWHtWDS6SimxFe8H4T2AZaActUoZDyhxvWFSL3+Sk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TUguwDnN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so1591196b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729875422; x=1730480222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJh1t6CMRH+lJdk90F6SduJwEmAVjV96hw/ehc4uVwI=;
        b=TUguwDnNZ0L8I7YGK8Fc5tq/cwRC8tcd9cMYsaHK8bVgzxW2rIpAGf/+jOFwIIXdgh
         tWllCwzjBp/rYl/648Sdig++5mIk3++8qUpmJMrV0C8dHEW2I5LkTl9I19n8LJd15HBY
         asaJs3B4AlICx7jZB67h49atnZNB/tTRMKtg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729875422; x=1730480222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJh1t6CMRH+lJdk90F6SduJwEmAVjV96hw/ehc4uVwI=;
        b=ND8WpOqPIWRdpBsv/Um4omp+ybjHE0f3QxOsY/bk0cnCCzZFkLmwdnfhhmKFvUrwmG
         wPjIz6nk+fQFI2VxE8qKwMPe6l7MUMX8FdTNzw4ZbBM3YWw2Lo/gRntwabfMWdvQ4E4D
         BXcga9oD6w2uaRkmc3kQnsv5mAxttyaf82NJsN/yoAzhS/thDPfJmwX2b3g28eL3RLKc
         +5OKoQWmovYvgmX7/Q62czXkztYsz5dfkwEVaXFWSepIO6k1DLuoc80wKkdxQiBy6dXp
         ZuvC3GnpOZzi2z1pnWMO2VlB5vENMjw8+ZeVErJ77EybXJNnZY/qy43P4UqAxNgdqoEp
         IXlg==
X-Forwarded-Encrypted: i=1; AJvYcCWGufhJPO741WYZor7R4mhOUwQPhuPPjCTlckSzYflKtrCWsPcwM91p8c3utB5EaByrKMi54OFAFjvSbFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyfdDTx1mCO6ydmLDgLeQPC56rsQTxaSMAW0jGfmy9kLiAyGW5
	86Zhv+MOhf6xKsvya9LpZ1YQVnx1lOGBjEGNc670Eh7QCXRjkHWXmeuZY3uDNA==
X-Google-Smtp-Source: AGHT+IFj27XudLwgQbsxrossUBSOsWzQeZwsqtBvvGQH5mzT4jL+yJTjB5u1zsM4PaeZpNE/M96B5g==
X-Received: by 2002:a05:6a00:228a:b0:71e:4196:ddb2 with SMTP id d2e1a72fcca58-72062f1464cmr286988b3a.9.1729875422080;
        Fri, 25 Oct 2024 09:57:02 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:bd37:bccf:f3e:a9ef])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791db5fsm1318970b3a.11.2024.10.25.09.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:57:01 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv6 0/3] media: venus: close() fixes
Date: Sat, 26 Oct 2024 01:56:40 +0900
Message-ID: <20241025165656.778282-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of fixes for venus driver close() handling
(both enc and dec).

v5->v6:
-- added kfree() backtrace to 0002

Sergey Senozhatsky (3):
  media: venus: fix enc/dec destruction order
  media: venus: sync with threaded IRQ during inst destruction
  media: venus: factor out inst destruction routine

 drivers/media/platform/qcom/venus/core.c      | 25 +++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h      |  2 ++
 drivers/media/platform/qcom/venus/vdec.c      | 13 ++--------
 drivers/media/platform/qcom/venus/vdec.h      |  1 -
 .../media/platform/qcom/venus/vdec_ctrls.c    |  5 ----
 drivers/media/platform/qcom/venus/venc.c      | 14 ++---------
 drivers/media/platform/qcom/venus/venc.h      |  1 -
 .../media/platform/qcom/venus/venc_ctrls.c    |  5 ----
 8 files changed, 31 insertions(+), 35 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


