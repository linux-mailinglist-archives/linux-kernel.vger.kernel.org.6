Return-Path: <linux-kernel+bounces-331258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B1797AA63
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9E81F288FD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 02:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09D333998;
	Tue, 17 Sep 2024 02:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mL02fGcz"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2E1803E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726539774; cv=none; b=pBLXF8Hb1AmW6OdBewZVbYzF6P1DJa9/tFPcNNHHzhXmKQWt0/Uo3et4TYKfWNlJLuMV3LE9+DLXhTD8r1KOn4y5dm26Bp4EwsAAQ+llrUjCGeVCy4uTQ4CMiHvn060J5+zkz1OI2X5haeDC18T3Z0JuWljTex2b1Rqb6Qja5a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726539774; c=relaxed/simple;
	bh=/fTI3aUKjRCjKJF9bh/6FeODJWbFRJsBatVLeDhs0Hs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=awzwFn0TvQ2XZLhAZ3d3p1j+ng0rOiQbNl2qTe35W7rP5m0llIkiKjOI3jvoGfh+QltTjWAhJFLdx2/3XO/YpWVuyFFCP8ytBn3tTtn8qCNw18p5tiOWUIy/5WZWwNpnPCAjk6zcbtPkBJH1DttvVvrmO1KlYOwcYPpGSWDFYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mL02fGcz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so42145435e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726539769; x=1727144569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ymm14DvclZR6EwNa1VR+Y/QCzcjsiiSSfxF2e1CPRak=;
        b=mL02fGcz97f1IQmyIZ9HCW+0mxl6EHOKIvq0AhGwt5YEU30h9oNCjsNzVea+k7qtL3
         xIfzL/nGQYpuwcXCQ9lTUE4l7IQR/4pmmZjmTECAwQJWJI4F01ncGpexB01J7xyEz7QW
         EhwEbvWfFfyQZ9ScN+EgQXA9dMOgqqd45dej05Kx27MJo5X/v6EayouFggntj5hNA0so
         lBa7fC6L0wdo0N43uF7jwuYQmx2wCOsfO395RKXY9n4Gs6Uk5CyY64IY0fKsEWBUse/x
         9BKPlair3mWLAvIV0gVg/iXWZBscnJDIAjyCNWZ6FloIUFnIM8VczjUBtMB4a7YZGAgy
         i19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726539769; x=1727144569;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ymm14DvclZR6EwNa1VR+Y/QCzcjsiiSSfxF2e1CPRak=;
        b=v1J9BXW8Qb9QPg35H/N9hsVBJFJUsXzKCrt2+ieABsvRJc3h2EOWIoVSt8wBe2nqTt
         etj+cYqkCrTiUEA10qvDeWw2jtBi8vAsWQIckCscrn9OEyp71K7V5jZUflO/pApIFbXA
         qJeaa0eTXscZFBMcgmZ7DvJ6tQfhIjEwDIMMiFHyoX6P/1FjtHoVvZi7dWu3cX1qCKZJ
         h1TBuIe6I/WDUO6tFjQMLlBIRSmL4wIL9G0a56dkPyThaqKk1vGcT6xmrDJUAyDas+dM
         vnsoNrVJGBMbPKmR30rbSwH07gjtN6fbENRtC2YbIPWgwGOZToZl7jx1ynyk9S8zbG1F
         jNUA==
X-Forwarded-Encrypted: i=1; AJvYcCUgJVHzhBSOHjh7ZkFPuvrLZB5p7tr5Otss7hXKSf5ecIW/MtqPxQKru9Z72O+MFWar43NrNdsE18B1rLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU+XqJV991SRUFnNC/C7I8dlHvJuh8Klp49ndFec4pelYp772j
	l2vj7nQA0Ls9gQzGjthWPGYjway5tHi0FnGD0rUuLmRLm9PzlinqMbtHxjBv4P4=
X-Google-Smtp-Source: AGHT+IF63k/bT2LAMPZwhQTEmuWk2DDFQQHQivUkBrnWMayxrI+PuPeBEDVu4AeofwYY5kFrT16u+A==
X-Received: by 2002:a05:600c:1987:b0:42c:b4f1:f281 with SMTP id 5b1f17b1804b1-42cdb58f2bbmr122075475e9.34.1726539769534;
        Mon, 16 Sep 2024 19:22:49 -0700 (PDT)
Received: from [127.0.0.1] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f0600sm8471045f8f.9.2024.09.16.19.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 19:22:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <6f6cb630-079f-4fdf-bf95-1082e0a3fc6e@stanley.mountain>
References: <6f6cb630-079f-4fdf-bf95-1082e0a3fc6e@stanley.mountain>
Subject: Re: [PATCH] io_uring: clean up a type in
 io_uring_register_get_file()
Message-Id: <172653976849.74656.8223840794211444474.b4-ty@kernel.dk>
Date: Mon, 16 Sep 2024 20:22:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 16 Sep 2024 17:07:10 +0300, Dan Carpenter wrote:
> Originally "fd" was unsigned int but it was changed to int when we pulled
> this code into a separate function in commit 0b6d253e084a
> ("io_uring/register: provide helper to get io_ring_ctx from 'fd'").  This
> doesn't really cause a runtime problem because the call to
> array_index_nospec() will clamp negative fds to 0 and nothing else uses
> the negative values.
> 
> [...]

Applied, thanks!

[1/1] io_uring: clean up a type in io_uring_register_get_file()
      (no commit info)

Best regards,
-- 
Jens Axboe




