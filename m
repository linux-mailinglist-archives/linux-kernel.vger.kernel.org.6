Return-Path: <linux-kernel+bounces-339264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4034A9861D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7079A1C25F66
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8187613A25B;
	Wed, 25 Sep 2024 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YGlORQfX"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4C0132132
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275318; cv=none; b=TD6gC7x2r+nIlFYaqB0YwkTmxnkOgzIMBRzWlonwrYyNidmYyCgiioVeLtUdQCyWqRDQoUnGgQsX7saYDoB5/OxQzYxYPDZH0hZ0+nBl12UjJgwXVYLs0kl1b/2pLj41tyqxUE3rJCubOepAfzOnuO5RsPVVo1NAWVJND7tb8wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275318; c=relaxed/simple;
	bh=N1n1W7kyeF/rHmv258O39cO37qviIuMCgrLTAZnXVbE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pothez5NLZdODNJPTHqCz/q03PXVnTyRa23qw0V9IsisZufbx+EU7pc4x9AJb4VYvzUOZfWGNAUBWWILnhd1nba/mOLWuS4g+AwHbHhfx/rES7PxWnsSdKwFUEVMqsPtZotXUkzFAhSJFHGkXedvAgHj2+qetrR8vAhPiS89VBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YGlORQfX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cafda818aso67014985e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727275315; x=1727880115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6YxIAdzjayyAJ7SPnjQzAFuzcgXCfaGhFkXioDlFtQ=;
        b=YGlORQfXTH42+sWZLhKOrXvRQfP7AmccreECKHo2OC4f3DOcsXzApuEaewo4ZJTkyF
         mjXEsZAq6B6DNTBo9pa5zOunrVBv+WMo0qIY64RHdP3kZ7hMiAo66gw6sKZnf/aR43Bu
         9OhsBAEf9nZhXxSlJrxgt9LAmW9Sq7wjX+yo87UKsNN12fbYdTxd9XzHNYkFOy7sgeLO
         CBHjKAJaF0yQ7Uhfn9ORVJmLTLclRDyhB7Bg992b/mLRayehhjUmOSU1nP6/syetnT2u
         zTBRg5XVW+lq8H5syzkPFjUAqHAjrJ6wLQlY/xyD8Pvve5jpTKGqtJGVWj6DAqblbkTc
         Qv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727275315; x=1727880115;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6YxIAdzjayyAJ7SPnjQzAFuzcgXCfaGhFkXioDlFtQ=;
        b=kg311JPMsEUL43x9njYr+xcOq6FUcHRUimXkOEcvMJ1GLQvZQlJ7UwIzAL3wSlr60t
         lZuuoYiFVvn8TofUEN5GRGhBSpG8UgxZhG0+HiPL9qqIBa2615G3Vwv1L9T7uZzI5BVN
         KDVazosewEC4RTUo2h3iDRsvwA0mGQfphUHiRG0KyhAdNNDRCxYJfi2VOCoJ3uRNZ7Ji
         q08Sy0WjyEJUeTrRFelLj+HBwGsuR0CgjE2QKMXPSjtbexJtBZ39F3pEQKrrptxKkYuJ
         lxHJ9BmBDq9tgUk2kn4PM9rKQRvHNdDLL4/NRno39g3AQEnFUp4j0dvJiBlTm+27aV6O
         4D5w==
X-Forwarded-Encrypted: i=1; AJvYcCW9HXMVkY11/DLdyiEYW05F/0QFSxImlYZ6//n/qHaRJ1XDJBTjy82Ax3fEJI1dyTSRh1CKPhPKkSANOVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwegThhHj+WsYpw6Ayl7xvVgcE+h2jEFbQeDOHRo4D+J8sjMg46
	X6en22DiLYOM6VlmjH6wiRcs2z3pA+VX5PUtUy/Xxdfx5QH8KiCAJyxFeYof20NfpYXfSUL0TVW
	3
X-Google-Smtp-Source: AGHT+IHAfHUuxoeTZOXnlSb00AtCPxIw644azB+Jwg19bMpf06tWeqhuqjRnBMg/w0GGwp9dIbB4gw==
X-Received: by 2002:a05:600c:1e27:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-42e961465c2mr20376755e9.25.1727275314706;
        Wed, 25 Sep 2024 07:41:54 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:857b:1996:7ede:6ce4])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e969fb894sm20822045e9.16.2024.09.25.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 07:41:54 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Chuan Liu <chuan.liu@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240925-mpll_spinlock-v2-1-8f9b73588ec1@amlogic.com>
References: <20240925-mpll_spinlock-v2-1-8f9b73588ec1@amlogic.com>
Subject: Re: [PATCH v2] clk: meson: mpll: Delete a useless spinlock from
 the MPLL
Message-Id: <172727531377.78586.12477940902502018099.b4-ty@baylibre.com>
Date: Wed, 25 Sep 2024 16:41:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Applied to clk-meson (clk-meson-next), thanks!

[1/1] clk: meson: mpll: Delete a useless spinlock from the MPLL
      https://github.com/BayLibre/clk-meson/commit/14b8d1d8b2c6

Best regards,
--
Jerome


