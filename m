Return-Path: <linux-kernel+bounces-176697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F888C3369
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4403A281270
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 19:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4729B1CD2D;
	Sat, 11 May 2024 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F9lUHDYC"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01A728E8
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715455272; cv=none; b=IFupPFHsDenh087l+Ip3k3cjyK9U98mv6VmyByG0K6PaT7tfjbWRSVN1s+o78/Ybh5cVKqaEHBL/tLOaSeAjzRbefHEnMfHksaMT/fyIA2wWOawTWtRQxTDqtfgF75RFddhadiCBLbiXXIRXAbiVQtK/FvRxpUnF7mp0tGYTZZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715455272; c=relaxed/simple;
	bh=80CK6AevCDe4nPUQXPEifZWh4f1hnDH8UhRLP1HYxtY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o/gEFZzRq9GqmXVIpAuxcCY+goNQrTog0g/4CbeoqIM07pBhbtQBt0ezn/c8x07HqCkCOxcg9G1MwLJvVieiUadzAc+3kVOte0FH+zhPK61yYeBN3DD3K+fGig+hIxax0tCB/ZBtrK9tUkcTRfOvNC47Gl4trqlY2KhRExqeHjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F9lUHDYC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f45020ac2cso2528130b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715455266; x=1716060066; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7G8cbABPJGT7WAQuTeJej+FL6XhTMx5z1HlPgQxKr8=;
        b=F9lUHDYCa0pGt/zdKPY7wLHoUf/7ohUXcG6jO2VqT5Sy+wH7y2wbLy/DPQzxwDoX/B
         9BJDzb5jErcuPELcCX9xOc2DgUC/Nq15CAjIuCmFE3iWiexE0b2tym5lpcW06Eay2frS
         R4Te5oNPDfYm0PhkFrMuvW/Yq8v7qRt3sLP6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715455266; x=1716060066;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7G8cbABPJGT7WAQuTeJej+FL6XhTMx5z1HlPgQxKr8=;
        b=hGXamq47N1cmhm9EWX55hD6lGTv82bj++hjbnzTzbTOj+k3Sg50cFYDSKtcad/3IJH
         huqmeNRfVkzaYogGrvfhbzUGpgu0lhO2mrNeDqE4cTGOsFZi31egiXBfsPZaIM6AyMhS
         I+BCIOE01Tpmn0RaKPe+C5xTniN4yiKOVlONaD5yt2AFEsT7yddOMXa+aYx6NOYruDNv
         o+lsvDGkgpK7LEtkXcwCf4qvgCEd/sdXW/L81fJzrirx9E8FEFy5SoYCegBdqhocCOnm
         RaY2DN7v7BHedpSn5NQ24sWbAVW8tzT3jUcNU7FWRDJ7uNXqAZWIZ3miZ+4ts9quJ3HU
         9DFA==
X-Gm-Message-State: AOJu0YwZHHeA4Hi4Uedm2GfIT4JKK0KjWSC1PAN3NZKM7ZDSRuDcAuDd
	DjIJbdXQI1+2gFXAfpaqkskqJZ9h8ms2IJ0WAxavl1FwM5BgC5sSPbEUmKSpjQ==
X-Google-Smtp-Source: AGHT+IHtgzjnlWTCFBC700FcQgZn8u9zQBsC8Bh5yx+wzvqBZnyydhxvLYDhLL3DIcinlAsbct03Lw==
X-Received: by 2002:a05:6a00:a1e:b0:6e8:f57d:f1ec with SMTP id d2e1a72fcca58-6f4e02cee46mr8015753b3a.17.1715455265818;
        Sat, 11 May 2024 12:21:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0dcasm4791673b3a.118.2024.05.11.12.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 12:21:05 -0700 (PDT)
Date: Sat, 11 May 2024 12:21:04 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: [GIT PULL] seccomp update for 6.10-rc1
Message-ID: <202405111220.B75A16497@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this single seccomp update for 6.10-rc1.

Thanks!

-Kees

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-6.10-rc1

for you to fetch changes up to e406737b11103752838cf50fd197ec8e9352bbf7:

  seccomp: Constify sysctl subhelpers (2024-05-08 12:50:40 -0700)

----------------------------------------------------------------
seccomp update for 6.10-rc1

- Prepare for sysctl table constification

----------------------------------------------------------------
Kees Cook (1):
      seccomp: Constify sysctl subhelpers

 kernel/seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Kees Cook

