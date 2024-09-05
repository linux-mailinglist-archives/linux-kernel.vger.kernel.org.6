Return-Path: <linux-kernel+bounces-316800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA23596D5A1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5AA1F2ADF2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD3419538A;
	Thu,  5 Sep 2024 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="UYQzLG1Q"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6310B191F7E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531398; cv=none; b=sp5d4Q2taK/s1rI3dqSUBmoOJ/9dAwRyKcFpOS1TOqFJvPfO1ZrS0Fb2gPRptDlkHMleW+0g0ITeANRx1ye1NstZk04LeJ3NISmK+T7otlqeyz65tdtukxMX9EeyJCQCpGFexBmFTEgUtTwrfeVuPSYEuAoJveKNtAB3YlzMiGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531398; c=relaxed/simple;
	bh=xd6tRDcBI6nT0vpG0+47dCoixHmT48y9ZIC4bv5qVFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hF7LRQtVO+cmi5C1/NDk86+bLj4mhiArn9OOcGLG95JGMT79xpylr3iR7Im+fF4WY51d6KCNP+ZJgZv4v+6Kj9g0L8ju6ONN44W8rC44NM8RMhmIdyXhKvEc6dpiza/RpMw21xDcRtQRgC8yvwv1xD+PLBmkAVDDLrzp4jIfBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=UYQzLG1Q; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1a7e54b898so691937276.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1725531395; x=1726136195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xd6tRDcBI6nT0vpG0+47dCoixHmT48y9ZIC4bv5qVFY=;
        b=UYQzLG1QisgvNJEIC8/eI3znrXkyViMVCWCVEUViKF5e19PlVRf4UzXoOAm8gS0cJk
         rX61+3RdZ3wGcPQJSKbMIAjfTZkMNCiXOjFEpKzWYhW2eCgDw7ydIsCJPpU1Tpyh5Ln6
         mLY965zl+xccCJVqgVMZQA+1k4havzizImXF3vozWXyjj7sMdZGm1tRVewINlRCXdqfs
         9WjBHp/QULdL8UAtb3ZvwGeSEJMl5/h2/sgfjekCOPVyPDekbbd3x+QF56f4EVIp+3le
         p3xsmEq681joQg9HmMYRveCVwxnQV2tZETwi49yPhgUg7WMa9CANBbvhw/x5Gi3fP1C9
         HFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531395; x=1726136195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xd6tRDcBI6nT0vpG0+47dCoixHmT48y9ZIC4bv5qVFY=;
        b=sGmV+B7saYI8nFMWp4MbViWJBZEeEsLB4AO9IKBdfU5oQ6SNJnlUA9s8zsT7C5dMpN
         KthwzQJoKGahWOH5jeWNpWKt5uIlzD5ZdM5FVidevQQs/3mgkv8r1cZbUTA0LbFpXAkD
         FcqFqQqMyFapfUTBjDgySAwqPDCgR35c6k0L4k//DQ+jMKUPsi3/rDwZCVNxv341iA6X
         cjIv/knVqlA5rb4s/tUC4MpDUrprUrEsLblAtaMRbIS4Wn+Lc+7aab+VmCEE+xm5qq/1
         Nn1EneQ2KEFQMmwIorYKxaOctK9S9RL+uf8ofNe7L2UO3HS2LFBLVLhH5RngHmWf6cOc
         J3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUuyfYotmyi1jg0Sjnt+3T2V3L14+YX2FgxTulMGe2Gc3xUbPPUp643crxTHaMhYg3K/qv4hbBjZtPT4TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZm1NQ14Qyu/FuYQaMwi0i0/2ey0YMgmYHMNlX47KGIkrs9+1n
	9E4GniJVm9Q7/PLqMzTD7NUcxu+LMzL1Q1/qEBl49nqOh6SNmnl4E3X4lqLHv1Y8jE4dlXu5RJU
	lEOwCfZu7xbnm/YPgsk2mZSGjxSVREyHYK91vpg==
X-Google-Smtp-Source: AGHT+IHOAa2WnFWM0m3QmtHGwmSzixacJsCBpWRBvguStq1YD37bVLj0/P6F5Iapvjw7xs8jP/X43ydPbq380G1rQQ4=
X-Received: by 2002:a05:6902:1547:b0:e1d:1b8a:ac4 with SMTP id
 3f1490d57ef6-e1d1b8a0cbemr3960625276.11.1725531395247; Thu, 05 Sep 2024
 03:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905093935.2780632-1-vignesh.raman@collabora.com>
In-Reply-To: <20240905093935.2780632-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Sep 2024 11:16:23 +0100
Message-ID: <CAPj87rPCctE=iJKfQXR-PJdUHR+5f-t2bRA5Daq2fzUTNekzcg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/ci: uprev IGT and deqp-runner
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Thu, 5 Sept 2024 at 10:41, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> Uprev IGT to the latest version and deqp-runner
> to v0.20.0. Also update expectation files.

Thanks! This is:
Reviewed-by: Daniel Stone <daniels@collabora.com>

