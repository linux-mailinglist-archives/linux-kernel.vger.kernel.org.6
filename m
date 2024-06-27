Return-Path: <linux-kernel+bounces-232332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B14A91A6F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401A51F26D63
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07DF178393;
	Thu, 27 Jun 2024 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjajGwUY"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B91779A5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492677; cv=none; b=fqTdHWGOBhgP/y661whthvVQVqPFgrt0gET8W9tmVltogDA4tHqgsZwpWyHtG1Hf1bIz39skFN649mTsANUNZy8lxUngWGbnGaMAykJ9lljVUqYQGO4l/hyA1QrdxkNXP1wjq9zU/kNNV5q9rGD3ndJn9yMbQNyou1WpPgHowt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492677; c=relaxed/simple;
	bh=qnbeZXhBfFJTTPcTPH/ROnaeI+osEUE7a1CoNefn9Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TAzoUeDap9d7iN1MLVe7/EjhDQC4GDTWopEg9dDvIX7vmU3NjrkW6N5tvLsXfP7kfGoHh8HXksXlK9RMJe7nke8z+nQKqgdutX7VKIkqs46IgtwXtlBAoUb/9ocY0ttjooSu0byTh+04tmTG2rU/hN7GwcQrU1JghUAhehp1mJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VjajGwUY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a729da840a8so93011166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719492675; x=1720097475; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8RdIwO1AqgATS1rruwHtz31wW4pIJuBMnKzZU+n75c=;
        b=VjajGwUY9K7ewt2dqbIXSYnD868MYkRsyuSVY0SLcGA5ZWas4K357WVLfhdIDQZtPK
         TIrgcIt/Vuf+hKzPG4Drq2CVb5I6yPdFyuTjkdl5mYZLYoZXpceVUCHM189pK/z+qxaw
         vquCe6z4w9BdJ6QxpmsKb2t3ilwMC8AtI8xmlgOVpgQbxq2eJWPvLTsBmzHZDOnx1Egp
         LaeaPikYP4FyIwltGqZrMT4w7ViV+d97u2BrQKSjSVl6Q5aZ3LengpqGK7DALHkvvOm+
         Vjhu6hDLgg9BpqexvYXbz74g9+SA/Wli0o7V4x6uNa0UQWVOFJG2ja8L23xLmaZt7F0n
         9izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492675; x=1720097475;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8RdIwO1AqgATS1rruwHtz31wW4pIJuBMnKzZU+n75c=;
        b=XuUz7gJQMUIqaFXsWgW4kjDiVDlnUPEZ/NfHvMpPLJo5L9mq+kkzzd7WTeWxVi2jw4
         /6mmcQbFZsrNh8Ry28jY+2xEH4xaEmKB680MduI1N81T4y7q9j4vIwxJG/F7J7dRAU/r
         YW7SSNKVcfCpWH6htM6n+uFGucqzMHQpUvjEocyWBo1me7F7TffxMbCj2zvo6SjOyUNb
         BaDKK6P83ikv8coq0QRdxFfDPYZFVcqfdYrr0G3Z3TEu4ldhbxAaEokYp6NNHP0pNl4C
         mcQNNInOUCv9DKLPYeLnhDfJP1GKzOuZUWn5nyZCdIrysKHrk5k6sHThd+v1A+9qAC0t
         Mn1A==
X-Gm-Message-State: AOJu0Yz+eRqyWmaw9kbJQzyXeBIZfw85AXLA4EhilVo+T3+AEv/WdxtJ
	/9CS/zpEiZxKtp02mvMJNg4gdFDro61dqV+EUD8MlpK/wpT3IKtejA2mczOy3JM=
X-Google-Smtp-Source: AGHT+IFB8SbhGNvYE/lAYWgisgvNl1xeZNFWFNCj05aBH7pV/cycVghwpgIH6UIUzmGlcNfVH9hzqg==
X-Received: by 2002:a17:907:36c6:b0:a72:9ebe:29da with SMTP id a640c23a62f3a-a729ebe44ffmr112781066b.35.1719492674604;
        Thu, 27 Jun 2024 05:51:14 -0700 (PDT)
Received: from rayden (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d71f54csm57247166b.71.2024.06.27.05.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:51:14 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:51:12 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE fix for v6.11
Message-ID: <20240627125112.GA2674988@rayden>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello arm-soc maintainers,

Please pull this small patch fixing a few missing-field-initializers warnings
in the optee driver.

Thanks,
Jens

The following changes since commit a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6:

  Linux 6.9 (2024-05-12 14:12:29 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-fix-for-v6.11

for you to fetch changes up to e0556255a53d6d3d406a28362dffd972018a997c:

  tee: optee: ffa: Fix missing-field-initializers warning (2024-06-27 10:27:31 +0200)

----------------------------------------------------------------
Fix optee missing-field-initializers warning

----------------------------------------------------------------
Mark-PK Tsai (1):
      tee: optee: ffa: Fix missing-field-initializers warning

 drivers/tee/optee/ffa_abi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

