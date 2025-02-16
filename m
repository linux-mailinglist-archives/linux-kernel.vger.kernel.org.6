Return-Path: <linux-kernel+bounces-516718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F061A3762F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 18:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277293AF4B5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC581993BD;
	Sun, 16 Feb 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5Cc86cz"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0B1AAC9;
	Sun, 16 Feb 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739725695; cv=none; b=SrTmE9e8MnabfuPULrMHcVrF9/lwMOzmQBwJty3QUlsxaZDCjXjkc+lLDvXC7cR8c71gyg+XlNnRGHL0CcuvGybnt08ByJhxPUyp/mz3qKyowzh/uVwwNDJdl0xbiDlWVyHz0ei3C92m0xl1Ox4cDzqRSo8MzgJkq6GjpOCZeTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739725695; c=relaxed/simple;
	bh=/N419Jjps23Vm5o3weAzAHFlgOhhlc9/Av3/FoZCn8k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lrzOF3rdngKe56ehMoJGaVYTRvZjOWCAC2cFwutPy/7lup8i7fKlS/JkxsWE6HnF+8hktHw47I8VuN6Qwax1+Xq2yj1MH8gs8cUlWtmSeKbu1eO3WSRjD3lNxX9c5LPayJmsjTl8Rh5oXb9qeFDD+kp6WAtFKsIinMST8DAjqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5Cc86cz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54622829175so79302e87.0;
        Sun, 16 Feb 2025 09:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739725692; x=1740330492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/N419Jjps23Vm5o3weAzAHFlgOhhlc9/Av3/FoZCn8k=;
        b=D5Cc86czePK3ElxOp4gv7LXDMhulXmbgpf38B5IzZS+3XKcSqpolRSlVypEYAQjaIm
         MUj46jxNakescDg0rhWMKTN/XyN7ACXEDZ0Qa+eDSBeg8rxTxtTv4lJcMeRwGk3TGgVc
         AGXIPJOcEUeQioyd6DczjnncIuAAL3MaEq1+xvyVWCXXXtjNLwuf7SVEW8VqRXwWHMtz
         El7tj+idaDS5n/FsEnDEf8YWJkUNjgLd91bKtKAzwBoTWDeAe5D0WBqTChIEUqlseGtI
         /3UtzJTKudT85dwa3X/R4WgBNyOKilTPgwaevEP55jhxLz3cBYhfVBNHcbZClr1mmlqS
         8wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739725692; x=1740330492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/N419Jjps23Vm5o3weAzAHFlgOhhlc9/Av3/FoZCn8k=;
        b=Bb+Axrke36wLJfzus0YgfDAWiOdBQjJVpdIHM8TBulelAPNM7nhU2BsHumvvS8yRKO
         SFildBjYzamQh4jsLug5EwnNcxPD+MYq19eiACqQOS2DgoiBzJDIuyOS0KDc/+3kK8vO
         undGSoB8mEDn3XO5P78+f7bh4Xr+QWEL1Jm7bL0JhAyj0ENK7JEWefBVTNX7Xa5Bmk0N
         eMy1INZKsTbyn7+bKqHwcXOCdJ1e9froLNLhv1OMqGUA7nT4l3oU6E/snbj8RWuoYieS
         M6F+jID8a8UFe0xYOmneUI9BbJwueSWIdsoThfWL4ph7K1pz2zZ0y6IRbTsviluidnOU
         U3gw==
X-Forwarded-Encrypted: i=1; AJvYcCVKIw6xJui6MrjP+oW8RdDSGHm+ogE84vyQGEo80WKk6vY0PUXZYfnY5G+92SWlYIb1L2MXlP7THVzSN44A@vger.kernel.org, AJvYcCXjv7ssJcstKi1mTxgaqP7J8D+txzRVU5CiBY1BC5fGpcpBaYwGAW76m/pHTboYY+MZWqQ/NpTFkE6Ctg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjhPwPyzYyh2x3NymegtbrvQr0lPpWjjSHxSl6ndhl7sD2Ofp/
	Wt4uLfJ+qN5C+SZFcsDdZGrlzssnV8Ru60HelejK6YBH+m5OZQd/
X-Gm-Gg: ASbGncu8D9kEZCq+YQaP4bbiw19h3O46TLgrkHdMLuOeHRA6795zq60ZVRPvHOJ8WX0
	8B0495KHfz4na3OJIcYksPgqKg6hAENdPHeYnY2B3UXBdVkuXRDxWzg0Mx5Go8s6u6tC61mM4oJ
	kjTtnJW+ZfYZt5CXSNpe/MkXp7xQqBXX5yk1OBK8zJ3yNESAOZwRuBrh1X+QAIUAnLGHcu0F29l
	rc/fpByvI73yjTrq4WZondCOOZmuTJxiAqcSB0szP5bwLCOZluDgGRb5gxfOFAgxR7OBmuwXMTu
	2d5XfvfBArI0CzFvtLEOEmv8PCga0UGgmP223G1LiOMW6dyrWJ/PiPwLX6MxXg==
X-Google-Smtp-Source: AGHT+IG79RCqXdLXG/HYFwClaSDt/ZsTMc6dIp2bgXOZ71fA6MF40N8lXz97AC8QaU45ONheAhjtlw==
X-Received: by 2002:a05:6512:ea1:b0:545:ae6:d73d with SMTP id 2adb3069b0e04-5452fe767f3mr2112547e87.45.1739725691902;
        Sun, 16 Feb 2025 09:08:11 -0800 (PST)
Received: from es40.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452a67e6c3sm921808e87.1.2025.02.16.09.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 09:08:11 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: linmag7@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	glaubitz@physik.fu-berlin.de,
	ink@unseen.parts,
	kees@kernel.org,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Subject: [PATCH 0/1] alpha: Fix pte_swp_exclusive on alpha
Date: Sun, 16 Feb 2025 18:04:52 +0100
Message-ID: <20250216170748.2258-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First noticed that swapoff fails to unmount/free a previously used swap
file or partition on alpha. swapoff fails to writeback exclusive swap
pages and gets stuck in an infinite loop trying to do so. This was
introduced in commit a172d5128706028ac07b8db709728379ecc72f6e. This
patch provides a fix for pte_swp_exclusive. Verified on UP2000 alpha.

