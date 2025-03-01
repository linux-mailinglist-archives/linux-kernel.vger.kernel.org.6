Return-Path: <linux-kernel+bounces-539745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46740A4A811
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCEF177E3A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF521BEF71;
	Sat,  1 Mar 2025 02:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="So5E9MlT"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C41B423B
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795824; cv=none; b=ujE00knV1zzyJKgKmbTu+qBQx65jRLCrTfZtH/4AAf2g64fLhcnj9dGJT3d+VEG0NOkNlUAqh0eVXFlHsIRlg0EYct06AY/2Lh7tyfX4L6uBST5Jk1UogDk/24oWt83dXVAgmfkvPdry8PL0PK70Kh6Ln+5b+sx+qnpBap2T3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795824; c=relaxed/simple;
	bh=xY/UISVIf1atfvS7OMuZEMjN7lkQ/iikiRcjhdY1uUg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CfPAOxV9I82tR9ixBZ4rKAFlwJaSUhn8u9aRXZCPU1K3cQEdcD03h7p2h4hnnmUxMhCN/Db6w/GCOSdTsemB3NjWcs6hR9J1cX2nZAn9wvWoALFgfjpXFnr8poGos8IKLesp4bMPh4bVYgIK/16kaarNSZjsUytL7FfSBMpgja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=So5E9MlT; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6fd3b6a6a24so18526757b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740795822; x=1741400622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfDYi42gjS+u1iz1GYPicfPXnoYEpE1W6/kuhPU/S5Q=;
        b=So5E9MlTlRzDmw0c+Z4XM5pR02TWjJnGjE8CZXyLYRLmebSsbsoyvn3pKFKGmET1kR
         sALd7G0wtFM8fLOSwdwrksR/jGxMCtqIqkmKIqhP+PNsGMpu3pkK/niTppJhl+cRT/Pp
         uxtSFNS53wGjqbOzPSZ+sKJ3SyyXqjxhIsDwcVhAMoXJlVY5OLg3NKQc4wWderLrfUA2
         HI/u+NGSLEFmcW+Ur2yC7SdbTzaC0+WEik9f3xYNNJO9geDlSuhYOsN4EEwVZynCHLJm
         Gis1J7py7xM9Jm7KBQ80IDMawiTPMGGFgocDebvZg4nCE+Z0jdWWkbbkpzdm+rs5BQWp
         38xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740795822; x=1741400622;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfDYi42gjS+u1iz1GYPicfPXnoYEpE1W6/kuhPU/S5Q=;
        b=kkhPnAs/KFeolBD6vYodz4xTZLZbMVbB8EwBRKlbvyHu7efrbHWscRbKcO8xXZ2Kt9
         Td6ouzFFstOm2fE9R0Whjx1Y0wogXYQ24kAzrLSncAd0Y7/DxIzT6sAEHQvJ1NFgrEfx
         pe6tac9FhI0g5qKMM4MyvuYWDNsCu8HUISsVZyK4xw58nByBaVBfosR7o0pf6y0LzqqW
         160oY14eSSK8ATG++6X7qOmHr+MJcd0/ck4FdSMMBiMy+Xex6R0ZS9rg5d0rxoU5yMuQ
         NEihphAZ5Tl4Dgj9AVwuYywpAWlq1hcNKk1baMdJsKdLTKhvk4wBW1vy9ltl+7aA2iVG
         lvBg==
X-Forwarded-Encrypted: i=1; AJvYcCV1ByHQSWTd2NqZWyLj1z+9XmHG9RzyzaWPbUvM4YtmQsG72db4B5ry8Uef2R/H6jT8jNSlUa1jEEwKzPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKlhGtlhNZNtdzsve5RYWD4KAYjL5vV/0SgjZV6xTZz4EYaKB
	6SwVHhL2FASm3KNEPXTlULx0/XSZV3BFICC0z2aPewDxU+6yBtkQ3BOFS/aaYms=
X-Gm-Gg: ASbGncs21iJqbLnMLXkW+6HJBD+FPy7TvWcvoAIojth1bfdPxa+5ZEg3nVfi9CWX5vP
	ZXcTV7MOmhElFrCbX+hEK9qTUhh3l9mGNvfDgAthHnn6ftFzKo0c4EyeY+wjEv9Fe9/muKHcuQc
	IbyymudX64tWw2OJe0+ynq4ymyP8KH9YTORaaZN0891c2IPZ/okAvi3kiNdsL/MSYXdXibkHzDA
	ISOlRwDPSbhvvLZVNqxERxSr03FPBcFlOjIbPwgDI2OQbynIdNqDQcSVWrVrBcH348qEQzhY+wO
	eHqWibH/t+XatkoAHJx5ccU3lgOH/Zvpq7uMPD8=
X-Google-Smtp-Source: AGHT+IEBXBECUiYtnJB7xtAXg6I/62QADZwXGKn1Rg9EBrqtWsNXbyRRrltHVGhBDMtUTvfcTG7yjw==
X-Received: by 2002:a05:690c:4b8c:b0:6fd:47b7:9730 with SMTP id 00721157ae682-6fd49fb60a6mr78166737b3.12.1740795822147;
        Fri, 28 Feb 2025 18:23:42 -0800 (PST)
Received: from [127.0.0.1] ([207.222.175.10])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3cb7e02dsm10175307b3.84.2025.02.28.18.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 18:23:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250301001610.678223-1-csander@purestorage.com>
References: <20250301001610.678223-1-csander@purestorage.com>
Subject: Re: [PATCH 1/2] io_uring/rsrc: declare io_find_buf_node() in
 header file
Message-Id: <174079582102.2596794.10638072394312089078.b4-ty@kernel.dk>
Date: Fri, 28 Feb 2025 19:23:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Fri, 28 Feb 2025 17:16:07 -0700, Caleb Sander Mateos wrote:
> Declare io_find_buf_node() in io_uring/rsrc.h so it can be called from
> other files.
> 
> 

Applied, thanks!

[1/2] io_uring/rsrc: declare io_find_buf_node() in header file
      commit: 98ddbefafecf270d51902cabfe289df10a702cef
[2/2] io_uring/nop: use io_find_buf_node()
      commit: 15d86dd9019c7a97bd8c5b6880870b97e7cc74ea

Best regards,
-- 
Jens Axboe




