Return-Path: <linux-kernel+bounces-327754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89607977ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98D6280F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF7D1D58A8;
	Fri, 13 Sep 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqfMpaT3"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E229813D625
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215141; cv=none; b=kEy39I0B3i/c9iOj8Mo4xa7/lUI1Y4r1Z0pi+nd3+8S/2uHLxXurlzXPIqb4HUC7pjmCvaZ1inZixDS89NtG2MOXiamiPRMm/AewQnVVBUFV6QCAPLwGmdmUo3GB4T1qx2bt0o+W4PcKd9ho2sT5i5YEmb+GBKuUyx3DSEA93+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215141; c=relaxed/simple;
	bh=VY7UofsNDHIDTdGaiUQ9zCgoVFnhbvC7Kp0uM2fwgxk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cd6oCSeArDObnA6u6my/POoKfsYHlYe/hSdgsuzn4V/WicpADEqWqKDdB4wu8wTY1qcOjGt0OMoDFAQ6G8d9w2dL5W78lMluMGCNMEimjYlXlGFLmKH8W8zg3kn/Fzjtk1x/DRzMuQ0As+6htm8WrMPYf/POn2Wjz8gBy89eAu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lqfMpaT3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so8269075e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726215138; x=1726819938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91mRVMd2vhtU530/+TgkYOHm6YHa2hzyKxVkYXWa9e0=;
        b=lqfMpaT39XFff7WvAAdRYG/JnYvI9ZkuVzWJI35QxkWjXwplzU770bzNGfMQUFe0Mm
         OlopaGE7xe81leiHyFB8t3Bd1X0/vEffuOHIJpTShB/mvbDsW0yDtoDB3Uoo8wSWvSXR
         fJNF1kGoDNj2bFlWghNY5h0qgVZLMAGXsmy86pY2peyp0qPvnh/+E33ljlM05ptx61TM
         VxdGkoq4i1XR8ZaNGuzVHsa47Fi9XXOp8LEfTCMrApsaRTykUijNytsUb4RMyfsNjWBZ
         t4D9YkvDAmOh/flhq6z2Fz3pAb6EZoZa0nN3oPSaxlbN/3l2l1KVsnAKPZP5lz6mg+3l
         5/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726215138; x=1726819938;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91mRVMd2vhtU530/+TgkYOHm6YHa2hzyKxVkYXWa9e0=;
        b=uk6KgmgYBkZ5a2yLz+lNRgKg4GKmObJHbW+qwwKAD2QRTATREhwqprWXy0SxYuQznn
         w+4JNKOSzTEf6RA/RaNA1aZGM60zsX5tYgA243CgeSJhKVwNr0TZvk8nsn8IkVD2gd0s
         T2VRmg/SYx6EaoaOgfsE80fHNDQNjTGpBIW9I+0t5KPZwhrZP09ZE3JTE3ntkcHxTmiY
         QsEIjW8udErYMLfkZ8DibnoAmiBw5JXYQWV5a6LHPIiBCwkK9Lt6X5mRWVT9tbY2emXZ
         zxGuj3xNszRJx/2PrcGSOz2ddrUraGugNKz3Xkrq/czI7g/0DmKZJGea0/IYXFMMYD6s
         epzg==
X-Forwarded-Encrypted: i=1; AJvYcCXOcu1g5WQ110jyWvWa9iwMnc4g/rpEDBpZPKzisk1OvMrMkm40BNTQcpW5S34Ek7Rdy77AyTQokiAMhvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPb1xF45hZRPqYexDf4qlsUmZPJ778SG07xTv8mdenEh8ynxDM
	FN2R8vPJxLqf4K1h+OrpLM0R6ps9kkXaJgm1d9ZmXqvoIBybq7SP4ftlT5b2cks=
X-Google-Smtp-Source: AGHT+IGwA+aeL8d8gBdinh5auwRgrcbjJuOako4emQukDLrktpdPJvwcvs9zLinFyxiUkKcXseJJNA==
X-Received: by 2002:a05:600c:5107:b0:42c:bd5a:9455 with SMTP id 5b1f17b1804b1-42d9082864emr16365285e9.18.1726215137907;
        Fri, 13 Sep 2024 01:12:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc137556esm106939955e9.1.2024.09.13.01.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 01:12:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120546.1845856-1-alexander.stein@ew.tq-group.com>
References: <20240904120546.1845856-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v3 0/3] Improve tc358767 debugging
Message-Id: <172621513694.966490.6966201660178351575.b4-ty@linaro.org>
Date: Fri, 13 Sep 2024 10:12:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Hi,

On Wed, 04 Sep 2024 14:05:42 +0200, Alexander Stein wrote:
> this small series improves debugging the tc358767 driver by using
> dev_err_probe for additional information (patch 1) and print IRQ
> debug output only if hotplug status actually changed.
> 
> Changes inv 3:
> * Collected Robert's and Dmitry' R-b
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/3] drm/bridge: tc358767: Use dev_err_probe
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/446967304b5671f9b9e5b1b7a620106b4fd6b1f2
[2/3] drm/bridge: tc358767: Only print GPIO debug output if they actually occur
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/31735a97cbd81bc3d858b44a56c8e8dc134a0a3c
[3/3] drm/bridge: tc358767: Support write-only registers
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0d317e820d40963a63eb61732784f23ca0e82d23

-- 
Neil


