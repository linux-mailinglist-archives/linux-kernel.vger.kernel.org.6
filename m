Return-Path: <linux-kernel+bounces-287477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE85952831
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE0A2870F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E30339BC;
	Thu, 15 Aug 2024 03:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6K4+8tV"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CA18651;
	Thu, 15 Aug 2024 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723691687; cv=none; b=ZTDjk1CsgmnFNOBRubw7tCwp/ZLjIEmHN8TvXWOLIvxdY00R0Z0qdMzuNGfC2uaCQkwLE3J6FbiDiRYDyaD5GXQ0dvh8IRqaFTrKzTpf8N1698d3LA8tU+eo1Ku3k54f+fMLR5wl5O2kYEuS0Yhl/GZt7+svNWxUTaxG3D1gKng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723691687; c=relaxed/simple;
	bh=SfaC3xwZ3uk+GXM5WJM2fZn/vPlRJwtz4gLQ5GYXojc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=egFbI8z3QwXAhdu8S4haWOmMxoXMJpzfzKkEGP/PJtA65Ktj8+eyN6M2x6MG6W5rVxxANGdSoMosyaM1Q+h4iaN2HuB8A2fn3y2CDAIne4r7DTqXfqHfk5YWJC/XWkXZTvbvb1JX2l6dGnJkIIgt7WnxkW0jreThxTS+RmJvRrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6K4+8tV; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-81f9339e52cso29492839f.0;
        Wed, 14 Aug 2024 20:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723691685; x=1724296485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HThLz/pddOfJHDr2i60OKvL+WhAaVIEljeQ69GJJ96M=;
        b=R6K4+8tVH6jqNmD4F4sK3VYk2Ax6ljZsGKllNEvmfVUnckPdPgUuRcJ63TfQgWd6xe
         Ly20rfKzPtgqO8puhVGvt1LhLS30WUL50mPYD3ab77vyu2t1lhuBF4HgEi3pUwt3Ej+h
         Crtb0+YA9jm3cp+ILoUzVVV1U3C8vC5Sfurq1zyLDfe4G132L9K4KDmoQzImk/YIWV0z
         uRst9dBBm4xFktpZcuqjstEgm0eMjPb6kPHVYc96WkEdsiqj4D+xoYWMalauHbV6zbP5
         OmiBv+TRlCZobF5xfPEriFaJe/C1LpwBQHiHiHQXhThqcpqnZ5QQ7A1k7C5utmfqv/Qi
         stRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723691685; x=1724296485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HThLz/pddOfJHDr2i60OKvL+WhAaVIEljeQ69GJJ96M=;
        b=aACaQ+exj2jZrUwoWfGrcRflC/N2EPBae7UIWM5B0Jhf3nDxn3G0qDgHUHubxYk7ND
         qmNL1BeqQwITrsUv+r7MXKLJL9zKQHpYjtODhulyN6yyS/hDiJYUrASPeyd3k7ZQuaHM
         rAgjx/dIXf2rHxZVGfIrV6YLDxr0Ysa7JK1X3wmXTTJ33zTwFNRVfarv3Xw61bMqW6tx
         qz3mZZoQglwdiM5eZIvEhN4GA77a/JmXGO5Z41Qvj6yXJmLBRwBugdfpL+yt7y50FYhM
         PvBaYvWWQSisV46qkxmdwyz0qGQVX4mUPg3dOCEMSXLAzDYaSSCQO5XH0LKw+RSINoY8
         FV3A==
X-Forwarded-Encrypted: i=1; AJvYcCUq8O/zGR/SdxkiNvJqBvzJW+RTBnn+XemEU7eh69ipKAuTiRRmsTHBfQq9QlHjUmzTvFQ9CSE5r4sXFWfTWT6sRzndJB1Si1JgArfJGpVvfz7w5OPM1mKOZcIMHJ7mX4N8dTQhQFGdWMHk6AxIr7aTSEWD7NL+dNq1tGjUqSWH4k/qrMI=
X-Gm-Message-State: AOJu0Yz+fSYDYX7gi6x+VQqsAlq8NGSDDqlVhld2Ibc3n4ZzwX512Imh
	/VJ6yc0bWomHfl9GBN6K1vLwWio46Xaf5ooZOSE1c+MsOXY/QnCS
X-Google-Smtp-Source: AGHT+IG4YdjfZVENBSkLFfNDFsOYKVmGdmyzG5HUzVhAV0Hb3tnhraM3FIpt3WUSozFOiVypkaxJHQ==
X-Received: by 2002:a05:6e02:1a8f:b0:39a:16c0:4bef with SMTP id e9e14a558f8ab-39d124cabc8mr66514625ab.23.1723691684887;
        Wed, 14 Aug 2024 20:14:44 -0700 (PDT)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7c6b61a93aesm284684a12.17.2024.08.14.20.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 20:14:44 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] hwmon: (oxp-sensors) Add support for multiple new devices.
Date: Wed, 14 Aug 2024 20:12:40 -0700
Message-ID: <20240815031358.21027-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds new devices from AYANEO, OneXPlayer and OrangePi. There are
also some formatting changes done for improving readability and making the
lists consistent bewtween the multiple functions, when it made sense to do 
so. These changes have been tested by multiple users since April of this
year as part of the ChimeraOS and Manjaro Handheld Edition kernels.

Derek J. Clark (1):
  Add support for multiple new devices.

 Documentation/hwmon/oxp-sensors.rst |  33 ++--
 drivers/hwmon/oxp-sensors.c         | 273 +++++++++++++++++++++++++---
 2 files changed, 267 insertions(+), 39 deletions(-)

-- 
2.46.0


