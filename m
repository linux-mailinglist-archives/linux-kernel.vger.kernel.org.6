Return-Path: <linux-kernel+bounces-532619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46EAA44FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04A41899613
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3312139B0;
	Tue, 25 Feb 2025 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvPylKIy"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074D214214;
	Tue, 25 Feb 2025 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522315; cv=none; b=dFd7S3iEWeSn5Y400mv4lh3d5lfHp9eQUPdpDxnI3rME35qkQ95hs8iN1qJmGQszOKCjOPcwgz9zZhQ3C00Whf/sfSmSw0etlsvFjkZNXEbmfLxTBuGUFAlB9Q+kI9V8ZJVWKz6A9BPlLtwfrlGwtmuvlG2rpWxskUZfSPAN8hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522315; c=relaxed/simple;
	bh=q3jHyRNNvXIjzZ7nO2jEkzZ+IW1J1YrvJJmz/xEgRXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEF4gClh6+dGORu9sV6F/eTfHjn6Pf+hZ65uBqwZt0gKO6Bjbjf7h5/Gep1VxUG2HkxWHld1iicC7rFODbpXLi0IeN3Hk8dCgNOdD2iN8c5wXPXl7ZCwrO0Qj2fjNffQt941iUZ91bN2yriXhCgECo37NFwFQw6lTa4hR8YxCIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvPylKIy; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6efe4e3d698so56723487b3.0;
        Tue, 25 Feb 2025 14:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740522312; x=1741127112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V9rre3lRagwXq1cwbJ0wl6TfznTQIvQ5/RpQ/IqFtic=;
        b=CvPylKIyJM00TLSN/qtELKtvpMoF2+0XAGVwPpxoeZPPeiyz4SCqzPQaqf1JAu5k5i
         AKxb2yWAcrwURZBL6gPI2o96Gt84WgYgpSYLz1eqkY/eLMiAOJTT+eno/xKEERq2tNCk
         BR04wp+qwGZVZUlBG0rMoUqlMkTbHzidlI7terbaRSgh5VZ/5lzocWbX3Q1WA7bhN3YP
         uHalVbUzrkbYwF1z+2frzuSld5yinR2km0J07sTThH3AL2jJjVTV6z0L8FLQk/WH+nRP
         1bZxw9y2/FTRH7baiLb8APDOjgL0iSyVhWSc+mavlRXQe05+iRFbDhojOkh4IM3kKE0t
         6LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522312; x=1741127112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9rre3lRagwXq1cwbJ0wl6TfznTQIvQ5/RpQ/IqFtic=;
        b=AkUCK/udrhQg8hQXBi1CePJ6+XbF0tpYVNFLyR5qK21P0HHglhlCGNG4P7k1Tkb5AK
         UwnRIqt0u9iv/qUx0XcMiPo5K39nqO9cbhb/wO+8U8NPkn8F0z6eiPqWnx4S7OUK5xkg
         qqzT+mAtT3vLyC22JhJsf5/x1yc3jko1YTfc1+ED91QDzLHaz0LVw924y/NC3+jg7pVa
         JqKov+2xjgWYAzLFPXzE2DXWYqg92s3h0pVrWS+B3VN6J4GuwGWNUBxQ59+caSTOpAOE
         qwKRekOZLLe8lJwRUVt0qhykAYPjzjz/bM9Xa5KBDm+md+8wklnJ7nfZ9JGst9lp3tav
         +Gxg==
X-Forwarded-Encrypted: i=1; AJvYcCVF5TLxJH10WOqsFl72jEhAezlmWm1qnYZmqWVEJEnnY8mjwB7L3H5McRUqlq16jQFX5KyYA7CUOuX9o30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+9RYGOsqcEd+GyTpl2LjPeankhOVmqdSfMDUzjZCvLDZkXuhP
	oCInKXCGAyJfZfYJNE0hnIhKBCTw9tNLFVP6TztnHy87+FmmUO7q
