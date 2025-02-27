Return-Path: <linux-kernel+bounces-535581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 253B7A474BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB7E16FD38
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75601F5832;
	Thu, 27 Feb 2025 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7mPt640"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A42A22A81F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631072; cv=none; b=i48n2KJHFnycysbRJhY7JDISgbQmBKe0IdU+UePFAUQJaXwsRI7qMxMLke3o5Tv2OKuzmtMlBWf02mXwoXIvuyhAOq500RFm0bKk4BPe+4u4fuD9I3kkPM/F+KHn5NCwsVjt4KvhIRcnnr72oYF/H+ZaD6WBQG754yNlMnGBZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631072; c=relaxed/simple;
	bh=Sorjd9JUiaK2Yf9A7/0/YxItO4E0XDK8bnceB1LN0u0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMdiyHn/9McYVy0W3ss42GVRluUWaPKOZKRKob8f3JlMOe/3YRGIufLxWldJ8w/5hxoAPPK8S7sRJFwFea3aMORryZ6Tzt6dhkM3oiwnfja9jsXxLqMoHJmLwu6gYXSk+NMqbBHXXQNnibfjcrydaeszFO4dCNBNNdEeDCyTJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B7mPt640; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54943bb8006so477755e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740631069; x=1741235869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yVVoncMUtyJrD71yPvbIabSZ+QZVXWPqdiViPaHHO8=;
        b=B7mPt6405M2BDSKpCFiOyKvMfCb63aX8oTkBW34F2uxKibPDOelfeuFtLKveKV2k+c
         6PC+6jAIoKyGsHpHRiflrtcQCU6CouFzyxDBwQHrWXZm3ehgZXxyZiEN7bvSP0Xkxis1
         OuOqwY2fTumy8RqikXcht2+iugeacEaVRFyMK0YtUf/fVjiVWrW844r3XDh2ToJ732Oc
         tBupvktVBhYHQx/yvyXh5HaT6E3qixifAnSWo03UtOZMhDjvNi3nDL/ObZcSt58wQvsM
         jKr4GOrdOtfLpeDZuNqHncsnC3PqLb/publTCokvmZgY+5AReHBBFW7Q1m7neS4iN+1Q
         0lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631069; x=1741235869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yVVoncMUtyJrD71yPvbIabSZ+QZVXWPqdiViPaHHO8=;
        b=YfV2kfAw4/aHFrxDG4JJuLNNxl8g8AQD8GRce3jMRr2V/pqgDBBTdt6DSRp2WNGbj/
         GJWNWK2g79YLhdYNdkoVdKCZvd7qscq6g2rmu41WUpj5JAoTt3zVPKBOzXDH0ynXbY32
         451TOYdiBGImfogCtOmOvF1799WRVYEtVpDvNM+C8UydktJgE1y9Y2EZKwZxclgea+Re
         iH5unU2gMM0ZY4MrjQPQ0RjCdW1zpAmRxeJFAY5r6REypFOsve12Hz3QFnqYZTFu1XfC
         e6zD6SaF2D+3IgfzZvdw9krCBG53s3+Djw+MxKfW4aX0e/d5pFWLrUZWt6M/ritZE5wO
         R82g==
X-Forwarded-Encrypted: i=1; AJvYcCVVbaOMxi3/7k3uwGYaz9/ndFfpxuOxBIoGZheidb0ch62Kn0iy4iNOFCa7MOB1qBqdloEY6I5N9kq8/8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyPKAmhA6pJHaODywzpJb41gjALOXuQD0mXT3zyzFFKCkIy3zQ
	9PpZ4is7YsDXxEg18HbdYHxj94UkLJ8Uc3gH5L00iLohtWPRsUKwGqxgFzrIMOE=
X-Gm-Gg: ASbGncsaAt4xs1UlZvrex7f+N2UNPsStcs7dQjibCiX5y4DZmm1tqtogtNfIAH3Sokp
	Ctuva8CUzsiDMOMTDLZ3iRYKRKFS9RKahICw6AHS7aEehoi9A+obDzlj1ufvlrYe5OWIc7TvrA3
	9xSY3NzspIWaljt0qcuNpEuNQhhJ5IbbaRI48V+bZKXAckZhbexazW0IGp9eo/zGMojFHpFZKdu
	IAnRh/tvW+iJtXiv3NRTJL2vzedKSX55BHEmLkzfVchoTq1BawgJZIt5Zwrj+bZQzeOzZS6uhSm
	KEY8ikIiNOEgyBs3LNxHKoQFC7y0/pnF1fEXYcbUHg==
X-Google-Smtp-Source: AGHT+IHhHacgUFUOWqaFKwGeZCIyQGRHzXtNQqLQR6DH/wWVs2+qKt/6fID2W1fIzlPqkwNrqTa2aQ==
X-Received: by 2002:a05:6512:2814:b0:545:60b:f38c with SMTP id 2adb3069b0e04-548510ed080mr5489768e87.41.1740631068697;
        Wed, 26 Feb 2025 20:37:48 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccf45sm63485e87.229.2025.02.26.20.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:37:47 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] drm/msm/dpu: Simplify using local 'ctl' variable
Date: Thu, 27 Feb 2025 06:37:26 +0200
Message-Id: <174063096235.3733075.7263678647140432875.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114155959.583889-1-krzysztof.kozlowski@linaro.org>
References: <20250114155959.583889-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 14 Jan 2025 16:59:59 +0100, Krzysztof Kozlowski wrote:
> In few places we store 'phys_enc->hw_ctl' to local 'ctl' variable so use
> it everywhere.  No functional change.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: Simplify using local 'ctl' variable
      https://gitlab.freedesktop.org/lumag/msm/-/commit/629ac9f0a68c

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

