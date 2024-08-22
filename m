Return-Path: <linux-kernel+bounces-297836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3B895BE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F981F23722
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFFB1D048C;
	Thu, 22 Aug 2024 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CND65yIg"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C661CFEB0;
	Thu, 22 Aug 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351731; cv=none; b=UEXQS1gyvQtODs1pbKbUVz+YsWsk1wmbxHubuepEr2J6RJe0n1kr6HQSx8sOcOX+6PT2Yd5KkJbSyXwFCZUilT671fE6UL9dthY1gBvdvhz/Rw8/aIhkZWLyAFuV2XpSNB7pzmnpXie91G6x5qROyObdbIFv3ShaJNrNuXNW1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351731; c=relaxed/simple;
	bh=JSsmxqbjjoYwvOrh08zQSUBpCLb1WfuKPuEyQzInGEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OX+nHysafNIsVv2OxDyRuLVYhxYba3NfqEW/FL7it0M5gwwQDi0j7VVx7osGCfE2mkJpTPvn8JkG+iuuXhC321g6pyDNfWZ/rVNed0ZFEYQCxLFyy0f4aFOSQeGnZltjDy+kQmt829+Nn+qBSULQ0NYylyS0kGhvohbml5pw8oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CND65yIg; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-27051f63018so801597fac.3;
        Thu, 22 Aug 2024 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351728; x=1724956528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=906ufAfSNe/qY3BHyy+uJ63N5beXiwz8DQQgbAogL34=;
        b=CND65yIg1qsPc7ZzuC8KG3TncTgfKEpkNwQeIZBQTlAgwPTVtJG//kzwNghZo8F862
         JjtathBlp9lycumkgKeuwnwi6CpLUto6gHGK/6t+hCf25xVKqsod3IRd7bVEAVomJIWt
         pIpwxQ8Msr9C83msuKbJVSAlIJN5p+ubC5KM3WG1S1QoAG1o2o1gCfKMWL/6tc+fk3pZ
         hhXgsbrlZVfRHbG4MXMQqfcnrgUrAlZ+rw544diL8dcRyylBneJQ5uoCtwXKNGM/Bbud
         zMmq70fYPhk4ThS9CO2Oext4d/4I4no+zBN4hrj/MAjDQULVWmZeZ4Lj0VJNRTnRUeyT
         ZHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351728; x=1724956528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=906ufAfSNe/qY3BHyy+uJ63N5beXiwz8DQQgbAogL34=;
        b=qII1KQRzI8pIbw/DicpTjiqIbNMGKmFRcQQg2ytZ9K9G0svOB+/v9hh2Fn/9HK9evo
         f4XSWBClMJ9tLaUnJ622tpHtIQH02z/60NShbajxtp7BylLFNLAmzn4u6vz9TGEsZoFV
         3l5K9P1jvlkoeEe9/2IaNhdqCTglxEKJBr7a+ca41O0Nqjfia0W1lfTX+9XNuah4qGjU
         orhobd6I5qd4wKCMuGljDESSKs2IACXmHJqvKKIXfjv2VyJb5P29npqv0T2vGLpiyZud
         DKmCFLP+HMsgLfJmv0iQNrmng2RzHlwyFdp38seHZX3HrpnT95+UrT1qArbADsux8Y1V
         NZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW6OWyAem3v5G6OCYpWrPt2fJLv2ue/6C5rqku0Gn/3NJUl8YM0e6fEYXOsX668GqR96tchKXZZI3bS568@vger.kernel.org, AJvYcCVLAJV/0mJqHzJ4+bKChLVb/cKDZDA3Ghvl1O12yoP/8OSZaJsm9ypC0jow6bprr1sHspgMcCplNNw=@vger.kernel.org, AJvYcCXzf5DvOKTkPJ261HyWmd7PiovRDqQ8qVuHoX5m0ob1ZujvKQAp4yD/aB7HvHypUBSqWyIo6UBA2a0+WEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3KZ4Kte/skqXaonW/6e5AmfmqvkYmrjpf1wV8KeNGpDH7uFau
	J2BHPruq4uLD/yHJLZJKNrOMvr1YyHApOct1syzLMzbr+oekV5me
X-Google-Smtp-Source: AGHT+IHQIuWOV49+E6Gb9IhrP6DxRd1HliN1cIZE/Fm6Mh1QeMiPuVI1Ou6cjM4G+wNdba6NZvazDw==
X-Received: by 2002:a05:6870:e0d2:b0:25e:1382:864d with SMTP id 586e51a60fabf-273cfcaf18emr2627047fac.30.1724351728473;
        Thu, 22 Aug 2024 11:35:28 -0700 (PDT)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdd0e3sm1691598a12.45.2024.08.22.11.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:35:28 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] hwmon: (oxp-sensors) Add support for multiple new devices.
Date: Thu, 22 Aug 2024 11:35:24 -0700
Message-ID: <20240822183525.27289-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds new devices from AYANEO, OneXPlayer and OrangePi. There are
also some formatting changes done for improving readability and making the
lists consistent bewtween the multiple functions, when it made sense to do
so. These changes have been tested by multiple users since April of this
year as part of the ChimeraOS and Manjaro Handheld Edition kernels.

v2:
In addition to fixing the fall-through switch case from the last patch, I
simplified the match cases for all three version of the OneXPlayer 2 as
well as the two AYANEO 2 and GEEK models. Some additional testing came
back identifying the fan speed read register for the 2 series was
different than previous models, so I adjusted that as well. I also added
the OneXPlayer X1 series as they use the same registers as the 2 series
and we were able to finish testing on them.

Derek J. Clark (1):
  Add support for multiple new devices.

 Documentation/hwmon/oxp-sensors.rst |  54 +++--
 drivers/hwmon/oxp-sensors.c         | 299 +++++++++++++++++++++++-----
 2 files changed, 290 insertions(+), 63 deletions(-)

-- 
2.46.0


