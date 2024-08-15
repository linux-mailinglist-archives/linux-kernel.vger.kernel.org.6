Return-Path: <linux-kernel+bounces-288094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD4A953423
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238CC1C259E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0551AB525;
	Thu, 15 Aug 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ey7MZYwP"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166571A76DD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731763; cv=none; b=aNPMJE2dDOS/I/E/MtWJ6FwnoH3xnW3FnKkOx/GoUU/GWfPOYgQbKP4Ysk2sxl7wAlfriYZHp/jC5XDvP98XtoDvx0akwPnpDWfMBCWWsVhWGmYTnH786pPuMrJKCjLJbf85VilEi7O5xYOh+vThcX2T6QuRncYCWWIgzJtxelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731763; c=relaxed/simple;
	bh=ZNSWxxQAl5JF1Vv7ZkOh/BPEEz3F/JxT1k0CbN3fYe4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eHKjyS5nMDt361QywoNzGyHWO4YiQjmKkcQBc2nFBPNq/8n7DHHcMmfB/xEJrx7Y72k78Ute6d49lUka0XoVPq10VI4ygBrSvJ8yAVLzsJl5UxwWhAwlL4iVYjb3OAuyQ5VA9CSZ++iBPfuaM+rtXb8EMKncu6SmBgLew2nq6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ey7MZYwP; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81f8d55c087so3803839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723731760; x=1724336560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98fnk4sqqU0DUmGRp9hZBZ09L6lQXvEbeeISq6VpsAg=;
        b=ey7MZYwPeVOkGtjS4178Er0xfhAS/92ANp6l/poyGlekjq38FsnOxGDle7GkS5OcYc
         YkAu2UJ51AzWE8ntli59/3L5jcIkjbMPNLBaZCsWhlAZPMRF7Z/cvEVopVWCHDkGi4L0
         l+XoylJiVLVE/Ok3lzEyx+JTOcx7KeuN9XixIBH/h0XkZYi6CfpIpTD3jmXqpvZGw9Gt
         p7tsxfbD1EIQRUbE+vTFyiSu/K9aAcax2kB423H9kiHVUUODCs9CuiVhOcFYYiy1xt+Z
         Sv4RpBQHeIVZT9+cY36RJf2CW/7WSpbw6ENc3n82tb6miyvaDV6g5FjTewl9N6vY2or3
         2TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723731760; x=1724336560;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98fnk4sqqU0DUmGRp9hZBZ09L6lQXvEbeeISq6VpsAg=;
        b=RomgD/GsbvUIXY/yLiIesaHzd26MgvTT7AFAva4I1KhrOwBwMnK7XtZbTc+4YOUjRH
         9wDypAEtv5a287oTsZ9/RyFkn9Q6cNjoEJiUfOxfB4/l9RcZNi5xAC0SXrAsQmNMWxaM
         Xrup2gmGY+3DKkBgHR1DsgxC7Uc3hBs63NCv47EeHNRMbDkFCY1v3qkNIXSxkw62zzr5
         cN6NoZ8KkEE5cihWN0LUMJJz53qtpszcYDKKgLMpcFJfWbtgOFMF2G36J1SiAkw/ZBqe
         kG8JTg7qejr5wXWpUIkQb7zt0gO3jk2sxJdorReqkfCSzTuPSCH/m83fVxr8He88um8q
         R7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXekXLEzTIv/NZLdnQtSCB6NDMfi7YaBlg04Hu49R9c7Ra4Sg0gFjbABMl1pEtoA8Bv1qlCdIso7r8IeUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj0SHUinWwHYBd7aZ8JV1mXWXDBI9b94sdxIO22VOKRh0lhCYm
	mKgLzNga5bE5qj0fOGOIHNIiHpYVzfBnptfF2zwu+qlrtkGBqaTH46ViL3i7Hwo=
X-Google-Smtp-Source: AGHT+IHnIel2/POZcT88jDsREpUOei267Za25zQnM3Q5WZHx70O75XoWAG+y8/drExtft5mrS8GkrA==
X-Received: by 2002:a6b:6305:0:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-824e86c307dmr184205039f.2.1723731759821;
        Thu, 15 Aug 2024 07:22:39 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccdc941eeasm203908173.176.2024.08.15.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 07:22:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Andreas Hindborg <nmi@metaspace.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, 
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240815074519.2684107-1-nmi@metaspace.dk>
References: <20240815074519.2684107-1-nmi@metaspace.dk>
Subject: Re: [PATCH 0/2] rust: fix erranous use of lock class key in rust
 block device bindings
Message-Id: <172373175849.6989.2668092199011403509.b4-ty@kernel.dk>
Date: Thu, 15 Aug 2024 08:22:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Thu, 15 Aug 2024 07:49:37 +0000, Andreas Hindborg wrote:
> The rust block device bindings include a wrong use of lock class key. This
> causes a WARN trace when lockdep is enabled and a `GenDisk` is constructed.
> 
> This series fixes the issue by using a static lock class key. To do this, the
> series first fixes the rust build system to correctly export rust statics from
> the bss segment.
> 
> [...]

Applied, thanks!

[2/2] rust: block: fix wrong usage of lockdep API
      commit: d28b514ea3ae15274a4d70422ecc873bf6258e77

Best regards,
-- 
Jens Axboe




