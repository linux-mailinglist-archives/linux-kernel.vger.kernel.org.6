Return-Path: <linux-kernel+bounces-247083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C9492CAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122A81C22D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246C36EB4C;
	Wed, 10 Jul 2024 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="K41vxN1X"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA1664C6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592630; cv=none; b=skppnJJbOt6V7iDVPKPDzqpYYrPwUKDlbCZDzRuQqWuFZ1QW7o50PZ4d6LZVPYRXCHdyUz+hHW5OXzylPNOBFeHIRV7XcwXZLhruDHnE9lx5skMT0uLOg1a2hvznbX9CnZShpVpBLWFeHzLBMknU0XRkZ1n7eKrbpl/eI2OHtzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592630; c=relaxed/simple;
	bh=1MzlV2SivzQk+toU9O0s1wYx7Gxy0Hx2ackzSFFM4U4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Eg03SHyk9vzFrE1+BZtcUsyN1weShtHQAFXdN0z2ERFEOeUawyXJSgxWJ2qO11/s/MQ0GpKF57vCWD8lu1xySkFWYnUC3Q4en7qxaKen2mvCS0wBxbLVxFDZ6RZXWHlTLwquFcVEAvXdMnzpI+p9AW+QwrxLRogRoQ2fwUtZlLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=K41vxN1X; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ea3d00253so647361e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 23:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720592627; x=1721197427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peZsNPj1BNH4twyiHnIZz89+5SLDTDtVFfp9lmKUxv4=;
        b=K41vxN1XBNHWYrqcnA2JNGiZrMzESpr1xyF0sCMrLXUppgzkOqwSgl8T28ralCx9MO
         rW7PqW7bA0k8kfs17fYRBRuu7qa0khlMPPpik93IN83tdf5AAIyut176qWDI6/wX9VML
         KVfZ3SWsUco0E4FJStAks+xlgKX+ulbWtBtS4j7vjDePEl3lyitlczoUvxvG3yY+FxNt
         OfyvcDt6+zhIwijAfqZ4zVM3+RNKLgadUiEdPnM8lzhAxd3+QPRgc1W2rvqfRdtxuFDt
         PzHRnO3VV6HIDP5jspeb9irs+tKqaUX+RxtFvsGmaSd5CMkdS6BwfitvCQXuj59mfv7O
         +npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720592627; x=1721197427;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peZsNPj1BNH4twyiHnIZz89+5SLDTDtVFfp9lmKUxv4=;
        b=MJyaHrJuL0ODF3w1o4EABuk2pDJN904JIkD1oXZGjd+fgzXCSd2GmIOODohQ6UiNuc
         /07JakWXuR9ZdG3pki9HIkPbnRxLQaRayWuNAcQlAuttsSQN0dTKVUEdd1sc5Jk8gbLP
         pIqU6tv+tguvYETGxj7u+JlK+R2/3q7Z4XhmogfzDjK5mk44k/U8ivnx4bjz7Rjbd3qI
         HKFVNqCpck1rIQMUmoBaj7R++D4385Myqo7J8CpnrKvMSLOaL0JHNO7ntL/w5MOuBNul
         ClQ1hyBIAJ0tcnRYp+vzsQGdYbuBswRHqJfpXMFrdjFi2Bkh/HEVNG2e2OWh+DF7OcR2
         Hskw==
X-Forwarded-Encrypted: i=1; AJvYcCWeItCVrCYGAtOnvKHEt+t/JnXVg3KqdKgtLeHMJ8G3wLV4wqx0bpTCyzFBsL2niLoq9MKyUg53spIrsUWAiB88sKowD4/KMjnXGbfm
X-Gm-Message-State: AOJu0YzU/ompDGQig9o6xG7gchYNdaaxq4DK9QpxKXXfOYSWU+aKUyV+
	RRt4PTgafZc3ORLkLl4lvP/7Nggs630xSCbi2qHZARscvg7vAH6xRqBLOOEpgAw=
X-Google-Smtp-Source: AGHT+IH5aoFqMDetAj6DeM6xs7OgL2qyb/6WTEb5Xw8gbWI7SvdV3F54U25nwN6xMLvlPI5WP9QFwA==
X-Received: by 2002:a05:6512:3d8e:b0:52c:f533:1e21 with SMTP id 2adb3069b0e04-52eb97586acmr3136252e87.0.1720592626693;
        Tue, 09 Jul 2024 23:23:46 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb90670b6sm463892e87.197.2024.07.09.23.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:23:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: xen-devel@lists.xenproject.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240602-md-block-xen-blkback-v1-1-6ff5b58bdee1@quicinc.com>
References: <20240602-md-block-xen-blkback-v1-1-6ff5b58bdee1@quicinc.com>
Subject: Re: [PATCH] xen/blkback: add missing MODULE_DESCRIPTION() macro
Message-Id: <172059262581.380385.3520658420031785227.b4-ty@kernel.dk>
Date: Wed, 10 Jul 2024 00:23:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Sun, 02 Jun 2024 17:37:28 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/xen-blkback/xen-blkback.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied, thanks!

[1/1] xen/blkback: add missing MODULE_DESCRIPTION() macro
      commit: 4c33e39f6201ab130719d44d6f6f25ec02e1b306

Best regards,
-- 
Jens Axboe




