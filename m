Return-Path: <linux-kernel+bounces-406588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7AC9C6115
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23451F22E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F47218929;
	Tue, 12 Nov 2024 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nswQ7FZ5"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A90721790E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438826; cv=none; b=MCNt/5oExEkNrm03TTSIpGQDEOIEtrmGTUjXCLyZD6JbtK9E29iBUnk2Ddji0dRJGRE1ohLv6qjTWQRZUdkXDxAVgQKJrQqcbOZxcN2BE7C5W5OoL2vIujeulbW+E/MuRdD8QSGcGOflppzmLCyWM5aG+d7OMNmro5p23KdRq4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438826; c=relaxed/simple;
	bh=z1I5Cnt8bb1hnH7BOsE+i9L1a9bYVhfqsKiQQEDYkbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvFjwmFaYqm4TyjzWkjSaF2B4EMJ/AHASqdF3Md5bu9/gxaNOhN6Y9JNLSf18OXdho9V2TAE2LRQHUMX3lYjPnlBu9lyMl/taFO36lTYu1efZiNYy/2h5hR2GYjFSmEwQe4gBQCu2LUapnCVLZyaqPmniRkDHVoPKxxGUY2bTVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nswQ7FZ5; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731438822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2wfruU0o5MqkGZQlyyUPdYIgcNLexv/NYFlVrUjaf0=;
	b=nswQ7FZ5qmBP/kugTAbcuj0+xAIgf8NB4/n/qS3hx7IGc3FCjrj6Xi6HelVeSqxa95yf2M
	6vYQz+5m1TTXmuhzGgcvf60p4YozmyoaeEF9pr1o/FbiSZVf8GjmQ3izmZlzs9iysdMUcL
	Rc8270A+I3YuY34i3envIE3Ka6Buct0=
From: Oliver Upton <oliver.upton@linux.dev>
To: tabba@google.com,
	maz@kernel.org,
	kvmarm@lists.linux.dev,
	James Clark <james.clark@linaro.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Pass on SVE mapping failures
Date: Tue, 12 Nov 2024 11:13:27 -0800
Message-Id: <173143830153.1780821.3252624992091199319.b4-ty@linux.dev>
In-Reply-To: <20241112105604.795809-1-james.clark@linaro.org>
References: <20241112105604.795809-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 12 Nov 2024 10:56:03 +0000, James Clark wrote:
> This function can fail but its return value isn't passed onto the
> caller. Presumably this could result in a broken state.
> 
> 

Applied to next, thanks!

[1/1] KVM: arm64: Pass on SVE mapping failures
      https://git.kernel.org/kvmarm/kvmarm/c/60ad25e14ab5

--
Best,
Oliver

