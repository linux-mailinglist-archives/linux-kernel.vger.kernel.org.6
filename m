Return-Path: <linux-kernel+bounces-400755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324289C11E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644B11C22B66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA61218D74;
	Thu,  7 Nov 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UxrT6Ut+"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C38EC0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018969; cv=none; b=COPQwY600eRxtvdRa8lu0jEyloX3/POEXIMjK7Fi5CE6AAEDK2q+N5nAJVRWcPLmz3xIjoCo6h+KUrqzg/E5YFb9HY81z4xmvKs8Qx8mbRfZDRJ03FQudcdwK0+N5soF3MPvf94QqKvPaUfBbbz3rYVQfTGWo/4T8ZNHiaPD+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018969; c=relaxed/simple;
	bh=bCL4mPl+uKiO5OLaD6a26tnCZQrNfn7ckvad7so5gY4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rmTuqBoiLljhTYmQrbO7XKmmkpfk8UYf/FloS+jGsqg67QtGGPfQPa5MS9+Nm67BYRDO8osB4jBhpaqcByH6Db5wiQeCDYDrbk7oDPFViBYrBnZ6CA719VbHejH3eK23nmD36HonU/jTCecaYElmfcknBbIgR/eeDA4V+OmP7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UxrT6Ut+; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e5fee32e76so916892b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 14:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731018967; x=1731623767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTqplkmd1oO+cDQ02FzVSJQIEeacVX2zBVF1DfowAhY=;
        b=UxrT6Ut+rmFmb0zhoQRNv6AVbLA8UUo/iVnr2ZleVa2yPZFKhhSheLIp0I0QfaDP/d
         bTdzrMec2xuLbSfwFS6OyNIozd6HlmC8FtB8HyK1CU13AuvqDN1Ug7ArwesFm4qbcEa5
         gPLkW/Qm5qeHPSCsWoguWdiSN1N2NFs/JztzYYjCRbneN5MjzXh0rUSi/KFxs1Y0xZx1
         WBOz5/fotQFJgT4V2Ti2lpOlBXRAAxAZMfT5LN51lhv0aF2J5GnrWjjl9gPvwrQkEhGr
         DeHVXw0NMtutXKmLKOyXADt75RqSXBfFgenqUB2OltFdGCl6ZoYP+KZ2JaZF2+/vf0Jm
         OcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731018967; x=1731623767;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTqplkmd1oO+cDQ02FzVSJQIEeacVX2zBVF1DfowAhY=;
        b=GbefN6YMa3/Zz+vA8HiJBEGDPX9jm0tpVROKY0Ci/0uBWXNNZfuQB/ZR61ZfarsQs0
         qj+vVMslIonFX5f/yOkTV2ZzxTjryvqpMtdVTTCE7wbSqdcXBbU9v63zzG0dUibj78vy
         48/5ud0+pjjYRj+3fB/IOabzIbXjsg/HjlRU58iLOQm0PGPsb0jnbDY6LzCpzWaG1LBU
         USAJmatuefXsPcUwKt+bKccPNLC+phtlpus/x1WoNWiKrVcxbuWHI4/mgz7VA2v5UWof
         w6Fk3mOYo1ZzjR1qz4UCiUHOzCJKR/gJ1YKU9U+1ZUnokQtcIEneGBehKudxbNsRB1Vb
         QQew==
X-Forwarded-Encrypted: i=1; AJvYcCXykoM4BoTCO36HwUaRQBA4jeSICcM5m19FCFOw2H0eYG6hdMJocETjkqUEyHEPBnlNQtleWyuQDl2KW2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIUH3kmS1B4qNkH36QJORCLEEo/Qe5k94GZlcJBrUpbWhYCrWg
	pY0IlKpFzq3Dqjrk3IPRCR/XhrzMw6B8MoxDz2hEsfgZ4p7wzAU9m/VpbVyulERbvMFZD1cR73U
	AIws=
X-Google-Smtp-Source: AGHT+IGk7/iCDuk7k11o8jqdaJjFfjiiCG/HkKL3ykX33IYYarQ6sNKSrJTzYjDQNIvyDfW43TEcTg==
X-Received: by 2002:a05:6808:15a0:b0:3e6:1ea5:6b30 with SMTP id 5614622812f47-3e7946aec3fmr1081232b6e.24.1731018966766;
        Thu, 07 Nov 2024 14:36:06 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cca4fbfsm457821b6e.24.2024.11.07.14.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 14:36:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, zhangguopeng <zhangguopeng@kylinos.cn>
Cc: hch@lst.de, ming.lei@redhat.com, yukuai3@huawei.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241107104258.29742-1-zhangguopeng@kylinos.cn>
References: <20241107104258.29742-1-zhangguopeng@kylinos.cn>
Subject: Re: [PATCH v2] block: Replace sprintf() with sysfs_emit()
Message-Id: <173101896555.1015163.9216450575734590168.b4-ty@kernel.dk>
Date: Thu, 07 Nov 2024 15:36:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 07 Nov 2024 18:42:58 +0800, zhangguopeng wrote:
> Per Documentation/filesystems/sysfs.rst, show() should only use
> sysfs_emit() or sysfs_emit_at() when formatting the value to be
> returned to user space.
> 
> No functional change intended.
> 
> 
> [...]

Applied, thanks!

[1/1] block: Replace sprintf() with sysfs_emit()
      commit: 8e71afb94d6ed59055b67dadbc423c70104f21a9

Best regards,
-- 
Jens Axboe