X-Gm-Gg: ASbGncvPj8YlZbYit8wx0V693XS8FOZwz4u6DDMeJpS477kzzd7STG36CNljMCwuhRb
	Nkc5xafIoZ7e4bWJ+RFv1ickm8PC4y1MU3zKtxVgMdEgBDSoke0J1ZesY6vtoK/4p1Kf5rjGP0P
	wnahyWZxRrMRLFe81PtbjmGgciL6NbKK0RvWIjYyqXB0xAIRIc5UvRh5LNQ5Q7TT93hTED83NvI
	BjkYORB38D05FFiJtQMWWSYw2Ku1ngkxNsjwLJKySub+2M8u4jZUoRU6FsSK+kBZ2ClrUVW5f9n
	MclW+k8J2vmUVhexE99lH45Aa/vlCBtbsA==
X-Google-Smtp-Source: AGHT+IFwTO0Xy8q6DgfoxieqTaGhxlwOKD7TmbF8FM8RPEf/XxO/cRNos+AR27PNpojX2XUwN6A4YA==
X-Received: by 2002:a05:690c:6c92:b0:6fb:4c11:61cf with SMTP id 00721157ae682-6fd21e0fd3cmr14468307b3.19.1740522312408;
        Tue, 25 Feb 2025 14:25:12 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e607b3ead63sm595466276.19.2025.02.25.14.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:25:12 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Armin Wolf" <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	Dell.Client.Kernel@dell.com,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v2 00/10] platform/x86: alienware-wmi-wmax: HWMON support + DebugFS + Improvements
Date: Tue, 25 Feb 2025 17:24:50 -0500
Message-ID: <20250225222500.23535-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

It's been a busy week, but I finally finished v2.

The biggest change since v1 is Patch 08/10, which now uses custom HWMON
attributes.

As always thank you for your feedback and reviews :)

PD: I lost my changelog so I apologize if I missed something bellow.

---
Changes since v1:

[03/10]
  - Minor correction in commit message

[04/10]
  - Dropped overflow approach in favor of checking a hardcoded limit for
    device resources

[07/10]
  - Dropped status cache
  - As Armin pointed out, operation 0x01 of GetFanSensors gives us the
    count of temperature sensors related to a given fan. Use this to
    retrieve related sensors for each fan into a bitmap and expose this
    information through pwm*_auto_channels_temp attributes
  - Use related temperature sensors to assign labels to fans
  - Store available fan IDs in a bitmap for convenience

[08/10]
  - Use custom attributes to expose pwm_boost
  - Add pm_ops because if a user sets pwm_boost fans would remain *on*
    after suspending

[10/10]
  - Correct information about GetFanSensors method, based on Armin's
    feedback

v1: https://lore.kernel.org/platform-driver-x86/20250208051614.10644-1-kuurtb@gmail.com/


Kurt Borja (10):
  platform/x86: alienware-wmi-wmax: Rename thermal related symbols
  platform/x86: alienware-wmi-wmax: Refactor is_awcc_thermal_mode()
  platform/x86: alienware-wmi-wmax: Improve internal AWCC API
  platform/x86: alienware-wmi-wmax: Modify supported_thermal_profiles[]
  platform/x86: alienware-wmi-wmax: Improve platform profile probe
  platform/x86: alienware-wmi-wmax: Add support for the "custom" thermal
    profile
  platform/x86: alienware-wmi-wmax: Add HWMON support
  platform/x86: alienware-wmi-wmax: Add support for manual fan control
  platform/x86: alienware-wmi-wmax: Add a DebugFS interface
  platform/x86: alienware-wmi: Improve and update documentation

 Documentation/wmi/devices/alienware-wmi.rst   | 387 +++----
 drivers/platform/x86/dell/Kconfig             |   1 +
 .../platform/x86/dell/alienware-wmi-wmax.c    | 955 +++++++++++++++---
 3 files changed, 948 insertions(+), 395 deletions(-)


base-commit: c86e269c4da6dca2beaf99bdc6fd9f0a9f69035f
-- 
2.48.1


